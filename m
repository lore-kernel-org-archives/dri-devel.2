Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FA2C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A4310E73A;
	Sat, 11 Jul 2026 06:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A4SGB3Fp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC6E10E737
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:15:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06399600C3;
 Sat, 11 Jul 2026 06:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A291F000E9;
 Sat, 11 Jul 2026 06:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750541;
 bh=lNhbMuMJ0S0HA6JMYfPVKHluRVkc+cjHyRfhVBBBzj4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A4SGB3FpXTeJGLr/oJghocT/mqEZl/w4FZOwwt+j2RskmxNJGH17obJXP7RxYlgaY
 bUzkwshZnflKoI7VxACpez2BcAZvX+YiIt3dwXxle2xUtcuTLiWZMglMIPqKwcylBW
 qF/9WDGF7NSbjLzCmaNCl0F30KTWxJ1HDC+DrdRr65joMh5VUndlhazdSOzl5UY+5i
 i2nrU+o59rx06boE8Xrl8m/skSN4EYN6V4nGo0K/rUXntrcZi51GEnr7k8qY7e2TdV
 6G2b8sG7HdunMXko7tsVIecC49rt+xqD6s7SIANP7k9EsTAPzvQwKxrx6zAs0SVqu/
 TFZbzPYkV2FuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/16] arm: dts: omap3pandora: Add device node for
 PCM1773 codec
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: lee@kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org,
 robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <db90762f9df023299a8855ed60482a056544d591.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <db90762f9df023299a8855ed60482a056544d591.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:15:40 +0000
Message-Id: <20260711061540.71A291F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Incorrect lifecycle for `devm_*` resource allocations in the ASoC =
component probe causes memory leaks and rebinding failures.
- [High] The driver swallows `-EPROBE_DEFER` from `devm_regulator_get()`, b=
reaking deferred probing for the VCC supply.
- [Low] The commit uses the deprecated property name `enable-gpio` instead =
of `enable-gpios`.
- [Low] Missing property definitions in the PCM1773 YAML binding schema wil=
l cause `dtbs_check` failures.
- [Low] Busy-waiting with `mdelay()` is used in a sleepable context.
--

--- Patch [12]: [PATCH 12/16] arm: dts: omap3pandora: Add device node for P=
CM1773 codec ---
commit 4dbdbb04f5f389f900287ce1a74c35a57890d4b3
Author: Grond <grond66@riseup.net>

arm: dts: omap3pandora: Add device node for PCM1773 codec

This commit adds a new device node for the PCM1773 codec to the OpenPandora
device tree. This ensures the new PCM1773 driver gets loaded automatically.

> diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/a=
rm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> --- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> @@ -42,6 +42,13 @@ tv_connector_in: endpoint {
>  		};
>  	};
> =20
> +	dac: pcm1773-codec {
> +		compatible =3D "ti,pcm1773";
> +		vcc-supply =3D <&vsim>;
> +		enable-gpio =3D <&gpio4 22 GPIO_ACTIVE_HIGH>; /* GPIO 118 */

[Severity: Low]
Is it expected to use the deprecated property name enable-gpio instead of t=
he
mandated enable-gpios suffix?

The standard requires the plural form even for single GPIOs.

> +		status =3D "okay";
> +	};
> +
>  	gpio-leds {

> diff --git a/Documentation/devicetree/bindings/sound/pcm1773.yaml b/Docum=
entation/devicetree/bindings/sound/pcm1773.yaml
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm1773.yaml
[ ... ]
> +properties:
> +  compatible:
> +    const: ti,pcm1773
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

[Severity: Low]
Will this schema cause dtbs_check validation errors?

The schema includes additionalProperties: false but fails to list enable-gp=
ios
and vcc-supply in the properties dictionary.

The provided device tree nodes specify these properties, which will lead to
schema validation failures.

> +
> +examples:

> diff --git a/sound/soc/codecs/pcm1773.c b/sound/soc/codecs/pcm1773.c
> --- /dev/null
> +++ b/sound/soc/codecs/pcm1773.c
[ ... ]
> +static int pcm1773_dac_event(struct snd_soc_dapm_widget *w,
> +			     struct snd_kcontrol *k, int event)
> +{
[ ... ]
> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		if (ctx->regulator) {
> +			ret =3D regulator_enable(ctx->regulator);
> +			if (ret) {
> +				dev_err(dev, "Failed to power DAC: %d\n", ret);
> +				return ret;
> +			}
> +			mdelay(1);

[Severity: Low]
Should this use usleep_range() or msleep() instead of busy-waiting?

pcm1773_dac_event() is executed during DAPM widget power up/down events, wh=
ich
run in a sleepable context (as demonstrated by calls to
gpiod_set_value_cansleep()). Using mdelay() here wastes CPU cycles.

> +		}
[ ... ]
> +static int pcm1773_probe(struct snd_soc_component *component)
> +{
> +	struct pcm1773 *ctx =3D NULL;
> +	struct device *dev =3D component->dev;
> +	int ret;
> +
> +	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	snd_soc_component_set_drvdata(component, ctx);
> +
> +	ctx->enable_gpio =3D devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_L=
OW);

[Severity: High]
Can this incorrect lifecycle for devm_ allocations cause memory leaks and
rebinding failures?

pcm1773_probe() executes during sound card binding, using devm_kzalloc() and
devm_gpiod_get_optional() with the platform device (component->dev).

Since the platform device outlives the sound card lifecycle, these resources
are not freed upon unbind, and a subsequent bind will hit -EBUSY when
requesting the GPIO or regulator.

> +	if (IS_ERR(ctx->enable_gpio)) {
[ ... ]
> +	ctx->regulator =3D devm_regulator_get(dev, "vcc");
> +	if (IS_ERR(ctx->regulator)) {
> +		dev_warn(dev, "cannot get regulator 'vcc'");
> +		ctx->regulator =3D NULL;
> +	}

[Severity: High]
Does this break deferred probing for the VCC supply by swallowing
-EPROBE_DEFER?

When the VCC regulator driver is loaded after the sound driver,
devm_regulator_get() returns -EPROBE_DEFER.

This code intercepts the error, sets the regulator to NULL, and continues
instead of propagating the error. This will cause the DAC to silently fail =
to
power up later.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D12
