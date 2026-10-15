Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B30CC6B2D
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8518910FFF3;
	Thu, 15 Oct 2026 00:02:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A62F10FFF3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:02:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AC18417F8;
 Thu, 15 Oct 2026 00:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884311F000C4;
 Thu, 15 Oct 2026 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792022567;
 bh=atpSlH/wAgVRNP5peMXukrGS8F/DJgQrL7zXrHK8OGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jYEGBubwYapKUW2UI9n3qrk/ZO28feF+As3HuZ+vFlSkPOXZjhM+hEyT4qqrvHywc
 ua6E/gpJsmnuvKM0foNPWTdQYS1vCEdMrPYNOFHoE91oJetFXpqz0rO0SFATEy5xSB
 jfe7XxEfN9cTR+W0uaSk77jdP/ioP4I73Acu74p2oR+fYBP3wsj2kGpnCuTSij28aX
 PhXwrNNLHpEZFgze5VkNsKRA5BkVGEOGjTtvx5Q42jwZ2fiOoSBfH5/uKzQFzijtFI
 quRu0kckpBv6utVTOFLrr9O4a1MW4yM9JpJsKN01YAkyRZLVja6SY+PS5z9zFXTnIr
 wz3DA89YIs0Gg==
Message-ID: <sashiko-outbox-172044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: add device tree for SDM845-HDK
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261015-sdm845-hdk-v3-4-1c179cd0d16f@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
 <20261015-sdm845-hdk-v3-4-1c179cd0d16f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 00:02:47 +0000
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
- [High] dts: qcom: swapped regulators in usb_1_qmpphy
- [Medium] dts: qcom: sdm845-hdk: home_pin_a pinctrl incorrectly configures=
 gpio6 instead of gpio5
--

commit b19f01b97eae7ab58c2051c6b112862e84428095
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

arm64: dts: qcom: add device tree for SDM845-HDK

Add device tree for the Qualcomm / Lantronix SDM845 HDK. It is the
development platform using the modem-less (SDA845) SoC, optional onboard
DSI panel and a rich set of connectors.

> diff --git a/arch/arm64/boot/dts/qcom/sdm845-hdk.dts b/arch/arm64/boot/dt=
s/qcom/sdm845-hdk.dts
> new file mode 100644
> index 0000000000000..450bbb9b9d19d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-hdk.dts
> @@ -0,0 +1,824 @@

[ ... ]

> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +		autorepeat;
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&home_pin_a>, <&vol_up_pin_a>;
> +
> +		key-home {
> +			label =3D "Home";
> +			linux,code =3D <KEY_HOMEPAGE>;
> +			gpios =3D <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
> +		};

[ ... ]

> +&pm8998_gpios {
> +	home_pin_a: home-active-state {
> +		pins =3D "gpio6";

[Severity: Medium]
Is this pinctrl configuration targeting the wrong pin?

The key-home node maps the Home button to PMIC GPIO 5, but its assigned
pinctrl state home_pin_a here configures gpio6. This might cause the
physical Home button to float or fail to work properly.

> +		function =3D "normal";
> +		input-enable;
> +		bias-pull-up;
> +		qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_NO>;
> +	};

[ ... ]

> +&usb_1_qmpphy {
> +	vdda-phy-supply =3D <&vreg_l26a_1p2>;
> +	vdda-pll-supply =3D <&vreg_l1a_0p88>;

[Severity: High]
Are these regulator assignments inverted?

Across other QMP PHYs for SDM845 (like pcie0_phy and ufs_mem_phy), the 0.88V
regulator is mapped to the core PHY supply and the 1.2V regulator to the
PLL supply. Reversing these voltages applies 1.2V to the 0.88V domain and
0.88V to the 1.2V domain, which may lead to hardware damage or cause the
USB3 PHY to fail.

> +
> +	status =3D "okay";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-sdm845-hdk=
-v3-0-1c179cd0d16f@oss.qualcomm.com?part=3D4
