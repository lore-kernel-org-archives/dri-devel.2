Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E053C982F1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B57510E420;
	Mon, 21 Sep 2026 18:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B7sPp0Ko";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6047B10E420
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:45:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22E5F408F7;
 Mon, 21 Sep 2026 18:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E831F000FF;
 Mon, 21 Sep 2026 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790016352;
 bh=QEXaBe/wzZMYxtsyY6HAox3T6MRIaBTtCY7Bf/0jZgA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B7sPp0KokBZVnD5b0XdYGpYUlUMFOOhwDWvG1H2RLehfFWy8Y9tCykC2y2eSkAmTT
 fFm5I5qnPYW38WUIJvt8ilVAyS4mjdz2IwV8cJUgVQY3t80mJdn7TftrViM+1e8/il
 P1Bld2sxD+Ku2XoEnqkWSSNULbtwh08rSZhwg4WnJy74Y8NYDxq6lxttwc5eympOSp
 FY/8rfCzzR47dglTiUNwFwG74sIASFI1A9qRqs9/BCPa/cenPT5Jrxvey6uBtthwMJ
 NMqxYayia2HJmLb6E8919DX2pPL7gD/dKrTVJKPcufrOaBfi1RHUgjKAb5hkV8Ez0g
 nEfUOgTax2uQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/19] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com,
 lee@kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-13-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-13-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:45:51 +0000
Message-Id: <20260921184551.71E831F000FF@smtp.kernel.org>
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
- [High] drm/msm: Missing designated initializers in lm.base array maps LM3=
 to 0x0
- [High] drm/msm: Hardware register corruption from exposing LM cursor as S=
SPP pipe
--

commit a462b33778a7f0e919c295ca897f61ab29c8108c
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

drm: msm: mdp5: Add MDP5 configuration for MSM8952

Add the mdp5_cfg_hw entry for MDP5 version v1.12 found on MSM8952.

> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/m=
sm/disp/mdp5/mdp5_cfg.c
> index 7c91fc1915f39..d34c94d6f7e2e 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
[ ... ]
> +static const struct mdp5_cfg_hw msm8952_config =3D {
> +	.name =3D "msm8952",
[ ... ]
> +	.pipe_cursor =3D {
> +		.count =3D 1,
> +		.base =3D { 0x440DC },
> +		.caps =3D MDP_PIPE_CAP_HFLIP	|
> +			MDP_PIPE_CAP_VFLIP	|
> +			MDP_PIPE_CAP_SW_PIX_EXT	|
> +			MDP_PIPE_CAP_CURSOR	|
> +			0,
> +	},

[Severity: High]
Does exposing the LM cursor as an SSPP pipe corrupt the LM cursor registers?

When userspace performs an atomic plane update on this cursor plane,
mdp5_plane_mode_set() writes standard SSPP pipe configurations to
0x440DC, which is the exact address of REG_MDP5_LM_CURSOR_STRIDE(0).

Because the two hardware blocks have completely different register layouts,
SSPP registers like SRC0_ADDR end up being written into LM CURSOR_XY
coordinates, corrupting the layer mixer's cursor configuration.

Should this cursor be handled by mdp5_crtc_cursor_set() instead of being
exposed as a pipe_cursor?

> +	.lm =3D {
> +		.count =3D 2,
> +		.base =3D { 0x44000, 0x47000 },

[Severity: High]
Will the base address for the LM3 (Writeback) hardware mixer evaluate to 0x=
0?

When the driver configures the Writeback interface (LM3), it indexes
mdp5_cfg->lm.base using the instance ID (mixer->lm =3D 3). Since the array
was initialized sequentially as { 0x44000, 0x47000 }, base[1] receives
0x47000 while base[3] is zero-initialized.

Writing layer mixer configuration to 0x0 corrupts the global MDP5 control
registers, leading to severe hardware malfunction or system crash.

Should this use designated initializers (e.g., [0] =3D 0x44000, [3] =3D 0x4=
7000)?

> +		.instances =3D {
> +				{ .id =3D 0, .pp =3D 0, .dspp =3D 0,
> +				  .caps =3D MDP_LM_CAP_DISPLAY, },
> +				{ .id =3D 3, .pp =3D -1, .dspp =3D -1,
> +				  .caps =3D MDP_LM_CAP_WB },
> +			     },
> +		.nb_stages =3D 8,
> +		.max_width =3D 2048,
> +		.max_height =3D 0xFFFF,
> +	},
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D13
