Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66601606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETNLZwmH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C732C112E13;
	Fri,  6 Nov 2026 14:18:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84EF8112E13
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:18:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44C61411E2;
 Fri,  6 Nov 2026 14:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D11F0089F;
 Fri,  6 Nov 2026 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974725;
 bh=4F/nkuv8fdeRgAx0B6n+wUt8uR7zMegMzliJuQqCmUg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ETNLZwmHLkBJ8VIUnR566/MXztPjgEqJNsPjssr/ztPAhrK+p4b6VdasjmCs2Cebj
 L+0A8W9wzDZe3PmXKPYtNXbByn5d+/v55oTyBFohWKrIlCcO/X+gMYKFyjk+aoSFpl
 3LrKMHV+9VxTH/juDsTxRnSqoX9afVohs2xIkwcSOPEoiDhdH3De8wevSDahsHaB4E
 7KsJY68V8Khi452FkMPeMNnj+3D3VYY3HJNNrq1JWARUS2lHuSr4UrkIwxQNu39OLD
 t1kbxt1wT4lODQkbq85wpp9PBh5ZmvrWzRYQYTgmsP0Rgo/cEpylhJQMwanyrb0shm
 vccRqnqyWMdxA==
Message-ID: <sashiko-outbox-201565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] rust: DmaFence: Replace is_signaled() with status()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261106140752.520386-7-phasta@kernel.org>
References: <20261106140752.520386-2-phasta@kernel.org>
 <20261106140752.520386-7-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:18:44 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rust: dma_fence: missing #[inline] on Fence::status() and
  Fence::__status()
--

commit a2517bd1921c87adc707463adc2934165a311348
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Replace is_signaled() with status()

This commit replaces Fence::is_signaled() with Fence::status() and
introduces FenceStatus so callers check whether a signaled fence completed
with an error under the fence lock.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index f74119b4d7f87..b0c0e32462aeb 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -504,40 +504,49 @@ unsafe impl Send for Fence {}
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
[ ... ]
> +    /// # Safety
> +    ///
> +    /// The caller must only call this on fences that are already signal=
ed.
> +    unsafe fn __status(&self) -> Result {
> +        // SAFETY: Safe by the function's safety requirements.
> +        let res =3D unsafe { (*self.as_raw()).error };
> =20
> -        ret
> +        to_result(res)
> +    }
> +
> +    /// Query a fence's status at the moment of the function call.
> +    ///
> +    /// If it is signaled, return the fence's result, i.e., determine if=
 it was
> +    /// signaled with an error.
> +    pub fn status(&self) -> FenceStatus {
> +        // The C backend provides `dma_fence_is_signaled()`. However, th=
is is
> +        // currently racy and could lead to misordering with our reading=
 of the
> +        // fence error code. Take the lock to prevent that.
> +        let fence =3D self.lock();
> +        // SAFETY: `fence` is valid because `self` is valid. The lock was
> +        // taken above.
> +        let signaled =3D unsafe { bindings::dma_fence_is_signaled_locked=
(fence.as_raw()) };
> +
> +        if signaled {
> +            // SAFETY: The fence is signaled.
> +            let status =3D unsafe { fence.__status() };
> +
> +            return FenceStatus::Signaled(status);
> +        }
> +
> +        FenceStatus::Unsignaled
>      }

[Severity: Low]
Should Fence::__status() and Fence::status() retain the #[inline] attribute
that Fence::is_signaled() had, so downstream crates can inline these small
C-binding wrappers across crate boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106140752.5203=
86-2-phasta@kernel.org?part=3D5
