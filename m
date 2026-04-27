Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E681FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E2010E6D0;
	Mon, 27 Apr 2026 11:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kGUz3Bq8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4296C10E6D0;
 Mon, 27 Apr 2026 11:28:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C939F43C85;
 Mon, 27 Apr 2026 11:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC46C2BCB6;
 Mon, 27 Apr 2026 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777289315;
 bh=StTYVLk4jF8kiFZCp6Zg56JlMDEype0lHVzFjl1p9pw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kGUz3Bq8lZnqL01QFqUD2Zaz97+RiBq1CBWRahxr54wRpgnDX2Yhlp7H3XrQDp5gz
 RYTNZFBmg4fDKJpacKeoIdXZBvOhJSyDkA3eRGhmqSaxl0P+Q0+eCrrxn3s10FFgDb
 tCARcnqJrWfST5JkA3zL651tsc8lPHj7JY/+Om0ev4uuZMZwL5o8hOEgzB4sSH41zI
 hw4npR4tsNsc22M78O5Mds4rS7rJnBm2dZMJFUZvicwEpPKyGpshWbi0yIiVg4qQ6l
 55+T5LkIxe5S88bO0XCTrFu5Bf7pvUSSNTQ62P5EAElAh4pZaXTTU1LQbTefFFjjQ+
 dcV2HjhnU1GkQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, Abdiel
 Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Alexandre
 Courbot <acourbot@nvidia.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH 1/5] rust: ptr: add panicking index projection variant
In-Reply-To: <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <FW-izTUZJ5UeE_3CsMTwNT-XlxQHmovjhfdXQpTE9Eb5aInlYy8Tj1H94gLDiBEOXlVVwadom47wXriTOW0iQQ==@protonmail.internalid>
 <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
Date: Mon, 27 Apr 2026 13:24:13 +0200
Message-ID: <87qzo0r6hu.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

"Gary Guo" <gary@garyguo.net> writes:

> There have been a few cases where the programmer knows that the indices are
> in bounds but compiler cannot deduce that. This is also
> compiler-version-dependent, so using build indexing here can be
> problematic. On the other hand, it is also not ideal to use the fallible
> variant, as it adds error handling path that is never hit.
>
> Add a new panicking index projection for this scenario. Like all panicking
> operations, this should be used carefully only in cases where the user
> knows the index is going to be in bounds, and panicking would indicate
> something is catastrophically wrong.
>
> To signify this, require users to explicitly denote the type of index being
> used. The existing two types of index projections also gain the keyworded
> version, which will be the recommended way going forward.
>
> The keyworded syntax also paves the way of perhaps adding more flavors in
> the future, e.g. `unsafe` index projection. However, unless the code is
> extremely performance sensitive and bounds checking cannot be tolerated,
> panicking variant is safer and should be preferred, so it will be left to
> future when demand arises.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/dma.rs            |  3 ++
>  rust/kernel/ptr/projection.rs | 98 +++++++++++++++++++++++++++++++++++--------
>  2 files changed, 84 insertions(+), 17 deletions(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 4995ee5dc689..3e4d44749aaf 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -1207,6 +1207,9 @@ macro_rules! dma_write {
>      (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
>          $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*])
>      };
> +    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
> +        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [$($rest)*])
> +    };
>      (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*]) => {
>          $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($rest)*])
>      };
> diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection.rs
> index 140ea8e21617..845811795393 100644
> --- a/rust/kernel/ptr/projection.rs
> +++ b/rust/kernel/ptr/projection.rs
> @@ -26,14 +26,14 @@ fn from(_: OutOfBound) -> Self {
>  ///
>  /// # Safety
>  ///
> -/// The implementation of `index` and `get` (if [`Some`] is returned) must ensure that, if provided
> -/// input pointer `slice` and returned pointer `output`, then:
> +/// The implementation of `index`, `build_index` and `get` (if [`Some`] is returned) must ensure
> +/// that, if provided input pointer `slice` and returned pointer `output`, then:

Since you are changing these lines I would suggest to rephrase for
better parsing:

For return value `output`, the implementation of `index`, `build_index`
and `get` (if [`Some`] is returned) must ensure that:

>  /// - `output` has the same provenance as `slice`;
>  /// - `output.byte_offset_from(slice)` is between 0 to
>  ///   `KnownSize::size(slice) - KnownSize::size(output)`.
>  ///
> -/// This means that if the input pointer is valid, then pointer returned by `get` or `index` is
> -/// also valid.
> +/// This means that if the input pointer is valid, then pointer returned by `get`, `index` or
> +/// `build_index` is also valid.
>  #[diagnostic::on_unimplemented(message = "`{Self}` cannot be used to index `{T}`")]
>  #[doc(hidden)]
>  pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
> @@ -42,9 +42,12 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
>      /// Returns an index-projected pointer, if in bounds.
>      fn get(self, slice: *mut T) -> Option<*mut Self::Output>;
>
> +    /// Returns an index-projected pointer; panic if out of bounds.
> +    fn index(self, slice: *mut T) -> *mut Self::Output;
> +
>      /// Returns an index-projected pointer; fail the build if it cannot be proved to be in bounds.
>      #[inline(always)]
> -    fn index(self, slice: *mut T) -> *mut Self::Output {
> +    fn build_index(self, slice: *mut T) -> *mut Self::Output {
>          Self::get(self, slice).unwrap_or_else(|| build_error!())
>      }
>  }
> @@ -67,6 +70,11 @@ fn index(self, slice: *mut T) -> *mut Self::Output {
>      fn index(self, slice: *mut [T; N]) -> *mut Self::Output {
>          <I as ProjectIndex<[T]>>::index(self, slice)
>      }
> +
> +    #[inline(always)]
> +    fn build_index(self, slice: *mut [T; N]) -> *mut Self::Output {
> +        <I as ProjectIndex<[T]>>::build_index(self, slice)
> +    }
>  }
>
>  // SAFETY: `get`-returned pointer has the same provenance as `slice` and the offset is checked to
> @@ -82,6 +90,14 @@ fn get(self, slice: *mut [T]) -> Option<*mut T> {
>              Some(slice.cast::<T>().wrapping_add(self))
>          }
>      }
> +
> +    #[inline(always)]
> +    fn index(self, slice: *mut [T]) -> *mut T {
> +        // Leverage Rust built-in operators for bounds checking.
> +        // SAFETY: All non-null and aligned pointers are valid for ZST read.
> +        unsafe { core::slice::from_raw_parts::<()>(core::ptr::dangling(), slice.len())[self] };

I think this would be more readable if you move the indexing operation
out of the unsafe block:

        // SAFETY: All non-null and aligned pointers are valid for ZST read.
        let slice = unsafe { core::slice::from_raw_parts::<()>(core::ptr::dangling(), slice.len()) };
        // Leverage Rust built-in operators for bounds checking.
        slice[self];

> +        slice.cast::<T>().wrapping_add(self)
> +    }
>  }
>
>  // SAFETY: `get`-returned pointer has the same provenance as `slice` and the offset is checked to
> @@ -100,6 +116,18 @@ fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
>              new_len,
>          ))
>      }
> +
> +    #[inline(always)]
> +    fn index(self, slice: *mut [T]) -> *mut [T] {
> +        // Leverage Rust built-in operators for bounds checking.
> +        // SAFETY: All non-null and aligned pointers are valid for ZST read.
> +        unsafe {
> +            _ = core::slice::from_raw_parts::<()>(core::ptr::dangling(), slice.len())[self.clone()];

Same comment regarding moving indexing to next line.

Side question: Why do you need to explicitly discard the return value
here (`_ = ...`) and not above?


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


