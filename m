Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB29606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5zwOaWg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F0D10E39D;
	Tue, 27 Oct 2026 11:00:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9475A10E3D0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:00:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61B7F60136;
 Tue, 27 Oct 2026 11:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608D01F01828;
 Tue, 27 Oct 2026 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793098814;
 bh=SWXAoeNX30DTt8Lwb9xNTpNWhLrvEfMFFNzLFwCHSRg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G5zwOaWgTw5opPtN1sFkyh3X9BzzzLQYrTGEWmh7NFV3Nu312WAVVI91cg1lii5Bp
 +uPnmatGkX5FFvlJNhPrXjPc4eTTnptaDr6kHGhun24wMacEnnEym40NT/624rJWlq
 6Rj4VjiT1ykvhvMq8zJFpFIPQMLhM1mksLa/+kbUWxW/elMaguKtTpJd29WQV09nNT
 C+Q93fPrGriFNrrqDl/RhtXjZfDw41xRX/ghz044xVs5RugrNwFW8BeBHYBRYeZmnR
 QB9/gpnmXaOL+OmapM/wsTKHoQ6jTBreTVB2+RRAogk3Mf1GK1vBFJrhWxbG9zyFwE
 pajhuEss+u3iQ==
Date: Tue, 27 Oct 2026 12:00:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
 "H . Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: display: Add the Ingenic X1600 LCD
 controller
Message-ID: <20261027-hospitable-apricot-scallop-166448@quoll>
References: <20261025191640.13592-1-olivier@mgcrea.io>
 <20261025191640.13592-3-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025191640.13592-3-olivier@mgcrea.io>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 08:16:37PM +0100, Olivier Louvignes wrote:
> The X1600's display controller fetches frames through descriptors and
> keeps its interface and timings in register blocks of their own (X1600
> programming manual, chapter 10), so it shares nothing with the
> controllers ingenic,lcd.yaml describes. Its registers are those of the
> X2000's display controller without the composer.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../bindings/display/ingenic,x1600-lcd.yaml   | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml b/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> new file mode 100644
> index 000000000000..171536c78f4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ingenic,x1600-lcd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic X1600 LCD controller
> +
> +maintainers:
> +  - Olivier Louvignes <olivier@mgcrea.io>
> +
> +description:
> +  The display controller of the Ingenic X1600 SoC. It fetches frames through
> +  descriptors in memory and drives a parallel RGB panel or a smart panel;
> +  its registers have nothing in common with the controllers described in
> +  ingenic,lcd.yaml.
> +
> +properties:
> +  $nodename:
> +    pattern: "^lcd-controller@[0-9a-f]+$"

Individual device schemas do not need to enforce naming, you can drop
nodename.

> +
> +  compatible:
> +    const: ingenic,x1600-lcd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: The pixel clock, whose gate also gates the controller
> +
> +  clock-names:
> +    items:
> +      - const: lcd

... and drop clock-names, since it is the same as device name.

> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: The output, to the panel or bridge.

No port for IPU?

Best regards,
Krzysztof

