Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BC1C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E907210E027;
	Wed, 29 Jul 2026 16:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B9+N9wa0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF20210ECE4
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:21:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B75E94097F;
 Wed, 29 Jul 2026 16:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED271F00A3A;
 Wed, 29 Jul 2026 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785342118;
 bh=6rtOLK4krP5iJSAx96VvPByMSxCnl7tfpe9qJhHsets=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B9+N9wa0KfDAxjSJGz9FrcerrY1V0wiU4NchrmGeFlOf1F8XPjVLb5Q6p93ErFJPy
 Rh6Q88q5fmCIojDQM1KYX72GDpZmWJbJhsqiEYU2y7vRGRZYWYmoKuorTWO2rqbScw
 T72tXGAGA4INr41o3goiRkjZZr32AcKhNC2jWlYtsOCAN92FIH80MD75QQBTXDrWfp
 oNfUxd7uOfg8yKXw7I8ZnaJH5zp0q1QPtcOYupxtLpEXlnY9flbXgGT/3MUz8D1yfq
 24+xN6AUMi+oArIhD6KoDglpZiu0JSDoO7oge6xFU8Ma5jpcdnYj3Q1V14QwfoCG7c
 s6e9VMBjb1h4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/17] drm/msm: Allow lazy VM creation to fail
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-15-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-15-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:21:58 +0000
Message-Id: <20260729162158.6ED271F00A3A@smtp.kernel.org>
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
- [Critical] Bypass of per-process pgtable support check in adreno_set_para=
m for MSM_PARAM_EN_VM_BIND
--

--- Patch [14]: [PATCH v7 14/17] drm/msm: Allow lazy VM creation to fail ---
commit 4152ad8d83f2b59969c7edf51ff58a105d0b46bf
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Allow lazy VM creation to fail

This commit updates the driver to handle failures during lazy VM creation,
returning ENOMEM or EPIPE instead of silently proceeding without a VM.
It modifies various entry points like gem_submit, vm_bind, and submitqueue
creation to validate the VM pointer.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 5738eac9aebd6..84101e534ebef 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -359,7 +359,7 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigne=
d long iova, int flags,
>  static bool
>  valid_per_process_vm(struct msm_gpu *gpu, struct drm_gpuvm *vm)
>  {
> -	return (vm !=3D gpu->vm);
> +	return vm && (vm !=3D gpu->vm);
>  }
> =20
>  int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,

[Severity: Critical]
This is a pre-existing issue, but while reviewing the VM validation changes
in this file, I noticed a potential check bypass in adreno_set_param().

If a platform lacks per-process pgtable support, lazy initialization means
ctx->vm will be NULL when adreno_set_param() is called.

Because ctx->vm is NULL, the following check:

    if (ctx->vm =3D=3D gpu->vm)
            return UERR(EINVAL, drm, "requires per-process pgtables");

will evaluate to false. It will then pass the second check:

    if (ctx->vm)
            return UERR(EBUSY, drm, "VM already created");

and successfully set ctx->userspace_managed_vm to the requested value.

When the VM is later lazily created via msm_context_vm(), it falls back to
the global gpu->vm, improperly setting up the global VM as a VM_BIND queue.

Does this allow userspace to opt into VM_BIND functionality on a global,
kernel-managed GPU VM?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D14
