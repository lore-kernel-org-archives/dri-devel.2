Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAA1C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE7010E6FA;
	Fri, 11 Sep 2026 22:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GP8DL93p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9026A10E597
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:43:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D784E601EF;
 Fri, 11 Sep 2026 22:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626411F000FF;
 Fri, 11 Sep 2026 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789166606;
 bh=G/4Zjk9ZGu/Xrnbk/UK1+fDS8hc2DvahKoWA+Nf26bM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GP8DL93pH7MNcL4v9gJ9BaFsglrAilZ4QKXUL5NxbMp5bnSTH2GW2B4+W9WNfPgRi
 NObySkDbH7zjjGk2vxMqUnAoZ/ToXBZqrKn6mbcXY+kPCuvWPphu8KOR904EyfxuxG
 e21ZXCix0Lb38BdJMMgYw8Rtp9FbeVrgzYNQ7Z4PNaGIW8dqybHpj7/ruWicunolg1
 CMyjdHDEFGT4wvPRQnmMmydtWPQvTCg/1iry4xTbqTy16CdMv+OuJwsnmrpyD8CwRF
 lem6WkEEqBUm4PnLTSUJeVjPMEDKSc0BCP3YXC31H4qcYlOe4cv+J5+BPqGUvGnjVd
 nl8SqMrYL+tTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/nouveau/gsp/r570: Start saving comptag backing
 stores
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911222428.752641-5-lyude@redhat.com>
References: <20260911222428.752641-1-lyude@redhat.com>
 <20260911222428.752641-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:43:25 +0000
Message-Id: <20260911224326.626411F000FF@smtp.kernel.org>
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

New issues:
- [Critical] The error check `if (cbc_size < 0)` is always false because `c=
bc_size` is an unsigned `u64`. When `r570_fb_get_compbit_store_size()` fail=
s, it returns a negative error code that is implicitly cast to a large posi=
tive `u64`, bypassing the error check and causing an integer wrap-around.
- [Low] Mismatched GSP object handles used for API allocation and cleanup i=
n `r570_fb_get_compbit_store_size()`.

Pre-existing issues:
- [High] Missing cleanup of suspended channels on error paths in `r570_fbsr=
_suspend()`.
--

commit caaa903dee4578bf9a609b4561ba8eb17ac6e144
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Start saving comptag backing stores

This commit implements support for saving and restoring comptag backing sto=
res
in OpenRM's fbsr process by fetching the required space and allocating it.
The goal is to safely enable bEnteringGcOff in fbsr.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 7f5aae0c055b8..58f426ba81191 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -26,6 +26,24 @@ r570_fbsr_suspend_channels(struct nvkm_gsp *gsp, bool =
suspend)
>  	return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  }
> =20
> +static u64
> +r570_fb_get_compbit_store_size(struct nvkm_gsp *gsp)
> +{
> +	NV0080_CTRL_FB_GET_COMPBIT_STORE_INFO_PARAMS *ctrl;
> +	u64 size;
> +
> +	ctrl =3D nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.object,
> +				   NV0080_CTRL_CMD_FB_GET_COMPBIT_STORE_INFO,
> +				   sizeof(*ctrl));
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);

[Severity: Critical]
Since r570_fb_get_compbit_store_size() returns a u64, does this implicitly
cast the negative signed error code (like -ENOMEM) into a huge positive val=
ue?

> +
> +	size =3D ctrl->Size;
> +
> +	nvkm_gsp_rm_ctrl_done(&gsp->internal.device.subdevice, ctrl);

[Severity: Low]
Does this violate API symmetry by allocating the control struct using
&gsp->internal.device.object but cleaning it up with
&gsp->internal.device.subdevice?

> +	return size;
> +}
> +
>  static int
>  r570_memsys_enable_raw_comp_mode(struct nvkm_gsp *gsp, bool enable)
>  {

[ ... ]

> @@ -151,6 +169,11 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
>  			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path fail to
undo r570_fbsr_suspend_channels(gsp, true) called earlier in the function?

If the suspend fails here, it seems the channels are left permanently
suspended, making the GPU unusable until a reboot.

>  	}
> =20
> +	cbc_size =3D r570_fb_get_compbit_store_size(gsp);
> +	if (cbc_size < 0)
> +		return cbc_size;

[Severity: Critical]
Is this error check dead code? Since cbc_size is an unsigned u64, it can
never be less than 0.

If r570_fb_get_compbit_store_size() fails, the implicitly cast large positi=
ve
error code will bypass this check, leading to an integer wrap-around when
added to size later in the function.

Could this cause an undersized memory allocation that results in memory
corruption when the firmware attempts to write the FBSR state out of bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911222428.7526=
41-1-lyude@redhat.com?part=3D4
