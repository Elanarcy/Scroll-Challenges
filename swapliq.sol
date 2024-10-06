// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/IERC20Permit.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 *
 * ==== Security Considerations
 *
 * There are two important considerations concerning the use of `permit`. The first is that a valid permit signature
 * expresses an allowance, and it should not be assumed to convey additional meaning. In particular, it should not be
 * considered as an intention to spend the allowance in any specific way. The second is that because permits have
 * built-in replay protection and can be submitted by anyone, they can be frontrun. A protocol that uses permits should
 * take this into consideration and allow a `permit` call to fail. Combining these two aspects, a pattern that may be
 * generally recommended is:
 *
 * ```solidity
 * function doThingWithPermit(..., uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public {
 *     try token.permit(msg.sender, address(this), value, deadline, v, r, s) {} catch {}
 *     doThing(..., value);
 * }
 *
 * function doThing(..., uint256 value) public {
 *     token.safeTransferFrom(msg.sender, address(this), value);
 *     ...
 * }
 * ```
 *
 * Observe that: 1) `msg.sender` is used as the owner, leaving no ambiguity as to the signer intent, and 2) the use of
 * `try/catch` allows the permit to fail and makes the code tolerant to frontrunning. (See also
 * {SafeERC20-safeTransferFrom}).
 *
 * Additionally, note that smart contract wallets (such as Argent or Safe) are not able to produce permit signatures, so
 * contracts should have entry points that don't rely on permit.
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     *
     * CAUTION: See Security Considerations above.
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

// File: @openzeppelin/contracts/utils/Address.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/Address.sol)

