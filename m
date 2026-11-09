Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD16082BDD
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsOvPEh/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A8810E042;
	Mon,  9 Nov 2026 12:32:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A97110F249
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:32:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48C5242A4B;
 Mon,  9 Nov 2026 12:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E371F008A3;
 Mon,  9 Nov 2026 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794227540;
 bh=DrFt5XUY5K+Z4YSTzjPJFdoi+/yuZntIqQXWFqO8qN4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nsOvPEh/a1Obx+RK4Q+xM1+BAeS34f4H7SqK1/nUp/OPUuPFIU3Fzw0bCiyVxehos
 m0i9ow/XPqrxyXqNx1nAM4P3g/MXaytVLrie4lX20B1Bc9rmIcq8QytWWl/e5HaFS9
 kQyqhhtMbepzUZ4jlCBMq4BzAXA4g30QUVJDIuNr/ACto54g4eLlh6n5Ey3oumRxGP
 GHCUJQFIv7eBLWjQpihC/C022EhgXg9Nww/i5RJOjw7RX5tLdzFeQ0cDHL7/tsTMob
 zoEbe55AaM+C+P5EvWBw97eTtXrj0cRdHr4dijUGAih4byxtZoZXg055nJNz5b7HUm
 vxzZqiud62WYQ==
Message-ID: <sashiko-outbox-204955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: display: panel: ilitek,ili9806e: Add
 Youritech ILI9806E
To: "Frank Obergfell" <frank.obergfell@bytesatwork.ch>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261109122250.720757-2-frank.obergfell@bytesatwork.ch>
References: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
 <20261109122250.720757-2-frank.obergfell@bytesatwork.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:32:19 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] dt-bindings: ilitek,ili9806e: non-specific youritech,ili9806e
  compatible
- [Low] dt-bindings: ilitek,ili9806e: incomplete commit message for
  panel and vendor
--

commit f808e27a7a6d1d461157c23c896bc2773caf8de9
Author: Frank Obergfell <frank.obergfell@bytesatwork.ch>

> dt-bindings: display: panel: ilitek,ili9806e: Add Youritech ILI9806E
>
> Add youritech panel as a compatible
>
> Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>

[Severity: Low]
This isn't a bug, but the commit message omits any description of the
panel hardware (such as the panel model, resolution, physical dimensions,
and whether it uses MIPI-DSI or SPI) and does not mention the new
youritech vendor prefix added to vendor-prefixes.yaml.

> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili98=
06e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.=
yaml
> index 2080d9e0ffac4..6f29ddc1fd090 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> @@ -19,6 +19,7 @@ properties:
>            - densitron,dmt028vghmcmi-1d
>            - ortustech,com35h3p70ulc
>            - rocktech,rk050hr345-ct106a
> +          - youritech,ili9806e
>        - const: ilitek,ili9806e

[Severity: Medium]
Should the compatible string use the specific Youritech panel part number
rather than repeating the ili9806e controller IC name?

In this binding, ilitek,ili9806e already identifies the display controller
IC as the fallback compatible, while the first entry identifies the panel
model. Using youritech,ili9806e makes it impossible to distinguish between
different Youritech panels built around the ILI9806E that have different
resolutions, physical dimensions, bus interfaces, or panel-specific
initialization sequences.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109122250.7207=
57-1-frank.obergfell@bytesatwork.ch?part=3D1
