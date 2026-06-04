Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48AFCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B8B11A300;
	Thu,  4 Jun 2026 20:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e/kd1xOT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC2C11A300
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:28:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C235060052;
 Thu,  4 Jun 2026 20:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543651F00893;
 Thu,  4 Jun 2026 20:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604927;
 bh=g9+zGEIKIgJB1amsat4K/QHJ1LTDB19+i1G5jeHXRZ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e/kd1xOTUEtqn9Je1P9QooE/x7I9Nh8T7D+VFIcgh45HU/UtEh0si1yzqsMm0fTVp
 vxkzRgVjBrD9IOzsz9oNNB//QtvkzXWPjAeAuLnTleRbOB+3hsxGCfDY1Z0MP9VeCx
 YwHgtJXkYhwZ6AgGwPsjH7b02RLMy3MJnx1l8gAv3lqIhmernp0q06bP4M2RPT0hQf
 ZcRUNS6IARemialdO7Es6/8w5EyDGaCqBxaeldDpJyUondy6bgzPUcP0vVFahT782F
 73MWrj+rDDmYEQwPVB9azzFzdYMBNj/zzm6FQG6EbfeINYBPQ7gOm2umSoO1wsbLy9
 Zd1SdZZkgLbBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] drm/msm: Fix task_struct reference leak in
 recover_worker
To: "Akhil P Oommen" <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605-assorted-fixes-june-v1-6-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-6-2caa04f7287c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:28:46 +0000
Message-Id: <20260604202847.543651F00893@smtp.kernel.org>
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
- [Critical] Direct access to ctx->vm without lazy initialization via msm_c=
ontext_vm() causes a NULL pointer dereference if ioctls are called before t=
he VM is created.
--

commit 9d77c7114e9006cacfe1802a7ff8d83c9c1a6bac
Author: Jie Zhang <jie.zhang@oss.qualcomm.com>

drm/msm: Fix task_struct reference leak in recover_worker

This commit fixes a missing put_task_struct() in the else branch of
recover_worker. This resolves a task struct reference leak that occurred
on every GPU hang recovery.

> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 48ac51f4119be..03c0578560658 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
[ ... ]
> @@ -505,6 +505,8 @@ static void recover_worker(struct kthread_work *work)
>  		 */
>  		if (!vm->managed)
>  			msm_gem_vm_unusable(submit->vm);
> +
> +		put_task_struct(task);
>  	}
> =20
>  	noreclaim_flag =3D memalloc_noreclaim_save();

[Severity: Critical]
This is a pre-existing issue, but while reviewing context VM usage in this
driver, I noticed that direct access to ctx->vm without lazy initialization
occurs in a few places.

In drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit():

	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");

If a userspace process opens the DRM device and immediately calls the
submit ioctl before the VM is lazily created, won't ctx->vm be NULL here?
Since base is the first element of struct msm_gem_vm, to_msm_vm(NULL)
evaluates to NULL, which would cause an immediate NULL pointer dereference
when accessing ->unusable.

Similarly, in drivers/gpu/drm/msm/msm_gem.c:msm_gem_new_handle():

		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);

Could this also trigger a crash if ctx->vm is NULL, since passing NULL to
drm_gpuvm_resv_obj() expands to dereference ctx->vm directly? Should these
paths be using msm_context_vm() to ensure the VM is initialized first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-assorted-f=
ixes-june-v1-0-2caa04f7287c@oss.qualcomm.com?part=3D6
