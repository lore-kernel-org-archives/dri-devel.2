Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695E606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhmZVsm1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D207210E885;
	Tue, 24 Nov 2026 13:40:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8361810E885
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:40:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CAE4402CC;
 Tue, 24 Nov 2026 13:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791031F000CA;
 Tue, 24 Nov 2026 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795527612;
 bh=LXiFx+L5CCwKVruNwA9sXl2NhTIyj3jvkEbySanPels=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BhmZVsm1F03k1gQhR42vPYWI3yvM5KqUr5TzQXRw69br9dDrzS24ACF0CW0cWStRv
 nhKYE5mMbiV3T0C0P2suHiRK1UxBghW8geD2ZwEdC+Bn5QnjyZwO8yABHU4x68W4+d
 Qkgzn/NMNWWuG+VM8hzD6q2X5loLeFUE6JKU+/VBu3Fvm3WFNY/wQLESZnWRvp1c6z
 sb9dHgjUZ9PYK4q8Vua/64XIVO6yl12N7xmwdf9HBqGBeJkKCmNL74J5/f8NjyJYdj
 VcZU3nKP5JWCkgoWZUUEwoneTHW2xF12oB56sa7R+p3llx6MG3LtW7wGvIQEqDRsAs
 Y4u96/vQvkDmQ==
Date: Tue, 24 Nov 2026 07:40:09 -0600
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
 conor+dt@kernel.org, lee@kernel.org
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound
 card
Message-ID: <20261124134009.GA43712-robh@kernel.org>
References: <cover.1795505160.git.hns@goldelico.com>
 <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
 <sashiko-outbox-230655@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-230655@kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 07:40:31AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Medium] dt-bindings: sound: openpandora sound-dai omits mcbsp4 and
>   twl4030 DAIs
> - [Low] dt-bindings: sound: openpandora sound-dai lacks per-entry items
>   list
> - [Low] dt-bindings: sound: openpandora example has status property and
>   wrong order
> --
> 
> commit a7d9248344c1d8736a83ed4cfd8b21aad87db0cb
> Author: H. Nikolaus Schaller <hns@goldelico.com>
> 
> dt-bindings: sound: Document OpenPandora sound card
> 
> This commit adds a Device Tree binding schema for the OpenPandora OMAP3
> audio subsystem connecting OMAP3 McBSP, the PCM1773 DAC, and the TWL4030
> codec.
> 
> > diff --git a/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
> > new file mode 100644
> > index 0000000000000..6c4d69ffc1c50
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
> 
> [ ... ]
> 
> > +  sound-dai:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 2
> > +    maxItems: 2
> > +    description:
> > +      Phandles to the audio CPU DAI (OMAP3 McBSP) and the codec DAI.
> 
> [Severity: Low]
> Should sound-dai define an items list with a per-entry description for
> each phandle instead of using minItems/maxItems with a free-form
> description?

This would be why you broke everyone else. sound-dai already has a type.

> 
> [ ... ]
> 
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    sound {
> > +        compatible = "openpandora,omap3pandora-sound";
> > +        status = "okay";
> > +
> > +        label = "OpenPandora";
> > +
> > +        amp-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> > +        amp-supply = <&aux_5v>;
> > +
> > +        widgets =
> > +            "Line", "Line Out",
> > +            "Line", "Line In",
> > +            "Headphone", "Headphone Jack",
> > +            "Microphone", "Mic (internal)",
> > +            "Microphone", "Mic (external)";
> 
> [Severity: Low]
> DT binding examples normally omit status = "okay", and the property
> order in the example node (widgets, routing, sound-dai) does not match
> the order declared under properties: in the schema (sound-dai, routing,
> widgets).

Also correct comments.

Rob
