Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02057CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AD110E1E2;
	Sat, 10 Oct 2026 17:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cZnUi0Tl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884D710E1E2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:36:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 079D860534;
 Sat, 10 Oct 2026 17:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9811F000FF;
 Sat, 10 Oct 2026 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791653773;
 bh=G2LDXzDLtUwxkGb/hvf1bdWOmnq2I7RV8XP/JMfZm0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cZnUi0Tl0eBD9CUOmUv1nwbnXbODtlDYJtB0lP//yoMxBcbUY1+rMdkMem87vNXlr
 uk+9I6XP/bBunDsbW3yHsgJkn9opML8+9LP7/U+uT507UaCe0gzCGaTZ5Cks0wNrfT
 xVc96RJFGY9XUnhqix9yjaTRCuRILx3mzx9lpoRVfky00scjSzy+SQFHYxgBJPQV00
 yTNvsRR26wN2Hp8VS107jiZGjiDEWVnra/6OdrfH8kCukef0X9k1nwRmxlu5h647Ef
 XaPiWLpVq/3/XU+FJdNI2VC7P9W8NIT3Ho6JYAc68f2+gSvsrdfekk2MHZ7coy48EP
 0vn/sZpqsRKIw==
Message-ID: <sashiko-outbox-166780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/imagination: Stop locking reservations around
 map and unmap
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-pvr-gpuvm-immediate-v1-2-5b298dfce4f8@gmail.com>
References: <20261011-pvr-gpuvm-immediate-v1-0-5b298dfce4f8@gmail.com>
 <20261011-pvr-gpuvm-immediate-v1-2-5b298dfce4f8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:36:13 +0000
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
- [Medium] drm/imagination: missing cleanup of deferred GPUVM BOs in pvr_vm=
_map()
--

commit 7b2c8feb3b00c98681f3c0f485d9d8ac9c58c5eb
Author: Gyeyoung Baek <gye976@gmail.com>

drm/imagination: Stop locking reservations around map and unmap

The GPUVA lists are now protected by gpuva.lock instead of the
reservations, so map and unmap no longer need to lock the reservations.
Nothing else on that path relies on them.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index 3921b765688e1..2f1bbcfdb60e3 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c

[ ... ]

> @@ -739,15 +729,6 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr=
_gem_object *pvr_obj,
>  	   u64 pvr_obj_offset, u64 device_addr, u64 size)
>  {
>  	struct pvr_vm_bind_op bind_op =3D {0};
> -	struct drm_gpuvm_exec vm_exec =3D {
> -		.vm =3D &vm_ctx->gpuvm_mgr,
> -		.flags =3D DRM_EXEC_INTERRUPTIBLE_WAIT |
> -			 DRM_EXEC_IGNORE_DUPLICATES,
> -		.extra =3D {
> -			.fn =3D pvr_vm_lock_extra,
> -			.priv =3D &bind_op,
> -		},
> -	};
> =20
>  	int err =3D pvr_vm_bind_op_map_init(&bind_op, vm_ctx, pvr_obj,
>  					  pvr_obj_offset, device_addr,

[Severity: Medium]
If pvr_vm_bind_op_map_init() fails after creating a gpuvm_bo, does this code
leak the deferred BO?

Looking at pvr_vm_bind_op_map_init(), if it fails (e.g., due to ENOMEM or an
import mapping failure in pvr_gem_object_get_pages_sgt()), the error path
calls pvr_vm_bind_op_fini() which defers the BO cleanup:

pvr_vm_bind_op_fini() {
	drm_gpuvm_bo_put_deferred(bind_op->gpuvm_bo);
	...
}

However, the early return path in pvr_vm_map() (right after the call to
pvr_vm_bind_op_map_init()) skips calling drm_gpuvm_bo_deferred_cleanup():

	int err =3D pvr_vm_bind_op_map_init(&bind_op, vm_ctx, pvr_obj,
					  pvr_obj_offset, device_addr,
					  size);

	if (err)
		return err;

Since pvr_vm_map() is reachable via the PVR_IOCTL_VM_MAP ioctl, could a fau=
lty
or malicious userspace trigger this error path repeatedly and cause the def=
erred
list to grow unbounded, leaking kernel memory until the VM context is destr=
oyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-pvr-gpuvm-=
immediate-v1-0-5b298dfce4f8@gmail.com?part=3D2
