Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A6606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8xo1RPq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43E110E03F;
	Wed, 28 Oct 2026 11:28:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E368510E03F
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:28:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A79443A6D;
 Wed, 28 Oct 2026 11:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E8D1F031E1;
 Wed, 28 Oct 2026 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793186917;
 bh=iJThpt3wCaw21tvb3jioV8nU1M0htI/CM4Pk5Zc2xX0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M8xo1RPq3m1el5NnQFxaMNYToKnJOouDD6hjkVmwaTEouQhhSn5TJqkJGFnBoOd7B
 jJo3D3ac51iHmLzrlyHvXYRqs6nOYjNtcRXSlNa6C40R4hlTST/PLMW4ELpiqMPeQM
 Ilmb5HzKvPsqnLNmpifl/qWsKjMbhztF1oalJ/97ITEw/338h3/9cDoGFqCdMv/mLx
 7gEHfgaJK6x17g6y0IvJfY3fBlASqqgUm9D1fhwc5pCxSQS1zijx2JB+yNHCrw6/Bk
 KQJUGGBswXsaWexFfNYga5Gol/Sa3oVGf8TRjjqnzq91gM89bGaSuc2pbKTdk2gVrj
 CsL/tYrmrnwIQ==
Message-ID: <sashiko-outbox-187817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/11] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261028-msm8952-initial-support-v6-11-e07ddd8bcf4c@mainlining.org>
References: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
 <20261028-msm8952-initial-support-v6-11-e07ddd8bcf4c@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:28:36 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: shamrock: missing color property on status LED=
s breaks RGB
--

commit 8fec21f5539dc733f3dc08f3078a4a994d335e11
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: generalmobile-shamrock: new device

This commit adds initial device tree support for the Qualcomm MSM8952-based
General Mobile GM 5 Plus (shamrock) smartphone.

> diff --git a/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts =
b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> new file mode 100644
> index 0000000000000..26a269f0f7694
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> @@ -0,0 +1,439 @@
[ ... ]
> +	multi-led {
> +		compatible =3D "leds-group-multicolor";
> +		color =3D <LED_COLOR_ID_RGB>;
> +		function =3D LED_FUNCTION_INDICATOR;
> +		leds =3D <&red_status>, <&green_status>, <&blue_status>;
> +	};
[ ... ]
> +	led-controller@68 {
> +		compatible =3D "si-en,sn3193";
> +		reg =3D <0x68>;
> +
> +		shutdown-gpios =3D <&tlmm 68 GPIO_ACTIVE_HIGH>;
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		red_status: led@1 {
> +			reg =3D <1>;
> +			label =3D "red:status";
> +			led-max-microamp =3D <17500>;
> +		};
> +
> +		green_status: led@2 {
> +			reg =3D <2>;
> +			label =3D "green:status";
> +			led-max-microamp =3D <17500>;
> +		};
> +
> +		blue_status: led@3 {
> +			reg =3D <3>;
> +			label =3D "blue:status";
> +			led-max-microamp =3D <17500>;
> +		};
> +	};

[Severity: Medium]
Should the child LED nodes under led-controller@68 use the color and functi=
on
properties instead of the deprecated label property?

When is31fl319x_probe() registers each child LED via
devm_led_classdev_register_ext(), led_classdev_register_ext() in
drivers/leds/led-class.c only populates led_cdev->color when the color
property is present on the node:

	if (fwnode_property_present(init_data->fwnode, "color"))
		fwnode_property_read_u32(init_data->fwnode, "color",
					 &led_cdev->color);

Because red_status, green_status, and blue_status only specify label and om=
it
color, led_cdev->color remains 0 (LED_COLOR_ID_WHITE) for all three LEDs.

When leds_gmc_probe() in drivers/leds/rgb/leds-group-multicolor.c subsequen=
tly
probes the multi-led node, it sets each channel's color_index from
led_cdev->color:

	for (i =3D 0; i < count; i++) {
		struct led_classdev *led_cdev =3D priv->monochromatics[i];

		subled[i].color_index =3D led_cdev->color;

		/* Configure the LED intensity to its maximum */
		subled[i].intensity =3D max_brightness;
	}

Without color =3D <LED_COLOR_ID_RED>, <LED_COLOR_ID_GREEN>, and
<LED_COLOR_ID_BLUE> on led@1, led@2, and led@3, multi_index in sysfs reports
"white white white" instead of "red green blue".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-msm8952-in=
itial-support-v6-0-e07ddd8bcf4c@mainlining.org?part=3D11
