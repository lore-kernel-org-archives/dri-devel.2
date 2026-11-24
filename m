Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739E606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPw0v10V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF73F10EF18;
	Tue, 24 Nov 2026 07:45:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028BC10EF18
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:45:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C80461FBD;
 Tue, 24 Nov 2026 07:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CF21F000CA;
 Tue, 24 Nov 2026 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795506327;
 bh=ySqtcJb8vbnzwtLmX1yALIBQHpMQo7/+5RhrpbUqdZc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LPw0v10VzLgcDfjMRmNKET3HZoneba0FBYu3sdR6wYJfoPGnrnZvAbx9OmYjA298f
 h/Y/rjKVXe2vf6JfUz8At6fHphquL8fEnzC6Fqf4KR+ecWWo+BJUmdiYCOqtp0a1/n
 5nr+3sUPxlEdx4X7kN+ThYNJ07W9O6w91ysvo1NyNPPM0d1W5G6a7rpdOgAdb66UxU
 5tcTLQUiaQNX8Y0ftWtN1oOeeLvZimeuPMNXKQ1CSaXp9oHQ503v66P/DvaY7/s+hH
 wEdBWFcXZ4WZZhxM4F4RBYHZfDjdz7a6B4WylY2H0SlUQYxtlAFXx6kwwbINszEVEs
 3Hd1fINT1Q4Tw==
Message-ID: <sashiko-outbox-230666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/20] ASoC: ti: omap3pandora: Convert sound card to DT
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <57d9a8b26bd2282deb9188d6913976cfee41aee9.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <57d9a8b26bd2282deb9188d6913976cfee41aee9.1795505160.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:45:26 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] ASoC: ti: omap3pandora: broken built-in McBSP names and missing
  DT DAI parsing
- [High] ASoC: ti: omap3pandora: missing SND_SOC_PCM1754 select in
  Kconfig
- [Medium] ASoC: ti: omap3pandora: grab_sample_rate() rejects
  single-stream rate change
- [Medium] ASoC: ti: omap3pandora: static open-time rate constraint in
  startup()
- [Medium] ASoC: ti: omap3pandora: missing snd_soc_pm_ops on
  omap3pandora_driver
- [Medium] ASoC: ti: omap3pandora: missing TWL4030_CLOCK_APLL setup in
  capture hw_params
- [Low] ASoC: ti: omap3pandora: omap3pandora_probe() requires optional
  DT properties
- [Low] ASoC: ti: omap3pandora: unused codec_dai variable and
  mach-types.h include
--

commit b90618564a61935165b508799b8ef7f6f6a36708
Author: Stefan Leichter <sle85276@gmx.de>

ASoC: ti: omap3pandora: Convert sound card to DT

This commit converts the OpenPandora ASoC machine driver to probe via a
Device Tree sound-card node, separates playback and capture handling
with shared TWL4030 APLL rate accounting, and switches to device-managed
resource registration.

> diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
> index 6c9c184cd9d6f..d747c0e6b48cb 100644
> --- a/sound/soc/ti/omap3pandora.c
> +++ b/sound/soc/ti/omap3pandora.c
> @@ -6,138 +6,274 @@

[ ... ]

