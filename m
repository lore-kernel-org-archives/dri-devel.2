Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCB7FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB5A8992E;
	Wed, 29 Apr 2026 12:22:27 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7CA8992E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 12:22:25 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a742b8b72eso3785068e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 05:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777465344; x=1778070144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYIYCIsBtJDK4jXwWO2JUdTXoGJvuUmgU1KwSHdoXoc=;
 b=mHlguGe+GUlb8BRdpe6JFja+Yg5ezxfRolQJPp5UKd06k5HnBQdaePddwbF6tVsMDK
 UIiWY0qgko8/B9GlenYmaDvul4a2+DkxkBV8JHtloJtedL5HPcVVqCT2w/oNtMRujh3l
 tiCSzqggvgSFFx5mmPNb0Dny94a20vT2gVESPEfobBlYvm9ISa64c2hNMWQf1V1ZNjFH
 qsh2fIfVE+itnfi7Q0BnmHG/PcBiJddaM++PJF8xT8k589d7shhMEYfhfM1fRfqTeBJl
 U9mMmhS3yYTiGYgf/qqWCsinVTn35B1g3PeymtRFlfyhzlPBqBz3vT+eoOc9pwhfU2M6
 giFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fFJwY+TPZ3BXKGM7AU9KlQy9/uLHyXoHi4dbufYtlDWIFvYzGQ419BtGbj9AAtzaY32Nv0qciH4I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/gq5yQTl/QbgJqtCD7CJbH43ViwplI+eXIOCeTNgDliMadYRV
 5c/+Uc8XL9UphMYzpuWr7unqK+WD7cyfpa54PrCLj/AtbvtcNqDvqXCVcK19zeN4MWA=
X-Gm-Gg: AeBDietuOCi7aiDAZWIYiPq4zdHTTNWFEidLETc/16RZSvyIYn/jeawmpHYq0M3r7zv
 8X9ugP8nwHjSqcWTDOVuzv3VLN6H3utYkhGm+Jz1bbhWLVmC9wtuz5oGJmAz1uTS1Hm1FbYuxGN
 VEtjOmN0dRi2fury9NKpEwy4wk9XKhj5hr9yLd02ijAi08gnCPjL3/qjtj3EC8AhL0G7kQOqdME
 rmsLGXNGWLS74qYcAMYhMpO91GYFIhMhOSLSFgu9a1W4/9cXLhnRKEwhC+bMl5KQzXg/uCYzmh8
 S7vuMASs5kg26BXtZPThmHv2f4K5eVd/mjk92zY6Ubjy2WXbZhITsscgs57jktRqOtaRN9WcWyq
 9A4c+782emmSqE7OBGS6ngVx7cqWhGvG5QrtEwqYbPBVQ8QMNkVILaolhU/2c3vkiWajqRC/7/z
 XbUJvwS6sHqTKs14xRSDdvlMjjM4cS5+z75NSId/WK/f56e7PN3J3K5O/xazoo0rxHCrUyt+QOU
 Mb8qfgc5v4VYQ==
X-Received: by 2002:a05:6512:2247:b0:5a2:d239:cb9c with SMTP id
 2adb3069b0e04-5a746626970mr2931624e87.28.1777465342891; 
 Wed, 29 Apr 2026 05:22:22 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a74a756d47sm498201e87.39.2026.04.29.05.22.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 05:22:22 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-38e7b8e3f38so105742071fa.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 05:22:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8XASOCvYFWJQLXB8cs2QqnCWUoCBbZmC9xoCyDZ3+baU4ER0b7uRuNcGCXMsUyHF9oz/Z+EQejL1o=@lists.freedesktop.org
X-Received: by 2002:a05:6402:2b8d:b0:676:9c6d:7448 with SMTP id
 4fb4d7f45d1cf-679bb0969d8mr3789280a12.22.1777465006980; Wed, 29 Apr 2026
 05:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260419193718.133174-7-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Apr 2026 14:16:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5NRFjGmLLSAFkst=y_v=haZ9_-oiZ7_3M2J1s5jiJSQ@mail.gmail.com>
X-Gm-Features: AVHnY4J_eIQauePt3-ENfJ0vvJTMmNJqoEy-L_5paGzJVO5LgQ5rAyTsYv0XxdM
Message-ID: <CAMuHMdV5NRFjGmLLSAFkst=y_v=haZ9_-oiZ7_3M2J1s5jiJSQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: renesas: r8a779md: Add Renesas R-Car
 R8A779MD M3Le DTs
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
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

Hi Marek,

CC wsa

On Sun, 19 Apr 2026 at 21:38, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> From: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
>
> Add support for the Renesas R-Car M3Le (R8A779MD) SoC, a variant of the
> R-Car M3-N (R8A77965) SoC. The Renesas M3Le SoC is a register-compatible
> variant of the R8A77965 (M3-N) with reduced set of peripherals.
>
> Signed-off-by: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a779md.dtsi
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the R-Car M3Le (R8A779MD) SoC
> + *
> + * Copyright (C) 2025-2026 Renesas Electronics Corp.
> + */
> +
> +#include "r8a77965.dtsi"
> +
> +/ {
> +       compatible = "renesas,r8a779md", "renesas,r8a77965";
> +};
> +
> +/delete-node/ &csi20;
> +/delete-node/ &drif00;
> +/delete-node/ &drif01;
> +/delete-node/ &drif10;
> +/delete-node/ &drif11;
> +/delete-node/ &drif20;
> +/delete-node/ &drif21;
> +/delete-node/ &drif30;
> +/delete-node/ &drif31;
> +/delete-node/ &hdmi0;
> +/delete-node/ &mlp;
> +/delete-node/ &pciec1;
> +/delete-node/ &sata;
> +/delete-node/ &sdhi3;

I am not sure disabling sdhi3 is correct.
The R-Car M3Le documentation says:

   "M3Le does not support MMC1.
    M3Le supports one MMC channel (MMC0) only.
    SD3 is used only for SDHI and is not used for MMC.
    M3Le does not support MMC HS400 class transfer rate."

The main R-Car Gen3 documentation says:

   "This LSI has four SD card interfaces (SDHI0 to SDHI3), two of
    which can also be used as MMC interfaces (SDHI2 and SDHI3)."

So while MMC1 is indeed sdhi3, sdhi3 can still be used in SD mode?
Do we need a new compatible value, as R-Car M3Le does not support HS400?

> +/delete-node/ &usb3_peri0;
> +/delete-node/ &usb3_phy0;
> +/delete-node/ &vin0csi20;
> +/delete-node/ &vin1csi20;
> +/delete-node/ &vin2csi20;
> +/delete-node/ &vin3csi20;
> +/delete-node/ &vin4csi20;
> +/delete-node/ &vin5csi20;
> +/delete-node/ &vin6csi20;
> +/delete-node/ &vin7csi20;
> +/delete-node/ &xhci0;

Shouldn't the following be disabled, too?
  - ohci1, ehci1, and usb2_phy1,
  - cmm1 and vspd1 (cfr. DU below).

> +
> +&du {
> +       compatible = "renesas,du-r8a779md";

Assuming the DU needs a new compatible value...

> +       renesas,cmms = <&cmm0>, <&cmm3>;
> +       renesas,vsps = <&vspd0 0>, <&vspd1 0>;

Shouldn't this be

    renesas,vsps = <&vspd0 0>, <&vspd0 1>;

? DU1 is unused, but DU3 is used.

> +
> +       ports {
> +               /delete-node/ port@1;
> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
