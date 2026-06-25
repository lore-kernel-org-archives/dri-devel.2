Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2BCCDE009
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4766910E262;
	Thu, 25 Jun 2026 19:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M/WS9YL8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DBF10E260
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:28:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 655FF43F07;
 Thu, 25 Jun 2026 19:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AA81F000E9;
 Thu, 25 Jun 2026 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782415712;
 bh=is01nkzlY7pr4Zy++qoPG2AGN3jNPbabO8zUkNXVCPc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M/WS9YL8FQnl7+Cyne0JiXYWcHNJV5pcpmVb8DLL17TVEWPvOFlbM2q77neaHiLSC
 VqnxvcxjGEnQrAnsEpBi7XoUb/wMEfuvV+43N7Wp6lFFwSDe69O+eg7vGh7QQ8RSy2
 ND3/gSf4bKXJsfoP92I5YsBwe65PtFFRrjbzBB8lMRTX5oTtdTVuW/8OpjrNmy/MpY
 dvFnkrD1BXPepUhub2pZXzpN3PSzKqNKJOssY4QeLQw3t0mLvwFc835AEHkiMF2kIB
 PiCiDc3uUO7xauTcrKEMjZVeCKlXgUprFE9Ko3x3Rp8OL26BtETJrJJDrt9Z9cOh1c
 h/VejgWZ/DjLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/msm: Fix barriers accessing ctx vm
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625191537.47965-2-robin.clark@oss.qualcomm.com>
References: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
 <20260625191537.47965-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 19:28:31 +0000
Message-Id: <20260625192832.16AA81F000E9@smtp.kernel.org>
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
- [High] Direct access to uninitialized `ctx->vm` in `adreno_set_param` byp=
asses validation, allowing `VM_BIND` on global VMs.
--

commit be0b70b2e7a9f55182d48578fb53358469060fcb
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Fix barriers accessing ctx vm

This commit adds load-acquire and store-release barriers when accessing
and lazily initializing ctx->vm in msm_context_vm(). This prevents callers
from seeing a partially initialized virtual memory state.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 32d5ebea2596f..ec88155e0ed72 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -224,18 +224,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device =
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

[Severity: High]
This isn't a bug introduced by this patch, but seeing the fixes to ctx->vm
lazy initialization here points to a related problem in adreno_set_param().

Looking at adreno_set_param() in drivers/gpu/drm/msm/adreno/adreno_gpu.c,
there is this check when enabling VM_BIND:

    if (ctx->vm =3D=3D gpu->vm)
        return UERR(EINVAL, drm, "requires per-process pgtables");

Since ctx->vm starts as NULL and is lazily initialized, couldn't this
check fail to catch global VMs (since NULL !=3D gpu->vm) if msm_context_vm()
hasn't been called yet?

If unprivileged userspace opts into VM_BIND mode before the VM is
initialized, could this bypass the validation check on platforms without
per-process pagetables, potentially allowing arbitrary mapping in the
global GPU address space?=20

Should this be using msm_context_vm(dev, ctx) instead to ensure the
VM is instantiated before checking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625191537.4796=
5-1-robin.clark@oss.qualcomm.com?part=3D1