pragma solidity ^0.8.20;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev The ETH balance of the account is not enough to perform the operation.
     */
    error AddressInsufficientBalance(address account);

    /**
     * @dev There's no code at `target` (it is not a contract).
     */
    error AddressEmptyCode(address target);

    /**
     * @dev A call to an address target failed. The target may have reverted.
     */
    error FailedInnerCall();

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://consensys.net/diligence/blog/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.8.20/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        if (address(this).balance < amount) {
            revert AddressInsufficientBalance(address(this));
        }

        (bool success, ) = recipient.call{value: amount}("");
        if (!success) {
            revert FailedInnerCall();
        }
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason or custom error, it is bubbled
     * up by this function (like regular Solidity function calls). However, if
     * the call reverted with no returned reason, this function reverts with a
     * {FailedInnerCall} error.
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        if (address(this).balance < value) {
            revert AddressInsufficientBalance(address(this));
        }
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResultFromTarget(target, success, returndata);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResultFromTarget(target, success, returndata);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResultFromTarget(target, success, returndata);
    }

    /**
     * @dev Tool to verify that a low level call to smart-contract was successful, and reverts if the target
     * was not a contract or bubbling up the revert reason (falling back to {FailedInnerCall}) in case of an
     * unsuccessful call.
     */
    function verifyCallResultFromTarget(
        address target,
        bool success,
        bytes memory returndata
    ) internal view returns (bytes memory) {
        if (!success) {
            _revert(returndata);
        } else {
            // only check if target is a contract if the call was successful and the return data is empty
            // otherwise we already know that it was a contract
            if (returndata.length == 0 && target.code.length == 0) {
                revert AddressEmptyCode(target);
            }
            return returndata;
        }
    }

    /**
     * @dev Tool to verify that a low level call was successful, and reverts if it wasn't, either by bubbling the
     * revert reason or with a default {FailedInnerCall} error.
     */
    function verifyCallResult(bool success, bytes memory returndata) internal pure returns (bytes memory) {
        if (!success) {
            _revert(returndata);
        } else {
            return returndaa;
        }
    }

    /**
     * @dev Reverts with returndata if present. Otherwise reverts with {FailedInnerCall}.
     */
    function _revert(bytes memory returndata) private pure {
        // Look for revert reason and bubble it up if present
        if (returndata.length > 0) {
            // The easiest way to bubble the revert reason is using memory via assembly
            /// @solidity memory-safe-assembly
            assembly {
                let returndata_size := mload(returndata)
                revert(add(32, returndata), returndata_size)
            }
        } else {
            revert FailedInnerCall();
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.20;




/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    /**
     * @dev An operation with an ERC20 token failed.
     */
    error SafeERC20FailedOperation(address token);

    /**
     * @dev Indicates a failed `decreaseAllowance` request.
     */
    error SafeERC20FailedDecreaseAllowance(address spender, uint256 currentAllowance, uint256 requestedDecrease);

    /**
     * @dev Transfer `value` amount of `token` from the calling contract to `to`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeCall(token.transfer, (to, value)));
    }

    /**
     * @dev Transfer `value` amount of `token` from `from` to `to`, spending the approval given by `from` to the
     * calling contract. If `token` returns no value, non-reverting calls are assumed to be successful.
     */
    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeCall(token.transferFrom, (from, to, value)));
    }

    /**
     * @dev Increase the calling contract's allowance toward `spender` by `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 oldAllowance = token.allowance(address(this), spender);
        forceApprove(token, spender, oldAllowance + value);
    }

    /**
     * @dev Decrease the calling contract's allowance toward `spender` by `requestedDecrease`. If `token` returns no
     * value, non-reverting calls are assumed to be successful.
     */
    function safeDecreaseAllowance(IERC20 token, address spender, uint256 requestedDecrease) internal {
        unchecked {
            uint256 currentAllowance = token.allowance(address(this), spender);
            if (currentAllowance < requestedDecrease) {
                revert SafeERC20FailedDecreaseAllowance(spender, currentAllowance, requestedDecrease);
            }
            forceApprove(token, spender, currentAllowance - requestedDecrease);
        }
    }

    /**
     * @dev Set the calling contract's allowance toward `spender` to `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful. Meant to be used with tokens that require the approval
     * to be set to zero before setting it to a non-zero value, such as USDT.
     */
    function forceApprove(IERC20 token, address spender, uint256 value) internal {
        bytes memory approvalCall = abi.encodeCall(token.approve, (spender, value));

        if (!_callOptionalReturnBool(token, approvalCall)) {
            _callOptionalReturn(token, abi.encodeCall(token.approve, (spender, 0)));
            _callOptionalReturn(token, approvalCall);
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data);
        if (returndata.length != 0 && !abi.decode(returndata, (bool))) {
            revert SafeERC20FailedOperation(address(token));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     *
     * This is a variant of {_callOptionalReturn} that silents catches all reverts and returns a bool instead.
     */
    function _callOptionalReturnBool(IERC20 token, bytes memory data) private returns (bool) {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We cannot use {Address-functionCall} here since this should return false
        // and not revert is the subcall reverts.

        (bool success, bytes memory returndata) = address(token).call(data);
        return success && (returndata.length == 0 || abi.decode(returndata, (bool))) && address(token).code.length > 0;
    }
}

// File: @openzeppelin/contracts/utils/math/SafeMath.sol


// OpenZeppelin Contracts (last updated v4.9.0) (utils/math/SafeMath.sol)

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
    * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

// File: @openzeppelin/contracts/utils/math/Math.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/math/Math.sol)

pragma solidity ^0.8.20;

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    /**
     * @dev Muldiv operation overflow.
     */
    error MathOverflowedMulDiv();

    enum Rounding {
        Floor, // Toward negative infinity
        Ceil, // Toward positive infinity
        Trunc, // Toward zero
        Expand // Away from zero
    }

    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    /**
     * @dev Returns the ceiling of the division of two numbers.
     *
     * This differs from standard division with `/` in that it rounds towards infinity instead
     * of rounding towards zero.
     */
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        if (b == 0) {
            // Guarantee the same behavior as in a regular Solidity division.
            return a / b;
        }

        // (a + b - 1) / b can overflow on addition, so we distribute.
        return a == 0 ? 0 : (a - 1) / b + 1;
    }

    /**
     * @notice Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
     * denominator == 0.
     * @dev Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
     * Uniswap Labs also under MIT license.
     */
    function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
        unchecked {
            // 512-bit multiply [prod1 prod0] = x * y. Compute the product mod 2^256 and mod 2^256 - 1, then use
            // use the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
            // variables such that product = prod1 * 2^256 + prod0.
            uint256 prod0 = x * y; // Least significant 256 bits of the product
            uint256 prod1; // Most significant 256 bits of the product
            assembly {
                let mm := mulmod(x, y, not(0))
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }

            // Handle non-overflow cases, 256 by 256 division.
            if (prod1 == 0) {
                // Solidity will revert if denominator == 0, unlike the div opcode on its own.
                // The surrounding unchecked block does not change this fact.
                // See https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic.
                return prod0 / denominator;
            }

            // Make sure the result is less than 2^256. Also prevents denominator == 0.
            if (denominator <= prod1) {
                revert MathOverflowedMulDiv();
            }

            ///////////////////////////////////////////////
            // 512 by 256 division.
            ///////////////////////////////////////////////

            // Make division exact by subtracting the remainder from [prod1 prod0].
            uint256 remainder;
            assembly {
                // Compute remainder using mulmod.
                remainder := mulmod(x, y, denominator)

                // Subtract 256 bit number from 512 bit number.
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }

            // Factor powers of two out of denominator and compute largest power of two divisor of denominator.
            // Always >= 1. See https://cs.stackexchange.com/q/138556/92363.

            uint256 twos = denominator & (0 - denominator);
            assembly {
                // Divide denominator by twos.
                denominator := div(denominator, twos)

                // Divide [prod1 prod0] by twos.
                prod0 := div(prod0, twos)

                // Flip twos such that it is 2^256 / twos. If twos is zero, then it becomes one.
                twos := add(div(sub(0, twos), twos), 1)
            }

            // Shift in bits from prod1 into prod0.
            prod0 |= prod1 * twos;

            // Invert denominator mod 2^256. Now that denominator is an odd number, it has an inverse modulo 2^256 such
            // that denominator * inv = 1 mod 2^256. Compute the inverse by starting with a seed that is correct for
            // four bits. That is, denominator * inv = 1 mod 2^4.
            uint256 inverse = (3 * denominator) ^ 2;

            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also
            // works in modular arithmetic, doubling the correct bits in each step.
            inverse *= 2 - denominator * inverse; // inverse mod 2^8
            inverse *= 2 - denominator * inverse; // inverse mod 2^16
            inverse *= 2 - denominator * inverse; // inverse mod 2^32
            inverse *= 2 - denominator * inverse; // inverse mod 2^64
            inverse *= 2 - denominator * inverse; // inverse mod 2^128
            inverse *= 2 - denominator * inverse; // inverse mod 2^256

            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
            // This will give us the correct result modulo 2^256. Since the preconditions guarantee that the outcome is
            // less than 2^256, this is the final result. We don't need to compute the high bits of the result and prod1
            // is no longer required.
            result = prod0 * inverse;
            return result;
        }
    }

    /**
     * @notice Calculates x * y / denominator with full precision, following the selected rounding direction.
     */
    function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (unsignedRoundsUp(rounding) && mulmod(x, y, denominator) > 0) {
            result += 1;
        }
        return result;
    }

    /**
     * @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded
     * towards zero.
     *
     * Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
     */
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        // For our first guess, we get the biggest power of 2 which is smaller than the square root of the target.
        //
        // We know that the "msb" (most significant bit) of our target number `a` is a power of 2 such that we have
        // `msb(a) <= a < 2*msb(a)`. This value can be written `msb(a)=2**k` with `k=log2(a)`.
        //
        // This can be rewritten `2**log2(a) <= a < 2**(log2(a) + 1)`
        // â `sqrt(2**k) <= sqrt(a) < sqrt(2**(k+1))`
        // â `2**(k/2) <= sqrt(a) < 2**((k+1)/2) <= 2**(k/2 + 1)`
        //
        // Consequently, `2**(log2(a) / 2)` is a good first approximation of `sqrt(a)` with at least 1 correct bit.
        uint256 result = 1 << (log2(a) >> 1);

        // At this point `result` is an estimation with one bit of precision. We know the true value is a uint128,
        // since it is the square root of a uint256. Newton's method converges quadratically (precision doubles at
        // every iteration). We thus need at most 7 iteration to turn our partial result with one bit of precision
        // into the expected uint128 result.
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);
        }
    }

    /**
     * @notice Calculates sqrt(a), following the selected rounding direction.
     */
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = sqrt(a);
            return result + (unsignedRoundsUp(rounding) && result * result < a ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 2 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     */
    function log2(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 128;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 64;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 32;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 16;
            }
            if (value >> 8 > 0) {
                value >>= 8;
                result += 8;
            }
            if (value >> 4 > 0) {
                value >>= 4;
                result += 4;
            }
            if (value >> 2 > 0) {
                value>>= 2;
                result += 2;
            }
            if (value >> 1 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 2, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log2(value);
            return result + (unsignedRoundsUp(rounding) && 1 << result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 10 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     */
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10 ** 64) {
                value /= 10 ** 64;
                result += 64;
            }
            if (value >= 10 ** 32) {
                value /= 10 ** 32;
                result += 32;
            }
            if (value >= 10 ** 16) {
                value /= 10 ** 16;
                result += 16;
            }
            if (value >= 10 ** 8) {
                value /= 10 ** 8;
                result += 8;
            }
            if (value >= 10 ** 4) {
                value /= 10 ** 4;
                result += 4;
            }
            if (value >= 10 ** 2) {
                value /= 10 ** 2;
                result += 2;
            }
            if (value >= 10 ** 1) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log10(value);
            return result + (unsignedRoundsUp(rounding) && 10 ** result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 256 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     *
     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
     */
    function log256(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 16;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 8;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 4;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 2;
            }
            if (value >> 8 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 256, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log256(value);
            return result + (unsignedRoundsUp(rounding) && 1 << (result << 3) < value ? 1 : 0);
        }
    }

    /**
     * @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
     */
    function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
        return uint8(rounding) % 2 == 1;
    }
}

