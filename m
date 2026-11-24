Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DC606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1LZ1Wpw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1ED510EECA;
	Tue, 24 Nov 2026 07:40:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F07D10EECA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:40:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A0C061F44;
 Tue, 24 Nov 2026 07:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A01F000C0;
 Tue, 24 Nov 2026 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795506033;
 bh=yQnefspdcKZ/GcvyTFC4c6OWRm4U0T/ukYXcetck0+o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e1LZ1WpwZpis/XkiuDjAePAw8+veOH2wHniJfsT0QZ/i2Pcu9+pY+PZkR7iaABhtC
 gEJL6bR27OzqnnRjYJMG7uOKzpj+Po6pn/usFmyOKU3Br/3T56WxYv0dN7YYUGAUwz
 8ZPKIcTHP8X4wKEvGzihXUqavN/RVAuvCY8Dm8d9Z8fE6PQdmcZ8OQVmHxctV3tURp
 2qnEIKqPxtxg4IPctHlsKV/XJ9Z1sDmh66B+Yll8F05DMNBKX7N3t8oiX0YYvp+aWN
 5TSv+D5IBp8GYp4EXl8G9wDpoeJGiVfcOFJNwjFbrk3bfy3BOlLGf3FHlHs4W9ad1K
 od244WfuII2sw==
Message-ID: <sashiko-outbox-230656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/20] ARM: dts: omap3pandora: Describe PCM1773
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <770a015f333c1927fccee2663eb76a7de923dffb.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <770a015f333c1927fccee2663eb76a7de923dffb.1795505160.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:40:32 +0000
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
- [Low] ARM: dts: omap3pandora: non-generic pcm1773-codec node name used
  as ABI
--

commit c8d3624565f86aa716a8f19bdd1dc4e2ff56499b
Author: H. Nikolaus Schaller <hns@goldelico.com>

ARM: dts: omap3pandora: Describe PCM1773

This commit adds a devicetree node for the PCM1773 playback DAC to the
common OpenPandora devicetree.

> diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/a=
rm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> index 2a5e8ba5714da..6e349f7ae6936 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> @@ -64,6 +64,13 @@ tv_connector_in: endpoint {
>  		};
>  	};
> =20
> +	dac: pcm1773-codec {
> +		compatible =3D "ti,pcm1773";
> +		vcc-supply =3D <&vsim>;
> +		enable-gpios =3D <&gpio4 22 GPIO_ACTIVE_HIGH>; /* GPIO 118 */
> +		status =3D "okay";
> +	};

[Severity: Low]
Should this node use a generic name such as audio-codec rather than the
chip-specific pcm1773-codec?

Because this root-level node has no reg property, of_device_make_bus_id()
names the platform device directly after the node name, and
sound/soc/ti/omap3pandora.c relies on that exact name as an ABI:

sound/soc/ti/omap3pandora.c:
SND_SOC_DAILINK_DEFS(out,
	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773")),
	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));

Matching the codec via a DT phandle in the machine driver would allow a
generic node name here without breaking codec binding.  Also, status =3D
"okay" is the default and can be dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795505160.gi=
t.hns@goldelico.com?part=3D16
