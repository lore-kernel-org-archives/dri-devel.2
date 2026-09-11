Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F076C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607C810E1F1;
	Fri, 11 Sep 2026 22:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MmV9JymJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E5810E1F1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:34:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98160600AA;
 Fri, 11 Sep 2026 22:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9E31F000FF;
 Fri, 11 Sep 2026 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789166048;
 bh=O8GVaB59YUgmW6AEkB119OnaVnlQus10pTyDq9zHGp8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MmV9JymJfJN7xrQF5KgPP3DAl9STs6+R59ky6vYoEYeww9+9CkFLsYiYPVDu2cFZz
 causNyeClsH7MGZz2Jam1eq3DUYGeL0rliwNAeOn7OCz0v4TxIitAolBtZ0sSKeY+y
 Nr+BcAp8QdUnt0o/1yCS0t51xbp63LThrZdQNe6/jggl8Ebka6iOj4RSLB9QPyp1LL
 nsM3t6x2riRnuwSDnlCzAWhDWHLGhznFea5e7H2zaZgd+qGO+xbqeVmRMK6Euz80hq
 gBPttEtwZVrbSWPBTF1SFo5yQ79hywTTPr3DqZ+Xxw+zk/BW8NsCiKdlnXmNQ8+MwU
 032j1jypekJEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] drm/nouveau/gsp/r535: Add support for
 MEMSYS_GET_STATIC_CONFIG
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911222428.752641-3-lyude@redhat.com>
References: <20260911222428.752641-1-lyude@redhat.com>
 <20260911222428.752641-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:34:07 +0000
Message-Id: <20260911223408.2C9E31F000FF@smtp.kernel.org>
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
- [High] The `r535_gsp_get_static_memsys_info` function allocates an RPC co=
mmand payload but never actually executes the command before reading its fi=
elds, resulting in reading uninitialized memory.
- [Medium] The memsys static info is never fetched when running on r535 fir=
mware because the call to `r535_gsp_get_static_memsys_info` is omitted from=
 `r535_gsp_get_static_info`.
--

commit 80c8c37934b6a701a8974b57594b260a8c0690c0
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r535: Add support for MEMSYS_GET_STATIC_CONFIG

This patch adds support for retrieving a GSP structure describing memory
management system characteristics during driver load. It fetches the
configuration for MEMSYS_GET_STATIC_CONFIG and saves it for later use.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> index 09b17b85dc1ac..c57a3250d6b96 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
[ ... ]
> @@ -1808,6 +1808,23 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_susp=
end_state suspend)
>  	return 0;
>  }
> =20
> +int
> +r535_gsp_get_static_memsys_info(struct nvkm_gsp *gsp)
> +{
> +	NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS *ctrl;
> +
> +	ctrl =3D nvkm_gsp_rm_ctrl_get(&gsp->internal.device.subdevice,
> +				    NV2080_CTRL_CMD_INTERNAL_MEMSYS_GET_STATIC_CONFIG,
> +				    sizeof(*ctrl));
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	gsp->memsys.use_raw_mode_comptagline_alloc =3D ctrl->bUseRawModeComptag=
lineAllocation;

[Severity: High]
Does this actually execute the RPC command to fetch the data?

It looks like nvkm_gsp_rm_ctrl_get() only allocates the payload buffer in
memory, but without a subsequent call to nvkm_gsp_rm_ctrl_push() (or by usi=
ng
nvkm_gsp_rm_ctrl_rd() instead), the command is never pushed to the firmware.

As a result, this might be reading uninitialized memory instead of the
firmware's response. This could silently break the workaround introduced in
the subsequent commit "drm/nouveau/gsp/r570: Add comp mode workaround from
issue #3172217", as use_raw_mode_comptagline_alloc will contain garbage or
zero, preventing the workaround from being applied properly.

> +
> +	nvkm_gsp_rm_ctrl_done(&gsp->internal.device.subdevice, ctrl);
> +	return 0;
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index b45781cd0dfdc..5a51fe7e5ab98 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> @@ -137,6 +137,14 @@ r570_gsp_get_static_info(struct nvkm_gsp *gsp)
>  		}
>  	}
> =20
> +	ret =3D r535_gsp_get_static_memsys_info(gsp);

[Severity: Medium]
Should r535_gsp_get_static_info() also be updated to call
r535_gsp_get_static_memsys_info(gsp)?

Currently, this is only added to r570_gsp_get_static_info(), which means the
memsys static info is never fetched when running on r535 firmware, and
gsp->memsys.use_raw_mode_comptagline_alloc will remain uninitialized for r5=
35.

While the follow-up commit "drm/nouveau/gsp/r570: Add comp mode workaround
from issue #3172217" currently only uses this flag in r570-specific suspend
paths, the commit message implies this configuration should be fetched on
r535 as well. Any future shared code relying on this flag on r535 could
receive uninitialized data.

> +	if (ret) {
> +		nvkm_error(&gsp->subdev, "Retrieving static memsys info failed\n");
> +		return ret;
> +	}
> +	nvkm_debug(&gsp->subdev, "memsys: Use raw mode for comptag allocations?=
 %s\n",
> +		   str_yes_no(gsp->memsys.use_raw_mode_comptagline_alloc));
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911222428.7526=
41-1-lyude@redhat.com?part=3D2
