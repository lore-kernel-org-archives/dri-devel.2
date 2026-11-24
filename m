Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AB606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMSkBkSd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E36B10F568;
	Tue, 24 Nov 2026 12:44:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E6210F564
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:44:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CD2243F2D;
 Tue, 24 Nov 2026 12:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46291F000D1;
 Tue, 24 Nov 2026 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795524253;
 bh=ROMESwk5n5FXW6D4n9p3A2sHm1oDzuNKnBn6Fxw9RzU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FMSkBkSdJlUvRDw0tGjKxRqH4tuap9gbVW+IhVxqhVyJEIGRB2A1g/ZmJKU5HbIR0
 jwf50DFO2DufCibXun1fYjcRItXaIY5pdOBhfy3i/W9hXKJGYR27PgDXR3tglBhGzs
 JoiMEkmS3e6lScgsCiNJkChY+fWWzNyTHl/0TkIv6zCdvesfepcqoBv7rdE57bT44x
 Ci73JKH/aN+WOxVAuAZEQGYU4UTgH/cUY0n4SXUjn+UoYRaoXCtbP7/Tq1ORReOolW
 8W1X9k9wk/styaFBA9ls5b0giy7d7fZZB9v3vqqM+dNUQ9q5pDBUg66JE6n7uZmGI8
 3is38HwyrZBbw==
Message-ID: <sashiko-outbox-231166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] rust: DmaFence: Replace is_signaled() with
 status()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261124122951.878199-9-phasta@kernel.org>
References: <20261124122951.878199-2-phasta@kernel.org>
 <20261124122951.878199-9-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:44:12 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] rust: dma_fence: unordered error read and dropped lock in
  Fence::status()
- [Low] rust: dma_fence: missing #[inline] on Fence::status() and
  Fence::__status()
--

commit 26df0fcba82116d2e43f022188ec8d892405d6cd
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Replace is_signaled() with status()

This commit replaces Fence::is_signaled() with Fence::status() and introduc=
es
FenceStatus so callers check the fence error code when querying whether a
fence has been signaled.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 20dadbde4eb9d..09bebf9c1e4ee 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -510,40 +510,44 @@ unsafe impl Send for Fence {}
>  // SAFETY: Fences are literally designed to be shared between threads.
>  unsafe impl Sync for Fence {}
> =20
> +/// Fence-Status queried through [`Fence::status()`].
> +#[derive(Debug)]
> +pub enum FenceStatus {
> +    /// The fence is not yet signaled.
> +    Unsignaled,
> +    /// The fence is signaled. Might have been signaled with an error.
> +    Signaled(Result),
> +}
> +
>  impl Fence {
> -    /// Check whether the fence was signaled at the moment of the functi=
on call.
> +    /// Query a fence's error code and turn it into a [`Result`].
>      ///
> -    /// Note that this can return `true` for a [`Fence`] whose [`DriverF=
ence`]
> -    /// has not yet been dropped. The reason is that the fence ops callb=
acks can
> -    /// cause the fence to get signaled by the C backend.
> -    #[inline]
> -    pub fn is_signaled(&self) -> bool {
> -        // We should not use `dma_fence_is_signaled_locked()` here, beca=
use
> -        // according to the C backend's recommendations, that function is
> -        // problematic and we should avoid calling that function with a =
lock
> -        // held.
> -
> -        // SAFETY: Inner `fence` is valid because `self` is valid.
> -        let ret =3D unsafe { bindings::dma_fence_is_signaled(self.as_raw=
()) };
> -
> -        // To be as robust as possible for the future we guarantee that =
an API
> -        // caller can 100% rely on the signaling being completed (i.e., =
all
> -        // fence callbacks ran), so we have to take the lock.
> -        //
> -        // The reason is that the C dma_fence backend currently does not
> -        // carefully synchronize the `dma_fence_is_signaled()` function =
with the
> -        // proper spinlock. This can lead to the function returning `tru=
e` while
> -        // fence callbacks are still being executed. This can be mitigat=
ed by
> -        // guarding the entire function with the spinlock.
> -        //
> -        // The fundamental reason is that the C backend currently does g=
uard
> -        // setting of the fence's signaled-bit with the fence's spinlock=
, but
> -        // reading is done locklessly.
> -        //
> -        // See commit c8a5d5ea3ba6a.
> -        let _ =3D self.lock();
> +    /// # Safety
> +    ///
> +    /// The caller must only call this on fences that are already signal=
ed. It
> +    /// must be ensured that this is ordered properly against checking o=
f the
> +    /// signaled status (fence->signaled bit).
> +    unsafe fn __status(&self) -> Result {
> +        // SAFETY: Safe by the function's safety requirements.
> +        let res =3D unsafe { (*self.as_raw()).error };
> +
> +        to_result(res)
> +    }
> +
> +    /// Query a fence's status at the moment of the function call.
> +    ///
> +    /// If it is signaled, return the fence's result, i.e., determine if=
 it was
> +    /// signaled with an error.
> +    pub fn status(&self) -> FenceStatus {
> +        // SAFETY: `self` is valid.
> +        if unsafe { bindings::dma_fence_is_signaled(self.as_raw()) } {
> +            // SAFETY: The fence is signaled. The C backend ensures orde=
ring.
> +            let status =3D unsafe { self.__status() };
> +
> +            return FenceStatus::Signaled(status);
> +        }
> =20
> -        ret
> +        FenceStatus::Unsignaled
>      }

[Severity: Medium]
Can Fence::status() read (*self.as_raw()).error without load-to-load orderi=
ng
against DMA_FENCE_FLAG_SIGNALED_BIT and observe FenceStatus::Signaled(Ok(()=
))
on a fence signaled with an error?

On the fast path, dma_fence_is_signaled() checks
dma_fence_test_signaled_flag(), which calls an unordered test_bit():

include/linux/dma-fence.h:dma_fence_test_signaled_flag() {
	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
}

Because test_bit() has no acquire semantics and a control dependency does n=
ot
order load-to-load, a weakly-ordered CPU can reorder the non-atomic read of
fence->error in Fence::__status() before the read of fence->flags:

CPU0                              CPU1
DriverFence::signal(Err(...))     Fence::status()
  dma_fence_lock_irqsave()          dma_fence_is_signaled()
                                      /* speculates fence->error =3D=3D 0 */
  fence->error =3D err;
  dma_fence_signal_locked()
    test_and_set_bit(SIGNALED, ...)
                                      test_bit(SIGNALED, ...) =3D=3D true
                                    self.__status()
                                      reads stale error =3D=3D 0  <-- data =
race

Removing self.lock() (which C's dma_fence_get_status() takes around
dma_fence_get_status_locked()) also drops the guarantee previously provided
by Fence::is_signaled() that all registered fence callbacks have finished
running before the fence is observed as signaled.  Acquiring self.lock()
before reading self.__status() would both order the error read and preserve
callback completion synchronization.

[Severity: Low]
In kernel crate abstractions, small functions and functions that forward to=
 C
bindings should be marked with #[inline] (as the removed Fence::is_signaled=
()
was).  Fence::__status() and Fence::status() are missing #[inline].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124122951.8781=
99-2-phasta@kernel.org?part=3D7
