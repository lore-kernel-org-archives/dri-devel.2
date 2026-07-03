Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48918C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84CB910F865;
	Fri,  3 Jul 2026 17:24:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hTBS2Lvb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF66F10F865
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 17:24:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5395260051;
 Fri,  3 Jul 2026 17:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6201F000E9;
 Fri,  3 Jul 2026 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783099442;
 bh=fTHh3/N3r4a6memjeXPrzyD5DLcC1v/7H9m4zQC+Gb0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hTBS2LvbuNoPlv5q6mAmUDX406t2aO+AeHVyXdJlBMPxSnVIG5809ThiEekKQ9Jrs
 4H8FOnl+UKtH+uZZRZ5wgXRTWDc7jy9l5uxFK/3yqXylsKF26mfJaV5QA+kmqTnhyk
 dx4KvG4a8/zzTSdphHhyMXBxl8LkBYQX5WwUCjuIMCVPsIcaB2Q64BHHAVEw/3reDd
 xbnZNj3i8Fv9k/+bWl9GAlfko9VTuNmE/5Zi4/A6X7GTxH90bBOSi9bK0YZ7g5rBll
 jb3BnIvyUFbrpwXVVQYYGsqMDcN1H9F0ec1CtwCmbJRkPflV9phW73OR2ppOZjYc0p
 eOER8aKrJXJ5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] drm/amdgpu: use drm_exec during BO validation
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-ttm_2_drm_exec-v1-10-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-10-43685ac1286b@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:24:01 +0000
Message-Id: <20260703172401.CF6201F000E9@smtp.kernel.org>
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
- [High] Iterating over `p->exec` objects for validation inadvertently vali=
dates victim BOs that were just evicted, breaking VRAM overcommit.
- [Medium] Buffer migration budget is bypassed when a submission retries du=
e to lock contention.
--

commit 106f3922010dddea6e74f4d9b1260b3b5ba91adf
Author: Christian K=C3=B6nig <christian.koenig@amd.com>

drm/amdgpu: use drm_exec during BO validation

This commit modifies the CS parser BO validation sequence to use the
drm_exec infrastructure, aiming to detect and handle deadlocks caused by
resource constraints during eviction.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index c2e6495a28bc5..052d41013f7a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c

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

[Severity: Medium]
If a submission physically moves buffers but then hits lock contention later
in the execution, drm_exec_retry_on_contention() will restart the
drm_exec_until_all_locked() loop.

Does resetting p->bytes_moved and p->bytes_moved_vis to 0 here cause the
driver to lose track of the bytes already moved during the aborted pass?

When the retry finally succeeds, it appears amdgpu_cs_report_moved_bytes()
will only report the final pass, which might bypass the migration budget
throttling logic and leak the physical migration costs already incurred.

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

[Severity: High]
When TTM evicts a buffer, does it use ctx.exec (which now points to p->exec
after this patch) to lock the victim BO?

If so, it seems the victim BO gets added to the p->exec locked objects list.
Since this drm_exec_for_each_locked_object() loop blindly iterates over all
objects in p->exec, won't it inadvertently validate the newly evicted victim
BO as well?

Calling amdgpu_cs_bo_validate() on the victim could attempt to move it back
to its preferred domain in VRAM, which seems like it would defeat the evict=
ion
entirely and potentially break VRAM overcommit.

> +			drm_exec_retry_on_contention(&p->exec);
> +			if (unlikely(r))
> +				goto out_free_user_pages;
> +		}
> +
> +		amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
> +					     p->bytes_moved_vis);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-ttm_2_drm_=
exec-v1-0-43685ac1286b@gmx.de?part=3D10
