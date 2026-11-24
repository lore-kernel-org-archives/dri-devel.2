Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53019606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oRtlLKp4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFF010E85F;
	Tue, 24 Nov 2026 12:43:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822D410E85F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:43:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 300B743AD8;
 Tue, 24 Nov 2026 12:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940E01F000CA;
 Tue, 24 Nov 2026 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795524194;
 bh=VbnzHdthd8wpLZrErwwu8ahnEGKiB9uHiBG3M12MCEk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oRtlLKp4u6GPoSWldKj8YI1uKXUY2CmbOB9vRfx7WoYp3UwiuT7+Grex3sFy2IHrF
 kc4gL4P3QXs4S2ugLcRk2tz/GWk2hXTb/2HlnHNCZYaynlgvUW1roZ9ircR/4LF7Ze
 cHTtHF1rwZ/OpvjDEK6Ke77AX93OeN5sSUuwVnGXlQC4Amt07DKav8NBeYaCuT73A+
 a2+CjORC3XYep1jbs8l05xdiy/ZurgVobKW7Jh6ZnTOdZ7xoueOGnD4KT05gpDhAq/
 lIDnaoxLWcVpJ65NiY6wVVs/ls0FXnGAzOBWFjGrUXvAV9+V8lY5hyOXOhAYMSyJbA
 qiUjLJqQ9iv7g==
Message-ID: <sashiko-outbox-231165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] rust: DmaFence: Replace call_rcu() with
 cond_synchronize_rcu()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261124122951.878199-8-phasta@kernel.org>
References: <20261124122951.878199-2-phasta@kernel.org>
 <20261124122951.878199-8-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:43:14 +0000
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
- [High] rust: dma_fence: T::FenceDataType leak in DriverFence::drop()
--

commit feab68d7112ee39624929e1b6780cb4f28b65440
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Replace call_rcu() with cond_synchronize_rcu()

This commit replaces deferred call_rcu() destruction of DriverFence data
with an inline cond_synchronize_rcu() wait in DriverFence::drop() so that
fence payloads are dropped in process context.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index c04b68fe67fe3..20dadbde4eb9d 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> @@ -988,59 +995,31 @@ fn drop(&mut self) {
>              return;
>          }
> =20
> -        // SAFETY: Valid because `self` is valid.
> -        let rcu_head_ptr =3D unsafe { &raw mut (*self.data.as_ptr()).rcu=
_head };
> +        // SAFETY: `self` is valid. No one can access the cookie anymore=
 because
> +        // we are dropping.
> +        let rcu_cookie =3D unsafe { *self.data.as_ref().synchronize_rcu_=
cookie.get() };
> =20
> -        // SAFETY: `call_rcu()` is always safe to be called. `rcu_head_p=
tr` was
> -        // created validly above. The module must perform a `synchronize=
_rcu()`
> -        // or `rcu_barrier()` call to guard against module unload.
> -        unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence=
_data::<T>)) };
> -    }
> -}
> +        // Make sure none of the fence backend_ops can access fence-data=
 anymore.
> +        //
> +        // TODO:
> +        // This would not be necessary if the C dma_fence backend were u=
sing a
> +        // spinlock to properly synchronize its signaled state. Fix it i=
n C and
> +        // then remove synchronize_rcu().
> +        if rcu_cookie !=3D 0 {
> +            // SAFETY: The if-else checks whether the cookie was validly
> +            // initialized when this fence signaled.
> +            unsafe { cond_synchronize_rcu(rcu_cookie) };
> +        } else {
> +            // The user never signaled this fence. We don't know the gra=
ce period.
> +            synchronize_rcu();
> +        }
> =20
> -// TODO:
> -// The entire call_rcu() mechanism in the drop above and the code below =
would be
> -// unnecessary if C's dma_fence_signal() could be reworked in a way that=
 after it
> -// ran, the caller knows that no fence_ops callbacks can be running anym=
ore.
> -// In other words, if the dma_fence backend would use its spinlock for f=
ull
> -// synchronization.
> -//
> -// Then we could move the drop_in_place() and dma_fence_put() upwards in=
to the
> -// drop() implementation and call it a day.
> +        // SAFETY: Valid because `self` is valid. RCU above ensures that=
 all
> +        // accessors are gone.
> +        unsafe { drop_in_place(&raw mut self.data) };
> =20
> -/// Finally really drop this `DriverFence<T>`
> -///
> -/// # Safety
> -///
> -/// `head` references the `rcu_head` field of an `DriverFenceData<T>`. A=
ll
> -/// accessors to that `DriverFenceData<T>` must be gone by now. This mus=
t be
> -/// ensured by signalling the associated `DriverFence<T>` and then waiti=
ng
> -/// for a grace period until calling this function here.
> -unsafe extern "C" fn drop_driver_fence_data<T: Send + Sync + FenceContex=
tOps>(
> -    head: *mut bindings::callback_head,
> -) {
> -    // SAFETY: Caller provides a pointer to the `rcu_head` field of a `D=
riverFenceData<C>`.
> -    let fence_data =3D unsafe { container_of!(head, DriverFenceData<'_, =
T>, rcu_head) };
> -
> -    // SAFETY: `fence_data` was created validly above. All the fence's d=
ata will
> -    // only drop below, but the raw pointer to the raw C `dma_fence` rem=
ains
> -    // valid because the reference count is only decremented at the end =
of the
> -    // function.
> -    let fence =3D unsafe { (*fence_data).inner.inner.get() };
> -
> -    // SAFETY: `fence_data` was created validly above. The user has alre=
ady
> -    // dropped the only conventional accessor to the user data, the `Dri=
verFence`,
> -    // one grace period ago. All accessors are gone now.
> -    unsafe { drop_in_place(&raw mut (*fence_data).data) };
> -
> -    // The inner `Fence` explicitly does not get dropped because there m=
ay be
> -    // many more users / consumers, each holding their own reference.
> -
> -    // SAFETY: Once a `DriverFence` is initialized, the inner `fence` is=
 valid
> -    // and initialized. It is valid until the refcount drops to 0, which=
 can
> -    // earliest happen once we drop the `DriverFence`'s reference here.
> -    unsafe { bindings::dma_fence_put(fence) };
> -
> -    // The actual memory the data associated with a `DriverFence` lives =
in
> -    // gets freed by the C dma_fence backend once the fence's refcount r=
eaches 0.
> +        // SAFETY: Valid because `self` is valid. This is the initial re=
ference
> +        // from when this `DriverFence` was created.
> +        unsafe { bindings::dma_fence_put(self.as_raw()) };
> +    }
>  }

[Severity: High]
Does drop_in_place(&raw mut self.data) leak the inner T::FenceDataType
payload?

self.data on DriverFence is a NonNull<DriverFenceData<'a, T>>, which has no
Drop implementation, so drop_in_place(&raw mut self.data) is a no-op and
(*self.data.as_ptr()).data is never dropped before dma_fence_put() releases
the allocation.  Note also that self.as_raw() creates a shared reference
&DriverFenceData<'a, T>, so the raw dma_fence pointer should be obtained
before dropping (*self.data.as_ptr()).data in place.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124122951.8781=
99-2-phasta@kernel.org?part=3D6
