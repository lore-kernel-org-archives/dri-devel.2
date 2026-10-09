Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB04CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D8310E1D6;
	Fri,  9 Oct 2026 19:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZWFSwxhE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B07610E1D6
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:23:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E44214161E;
 Fri,  9 Oct 2026 19:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727BA1F000FF;
 Fri,  9 Oct 2026 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573830;
 bh=PncJfoTJSK1IyIClaYJt7sHIDtBgeczxENWJTtWC11A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZWFSwxhEbrLBgtRa/UbBFxOwhaRV7TOpmM0CcCDa/1O+t5Y7bXx4xGdRB6qAsfeyN
 rRKFYs4yJH/L8GuYBoK4nfO+tx0kuyTu3BWGpPGwP60VYqRQJSfzrpSZrhj5nKCDO1
 GEj9mw1X5dygBoCFcqa/w27HEbebHU4NU/Hp8nlF26z4OXQW+H4ihJbW/V0o9qaFQW
 o0mAmgxPcTogVSTG02HbSyQlIPdGOwzgzjYW0n/TDM4K/Njm2a7bjr/h5t/T7fqZBm
 6MT0B6mOcu3vdsRqOxnbGvB88VgykqUcocApOLXt6yEK+ie3NEOjdQ4/FVnBhygfMu
 4+MHJJgY6PKdg==
Message-ID: <sashiko-outbox-165997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 4/6] rust: DmaFence: [RFC] Add Signaler
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, gary@garyguo.net, ojeda@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261009191124.1022902-6-phasta@kernel.org>
References: <20261009191124.1022902-2-phasta@kernel.org>
 <20261009191124.1022902-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 19:23:49 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dma_fence: counter leak in FenceSignaler::signal causes panic on d=
rop
- [Low] rust: missing inline annotations on small forwarding functions in a=
bstraction crate
--

commit 31b644dae0c3cdaaa05c7d23cd49d1e5209e51c7
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: [RFC] Add Signaler

This commit introduces a FenceSignaler type that allows signaling an
associated DriverFence independently of the locked data structure it
resides in.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index b67121c7abd41..4e9b4a6a9471b 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -590,6 +590,45 @@ unsafe fn dec_ref(ptr: NonNull<Self>) {
>      }
>  }
> =20
> +/// An object that can signal an associated [`DriverFence`], independent=
ly of
> +/// that one's lifetime.
> +///
> +/// Use with great caucion! Only the producer of a fence should ever be =
able to
> +/// signal it.
> +///
> +/// This helper is necessary to signal DriverFences that are hidden behi=
nd locks
> +/// which cannot be taken in certain situations.
> +pub struct FenceSignaler {
> +    fence: ARef<Fence>,
> +}
> +
> +impl FenceSignaler {
> +    /// Signal the associated [`DriverFence`].
> +    pub fn signal(&self, res: Result) {
> +        let fence =3D self.fence.lock();
> +
> +        // SAFETY: `fence` is valid because `self` is valid. The lock mu=
st be
> +        // held, which we acquired directly above.
> +        if !unsafe { bindings::dma_fence_test_signaled_flag(fence.as_raw=
()) } {
> +            if let Err(err) =3D res {
> +                // SAFETY: `fence` is valid because `self` is valid. The=
 fence
> +                // must not have been signaled yet, which we check direc=
tly above.
> +                unsafe { bindings::dma_fence_set_error(fence.as_raw(), e=
rr.to_errno()) };
> +            }
> +            // SAFETY: `fence` is valid because `self` is valid. The loc=
k must
> +            // be held, which we acquired above.
> +            unsafe { bindings::dma_fence_signal_locked(fence.as_raw()) };
> +        }
> +
> +        // TODO: This should decrement the nr-of-unsignaled-fences track=
er in fctx
> +    }

[Severity: High]
Does skipping the counter decrement here cause a resource leak leading to a
kernel panic?

When FenceSignaler::signal() signals the fence without decrementing
nr_of_unsignaled_fences, it creates an issue during teardown. If the
associated DriverFence is subsequently dropped, DriverFence::drop() will
observe that the fence is already signaled and skip its own decrement:

DriverFence::drop() {
    ...
    let signaled: bool =3D unsafe { bindings::dma_fence_test_signaled_flag(=
guard.as_raw()) };
    if !signaled {
    ...
}

As a result, the unsignaled counter permanently leaks 1 count per use of
FenceSignaler. When the FenceContext is eventually dropped, its non-zero
counter triggers panic!("Forgotten fences in FenceContext.").

Can this TODO be resolved before merging to prevent drivers from triggering=
 a
denial of service on normal cleanup paths?

> +
> +    /// Get the associated fence's sequence number.
> +    pub fn seqno(&self) -> u64 {
> +        self.fence.seqno()
> +    }

[Severity: Low]
Are small forwarding functions like this missing the #[inline] attribute?

According to the Rust subsystem coding guidelines, small functions or funct=
ions
forwarding to a C binding call in abstractions should be annotated with
#[inline] to avoid minor performance overhead across crate boundaries.

[ ... ]

> @@ -805,6 +844,16 @@ pub fn as_fence(&self) -> &Fence {
>          unsafe { Fence::from_raw(self.as_raw()) }
>      }
> =20
> +    /// Create a [`FenceSignaler`] associated with this `DriverFence`.
> +    ///
> +    /// Use with caution! Only the producer of a [`DriverFence`] should =
be able
> +    /// to signal it.
> +    pub fn new_signaler(&self) -> FenceSignaler {
> +        FenceSignaler {
> +            fence: ARef::from(self.as_fence()),
> +        }
> +    }

[Severity: Low]
Should this small constructor also have an #[inline] annotation?

Additionally, FenceContext::deref() is a trivial deref implementation in
this file missing the #[inline] attribute. Could these annotations be added?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009191124.1022=
902-2-phasta@kernel.org?part=3D4
