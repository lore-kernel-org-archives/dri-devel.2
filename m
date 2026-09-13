Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F701C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8265F8910E;
	Sun, 13 Sep 2026 20:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A9myeAzE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3C08910E
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:27:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF79C400FE;
 Sun, 13 Sep 2026 20:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451271F000FF;
 Sun, 13 Sep 2026 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789331269;
 bh=HYjO40TTJHmr4WU71qfoKNSqdL0KW4ZzobINfyQbEgY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A9myeAzE4UYgy1WFDDtNh6GcnA+ayf31Q5eGZsxQGrz4lQ6RUrKYUi21R9bJSjbf0
 HEnXCVdQXWtFSVt3aQN1TuShjBJgFx4VBcF8I7yHr8GlDX74RUH3sNHIuKFQATpS71
 Q0DnwkfF4yd7VTqhzY5xDEn1D3ywoY0QP2TFSMc+vajAovgmkV0ld8+UTqrgngLvY0
 oylhpL82fetmu7x/93pUfEwHm+PBThKlQcgk4k72EX6tMIuVEpzfv0QVV15sTD1dLT
 N6g3GVR3ge4AlrP1R+p4dbBf45JJKjD4l6q9f05QxhDBbmk0u1Qd83LWGHqbpI/6IK
 zfD9K1DCv25WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add Lenovo ThinkPad T14s Gen 7
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260913201835.250085-4-srinivas.kandagatla@oss.qualcomm.com>
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260913201835.250085-4-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 20:27:48 +0000
Message-Id: <20260913202749.451271F000FF@smtp.kernel.org>
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
- [Medium] Missing pinctrl configuration for `vreg_misc_3p3` regulator enab=
le GPIO
- [Low] Unused `wcd_default` pinctrl configuration
--

commit d71c12fe04485a49b8c9508f6401f49a6f0252e9
Author: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

arm64: dts: qcom: Add Lenovo ThinkPad T14s Gen 7

Introduce a device tree for the Mahua-based Lenovo ThinkPad T14s Gen 7,
a Snapdragon X2 Elite laptop.

> diff --git a/arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7.dts=
 b/arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7.dts
> new file mode 100644
> index 0000000000000..be5f12bfe56a4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7.dts

[ ... ]

> +	vreg_edp_3p3: regulator-edp-3p3 {
> +		compatible =3D "regulator-fixed";
> +
> +		regulator-name =3D "VREG_EDP_3P3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		gpio =3D <&tlmm 70 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 =3D <&edp_reg_en>;
> +		pinctrl-names =3D "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_misc_3p3: regulator-misc-3p3 {
> +		compatible =3D "regulator-fixed";
> +
> +		regulator-name =3D "VREG_MISC_3P3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		gpio =3D <&pmh0110_f_e0_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};

[Severity: Medium]
Should vreg_misc_3p3 include pinctrl-0 =3D <&misc_3p3_reg_en>; and
pinctrl-names =3D "default"; properties?

Since the explicit pinctrl state for this GPIO (misc_3p3_reg_en) is defined
later in the file but never referenced, omitting it here might cause the PM=
IC
GPIO pad to lack the intended configuration (such as drive-push-pull and
power-source).

Could this fail to drive the enable pin correctly and leave the I2C touchpad
and keyboard unpowered?

[ ... ]

> +&tlmm {
> +	gpio-reserved-ranges =3D <4 4>,   /* EC TZ Secure I3C */
> +			       <10 2>,  /* OOB UART */
> +			       <27 1>,  /* TZ trigger  */
> +			       <44 4>,  /* TPM */
> +			       <139 1>; /* TZ trigger */

[ ... ]

> +	tpad_default: tpad-default-state {
> +		pins =3D "gpio3";
> +		function =3D "gpio";
> +		bias-disable;
> +	};
> +
> +	wcd_default: wcd-reset-n-active-state {
> +		pins =3D "gpio191";
> +		function =3D "gpio";
> +		drive-strength =3D <16>;
> +		bias-disable;
> +		output-low;
> +	};

[Severity: Low]
Is wcd_default still needed?

This pinctrl configuration is defined but never consumed by any device's
pinctrl-0 property. Since this board uses WSA8845 and DMICs for audio, it
appears a WCD audio codec reset GPIO is not required. Is this a remnant
from a reference design that can be removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913201835.2500=
85-1-srinivas.kandagatla@oss.qualcomm.com?part=3D3