> +#include <asm/mach-types.h>
> +#include <linux/mfd/twl4030-audio.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> =20
>  #include "omap-mcbsp.h"
> =20
> -#define PREFIX "ASoC omap3pandora: "
> +struct omap3pandora_sound {
> +	struct gpio_desc *amp_gpio;
> +	struct regulator *amp_regulator;
> +
> +	struct snd_pcm_substream *playback_stream;
> +	struct snd_pcm_substream *capture_stream;
> +
> +	struct mutex sample_rate_lock; // protects all fields after
> +	unsigned int sample_rate;
> +	int sample_rate_users;
> +};
> =20
> -static struct regulator *omap3pandora_dac_reg;
> -static struct gpio_desc *dac_power_gpio;
> -static struct gpio_desc *amp_power_gpio;
> +static struct snd_soc_dai_link omap3pandora_dai[];
> =20
> -static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
> -	struct snd_pcm_hw_params *params)
> +static int omap3pandora_common_hw_params(struct snd_pcm_substream *subst=
ream,
> +					 struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd =3D snd_soc_substream_to_rtd(substream);
> -	struct snd_soc_dai *codec_dai =3D snd_soc_rtd_to_codec(rtd, 0);
> +	__maybe_unused struct snd_soc_dai *codec_dai =3D snd_soc_rtd_to_codec(r=
td, 0);

[Severity: Low]
This isn't a bug, but codec_dai in omap3pandora_common_hw_params() and the
new <asm/mach-types.h> include are both unused and can be dropped.

[ ... ]

> +/* The McBSP playback and capture interfaces share the TWL4030 APLL. */
> +static int grab_sample_rate(struct omap3pandora_sound *ctx,
> +			    struct snd_pcm_substream **owner,
> +			    struct snd_pcm_substream *substream,
> +			    struct snd_pcm_hw_params *params,
> +			    bool *new_owner)
> +{
> +	unsigned int rate =3D params_rate(params);
> +	int ret =3D 0;
> +
> +	*new_owner =3D false;
> +	mutex_lock(&ctx->sample_rate_lock);
> +	if (*owner =3D=3D substream) {
> +		if (ctx->sample_rate !=3D rate)
> +			ret =3D -EINVAL;
> +	} else if (*owner || (ctx->sample_rate_users &&
> +				ctx->sample_rate !=3D rate)) {
> +		ret =3D -EINVAL;
> +	} else {
> +		ctx->sample_rate =3D rate;
> +		ctx->sample_rate_users++;
> +		*owner =3D substream;
> +		*new_owner =3D true;
> +	}
> +	mutex_unlock(&ctx->sample_rate_lock);
> +
> +	return ret;
> +}

[Severity: Medium]
Does grab_sample_rate() reject sample-rate changes on a substream even
when no other stream is active?

ALSA allows userspace to call SNDRV_PCM_IOCTL_HW_PARAMS more than once on
an open substream without an intervening hw_free().  When *owner =3D=3D
substream and ctx->sample_rate_users =3D=3D 1, returning -EINVAL on
ctx->sample_rate !=3D rate causes snd_pcm_hw_params() to fail and call
hw_free(), dropping the reservation anyway.  If ctx->sample_rate_users =3D=
=3D
1, *owner =3D=3D substream should be allowed to update ctx->sample_rate to =
the
new rate.

[ ... ]

> +static int omap3pandora_capture_hw_params(struct snd_pcm_substream *subs=
tream,
> +					  struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D snd_soc_substream_to_rtd(substream);
> +	struct snd_soc_dai *codec_dai =3D snd_soc_rtd_to_codec(rtd, 0);
> +	struct device *dev =3D rtd->dev;
> +	struct snd_soc_card *card =3D rtd->card;
> +	struct omap3pandora_sound *ctx =3D snd_soc_card_get_drvdata(card);
> +	bool new_owner;
> +	int ret;
> +
> +	/* Set the codec system clock for DAC and ADC */
> +	ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
> +				     SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot set TWL4030 system clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D grab_sample_rate(ctx, &ctx->capture_stream, substream,
> +			       params, &new_owner);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D omap3pandora_common_hw_params(substream, params);
> +	if (ret)
> +		goto err_release;
>  	return 0;

[Severity: Medium]
Does omap3pandora_capture_hw_params() also need to program
TWL4030_CLOCK_APLL via snd_soc_dai_set_sysclk()?

In sound/soc/codecs/twl4030.c, twl4030_hw_params() sets
twl4030->configured =3D 1 on the first hw_params() call and returns early
without updating TWL4030_REG_CODEC_MODE until twl4030_shutdown() clears
twl4030->configured:

sound/soc/codecs/twl4030.c:twl4030_hw_params() {
    ...
	 /* If the substream has no subscribers, the Giacinto
	  * is already configured, so we can return */
	if (twl4030->configured)
		return 0;
    ...
}

If an open capture substream runs hw_params(), hw_free() (which releases
ctx->capture_stream), and then hw_params() at a new rate (or if playback
changed the APLL rate in the meantime), McBSP4 is reconfigured to 256 *
new_rate while the TWL4030 APLL stays at the old frequency.

[ ... ]

> +static int omap3pandora_common_startup(struct snd_pcm_substream *substre=
am)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D snd_soc_substream_to_rtd(substream);
> +	struct snd_soc_card *card =3D rtd->card;
> +	struct omap3pandora_sound *ctx =3D snd_soc_card_get_drvdata(card);
> +	unsigned int sample_rate;
> +
> +	mutex_lock(&ctx->sample_rate_lock);
> +	sample_rate =3D ctx->sample_rate;
> +	mutex_unlock(&ctx->sample_rate_lock);
> +
> +	if (!sample_rate)
> +		return 0;
> +
> +	return constrain_sample_rate(substream, sample_rate);
> +}

[Severity: Medium]
Can constraining the rate from a snapshot of ctx->sample_rate in startup()
leave a substream either unconstrained or locked to a stale rate?

Because ctx->sample_rate is only set later in hw_params(), a full-duplex
application that opens both playback and capture before configuring
hw_params() sees ctx->sample_rate =3D=3D 0 in both startup() calls and gets=
 no
rate constraint.  Conversely, if stream B opens while stream A is running
at rate R1, stream B is permanently constrained to R1 via
snd_pcm_hw_constraint_single(); if stream A then closes and reopens at
rate R2 !=3D R1 before stream B runs hw_params(), stream B cannot succeed at
any rate.

> @@ -171,20 +307,40 @@ static int omap3pandora_in_init(struct snd_soc_pcm_=
runtime *rtd)

[ ... ]

>  /* Digital audio interface glue - connects codec <--> CPU */
> +#if IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA)
>  SND_SOC_DAILINK_DEFS(out,
>  	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
> -	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773")),
>  	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
> =20
>  SND_SOC_DAILINK_DEFS(in,
>  	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.4")),
>  	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
>  	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.4")));
> +#else /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */
> +SND_SOC_DAILINK_DEFS(out,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("49022000.mcbsp")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773")),
> +	DAILINK_COMP_ARRAY(COMP_PLATFORM("49022000.mcbsp")));
> +
> +SND_SOC_DAILINK_DEFS(in,
> +		     DAILINK_COMP_ARRAY(COMP_CPU("49026000.mcbsp")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
> +	DAILINK_COMP_ARRAY(COMP_PLATFORM("49026000.mcbsp")));
> +#endif /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */

[Severity: High]
Does SND_SOC_OMAP3_PANDORA in sound/soc/ti/Kconfig need to select
SND_SOC_PCM1754 now that the playback DAI link binds to the pcm1773 DAI?

Without select SND_SOC_PCM1754 in Kconfig, configs enabling
CONFIG_SND_SOC_OMAP3_PANDORA (such as omap2plus_defconfig) do not build
sound/soc/codecs/pcm1754.c, leaving the playback link unbound.

[Severity: High]
Why do the DAI links hardcode component names and branch on
IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) instead of populating the DAI
link of_node pointers from Device Tree?

On DT-based OMAP3 kernels, the McBSP devices are always named
"49022000.mcbsp" and "49026000.mcbsp" regardless of whether this driver is
built-in or a module, so CONFIG_SND_SOC_OMAP3_PANDORA=3Dy searches for
"omap-mcbsp.2" and "omap-mcbsp.4" and never binds.  In addition,
sound/soc/codecs/pcm1754.c leaves soc_component_dev_pcm1754.name NULL, so
the codec component is named after the DT node (for example "dac" in the
binding example) rather than "pcm1773-codec", and omap3pandora_probe()
never parses the sound-dai phandles into cpus->of_node, platforms->of_node
and codecs->of_node.

> @@ -192,100 +348,122 @@ static struct snd_soc_dai_link omap3pandora_dai[]=
 =3D {

[ ... ]

> +	if (dev->of_node) {
> +		ret =3D snd_soc_of_parse_card_name(card, "label");
> +		if (ret)
> +			card->name =3D "omap3pandora";
> +
> +		ret =3D snd_soc_of_parse_audio_simple_widgets(card, "widgets");
> +		if (ret) {
> +			dev_err(dev, "Failed to parse DAPM widgets: %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret =3D snd_soc_of_parse_audio_routing(card, "routing");
> +		if (ret) {
> +			dev_err(dev, "Failed to parse audio routing: %d\n", ret);
> +			return ret;
> +		}
>  	}

[Severity: Low]
Should omap3pandora_probe() check whether the "widgets" and "routing"
properties exist before calling snd_soc_of_parse_audio_simple_widgets()
and snd_soc_of_parse_audio_routing()?

Both helpers return -EINVAL when the property is absent, whereas the DT
binding only lists compatible and sound-dai as required.

[ ... ]

> +static struct platform_driver omap3pandora_driver =3D {
> +	.driver =3D {
> +		.name =3D "omap3pandora-sound",
> +		.of_match_table =3D omap3pandora_of_match,
> +	},
> +	.probe =3D omap3pandora_probe,
> +};

[Severity: Medium]
Should omap3pandora_driver.driver set .pm =3D &snd_soc_pm_ops?

Previously, registering a "soc-audio" platform device bound the card to
soc_driver in sound/soc/soc-core.c, which wires up snd_soc_pm_ops.
Omitting .pm here disables ASoC card suspend, resume, and poweroff
callbacks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795505160.gi=
t.hns@goldelico.com?part=3D7
