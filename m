Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3CBC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7145210ED9D;
	Wed,  1 Jul 2026 16:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mcMsC1fC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05A310ED9D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:13:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F8D040692;
 Wed,  1 Jul 2026 16:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDD1F000E9;
 Wed,  1 Jul 2026 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782922385;
 bh=gVZdtQapB6tTMhtZxOuhDl+RYUu/A/XFkT3BmKPLcPw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mcMsC1fCnP4PxULGmbzJPQDuvU3L472fDB0yH8pWrq/mCO48OqnuOs6C5GxCpvqdx
 PKY1eddFEouqD6fsc3F+OdousoZJJ1wHyO6PcVoAFMI/AhUoBXDB2j26Bw2ymKdXmU
 2QHwvOJDplobgG/jjH64ywiOp+cfvS2JqqUKnzJA/FmwJAqa0rmP9gVGPi0XMemKeW
 RBmcs9PP9MET9CyeB68ypx25Ufiipfs7bX31CqWqwswmJ3/rZ75ayw8RD9rC59L4M5
 wN8LWh60jCeI12fWhosBMaN6nUcDNZ5yL+G4fDF8a0fQydB3bDbSgHh9Ga2NncE48S
 bmE1AUJAWBgAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/11] dt-bindings: display: tegra: Document memory
 regions
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-tegra-vpr-v3-2-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-2-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:13:04 +0000
Message-Id: <20260701161305.00EDD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The JSON Schema keyword `maxItems` is misspelled as `maxitems` in t=
he `memory-region-names` property definition.
--

commit ee391cd788a9c41587882f086abaab0871d4967e
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: display: tegra: Document memory regions

This commit adds memory-region and memory-region-names properties to the
display controllers and host1x engine bindings for Tegra generations. These
regions allow access to firmware-provided framebuffer memory and the video
protection region.

> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20=
-dc.yaml
> index 69be95afd5627..a012644eeb7d7 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.y=
aml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.y=
aml
[ ... ]
> @@ -65,7 +65,15 @@ properties:
>      items:
>        - description: phandle to the core power domain
> =20
> -  memory-region: true
> +  memory-region:
> +    minItems: 1
> +    maxItems: 2
> +
> +  memory-region-names:
> +    items:
> +      enum: [ framebuffer, protected ]
> +    minItems: 1
> +    maxitems: 2

[Severity: Low]
Is this meant to be maxItems? The lowercase spelling maxitems might be igno=
red
by the JSON schema validator, which would fail to enforce the upper array
bound limit or cause a meta-schema validation error when running
make dt_binding_check.

> =20
>    nvidia,head:
>      $ref: /schemas/types.yaml#/definitions/uint32

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D2
