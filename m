Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC3BC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D9810EC2B;
	Tue,  1 Sep 2026 09:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G2Suoa56";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B82610EC2B
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:05:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEAA560202;
 Tue,  1 Sep 2026 09:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CD21F000E9;
 Tue,  1 Sep 2026 09:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253554;
 bh=KuVUUMiVWKPGBNQcqJbw1KvuVeRdOIBJTa4lJGyOfAA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G2Suoa56LmItPitqcrgmvFckWKptoO4z7yocRcIxj937eqUwo0x/iJoOn0K2tNBQN
 KQWZb8Z2HdW799daWVCNCaeAeYd8/ZevbFQPRHLQs3mK7wW4m01g8dcxDu+8jBi4rm
 lhLcct79lWraRpaExVCi5ymsfcNRxzuBKlkyMJIylakx9dhlkQxHgv9QgmTWM40sbJ
 uQ1pPpX7uvrxyVjMDGJyYje6/IhnUDj8hDIXlcUsGvYq4MZSALW+/yLwEEDwauR3kY
 ZpItviWB7+X4FXrvYg+MrLDz65rGBk6BXLu6grOsdfd0aCBCuIBZIUrYBLsvFwGIjg
 wvZ0C2C8wOiFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
To: "Xilin Wu" <sophon@radxa.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260901-q8b-dts-v1-6-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-6-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:05:52 +0000
Message-Id: <20260901090553.74CD21F000E9@smtp.kernel.org>
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
- [High] Swapped voltage regulators for the DP2 PHY.
--

commit be4c87024201f57f02fd6174d5602a08840ba63a
Author: Xilin Wu <sophon@radxa.com>

arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

This commit adds initial device tree support for the Radxa Dragon Q8B, based
on the Qualcomm Snapdragon 8cx Gen 3 SC8280XP platform. It describes various
hardware components including storage, PCIe interfaces, USB, HDMI output, a=
nd
audio.

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts b/arc=
h/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> new file mode 100644
> index 0000000000000..1c0e94bba4d7d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts

[ ... ]

> +&mdss0_dp2_phy {
> +	vdda-phy-supply =3D <&vreg_l3b>;
> +	vdda-pll-supply =3D <&vreg_l6b>;

[Severity: High]
Are these voltage regulators swapped for the DP2 PHY? vreg_l3b provides
1.2V and vreg_l6b provides 0.88V, but the PHY requires ~0.88V and the PLL
requires 1.2V.

If vdda-phy-supply receives 1.2V, it violates the physical hardware
configuration which expects ~0.88V. This could cause the DP PHY to fail,
preventing DisplayPort output, and potentially risk hardware damage due to
overvoltage on the PHY rail.

> +
> +	status =3D "okay";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D6
