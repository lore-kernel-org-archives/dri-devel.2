Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7FEC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD78289BEC;
	Fri, 11 Sep 2026 22:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="el0t9IDy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E423089BEC
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:36:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FBBF600AA;
 Fri, 11 Sep 2026 22:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0F61F000FF;
 Fri, 11 Sep 2026 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789166210;
 bh=gPmkjxS4r7I2FlEHiauRI0I61p+A3q1Y9t0eN3dHMpI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=el0t9IDylOBml4ApYTcl9NKv0eNwGYcSige4m0keMX0lSO/KbUZiGKTY0viBl0FYx
 DYLY7gMrFwQrhjEO4OsNXqxBi/2xHPtxQgEOpg/URzOs6AZmNXJPolMBTC4uTRpZNM
 8schR/CBg7zUtdoSrT9DKt36JO0LfRzBoQGrHX2IU0W40ABPqDUm5H68XAm7UzeT7Q
 hJ6pTkDeWVafVmfJMXd2dc7Ynw5gMTCFs3u6jb5g/LoizqX8K04luL8jUjxUvFn1DX
 QME17OtJB1sOGkM4ulaV6nzxQwpoY7In97MX9LmgwAZ3+9X1uH4RLWk+V19+ztsUUt
 +V9aUbeJBxtug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911222428.752641-2-lyude@redhat.com>
References: <20260911222428.752641-1-lyude@redhat.com>
 <20260911222428.752641-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:36:50 +0000
Message-Id: <20260911223650.8F0F61F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Negative error codes from `nvif_device_gcx_ready()` are treated as=
 bitmasks, leading to unpredictable runtime suspend behavior.
- [High] Hardcoding `r535_gsp_gcx_ready(gsp)` bypasses the GSP function vta=
ble and will cause a NULL pointer dereference on non-RM GSPs.
- [Medium] `nvkm_udevice_gcx_ready()` bypasses the ioctl unpack protocol an=
d returns a positive bitmask directly as a return code.
- [Low] `GSP_GCX_ENTRY_GC6_READY` and `GSP_GCX_ENTRY_GCOFF_READY` are defin=
ed but never used.
--

commit 9f05a64653e46f7b990f534168f7024b8a4d408a
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r535: Add support for INTERNAL_GCX_ENTRY_PREREQUISITE

OpenRM consults GSP to check if the GPU should be allowed to enter Gc6
and/or GcOff before runtime suspending. If not ready, runtime suspend is
delayed. This commit implements the NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PRER=
EQUISITE
query and adds readiness checks in nouveau_pmops_runtime_suspend().

> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/=
gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> @@ -10,6 +10,9 @@
>  #define GSP_PAGE_SHIFT 12
>  #define GSP_PAGE_SIZE  BIT(GSP_PAGE_SHIFT)
> =20
> +#define GSP_GCX_ENTRY_GC6_READY		BIT(0)
> +#define GSP_GCX_ENTRY_GCOFF_READY	BIT(1)

[Severity: Low]
This isn't a bug, but these macros appear to be unused in this patch?
It looks like NV_DEVICE_GC6_READY and NV_DEVICE_GCOFF_READY are used
instead throughout the rest of the implementation.

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1157,6 +1157,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct nouveau_drm *drm =3D pci_get_drvdata(pdev);
> +	struct nvif_device *nvif =3D &drm->client.device;
>  	int ret;
> =20
>  	if (!nouveau_pmops_runtime()) {
> @@ -1164,6 +1165,14 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  	}
> =20
> +	// Check if the GPU itself is ready for runtime suspend, otherwise mark=
 as busy and check
> +	// again in a bit.
> +	if (!(nvif_device_gcx_ready(nvif) & NV_DEVICE_GCOFF_READY)) {

[Severity: High]
Can this bitwise check misinterpret negative error codes?

Looking at nvif_device_gcx_ready(), it can return negative error codes
like -ENOSYS or other transport errors. Since negative numbers usually
have higher bits set in two's complement (e.g., -ENOSYS often has bit 1
set), the bitwise AND with NV_DEVICE_GCOFF_READY (which is BIT(1)) might
evaluate to non-zero.

This could cause the driver to mistakenly assume the GPU is ready and
proceed with runtime suspend when the query actually failed, leading to
unpredictable power transition behavior.

> +		NV_DEBUG(drm, "GPU isn't ready for suspend yet, delaying...\n");
> +		pm_runtime_mark_last_busy(dev);
> +		return -EBUSY;
> +	}

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/=
gpu/drm/nouveau/nvkm/engine/device/user.c
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> @@ -189,6 +191,38 @@ nvkm_udevice_time(struct nvkm_udevice *udev, void *d=
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
> +	if (!device->gsp)
> +		return NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;

[Severity: Medium]
Does this early return break the NVIF mthd API contract?

The convention for mthd handlers is generally to unpack the arguments,
set the output fields in the args struct, and return 0 on success. Returning
a positive bitmask directly here bypasses the nvif_unpack sequence.

This positive value then bubbles up to the caller in nvif_device_gcx_ready(=
),
where it acts as a pseudo-error code and leaves the actual args.ready field
uninitialized.

> +
> +	nvif_ioctl(object, "device gcx ready size %d\n", size);
> +	if (!(ret =3D nvif_unpack(ret, &data, &size, args->v0, 0, 0, false))) {
> +		nvif_ioctl(object, "device gcx ready vers %d\n", args->v0.version);
> +
> +		ret =3D r535_gsp_gcx_ready(gsp);

[Severity: High]
Could this lead to a NULL pointer dereference on architectures running
without full Resource Manager (RM) functionality?

When falling back to firmware like gv100_gsp_nofw (e.g., on Turing or
Ampere), device->gsp is non-NULL, so the early return above is bypassed.
However, the RM structures are not initialized.

When r535_gsp_gcx_ready() is called in this state, it eventually invokes
nvkm_gsp_rm_ctrl_rd() -> nvkm_gsp_rm_ctrl_get(), which attempts to
dereference object->client->gsp->rm->api. If gsp->rm is NULL, this will
crash.

Would checking for !nvkm_gsp_rm(device->gsp) rather than !device->gsp
safeguard against this?

> +		if (ret < 0)
> +			return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911222428.7526=
41-1-lyude@redhat.com?part=3D1
