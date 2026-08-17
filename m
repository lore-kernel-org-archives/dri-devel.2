Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A5EC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C013010E7A8;
	Mon, 17 Aug 2026 17:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RS/K17pp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5C910E7A8
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:31:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61061600AE;
 Mon, 17 Aug 2026 17:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C311F000E9;
 Mon, 17 Aug 2026 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786987911;
 bh=CKN+q9tl7lYQI8ZJfGj6rsvGpVNeb9NI0bd+MDRTfck=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RS/K17ppXCbPL9BgwgLzJXDYsPnWtqDtA55DpmT0SMp8vu91GCp1egvMuS8SqDbdh
 mov88INkrje32MQxB35pHAvC/6mN4qFXYpkQocpSlMMThdX5SjAeG+3ymadYZPXwC7
 Irou67FJNEmIlaltp/Q3b16zQmigBL3NC6861baxYSX02HVH37/P0gPWUa6YI9vStm
 S+kzGVysjDRb7q2NyR1z3SNzlY32FHq+jyGKAqDxJGOjB/j+XKH/cd1pJwuOfaUGVs
 nTN7VmbIq3anKjgNcDDGNzMD7yWhdKSQ6TSJLvPlYFgF6tvzSozKcru5WytgpDT9K6
 kKm68r4qCebxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] drm/gpuvm: Route gpuva_op allocations to
 folio_scratchpad
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org
In-Reply-To: <20260817-folio-pool-v1-v1-4-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-4-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:31:50 +0000
Message-Id: <20260817173150.D1C311F000E9@smtp.kernel.org>
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
- [High] Unbounded memory leak of transient `struct drm_gpuva_op` objects d=
ue to bump allocator usage without intermediate resets.
- [Low] Undeclared static key variable 'gpuvm_scratchpad_key' used in drm_g=
puvm_init().
--

--- Patch [4]: [PATCH 4/9] drm/gpuvm: Route gpuva_op allocations to folio_s=
cratchpad ---
commit 6e27181fef6cb87688764c9745ab2086b2091e88
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: drm/gpuvm: Route gpuva_op allocations to folio_scratchpad

This commit modifies the DRM GPUVM subsystem to route default gpuva_op
allocations to a folio scratchpad embedded in struct drm_gpuvm. It updates
gpuva_op_alloc() to use folio_scratchpad_alloc_obj() and handles the bulk
teardown during drm_gpuvm_fini().

> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -1109,6 +1109,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char =
*name,
>  	spin_lock_init(&gpuvm->evict.lock);
> =20
>  	init_llist_head(&gpuvm->bo_defer);
> +	folio_scratchpad_init_key(&gpuvm->va_scratchpad, get_order(SZ_64K),
> +				  &gpuvm_scratchpad_key);

[Severity: Low]
Does this cause a compilation failure?

In drm_gpuvm_init(), the code references gpuvm_scratchpad_key, but this
static key is not defined until later in the file via the
DEFINE_FOLIO_POOL_STATIC_KEY_PARAM macro.

[ ... ]

> @@ -2814,7 +2820,8 @@ gpuva_op_alloc(struct drm_gpuvm *gpuvm)
>  	if (fn && fn->op_alloc)
>  		op =3D fn->op_alloc();
>  	else
> -		op =3D kzalloc_obj(*op);
> +		op =3D folio_scratchpad_alloc_obj(gpuvm, va_scratchpad,
> +						struct drm_gpuva_op, GFP_KERNEL);
> =20
>  	if (unlikely(!op))
>  		return NULL;
> @@ -2831,7 +2838,7 @@ gpuva_op_free(struct drm_gpuvm *gpuvm,
>  	if (fn && fn->op_free)
>  		fn->op_free(op);
>  	else
> -		kfree(op);
> +		folio_scratchpad_free_elem(op);
>  }

[Severity: High]
Will this cause an unbounded memory leak for long-lived VMs?

In gpuva_op_alloc(), struct drm_gpuva_op objects are allocated using
gpuvm->va_scratchpad, which acts as a bump allocator. However, the
folio_scratchpad_free_elem() called here in gpuva_op_free() cannot reclaim
individual elements from a scratchpad bump allocator.

Since the memory is only fully reclaimed during bulk teardown in
drm_gpuvm_fini(), and these objects are transiently allocated per map/unmap
operation, could this result in continuous memory leakage over the lifetime
of the GPU VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D4
