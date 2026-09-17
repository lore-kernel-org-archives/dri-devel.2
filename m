Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC99CC982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26A810F03E;
	Thu, 17 Sep 2026 17:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IdnPIw8F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BAFA10F039
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:38:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64DE543A16;
 Thu, 17 Sep 2026 17:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274F81F000FF;
 Thu, 17 Sep 2026 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666692;
 bh=VjJy1qwQk09LJriKfquCL/pk++A3eoeIOeTJWcUVjK0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IdnPIw8FPB6l89fbzPrP1nkATWTEg7uoQR6o/0/Vv2Vl1zja/WQvg1H/bkzHBBtbQ
 2GuiYHxfyyFpp1FOKaTqzUiuvauQ/M1EkpK4Z04YIh3E2sunLKC8XUh56JXv6DvjQ4
 9OEANoaOIZB2lstcOusicUHNxm3TbyEEISNoqA9eeVXpCwLLpBQo0d6kdZrvyf9cJP
 WGCqFZXJR9lHqvkN0dJYl8FVMdWIFQUnOqODXv9ntGQcmupybL1zFilKGBIHOp9PUa
 1Zvr/c+ts5b4MP54HezrPVwdTAKJYmxHs4bo3mQRg42gqhIB43UItJD92O2uh0YxjC
 tlr4QxWD/6Jkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] drm/nouveau/gsp/r570: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917170042.440276-2-lyude@redhat.com>
References: <20260917170042.440276-1-lyude@redhat.com>
 <20260917170042.440276-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:38:11 +0000
Message-Id: <20260917173812.274F81F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] nouveau: memory corruption via unvalidated buffer write in nvkm_ud=
evice_gcx_ready()
- [High] nouveau: NULL pointer dereference in nvkm_gsp_gcx_ready when GSP-R=
M is disabled
- [Medium] pm: autosuspend timer permanently disabled on GSP query failure
- [Low] style: mismatched object pointers used for RPC control allocation a=
nd deallocation
- [Low] build: dead declaration for r535_gsp_gcx_ready
--

commit 4cd99785097738ad0c1e828e75d9aae4edf01817
Author: Lyude Paul <lyude@redhat.com>
Subject: drm/nouveau/gsp/r570: Add support for INTERNAL_GCX_ENTRY_PREREQUIS=
ITE

This patch adds support for querying the OpenRM GSP for GC6/GCOFF readiness
before runtime suspending the GPU. If the hardware is not ready, the suspend
operation is delayed.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1148,6 +1148,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct nouveau_drm *drm =3D pci_get_drvdata(pdev);
> +	struct nvif_device *nvif =3D &drm->client.device;
>  	int ret;
> =20
>  	if (!nouveau_pmops_runtime()) {
> @@ -1155,6 +1156,18 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  	}
> =20
> +	// Check if the GPU itself is ready for runtime suspend, otherwise mark=
 as busy and check
> +	// again in a bit.
> +	ret =3D nvif_device_gcx_ready(nvif);
> +	if (ret < 0) {
> +		NV_ERROR(drm, "Failed to query GCX readiness (returned %d)\n", ret);
> +		return -EBUSY;

[Severity: Medium]
Will this error path leave the PM core's autosuspend loop permanently disab=
led?

If nvif_device_gcx_ready() fails and returns -EBUSY without calling
pm_runtime_mark_last_busy(), the PM core won't re-arm the autosuspend timer
because the calculated expiration is in the past. Should this failure path
also mark the device as busy so it retries, or is disabling autosuspend
intentional here?

> +	} else if (!(ret & NV_DEVICE_GCOFF_READY)) {
> +		NV_DEBUG(drm, "GPU isn't ready for suspend yet, delaying...\n");
> +		pm_runtime_mark_last_busy(dev);
> +		return -EBUSY;
> +	}
> =20
>  	nouveau_switcheroo_optimus_dsm();
>  	ret =3D nouveau_do_suspend(drm, true);