// File: contracts/Interface/ILiquidityToken.sol


pragma solidity ^0.8.0;

interface ILiquidityToken {
    function mint(address to, uint256 amount) external;
    function burn(address from, uint256 amount) external returns (uint256, uint256);
    function safeTransfer(address to, uint256 amount) external; 
    function balanceOf(address account) external view returns (uint256);
    function totalSupply() external view returns (uint256);
}

// File: contracts/Interface/ICoFinance.sol


prgma solidity ^0.8.0;

interface ICoFinance {
    function calculateInterest(uint256 amount) external view returns (uint256);
    function SWAP_FEE_PERCENT() external view returns (uint256);
    function APR_7_DAYS() external view returns (uint256);
    function APR_14_DAYS() external view returns (uint256);
    function APR_21_DAYS() external view returns (uint256);
    function SECONDS_IN_7_DAYS() external view returns (uint256);
    function SECONDS_IN_14_DAYS() external view returns (uint256);
    function SECONDS_IN_21_DAYS() external view returns (uint256);
    function rewardToken() external view returns (address);
}

// File: @openzeppelin/contracts/security/ReentrancyGuard.sol


// OpenZeppelin Contracts (last updated v4.9.0) (security/ReentrancyGuard.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        // On the first call to nonReentrant, _status will be _NOT_ENTERED
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;
    }

    function _nonReentrantAfter() private {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Returns true if the reentrancy guard is currently set to "entered", which indicates there is a
     * `nonReentrant` function in the call stack.
     */
    function _reentrancyGuardEntered() internal view returns (bool) {
        return _status == _ENTERED;
    }
}

// File: contracts/Staking.sol


pragma solidity ^0.8.0;






contract Staking is ReentrancyGuard  {

    uint256 public immutable APR_7_DAYS = 20; // 20% APR for 7 days
    uint256 public immutable APR_14_DAYS = 30; // 30% APR for 14 days
    uint256 public immutable APR_21_DAYS = 50; // 50% APR for 21 days
    uint256 public constant SECONDS_IN_7_DAYS = 7 days;
    uint256 public constant SECONDS_IN_14_DAYS = 14 days;
    uint256 public constant SECONDS_IN_21_DAYS = 21 days;

    ILiquidityToken public liquidityToken;
    ICoFinance public coFinance;

    mapping(address => uint256) public stakerBalances;
    mapping(address => uint256) public stakingStartTimes;
    mapping(address => uint256) public rewardBalances;

    constructor(address _liquidityToken, address _coFinance) {
        liquidityToken = ILiquidityToken(_liquidityToken);
        coFinance = ICoFinance(_coFinance);
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        IERC20(address(liquidityToken)).transferFrom(msg.sender, address(this), amount);
        updateRewards(msg.sender);
        stakerBalances[msg.sender] = stakerBalances[msg.sender] + amount;
        stakingStartTimes[msg.sender] = block.timestamp;
    }

    function withdraw(uint256 amount) external {
        require(stakerBalances[msg.sender] >= amount, "Insufficient balance");
        updateRewards(msg.sender);
        stakerBalances[msg.sender] = stakerBalances[msg.sender] - (amount);
        IERC20(address(liquidityToken)).transfer(msg.sender, amount);
    }

    function claimReward() external {
        updateRewards(msg.sender);
        uint256 reward = rewardBalances[msg.sender];
        require(reward != 0, "No rewards to claim");
        rewardBalances[msg.sender] = 0;
        IERC20 rewardToken = IERC20(coFinance.rewardToken());
        rewardToken.transfer(msg.sender, reward);
    }

    function updateRewards(address staker) internal {
        uint256 stakerBalance = stakerBalances[staker];
        uint256 stakingDuration = block.timestamp - stakingStartTimes[staker];

        uint256 apr = getAPRForDuration(stakingDuration);
        uint256 newReward = stakerBalance * apr / stakingDuration / 100 / 365 days;

        rewardBalances[staker] = rewardBalances[staker] + newReward;
        stakingStartTimes[staker] = block.timestamp;
    }

    function getAPRForDuration(uint256 duration) internal pure returns (uint256) {
        if (duration <= SECONDS_IN_7_DAYS) {
            return APR_7_DAYS;
        } else if (duration <= SECONDS_IN_14_DAYS) {
            return APR_14_DAYS;
        } else if (duration <= SECONDS_IN_21_DAYS) {
            return APR_21_DAYS;
        } else {
            return 0;
        }
    }
}
// File: contracts/Interface/IPricefeed.sol


