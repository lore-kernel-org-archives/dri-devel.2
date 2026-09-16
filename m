Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4079C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C39510E06F;
	Wed, 16 Sep 2026 00:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VtDexF6A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE6010E06F
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:34:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB2964087F;
 Wed, 16 Sep 2026 00:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732E61F000FF;
 Wed, 16 Sep 2026 00:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789518844;
 bh=k24fp0J5mGcfnMeR08fm8Nt3JpA3dKi/SgVwUSb4xsA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VtDexF6AjzIekw6GqYn6sVVCUlXBzMgcEtrFImS76b1VjZAs4SYYISBGnVyvkrfew
 Ph8M3OTldbLPHMVAwzQnsMUEqWcGwkcAJ8f/0kZrZUqaIdD50p2DRk9x2E1sZXTHsE
 yA5+mzzJlwlDjUYey1XTG5CpurmjdzzVF6b4lmgNNsm/puvF8Ped7rw/T95RAEbyiv
 TYAmaidKSIy0mtKkXwNzlqy2VCiwL29Q2zPKYZ7QLj8AL5kGoUZqUtIYmCpxS0BXhU
 xBaQmIYuu1hOJ7NnBAHotRcEeMVyT3HYYbomDnimJjomEMnQ1lJ3if6RgyfDxVPj1Q
 zcmOliJBoPgPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] drm/nouveau/gsp/r570: Add comp mode workaround
 from issue #3172217
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916001603.22394-4-lyude@redhat.com>
References: <20260916001603.22394-1-lyude@redhat.com>
 <20260916001603.22394-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 00:34:03 +0000
Message-Id: <20260916003404.732E61F000FF@smtp.kernel.org>
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
- [High] drm/nouveau/gsp: wrong RM object in r570_memsys_enable_raw_comp_mo=
de()
--

commit eb1bdf6977173ce64b7e6625732d7ec397b78121
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Add comp mode workaround from issue #3172217

This commit adds a workaround to temporarily disable raw compression mode
on the GPU before initiating FBSR during suspend, and re-enable it during
resume. This addresses an issue on Ampere and Ada GPUs where restore
operations could otherwise corrupt compressed surfaces.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index af5aa5065c3dd..fe618a94461dc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
[ ... ]
> @@ -26,6 +26,35 @@ r570_fbsr_suspend_channels(struct nvkm_gsp *gsp, bool =
suspend)
>  	return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  }
> =20
> +static int
> +r570_memsys_enable_raw_comp_mode(struct nvkm_gsp *gsp, bool enable)
> +{
> +	NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_PARAMS *ctrl;
> +	int ret;
> +
> +	ctrl =3D nvkm_gsp_rm_ctrl_get(&gsp->internal.device.object,
> +				    NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE,
> +				    sizeof(*ctrl));

[Severity: High]
Should this use &gsp->internal.device.subdevice instead of .object?

The command being allocated is an 0x2080 Subdevice command
(NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE). If this is
requested against the Device object instead of the Subdevice object, the GS=
P RM
will reject the control command with an error because the target object does
not match the command's expected class.

> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	ctrl->bRawMode =3D enable;
> +
> +	ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.object, ctrl);

[Severity: High]
Similarly, should this write be issued to the subdevice?=20

Since r570_fbsr_suspend() propagates the return value of this function on G=
A100
and AD100 GPUs, an RM validation failure resulting from the class mismatch =
will
abort the suspend sequence entirely.

> +	if (!ret)
> +		nvkm_debug(&gsp->subdev, "memsys: Raw compression mode %s\n",
> +			   str_enabled_disabled(enable));
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916001603.2239=
4-1-lyude@redhat.com?part=3D3
