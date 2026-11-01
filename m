Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF66606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojzU3fya
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B8D910E3B6;
	Sun,  1 Nov 2026 23:38:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B2410E3B6
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:38:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7E2A60A50;
 Sun,  1 Nov 2026 23:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344DF1F00919;
 Sun,  1 Nov 2026 23:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793576323;
 bh=Juti9EcHeNFsMBB/29LIEyiqTgwCQ4NeUM7qAEas7Fk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ojzU3fyawC8EDIJXmoX6BReXYnKNFTQgMk7zQ83apVqS6NPtLj9RX2d62VFD0Zy5j
 0LBnCuO7tL8Qdil4eT8xiGbD56IJnJlUm9Go6XzNZK82SKgpRR5nhmrqPp2UKAdV8p
 SXeQUJGzIeMUYy9U7y+mZHFBGXfYQiGfDfBK7Iw+ZTZDGIfVZl7Y2/NmbM0PbuLpUg
 NIVbJYt3MiM4PvGzxd5cL6oFEDsoQIsJQj3QqhKtEwAxRCUUC+Yhk1y7TaFYp3egKg
 a1SSq040J8dW420d+j3U1ANmW/cOuF1G0/vwG+wTHYO1N+P6Rpa0NWKYxnHZvwcwQC
 gWudeSGBfWUhg==
Message-ID: <sashiko-outbox-192760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/12] arm64: dts: qcom: sm6350-lena: Add flash LED
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102-pdx213-upstream-3-v3-1-cdc3be96d257@erebion.eu>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-1-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:38:42 +0000
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
- [Medium] arm64: dts: qcom: sm6350-lena: invalid led-max-microamp in pm615=
0l_flash
--

commit c063589d95e3f37ff34d230113ce64e10e062736
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: Add flash LED

This commit adds a devicetree node for the camera flash LED on the Sony
Xperia 10 III (pdx213).

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 6e2bbf4f060ac..6942a117d41cf 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts

[ ... ]

> @@ -302,6 +304,19 @@ touchscreen@48 {
>  	};
>  };
> =20
> +&pm6150l_flash {
> +	status =3D "okay";
> +
> +	led-0 {
> +		function =3D LED_FUNCTION_FLASH;
> +		color =3D <LED_COLOR_ID_WHITE>;
> +		led-sources =3D <1>;
> +		led-max-microamp =3D <1500000>;
> +		flash-max-microamp =3D <1000000>;

[Severity: Medium]
Is led-max-microamp =3D <1500000> in pm6150l_flash intended here, or was a =
lower
continuous torch current limit such as 150000 uA meant instead?

In Documentation/devicetree/bindings/leds/common.yaml and
Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml,
led-max-microamp specifies the maximum continuous torch current, whereas
flash-max-microamp specifies the pulsed strobe flash current. The binding
schema constrains led-max-microamp to a maximum of 500000 uA for a single
channel (or 1000000 uA for two ganged channels):

Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml:
      led-max-microamp:
        anyOf:
          - minimum: 5000
            maximum: 500000
            multipleOf: 5000
          - minimum: 10000
            maximum: 1000000
            multipleOf: 10000

Setting led-max-microamp to 1500000 uA causes dtbs_check validation to fail
and sets the continuous torch limit higher than flash-max-microamp
(1000000 uA).

At runtime, when qcom_flash_led_probe() calls qcom_flash_register_led_devic=
e()
in drivers/leds/flash/leds-qcom-flash.c for a single-channel LED
(led-sources =3D <1>), the driver clamps led-max-microamp to the hardware p=
er-
channel maximum of 500000 uA (TORCH_CURRENT_MAX_UA):

drivers/leds/flash/leds-qcom-flash.c:qcom_flash_register_led_device() {
	...
	current_ua =3D min_t(u32, current_ua, TORCH_CURRENT_MAX_UA * led->chan_cou=
nt);
	led->max_torch_current_ma =3D current_ua / UA_PER_MA;
	...
}

This allows up to 500 mA in continuous torch mode rather than a board-speci=
fic
torch limit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-pdx213-ups=
tream-3-v3-0-cdc3be96d257@erebion.eu?part=3D1