pragma solidity ^0.8.0;

interface IPriceFeed {
    function getTokenAPrice() external view returns (uint256);
    function getTokenBPrice() external view returns (uint256);
}

// File: contracts/CoFinance.sol


pragma solidity ^0.8.0;









contract CoFinance is ReentrancyGuard {
    using SafeERC20 for IERC20;
    IERC20 public tokenA;
    IERC20 public tokenB;
    ILiquidityToken public liquidityToken;
    Staking public stakingContract;
    IERC20 public rewardToken;
    IPriceFeed public priceFeed;
    address public owner;
    address public factory;
    uint256 public swapFeePercent = 5;
    uint256 public constant INTEREST_RATE_30_DAYS = 2;
    uint256 public constant INTEREST_RATE_90_DAYS = 6;
    uint256 public constant SECONDS_IN_30_DAYS = 30 days;
    uint256 public constant SECONDS_IN_90_DAYS = 90 days;
    uint256 public ownerSharePercent = 7;
    bool public isPoolIncentivized;

    address private immutable _thisAddress;
    address[] public liquidityProviders;
    mapping(address => uint256) public borrowed;
    mapping(address => uint256) public collateralA;
    mapping(address => uint256) public collateralB;
    mapping(address => uint256) public loanStartTime;
    mapping(address => uint256) public loanDuration;
    mapping(address => address) public borrowedToken;
    mapping(address => uint256) public userLiquidityBalance;
    mapping(address => bool) public isLiquidityProvider;
    mapping(address => uint256) public userInterestFees;
    mapping(address => uint256) public userAccumulatedFeesA;
    mapping(address => uint256) public userAccumulatedFeesB;


    uint256 public totalSwapFeesA;
    uint256 public totalSwapFeesB;
    uint256 public totalCollateralA;
    uint256 public totalCollateralB;
    uint256 public totalLiquidity;

    event TokensSwapped(address indexed swapper, uint256 tokenAAmount, uint256 tokenBAmount, uint256 feeAmount);
    event LiquidityProvided(address indexed provider, uint256 tokenAAmount, uint256 tokenBAmount, uint256 liquidityTokensMinted);
    event TokensBorrowed(address indexed borrower, uint256 tokenAAmount, address tokenAddress, uint256 duration);
    event CollateralDeposited(address indexed depositor, address indexed tokenAddress, uint256 amount);
    event CollateralWithdrawn(address indexed withdrawer, uint256 amount);
    event LoanRepaid(address indexed borrower, uint256 amount);
    event CollateralLiquidated(address indexed borrower, uint256 collateralAmount);
    event SwapFeeClaimed(address indexed claimer, uint256 amount);
    event InterestFeeClaimed(address indexed claimer, uint256 amount);
    event LiquidityTokensSent(address recipient, uint256 amount);
    event WithdrawLiquidity(address indexed exiter, uint256 tokenAAmount, uint256 tokenBAmount);

    constructor(
        address _tokenA,
        address _tokenB,
        address _rewardToken,
        address _priceFeed,
        address _liquidityToken,
        address _stakingContract,
        bool _isPoolIncentivized,
        address _factory
    ) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        rewardToken = IERC20(_rewardToken);
        priceFeed = IPriceFeed(_priceFeed);
        liquidityToken = ILiquidityToken(_liquidityToken);
        stakingContract = Staking(_stakingContract);
        owner = msg.sender;
        isPoolIncentivized = _isPoolIncentivized;
        factory = _factory;
        _thisAddress = address(this);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier hasCollateral() {
        require(collateralA[msg.sender] != 0 || collateralB[msg.sender] != 0, "No collateral available");
        _;

    }

    function swapTokens(address tokenAddress, uint256 tokenAmount) external {
        require(tokenAmount != 0, "Token amount must be greater than 0");
        uint256 totalFee = tokenAmount * swapFeePercent / 1000;
        uint256 factoryFee = totalFee * 10 / 100; 
        uint256 poolReward = totalFee - factoryFee;
        uint256 amountAfterFee = tokenAmount - totalFee;
        uint256 priceTokenA = priceFeed.getTokenAPrice();
        uint256 priceTokenB = priceFeed.getTokenBPrice();
        if (priceTokenA == 0 || priceTokenB == 0) {
            swapTokensConstantProduct(tokenAddress, tokenAmount);
        } else {
            if (tokenAddress == address(tokenA)) {
                uint256 tokenBAmount = amountAfterFee * priceTokenA / priceTokenB;
                tokenA.safeTransferFrom(msg.sender, _thisAddress, tokenAmount);
                tokenA.safeTransfer(factory, factoryFee);
                distributeFees(poolReward, true);
                tokenB.safeTransfer(msg.sender, tokenBAmount);
                emit TokensSwapped(msg.sender, tokenAmount, tokenBAmount, factoryFee);
            } else if (tokenAddress == address(tokenB)) {
                uint256 tokenAAmount = amountAfterFee * priceTokenB / priceTokenA;
                tokenB.safeTransferFrom(msg.sender, _thisAddress, tokenAmount);
                tokenB.safeTransfer(factory, factoryFee);
                distributeFees(poolReward, false);
                tokenA.safeTransfer(msg.sender, tokenAAmount);
                emit TokensSwapped(msg.sender, tokenAmount, tokenAAmount, factoryFee);
            } else {
                revert("Invalid token address");
            }
        }
    }

    function getReserves() internal  view returns (uint256 reserveA, uint256 reserveB) {
        reserveA = tokenA.balanceOf(_thisAddress) - totalSwapFeesA - totalCollateralA;
        reserveB = tokenB.balanceOf(_thisAddress) - totalSwapFeesB - totalCollateralB;
  }

    function swapTokensConstantProduct(address tokenAddress, uint256 tokenAmount) internal {
        require(tokenAmount != 0, "Token amount must be greater than 0");
        (uint256 reserveA, uint256 reserveB) = getReserves();
        uint256 amountAfterFee = tokenAmount * (1000 - swapFeePercent) / 1000;
        uint256 factoryFee = tokenAmount * swapFeePercent / 1000 * 10 / 100; 
        uint256 poolReward = tokenAmount * swapFeePercent / 1000 - factoryFee;
        if (tokenAddress == address(tokenA)) {
            uint256 newReserveA = reserveA + amountAfterFee;
            uint256 newReserveB = (reserveA * reserveB) / newReserveA;
            uint256 tokenBAmount = reserveB - newReserveB;
            tokenA.safeTransferFrom(msg.sender, _thisAddress, tokenAmount);
            tokenA.safeTransfer(factory, factoryFee);
            distributeFees(poolReward, true);
            tokenB.safeTransfer(msg.sender, tokenBAmount);
            emit TokensSwapped(msg.sender, tokenAmount, tokenBAmount, factoryFee);
        } else if (tokenAddress == address(tokenB)) {
            uint256 newReserveB = reserveB + amountAfterFee;
            uint256 newReserveA = (reserveA * reserveB) / newReserveB;
            uint256 tokenAAmount = reserveA - newReserveA;
            tokenB.safeTransferFrom(msg.sender, _thisAddress, tokenAmount);
            tokenB.safeTransfer(factory, factoryFee);
            distributeFees(poolReward, false);
            tokenA.safeTransfer(msg.sender, tokenAAmount);
            emit TokensSwapped(msg.sender, tokenAmount, tokenAAmount, factoryFee);
        } else {
            revert("Invalid token address");
        }
    }

    function previewSwap(address tokenAddress, uint256 tokenAmount) external view returns (uint256 outputAmount, uint256 feeAmount) {
        require(tokenAmount != 0, "Token amount must be greater than 0");
        feeAmount = tokenAmount * swapFeePercent / 1000;
        uint256 amountAfterFee = tokenAmount - feeAmount;
        uint256 priceTokenA = priceFeed.getTokenAPrice();
        uint256 priceTokenB = priceFeed.getTokenBPrice();
        if (priceTokenA == 0 || priceTokenB == 0) {
            (uint256 reserveA, uint256 reserveB) = getReserves();
            if (tokenAddress == address(tokenA)) {
                uint256 newReserveA = reserveA + amountAfterFee;
                uint256 newReserveB = (reserveA * reserveB) / newReserveA;
                outputAmount = reserveB - newReserveB;
            } else if (tokenAddress == address(tokenB)) {
                uint256 newReserveB = reserveB + amountAfterFee;
                uint256 newReserveA = (reserveA * reserveB) / newReserveB;
                outputAmount = reserveA - newReserveA;
            } else {
                revert("Invalid token address");
            }
        } else {
            // Use price feed for dynamic swap calculation
            if (tokenAddress == address(tokenA)) {
                uint256 tokenBAmount = amountAfterFee * priceTokenA / priceTokenB;
                outputAmount = tokenBAmount;
            } else if (tokenAddress == address(tokenB)) {
                uint256 tokenAAmount = amountAfterFee * priceTokenB / priceTokenA;
                outputAmount = tokenAAmount;
            } else {
                revert("Invalid token address");
            }
            }
    }

    function depositCollateral(address tokenAddress, uint256 amount) external {
        require((tokenAddress == address(tokenA) || tokenAddress == address(tokenB)) && amount != 0, "Invalid input");

        IERC20(tokenAddress).safeTransferFrom(msg.sender, _thisAddress, amount);

        if (tokenAddress == address(tokenA)) {
            collateralA[msg.sender] += amount;
            totalCollateralA += amount;
        } else {
            collateralB[msg.sender] += amount;
            totalCollateralB += amount;
        }

        emit CollateralDeposited(msg.sender, tokenAddress, amount);
    }

    function withdrawCollateral(uint256 amount) external hasCollateral {
        require(amount != 0, "Amount must be greater than 0");
        uint256 collateralAmount;
        if (collateralA[msg.sender] >= amount) {
            collateralAmount = amount;
            collateralA[msg.sender] -= amount;
            totalCollateralA -= amount;
            tokenA.safeTransfer(msg.sender, amount);
        } else if (collateralB[msg.sender] >= amount) {
            collateralAmount = amount;
            collateralB[msg.sender] -= amount;
            totalCollateralB -= amount;
            tokenB.safeTransfer(msg.sender, amount);
        } else {
            revert("Insufficient collateral");
        }
        emit CollateralWithdrawn(msg.sender, collateralAmount);
    }

    function borrowTokens(uint256 amount, address tokenAddress, uint256 duration) external hasCollateral nonReentrant {
        require(amount > 0, "Invalid amount");
        require(duration == 30 days || duration == 90 days, "Invalid duration");
        uint256 priceTokenA = priceFeed.getTokenAPrice();
        uint256 priceTokenB = priceFeed.getTokenBPrice();
        uint256 collateralAmount;
        
        if (tokenAddress == address(tokenA)) {
            collateralAmount = collateralB[msg.sender] * priceTokenB; 
        } else if (tokenAddress == address(tokenB)) {
            collateralAmount = collateralA[msg.sender] * priceTokenA;
        } else {
            revert("Invalid token address");
        }
        
        uint256 maxBorrowableUSD = collateralAmount * 80 / 100; 
        if (tokenAddress == address(tokenA)) {
            uint256 requiredCollateralUSD = amount * priceTokenA;
            require(collateralAmount >= requiredCollateralUSD * 80 / 100, "Insufficient collateral");
            borrowed[msg.sender] = amount;
            loanStartTime[msg.sender] = block.timestamp;
            loanDuration[msg.sender] = duration;
            borrowedToken[msg.sender] = address(tokenA);
            collateralB[msg.sender] -= amount;
            tokenA.safeTransfer(msg.sender, amount);
        } else if (tokenAddress == address(tokenB)) {
            uint256 maxBorrowableAmount = maxBorrowableUSD / priceTokenB;
            require(amount <= maxBorrowableAmount, "Amount exceeds borrow limit");
            uint256 requiredCollateralUSD = amount * priceTokenB;
            require(collateralAmount >= requiredCollateralUSD * 80 / 100, "Insufficient collateral");
            tokenA.safeTransfer(msg.sender, amount);
            borrowed[msg.sender] = amount;
            loanStartTime[msg.sender] = block.timestamp;
            loanDuration[msg.sender] = duration;
            borrowedToken[msg.sender] = address(tokenB);
            collateralA[msg.sender] -= amount;
            tokenB.safeTransfer(msg.sender, amount);
        }
    }


    function repayLoan(uint256 amount) external {
        require(amount != 0, "Repay amount must be greater than zero");
        require(borrowed[msg.sender] > 0, "No outstanding loan");
        uint256 interest = calculateInterestFee(borrowed[msg.sender], loanDuration[msg.sender]);
        uint256 totalRepayAmount = borrowed[msg.sender] + interest;
        require(amount >= totalRepayAmount, "Insufficient amount to repay loan");
        uint256 totalFee = interest;
        uint256 factoryFee = totalFee * 10 / 100; 
        uint256 poolReward = totalFee - factoryFee;
        address tokenToRepay = borrowedToken[msg.sender];
        if (tokenToRepay == address(tokenA)) {
            tokenA.safeTransferFrom(msg.sender, _thisAddress, totalRepayAmount);
            distributeFees(poolReward, true);
            uint256 coll = totalRepayAmount - interest;
            collateralA[msg.sender] += coll;
            totalSwapFeesA += poolReward;
        } else if (tokenToRepay == address(tokenB)) {
            tokenB.safeTransferFrom(msg.sender, _thisAddress, totalRepayAmount);
            distributeFees(poolReward, false);
            uint256 coll = totalRepayAmount - interest;
            collateralB[msg.sender] += coll;
            totalSwapFeesB += poolReward;
        }
        delete borrowed[msg.sender];
        delete borrowedToken[msg.sender];
        delete loanStartTime[msg.sender];
        delete loanDuration[msg.sender];
        emit LoanRepaid(msg.sender, amount);
    }

     function calculateInterestFee(uint256 borrowedAmount, uint256 duration) internal pure returns (uint256) {
        uint256 interestRate = (duration == SECONDS_IN_30_DAYS) ? INTEREST_RATE_30_DAYS : INTEREST_RATE_90_DAYS;
        return borrowedAmount * interestRate / 100;
    }

    function distributeFees(uint256 feeAmount, bool isTokenA) internal {
        if (isTokenA) {
            totalSwapFeesA += feeAmount;
        } else {
            totalSwapFeesB += feeAmount;
        }
           for (uint256 i = 0; i < liquidityProviders.length; i++) {
            address provider = liquidityProviders[i];
            uint256 providerLiquidity = userLiquidityBalance[provider];
            if (providerLiquidity > 0) {
                uint256 feeShare = feeAmount * providerLiquidity / totalLiquidity;
                if (isTokenA) {
                    userAccumulatedFeesA[provider] += feeShare;
                } else {
                    userAccumulatedFeesB[provider] += feeShare;
                }
            }
        }
    }

    function claimFees() external nonReentrant {
        uint256 accumulatedFeesA = userAccumulatedFeesA[msg.sender];
        uint256 accumulatedFeesB = userAccumulatedFeesB[msg.sender];
        require(accumulatedFeesA > 0 || accumulatedFeesB > 0, "No fees to claim");
        if (accumulatedFeesA > 0) {
            tokenA.safeTransfer(msg.sender, accumulatedFeesA);
            userAccumulatedFeesA[msg.sender] = 0;
            totalSwapFeesA -= accumulatedFeesA;
        }
        if (accumulatedFeesB > 0) {
            tokenB.safeTransfer(msg.sender, accumulatedFeesB);
            userAccumulatedFeesB[msg.sender] = 0;
            totalSwapFeesB -= accumulatedFeesB;
        }
        emit SwapFeeClaimed(msg.sender, accumulatedFeesA + accumulatedFeesB);
    }

    function updateSwapFee(uint256 newFee) external onlyOwner {
        require(newFee <= 1000, "Fee too high");
        swapFeePercent = newFee;
    }

    function updateOwnerShare(uint256 newShare) external onlyOwner {
        require(newShare <= 100, "Share too high");
        ownerSharePercent = newShare;
    }

    function provideLiquidity(uint256 tokenAAmount, uint256 tokenBAmount) external {
        require(tokenAAmount != 0 && tokenBAmount != 0, "Token amounts must be greater than 0");
        uint256 netReserveA = IERC20(tokenA).balanceOf(_thisAddress) - totalSwapFeesA - totalCollateralA;
        uint256 netReserveB = IERC20(tokenB).balanceOf(_thisAddress) - totalSwapFeesB - totalCollateralB;
        uint256 liquidityMinted;
        uint256 liquidityTotalSupply = liquidityToken.totalSupply();
        tokenA.safeTransferFrom(msg.sender, _thisAddress, tokenAAmount);
        tokenB.safeTransferFrom(msg.sender, _thisAddress, tokenBAmount);
        if (liquidityTotalSupply == 0) {
            liquidityMinted = calculateInitialLiquidity(tokenAAmount, tokenBAmount);
        } else {
            liquidityMinted = calculateSubsequentLiquidity(tokenAAmount, tokenBAmount, netReserveA, netReserveB, liquidityTotalSupply);
        }
        liquidityToken.mint(_thisAddress, liquidityMinted);
        liquidityToken.safeTransfer(msg.sender, liquidityMinted);
        userLiquidityBalance[msg.sender] += liquidityMinted;
        totalLiquidity += liquidityMinted;
        addLiquidityProvider(msg.sender);
        emit LiquidityProvided(msg.sender, tokenAAmount, tokenBAmount, liquidityMinted);
    }

    function calculateInitialLiquidity(uint256 tokenAAmount, uint256 tokenBAmount) internal pure returns (uint256) {
        return Math.sqrt(tokenAAmount * tokenBAmount);
    }

    function calculateSubsequentLiquidity(
        uint256 tokenAAmount,
        uint256 tokenBAmount,
        uint256 netReserveA,
        uint256 netReserveB,
        uint256 liquidityTotalSupply
        ) internal pure returns (uint256) {
        uint256 liquidityA = (tokenAAmount * liquidityTotalSupply) / netReserveA;
        uint256 liquidityB = (tokenBAmount * luidityTotalSupply) / netReserveB;
        return Math.min(liquidityA, liquidityB);
    }

    function withdrawLiquidity(uint256 liquidityTokenAmount) external {
        require(liquidityTokenAmount != 0, "Liquidity token amount must be greater than 0");

        uint256 liquidityTotalSupply = liquidityToken.totalSupply();
        require(liquidityTotalSupply != 0, "No liquidity tokens in circulation");

        uint256 reserveA = tokenA.balanceOf(_thisAddress);
        uint256 reserveB = tokenB.balanceOf(_thisAddress);
        uint256 netReserveA = reserveA - totalSwapFeesA - totalCollateralA;
        uint256 netReserveB = reserveB - totalSwapFeesB - totalCollateralB;
        uint256 tokenAAmount = liquidityTokenAmount * netReserveA / liquidityTotalSupply;
        uint256 tokenBAmount = liquidityTokenAmount * netReserveB / liquidityTotalSupply;
        liquidityToken.burn(msg.sender, liquidityTokenAmount);
        tokenA.safeTransfer(msg.sender, tokenAAmount);
        tokenB.safeTransfer(msg.sender, tokenBAmount);
        userLiquidityBalance[msg.sender] -= liquidityTokenAmount;
        totalLiquidity -= liquidityTokenAmount;
         if (userLiquidityBalance[msg.sender] == 0) {
        removeLiquidityProvider(msg.sender);
        }
        emit WithdrawLiquidity(msg.sender, tokenAAmount, tokenBAmount);

    }

    function getCollateralAmounts() external view returns (uint256, uint256) {
        return (collateralA[msg.sender], collateralB[msg.sender]);
    }

    function getBorrowedAmount() external view returns (uint256) {
        return borrowed[msg.sender];
    }

    function liquidateLoan(address borrower) external {
        require(borrower != msg.sender, "Cannot liquidate your own loan");
        require(borrowed[borrower] > 0, "No outstanding loan to liquidate");
        require(block.timestamp > loanStartTime[borrower] + loanDuration[borrower], "Loan is not overdue");
        uint256 liquidationAmount = borrowed[msg.sender];
        if (borrowedToken[borrower] == address(tokenA)) {
            totalCollateralA -= liquidationAmount;
        } else {
            totalCollateralB -= liquidationAmount;
        }
        borrowed[borrower] = 0;
        loanStartTime[borrower] = 0;
        loanDuration[borrower] = 0;
        emit CollateralLiquidated(borrower, liquidationAmount);
    }

    function addLiquidityProvider(address provider) internal {
        if (!isLiquidityProvider[provider]) {
            isLiquidityProvider[provider] = true;
            liquidityProviders.push(provider);
        }
    }

    function removeLiquidityProvider(address provider) internal {
        if (isLiquidityProvider[provider]) {
            isLiquidityProvider[provider] = false;
            uint256 index = findProviderIndex(provider);
            if (index < liquidityProviders.length - 1) {
                liquidityProviders[index] = liquidityProviders[liquidityProviders.length - 1];
            }
            liquidityProviders.pop();
        }
    }
    
    function findProviderIndex(address provider) internal view returns (uint256) {
        for (uint256 i = 0; i < liquidityProviders.length; i++) {
            if (liquidityProviders[i] == provider) {
                return i;
            }
        }
        revert("Provider not found");
    }
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.20;


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.20;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: @openzeppelin/contracts/interfaces/draft-IERC6093.sol


// OpenZeppelin Contracts (last updated v5.0.0) (interfaces/draft-IERC6093.sol)
pragma solidity ^0.8.20;

/**
 * @dev Standard ERC20 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC20 tokens.
 */
interface IERC20Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC20InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC20InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `spender`âs `allowance`. Used in transfers.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     * @param allowance Amount of tokens a `spender` is allowed to operate with.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC20InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `spender` to be approved. Used in approvals.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC20InvalidSpender(address spender);
}

