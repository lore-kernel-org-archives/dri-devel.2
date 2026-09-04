Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C5EC79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33CD110F95A;
	Fri,  4 Sep 2026 13:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ymk12fQx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF79710F95A
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:35:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDAF7601F0;
 Fri,  4 Sep 2026 13:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372801F00A3D;
 Fri,  4 Sep 2026 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788528908;
 bh=mZKjmtsE3tzdE9+pHIwlJUk3Qt+6fz8Ww6jrCUSt+X4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ymk12fQxbY03vo1t2Nt9xp4fUI2HH4+OaDVrSfOXmVoPt0xMoEuFDu6Tk9UnuWPbv
 iCbc/I8MVG2pa7E57gdTJubTaNkbb3mGpcy308auCmykK3S29HUABmdlzPt9qp74+/
 Bm3s6CSjkEkBq6+tj7PAoRf/jVQtbaitkEuX1qM++bczBwssu2Cle7sJ+WIL+pGf05
 zHz+7QAqSJ4Y16mmYDMK/fyMoKHGZUPcb3DFCZiFx4Yujyumc6ZaI0UEhGaKgNaIJh
 OPs2P45AwQYw1SNxzNasjCqX1roSB6rfaigF8xVdetV0i074C2rmyymZ7xa7XJ4FH3
 8zaD5hyv/uPHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/19] dt-bindings: display: bridge: Add
 starfive,jh7110-inno-hdmi-controller
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 mfd@lists.linux.dev, lee@kernel.org, olteanv@gmail.com,
 neil.armstrong@linaro.org, linux-phy@lists.infradead.org, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260904-jh7110-clean-send-v3-2-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132712eucas1p167f9527c4728af56f811d06832b43c36@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-2-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:35:07 +0000
Message-Id: <20260904133508.372801F00A3D@smtp.kernel.org>
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
- [Medium] The clock names described in the commit message contradict the c=
lock names defined in the schema.
--

commit d8a94c9a1ba333a313d74a23f9f5fb6dcc401472
Author: Michal Wilczynski <m.wilczynski@samsung.com>

dt-bindings: display: bridge: Add starfive,jh7110-inno-hdmi-controller

This commit adds the device tree binding schema for the StarFive JH7110
Innosilicon HDMI controller.

> It consumes register access clocks (sys, mclk, bclk) from the voutcrg and
> both the pixel clock (pclk) and the PHY from its hdmi_phy sibling.

[ ... ]

> diff --git a/Documentation/devicetree/bindings/display/bridge/starfive,jh=
7110-inno-hdmi-controller.yaml b/Documentation/devicetree/bindings/display/=
bridge/starfive,jh7110-inno-hdmi-controller.yaml
> new file mode 100644
> index 0000000000000..ea489a7722d02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-in=
no-hdmi-controller.yaml

[ ... ]

> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: mclk
> +      - const: bclk
> +      - const: pixel

[Severity: Medium]
The clock names described in the commit message contradict the clock names
defined in the schema.

The commit message states that the device consumes register access clocks
"(sys, mclk, bclk)" and the pixel clock "(pclk)". However, the schema defin=
es
the expected clock names as "pclk" for the main clock and "pixel" for the
pixel clock.

Is the commit message inaccurate, or should the schema use "sys" and "pclk"
instead of "pclk" and "pixel" for these respective clocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D2
