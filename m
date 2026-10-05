Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF38CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DC310EBDC;
	Mon,  5 Oct 2026 07:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZCQ3JEmI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 718C810EBE7
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:35:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DD164359F;
 Mon,  5 Oct 2026 07:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10011F000FF;
 Mon,  5 Oct 2026 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791185729;
 bh=3F3QHfpvLBv4kZLQcz5gHkGDwleXMbGboGQTya8oXK8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZCQ3JEmIOCvqazhigP4NF6jCN4XgJOeMYiF8b/WsPdMzmqjquq+HfdqpFfhtVEicZ
 LHB4J3I/30P2DYK0fMt1+GMi1MN7krnrhtdKO+D7CoDnVIapm1mk8/973+vhnsDjcG
 FTS6ZIafYh2ZIScPToIaII0r/N+I2T15Elwjsh7K/YPUaZ7dNCd3uc+L6gnruJSwpB
 rTPyP/U4vi+iO8SagrzTPqfjbm5rCuDaFgsfMOLMz8Fn6TOKV4HhTmG+iQpaHyrAw5
 WycP/AkSqRKXQQ5YqCueImQ57HqUWkwYe17eGNJjDeIKz6xCRCRuYIxRSkozC+Wo7w
 Xdqry551kBf6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort
 controller
To: "Balaji Kalkonda" <balaji.kalkonda@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261005-kaanapali_dp-v1-3-6faeac3a6d59@oss.qualcomm.com>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-3-6faeac3a6d59@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 07:35:28 +0000
Message-Id: <20261005073528.C10011F000FF@smtp.kernel.org>
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
- [High] dts: qcom: mdss_dp0 incorrectly uses MX power domain instead of MM=
CX
--

commit 553dc7a911ae71f6e7c738ff40500145e878f936
Author: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>

arm64: dts: qcom: kaanapali: Add DisplayPort controller

This commit adds the device node for the DisplayPort controller on the
kaanapali platform. It configures the OPP table, clocks, power domain,
and connects it to the DPU and USB/DP QMP PHY.

> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dt=
s/qcom/kaanapali.dtsi
> index e48a179d07220..155c590c8eb60 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
[ ... ]
> @@ -3851,6 +3854,86 @@ mdss_dsi0_phy: phy@9ac1000 {
> =20
>  				status =3D "disabled";
>  			};
> +
> +			mdss_dp0: displayport-controller@9ad2000 {
> +				compatible =3D "qcom,kaanapali-dp";
[ ... ]
> +				operating-points-v2 =3D <&dp_opp_table>;
> +
> +				power-domains =3D <&rpmhpd RPMHPD_MX>;

[Severity: High]
Should this power domain be RPMHPD_MMCX instead of RPMHPD_MX?

When the mdss_dp0 DisplayPort controller is active and changes link rates,
its performance state votes will scale the MX (memory) voltage rail instead
of the MMCX (multimedia) rail.

Since the display hardware physically resides on the MMCX rail, could this
misrouting cause the MMCX rail to be starved of the required voltage? This
appears like it could lead to under-voltage, silent hardware hangs, and
display corruption, while unnecessarily elevating the memory domain voltage.
Sibling display subsystem components like mdss_mdp and mdss_dsi0 typically
use RPMHPD_MMCX.

> +
> +				phys =3D <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names =3D "dp";
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-kaanapali_=
dp-v1-0-6faeac3a6d59@oss.qualcomm.com?part=3D3