/**
 * @dev Standard ERC721 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC721 tokens.
 */
interface IERC721Errors {
    /**
     * @dev Indicates that an address can't be an owner. For example, `address(0)` is a forbidden owner in EIP-20.
     * Used in balance queries.
     * @param owner Address of the current owner of a token.
     */
    error ERC721InvalidOwner(address owner);

    /**
     * @dev Indicates a `tokenId` whose `owner` is the zero address.
     * @param tokenId Identifier number of a token.
     */
    error ERC721NonexistentToken(uint256 tokenId;

    /**
     * @dev Indicates an error related to the ownership over a particular token. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param tokenId Identifier number of a token.
     * @param owner Address of the current owner of a token.
     */
    error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC721InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC721InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`âs approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param tokenId Identifier number of a token.
     */
    error ERC721InsufficientApproval(address operator, uint256 tokenId);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC721InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC721InvalidOperator(address operator);
}

/**
 * @dev Standard ERC1155 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC1155 tokens.
 */
interface IERC1155Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     * @param tokenId Identifier number of a token.
     */
    error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC1155InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC1155InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`âs approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param owner Address of the current owner of a token.
     */
    error ERC1155MissingApprovalForAll(address operator, address owner);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC1155InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC1155InvalidOperator(address operator);

    /**
     * @dev Indicates an array length mismatch between ids and values in a safeBatchTransferFrom operation.
     * Used in batch transfers.
     * @param idsLength Length of the array of token identifiers
     * @param valuesLength Length of the array of token amounts
     */
    error ERC1155InvalidArrayLength(uint256 idsLength, uint256 valuesLength);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.20;





/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 */
abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
    mapping(address account => uint256) private _balances;

    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `value`.
     */
    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `value`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `value`.
     */
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }

