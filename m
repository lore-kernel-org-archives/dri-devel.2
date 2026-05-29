Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFAFCD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED9F10FCC5;
	Fri, 29 May 2026 10:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Em4uxmtz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC2B10FCC5
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:35:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A59742ADF;
 Fri, 29 May 2026 10:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6FB1F00898;
 Fri, 29 May 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780050921;
 bh=/81VudvRrm3p1s1RTSNTNyWiS4UEzvG8GS46X/jp2UQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Em4uxmtzY1k6rxjB1apPt95CeGfsxjzf9CJ9egdLVUfW0O0FZUXde/EG9fWv2EwBM
 dLruv10Rnc8aagJjVA8UHpsj73p5nkQqkDqLMjyDM3UW6MoZaYKGtGfOvw01IQWGtm
 tzW6pvMcH3pf/HnJTLy/ZKo7sOjLV/uNWvN1lBInrtoi07CFK3b0EIyHJSoX3r+UII
 an8q+13mv/ifGRUKmN8wZlyn+rjMB9OdX2bU2/UumW/HSH9+tWZYCnsIhG3kjN7K0P
 CzA6UqWWMDhuZ1reqe7CGQrvK2elag/gxPsyN0M4bS9CuqzGME+7/3/4qOcSjb1xSR
 495O+ckls7drg==
Date: Fri, 29 May 2026 11:35:16 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <ahlr5PnX5O0tEd6G@aspen.lan>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
 <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
 <ahllT_HVTAJ5MbkS@aspen.lan>
 <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, May 29, 2026 at 12:16:07PM +0200, Neil Armstrong wrote:
> On 5/29/26 12:07, Daniel Thompson wrote:
> > On Tue, May 19, 2026 at 10:43:38AM +0200, Neil Armstrong wrote:
> > > Document the Silergy SY7758 6-channel High Efficiency LED Driver
> > > used for backlight brightness control.
> > >
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
> > >   1 file changed, 53 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> > > new file mode 100644
> > > index 000000000000..80e978d691c2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Silergy SY7758 6-channel High Efficiency LED Driver
> > > +
> > > +maintainers:
> > > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > > +
> > > +description:
> > > +  Silergy SY7758 is a high efficiency 6-channels LED backlight
> > > +  driver with I2C brightness control.
> > > +
> > > +allOf:
> > > +  - $ref: common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: silergy,sy7758
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  vddio-supply: true
> > > +
> > > +  enable-gpios:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - vddio-supply
> >
> > Sorry for missing this in v2 but is vddio-supply really a required
> > property?
> >
> > It's unusual for supplies to be mandatory (and the it is not mandatory
> > in the driver implementation).
>
> This device is a little bit special, the VDDIO regulator is used to provide
> power for the I/O via the enable input, so basically the enable gpio power
> level is provided by VDDIO.

I don't follow. The EN pin acts as both VDDIO and as an enable but it's
still effectively a power rail isn't it (albeit one with very low current
draw).

It looked to me like the correct way to model to two power rails
going into the chip is vdd-supply (main power supply) and vddio-supply
(EN/VDDIO) I don't understand why a single pin needs both a regulator
*and* a GPIO in the DT bindings?


> This is the recommended way from the datasheet, and I assume it will be used
> like that on other platforms (if it exists...)
>
> This is why it's mandatory and enabled first before setting the enable pin.

It's not mandatory for the C implementation. devm_regulator_get_enable()
will provide a dummy regulator if the property is omitted.


Daniel.
