Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FC1C5DF6D
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 00:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6053E10F77C;
	Sat, 15 Aug 2026 00:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S9ezuslN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E9F10F795
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 00:08:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B19A4018F;
 Sat, 15 Aug 2026 00:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E969D1F000E9;
 Sat, 15 Aug 2026 00:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786752526;
 bh=AQt9ZY2/w8Sg8SYnVSEg9d4YcRSKrLK8o4hW8XLclI4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S9ezuslNTQE+5r6X8rXOnvWrdEoJm/S/kiCPVk92M1zYcA5Bk4viqTLAxgG0OLzSP
 oKpUx1jo99zuzBLHjcZ7jFmNpgDVwleLllKiSdmPCqIf2JcODdNb1WoArFC3AnBxLt
 v+ZJFfK8so7tmwlJrmsWnzz0MHpiNjSUd+YHICvkp0WiQPLvjwIvYDWETXYW1qUX4N
 BmX95XXdvNZg4tDmj7K50ojUvLObwg160xcBj/dvakuUrjR1q89FzkCFT7D/A91t/L
 1l0tq/T+RHTWC9tuBcbR4UgSRL8Sy0t5ezMTdotVGE/s49X5hivleSbsJLT9IyWGtZ
 1vxlbmp75g8AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] nouveau/gsp: fix HDMI vendor infoframes on GB20x
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814235705.59132-3-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-3-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 00:08:45 +0000
Message-Id: <20260815000845.E969D1F000E9@smtp.kernel.org>
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
- [High] The `gb202_sor_hdmi` structure omits the `.scdc` callback, which b=
reaks HDMI 2.0+ (SCDC) support and high-bandwidth modes (like 4K@60Hz) on G=
B20x GPUs.
- [Low] The patch assigns an undeclared function `r535_sor_frl_train` to a =
non-existent struct member `.frl_train` in `gb202_sor_hdmi`, causing a hard=
 build failure.
--

--- Patch [2]: [PATCH 2/7] nouveau/gsp: fix HDMI vendor infoframes on GB20x=
 ---
commit bab0e0425109e6d57a40d900a50e9f7f22ac57de
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

nouveau/gsp: fix HDMI vendor infoframes on GB20x

This commit selects the SOR functions per GPU family in r535_sor_new() based
on the display root class. It introduces gb202_sor_hdmi to use the new
generic-infoframe VSI writer on GB20x GPUs.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index e77733a5d9c3c..6b78619840c9c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c

[ ... ]

> @@ -587,6 +589,16 @@ r535_sor_hdmi =3D {
>  	.audio =3D r535_sor_hdmi_audio,
>  };
> =20
> +static const struct nvkm_ior_func_hdmi
> +gb202_sor_hdmi =3D {
> +	.ctrl =3D r535_sor_hdmi_ctrl,
> +	/* The legacy AVI unit is unchanged on GB20x. */
> +	.infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
> +	.infoframe_vsi =3D gb202_sor_hdmi_infoframe_vsi,
> +	.audio =3D r535_sor_hdmi_audio,

[Severity: High]
Does this initialization omit the .scdc callback mapping?

Looking at nvkm_uoutp_mthd_hdmi(), if userspace requests a high-bandwidth
mode that depends on SCDC scrambling, the modeset aborts if the callback is
missing:

drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c:nvkm_uoutp_mthd_hdmi() {
	if (!ior->func->hdmi ||
	    args->v0.max_ac_packet > 0x1f ||
	    args->v0.rekey > 0x7f ||
	    (args->v0.scdc && !ior->func->hdmi->scdc))
		return -EINVAL;
	...
}

Can this result in broken HDMI output or black screens for high-bandwidth
modes (like 4K@60Hz) on GB20x GPUs?

> +	.frl_train =3D r535_sor_frl_train,

[Severity: Low]
Does this cause a build failure?

Looking at the definition of struct nvkm_ior_func_hdmi in
drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h, it does not contain a
.frl_train member.

Additionally, it appears r535_sor_frl_train is undeclared in this scope.

> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814235705.5913=
2-1-mohamedahmedegypt2001@gmail.com?part=3D2
