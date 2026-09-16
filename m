Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497F9C982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77CD10E454;
	Wed, 16 Sep 2026 14:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l9GfSJOx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C2E10E13E
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:43:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B26CE432F2;
 Wed, 16 Sep 2026 14:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104E41F000FF;
 Wed, 16 Sep 2026 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569819;
 bh=A13kCcw9ArEt4WpVsX8DkVfrRV1kpvUki+/PUinst9M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l9GfSJOxK53P7MzywYkzh7dGNQHQrbwtAe9Z9RiQuoO7wO1qHjKrvgeA7lIaAslY/
 3Lrfikc2K5g5hBsi65K5xnfD6a9XZSctiqOKsgci3UhyxhVrWU5AEemjqdxAKVpYgr
 /knpyjgmiLoZJyiwWbGuiupxph7LWV9q7X1eHllvCF1cYb8daiiQ2/1Zfi6lwzFgTA
 z1wKSghl6m9Hk/ZEh65INK0rh7GS4AraKji8Ez9PhFSXDI0sd5+RFxHUFozESIt1Mg
 Jn0Gi6sW2MTIzrDmUx/itf7KyuUrLxwFt3cEEfgwpLMzq4Y0MuqcqL3xF89v6QeO9l
 aNDlKWp7xotaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/19] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, lee@kernel.org, dmitry.torokhov@gmail.com,
 robh@kernel.org, linux-clk@vger.kernel.org, conor+dt@kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-13-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-13-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:43:38 +0000
Message-Id: <20260916144339.104E41F000FF@smtp.kernel.org>
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
- [High] drm/msm: hardware corruption due to zero-initialized LM3 base addr=
ess
--

commit f01ed8464ded4b4b827835f9551a26ed60e5dded
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

drm: msm: mdp5: Add MDP5 configuration for MSM8952

This commit adds the mdp5_cfg_hw entry for MDP5 version v1.12 found on
the MSM8952.

> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/m=
sm/disp/mdp5/mdp5_cfg.c
> index 7c91fc1915f39..d34c94d6f7e2e 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> @@ -744,6 +744,86 @@ static const struct mdp5_cfg_hw msm8x76_config =3D {
>  	.max_clk =3D 360000000,
>  };
> =20
> +static const struct mdp5_cfg_hw msm8952_config =3D {
> +	.name =3D "msm8952",

[ ... ]

> +	.lm =3D {
> +		.count =3D 2,
> +		.base =3D { 0x44000, 0x47000 },
> +		.instances =3D {
> +				{ .id =3D 0, .pp =3D 0, .dspp =3D 0,
> +				  .caps =3D MDP_LM_CAP_DISPLAY, },
> +				{ .id =3D 3, .pp =3D -1, .dspp =3D -1,
> +				  .caps =3D MDP_LM_CAP_WB },
> +			     },

[Severity: High]
Will this lead to hardware register corruption when LM3 is brought up?

In msm8952_config, the .lm.base array is initialized sequentially as
{ 0x44000, 0x47000 }, which assigns base[0] =3D 0x44000 and base[1] =3D 0x4=
7000.
This leaves base[3] implicitly zero-initialized.

However, the second LM instance is defined with .id =3D 3 (for LM3). When t=
he
driver configures this mixer, it uses lm->id to access the LM registers.
Because base[3] is 0, the driver will mistakenly perform writes to offset 0=
x0
of the MDP block (which corresponds to top-level registers).

Should designated initializers be used for the base array here, such as
{ [0] =3D 0x44000, [3] =3D 0x47000 }?

> +		.nb_stages =3D 8,
> +		.max_width =3D 2048,
> +		.max_height =3D 0xFFFF,
> +	},

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D13
