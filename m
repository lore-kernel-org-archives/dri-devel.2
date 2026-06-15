Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84770CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9E610E303;
	Mon, 15 Jun 2026 09:25:12 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F045510E303
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:25:10 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-6efdb57d98fso651674137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 02:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781515510; x=1782120310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekHktY4/Tubvm6BgE1BfS1UNgz1F/icrKZN3pNx8f0Y=;
 b=hE6lRgtLvydX2C3id204JF1T6Ts3vrSa8VovlKz6MAPU7kQAXfUe5Pi2s/mVYqZdJ8
 tQY3XluFwEi/EUueeJO2eq0vihekhcHiGyOTVMs6IknASJK5MkNo2pkZ3itOwdKU1QcT
 OELYZvenqPF/ZkTeMvXdqzMMRWX0UN+m357cYt0uDeq9yTCqvZEqWB6iMTCFu/Re45zt
 qkfk3fJ2sBqQ8nhaFtzKN10yHIXopegkaXIo2AoUoBI6ENIs3xAFcXvP75mFfkROfNMk
 Kl4lpmTacwk34YIhFii2+Dw9UkxhNut/rrGU7Dwj/riF7OwEaXkDoY+HUo01bFedHWGu
 UW1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ91yYVc4NcXCAqSNMB2Oa9puxpk/NjO4pnGFq/bZXDH57ObaEdO7rcgqvmPAbnqKPi5wFgWlfNFw1g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEhe09U4jtg0gtGZGinRQvGpUhqHJQLXJ1Dj0EKDBl6sNlBk5A
 weSrZhp7UeW44dQEJVDAsZduQiBhzIEzPm6eLCKCtGaTs/ZDVqDkzRuH8Nb9zXOh
X-Gm-Gg: Acq92OHaA0y/CMlF6/MgIznxpMJVr28mRBKCWlKvtY6YhmeR3W/EdzDiDN1T0qHhci0
 g8dIhSUTk5fFheKuiHYjBQpkV/qgRdWSK7gHKSvtDfVlKa4ZqNI8wxRoGGBYvHoJExPPpXAkM35
 +8V54Std/LE3tTdiKGv3iM/8U80xVH/cN1wx8ZC31hSvFlT/e1KHWue24GGisJXRtPWsIifrlME
 AJ40Ed/Bls3EGLoACha5gxI/nPJJevLLQLEefVruBj8deW648kTFb5v0dwagD+V39SjloCymNEJ
 AwbGyljaniQPEoqb3sUjQW0nMzfHfyBWImlEfA59TBp79sKvxWbq+TmeopWm3gnS12OwOoS2xyM
 /ayTrtxXcdYJEZjZt+D0yQ7RdydDI2i2u+W4++4xnmMo6JZl1wa6Ok4V4dboK0U3EYJ19Hl9Es1
 C1x+kPKcN/mQpp40isNWN2MBudo14w8jnvmEJb0AArHEYudRB7C/XsNWtyT4k/
X-Received: by 2002:a05:6102:f13:b0:631:2cb0:bf8d with SMTP id
 ada2fe7eead31-71f5e1f25d4mr4071161137.6.1781515509728; 
 Mon, 15 Jun 2026 02:25:09 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com.
 [209.85.222.42]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-966a0149563sm2653658241.0.2026.06.15.02.25.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 02:25:09 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-9639b1ef167so1130520241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 02:25:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8/kQuRlYl/z13mnjUAsdI2RwPNAVoto83FjF9qJx+ib8GqIyvz6eZIsV2+jTfyF9/Be/Rhq85r5Oc=@lists.freedesktop.org
X-Received: by 2002:a05:6102:32c4:b0:6c2:e290:cc69 with SMTP id
 ada2fe7eead31-71f60e0fc5bmr5388435137.23.1781515508903; Mon, 15 Jun 2026
 02:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com>
 <20260615-rcar-du-dsc-v4-2-93096a1b56a3@ideasonboard.com>
In-Reply-To: <20260615-rcar-du-dsc-v4-2-93096a1b56a3@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2026 11:24:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxwvDmRqsdbA_ReCnnaDWbzzTKGCXw-64U-bSJfgiy7g@mail.gmail.com>
X-Gm-Features: AVVi8Ceq73VEJddOjmb1j9jjrYgT5rbGI4-mYSdD7C_MYewqPqxZACymjTcgJ3U
Message-ID: <CAMuHMdVxwvDmRqsdbA_ReCnnaDWbzzTKGCXw-64U-bSJfgiy7g@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tomi,

On Mon, 15 Jun 2026 at 08:28, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> The Renesas DSC Display Stream Compression is a bridge embedded in the
> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> 8k or 400 Mpixel/s .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [tomi.valkeinen: fix the example]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/renesas,dsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car DSC Display Stream Compression
> +
> +maintainers:
> +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
> +
> +description: |
> +  This binding describes the VESA DSC Display Stream Compression encoder
> +  embedded in the Renesas R-Car V4H SoC. The encoder supports all DSC1.1
> +  encoding mechanisms, configurable bits-per-pixel, resolution up to 8k.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r8a779g0-dsc
> +      - const: renesas,rcar-dsc

Please do not introduce new "renesas,rcar" fallback compatible values,
unless you are adding new support for a hardware block that is present
in SoCs belonging to multiple (nowadays I would say at least three)
R-Car generations.  The DSC is only found in R-Car Gen4 SoCs, so
"renesas,rcar-gen4-dsc" sounds more appropriate.
However, so far R-Car V4H is the only R-Car Gen4 SoC that has a DSC.
Even the very similar R-Car V4M does not seem to have it.
R-Car X5H has DSC-functionality integrated in its DisplayPort TX
controller, so that seems to be a different implementation?
Hence that rules out any family-specific compatible value for now.

The rest of the (system/core) SoC integration LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
