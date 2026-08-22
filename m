Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36904C5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 09:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570ED10E3C6;
	Sat, 22 Aug 2026 09:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jIZeV6sx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7DB10E3C6
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 09:03:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0455D600E2;
 Sat, 22 Aug 2026 09:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA311F000E9;
 Sat, 22 Aug 2026 09:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787389430;
 bh=GqODYx6QbS5o44T3EG4htXwGvGQG4186Dg9ND94qIxY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jIZeV6sxWu0hq0ckEyRaDe98xNnmKE4eo9ETtxlwmWt8F37rDYU1WnzhShClvaclw
 eiHQpaRLUOalgu5YdmmEhGMUnP8XxcdWn5c96t3kIdwHik1mDvtbjz75DD+i3Rm171
 kIOBV7WoTUdhTBby2GddHeNi1NbeSjQr8Zm8qfiw5ePzVVNce+a4pJQGn7dV/Ya/oW
 0i1T+piZ7sryUcH8vHdmjXHY5Ztf+TqLo50LY+xcghsw2YhTbp4DGWjb5ZPtyk4Qox
 +s+RIG/N8wnbLT7oFQst/xPAVG/D0kio/sqzixhLU+7ED73/1xmds1NXhF2mGUiS2N
 whAIPXWslz6Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm: factor out a locking put_iova_spaces()
 wrapper
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260822-msm-fix-export-v1-1-917b3cbedd43@oss.qualcomm.com>
References: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
 <20260822-msm-fix-export-v1-1-917b3cbedd43@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:03:49 +0000
Message-Id: <20260822090350.6BA311F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The VMA reference count (`vma_ref`) is decremented and checked=
 outside of the VMA/object lock, leading to a TOCTOU race where an active V=
MA can be unmapped and freed while in use by another thread.
--

--- Patch [1]: [PATCH 1/2] drm/msm: factor out a locking put_iova_spaces() =
wrapper ---
commit 3d4e26e168daef686a19b61570238be2722c0b4d
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: drm/msm: factor out a locking put_iova_spaces() wrapper

This commit factors out a locking put_iova_spaces_locked() wrapper and
updates callers. It aims to clean up redundant lock, tear down, and unlock
sequences around the teardown path.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index de4e60e28a711..8b979d84bb958 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c

[ ... ]

> @@ -105,11 +113,7 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
>  		return;
> =20
>  #ifdef CONFIG_DRM_MSM_KMS
> -	struct drm_exec exec;
> -
> -	msm_gem_lock_vm_and_obj(&exec, obj, priv->kms->vm);
>  	put_iova_spaces(obj, priv->kms->vm, true, "vma_put");
> -	drm_exec_fini(&exec);     /* drop locks */
>  #endif
>  }

[ ... ]

> @@ -408,8 +412,8 @@ static struct drm_gpuva *lookup_vma(struct drm_gem_ob=
ject *obj,
>   * mapping.
>   */
>  static void
> -put_iova_spaces(struct drm_gem_object *obj, struct drm_gpuvm *vm,
> -		bool close, const char *reason)
> +put_iova_spaces_locked(struct drm_gem_object *obj, struct drm_gpuvm *vm,
> +		       bool close, const char *reason)
>  {
>  	struct drm_gpuvm_bo *vm_bo, *tmp;

[Severity: Critical]
This is a pre-existing issue, but can the lockless decrement of vma_ref in
msm_gem_vma_put() cause a race condition?

If CPU1 calls msm_gem_close() -> msm_gem_vma_put() and decrements vma_ref to
0, but gets preempted before taking the lock and calling put_iova_spaces():

CPU2 could concurrently open the GEM object (e.g., via flink), calling
msm_gem_open() -> msm_gem_vma_get(), incrementing vma_ref back to 1,
mapping the object, and submitting a job.

When CPU1 resumes, it continues into put_iova_spaces() and eventually
put_iova_spaces_locked():

drivers/gpu/drm/msm/msm_gem.c:put_iova_spaces_locked() {
        ...
        drm_gpuvm_bo_for_each_va_safe (vma, vmatmp, vm_bo) {
                msm_gem_vma_unmap(vma, reason);
                if (close)
                        msm_gem_vma_close(vma);
        }
        ...
}

Since vma_ref isn't re-checked inside the lock, the IOVA space is torn down
unconditionally. Could this result in tearing down an active IOVA mapping
while the GPU is executing a job, leading to an IOMMU fault or memory
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-msm-fix-ex=
port-v1-0-917b3cbedd43@oss.qualcomm.com?part=3D1
