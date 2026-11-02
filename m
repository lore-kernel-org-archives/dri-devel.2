Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E816087A05
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtjRPct/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093F310F003;
	Mon,  2 Nov 2026 15:30:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E709C10F003
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:30:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B88760B3B;
 Mon,  2 Nov 2026 15:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DB21F00A16;
 Mon,  2 Nov 2026 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793633441;
 bh=VqRwWUkcYzRESZsOlbhts/IU52snrP1CYOjqgv01fcw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZtjRPct/P/cSczN4BkSqz5jDRNX/bcer5OIvI6SLV9YdBb55Wi3DtwgzytVDrLdxg
 v29sRI8kWY+MlOXASrjBQIJtaX0xh2yIyU4fbCwhiDgJrxxvcHVrIISVg7RsBxi6oG
 ZX6bJdxeabhVKlea4ymD3PDW9fTHvKh21GVFtYopO2fk1wRc4b2n7k0WCg0fxuSh5S
 8qkAU2BHSa8bMa0AbwvjGIyQABgDbQOyAHq8YgOcRRGRSa/U/D0nvvcmUVgMYhO3rw
 81FiIa/6ODGiTBAc0j8Xrii1CyTz428VsnZw+za4HrrsYTkDKjpOmNxv22PAVpoeY5
 Yi2Sa3VohuJDQ==
Message-ID: <sashiko-outbox-193667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rust: DmaFence: Replace call_rcu() with
 synchronize_rcu()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261102150617.527772-4-phasta@kernel.org>
References: <20261102150617.527772-2-phasta@kernel.org>
 <20261102150617.527772-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:30:40 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] rust: dma_fence: leak of FenceDataType in DriverFence::drop()
- [High] rust: dma_fence: missing RCU grace period before FenceContext drop
- [Low] rust: dma_fence: stale atomic-context Drop docs on FenceDataType
- [Low] rust: dma_fence: broken intra-doc link to rcu::synchronize_rcu
--

commit 5b8baa0550a0166f96a31017e673de763e929c7c
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Replace call_rcu() with synchronize_rcu()

This commit replaces the deferred call_rcu() callback in DriverFence::drop()
with a synchronous synchronize_rcu() call so that driver fence payload data=
 is
not dropped in atomic context.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 3022bdb5f7c3e..ad9cebf8428c0 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -42,7 +42,10 @@
>              Atomic,
>              Relaxed, //
>          },
> -        rcu::rcu_barrier, //
> +        rcu::{
> +            rcu_barrier,
> +            synchronize_rcu, //
> +        }, //
>      }, //
>  };
> =20
> @@ -65,7 +68,7 @@ pub struct FenceContext<T: FenceContextOps + Send + Syn=
c> {
>      /// The sequence number for the next fence created.
>      seqno: Atomic<u64>,
>      // The name parameters can be accessed by the dma_fence backend_ops.=
 UAF
> -    // errors are prevented by the `call_rcu()` in `drop_driver_fence_da=
ta()`.
> +    // errors are prevented by the `synchronize_rcu()` in `drop_driver_f=
ence_data()`.
>      /// The name of the driver this FenceContext's fences belong to.
>      driver_name: CString,
>      /// The name of the timeline this FenceContext's fences belong to.

[ ... ]

> @@ -600,8 +602,6 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCont=
extOps> {
>      // necessary so that the C backend can free the allocation (coming f=
rom our
>      // Rust code) with kfree_rcu().
>      inner: Fence,
> -    /// Callback head for dropping this in a deferred manner through RCU.
> -    rcu_head: bindings::callback_head,
>      /// Reference to access the FenceContext.
>      fctx: &'a FenceContext<T>,
>      /// The API user's data. It is essential that the data only performs

[Severity: Low]
Since DriverFence::drop() now drops the payload synchronously after
synchronize_rcu() instead of inside a call_rcu() callback, should the doc
comments on DriverFenceData::data and FenceContext::new_fence_allocation() =
be
updated to remove the requirement that T::FenceDataType::drop() only perform
operations legal in atomic context?

> @@ -644,6 +644,10 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCon=
textOps> {
>  ///
>  /// In the unlikely case of such violations, a panic is thrown.
>  ///
> +/// For requirements imposed by the C backend, a [`DriverFence`] might p=
erform
> +/// a call to [`rcu::synchronize_rcu`] when it drops. Thus, avoid droppi=
ng a
> +/// [`DriverFence`] in atomic context.

[Severity: Low]
Because synchronize_rcu is imported directly from kernel::sync::rcu rather
than importing the rcu module, will the intra-doc link to rcu::synchronize_=
rcu
fail to resolve in rustdoc unless written as synchronize_rcu?

[ ... ]

> @@ -973,59 +977,18 @@ fn drop(&mut self) {
>              return;
>          }
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
Can this cause a use-after-free on FenceContext (and its driver_name and
timeline_name fields) if a concurrent RCU reader is in dma_fence_driver_nam=
e()
or dma_fence_timeline_name() when the last fence is signaled and FenceConte=
xt
is dropped?

In DriverFence::drop(), if !core::mem::needs_drop::<T::FenceDataType>() is
true, the function returns early before calling synchronize_rcu():

    if !core::mem::needs_drop::<T::FenceDataType>() {
        unsafe { bindings::dma_fence_put(self.as_raw()) };
        return;
    }

Similarly, if a signaled DriverFence is forgotten or converted via
ForeignOwnable::into_foreign() after DriverFence::signal() has already
decremented nr_of_unsignaled_fences, DriverFence::drop() does not run before
FenceContext can be dropped.

In FenceContext::drop(), the code calls rcu_barrier() to wait for callbacks
from DriverFence::drop():

    // Wait for the RCU callbacks in `DriverFence::drop`.
    rcu_barrier();

However, DriverFence::drop() no longer queues any call_rcu() callbacks, and
rcu_barrier() only waits for pending call_rcu() callbacks rather than waiti=
ng
for an RCU grace period. Should FenceContext::drop() call synchronize_rcu()
instead of rcu_barrier() (and should the comment in FenceContext be updated=
 to
no longer refer to the removed drop_driver_fence_data() function)?

> =20
>          // SAFETY: Valid because `self` is valid.
> -        let rcu_head_ptr =3D unsafe { &raw mut (*self.data.as_ptr()).rcu=
_head };
> +        unsafe { drop_in_place(&raw mut self.data) };

[Severity: High]
Does this leak the T::FenceDataType payload when DriverFence is dropped?

On DriverFence, self.data has type NonNull<DriverFenceData<'a, T>>:

    pub struct DriverFence<'a, T: Send + Sync + FenceContextOps> {
        data: NonNull<DriverFenceData<'a, T>>,
    }

While the user payload is the data field inside DriverFenceData:

    struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
        inner: Fence,
        fctx: &'a FenceContext<T>,
        #[pin]
        data: T::FenceDataType,
    }

Passing &raw mut self.data to drop_in_place() drops the NonNull pointer its=
elf
(which is a no-op) rather than (*self.data.as_ptr()).data, and the subseque=
nt
dma_fence_put() lets C free the allocation via kfree_rcu() without ever
running the destructor of T::FenceDataType. Should this be:

    unsafe { drop_in_place(&raw mut (*self.data.as_ptr()).data) };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150617.5277=
72-2-phasta@kernel.org?part=3D2
