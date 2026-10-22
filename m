Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA2606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcUlmrYz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632F610E42E;
	Thu, 22 Oct 2026 16:47:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A07510E42E
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 16:47:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86E0042A34;
 Thu, 22 Oct 2026 16:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179391F01825;
 Thu, 22 Oct 2026 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792687641;
 bh=vbOJigGe+ZyCcLUM2u5fbhq5ZhA5n8CDCfZA8F7woPM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XcUlmrYzYWNiMABCDmUbjW4nTR63gd9KNfU7ftnaFyVgXppgo4lue9MRcpon52g0H
 PlbPUfnF3jnPsBI7377gOAsTa899EetpTH+yb7Bzn0TxKu9pk9YonRtjgpUfSrGnt+
 stPT1mVdo3dM+6nBFslGvayKRV3YwJW6Bzkef5T4QgWY2oznnh0aplYygdXkQe2Y8R
 YSMzGNTyrdXOBpkAFmbGmTzde+DhCTdDV5K9ta1iOL3a8DegJkUXSHhdZxJQcQuL1r
 2WnZ/DfITrUo8d/hqThHfnWJnuew8qdMqz1l3HeXTPYQmVaVUt+Ah5bnXx7cnj6EWy
 kEGI9AmNcaGDA==
Message-ID: <sashiko-outbox-181828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: DmaFence: Don't drop on signal
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261022162701.2297062-3-phasta@kernel.org>
References: <20261022162701.2297062-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:47:20 +0000
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
- [High] rust: dma_fence: premature unsignaled fence count decrement in sig=
nal()
--

commit d89d19611f93fbf6fde4c15619608d55fb454178
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Don't drop on signal

This commit changes DriverFence::signal() to take &self instead of consuming
self by value so that signaling a fence in atomic context does not
immediately drop it, and moves the nr_of_unsignaled_fences decrement inside
the unsignaled check.

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
Can decrementing fctx.nr_of_unsignaled_fences in DriverFence::signal() befo=
re
DriverFence::drop() runs lead to a use-after-free of FenceContext?

Previously, DriverFence::signal(self, res) consumed self by value, so
decrementing nr_of_unsignaled_fences was immediately followed by
DriverFence::drop(), which queues the drop_driver_fence_data() callback via
call_rcu():

rust/kernel/dma_buf/dma_fence.rs:DriverFence::drop() {
    ...
    unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence_data::=
<T>)) };
}

In FenceContext::drop(), the check on nr_of_unsignaled_fences and the
subsequent rcu_barrier() rely on all associated DriverFence instances having
already been dropped and having queued their call_rcu() callbacks:

rust/kernel/dma_buf/dma_fence.rs:FenceContext::drop() {
    if self.nr_of_unsignaled_fences.load(Relaxed) !=3D 0 {
        panic!("Forgotten fences in FenceContext.");
    }
    ...
    rcu_barrier();
}

With DriverFence::signal(&self, res) no longer consuming self,
fctx.nr_of_unsignaled_fences is decremented before DriverFence::drop() runs
and before bindings::dma_fence_signal_locked() is called.

If a DriverFence is signaled via DriverFence::signal() and then leaked with
core::mem::forget(), or held as a foreign pointer via
ForeignOwnable::into_foreign() and signaled via DriverFenceBorrow::signal(),
nr_of_unsignaled_fences can reach 0 before DriverFence::drop() has queued
call_rcu().

When FenceContext::drop() then runs:

1. The nr_of_unsignaled_fences check passes even though DriverFence::drop()
   has not run.
2. rcu_barrier() only waits for already-queued call_rcu() callbacks, so it
   can return without waiting for a grace period after
   dma_fence_signal_locked(), or before a foreign-owned DriverFence is later
   reclaimed via DriverFence::from_foreign() and dropped.
3. For a foreign-owned DriverFence, decrementing nr_of_unsignaled_fences wi=
th
   Relaxed ordering before dma_fence_signal_locked() also allows
   FenceContext::drop() to free fctx.driver_name and fctx.timeline_name whi=
le
   dma_fence_signal_locked() (via trace_dma_fence_signaled()) or concurrent
   readers in dma_fence_driver_name() and dma_fence_timeline_name() are sti=
ll
   accessing the FenceContext through FenceContext::get_driver_name() and
   FenceContext::get_timeline_name().

Should nr_of_unsignaled_fences only be decremented in DriverFence::drop() (=
or
tracked until drop) so that FenceContext::drop() cannot complete before all
DriverFence instances have queued their call_rcu() callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022162701.2297=
062-3-phasta@kernel.org?part=3D1
