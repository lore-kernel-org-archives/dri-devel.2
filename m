Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B963DC982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2434210E3EF;
	Wed, 16 Sep 2026 14:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="agBrgLbP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271E010E3EF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:44:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A1C86053A;
 Wed, 16 Sep 2026 14:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A18D1F000FF;
 Wed, 16 Sep 2026 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569878;
 bh=FBvbPH8tbC/J+MeTv9LGjYGrwJAxOJHNVOVhnC4K2mY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=agBrgLbPtX7pcsBoIDTRLYtlo2wuhz82bfv1jtcmIdw1AaIEMbmCyUTTZnmNuqrdl
 2ae2Fk1OljbT2LELpAqw5UajmYiYeOFNaeYMW+A7FPQKrtmu8xrbbQKNIe5nEKqWiM
 EX99rt/b0aYWkzThlSQJgbkkr8aXEYQBNCrNG3miksc8bHE7b7DyNJLg81ETvducRH
 qC5MmNB+EejLzEiMFSHa/Ae0bTkLnlXmWU59S4merznCIBc8+I/AaCd3MYv1/VwATw
 lYxI3WG7FXVPju4s/C+TDTzDVzXUTCdOBVmklo6dW0fRrCFcTDxaDSUw13cCesf116
 e6T6fJevZDM+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: conor+dt@kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, mfd@lists.linux.dev,
 lee@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-msm8952-initial-support-v2-2-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-2-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:44:37 +0000
Message-Id: <20260916144437.8A18D1F000FF@smtp.kernel.org>
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
- [High] clk: qcom: gp1/2/3_clk_src CCF parent incorrectly mapped to gpll0_=
vote instead of xo
- [High] clk: qcom: reset map targets CBCR enable bits instead of BCR reset=
 registers
--

commit f6425874e2d9adc87ee0fd906bb71cd217405222
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

clk: qcom: Add global clock controller driver for MSM8952

This commit adds the global clock controller (GCC) driver for the Qualcomm
MSM8952 SoC. It provides clocks, resets, and power domains needed for vario=
us
hardware components on the device.

Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c

diff --git a/drivers/clk/qcom/gcc-msm8952.c b/drivers/clk/qcom/gcc-msm8952.c
--- a/drivers/clk/qcom/gcc-msm8952.c
+++ b/drivers/clk/qcom/gcc-msm8952.c
[ ... ]
> static struct clk_rcg2 gp1_clk_src =3D {
> 	.cmd_rcgr =3D 0x08004,
> 	.mnd_width =3D 8,
> 	.hid_width =3D 5,
> 	.parent_map =3D gcc_xo_map,
> 	.freq_tbl =3D ftbl_gcc_gp1_3_clk,
> 	.clkr.hw.init =3D &(struct clk_init_data){
> 		.name =3D "gp1_clk_src",
> 		.parent_hws =3D (const struct clk_hw *[]) {
> 			&gpll0_vote.hw,
> 		},

[Severity: High]
Does this code map to the wrong parent hardware clock? The parent_map is set
to gcc_xo_map (which implies hardware source 0, typically XO), but the CCF
parent_hws array points to &gpll0_vote.hw (800MHz) instead of the XO
reference.

This causes the Common Clock Framework to report the parent rate as 800MHz
while the hardware operates at 19.2MHz. Consequently, downstream drivers
configuring these clocks may compute incorrect hardware dividers, leading to
severe underclocking, and it will keep gpll0_vote enabled unnecessarily.

> 		.num_parents =3D 1,
> 		.ops =3D &clk_rcg2_ops,
> 	},
> };
>=20
> static struct clk_rcg2 gp2_clk_src =3D {
> 	.cmd_rcgr =3D 0x09004,
> 	.mnd_width =3D 8,
> 	.hid_width =3D 5,
> 	.parent_map =3D gcc_xo_map,
> 	.freq_tbl =3D ftbl_gcc_gp1_3_clk,
> 	.clkr.hw.init =3D &(struct clk_init_data){
> 		.name =3D "gp2_clk_src",
> 		.parent_hws =3D (const struct clk_hw *[]) {
> 			&gpll0_vote.hw,
> 		},

[Severity: High]
Does the same parent mismatch apply here to gp2_clk_src as well?

> 		.num_parents =3D 1,
> 		.ops =3D &clk_rcg2_ops,
> 	},
> };
>=20
> static struct clk_rcg2 gp3_clk_src =3D {
> 	.cmd_rcgr =3D 0x0a004,
> 	.mnd_width =3D 8,
> 	.hid_width =3D 5,
> 	.parent_map =3D gcc_xo_map,
> 	.freq_tbl =3D ftbl_gcc_gp1_3_clk,
> 	.clkr.hw.init =3D &(struct clk_init_data){
> 		.name =3D "gp3_clk_src",
> 		.parent_hws =3D (const struct clk_hw *[]) {
> 			&gpll0_vote.hw,
> 		},

[Severity: High]
And similarly, does gp3_clk_src also point to gpll0_vote.hw instead of xo?

[ ... ]
> static const struct qcom_reset_map gcc_msm8952_resets[] =3D {
> 	[RST_CAMSS_MICRO_BCR]		=3D { 0x56008 },
> 	[RST_USB_HS_BCR]		=3D { 0x41000 },
> 	[RST_QUSB2_PHY_BCR]		=3D { 0x4103c },
> 	[RST_USB_HS_PHY_CFG_AHB_CBCR]	=3D { 0x41030 },

[Severity: High]
Are we targeting the Clock Branch Control Register (CBCR) here instead of t=
he
Block Control Register (BCR)?

By omitting .bit, the reset framework defaults to bit 0, which is the clock
enable bit for CBCRs. When a subsystem requests a block reset, the driver
will toggle the clock enable bit instead of actually resetting the hardware
block. This corrupts the clock's enabled/disabled state behind the
framework's back and fails to reset the hardware.

> 	[RST_USB2_HS_PHY_ONLY_BCR]	=3D { 0x41034 },
> 	[RST_USB_FS_BCR]		=3D { 0x3f000 },
> 	[RST_CAMSS_CSI1PIX_CBCR]	=3D { 0x4f058 },
> 	[RST_CAMSS_CSI_VFE1_CBCR]	=3D { 0x58074 },
> 	[RST_CAMSS_VFE1_CBCR]		=3D { 0x5805c },
> 	[RST_CAMSS_CPP_CBCR]		=3D { 0x5803c },

[Severity: High]
Do these CAMSS entries also incorrectly target CBCR registers instead of th=
eir
respective BCR hardware reset registers? Similar to the USB reset above, th=
is
could break hardware state recovery for fundamental blocks by toggling clock
enablements instead.

> 	[RST_MSS_BCR]			=3D { 0x71000 },
> 	[RST_MDSS_BCR]			=3D { 0x4d074 },
> };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D2
