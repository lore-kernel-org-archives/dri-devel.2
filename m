Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF24C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A764210E8AB;
	Mon,  6 Jul 2026 10:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AmqfbM+4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F98810E8AB
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:41:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1557600DA;
 Mon,  6 Jul 2026 10:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8639E1F000E9;
 Mon,  6 Jul 2026 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783334472;
 bh=Aq+MpksnE6d2w74LKL6MkUpA/ESJhyntj370FAKAMic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AmqfbM+4KIOVdmq9g91vcpvE981pcBMrWLa0A0y1xA0oIeqHUFT6YGQsFCAUMP0cv
 8ba1Zj2OBIZjil7qpOuRmS3RAewieN0mcdmNwM2fUqdY8IoACaUhklhF/pI513q7vN
 oXMMfP42Wj3S3rmOcVFnMkmmcUmFXyGXeRZzLyAgVVMow4ybJpYCTGO5EyNuQW2Doo
 RsN0QpivCYsLUVADJAVc9mHVPZe5+9Aj4zgiC+f9nk7k81CcrVNYilcZcZYKJbmX2F
 C3uN8FbNPCgoo5f56WhwS/meANFY5EOgUp+EDY4FZqrCIIA9lu79jThVFd1GbU5ZWa
 iWQP66wYD60PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] drm/amdgpu: use drm_exec during BO validation
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-ttm_2_drm_exec-v2-10-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
 <20260706-ttm_2_drm_exec-v2-10-4bf6bfc0d320@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:41:12 +0000
Message-Id: <20260706104112.8639E1F000E9@smtp.kernel.org>
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
- [High] Resource Accounting Leak / Throttle Bypass via loop state reset
- [High] Eviction Ping-Pong and Mass Locking via blind `drm_exec` iteration
--

commit 55fa3886644544ae8f5e3d97c8a80ceba452b3ca
Author: Natalie Vock <nat@pixelcluster.dev>
Subject: drm/amdgpu: use drm_exec during BO validation

This commit updates the BO validation in amdgpu_cs to use drm_exec, aiming
to prevent deadlocks caused by resource constraints and avoid sporadic
-ENOMEM issues when using GDS.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index c2e6495a28bc5..052d41013f7a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -793,7 +793,7 @@ static int amdgpu_cs_bo_validate(void *param, struct =
amdgpu_bo *bo)
>  	struct ttm_operation_ctx ctx =3D {
>  		.interruptible =3D true,
>  		.no_wait_gpu =3D false,
> -		.resv =3D bo->tbo.base.resv
> +		.exec =3D &p->exec,
>  	};
>  	uint32_t domain;
>  	int r;

[Severity: High]
Does setting .exec to &p->exec cause TTM to add evicted victim buffers to t=
he
transaction's locked object list?

If so, later when drm_exec_for_each_locked_object() iterates over all
objects in p->exec, will it inadvertently re-validate these victim BOs
and attempt to move them back into VRAM?

[ ... ]

> @@ -922,47 +923,53 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pa=
rser *p,
>  			if (unlikely(r))
>  				goto out_free_user_pages;
>  		}

[ ... ]

> -	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
> -					  &p->bytes_moved_vis_threshold);
> -	p->bytes_moved =3D 0;
> -	p->bytes_moved_vis =3D 0;
> -
> -	r =3D amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
> -			       amdgpu_cs_bo_validate, p);
> -	if (r) {
> -		drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
> -		goto out_free_user_pages;
> -	}
> +		amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
> +						  &p->bytes_moved_vis_threshold);
> +		p->bytes_moved =3D 0;
> +		p->bytes_moved_vis =3D 0;

[Severity: High]
Is it intentional to unconditionally reset these accumulators inside the
retry loop?

Since this block is inside the drm_exec_until_all_locked() loop, if a later
validation causes WW lock contention and triggers a retry, the loop will
restart and these counters will be zeroed.

Because TTM does not rollback physical moves when dropping locks, this
appears to discard the accounting for BOs that were already moved,
potentially bypassing the migration bandwidth throttle.

> -	drm_exec_for_each_locked_object(&p->exec, obj) {
> -		r =3D amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
> -		if (unlikely(r))
> +		r =3D amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
> +				       amdgpu_cs_bo_validate, p);
> +		drm_exec_retry_on_contention(&p->exec);
> +		if (r) {
> +			drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
>  			goto out_free_user_pages;
> +		}
> +
> +		drm_exec_for_each_locked_object(&p->exec, obj) {
> +			r =3D amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
> +			drm_exec_retry_on_contention(&p->exec);
> +			if (unlikely(r))
> +				goto out_free_user_pages;
> +		}

[Severity: High]
Could this iteration cause an eviction ping-pong?

Because TTM eviction adds victim buffers to p->exec, this loop will
iterate over those newly added victims. amdgpu_cs_bo_validate() might
then see the victim's preferred domains and try to move it back into
VRAM, forcing another eviction and trapping the validation in an infinite
loop until the threshold is hit or VRAM is exhausted.

> +
> +		amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
> +					     p->bytes_moved_vis);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-ttm_2_drm_=
exec-v2-0-4bf6bfc0d320@pixelcluster.dev?part=3D10
