Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEF2C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A4110E28A;
	Wed, 16 Sep 2026 22:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OOEhS7zc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBBA510E28A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 22:51:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3DAA43748;
 Wed, 16 Sep 2026 22:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770231F000FF;
 Wed, 16 Sep 2026 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789599090;
 bh=QGT9vKQWzP+wMsli5c8KtZR/PDBvtAJ0jo3wvlQU+iY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OOEhS7zccZg+N8Z4WH3ra/UZxSdZhjhHNiitBzAKba/s6ao/7Id79TZSmZGZmOUD+
 tIPts6Pm9vHo3WLR8pQJSG/dzF7tTcUAlH/NDLYC8dUYEUnXFdLsPluig4pSVS9gqN
 ILG7aBgXHT9wVDnhR8cg5b+sXggmvUu1dJPP17mETGmk3W710hU0I8uXIrYVQbPMUr
 H9xO/i9nvcF8Y1zXqdjxBJlmKjEyYBaRdEJgFv6uQ4fXd8sXyyl2Z0YUnbWPmaw4Bo
 FLFBPZE/LZoqDAPsIA16+7Q2anH/eqv561qXIcHPvoYzQZygzjtD/CNGc4Jm5uLXPR
 zDUKYsOGDp2pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916223358.507351-2-lyude@redhat.com>
References: <20260916223358.507351-1-lyude@redhat.com>
 <20260916223358.507351-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:51:30 +0000
Message-Id: <20260916225130.770231F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] nouveau/gsp: NULL pointer dereference when RM is disabled
- [Medium] pm: autosuspend stall on transient GCX readiness query error
- [Low] nouveau/gsp: API mismatch in gcx_ready using different object for a=
lloc/free
--

commit 71e096484486fcd07150f6da48fcb331a8eae639
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r535: Add support for INTERNAL_GCX_ENTRY_PREREQUISITE

OpenRM consults GSP to ask whether the GPU should be allowed to enter Gc6
and/or GcOff before runtime suspending. This patch implements the
NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE command query to check for
this readiness and delay runtime suspend if necessary.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index b0f9fb10a74dd..c2e2f430deded 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c

[ ... ]

> @@ -1164,6 +1165,18 @@ nouveau_pmops_runtime_suspend(struct device *dev)
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
When nvif_device_gcx_ready() fails, this error path returns -EBUSY without
calling pm_runtime_mark_last_busy(dev).

Will this stall the autosuspend timer? Without advancing last_busy, the PM
core will not automatically reschedule the timer, leaving the device in
the RPM_ACTIVE state.

> +	} else if (!(ret & NV_DEVICE_GCOFF_READY)) {
> +		NV_DEBUG(drm, "GPU isn't ready for suspend yet, delaying...\n");
> +		pm_runtime_mark_last_busy(dev);
> +		return -EBUSY;
> +	}
> +
>  	nouveau_switcheroo_optimus_dsm();
>  	ret =3D nouveau_do_suspend(drm, true);

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/gsp/base.c
> index 9ba1316831e7e..e475d0e8fa7bf 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c

[ ... ]

> @@ -47,6 +48,15 @@ nvkm_gsp_intr_stall(struct nvkm_gsp *gsp, enum nvkm_su=
bdev_type type, int inst)
>  	return -ENOENT;
>  }
> =20
> +int
> +nvkm_gsp_gcx_ready(struct nvkm_gsp *gsp)
> +{
> +	if (!gsp->rm->api->gsp->gcx_ready)

[Severity: Critical]
Does this code cause a NULL pointer dereference when RM is disabled?

On devices that use GSP but do not load GSP-RM (such as GV100 or Turing
without experimental RM enabled, or when disabled via the module parameter),
gsp->rm is never allocated and remains NULL.

Since nouveau_pmops_runtime_suspend() invokes this path for any GPU with a
GSP, won't this result in a kernel panic upon entering runtime suspend?

> +		return NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
> +
> +	return gsp->rm->api->gsp->gcx_ready(gsp);
> +}
> +

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index b45781cd0dfdc..dfda6b0b910a2 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c

[ ... ]

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
This isn't a bug, but is there an object mismatch here?

The memory for ctrl is allocated earlier using the device.subdevice object:

	ctrl =3D nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.subdevice, ...);

but it is released here using the mismatched client.object.

While this avoids a crash because both objects' client fields resolve to
the same GSP context internally, does this violate the API contract?

> +	return ret;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916223358.5073=
51-1-lyude@redhat.com?part=3D1
