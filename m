Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F0C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C26088C3D;
	Fri, 14 Aug 2026 19:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GXwcU0Tz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283D610F6D0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:57:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16C1860008;
 Fri, 14 Aug 2026 19:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9950F1F000E9;
 Fri, 14 Aug 2026 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786737418;
 bh=oZLt1QG05Vr/cnSLlu10sDUI9rD9E493W+3OGIv93jA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GXwcU0Tzy9vIA0zt2xu7Ji7SAZEhz1eRcj05lWMx783wYJKZo1axEK+zxfG9uc15w
 DaI0lW24WOl0ybH/yawDuGvFljOAb6M0wCZKKkx5F5sKyqBQ42btNQKQPnD1yZgxcz
 +QVJfvLPWlhTT7ZQcXitdPQJOGer3hfJTbbLG3BpBvnGopPYp5k7S/b84c3Oupa+Lu
 jA51PKJJPT2u8EA8JrZZB1bidoVcvtCvhO5zlOjlhMVN3ZHW+cDP76I2qtbMiHPWSj
 xyivFzvz2sM7n3yyJtSk90T+v2OrVPiikprbehS0N6dMgm99DW/aDbFCrHncGCVSQV
 M6BUs2i3eTimg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] drm/nouveau/gsp/r570: Set GcOff = 0 in fbsr
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814194542.781955-3-lyude@redhat.com>
References: <20260814194542.781955-1-lyude@redhat.com>
 <20260814194542.781955-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 19:56:58 +0000
Message-Id: <20260814195658.9950F1F000E9@smtp.kernel.org>
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
- [High] Unbalanced teardown and PM rollback failure in r570_fbsr_suspend()=
 on error paths, leading to permanent GPU malfunction.
--

--- Patch [2]: [PATCH v5 2/4] drm/nouveau/gsp/r570: Set GcOff =3D 0 in fbsr=
 ---
commit 16fc4506e7114a3cfe615883d89f54f5f2c54a54
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Set GcOff =3D 0 in fbsr

This commit fixes suspend/resume on some desktops by setting GcOff to 0.
It turns out that setting GcOff to 1 causes GSP to save and restore buffers
that actually need to be reinitialized on resume.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
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
This isn't a bug introduced by this patch, but while looking at the suspend
paths in this file, I noticed an issue in r570_fbsr_suspend().

If nvkm_instobj_save() fails, it returns without restoring channel
scheduling:

r570_fbsr_suspend() {
    ...
			ret =3D nvkm_instobj_save(iobj);
			if (ret)
				return ret;
    ...
}

Similarly, if nvkm_gsp_sg() fails later in the same function:

r570_fbsr_suspend() {
    ...
	ret =3D nvkm_gsp_sg(device, size, &gsp->sr.fbsr);
	if (ret)
		return ret;
    ...
}

Does this leave the system in an unusable state if a memory allocation
failure occurs?=20

It appears that returning immediately here skips restoring the channels or
freeing previously allocated iobj->suspend buffers.

During a suspend failure, nvkm_device_fini() aborts the suspend process and
attempts to restart devices by calling nvkm_subdev_init(), which invokes
r535_gsp_init(). Because gsp->sr.meta.data was destroyed and set to NULL on
the error path, r535_gsp_init() will skip calling rm->api->fbsr->resume(gsp=
).

Could this permanently disable the channels and leave the GPU in a broken
suspended state until the system is rebooted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814194542.7819=
55-1-lyude@redhat.com?part=3D2
