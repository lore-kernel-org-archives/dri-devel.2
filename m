Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAA6C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 22:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C55E10E13B;
	Mon, 29 Jun 2026 22:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k9uR3cDJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4AD10E13B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 22:56:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E09560008;
 Mon, 29 Jun 2026 22:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC9C1F000E9;
 Mon, 29 Jun 2026 22:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782773769;
 bh=Wby8WIx4A8bV0Rji68a5AMS3k0YTKW61kNErD+yFKuM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k9uR3cDJy1wtoNk3X4M4tTqSgoqo5HkJTjWOAYoRbnYSKZWK6Ecs9woyxjxKsS5Zz
 SRCDrh5xZwcgJczqbIHCg7dY8MB7WCAcbzj2c/NaAY6ySmwDtd1yBJyVGamfFU8XBP
 hWolDMnO+7IiGMFpsZtRgvh0VBRIJw2aW9aKBklx/ISMR7mIPVOnUZ8CVDayLga3LZ
 fUiLLmmo/7edgxY7b39jT44JVlMVKTYepiApOjphCQdQfcMqAy9Crh1NYZSnW5487Z
 gjTajlCojEwgnvUnM69SWc1yp3RE0/bahh47LXLwkmEqmesLW2KJpLZtbjMUhfH5J1
 AY6QVC2LXfT1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/nouveau/gsp/r570: Never enter Gcoff state
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629224350.2870201-3-lyude@redhat.com>
References: <20260629224350.2870201-1-lyude@redhat.com>
 <20260629224350.2870201-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 22:56:08 +0000
Message-Id: <20260629225609.2AC9C1F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but GSP active chann=
el scheduling is not resumed on suspend error paths, leading to a permanent=
 GPU hang.
--

commit d3622da930a8cf5e22c2dae487c3e7c942f12198
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Never enter Gcoff state

This commit disables the Gcoff state transition for the r570 platform
during suspend operations. It resolves an issue where the Gcoff state
caused runtime suspend failures by ensuring the bEnteringGcoffState
flag is permanently set to 0.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 2945d5b4e5707..af5aa5065c3dd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *s=
gt, u64 size)
>  	ctrl->hClient =3D gsp->internal.client.object.handle;
>  	ctrl->hSysMem =3D memlist.handle;
>  	ctrl->sysmemAddrOfSuspendResumeData =3D gsp->sr.meta.addr;
> -	ctrl->bEnteringGcoffState =3D 1;
> +	ctrl->bEnteringGcoffState =3D 0;
> =20
>  	ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  	if (ret)

[Severity: High]
This is a pre-existing issue, but I have a question about the error
handling paths during suspend in this file.

If r570_fbsr_init() or other operations like nvkm_instobj_save() return
an error, those errors propagate out of r570_fbsr_suspend():

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c:r570_fbsr_suspend() {
    ...
	/* Stop channel scheduling. */
	r570_fbsr_suspend_channels(gsp, true);

	/* Save BAR2 allocations to system memory. */
	list_for_each_entry(iobj, &imem->list, head) {
		if (iobj->preserve) {
			ret =3D nvkm_instobj_save(iobj);
			if (ret)
				return ret;
    ...
}

If any of these early returns are taken, r570_fbsr_suspend_channels(gsp,
false) is never called. Will this leave the GSP active channel scheduling
permanently disabled and result in a GPU hang if the PM core aborts the
suspend process?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629224350.2870=
201-1-lyude@redhat.com?part=3D2
