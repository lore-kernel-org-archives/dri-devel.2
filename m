Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C0606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMl4E7BN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF6E10E4D0;
	Tue,  3 Nov 2026 15:44:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C79D10E4D0
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:44:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C574760A7C;
 Tue,  3 Nov 2026 15:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4242F1F000C1;
 Tue,  3 Nov 2026 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793720666;
 bh=7Ahw7uJq3o8c7cJ4EppugyU2ZAFqthKpPx9SdR79/kc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nMl4E7BNI4hJhzu64i6dA1sDuvXlbk8RGad3IQJHVBJxumiT1m7jHChaSuw6lJ/g0
 Ny9T9Ud4pHfin7pMginwFWRgWp1Jah2OE6H/wKHR4+JuxAigaePuw5Gi1+HXgXFLIm
 Y3JA0dgeJpCIhF07iy3OErE0StrZwUIJWPf9qwCcOlZKG1KC1Jiad6rSkIIhZSJjH0
 ywqCFcGhnsvd2XdLkOT3yxSbjH1ZBmh5X9DGvK3ReJBfGo67govShPTh0zvmqSmszQ
 XfspJe2puhe2Bbg6h7mnXOQKkJvZfwcZAQpMqVckTfGuSVQbKKKq8Izo2XsBIGz1FO
 /+diyNhodtCDA==
Message-ID: <sashiko-outbox-195644@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 4/8] rust: DmaFence: Replace call_rcu() with
 synchronize_rcu()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261103153138.1087330-6-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
 <20261103153138.1087330-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:44:25 +0000
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
- [High] rust: dma_fence: payload leak in DriverFence::drop() dropping NonN=
ull wrapper
--

commit 5c06afa6bb1de1d597e5eea16a29dd0b6c6d9220
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Replace call_rcu() with synchronize_rcu()

This commit replaces the deferred RCU callback in DriverFence::drop() with
synchronize_rcu() so that driver fence data is not dropped from atomic
context, and updates FenceContext::drop() to use synchronize_rcu() instead
of rcu_barrier().

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 735c4f090a2c4..fbbc6ab202eca 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> @@ -980,59 +968,18 @@ fn drop(&mut self) {
>              return;
>          }
> =20
> +        // Make sure none of the fence backend_ops can access fence-data=
 anymore.
> +        //
> +        // TODO:
> +        // This would not be necessary if the C dma_fence backend were u=
sing a
> +        // spinlock to properly synchronize its signaled state. Fix it i=
n C and
> +        // then remove synchronize_rcu().
> +        synchronize_rcu();
> +
>          // SAFETY: Valid because `self` is valid.
> -        let rcu_head_ptr =3D unsafe { &raw mut (*self.data.as_ptr()).rcu=
_head };
> +        unsafe { drop_in_place(&raw mut self.data) };
> =20
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

[Severity: High]
As reported by Sashiko on RFC v6 [1], does DriverFence::drop() leak the
T::FenceDataType payload when a DriverFence is dropped?

In DriverFence, self.data has type NonNull<DriverFenceData<'a, T>>, while
the user payload of type T::FenceDataType lives in the inner data field of
DriverFenceData:

rust/kernel/dma_buf/dma_fence.rs:
    struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
        #[pin]
        inner: Fence,
        fctx: &'a FenceContext<T>,
        #[pin]
        data: T::FenceDataType,
    }
    ...
    pub struct DriverFence<'a, T: Send + Sync + FenceContextOps> {
        data: NonNull<DriverFenceData<'a, T>>,
    }

Because self is &mut DriverFence<'a, T>, passing &raw mut self.data to
drop_in_place() passes *mut NonNull<DriverFenceData<'a, T>> rather than
*mut T::FenceDataType. Since NonNull is a Copy pointer wrapper with no Drop
implementation, drop_in_place(&raw mut self.data) is a no-op, and the
subsequent dma_fence_put() releases the underlying allocation without ever
running the destructor for T::FenceDataType.

Should this obtain the raw dma_fence pointer before dropping the inner
payload, and then pass &raw mut (*self.data.as_ptr()).data to
drop_in_place() so that self.as_raw() does not create a shared reference to
DriverFenceData after its data field has been dropped in place?

[1] https://lore.kernel.org/r/20261016085724.1031766-6-phasta@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103153138.1087=
330-2-phasta@kernel.org?part=3D4
