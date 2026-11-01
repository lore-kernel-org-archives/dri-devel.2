Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC6606A326
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1FcLBzq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BCD010E032;
	Sun,  1 Nov 2026 23:38:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139CF10E032
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:38:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6E1443695;
 Sun,  1 Nov 2026 23:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611A91F000C1;
 Sun,  1 Nov 2026 23:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793576292;
 bh=qDEkJ+y7fTxS070doIg4meeeWl+CCzsZV4heyjcpoSU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W1FcLBzqM8BVBVSfwWy4Lp7mzUQquycCHMhsTyTBhGWnVGGBZswcnGdUFRF7+vdyJ
 yd0TpUOgQSJq++xnMSgMDsJuUAsK2LMVSer6aHzN0cbNjszAFFkWsjGOUMI5S6KeQU
 zHSq+s9cr/3lHhmTyZqu5xahZ/x6vTI1rVD/VZuDLnQkrDZwf+DfqIaRs2U0NrRuv6
 2A5wPfZ4u3wFAWIuAPrA2E8CEW6XuXPMK1wGFb0EVekHQDZm/tsN0AKtzcALe9yBnM
 nnerBFyPGDxDmpU19Wrkf1LI3kb/chod8FVrEpTuFMYe+6cFsHbZCXrejSwfAGxdJu
 /SNV3O0puP4HA==
Message-ID: <sashiko-outbox-192758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/12] arm64: dts: qcom: sm6350-lena: rename
 touch-en-regulator
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102-pdx213-upstream-3-v3-2-cdc3be96d257@erebion.eu>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-2-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:38:11 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: sm6350-lena: stray unused regulator-lcdb-dummy=
 node
- [Medium] arm64: dts: qcom: sm6350-lena: invalid led-max-microamp in pm615=
0l_flash
--

commit e7731bb19fd5c211a5eb8caeb5f7301cbd391239
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: rename touch-en-regulator

This commit renames touch-en-regulator to regulator-touch-en in
sm6350-sony-xperia-lena-pdx213.dts to keep fixed-regulator nodes sorted
together, and also adds a regulator-lcdb-dummy fixed-regulator node.

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 6942a117d41cf..9295b2e6f179f 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -46,7 +46,16 @@ key-volume-down {
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

[Severity: Medium]
Was regulator-lcdb-dummy included in this patch by mistake?

The commit message states that this change only renames touch-en-regulator =
to
regulator-touch-en, and nothing in sm6350-sony-xperia-lena-pdx213.dts or its
included dtsi files references the lcdb_dummy phandle, which results in an
unused always-on fixed regulator being registered at boot.

> +
> +	touch_en_vreg: regulator-touch-en {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "touch_en_vreg";
>  		gpio =3D <&tlmm 10 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Further down in arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts,
is led-max-microamp in the pm6150l_flash node configured with an out-of-ran=
ge
value?

arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts:
&pm6150l_flash {
	status =3D "okay";

	led-0 {
		function =3D LED_FUNCTION_FLASH;
		color =3D <LED_COLOR_ID_WHITE>;
		led-sources =3D <1>;
		led-max-microamp =3D <1500000>;
		flash-max-microamp =3D <1000000>;
		flash-max-timeout-us =3D <1280000>;
	};
};

In Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml,
led-max-microamp specifies the maximum continuous torch current, which is
limited to 500000 uA for a single channel (or 1000000 uA across two ganged
channels):

      led-max-microamp:
        anyOf:
          - minimum: 5000
            maximum: 500000
            multipleOf: 5000
          - minimum: 10000
            maximum: 1000000
            multipleOf: 10000

Setting led-max-microamp to 1500000 uA on a single channel causes dtbs_check
validation to fail, configures the continuous torch current higher than
flash-max-microamp (1000000 uA), and causes qcom_flash_register_led_device()
in drivers/leds/flash/leds-qcom-flash.c to clamp the torch current to the
500000 uA PMIC channel limit:

	current_ua =3D min_t(u32, current_ua, TORCH_CURRENT_MAX_UA * led->chan_cou=
nt);
	led->max_torch_current_ma =3D current_ua / UA_PER_MA;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-pdx213-ups=
tream-3-v3-0-cdc3be96d257@erebion.eu?part=3D2
