Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F20606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqWmQMF8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8EC10EC1A;
	Wed, 18 Nov 2026 12:27:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9BE10EC1A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:27:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 036D662160;
 Wed, 18 Nov 2026 12:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F1F1F000C4;
 Wed, 18 Nov 2026 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795004830;
 bh=IF0/oHGV7P/rpt91jQULrBeSJxduK1eVC6UzBiUzwiQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EqWmQMF8YFOQY7gS9rKWBwLicWImQ/V1dCKkxdNtL6VYNIKu7NB38yVfVY5nLLeFI
 m/Y3CFr2Z5ru2xvnrWAB8GXVlcMGlP9hNw8AHlQto3SF+aBBVZyk+fTIGqGYtUGg1q
 oYc6Iczqilk/pmqFqu54fW7aRxE3GTOGF7CZXTWpKeh8TO6/bokTd7cEAkeOzABM+A
 1VXxXOIOdMYiMPc18YtXOUH7PCIKlBZJv4JbSXRyVX+8xHaqLj3+bHr0DDbNkwbkUL
 xLMzreQd+NyT8A7V7cGqpstVhblxEWmXg4u4I+Hi+hMukUlJd8eXgKw48rfqUDC/BA
 BQS0q995wt9Ig==
Message-ID: <sashiko-outbox-220912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: sm8250-lg-timelm: add
 SW42902 touchscreen
To: "Abdur Rofik" <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261118120714.31505-9-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
 <20261118120714.31505-9-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:27:09 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] Input: sw42902: unbalanced regulator_bulk_disable() in
  sw42902_power_off()
--

commit 675fc0153d8629f5c836725c06a791bb2e0ad680
Author: Abdur Rofik <rofikcoga@gmail.com>

arm64: dts: qcom: sm8250-lg-timelm: add SW42902 touchscreen

This commit adds the SW42902 touchscreen node on I2C13 along with its fixed
regulator supplies and interrupt pinctrl state for the LG V60 ThinQ 5G
(timelm).

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/b=
oot/dts/qcom/sm8250-lg-timelm.dts
> index d307a52cd0e62..be5b894b677bb 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts

[ ... ]

> @@ -461,6 +479,29 @@ zap-shader {
>  	};
>  };
> =20
> +&i2c13 {
> +	status =3D "okay";
> +	clock-frequency =3D <400000>;
> +
> +	touchscreen@48 {
> +		compatible =3D "lg,sw42902";
> +		reg =3D <0x48>;
> +
> +		interrupt-parent =3D <&tlmm>;
> +		interrupts =3D <39 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&ts_int_default>;
> +
> +		reset-gpios =3D <&tlmm 38 GPIO_ACTIVE_LOW>;
> +		vcl-supply =3D <&reg_ts_vcl>;
> +		vdd-supply =3D <&reg_ts_vdd>;

[Severity: Medium]
Can binding this node trigger an unbalanced regulator_bulk_disable() on
ts->supplies in the driver added by commit "Input: touchscreen: add Silicon
Works SW42902 support"?

sw42902_probe() registers the sw42902_power_off() devres action right after
devm_regulator_bulk_get(), before sw42902_power_on() enables the vcl and vdd
regulators:

drivers/input/touchscreen/sw42902.c:sw42902_probe() {
	...
	error =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies), ts->suppl=
ies);
	if (error)
		return dev_err_probe(dev, error, "failed to get regulators\n");

	error =3D devm_add_action_or_reset(dev, sw42902_power_off, ts);
	if (error)
		return error;
	...
	error =3D sw42902_power_on(ts);
	if (error)
		return error;
	...
}

If an intermediate call such as devm_request_threaded_irq() or
regulator_bulk_enable() inside sw42902_power_on() fails, devres runs
sw42902_power_off() and calls regulator_bulk_disable() on supplies that were
never enabled, underflowing the regulator enable count and triggering a
WARN_ON() in _regulator_disable().  Unbinding the device while suspended has
the same effect because sw42902_suspend() already called sw42902_power_off()
without tracking power state in sw42902_power_off().

Registering the devres action after sw42902_power_on() succeeds and skipping
sw42902_power_off() when ts->suspended is set would avoid disabling
already-disabled regulators.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118120714.3150=
5-1-rofikcoga@gmail.com?part=3D8
