Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63965606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMl57hJA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C377F112E0F;
	Fri,  6 Nov 2026 14:15:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82CA112E0F
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:15:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10659601E3;
 Fri,  6 Nov 2026 14:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7AC1F0089F;
 Fri,  6 Nov 2026 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974541;
 bh=j51B6uuM0V80Ruk2AchG9gnAIrxoHbi4v3guAJrwD7U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nMl57hJA18ssK9v4tN3cPFio1klSqX5YGFYx4vRRRabBRT4LTGrVWB6Pw7pMV9d/s
 ymEvvuFJT9sj+iyNLLd/vVK8EC9UFN1lYpcK8VGX7x9YvIG1ZTh6nkz6XI3xZ7sogB
 voGwQ0mpCJCkF1SXfO/R2DuSesdOtP7m1sSpuxyRenguRGsYjqYQ5s5n2P/nB2SRKQ
 l+4658fliSRmz7pP9SwmLSO3O5a2gAwHaMqatd+H2OR8zhgGqLQIq2guKcH+kwGOrR
 YZsTNNYQYTsxGcFjyQhiPzkL0zZOutTaSw35gWfe4xxNnerdn1wHbEoZY5zryD4wKO
 N9AtA6AIS6qdQ==
Message-ID: <sashiko-outbox-201554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] rust: DmaFence: Replace call_rcu() with
 synchronize_rcu()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261106140752.520386-6-phasta@kernel.org>
References: <20261106140752.520386-2-phasta@kernel.org>
 <20261106140752.520386-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:15:41 +0000
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
- [High] rust: dma_fence: payload leak in DriverFence::drop() dropping
  NonNull wrapper
--

commit afa4bc5452ca231722f66b50ee2edd5a29c21433
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Replace call_rcu() with synchronize_rcu()

This commit replaces the deferred call_rcu() callback in DriverFence::drop()
and the rcu_barrier() in FenceContext::drop() with synchronous
synchronize_rcu() calls so that driver fence data is not dropped in atomic
context.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index c04b68fe67fe3..f74119b4d7f87 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> @@ -988,59 +980,18 @@ fn drop(&mut self) {
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
Does drop_in_place(&raw mut self.data) leak the user payload
T::FenceDataType on every DriverFence drop?

On DriverFence, self.data is NonNull<DriverFenceData<'a, T>>, which is a
pointer wrapper with no Drop implementation, whereas the user payload lives
in (*self.data.as_ptr()).data.  As a result, drop_in_place(&raw mut
self.data) is a no-op and T::FenceDataType's destructor never runs before t=
he
C backend frees the allocation.

Also, when dropping (*self.data.as_ptr()).data in place, the raw dma_fence
pointer should be obtained before drop_in_place() because self.as_raw()
creates a shared reference &DriverFenceData<'a, T>, which would otherwise
happen after its data field has already been dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106140752.5203=
86-2-phasta@kernel.org?part=3D4
