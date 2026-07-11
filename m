Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187B6C44506
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD0910E72B;
	Sat, 11 Jul 2026 06:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OeqN9BV+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D1B10E72B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:14:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E34DD600C3;
 Sat, 11 Jul 2026 06:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A671F000E9;
 Sat, 11 Jul 2026 06:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750450;
 bh=Q3/BMyroBQ9AAjuM21JLrlrdQBB34rp9kkSwrZSBMVo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OeqN9BV+lxXZ/bdjfrNEFemX0qnwBmNmLwYIJ9NECOa/akSKRUalCdbEtvKnASyO+
 m9zQXAh4H+RZWOMLwY7DScydMBA3OrUVhMMZdnXJIYPVpNrdApYEjcHf+8Bosac18F
 QX/YqnhZ9cEhgs/i6kYwjWR74ASTG6epkpw8Od7pGK6+wnwZOi6GseSg58BSsGg8K2
 eR4TUSrSPzPy6TcUSA0TPMDxJfHn5LoAo8f1x/eqPtBvojGVwHnxWcKVfq+Wz7RKZ2
 Vfa0h9YqRKUDgdnPPBKf9yUY/U4rfolH67+aQuDRaZdH7CoziVy8mA9ubeOOtf+E+/
 IqOe+Ud7tmU0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/16] ASoC: pcm1773-codec: write a driver for the
 PCM1773 chip from TI
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: lee@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <7d8989813cbd750259dfdde2e1187082493279a0.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <7d8989813cbd750259dfdde2e1187082493279a0.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:14:09 +0000
Message-Id: <20260711061410.32A671F000E9@smtp.kernel.org>
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
- [High] Device-managed allocations (devm_*) are incorrectly placed in the =
ASoC component probe, causing memory leaks and -EBUSY errors on card unbind=
/rebind.
- [High] The driver silently ignores errors from devm_regulator_get(), brea=
king deferred probing.
- [High] The codec driver defines a DAC widget but lacks physical output en=
dpoints (SND_SOC_DAPM_OUTPUT).
- [Medium] The driver uses mdelay() inside a sleepable DAPM event handler, =
needlessly wasting CPU cycles.
- [Low] SND_SOC_PCM1773 uses `select GPIOLIB` instead of `depends on GPIOLI=
B`, violating cross-config consistency.
--

--- Patch [8]: [PATCH 08/16] ASoC: pcm1773-codec: write a driver for the PC=
M1773 chip from TI ---
commit 834434a73863a6e3a112c74fe0cc88b2cf342a3d
Author: Grond <grond66@riseup.net>

ASoC: pcm1773-codec: write a driver for the PCM1773 chip from TI

This commit adds a new ASoC codec driver for the Texas Instruments PCM1773
chip, which is used in the OpenPandora.

> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 252f683be3c18..3e186652fa06d 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
[ ... ]
> @@ -1541,6 +1542,10 @@ config SND_SOC_PCM1754
>  	tristate "Texas Instruments PCM1754 CODEC"
>  	depends on GPIOLIB
> =20
> +config SND_SOC_PCM1773
> +	tristate "Texas Instruments PCM1773 CODEC"
> +	select GPIOLIB

[Severity: Low]
Does this config violate cross-config consistency?=20

The adjacent SND_SOC_PCM1754 config uses depends on GPIOLIB, while this=20
one uses select GPIOLIB.

> diff --git a/sound/soc/codecs/pcm1773.c b/sound/soc/codecs/pcm1773.c
> new file mode 100644
> index 0000000000000..75f9fe40a89d5
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

[Severity: Medium]
Since this DAPM event handler is called in process context where sleeping is
allowed (as seen by the use of gpiod_set_value_cansleep below), should this
use a sleeping delay instead of a busy-wait loop to avoid wasting CPU cycle=
s?

> +		}
> +
> +		if (ctx->enable_gpio)
> +			gpiod_set_value_cansleep(ctx->enable_gpio, 1);
> +	} else {
> +		if (ctx->enable_gpio)
> +			gpiod_set_value_cansleep(ctx->enable_gpio, 0);
> +
> +		if (ctx->regulator) {
> +			mdelay(1);

[Severity: Medium]
Could this also be a sleeping delay instead of wasting CPU cycles?

> +			regulator_disable(ctx->regulator);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dapm_widget pcm1773_dapm_widgets[] =3D {
> +	SND_SOC_DAPM_DAC_E("PCM1773 DAC", "HiFi Playback", SND_SOC_NOPM,
> +			   0, 0, pcm1773_dac_event,
> +			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> +};

[Severity: High]
Are physical output endpoints missing here?

The DAPM widgets define the DAC, but there are no corresponding physical
sink endpoints (like SND_SOC_DAPM_OUTPUT) provided to terminate the
playback path. Without a path to a sink endpoint, the DAPM graph remains
incomplete and the DAC will not be powered on during playback.

[ ... ]
> +static int pcm1773_probe(struct snd_soc_component *component)
> +{
> +	struct pcm1773 *ctx =3D NULL;
> +	struct device *dev =3D component->dev;
> +	int ret;
> +
> +	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);

[Severity: High]
Will placing device-managed allocations inside the ASoC component probe
cause memory leaks and failures on rebind?

When a sound card unbinds and rebinds (such as during deferred probing of a
machine driver), pcm1773_probe() is called multiple times. Because these
allocations are tied to the underlying platform device dev rather than the
component lifetime, the memory won't be freed until the platform device
itself is removed.

> +	if (!ctx)
> +		return -ENOMEM;
> +	snd_soc_component_set_drvdata(component, ctx);
> +
> +	ctx->enable_gpio =3D devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_L=
OW);

[Severity: High]
Does requesting the GPIO here also fail on card rebind?

Since devm_gpiod_get_optional is tied to the platform device, an unbind and
rebind of the sound card will attempt to request the same GPIO again before
the platform device is removed, resulting in a permanent -EBUSY error.

> +	if (IS_ERR(ctx->enable_gpio)) {
> +		return dev_err_probe(dev, PTR_ERR(ctx->enable_gpio),
> +				     "invalid GPIO specification for enable");
> +	}
> +	if (ctx->enable_gpio)
> +		dev_dbg(dev, "got enable-gpio\n");
> +	else
> +		dev_warn(dev, "enable-gpio not specified\n");
> +
> +	ctx->regulator =3D devm_regulator_get(dev, "vcc");
> +	if (IS_ERR(ctx->regulator)) {
> +		dev_warn(dev, "cannot get regulator 'vcc'");
> +		ctx->regulator =3D NULL;
> +	}

[Severity: High]
Does this silently break deferred probing?

If devm_regulator_get returns -EPROBE_DEFER (because the regulator driver
probes after this codec), the error is swallowed, ctx->regulator is set to
NULL, and the function returns 0. The driver will successfully probe
without its regulator, resulting in silent audio failures since the DAC
won't be powered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D8