    /**
     * @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
     * (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
     * this function.
     *
     * Emits a {Transfer} event.
     */
    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            // Overflow check required: The rest of the code assumes that totalSupply never overflows
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) {
                revert ERC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                // Overflow not possible: value <= fromBalance <= totalSupply.
                _balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            unchecked {
                // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
                _totalSupply -= value;
            }
        } else {
            unchecked {
                // Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
                _balances[to] += value;
            }
        }

        emit Transfer(from, to, value);
    }

    /**
     * @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
     * Relies on the `_update` mechanism
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

    /**
     * @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
     * Relies on the `_update` mechanism.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead
     */
    function _burn(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }

    /**
     * @dev Sets `value` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `appve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     *
     * Overrides to this logic should be done to the variant with an additional `bool emitEvent` argument.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }

    /**
     * @dev Variant of {_approve} with an optional flag to enable or disable the {Approval} event.
     *
     * By default (when calling {_approve}) the flag is set to true. On the other hand, approval changes made by
     * `_spendAllowance` during the `transferFrom` operation set the flag to false. This saves gas by not emitting any
     * `Approval` event during `transferFrom` operations.
     *
     * Anyone who wishes to continue emitting `Approval` events on the`transferFrom` operation can force the flag to
     * true using the following override:
     * ```
     * function _approve(address owner, address spender, uint256 value, bool) internal virtual override {
     *     super._approve(owner, spender, value, true);
     * }
     * ```
     *
     * Requirements are the same as {_approve}.
     */
    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `value`.
     *
     * Does not update the allowance value in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Does not emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < value) {
                revert ERC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}

