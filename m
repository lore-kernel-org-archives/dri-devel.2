Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066F606A326
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzO912Hw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0E510EAE8;
	Sun,  1 Nov 2026 23:48:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D19510EAE8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:48:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0846D43499;
 Sun,  1 Nov 2026 23:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DAA1F00A02;
 Sun,  1 Nov 2026 23:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793576891;
 bh=y8MYRhICvulHBlM0GysD+FdE3lutZrcN44qg6ngQ+z0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JzO912Hwkc/DUN3TWQUpBsNU1zzT7DJVZ6dEbKTdVZYzcl7kDW9WaX955NWe/W8Ar
 IG3o5ivLbE8CwTv/KZx6fbSyoRUv1GtzCD5gaS4JHwOyEOBRN+nIxLS//+Zsc2rnow
 9qbHGT3u2OVrGsOuO4Itn9P4Si5eQb/W7TamRhomb2HbBYW7s8YE+V2DtbSQYrZBd2
 laGVjICcAmqti6Y6kr2RefhuFN4gy/7Ae69+7L6Tfo5GFjLySfKhJgKn6yr4s167ng
 UHs2MWaDhdfzOTXZNqHr9UXI0WiAM1/9X2HSBkKD857Ym239jITPiuiogEnc1/i0BE
 rB72dfX4qwy1Q==
Message-ID: <sashiko-outbox-192773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/12] arm64: dts: qcom: sm6350-lena: enable
 remaining i2c busses
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102-pdx213-upstream-3-v3-12-cdc3be96d257@erebion.eu>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-12-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:48:11 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: sm6350-lena: unrelated and incomplete GPU enab=
lement
- [Medium] arm64: dts: qcom: sm6350-lena: wrong ADC channel in rear_cam_sen=
sor
- [Medium] arm64: dts: qcom: sm6350-lena: invalid led-max-microamp in pm615=
0l_flash
- [Low] arm64: dts: qcom: sm6350-lena: undocumented unused lcdb_dummy regul=
ator
--

commit dab0552e769e72745a887b1b9b15ebbca1b4c037
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: enable remaining i2c busses

