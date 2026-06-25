Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582DACDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 23:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC65F10F3C3;
	Thu, 25 Jun 2026 23:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXy4VDNA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E1110F3C3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 23:25:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AAA1043619;
 Thu, 25 Jun 2026 23:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD591F000E9;
 Thu, 25 Jun 2026 23:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782429953;
 bh=mncVSX+5UWr5tuoEmSdnddqsF1Y5Y+Kx5U2IMXk1zUQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bXy4VDNAeJkqdGf2/+2UobnQfaTV2qXGQ7S+lFl7kujBNsOVnmwy/fyz7EoE3HDBX
 mhupmg+CfSG2yhdTvqCuE4mL3so7KqTjPSaf9BfYDhvzuP8e+hVCasT68Q1FdGOExv
 f6pZC8q1QPZr2koQOuDW/0UGl16+0aPynQWbyl/sEPoBK73sUzKNf7X2YgRIROOY7Y
 RPZ2BgXYMWrp7XOWgj86nTWLpllyGtBB9Ig++gw8v6dQKr+fmF+JmHtKJGCHXPucFI
 u/vQwcl8FCJXRJ4FZNSzsUlP7HYDCot4wRcp+Jt51+BYgMt7A8wIeR5v6muk1URcfV
 VmigX5xV5zMgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/nouveau/gsp/r570: Never enter Gcoff state
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625231252.89684-3-lyude@redhat.com>
References: <20260625231252.89684-1-lyude@redhat.com>
 <20260625231252.89684-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 23:25:52 +0000
Message-Id: <20260625232553.4FD591F000E9@smtp.kernel.org>
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
- [High] Missing rollback of hardware state in suspend paths when operation=
s fail, leaving the device hung.
--

commit ed5c98b04aafc61a13ebb42fe49a1f15121c1b4d
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Never enter Gcoff state

It turns out that the only reason our previous fixes looked like they
worked for this was because we would occasionally set the Gcoff state to 0
in the normal S3 path, which fixed suspend/resume on desktops - but not on
machines using runtime suspend.

The proper fix is to just never set this flag. Our current guess for the
reasoning behind this is that Gcoff likely coincides with GC6, and not
literally power off.

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
This is a pre-existing issue, but I have a question about the suspend path's
error handling.

If nvkm_gsp_rm_ctrl_wr() fails here, r570_fbsr_init() returns an error back=
 to
r570_fbsr_suspend():

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c:r570_fbsr_suspend() {
    ...
    r570_fbsr_suspend_channels(gsp, true);
    ...
    device->bar->bar2 =3D false;
    ...
    ret =3D r570_fbsr_init(gsp, &gsp->sr.fbsr, size);
    if (ret) {
        nvkm_gsp_sg_free(device, &gsp->sr.fbsr);
        return ret;
    }
}

The same error path exists earlier in r570_fbsr_suspend() if
nvkm_instobj_save() or nvkm_gsp_sg() fail.

Since the PM core doesn't call the resume callback for devices that fail to
suspend, does this leave the GPU hung with suspended channels and BAR2
disabled?

Would it make sense to restore the channel and BAR state on error paths
in r570_fbsr_suspend() before returning?

>  		return ret;
> =20
>  	nvkm_gsp_rm_free(&memlist);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625231252.8968=
4-1-lyude@redhat.com?part=3D2
