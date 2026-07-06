Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC61C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF8F010E33C;
	Mon,  6 Jul 2026 10:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BWFu4YUB";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7352110E33C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:03:29 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 21E8133D;
 Mon,  6 Jul 2026 12:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783332160;
 bh=Sb4iMYjbedO64WmPLzaRf05zqar0z8v+EnBWdzETtUg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BWFu4YUBI/IcrAAjTK1CItkEH1FftGsDP7SOEZp9j02bgYinuypdBO11soxkSjvA8
 JUrJ6PgZHVkFxO+iKj0vkdfTPhpMH+TELU8hb9oTM7V4LqPJlqsFhllXBAvv0UE3x3
 +f97cTPme7hAI5ubiZRfwQDMmQ5h8WotKuUDjX6M=
Date: Mon, 6 Jul 2026 13:03:27 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: vga-connector: Allow
 hardcoding EDID
Message-ID: <20260706100327.GA66892@killaraus.ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdUCqTQ0fWDyHJkU=0gzFe88r0hsSk9tsgfQUZq4TRcAoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUCqTQ0fWDyHJkU=0gzFe88r0hsSk9tsgfQUZq4TRcAoQ@mail.gmail.com>
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

On Mon, Jul 06, 2026 at 10:08:57AM +0200, Geert Uytterhoeven wrote:
> On Sun, 5 Jul 2026 at 23:35, Laurent Pinchart wrote:
> > Since DDC version 2, introduced in 1996, VGA monitors have exposed EDID
> > data over an I2C bus. The bus is also used to detect the presence of a
> > connected monitor by trying to read the EDID data.
> >
> > Some devices where the VGA display is integrated in the device and
> > always connected do not connect the DDC pins. Some development boards,
> > such as the Renesas M3N Salvator-XS, also do not connect the DDC pins.
> >
> > To support those, add the ability to provide hardcoded EDID data in the
> > device tree. This is mutually exclusive with specifying a DDC bus, and
> > can only be done when the VGA display is guaranteed to be always
> > connected.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
> > +++ b/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
> > @@ -19,10 +19,25 @@ properties:
> >      description: phandle link to the I2C controller used for DDC EDID probing
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >
> > +  edid:
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +    description:
> > +      When the DDC signals are not wired to the connector, and the connected
> > +      display is not removable, this property is used to supply a binary EDID
> > +      blob for the display.
> > +
> >    port:
> >      $ref: /schemas/graph.yaml#/properties/port
> >      description: Connection to controller providing VGA signals
> >
> > +allOf:
> > +  - if:
> > +      required:
> > +        - ddc-i2c-bus
> > +    then:
> > +      properties:
> > +        edid: false
> > +
> 
> What if the DDC signals are wired to the connector on the provider side,
> but not on the consumer side?
> A DT overlay describing the consumer device can add an edid property,
> but it cannot delete the ddc-i2c-bus property in the base DTB.

As the use case is devices where the VGA display is an integral part of
the device, I don't this this is a big issue. I would be quite surprised
if a manufacturer wanted to support different SKUs with multiple VGA
display overlays, with the DDC signals wired up in the base board on all
SKUs, and on the VGA display side in some SKUs only. If that happened,
they could set the ddc-i2c-bus property in the overlays that wire the
signals, implement /delete-property/ support for overlays (would be an
interesting feature in my opinion), or as a very last resort propose
relaxing the constraint here.

> >  required:
> >    - compatible
> >    - port

-- 
Regards,

Laurent Pinchart
