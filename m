Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451E606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8OlA3nJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBD910EFC4;
	Tue, 24 Nov 2026 07:47:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9DF10EFC4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:47:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AA7240019;
 Tue, 24 Nov 2026 07:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715841F000C6;
 Tue, 24 Nov 2026 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795506466;
 bh=OTP7w9ZiHM/lSydigi/3xg0xnFIH5CNg9KINKRpIhqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C8OlA3nJGgJOPEuTgFE6g3O/1WYphIIs5vWScHSdTx61yTdpw4qYJFTFB1uI7SZJA
 MppJLC0/0VIssitZoNqKhk5a+dai8i9qQ+PEIzxiu6mFIIyoQbkEmjXVilaC+sW2Fm
 lie1tyUCU0rptJQbhtrPiJKbgKuH5w6UmUUHcVdMYMcoBSBHKEAWmzAZE6Fkg0LR5C
 US1V9fA4B/FI2b01o2mRDWO4jglQEullBUnkqvyrj1rpvuO36qXzdPYFeCYblKqS6i
 CMs5y5oALaeq3wdjPh/GqppBQpj7IE1PtVDoxDSIa1FMlmjS4uGVRW7GdaCMYaF8N7
 9nmDuIFWTRWCQ==
Message-ID: <sashiko-outbox-230672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/20] ARM: dts: omap3pandora: Describe sound card
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <0269f30c3f766431c0c20a36fd6e2b2dce1b3f2f.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <0269f30c3f766431c0c20a36fd6e2b2dce1b3f2f.1795505160.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:47:46 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] ARM: dts: omap3pandora: incomplete and unused sound-dai
  property on sound node
- [Medium] ASoC: ti: omap3pandora: built-in driver fails to bind DT
  McBSP DAIs
- [Low] ARM: dts: omap3pandora: redundant clocks properties on mcbsp2
--

commit 51a8d5eee5be53980684a82cdf4795c967918b82
Author: Stefan Leichter <sle85276@gmx.de>

ARM: dts: omap3pandora: Describe sound card

This commit adds the OpenPandora sound card node and McBSP2 DAI properties
to omap3-pandora-common.dtsi.

> diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/a=
rm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> index 6e349f7ae6936..a5633d93547a3 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> @@ -69,6 +69,41 @@ dac: pcm1773-codec {
>  		vcc-supply =3D <&vsim>;
>  		enable-gpios =3D <&gpio4 22 GPIO_ACTIVE_HIGH>; /* GPIO 118 */
>  		status =3D "okay";
> +		#sound-dai-cells =3D <0>;
> +	};
> +
> +	sound: sound {
> +		compatible =3D "openpandora,omap3pandora-sound";
> +		status =3D "okay";
> +
> +		label =3D "OpenPandora";
> +
> +		amp-gpios =3D <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		amp-supply =3D <&aux_5v>;
> +
> +		widgets =3D
> +			"Line", "Line Out",
> +			"Line", "Line In",
> +			"Headphone", "Headphone Jack",
> +			"Microphone", "Mic (internal)",
> +			"Microphone", "Mic (external)";
> +
> +		routing =3D
> +			"DAC1", "APLL Enable",
> +			"DAC2", "APLL Enable",
> +			"Headphone Amplifier", "VOUTL",
> +			"Headphone Amplifier", "VOUTR",
> +			"Line Out", "VOUTL",
> +			"Line Out", "VOUTR",
> +			"Headphone Jack", "Headphone Amplifier",
> +			"AUXL", "Line In",
> +			"AUXR", "Line In",
> +			"MAINMIC", "Mic (internal)",
> +			"Mic (internal)", "Mic Bias 1",
> +			"SUBMIC", "Mic (external)",
> +			"Mic (external)", "Mic Bias 2";
> +
> +		sound-dai =3D <&mcbsp2>, <&dac>;

[Severity: Medium]
Is sound-dai here both incomplete for the capture link and unused by
omap3pandora_probe()?

The sound card has both a playback link (McBSP2 to PCM1773) and a capture
link (McBSP4 to TWL4030), but sound-dai and #sound-dai-cells only cover
&mcbsp2 and &dac, omitting &mcbsp4 and the TWL4030 codec.  In addition,
omap3pandora_probe() in sound/soc/ti/omap3pandora.c only parses label,
widgets and routing, and never reads sound-dai to populate the CPU,
platform or codec of_node pointers in omap3pandora_dai[].  As a result,
component matching still relies on hardcoded device names in
omap3pandora_dai[], including the non-generic pcm1773-codec DT node name.

[Severity: Medium]
Can this sound card probe when CONFIG_SND_SOC_OMAP3_PANDORA=3Dy?

Because omap3pandora_probe() does not populate dai_link->cpus->of_node or
dai_link->platforms->of_node from sound-dai, ASoC matches the McBSP DAIs
using the hardcoded names in omap3pandora_dai[] from commit "ASoC: ti:
omap3pandora: Convert sound card to DT":

sound/soc/ti/omap3pandora.c:
#if IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA)
SND_SOC_DAILINK_DEFS(out,
	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773")),
	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));

SND_SOC_DAILINK_DEFS(in,
	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.4")),
	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.4")));
#else /* IS_BUILTIN(CONFIG_SND_SOC_OMAP3_PANDORA) */

On a Device Tree boot, the McBSP devices are always registered as
49022000.mcbsp and 49026000.mcbsp regardless of whether the sound driver
is built-in or modular, so a built-in driver will never find omap-mcbsp.2
or omap-mcbsp.4 and card registration will defer indefinitely.

[ ... ]

> @@ -736,6 +771,9 @@ &mcbsp1 {
>  /* audio DAC */
>  &mcbsp2 {
>  	status =3D "okay";
> +	#sound-dai-cells =3D <0>;
> +	clocks =3D <&mcbsp2_fck>, <&mcbsp2_ick>;
> +	clock-names =3D "fck", "ick";
>  };

[Severity: Low]
This isn't a bug, but clocks and clock-names on &mcbsp2 duplicate the
 exact same properties already defined in the base mcbsp2 node in
arch/arm/boot/dts/ti/omap/omap3.dtsi.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795505160.gi=
t.hns@goldelico.com?part=3D17
