Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B3BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A731510E27C;
	Wed,  1 Jul 2026 20:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CTb/xXVr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D14610E27C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 20:59:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4877643886;
 Wed,  1 Jul 2026 20:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE121F000E9;
 Wed,  1 Jul 2026 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782939597;
 bh=bkKUvCtM0kKvV4ZEaYFCMgMq8+ov6kQny5Xhp2bmuC4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CTb/xXVrHaxJO+tBr/YcMgPIObq4u5EZh+r9kFGOEmW1AcbEha9y1lYW/Nl0zP0s2
 Z8BTJ9YkVUN0ubxWlDPNzXc+WEhr8fn5/gMT0LnB0N8VG7tSk7gU4tZvT1SlIF2SMM
 zubCxJgyZ5TI7uFdJFGAUexyHRPMaoPduH3QYRiNnUc1EZA4l6fHcOLmU40YGM2HD1
 Jf6fqJyFeBXkZ9YXumoStedrgLHw0b5m6Pw1QfiSE+wqpt/fiG7SdsuSsHVZv3hNRq
 lt9bHBlqX0m/V3dtodSa37EDz+9UoZqHGOIylwuMPGGgpRHAnU78rpxYA0xxAF7im8
 qeC8ZPwpP5/qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
To: "Cristian Cozzolino" <cristian_ci@protonmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-rimob-new-features-v6-1-be7d5d1e007f@protonmail.com>
References: <20260701-rimob-new-features-v6-0-be7d5d1e007f@protonmail.com>
 <20260701-rimob-new-features-v6-1-be7d5d1e007f@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:59:56 +0000
Message-Id: <20260701205956.EDE121F000E9@smtp.kernel.org>
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
- [Low] The panel's compatible property is missing the mandatory generic fa=
llback string.
--

commit 14ab3e4951175e1cf33309cf294f421f36606cd0
Author: Cristian Cozzolino <cristian_ci@protonmail.com>

arm64: dts: qcom: msm8953-flipkart-rimob: Enable display and GPU
   =20
This commit adds the description for the display panel found on the phone.
It also enables the GPU and sets the zap shader firmware path.

> diff --git a/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts b/arch/a=
rm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
> index ef4faf7631327..5a9d71d1e4664 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
[ ... ]
> @@ -87,11 +94,70 @@ &hsusb_phy {
>  	status =3D "okay";
>  };
> =20
[ ... ]
> +&mdss_dsi0 {
> +	vdda-supply =3D <&pm8953_s3>;
> +	vddio-supply =3D <&pm8953_l6>;
> +
> +	status =3D "okay";
> +
> +	panel: panel@0 {
> +		compatible =3D "flipkart,rimob-panel-nt35532-cs";

[Severity: Low]
Is the generic fallback string missing from this compatible property?

The DT schema for this panel (novatek,nt35532.yaml) strictly requires two i=
tems
for the compatible property: the device-specific string and the generic fal=
lback
"novatek,nt35532". Providing only the device-specific string violates the
binding and will trigger a dtbs_check warning.

> +		reg =3D <0>;
> +
> +		backlight =3D <&pmi8950_wled>;
> +		reset-gpios =3D <&tlmm 61 GPIO_ACTIVE_LOW>;
> +		avdd-supply =3D <&lab>;
> +		avee-supply =3D <&ibb>;
> +		vci-supply =3D <&pm8953_l17>;
> +		vddi-supply =3D <&pm8953_l6>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-rimob-new-=
features-v6-0-be7d5d1e007f@protonmail.com?part=3D1
