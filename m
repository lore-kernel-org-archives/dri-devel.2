Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFDBC44506
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F03810E73D;
	Sat, 11 Jul 2026 06:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Or/8Li9+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7FE10E73B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:17:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58A9640DBC;
 Sat, 11 Jul 2026 06:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89BC1F000E9;
 Sat, 11 Jul 2026 06:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750628;
 bh=UD7smZADEiY1VZwooZUtPRCUSB+BCbV0dxOF6bSATKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Or/8Li9+El8vdoBQMs/6Pk8knhOrwolZ3kJZJ3kmiG6g4d4fgN7HlqbDLPMfqT55K
 cYSz3+pri6qBO5hNFeFr7wPGpnzeSUOO2KVaAAxIcKZD2k0t89TOO2FXAokFDRVubP
 l4BZ9FsS/rWFEV8ogKKtFPVyuNJiUY0lxd/FiJCSNIcz4M/9jLvSvjdzBjl235UsCX
 gnb/+jGOz2QDXgUAcxEhC/H9fKvfXPVdlHVqT2oRL0rIIE4g+bh7iDqGdKiC2+bJJk
 qHs7rvlZ7ewfvpBGD/D0rqgVLOUJ2uie5addub/3gJ1pVfMfgOVg3rLEmlPrLxhZiv
 AC/A0G/tq7xnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/16] arm: dts: omap3pandora: create new DT node for
 the sound card
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, lee@kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <e21be70f6ac6691c4a42808693215ed2f58eace2.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <e21be70f6ac6691c4a42808693215ed2f58eace2.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:17:07 +0000
Message-Id: <20260711061707.E89BC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Double decrement of sample_rate_users on hw_params error path.
- [High] Using `IS_BUILTIN()` to change CPU and Platform component names br=
eaks DAI linking for built-in driver initialization.
- [Medium] Incorrect `$id` and `$schema` fields in the newly added audio DT=
 bindings.
- [Medium] The `ti,pcm1773` binding schema does not document necessary prop=
erties and sets `additionalProperties: false`, causing DT validation failur=
es.
--

--- Patch [13]: [PATCH 13/16] arm: dts: omap3pandora: create new DT node fo=
r the sound card ---
commit 9dab89ea3f463775080f6924b99e5cea84e88df3
Author: Stefan Leichter <sle85276@gmx.de>

arm: dts: omap3pandora: create new DT node for the sound card

This means that the sound card driver (snd-soc-omap3pandora) will get
loaded by default. To make this work, we also add dac pcm1773-codec and
widgets and routing as needed.

> diff --git a/Documentation/devicetree/bindings/sound/openpandora,omap3pan=
dora-sound.yaml b/Documentation/devicetree/bindings/sound/openpandora,omap3=
pandora-sound.yaml
> new file mode 100644
> index 0000000000000..d3c747e5c58d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-so=
und.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org
> +$schema: http://devicetree.org

[Severity: Medium]
Are these $id and $schema paths correct? The $id field breaks the schema
cross-reference system if it doesn't include the full path, and could cause
dt_binding_check to report misleading errors or skip validation.

[ ... ]

> diff --git a/Documentation/devicetree/bindings/sound/pcm1773.yaml b/Docum=
entation/devicetree/bindings/sound/pcm1773.yaml
> new file mode 100644
> index 0000000000000..f3e640705bf70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm1773.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/sound/pcm1773.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

[Severity: Medium]
Should this $id field omit the extraneous bindings/ directory to match the
standard path format?

[ ... ]

> +properties:
> +  compatible:
> +    const: ti,pcm1773
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

[Severity: Medium]
Since additionalProperties is set to false but only the compatible string is
documented, won't valid device tree nodes that use properties like
vcc-supply, enable-gpio, status, and #sound-dai-cells fail validation?

[ ... ]

> diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
> index 6c9c184cd9d6f..d3509473f5df0 100644
> --- a/sound/soc/ti/omap3pandora.c
> +++ b/sound/soc/ti/omap3pandora.c
[ ... ]
> +static int omap3pandora_playback_hw_params(struct snd_pcm_substream *sub=
stream,
> +					   struct snd_pcm_hw_params *params)
> +{
[ ... ]
> +	if (!ctx->playback_stream) {
> +		ctx->playback_stream =3D substream;
> +		ret =3D grab_sample_rate(ctx, substream, params);
> +		if (ret)
> +			return ret;
> +	}

[Severity: High]
If grab_sample_rate() returns an error, it drops sample_rate_users back
down, but ctx->playback_stream remains set to this substream.

When this stream is subsequently closed, omap3pandora_playback_hw_free()
will see ctx->playback_stream is set and call release_sample_rate() again.

Will this result in a double decrement of sample_rate_users that could
prematurely unlock constraints for an active stream?

[ ... ]

> +static int omap3pandora_capture_hw_params(struct snd_pcm_substream *subs=
tream,
> +					  struct snd_pcm_hw_params *params)
> +{
[ ... ]
> +	if (!ctx->capture_stream) {
> +		ctx->capture_stream =3D substream;
> +		ret =3D grab_sample_rate(ctx, substream, params);
> +		if (ret)
> +			return ret;
> +	}

[Severity: High]
Similarly, does this have the same double decrement issue if
grab_sample_rate() fails, leaving ctx->capture_stream set for
omap3pandora_capture_hw_free() to clean up later?

[ ... ]

> +#if IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA)
>  SND_SOC_DAILINK_DEFS(out,
>  	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
> -	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773-hifi")),
>  	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
> =20
>  SND_SOC_DAILINK_DEFS(in,
>  	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.4")),
>  	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
>  	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.4")));
> +#else /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */
> +SND_SOC_DAILINK_DEFS(out,
> +	DAILINK_COMP_ARRAY(COMP_CPU("49022000.mcbsp")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773-hifi")),
> +	DAILINK_COMP_ARRAY(COMP_PLATFORM("49022000.mcbsp")));
> +
> +SND_SOC_DAILINK_DEFS(in,
> +	DAILINK_COMP_ARRAY(COMP_CPU("49026000.mcbsp")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
> +	DAILINK_COMP_ARRAY(COMP_PLATFORM("49026000.mcbsp")));
> +#endif /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */

[Severity: High]
Does this IS_BUILTIN() check break DAI linking when the driver is built into
the kernel?

Since the McBSP devices are populated via the Device Tree and use unit
addresses (like 49022000.mcbsp) regardless of the driver's compilation
state, could ALSA fail to find omap-mcbsp.2 when probing the built-in
driver?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D13