This series enables peripheral, PMIC, thermal, LED, regulator, and bus node=
s in the device tree for the Sony Xperia 10 III (sm6350-sony-xperia-lena-pd=
x213).

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 6e2bbf4f060ac..d2b3aa6e61ab6 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
[ ... ]
> @@ -44,7 +63,30 @@ key-volume-down {
>  		};
>  	};
> =20
> -	touch_en_vreg: touch-en-regulator {
> +	lcdb_dummy: regulator-lcdb-dummy {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "lcdb_dummy";
> +		regulator-min-microvolt =3D <5500000>;
> +		regulator-max-microvolt =3D <5500000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};

[Severity: Low]
This isn't a bug, but commit e7731bb19fd5 ("arm64: dts: qcom: sm6350-lena:
rename touch-en-regulator") states that it only renames touch-en-regulator
to regulator-touch-en for sorting, while also adding this lcdb_dummy
regulator node.

Nothing in sm6350-sony-xperia-lena-pdx213.dts or sm6350.dtsi references
&lcdb_dummy. Was this node added by mistake, or should it be dropped until a
consumer uses it?

> +
> +	msm_therm_sensor: thermal-sensor-msm {
> +		compatible =3D "generic-adc-thermal";
> +		#thermal-sensor-cells =3D <0>;
> +		io-channels =3D <&pm6150l_adc ADC5_AMUX_THM2_100K_PU>;
> +		io-channel-names =3D "sensor-channel";
> +	};
> +
> +	rear_cam_sensor: thermal-sensor-rear-cam {
> +		compatible =3D "generic-adc-thermal";
> +		#thermal-sensor-cells =3D <0>;
> +		io-channels =3D <&pm6150l_adc ADC5_GPIO6_100K_PU>;
> +		io-channel-names =3D "sensor-channel";
> +	};

[Severity: Medium]
Does rear_cam_sensor fail to probe with -EINVAL here?

Under &pm6150l_adc below, the rear_cam_therm channel is defined on
channel@53 with reg =3D <ADC5_GPIO2_100K_PU> (since GPIO6 on PM6150L routes=
 to
ADC5_GPIO2_100K_PU):

	channel@53 {
		reg =3D <ADC5_GPIO2_100K_PU>;
		label =3D "rear_cam_therm";
		qcom,hw-settle-time =3D <200>;
		qcom,pre-scaling =3D <1 1>;
		qcom,ratiometric;
	};

However, rear_cam_sensor requests io-channels =3D <&pm6150l_adc
ADC5_GPIO6_100K_PU>. When gadc_thermal_probe() requests the channel,
adc5_fwnode_xlate() in drivers/iio/adc/qcom-spmi-adc5.c searches the
configured channels on &pm6150l_adc:

	for (i =3D 0; i < adc->nchannels; i++)
		if (adc->chan_props[i].channel =3D=3D iiospec->args[0])
			return i;

	return -EINVAL;

Because no channel is registered for ADC5_GPIO6_100K_PU (and
adc5_chans_pmic[] only defines ADC5_GPIO1_100K_PU through
ADC5_GPIO4_100K_PU), adc5_fwnode_xlate() returns -EINVAL and leaves
rear-cam-thermal without a working sensor.

Should rear_cam_sensor use ADC5_GPIO2_100K_PU instead of ADC5_GPIO6_100K_PU?

[ ... ]
> @@ -285,6 +470,21 @@ &gpi_dma1 {
>  	status =3D "okay";
>  };
> =20
> +&gpu {
> +	status =3D "okay";
> +};
> +
> +&gpu_zap_shader {
> +	firmware-name =3D "qcom/sm6350/sony/pdx213/a615_zap.mbn";
> +};

[Severity: Medium]
Was enabling &gpu and &gpu_zap_shader intended to be part of commit
dab0552e769e ("arm64: dts: qcom: sm6350-lena: enable remaining i2c busses")?

In addition to not matching the commit description, &mdss in sm6350.dtsi
remains disabled:

		mdss: display-subsystem@ae00000 {
			...
			status =3D "disabled";

			mdss_mdp: display-controller@ae01000 {
				compatible =3D "qcom,sm6350-dpu";

With the default drm/msm configuration (separate_gpu_kms =3D false),
adreno_probe() in drivers/gpu/drm/msm/adreno/adreno_device.c registers a
component and waits for the KMS master on mdss_mdp:

static int adreno_probe(struct platform_device *pdev)
{
	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
	    msm_gpu_no_components())
		return msm_gpu_probe(pdev, &a3xx_ops);

	return component_add(&pdev->dev, &a3xx_ops);
}

Because &mdss is disabled, the component master never probes and the GPU
component never binds (and if adreno_remove() runs while unbound,
platform_get_drvdata(pdev) is NULL and dereferencing priv->kms_init crashes=
).

Should the &gpu and &gpu_zap_shader changes be dropped from this I2C patch?

[ ... ]
> +&pm6150l_flash {
> +	status =3D "okay";
> +
> +	led-0 {
> +		function =3D LED_FUNCTION_FLASH;
> +		color =3D <LED_COLOR_ID_WHITE>;
> +		led-sources =3D <1>;
> +		led-max-microamp =3D <1500000>;
> +		flash-max-microamp =3D <1000000>;
> +		flash-max-timeout-us =3D <1280000>;
> +	};
> +};

[Severity: Medium]
Is led-max-microamp =3D <1500000> valid for a single flash channel here?

In Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml,
led-max-microamp (continuous torch current) is limited to 500000 uA for a
single channel or 1000000 uA for dual ganged channels, matching
TORCH_CURRENT_MAX_UA (500000) in drivers/leds/flash/leds-qcom-flash.c:

      led-max-microamp:
        anyOf:
          - minimum: 5000
            maximum: 500000
            multipleOf: 5000
          - minimum: 10000
            maximum: 1000000
            multipleOf: 10000

Setting led-max-microamp to 1500000 uA with led-sources =3D <1> fails
dtbs_check validation and sets the continuous torch current higher than both
the 500 mA hardware limit and the 1000000 uA flash-max-microamp strobe
current.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-pdx213-ups=
tream-3-v3-0-cdc3be96d257@erebion.eu?part=3D12
