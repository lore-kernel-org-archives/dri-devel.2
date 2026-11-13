Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfQlzg57
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99F910E5E6;
	Fri, 13 Nov 2026 01:38:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C9B10E5E6
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:38:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE8F3414CD;
 Fri, 13 Nov 2026 01:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1531F000C4;
 Fri, 13 Nov 2026 01:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533891;
 bh=jlDhs3c1raJ/mHbEiJHEARciOgXNbFdNwnMEavYyn5k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZfQlzg57AZk9X3vsfUpelx//fAOCraglnrugeZ837RcxAEez9gIUdfkNxUW+ROzXk
 j57qyaZ8P8ckwMUoypHOKxwcrGQ5d4Z9xTdiJReJC5xqokjhk86i+f1FGwiIGgeZzP
 RXnrrOdW2Up3QiqEyLBgdlrdG3sk7BRJz8GObwJRKGtQvkhGwDuo31ozpnn6Zwqj9A
 KIqIoSav7EfKbv40G39pduPVMwklQMS3u3fFyc2/feoikTubjVFlNObT+TGY7Ey2E3
 O/iviIKfH77M3KHZN54Rx83mIMOYA6s4sWHg05kuF8OqkX5eEcfmUSzwayDnxRkueR
 KziWb18iBxkyA==
Message-ID: <sashiko-outbox-212070@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/12] arm64: dts: qcom: sm6350-lena: Add PM6150L
 thermals
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-11-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-11-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:38:10 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] arm64: dts: qcom: sm6350-lena: handle used in Author and
  Signed-off-by
- [Medium] arm64: dts: qcom: sm6350-lena: inconsistent RFC_CAM_THERM
  pinctrl and ADC setup
- [Low] arm64: dts: qcom: sm6350-lena: thermal-sensor-msm ordered by
  label not name
--

commit e42ff4c503ef1827973e7803bdff8b39d54aacf7
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add PM6150L thermals
>
> Configure the thermals for the PA_THERM1, MSM_THERM, PA_THERM0,
> RFC_CAM_THERM, CAM_FLASH_THERM and QUIET_THERM thermistors connected to
> PM6150L.
>
> Due to hardware constraints we can only register 4 zones with
> pm6150l_adc_tm, the other 2 we can register via generic-adc-thermal.
>
> The trip points can really only be considered as placeholders, more
> configuration with cooling etc. can be added later.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Per Documentation/process/submitting-patches.rst, the Author header and
Signed-off-by trailer must use a real human name rather than an account
handle ("erebion").

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 79097ae409bab..d7a5df04a296c 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -61,6 +61,13 @@ key-volume-down {
>  		};
>  	};
> =20
> +	msm_therm_sensor: thermal-sensor-msm {
> +		compatible =3D "generic-adc-thermal";
> +		#thermal-sensor-cells =3D <0>;
> +		io-channels =3D <&pm6150l_adc ADC5_AMUX_THM2_100K_PU>;
> +		io-channel-names =3D "sensor-channel";
> +	};
> +
>  	touch_en_vreg: regulator-touch-en {

[Severity: Low]
This isn't a bug, but devicetree coding style orders nodes without unit
addresses alphabetically by node name rather than label, so
thermal-sensor-msm should be placed after reserved-memory and before
thermal-zones.

[ ... ]

> @@ -392,6 +467,83 @@ &mpss {
>  	status =3D "okay";
>  };
> =20
> +&pm6150l_adc {
> +	pinctrl-0 =3D <&pm6150l_adc_default>;
> +	pinctrl-names =3D "default";
> +
> +	channel@4d {
> +		reg =3D <ADC5_AMUX_THM1_100K_PU>;
> +		label =3D "pa_therm1";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@4e {
> +		reg =3D <ADC5_AMUX_THM2_100K_PU>;
> +		label =3D "msm_therm";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@4f {
> +		reg =3D <ADC5_AMUX_THM3_100K_PU>;
> +		label =3D "pa_therm0";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@54 {
> +		reg =3D <ADC5_GPIO3_100K_PU>;
> +		label =3D "rear_cam_flash_therm";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +
> +	channel@55 {
> +		reg =3D <ADC5_GPIO4_100K_PU>;
> +		label =3D "quiet_therm";
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		qcom,ratiometric;
> +	};
> +};

[ ... ]

> @@ -405,6 +557,14 @@ led-0 {
>  	};
>  };
> =20
> +&pm6150l_gpios {
> +	pm6150l_adc_default: adc-default-state {
> +		pins =3D "gpio6", "gpio7", "gpio10";
> +		function =3D PMIC_GPIO_FUNC_NORMAL;
> +		bias-high-impedance;
> +	};
> +};

[Severity: Medium]
Is the sixth thermistor (for rear camera) missing from pm6150l_adc, or
should gpio6 be dropped from pm6150l_adc_default?

The commit message describes six thermistors with two registered via
generic-adc-thermal, and pm6150l_adc_default configures three pins (gpio6,
gpio7, and gpio10) into high-impedance mode.  However, pm6150l_adc only
defines five channels (with only two gpio-backed inputs, channel@54 and
channel@55, omitting channel@53) and only one generic-adc-thermal sensor
(msm_therm_sensor) is registered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D11
