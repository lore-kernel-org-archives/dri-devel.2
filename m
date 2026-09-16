Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13803C88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EA710E09E;
	Wed, 16 Sep 2026 00:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IVAlJW49";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198C310E09E
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:40:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1223260008;
 Wed, 16 Sep 2026 00:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9AB1F000FF;
 Wed, 16 Sep 2026 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789519205;
 bh=EwLXVnsCAAkZOTI6VIPAS32JmiJR2ZCNiNag0QqRxKI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IVAlJW49m/o6cbezU6pXQcbZkicUE/3w8tu5rDvUNp4gCmpktI9+53aFfTIcDdf+2
 LcnBp0gN/432TcyokDIMAHmDjzgIe8HKy5bOgVxzYf53FDTIRi71iv3MVD6C7RqDRy
 ghP0MYuB3nuS8XA/3Og/hdN91T9ib6yQcahFZ7940m69vHuiNtu0nD4ElXDt4qd5No
 pUW0KWIBc5aCedu1gnq8UrL75jWJo1czVUrSORxCQxPYZVVA2K7jnZrWlgz1aU3Ap1
 AHXRUeCJMKP/EG0RxsYTSRXa06MqbuBpKoD/Qz7WBZBGe+7bouWVnikc5gxwHoyck3
 +BmbhWKNG6ODw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916001603.22394-2-lyude@redhat.com>
References: <20260916001603.22394-1-lyude@redhat.com>
 <20260916001603.22394-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 00:40:05 +0000
Message-Id: <20260916004005.9C9AB1F000FF@smtp.kernel.org>
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
- [High] drm/nouveau: OOB write in nvkm_udevice_gcx_ready() on non-GSP devi=
ces
- [High] drm/nouveau: NULL pointer dereference in r535_gsp_gcx_ready() with=
out GSP RM
--

commit 3c9696115b3fc14a9b7b98dbb2d52910189ce9c7
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r535: Add support for INTERNAL_GCX_ENTRY_PREREQUISITE

This commit implements the NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE
command to query GSP about whether the GPU is ready to enter Gc6 and/or
GcOff states. It updates nouveau_pmops_runtime_suspend() to consult this
readiness state before suspending.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/=
gpu/drm/nouveau/nvkm/engine/device/user.c
> index 23d11d8221cb6..c47d6daa9e5aa 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
[ ... ]
> @@ -189,6 +191,41 @@ nvkm_udevice_time(struct nvkm_udevice *udev, void *d=
ata, u32 size)
>  	return ret;
>  }
> =20
> +static int
> +nvkm_udevice_gcx_ready(struct nvkm_udevice *udev, void *data, u32 size)
> +{
> +	struct nvkm_object *object =3D &udev->object;
> +	struct nvkm_device *device =3D udev->device;
> +	struct nvkm_gsp *gsp =3D device->gsp;
> +	union {
> +		struct nv_device_gcx_ready_v0 v0;
> +	} *args =3D data;
> +	int ret =3D -ENOSYS;
> +
> +	/* XXX: We don't know any way of performing this check outside of GSP, =
so just assume
> +	 * things are ready for non-GSP clients.
> +	 */
> +	if (!gsp) {
> +		args->v0.ready =3D NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;

[Severity: High]
Does this code write out of bounds?

In nvkm_udevice_gcx_ready(), args->v0.ready is written here before
nvif_unpack() validates the payload size.

If a userspace process issues this ioctl with a size of 0, the data pointer
would point past the end of the allocated header. Writing to args->v0.ready
would then cause a 1-byte heap out-of-bounds write.

[Severity: High]
Can this condition lead to a NULL pointer dereference?

This checks if GSP exists (!gsp), but doesn't verify if OpenRM is actually
in use via nvkm_gsp_rm(gsp).

If GSP firmware is instantiated but RM is disabled, execution will fall
through to call r535_gsp_gcx_ready(), which assumes the RM control
structures are fully initialized.

> +		return 0;
> +	}
> +
> +	nvif_ioctl(object, "device gcx ready size %d\n", size);
> +	ret =3D nvif_unpack(ret, &data, &size, args->v0, 0, 0, false);
[ ... ]
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> index 94925f1590ea4..09b17b85dc1ac 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
[ ... ]
> @@ -1721,6 +1722,31 @@ r535_gsp_sr_data_size(struct nvkm_gsp *gsp)
>  	return meta->gspFwWprEnd - meta->gspFwWprStart;
>  }
> =20
> +int
> +r535_gsp_gcx_ready(struct nvkm_gsp *gsp)
> +{
> +	NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS *ctrl;
> +	int ret =3D 0;
> +
> +	ctrl =3D nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.subdevice,
> +				   NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE,
> +				   sizeof(*ctrl));

[Severity: High]
Does this call dereference an uninitialized pointer when GSP RM is absent?

If nvkm_udevice_gcx_ready() calls this function on a device that has GSP
present but OpenRM disabled, the internal GSP RM control structures are not
initialized. Calling nvkm_gsp_rm_ctrl_rd() here will dereference the NULL
client pointer, leading to a kernel panic.

> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	if (ctrl->bIsGC6Satisfied)
> +		ret |=3D NV_DEVICE_GC6_READY;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916001603.2239=
4-1-lyude@redhat.com?part=3D1
