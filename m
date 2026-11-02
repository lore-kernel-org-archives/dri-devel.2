Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0360805BB
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3MnD7ha
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D5510EFDC;
	Mon,  2 Nov 2026 15:22:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5883C10EFDC
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:21:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF5A560054;
 Mon,  2 Nov 2026 15:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6861F00A28;
 Mon,  2 Nov 2026 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793632917;
 bh=lamd1hngyjQe9Qec+ZAE623xEm5qURZqSCNCuwpq8/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h3MnD7haXKrv7lw/q8yLht91bfxvSezCTLYD3mCDFWw6tq+wy+xqjB5w8333wqhvq
 XBTCtdZLdi9j6inJpIy2OxSkMAdZVgYi96la4l1FXKGHAONqeEbkI/eQs0Gkc6hXdx
 65grBwFVsPjgaxpPt/iivWLx9JsVM6OUgsE1xXVWVLDuF7eAQ4hn7sb/GCGdbqMh37
 xDyVA734rXD7VmaVAT8VoorEn220qEGCxne3935Y1YzzaRciERsNbah2PrRam2i3w4
 gdyNt2QcIGCHV9d1JrIA2ihHf0It1BXCDDE2uF2DVvso2rLzyO/SDnm9fsuRb1X19v
 dwmIuzKdbaExw==
Message-ID: <sashiko-outbox-193652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rust: DmaFence: Don't drop on signal
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261102150617.527772-3-phasta@kernel.org>
References: <20261102150617.527772-2-phasta@kernel.org>
 <20261102150617.527772-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:21:56 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rust: dma_fence: premature unsignaled count decrement in signal()
--

commit cc3ae2917828ada16cb77f317557169874bb144b
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Don't drop on signal

This commit changes DriverFence::signal() in rust/kernel/dma_buf/dma_fence.=
rs
to take a shared reference instead of consuming self, allowing fences to be
signaled without immediately dropping the DriverFence.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index a1d851656562d..3022bdb5f7c3e 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -805,7 +805,7 @@ pub fn as_fence(&self) -> &Fence {
>      }
> =20
>      /// Signal the fence. This will invoke all registered callbacks.
> -    pub fn signal(self, res: Result) {
> +    pub fn signal(&self, res: Result) {
>          let fence =3D self.as_fence().lock();
> =20
>          // SAFETY: `fence` is valid because `self` is valid. The lock mu=
st be
> @@ -816,14 +816,15 @@ pub fn signal(self, res: Result) {
>                  // must not have been signaled yet, which we check direc=
tly above.
>                  unsafe { bindings::dma_fence_set_error(fence.as_raw(), e=
rr.to_errno()) };
>              }
> +
> +            // SAFETY: `self.data` is valid because `self` is valid.
> +            let fctx =3D unsafe { self.data.as_ref().fctx };
> +            let _ =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
> +
>              // SAFETY: `fence` is valid because `self` is valid. The loc=
k must
>              // be held, which we acquired above.
>              unsafe { bindings::dma_fence_signal_locked(fence.as_raw()) };
>          }
> -
> -        // SAFETY: `self.data` is valid because `self` is valid.
> -        let fctx =3D unsafe { self.data.as_ref().fctx };
> -        let _ =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
>      }
>  }

[Severity: High]
Since DriverFence::signal() no longer consumes self and no longer runs
DriverFence::drop(), can decrementing fctx.nr_of_unsignaled_fences here all=
ow
FenceContext::drop() to free FenceContext too early?

In FenceContext::drop(), nr_of_unsignaled_fences is checked before calling
rcu_barrier() to wait for the RCU callbacks queued by DriverFence::drop():

rust/kernel/dma_buf/dma_fence.rs:FenceContext::drop() {
    if self.nr_of_unsignaled_fences.load(Relaxed) !=3D 0 {
        panic!("Forgotten fences in FenceContext.");
    }
    ...
    // Wait for the RCU callbacks in `DriverFence::drop`.
    rcu_barrier();
}

Because DriverFence::signal() now takes &self and does not drop the fence,
DriverFence::drop() has not queued call_rcu(rcu_head_ptr,
Some(drop_driver_fence_data::<T>)) when signal() returns.

If a DriverFence is signaled via DriverFence::signal() and then forgotten in
safe Rust via core::mem::forget() (or held in foreign storage via
ForeignOwnable::into_foreign()) when FenceContext is dropped,
FenceContext::drop() will observe nr_of_unsignaled_fences =3D=3D 0 without
panicking. It then runs rcu_barrier(), which returns without waiting for an
RCU grace period after signaling because no RCU callback was ever queued by
DriverFence::drop(). Concurrent RCU readers in dma_fence_driver_name() or
dma_fence_timeline_name() that raced with signaling could then read freed
fctx.driver_name and fctx.timeline_name memory, or a later
DriverFence::drop() on a foreign-owned fence could access a dangling fctx
reference and queue call_rcu() after FenceContext::drop() has already
completed.

Additionally, fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed) now runs
before bindings::dma_fence_signal_locked(fence.as_raw()). During
dma_fence_signal_locked(), trace_dma_fence_signaled() invokes
FenceContext::get_driver_name() and FenceContext::get_timeline_name(), which
dereference fctx. If a foreign-owned DriverFence is signaled via
DriverFence::borrow().signal() concurrently with FenceContext::drop(), could
FenceContext::drop() see nr_of_unsignaled_fences =3D=3D 0 and free FenceCon=
text
before dma_fence_signal_locked() even finishes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150617.5277=
72-2-phasta@kernel.org?part=3D1
