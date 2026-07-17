Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99930C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009BC10F62B;
	Fri, 17 Jul 2026 21:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P56fiLul";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09C710F629
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:07:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C012842A1A;
 Fri, 17 Jul 2026 21:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D311F000E9;
 Fri, 17 Jul 2026 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322435;
 bh=Meno9IWS79Kr4llWaiaWhHtFuMcBoCKuVjYSfmsK5pU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P56fiLulyr9C6dlHMvji2LLVBet5JdMJfpsMhDIhiPP/cXRZNwBXS7DCDl6jR79dc
 n/wCcIVP9WUDJW3Ouo/eJvzI26/dBY4hK6GoBuaTZScNoaOYU34k63HvbeYMXOiEX3
 TUbHTsW00eHiT0PmBOEFcHnWwrQ5KctmBV4yKQUSp48lPcdWUOkJDEaw7EtGKl0DTP
 dTD2ZXoZvoHjfPHlrV9cXiFZ4XPcR8B85t02KoGBHkMpsjNktKy5z6Hwky6DIuOSS2
 ylNzRWzICtUrQorLQOyDJfCxFb1QhWKmq/yljFNLgLK1HPSTCXDFsIoYvFpE5c131T
 S10hHzXxfwf6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/16] drm/msm: Fix barriers accessing ctx vm
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-2-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:07:14 +0000
Message-Id: <20260717210715.81D311F000E9@smtp.kernel.org>
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
- [Critical] Direct access to ctx->vm before lazy initialization causes a N=
ULL pointer dereference.
- [High] TOCTOU race in MSM_PARAM_EN_VM_BIND allows invalid VM configuratio=
n.
--

--- Patch [1]: [PATCH v6 01/16] drm/msm: Fix barriers accessing ctx vm ---
commit ca8b3357d768cc8c8e48035f7adbc82abd4eb8c7
Author: Rob Clark <robin.clark@oss.qualcomm.com>

    drm/msm: Fix barriers accessing ctx vm
   =20
    Don't rely on store ordering to protect us from caller seeing a
    partially initialized vm.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 79f78e7e16e9d..3c8b5083a1fbe 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -225,18 +225,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device =
*dev, struct msm_context *ctx
>  {
>  	static DEFINE_MUTEX(init_lock);
>  	struct msm_drm_private *priv =3D dev->dev_private;
> +	struct drm_gpuvm *vm =3D smp_load_acquire(&ctx->vm);
> =20
>  	/* Once ctx->vm is created it is valid for the lifetime of the context:=
 */
> -	if (ctx->vm)
> -		return ctx->vm;
> +	if (vm)
> +		return vm;
> +
> +	guard(mutex)(&init_lock);
> =20
> -	mutex_lock(&init_lock);
>  	if (!ctx->vm) {
> -		ctx->vm =3D msm_gpu_create_private_vm(
> +		vm =3D msm_gpu_create_private_vm(
>  			priv->gpu, current, !ctx->userspace_managed_vm);
> -
> +		smp_store_release(&ctx->vm, vm);
>  	}
> -	mutex_unlock(&init_lock);
> =20
>  	return ctx->vm;
>  }

[Severity: Critical]
This is a pre-existing issue, but I noticed that ctx->vm can be accessed=20
directly before lazy initialization. If an unprivileged user opens the DRM=
=20
device and immediately calls the MSM_GEM_SUBMIT IOCTL, it evaluates=20
to_msm_vm(ctx->vm)->unusable without ensuring the VM has been initialized v=
ia=20
msm_context_vm():

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
    ...
	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");
    ...
}

Since ctx->vm is NULL, the to_msm_vm() macro computes an invalid pointer an=
d=20
dereferences its unusable field, causing a panic.

Similarly, calling the MSM_GEM_NEW IOCTL with the MSM_BO_NO_SHARE flag=20
executes drm_gpuvm_resv_obj(ctx->vm) which also dereferences NULL:

drivers/gpu/drm/msm/msm_gem.c:msm_gem_new_handle() {
    ...
	if (flags & MSM_BO_NO_SHARE) {
		struct msm_context *ctx =3D file->driver_priv;
		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);
    ...
}

Can these paths be updated to ensure the VM is initialized via=20
msm_context_vm() before accessing it?


[Severity: High]
This isn't a bug introduced by this patch, but I found a potential TOCTOU=20
race in MSM_PARAM_EN_VM_BIND that could allow an invalid VM configuration.=
=20

In adreno_gpu_set_param(), it locklessly checks if (ctx->vm):

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_gpu_set_param() {
    ...
	case MSM_PARAM_EN_VM_BIND:
        ...
		if (ctx->vm)
			return UERR(EBUSY, drm, "VM already created");

		ctx->userspace_managed_vm =3D value;
    ...
}

If Thread A calls the MSM_SET_PARAM IOCTL, checks ctx->vm and sees NULL, an=
d=20
concurrently Thread B calls an IOCTL like MSM_INFO_GET_IOVA which calls=20
msm_context_vm(), Thread B will create the VM as kernel-managed. Thread A=20
then resumes and sets ctx->userspace_managed_vm =3D 1.=20

Does this result in an inconsistent state where the context claims userspac=
e=20
management but the underlying VM is kernel-managed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D1