// File: contracts/LiquidityToken.sol


pragma solidity ^0.8.0;

// Import the OpenZeppelin ERC20 contract




// The LiquidityToken contract inherits from ERC20 and uses SafeERC20 for safe operations
contract LiquidityToken is ERC20 {
    using SafeERC20 for IERC20;

    address public owner;
    address public cofinanceContract;
    bool public poolIncentivized;

    modifier onlyCoFinance() {
        require(msg.sender == cofinanceContract, "LiquidityToken: Only CoFinance contract can call this function");
        _;
    }

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
    }

    function mint(address account, uint256 amount) external onlyCoFinance {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external {
        _burn(account, amount);
    }

    function safeTransfer(address to, uint256 amount) external {
        _safeTransfer(msg.sender, to, amount);
    }

    function setCoFinanceContract(address _cofinanceContract) external {
        require(msg.sender == owner, "LiquidityToken: Only owner can set CoFinance contract");
        cofinanceContract = _cofinanceContract;
    }

    function _safeTransfer(address from, address to, uint256 amount) internal {
        require(to != address(0), "ERC20: transfer to the zero address");
        require(balanceOf(from) >= amount, "ERC20: transfer amount exceeds balance");
        _transfer(from, to, amount);
    }
}
// File: contracts/CoFinanceFactory.sol


