Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFBDCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF8510FE67;
	Wed, 14 Oct 2026 16:31:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FEBA10FE40
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:31:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73F3E4354E;
 Wed, 14 Oct 2026 16:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BE61F000C4;
 Wed, 14 Oct 2026 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791995478;
 bh=yXRGjgtvWVK6g91h157yXzR4HkIoEPgS1TuZGqZYNzs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jLha2XIFwGUHNGqXStjCJjp5DSIwgQDTtfqPBsbJyb+Wq0nfARDh3dS+XVAXxufBL
 OhlCuMoV9hAHsrL9q8zmT4/G/MRH4aozn4RNbXHYZvfXDXwIy58afAGhkt0d8c+wcR
 Ls7scy6QzmYqcgo3c0F+WxGDhxGjHlEGjWFrFdv3o488o1hRMc3JLGixazMPrPCzE+
 gUMf971FNA5AThFyMUUQXmpWxcctw2G8UwIVimZ88W7FtYIhbV+6RZpOsQGV/uCtlA
 PKUpJa53xnprX1+IDaSsG6fXtfvHAyv3YPO8i6s5f+gzVXhVcBZf2hz117GRxpaHKh
 t0s5TMsu5H+vQ==
Message-ID: <sashiko-outbox-171533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: add device tree for SDM845-HDK
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014-sdm845-hdk-v2-4-6d0b4b42f267@oss.qualcomm.com>
References: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
 <20261014-sdm845-hdk-v2-4-6d0b4b42f267@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:31:17 +0000
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
- [High] dts: usb_1_qmpphy swaps vdda-phy and vdda-pll voltage supplies
- [Medium] dts: home_pin_a pinctrl incorrectly configures gpio6 instead of =
gpio5
- [Medium] dts: impossible 1.8V vin-supply for 3.3V fixed regulator vreg_sy=
s_bob_3p3
--

commit 48f1c407e24f3899e533d5dddbd59a77b4901a02
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

arm64: dts: qcom: add device tree for SDM845-HDK

This patch adds the device tree for the SDM845-HDK board, a development
platform utilizing the modem-less SDA845 SoC. It introduces initial support
for features like HDMI display, uSD, UFS, USB, and various onboard peripher=
als.

> diff --git a/arch/arm64/boot/dts/qcom/sdm845-hdk.dts b/arch/arm64/boot/dt=
s/qcom/sdm845-hdk.dts
> new file mode 100644
> index 0000000000000..4dd426912d20f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-hdk.dts

[ ... ]

> +	vreg_sys_bob_3p3: regulator-sys-bob {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "sys_bob";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply =3D <&vreg_s4a_1p8>;
> +	};

[Severity: Medium]
Is vreg_s4a_1p8 the correct vin-supply for this regulator?

vreg_s4a_1p8 provides 1.8V, but vreg_sys_bob_3p3 is defined as a 3.3V fixed
regulator. A fixed regulator cannot step up a 1.8V input to 3.3V.

Could this create an incorrect power dependency tree, potentially causing t=
he
1.8V supply to be kept awake unnecessarily or turned off while the 3.3V rail
is still needed?

[ ... ]

> +&pm8998_gpios {
> +	home_pin_a: home-active-state {
> +		pins =3D "gpio6";
> +		function =3D "normal";
> +		input-enable;
> +		bias-pull-up;
> +		qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_NO>;
> +	};

[Severity: Medium]
Does home_pin_a incorrectly configure gpio6 instead of gpio5?

Earlier in the file, the key-home node is defined to use gpio5:

		key-home {
			label =3D "Home";
			linux,code =3D <KEY_HOMEPAGE>;
			gpios =3D <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
		};

Configuring gpio6 here leaves gpio5 without its required pull-up configurat=
ion,
which could break the Home button. Additionally, since vol_up_pin_a also us=
es
gpio6, this results in gpio6 being configured twice.

[ ... ]

> +&usb_1_qmpphy {
> +	vdda-phy-supply =3D <&vreg_l26a_1p2>;
> +	vdda-pll-supply =3D <&vreg_l1a_0p88>;
> +
> +	status =3D "okay";
> +};

[Severity: High]
Are the voltage supplies for vdda-phy and vdda-pll swapped?

The QMP PHY expects a ~0.88V core supply and a 1.2V PLL supply. Assigning
vreg_l26a_1p2 (1.2V) to vdda-phy-supply and vreg_l1a_0p88 (0.88V) to
vdda-pll-supply applies excessive voltage to the 0.88V rail and insufficient
voltage to the 1.2V rail.

Could this reversed configuration lead to hardware failure or potential dam=
age?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-sdm845-hdk=
-v2-0-6d0b4b42f267@oss.qualcomm.com?part=3D4
