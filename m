Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F215C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F0F10E6A0;
	Mon, 27 Jul 2026 18:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fUbkCbk6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4B310E6A0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:03:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3A0860008;
 Mon, 27 Jul 2026 18:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2C21F00A3A;
 Mon, 27 Jul 2026 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785175390;
 bh=aU6ECMDOdvedOiPBDbo07UpCo5cSRUreJJxNhCuSqok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fUbkCbk6HD0vlb/uiuGzLigpBBZHZu0AVfhwGOOojiwq6mAxXfy5tdKCNFWXOjgAm
 i2vCdmV57sRslYt7CYNuBJeSPdaW7SMOVTP+OuspIS7/6Vn6O9i6wtyqZS+xGTs63c
 A6OZXR7SXRHUv38KJJv/akblT5RbOGEHZf5zSqOQ3Bx5db1K3EUPKSNIrSPxAX4tff
 JH4X5s3YpxtNzU+ClUxUt8Kx33ejgrd6r57uePUffp6Y3XtrP3DLx2TgfKPgUlrljX
 xYjxRKKJwy6hhnZaN6M2ToKHXw/UjE3ps2OoRp28/uOeuP1aftc7HrJhp5q65OlAR1
 u1y1t+lBCKzYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727175246.642071-2-lyude@redhat.com>
References: <20260727175246.642071-1-lyude@redhat.com>
 <20260727175246.642071-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:03:09 +0000
Message-Id: <20260727180310.4B2C21F00A3A@smtp.kernel.org>
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
- [High] GSP firmware memory allocation (memlist) is permanently leaked on =
error paths in r570_fbsr_init() and fbsr_init().
- [High] Incomplete error rollback in r570_fbsr_suspend() leaves hardware d=
isabled and leaks system memory.
--

--- Patch [1]: [PATCH v4 1/3] Revert "nouveau/gsp: fix suspend/resume regre=
ssion on r570 firmware" ---
commit e90949dff871229c99ce748acd0012d5f702035b
Author: Lyude Paul <lyude@redhat.com>

Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"

This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.

It turns out this looked like the right fix on some systems, but it's not -
as this causes runtime PM to actually fail on many a laptop.

Cc: <stable@vger.kernel.org> # v6.19+

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 8ef8b4f655883..2945d5b4e5707 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *s=
gt, u64 size, bool runtim
>  	ctrl->hClient =3D gsp->internal.client.object.handle;
>  	ctrl->hSysMem =3D memlist.handle;
>  	ctrl->sysmemAddrOfSuspendResumeData =3D gsp->sr.meta.addr;
> -	ctrl->bEnteringGcoffState =3D runtime ? 1 : 0;
> +	ctrl->bEnteringGcoffState =3D 1;
> =20
>  	ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  	if (ret)

[Severity: High]
This isn't a bug introduced by this patch, but does this error path permane=
ntly
leak the memlist object?

In r570_fbsr_init(), if the allocation of the control structure fails:

    ctrl =3D nvkm_gsp_rm_ctrl_get(&gsp->internal.device.subdevice,
                                NV2080_CTRL_CMD_INTERNAL_FBSR_INIT, sizeof(=
*ctrl));
    if (IS_ERR(ctrl))
        return PTR_ERR(ctrl);

The function returns directly, leaving the memlist object allocated on the =
GSP=20
firmware with a hardcoded handle. Because the handle is hardcoded, would a=
=20
subsequent suspend attempt fail with a duplicate handle error, permanently=
=20
breaking system suspend until the driver is reloaded?

(A similar pattern also appears to exist in fbsr_init()).

[ ... ]

> @@ -133,7 +133,7 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
>  		return ret;
> =20
>  	/* Initialise FBSR on RM. */
> -	ret =3D r570_fbsr_init(gsp, &gsp->sr.fbsr, size, runtime);
> +	ret =3D r570_fbsr_init(gsp, &gsp->sr.fbsr, size);
>  	if (ret) {
>  		nvkm_gsp_sg_free(device, &gsp->sr.fbsr);
>  		return ret;
>  	}

[Severity: High]
This is a pre-existing issue, but does this error path leave the GPU in an
unusable state and leak system memory?

If r570_fbsr_init() fails, r570_fbsr_suspend() returns the error without=20
rolling back prior operations:

    /* Initialise FBSR on RM. */
    ret =3D r570_fbsr_init(gsp, &gsp->sr.fbsr, size);
    if (ret) {
        nvkm_gsp_sg_free(device, &gsp->sr.fbsr);
        return ret;
    }

Since PM core aborts suspend and doesn't call resume on failure, does this=
=20
leave the GPU unresponsive with channel scheduling suspended and BAR2 disab=
led?

Additionally, earlier in the same function:

    /* Save BAR2 allocations to system memory. */
    list_for_each_entry(iobj, &imem->list, head) {
        if (iobj->preserve) {
            ret =3D nvkm_instobj_save(iobj);
            if (ret)
                return ret;
        }
    }

Would failing here (or later) permanently leak the memory allocated by=20
nvkm_instobj_save(), since it's only freed during a successful resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727175246.6420=
71-1-lyude@redhat.com?part=3D1
