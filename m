Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CEDC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696FA10ECE1;
	Wed, 29 Jul 2026 16:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CZ+NWejb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8E010ECE1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:12:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C00341774;
 Wed, 29 Jul 2026 16:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121C81F00A3A;
 Wed, 29 Jul 2026 16:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785341533;
 bh=OsoCDgIp2mQLWpjaIS74a0iK6I/On/yJkMt7CbVF4Vo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CZ+NWejbYBSejPTo4to8hQ2GJea/D4SDZHLQENFa9tTazeV86rl+OSjealxKhfZrg
 M7ubg+FEESGBXAhplY+eisIRaofc3R/wgtfwJ73RKwMvwSOshbguVrQ5IrXmRbbtnB
 PwhBdk8gE1AnrVHmrAePOpzZkZ+OFFHtfeuVOXxPD2pqjE7IAThFWuBGEuyGkP3zIo
 YjN7rtAD1Nl+ef28k1gktvHy5ZAmAekKutoT0caPogjAy3v60oOk8IqUbGYuINTRkn
 gi9cg6PGTbmr8NNCu6hdJcAkiRi9l46BTwxTLNhRqRi68NL1pqxRrulhjYJuiaUczM
 S9zH5ciJXE3Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/17] drm/msm/a6xx: Access VM directly in submit path
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-8-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-8-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:12:12 +0000
Message-Id: <20260729161213.121C81F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Direct access to ctx->vm in ioctl entry point without precedin=
g call to msm_context_vm() causes NULL pointer dereference.
- [High] Unchecked ERR_PTR assignment from msm_context_vm() leads to kernel=
 crash in submit_lock_objects().
--

--- Patch [7]: [PATCH v7 07/17] drm/msm/a6xx: Access VM directly in submit =
path ---
commit fb968654323d1792a0d26ac37c9d0a8e1d71c1dd
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a6xx: Access VM directly in submit path

The GEM_SUBMIT ioctl has already ensured that the VM is created, so we
aren't expecting to lazily create the VM this deep into the ioctl.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index e293b4ca808a4..9240c4af687c9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -229,7 +229,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_=
gpu,
>  {
>  	bool sysprof =3D msm_gpu_sysprof_no_perfcntr_zap(&a6xx_gpu->base.base);
>  	struct msm_context *ctx =3D submit->queue->ctx;
> -	struct drm_gpuvm *vm =3D msm_context_vm(submit->dev, ctx);
> +	struct drm_gpuvm *vm =3D ctx->vm;

[Severity: Critical]
This is a pre-existing issue, but since the commit message mentions that
the GEM_SUBMIT ioctl has already ensured that the VM is created, I wanted to
ask about msm_ioctl_gem_submit().

Looking at msm_ioctl_gem_submit() in drivers/gpu/drm/msm/msm_gem_submit.c, =
it
accesses ctx->vm directly:

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
    ...
	if (args->pad)
		return -EINVAL;

	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");
    ...
}

Can this cause a NULL pointer dereference if an unprivileged user creates a
legacy submit queue without VM_BIND and immediately calls the submit ioctl?
The VM is initialized lazily, so it seems ctx->vm could be NULL here if we
haven't called msm_context_vm() first.

[Severity: High]
This is another pre-existing issue, but I wanted to check how we handle VM
allocation failures in the submit path.

In submit_create() in drivers/gpu/drm/msm/msm_gem_submit.c:

drivers/gpu/drm/msm/msm_gem_submit.c:submit_create() {
    ...
	submit->vm =3D msm_context_vm(dev, queue->ctx);
    ...
}

msm_context_vm() can return an ERR_PTR(-ENOMEM). Later in the same ioctl,
submit_lock_objects() unconditionally dereferences it:

drivers/gpu/drm/msm/msm_gem_submit.c:submit_lock_objects() {
    ...
	drm_exec_until_all_locked (&submit->exec) {
		ret =3D drm_exec_lock_obj(&submit->exec,
					drm_gpuvm_resv_obj(submit->vm));
    ...
}

Does submit->vm need an IS_ERR() check after calling msm_context_vm() to
prevent a kernel crash if the VM allocation fails?

>  	struct adreno_gpu *adreno_gpu =3D &a6xx_gpu->base;
>  	phys_addr_t ttbr;
>  	u32 asid;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D7
