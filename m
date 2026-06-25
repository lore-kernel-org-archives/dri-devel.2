Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85B8CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05BF10E1E8;
	Thu, 25 Jun 2026 12:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b/e9gwqh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5DD10E1E8
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:24:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90CB560018
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5841F000E9;
 Thu, 25 Jun 2026 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782390253;
 bh=+ev/MbYM79nnCirR6VQ2j+1yHoZbgSCaE0wxXCMX9Xw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=b/e9gwqhowGhyJ/rECNST8dxSNJa7J0mB8wKJ5YPivPO23Gvw0kpgXL6v2ctoUfIU
 osojjl0mIcmRC0KQsuFpX/LOTocf3N7Cqb9CBB7h75FYp8k1ZsWU+KwJh+FR7SvLU3
 TFx4Vy4yK8o5cmMa0E8xduu6AIYNBPdof6GN5fh3LgIUpci2qFZb1wcphNHq1Lp/DB
 1HHPmqlULEpX1B2b0z6iuVtK0Sdww6W9zdCSd7YkHV8naWp0VznrJj8Q1HTCxwYrx+
 Esc3E8kMRv/4hvk0pM+tCj5maLQ3gJ8j3wEa9D6LVZ408kuiYyghIzH9UDF6Ina+5O
 ndKnbfktwYIWA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v18 2/8] rust: types: Add Ownable/Owned types
In-Reply-To: <20260625102450.7611D1F000E9@smtp.kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-2-4e06b5896d47@kernel.org>
 <RGwPXnEIbmBiUBfnS6xf4w_nFgCkKyGqve0WSY_SbSrRXPnRF3zE_LoMjmCUpsnUBAZU8NQz5SkXWgUU7xZnBA==@protonmail.internalid>
 <20260625102450.7611D1F000E9@smtp.kernel.org>
Date: Thu, 25 Jun 2026 14:24:04 +0200
Message-ID: <87a4siiza3.fsf@t14s.mail-host-address-is-not-set>
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

<sashiko-bot@kernel.org> writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] `Owned<T>` unconditionally structurally pins `T` by exposing `Pin<&mut T>`, but its API lacks the necessary documentation and safety bounds to enforce the pinning invariants. Specifically, `Owned::from_raw(ptr)` takes ownership without requiring the caller to promise the memory is or can be pinned; `Owned::into_raw(me)` safely extracts the pointer without documenting that the returned pointer's referent is still pinned; and `Ownable::release(this)` doesn't forbid the implementer from moving the pinned `Self` before dropping it. This omission allows an `Ownable` implementer or a user correctly following the explicit safety contracts to accidentally move a pinned `!Unpin` type, resulting in undefined behavior.
> --
>
> commit b7329ea2c0525ffa6a63171ede0921ad2e6a23e5
> Author: Asahi Lina <lina+kernel@asahilina.net>
>
> rust: types: Add Ownable/Owned types
>
> This commit introduces Ownable and Owned types for unique owned pointers
> with custom drop logic. These types allow C-allocated objects owned by Rust
> to be freed through the C API. It also updates documentation and adds usage
> examples.
>
> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
>
>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>> new file mode 100644
>> index 0000000000000..7fe9ec3e55126
>> --- /dev/null
>> +++ b/rust/kernel/owned.rs
> [ ... ]
>> +pub trait Ownable {
>> +    /// Tear down this `Ownable`.
>> +    ///
>> +    /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
>> +    /// include freeing the underlying object.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that they have exclusive ownership of the `Self` pointed to by `this`,
>> +    /// and that this ownership is transferred to the `release` method. `this` must not be used
>> +    /// after calling this method, as the underlying object may have been freed.
>> +    unsafe fn release(this: NonNull<Self>);
>
> [Severity: High]
> Since Owned<T> treats T as pinned (exposing Pin<&mut T> via as_pin_mut()),
> should the safety contract here also require that implementers treat `this`
> as pointing to pinned memory?
>
> If an implementer moves the value during cleanup (for example, by reading it
> onto the stack), it could violate the pinning guarantees for !Unpin types and
> cause memory corruption due to self-reference invalidation.

No. `this` is a pointer, and the value cannot be accessed or moved with
safe code. Moving out of `this` requires an unsafe block with proper
safety comments.

>
>> +}
> [ ... ]
>> +impl<T: Ownable> Owned<T> {
>> +    /// Creates a new instance of [`Owned`].
>> +    ///
>> +    /// This function takes over ownership of the underlying object.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that:
>> +    /// - `ptr` points to a valid instance of `T`.
>> +    /// - Until `T::release` is called, the returned `Owned<T>` exclusively owns the underlying `T`.
>> +    #[inline]
>> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>
> [Severity: High]
> Does this safety contract need to require that the pointer is permanently
> pinned?
>
> Because Owned<T> can expose a pinned mutable reference, callers should be
> aware that they cannot assume the memory remains unpinned after calling this
> function.

No. The documentation clearly state that this function takes ownership
of the underlying object. The caller no longer has authority to access
the object.

>
>> +        // INVARIANT: By function safety requirement we satisfy the first invariant of `Self`.
>> +        // We treat `T` as pinned from now on.
>> +        Self { ptr }
>> +    }
>> +
>> +    /// Consumes the [`Owned`], returning a raw pointer.
>> +    ///
>> +    /// This function does not drop the underlying `T`. When this function returns, ownership of the
>> +    /// underlying `T` is with the caller.
>> +    #[inline]
>> +    pub fn into_raw(me: Self) -> NonNull<T> {
>
> [Severity: High]
> Since into_raw() safely strips the Owned wrapper, should there be
> documentation stating that the caller remains bound by the pin invariant
> established by Owned?
>
> Without this, a caller might extract the pointer and safely move the
> previously pinned object, resulting in undefined behavior.
>

No. the return value is a pointer, and the pointee cannot be accessed or
moved with safe code. Moving out of `this` requires an unsafe block with
proper safety comments.


Best regards,
Andreas Hindborg


