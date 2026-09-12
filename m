Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04059C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10A610E6B7;
	Sat, 12 Sep 2026 08:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C/IIgzXK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D672010E6B7
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:54:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 717F243885;
 Sat, 12 Sep 2026 08:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EA91F00893;
 Sat, 12 Sep 2026 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789203288;
 bh=Kds5i5eW8NniQqjztdR2pS/cbSIHifd1HmIJdy2YJBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C/IIgzXKnM9SDvwwUgK8JPV6W3L9hgohqnUgqu/Ae0OOahjUktx9go0LhCbSMfGic
 flGNLtA5d1/M44m3gKVs8anxTNIyFHR423OI2HRp/QRXCnolUk8XcKUf+SZGOfjflq
 viGpL2Vw0KtwSgkVjIzchzhEcxditR5ZkktjxhLa7A6d9A2MWmA9Zykz2vV2j6rN7I
 SKmhqiCSipX7kSNliW0Pn7vX5xq7IHtjqdZe1x7G7nT9RFAZb78ISOkQqE3zkcPltM
 KLzASnNwysYi1i28U1BvkrFu1mkNYc6Zvrcj+tnERLaAtYLo1XE5uURPD4x5lbwUV0
 +9Q2/rYPoixsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/20] clk: qcom: Add global clock controller driver
 for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com,
 linux-clk@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev,
 devicetree@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-2-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-2-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:54:47 +0000
Message-Id: <20260912085447.C2EA91F00893@smtp.kernel.org>
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
- [High] Duplicate CCF clock branches are registered for the same physical =
hardware registers (`0x58044` and `0x58048`), leading to state desynchroniz=
ation.
- [High] Incorrect parent map for `gp1_clk_src`, `gp2_clk_src`, and `gp3_cl=
k_src` causes rate setting to unconditionally fail.
- [High] Hardware resets are improperly mapped to Clock Branch Control Regi=
sters (CBCR) instead of Block Control Registers (BCR), causing them to togg=
le clock enablement instead of performing a hardware reset.
--

commit b4dadd423234c197ee41263628a67b773be1b25f
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

clk: qcom: Add global clock controller driver for MSM8952

This commit adds the global clock controller driver for MSM8952, providing
clocks, resets, and power domains for various SoC components. It ports the
GCC driver for the 8952 based on a downstream reference.

Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c

> diff --git a/drivers/clk/qcom/gcc-msm8952.c b/drivers/clk/qcom/gcc-msm895=
2.c
> new file mode 100644
> index 0000000000000..e75bf51ad4087
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-msm8952.c
[ ... ]
> +static const struct freq_tbl ftbl_gcc_gp1_3_clk[] =3D {
> +	F(19200000, P_XO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gp1_clk_src =3D {
> +	.cmd_rcgr =3D 0x08004,
> +	.mnd_width =3D 8,
> +	.hid_width =3D 5,
> +	.parent_map =3D gcc_gpll0_map,

[Severity: High]
Will this cause rate setting to fail for the general-purpose clocks?
The frequency table ftbl_gcc_gp1_3_clk requests P_XO as the parent source,
but the parent map gcc_gpll0_map does not contain an entry for P_XO. When t=
he
clock framework attempts to configure the parent, it will search for P_XO a=
nd
return -ENOENT. Does this parent map need to be updated to one that includes
P_XO?

> +	.freq_tbl =3D ftbl_gcc_gp1_3_clk,
[ ... ]
> +static struct clk_rcg2 gp2_clk_src =3D {
> +	.cmd_rcgr =3D 0x09004,
> +	.mnd_width =3D 8,
> +	.hid_width =3D 5,
> +	.parent_map =3D gcc_gpll0_map,

[Severity: High]
Does this have the same parent map issue as gp1_clk_src?

> +	.freq_tbl =3D ftbl_gcc_gp1_3_clk,
[ ... ]
> +static struct clk_rcg2 gp3_clk_src =3D {
> +	.cmd_rcgr =3D 0x0a004,
> +	.mnd_width =3D 8,
> +	.hid_width =3D 5,
> +	.parent_map =3D gcc_gpll0_map,

[Severity: High]
Does this also need to be updated to a parent map containing P_XO?

> +	.freq_tbl =3D ftbl_gcc_gp1_3_clk,
[ ... ]
> +static struct clk_branch gcc_camss_vfe0_ahb_clk =3D {
> +	.halt_reg =3D 0x58044,
[ ... ]
> +static struct clk_branch gcc_camss_vfe0_axi_clk =3D {
> +	.halt_reg =3D 0x58048,
[ ... ]
> +static struct clk_branch gcc_camss_vfe_ahb_clk =3D {
> +	.halt_reg =3D 0x58044,

[Severity: High]
Are these duplicate clock branches intentional? Both gcc_camss_vfe0_ahb_clk
and gcc_camss_vfe_ahb_clk map to the exact same physical hardware register
(0x58044). If different consumer drivers request these two different clock
abstractions for the same hardware bit, couldn't one driver disable the
clock while the other expects it to be on, causing unexpected hardware
failures?

> +	.clkr =3D {
> +		.enable_reg =3D 0x58044,
[ ... ]
> +static struct clk_branch gcc_camss_vfe_axi_clk =3D {
> +	.halt_reg =3D 0x58048,

[Severity: High]
Similarly, does this duplicate the gcc_camss_vfe0_axi_clk definition for
register 0x58048? This might lead to the same state desynchronization and
reference counting issues in the clock framework.

> +	.clkr =3D {
> +		.enable_reg =3D 0x58048,
[ ... ]
> +static const struct qcom_reset_map gcc_msm8952_resets[] =3D {
> +	[RST_CAMSS_MICRO_BCR]		=3D { 0x56008 },
> +	[RST_USB_HS_BCR]		=3D { 0x41000 },
> +	[RST_QUSB2_PHY_BCR]		=3D { 0x4103c },
> +	[RST_USB_HS_PHY_CFG_AHB_CBCR]	=3D { 0x41030 },

[Severity: High]
Could this reset mapping cause unintended behavior? It maps to a Clock
Branch Control Register (CBCR) instead of a Block Control Register (BCR).
Without specifying a bit, it defaults to bit 0, which is the CLK_ENABLE bit
for the CBCR. When a peripheral driver triggers this reset, will it
accidentally toggle the clock enable state rather than performing a true
hardware reset?

> +	[RST_USB2_HS_PHY_ONLY_BCR]	=3D { 0x41034 },
> +	[RST_USB_FS_BCR]		=3D { 0x3f000 },
> +	[RST_CAMSS_CSI1PIX_CBCR]	=3D { 0x4f058 },
> +	[RST_CAMSS_CSI_VFE1_CBCR]	=3D { 0x58074 },
> +	[RST_CAMSS_VFE1_CBCR]		=3D { 0x5805c },
> +	[RST_CAMSS_CPP_CBCR]		=3D { 0x5803c },

[Severity: High]
Do these entries also incorrectly map to CBCR registers rather than BCR
registers, potentially toggling clock enablement instead of performing a
hardware reset?

> +	[RST_MSS_BCR]			=3D { 0x71000 },
> +	[RST_MDSS_BCR]			=3D { 0x4d074 },
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D2