pragma solidity ^0.8.17;  





contract CoFinanceFactory {
    uint256 public creationFee = 10;
    address public owner;
    address public immutable thisAddress; 
    address[] public allPools;
    mapping(address => mapping(address => address)) public pools; 
    mapping(address => address[]) private  poolsByToken;
    mapping(address => bool) public incentivizedPools;
    address[] public incentivizedPoolsList; 
    event PoolCreated(
        address indexed poolAddress,
        address indexed tokenA,
        address indexed tokenB,
        address liquidityTokenAddress,
        address rewardToken,
        address priceFeed,
        address stakingContract,
        bool isPoolIncentivized
    );
    event CreationFeeUpdated(uint256 newFee);
    event FeesWithdrawn(address indexed owner, address token, uint256 amount);
    event PoolIncentivized(address indexed poolAddress);

    constructor() {
        owner = msg.sender;
        thisAddress = address(this);  
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function createPool(
        address tokenA,
        address tokenB,
        address rewardToken,
        address priceFeed,
        string memory liquidityTokenName,
        string memory liquidityTokenSymbol,
        bool isPoolIncentivized
    ) external payable returns (address) {
        require(msg.value == creationFee, "Incorrect amount sent");
        require(tokenA != tokenB, "Token addresses must be different");

        if (tokenA > tokenB) {
            (tokenA, tokenB) = (tokenB, tokenA);
        }

        address existingPool = pools[tokenA][tokenB];
        if (existingPool != address(0)) {
            return existingPool; 
        }
        LiquidityToken liquidityToken = new LiquidityToken(liquidityTokenName, liquidityTokenSymbol);
        Staking stakingContract = new Staking(address(liquidityToken), rewardToken);
        CoFinance pool = new CoFinance(
            tokenA,
            tokenB,
            rewardToken,
            priceFeed,
            address(liquidityToken),
            address(stakingContract),
            isPoolIncentivized,
            thisAddress
        );
        liquidityToken.setCoFinanceContract(address(pool));
        pools[tokenA][tokenB] =address(pool);
        poolsByToken[tokenA].push(address(pool));
        poolsByToken[tokenB].push(address(pool));
        allPools.push(address(pool));
        if (isPoolIncentivized) {
            incentivizedPools[address(pool)] = true;
            incentivizedPoolsList.push(address(pool));
        }
        emit PoolCreated(
            address(pool),
            tokenA,
            tokenB,
            address(liquidityToken),
            rewardToken,
            priceFeed,
            address(stakingContract),
            isPoolIncentivized
        );
        return address(pool);
    }

    function getAllPools() external view returns (address[] memory) {
        return allPools;
    }

    function updateCreationFee(uint256 newFee) external onlyOwner {
        creationFee = newFee;
        emit CreationFeeUpdated(newFee);
    }

    function getPoolByToken(address token) external view returns (address[] memory) {
        return poolsByToken[token];
    }

    function getPoolByPair(address tokenA, address tokenB) external view returns (address) {
        if (tokenA != tokenB) {
            (tokenA, tokenB) = (tokenB, tokenA);
        }
        return pools[tokenA][tokenB];
    }

    function getIncentivizedPools() external view returns (address[] memory) {
        return incentivizedPoolsList;
    }

    function withdrawFees(address tokenAddress) external onlyOwner {
        if (tokenAddress == address(0)) {
            uint256 balance = thisAddress.balance; 
            require(balance > 0, "No ETH to withdraw");
            (bool success, ) = owner.call{value: balance}("");
            require(success, "Transfer failed");
            emit FeesWithdrawn(owner, address(0), balance);
        } else {
            IERC20 token = IERC20(tokenAddress);
            uint256 balance = token.balanceOf(thisAddress); 
            require(balance > 0, "No ERC20 tokens to withdraw");
            bool success = token.transfer(owner, balance);
            require(success, "Transfer failed");
            emit FeesWithdrawn(owner, tokenAddress, balance);
        }
    }

}
