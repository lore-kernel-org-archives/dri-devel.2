Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D698DCD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4137B11A6B6;
	Fri,  5 Jun 2026 09:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q21k24N+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B4F11A6B6
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 09:58:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34BA744196;
 Fri,  5 Jun 2026 09:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07411F00893;
 Fri,  5 Jun 2026 09:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780653485;
 bh=CuydSkOLMkLBOKxfQ4VdgcTdXJRdoV7U01NgKcIChTs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q21k24N+dcLeEk2pO08n3uhfodoQKp8KOhhxLJnI8a5cxwkaRB8zBilOROyZGX4wk
 Org/UyEhO8HM2y5b/JiU8UOBMhaZ0JryEB9AmN5xUgvhF+WWzMKw8mkPK+S8GcHALT
 iiLpX/12VAExoliA/H9mTyI2KxiV32jVuh/qU7AB8gyPwmDJ+fOncmHlzgi0WsoVWT
 jmW/EW7knclltlbRnGpP6J1lxPQIo+zQJOQ1+uZqBH0MPDmrjeZwPXUw+3kITooMFo
 fpGooRoZveRRXffdBJH6AieHU91njAMmURIIAlbTk6XehCp/lQRbn5oaf12xnNitpW
 aC52OBsPbUIlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix refcount leak in amdgpu_ttm_clear_buffer()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605094827.7982-1-vulab@iscas.ac.cn>
References: <20260605094827.7982-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 09:58:04 +0000
Message-Id: <20260605095804.F07411F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unconditional clearing of the output `*fence` in `amdgpu_ttm_c=
lear_buffer` causes a guaranteed NULL pointer dereference in `amdgpu_bo_cre=
ate`.
--

commit f32c06ed28183e8d1c9d0dd64a83a68252d25f63
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/amdgpu: fix refcount leak in amdgpu_ttm_clear_buffer()

This commit attempts to fix a fence reference leak in the error path of
amdgpu_ttm_clear_buffer() by putting the fence and setting it to NULL.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 3d2e00efc7415..d65f1df3574fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c

[ ... ]

> @@ -2585,6 +2585,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>  	}
>  err:
>  	mutex_unlock(&entity->lock);
> +	dma_fence_put(*fence);
> +	*fence =3D NULL;

[Severity: Critical]
Does this unconditionally clear the output fence even on the success path?=
=20

The loop naturally falls through to the err: label when it completes
successfully with r =3D 0. Since the cleanup isn't guarded by an error chec=
k,
the output fence is always destroyed and set to NULL.

If the clear operation is successful, won't this cause a NULL pointer
dereference when the caller uses the fence? For example, in the buffer
creation path:

amdgpu_bo_create() {
	r =3D amdgpu_ttm_clear_buffer(bo, bo->tbo.base.resv, &fence);
	if (unlikely(r))
		goto fail_unreserve;

	dma_resv_add_fence(bo->tbo.base.resv, fence, DMA_RESV_USAGE_KERNEL);
}

The caller will see r =3D 0 but have a NULL fence. Passing that NULL fence =
into
dma_resv_add_fence() will cause an immediate NULL pointer dereference when =
it
checks WARN_ON(dma_fence_is_container(fence)).

Should this cleanup be guarded with if (r) to ensure we only drop the fence
reference on actual failures?

> =20
>  	return r;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605094827.7982=
-1-vulab@iscas.ac.cn?part=3D1
