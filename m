Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D663C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7191A10E50B;
	Fri, 11 Sep 2026 22:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M+/J4e+8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCDB10E50B
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:49:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8037C43C83;
 Fri, 11 Sep 2026 22:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B81F000FF;
 Fri, 11 Sep 2026 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789166942;
 bh=a5wa48MqRRu7pj7tFkgesOcVqXda0yfigETZABmiawo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M+/J4e+8pyaWmM+um8Bn8Y8nB7ftZcJC5yLzxkj2v/Uo1IYkoF2Oc79na2DtTFTqh
 DI1GMgpc783/qamPS3LdojCznLymfIkfQahxt0OfEOZq20MdxLX7OboZ8jI4V6rT9E
 +LMnZ4DiKAobwL7o1PyTMwydD4Pr2YWf7U6sF22dUKTKJDQUK/7+nV4C498P9vGlFR
 7/7DOXw54hZAZWx5+8QVCBSJSsK9embC51Gne4qeNw8MKb85OuFGFNuvs8O2WSNnQh
 5kVSPXqk0xnfkBuT+PydRm2MsqoPAiHQDZSS4lyTM+EBo8i839yb4t89zx3UrDjazU
 Z7gNMy7wNQf+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/nouveau/gsp/r570: Enable Gcoff in fbsr again
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911222428.752641-6-lyude@redhat.com>
References: <20260911222428.752641-1-lyude@redhat.com>
 <20260911222428.752641-6-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:49:01 +0000
Message-Id: <20260911224902.615B81F000FF@smtp.kernel.org>
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
- [Critical] An always-false `cbc_size < 0` check fails to catch errors in =
`r570_fbsr_suspend()`, causing arithmetic wrap-around and an undersized sca=
tter-gather table allocation.
- [High] Error paths in `r570_fbsr_suspend()` fail to restore hardware stat=
e, leaving the GPU suspended.
--

commit 26e4bfb04a1b75eda1612ecdcc3766ff92fd2fb3
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Enable Gcoff in fbsr again

Now that we're properly saving the compbit backing stores on fbsr init, we
can start setting bEnteringGcOff =3D 1 again without things breaking, which
brings us closer to following the exact same code-paths OpenRM does for
fbsr.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 58f426ba81191..8545be1dde6ed 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -135,7 +135,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table =
*sgt, u64 size)
>  	ctrl->hClient =3D gsp->internal.client.object.handle;
>  	ctrl->hSysMem =3D memlist.handle;
>  	ctrl->sysmemAddrOfSuspendResumeData =3D gsp->sr.meta.addr;
> -	ctrl->bEnteringGcoffState =3D 0;
> +	ctrl->bEnteringGcoffState =3D 1;
> =20
>  	ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  	if (ret)

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential issue in
r570_fbsr_suspend() while reviewing this file:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c:r570_fbsr_suspend() {
    ...
	u64 size, cbc_size;
    ...
	cbc_size =3D r570_fb_get_compbit_store_size(gsp);
	if (cbc_size < 0)
		return cbc_size;
    ...
}

Because cbc_size is typed as u64, is it possible for the cbc_size < 0
check to ever be true?

If r570_fb_get_compbit_store_size() returns a negative error code
like PTR_ERR(ctrl), it will be cast to a massive unsigned value. This
huge value would then be added to size later in the function, which
could wrap around and lead to allocating an undersized SG table. Can
this overrun the allocated scatter-gather table during suspend?


[Severity: High]
This isn't a bug introduced by this patch, but I found another issue with
the error paths in r570_fbsr_suspend():

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c:r570_fbsr_suspend() {
	/* Stop channel scheduling. */
	r570_fbsr_suspend_channels(gsp, true);

	/* Temporarily disable raw mode ... */
	if (r570_need_raw_comp_war(gsp, device)) {
		ret =3D r570_memsys_enable_raw_comp_mode(gsp, false);
		if (ret)
			return ret;
	}
    ...
	/* Save BAR2 allocations to system memory. */
	list_for_each_entry(iobj, &imem->list, head) {
		if (iobj->preserve) {
			ret =3D nvkm_instobj_save(iobj);
			if (ret)
				return ret;
		}
	}
    ...
}

If operations like r570_memsys_enable_raw_comp_mode() or nvkm_instobj_save()
fail, the function returns immediately. Does this leave the GPU with channe=
ls
suspended and raw compression mode disabled without rolling them back?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911222428.7526=
41-1-lyude@redhat.com?part=3D5
