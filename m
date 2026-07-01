Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55C0C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1962510F0A6;
	Wed,  1 Jul 2026 18:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fUBwvTx0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D3710F0A6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:41:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E0806001D;
 Wed,  1 Jul 2026 18:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDC71F000E9;
 Wed,  1 Jul 2026 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782931263;
 bh=7Z+Ti0ipwjkcuht/kUHiiOcGjNWBOkb1iJlINNxmVPA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fUBwvTx08OCd5sLTrg3Ce5du/fUq4ZHievHCJBUbVWzEibSVuWdZ9yk3iux6yTqc1
 kt4AF2C+kAoLtIKMPZXix8d6HGl/wDTMkFe/1AVPoadVsPRlzsqh6zDQNS/bwEAJa8
 hDIop+WImqZ3uu3RD5QA+Rprabe+q8lJq8sCgZKn/ni/qrRIbxiw3lgiFwxqR3DAU7
 dSKPHWjrCsAuTCUAERFRwfY7oM29SCHgUUQfvMmlNxP2hEacMjr6V8ti38CZlZ8fQ0
 ehlKu5NqGb/wKxdmsLTJwmQMRU6ap6B27Gr4LbPotZo0ZsDYwBYyXZRV4XDqAzc8l1
 DdEf3o4PRxUoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701182857.190713-2-lyude@redhat.com>
References: <20260701182857.190713-1-lyude@redhat.com>
 <20260701182857.190713-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 18:41:02 +0000
Message-Id: <20260701184102.CCDC71F000E9@smtp.kernel.org>
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
- [High] Missing cleanup of RM object (memlist) on error paths in FBSR init=
ialization.
- [High] Error paths in `r570_fbsr_suspend()` leave GPU channel scheduling =
and BAR2 in a broken state.
--

commit 7d63de5b70c2db9e57a30fb5f72d5fa08bb0b6fa
Author: Lyude Paul <lyude@redhat.com>
Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"

This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18. It turns out
this looked like the right fix on some systems, but it causes runtime PM to
fail on many laptops.

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
This isn't a bug introduced by this patch, but does this error path leak the
memlist RM object?

If nvkm_gsp_rm_ctrl_wr() fails here, we return early without calling
nvkm_gsp_rm_free(&memlist).

Because the object uses a hardcoded handle (0xcaf00003), leaking it could
cause subsequent suspend attempts to fail with a name collision error. A
similar leak seems to exist just above this for nvkm_gsp_rm_ctrl_get()
failures, and also in the r535 backend in fbsr_init().

>  		return ret;
> =20
>  	nvkm_gsp_rm_free(&memlist);
>  	return 0;
>  }
> =20
>  static int
> -r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
> +r570_fbsr_suspend(struct nvkm_gsp *gsp)
>  {
>  	struct nvkm_subdev *subdev =3D &gsp->subdev;
>  	struct nvkm_device *device =3D subdev->device;

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

[Severity: High]
This is a pre-existing issue, but does this return leave the GPU channel
scheduling and BAR2 in a broken state?

Earlier in r570_fbsr_suspend(), we disable channel scheduling and BAR2 acce=
ss:

r570_fbsr_suspend() {
    ...
	/* Stop channel scheduling. */
	r570_fbsr_suspend_channels(gsp, true);
    ...
	/* Disable BAR2 access. */
	device->bar->bar2 =3D false;
    ...
}

If r570_fbsr_init() (or the earlier nvkm_gsp_sg and nvkm_instobj_save calls)
fails, we return the error without restoring channel scheduling or BAR2 acc=
ess.

Since the suspend callback returns an error, the kernel PM core will abort =
the
suspend process and not invoke the corresponding resume callback, potential=
ly
leaving the GPU in a broken, half-suspended state.

>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701182857.1907=
13-1-lyude@redhat.com?part=3D1
