Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4716CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5066D1126E0;
	Fri, 16 Oct 2026 09:11:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE881126E1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:11:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DD8E60008;
 Fri, 16 Oct 2026 09:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035AC1F000C4;
 Fri, 16 Oct 2026 09:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792141897;
 bh=vvrwRY9A3W0JlUA8O/MOXZoUw4Mh6FR7BUSyyBmrx6M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VSoPeqBG9mQFLqfzHqkGXHSikotix188+wXReM1xBEBTxicAgyxgMxsO54GuTJwd7
 qe9NBl1Qw9cEy1VyAtKH8uQrY7gR/dMErca+37HMDZBBudTUWS/kVPgU7nQkRmIYwL
 EIUoj934659zDERBAHqR43JoDV8jiYeFh7OL01SaNsvQ1IvBPS46P2xVtI/M89zW0d
 x1XB84yA/1Y3iZ12HFGDyc4xNs4HTbCL6ytwI1r3KgizjYQb5BrlGIn/cQ+XX1fdeg
 tZJBX6A1F9zyy1hfkGRSP5IkT7AH1GZ37CCqm+MHuzgewwk0sC18HVHpiE1NSKAj/M
 1TU1qCcnUUJfQ==
Message-ID: <sashiko-outbox-174062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 4/5] rust: DmaFence: Replace call_rcu() with
 synchronize_rcu()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261016085724.1031766-6-phasta@kernel.org>
References: <20261016085724.1031766-2-phasta@kernel.org>
 <20261016085724.1031766-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:11:36 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] mm: memory leak of T::FenceDataType in DriverFence::drop due to dr=
opping NonNull wrapper
- [High] locking: synchronize_rcu() in DriverFence::drop causes sleep-in-at=
omic
- [High] dma_fence: UAF of FenceContext strings via outliving Fence consume=
rs
- [Low] doc: outdated safety comments referencing removed call_rcu()
--

commit 900eae064aeab4bf810f0f2081db8a2981b08546
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Replace call_rcu() with synchronize_rcu()

This commit replaces the use of call_rcu() with synchronize_rcu() for dropp=
ing
DriverFence data. It removes the raw C callback and drops the data in-place
using drop_in_place().

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index b67121c7abd41..9efb84c00b6a2 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> @@ -973,59 +971,18 @@ fn drop(&mut self) {
>              return;
>          }

[Severity: Low]
Does this patch leave outdated safety comments in DriverFence::drop()?

The deferred call_rcu() has been removed from DriverFence::drop() and repla=
ced
with synchronize_rcu(), but multiple SAFETY comments still reference it:

    // SAFETY: `guard` is valid until the `call_rcu()` below.
    let signaled: bool =3D unsafe { bindings::dma_fence_test_signaled_flag(=
guard.as_raw()) };

Could these comments be updated to prevent confusion during future maintena=
nce?

> =20
> +        // Make sure none of the fence backend_ops can access data anymo=
re.
> +        //
> +        // TODO:
> +        // This would not be necessary if the C dma_fence backend were u=
sing a
> +        // spinlock to properly synchronize its signaled state. Fix it i=
n C and
> +        // then remove synchronize_rcu().
> +        synchronize_rcu();

[Severity: High]
DriverFence implements Send + Sync, and Drop is called automatically when
variables go out of scope. Can this synchronize_rcu() be called from atomic
contexts like spinlock critical sections, interrupt handlers, or RCU read-s=
ide
critical sections?

Because synchronize_rcu() blocks and waits for a grace period, wouldn't dro=
pping
a DriverFence in these contexts cause a might_sleep() lockdep warning or a
system deadlock on PREEMPT_RT?

[Severity: High]
This problem wasn't introduced by this patch, but does FenceContext have a
use-after-free issue with its strings?

The safety comment in get_driver_name() assumes it is only called on unsign=
aled
fences:

rust/kernel/dma_buf/dma_fence.rs:get_driver_name() {
    // SAFETY: The C backend only invokes this callback with `ptr` pointing
    // to a valid, unsignaled `bindings::dma_fence`.
    // ...
    let fctx =3D unsafe { Self::from_raw_fence(ptr) };

    fctx.driver_name.as_char_ptr()
}

However, sync_fill_fence_info() accesses the driver name when userspace que=
ries
the sync_file info, and it calls get_driver_name() regardless of the signal=
ed
state.

A consumer holding a sync_file fd can retain a reference to the Fence long =
after
the driver signals it and drops the FenceContext.

Furthermore, by replacing call_rcu() with synchronize_rcu() in
DriverFence::drop(), doesn't this completely defeat the rcu_barrier() in
FenceContext::drop() which was meant to wait for these tear-downs?

rust/kernel/dma_buf/dma_fence.rs:FenceContext::drop() {
    // Wait for the RCU callbacks in `DriverFence::drop`.
    rcu_barrier();
}

> =20
>          // SAFETY: Valid because `self` is valid.
> -        let rcu_head_ptr =3D unsafe { &raw mut (*self.data.as_ptr()).rcu=
_head };
> +        unsafe { drop_in_place(&raw mut self.data) };

[Severity: High]
Does this actually drop the underlying data, or does it just drop the NonNu=
ll
pointer itself?

Since self.data is of type NonNull<DriverFenceData<'a, T>>, &raw mut self.d=
ata
produces a pointer to the NonNull wrapper (*mut NonNull<...>).

Because NonNull is Copy and has no Drop implementation, calling drop_in_pla=
ce()
on this pointer is a no-op.

Will this permanently leak the actual user payload T::FenceDataType located=
 at
(*self.data.as_ptr()).data?

> -        // SAFETY: `call_rcu()` is always safe to be called. `rcu_head_p=
tr` was
> -        // created validly above. The module must perform a `synchronize=
_rcu()`
> -        // or `rcu_barrier()` call to guard against module unload.
> -        unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence=
_data::<T>)) };
> +        // SAFETY: The `synchronize_rcu()` above ensures all accessors a=
re gone.
> +        unsafe { bindings::dma_fence_put(self.as_raw()) };
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016085724.1031=
766-2-phasta@kernel.org?part=3D4