> [ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/=
gpu/drm/nouveau/nvkm/engine/device/user.c
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> @@ -189,6 +190,38 @@ nvkm_udevice_time(struct nvkm_udevice *udev, void *d=
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
> +	if (!gsp) {
> +		args->v0.ready =3D NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
> +		return 0;
> +	}

[Severity: High]
Could this result in an out-of-bounds write if the caller provides an empty
or undersized buffer?

The ioctl handler allocates exactly the requested size, but if gsp is NULL
(e.g., NvGspRm=3D0), this writes to args->v0.ready before nvif_unpack() is
called to validate the size. A crafted 0-byte payload for this method could
cause a write past the allocation into kernel heap memory. Should the
size validation happen before any writes to the arguments?

> +
> +	nvif_ioctl(object, "device gcx ready size %d\n", size);
> +	ret =3D nvif_unpack(ret, &data, &size, args->v0, 0, 0, false);

> [ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/gsp/base.c
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> @@ -47,6 +48,15 @@ nvkm_gsp_intr_stall(struct nvkm_gsp *gsp, enum nvkm_su=
bdev_type type, int inst)
>  	return -ENOENT;
>  }
> =20
> +int
> +nvkm_gsp_gcx_ready(struct nvkm_gsp *gsp)
> +{
> +	if (!gsp->rm->api->gsp->gcx_ready)

[Severity: High]
Does this code crash with a NULL pointer dereference when GSP is present but
RM is disabled?

When RM is disabled (e.g., via NvGspRm=3D0 or firmware fallback to
gv100_gsp_nofw), device->gsp is allocated but gsp->rm is left as NULL.
Since nouveau_pmops_runtime_suspend() calls this unconditionally when
runtime PM is active, this looks like it will panic when dereferencing
gsp->rm->api. Should there be a check for !gsp->rm here?

> +		return NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
> +
> +	return gsp->rm->api->gsp->gcx_ready(gsp);
> +}

> [ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h b/drivers/gpu=
/drm/nouveau/nvkm/subdev/gsp/priv.h
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
> @@ -93,6 +93,7 @@ void r535_gsp_dtor(struct nvkm_gsp *);
>  int r535_gsp_oneinit(struct nvkm_gsp *);
>  int r535_gsp_init(struct nvkm_gsp *);
>  int r535_gsp_fini(struct nvkm_gsp *, enum nvkm_suspend_state suspend);
> +int r535_gsp_gcx_ready(struct nvkm_gsp *gsp);

[Severity: Low]
This isn't a bug, but this declaration appears to be dead code, as the
implementation for r535_gsp_gcx_ready was removed in earlier revisions
of this patch series.

> =20
>  int nvkm_gsp_new_(const struct nvkm_gsp_fwif *, struct nvkm_device *, en=
um nvkm_subdev_type, int,
>  		  struct nvkm_gsp **);

> [ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> @@ -215,6 +216,32 @@ r570_gsp_set_rmargs(struct nvkm_gsp *gsp, bool resum=
e)
>  	args->bDmemStack =3D 1;
>  }
> =20
> +int
> +r570_gsp_gcx_ready(struct nvkm_gsp *gsp)
> +{
> +	NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS *ctrl;
> +	int ret =3D 0;
> +
> +	ctrl =3D nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.subdevice,
> +				   NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE,
> +				   sizeof(*ctrl));
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	if (ctrl->bIsGC6Satisfied)
> +		ret |=3D NV_DEVICE_GC6_READY;
> +	if (ctrl->bIsGCOFFSatisfied)
> +		ret |=3D NV_DEVICE_GCOFF_READY;
> +
> +	nvkm_debug(&gsp->subdev,
> +		   "GCX ready status: GC6=3D%s GCOFF=3D%s\n",
> +		   str_yes_no(ctrl->bIsGC6Satisfied), str_yes_no(ctrl->bIsGCOFFSatisfi=
ed));
> +
> +	nvkm_gsp_rm_ctrl_done(&gsp->internal.client.object, ctrl);

[Severity: Low]
Is this using the intended object pointer to finalize the control buffer?

The allocation is done using &gsp->internal.device.subdevice, but here it is
finalized with &gsp->internal.client.object. Since both resolve to the same
underlying GSP pointer for the RPC completion it likely works, but shouldn'=
t it
use the same object for both allocation and deallocation?

> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917170042.4402=
76-1-lyude@redhat.com?part=3D1
