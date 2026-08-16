Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7557FC5DF66
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D24710E34D;
	Sun, 16 Aug 2026 19:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D3vNRLSm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3117710E34D
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 19:55:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5604411FC;
 Sun, 16 Aug 2026 19:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B4F1F000E9;
 Sun, 16 Aug 2026 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786910152;
 bh=qCKJiiMDNZSBlyXYcD5zJGiO24QQFz+MwY/EOr04EY8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D3vNRLSmrrQWLSEzZz/9p68vr3SOF0mDIOrkGtcCiqM/XALV/u13dO+KKR5nf/aRf
 EKj3LRACT97iiaufVI90GpPK2E2iy4j6ve8eepY75xyGoH3SCzWBGWxZsMu8scFtmR
 u1/npQWnQwYa/1IXK2xQ+SG2kz93zaOG/FJve1c0++CRNo8S5KRBY2KrnYF3s085Fu
 Q/Jfp9vOnc82BRtj+sw6sSD+MeqJsj3pB/xhLv7roRaVxY9LAbCAGmfyuJXjGF0O2C
 pQXXGdnofmDVim/pu8LQdHMIekdS2L+YfdT3OlzhWvuIunuOCDZ0Gt81QINOO2k5S5
 4AAaygv3BV1hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/imagination: Switch the GPUVM to immediate mode
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-pvr-vm-bind-v1-2-0a0f21be7d38@gmail.com>
References: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
 <20260817-pvr-vm-bind-v1-2-0a0f21be7d38@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 19:55:51 +0000
Message-Id: <20260816195552.60B4F1F000E9@smtp.kernel.org>
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
- [High] When splitting an existing mapping, `pvr_vm_gpuva_remap` permanent=
ly leaks references to the GEM object by explicitly calling `pvr_gem_object=
_get` for `prev_va` and `next_va` without any corresponding put in the unma=
p path.
--

--- Patch [2]: [PATCH 2/4] drm/imagination: Switch the GPUVM to immediate m=
ode ---
commit 62abfc02f1a7752ea9adac50d4fa08b736d27170
Author: Gyeyoung Baek <gye976@gmail.com>

drm/imagination: Switch the GPUVM to immediate mode

This commit switches the PowerVR GPUVM implementation to use
DRM_GPUVM_IMMEDIATE_MODE instead of the deferred execution model. This chan=
ge
aims to avoid deadlocks during asynchronous VM_BIND operations by removing
the use of drm_gpuvm_exec and directly protecting the gpuva list with the G=
EM
object's gpuva.lock.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index 608e8c0467dce..45df76e61f7cf 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c

[ ... ]

> @@ -436,17 +441,21 @@ pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *o=
p_ctx)
> =20
>  	if (op->remap.prev) {
>  		pvr_gem_object_get(gem_to_pvr_gem(ctx->prev_va->base.gem.obj));
> +		mutex_lock(&obj->gpuva.lock);
>  		drm_gpuva_link(&ctx->prev_va->base, vm_bo);
> +		mutex_unlock(&obj->gpuva.lock);
>  		ctx->prev_va =3D NULL;
>  	}
> =20
>  	if (op->remap.next) {
>  		pvr_gem_object_get(gem_to_pvr_gem(ctx->next_va->base.gem.obj));
> +		mutex_lock(&obj->gpuva.lock);
>  		drm_gpuva_link(&ctx->next_va->base, vm_bo);
> +		mutex_unlock(&obj->gpuva.lock);
>  		ctx->next_va =3D NULL;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does pvr_vm_gpuva_remap()
permanently leak references to the GEM object here?

When splitting an existing mapping (e.g., when an unprivileged userspace
client unmaps a subset or hole of an existing mapping), this code explicitly
calls pvr_gem_object_get() for prev_va and next_va to take an additional
reference to the GEM object for the newly split mappings.

Looking at the unmap path in pvr_vm_gpuva_unmap(), it relies purely on the
vm_bo lifecycle and does not appear to drop these per-VA GEM references:

pvr_vm_gpuva_unmap() {
        ...
        drm_gpuva_unmap(&op->unmap);
        drm_gpuva_unlink_defer(op->unmap.va);
        kfree(to_pvr_vm_gpuva(op->unmap.va));
        ...
}

Because these extra references taken during the remap operation are never
dropped when the mapping is subsequently unmapped, can this lead to a
permanent memory leak of GEM objects and eventual memory exhaustion if
userspace repeatedly splits mappings?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-pvr-vm-bin=
d-v1-0-0a0f21be7d38@gmail.com?part=3D2
