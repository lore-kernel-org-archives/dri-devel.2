Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118D8FF886F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 12:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B11C10E681;
	Mon,  4 May 2026 12:41:24 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CB410E681
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 12:41:23 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-95cc1a5fe9cso948569241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 05:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777898482; x=1778503282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znJkm+yheaBiOtiXBHrScjCf5aNJhz18eCP9uLN0zvY=;
 b=UcqUXD5R/PqPyjzFaqkCxoUnz5TaWIUnVGe4fpu2/M/+bclyjQC3R2UpMB7b9NgvS1
 Ln61BYmhhPZ9W8aexliu9U1Ugd5bLv+GQeYvwfWRlUtEqmXs5D6gf2GXNSiu6z8RwEjD
 dP3seyNBfH96V+56fkwbZPwIS5Psqs7sklml3HUjsVi2Jl+S0aIYM1AvaCCmmAjtL8GG
 9CjJJSSPa0CPgJ1F9s6Tpz6RXkexadlcYwyi+zeMUqqYdHPQHYPhT0m80JBmPxm9H3F/
 tZfCOY6GbahMdMYWvU8dC+nZB1nyBC0h01upw+pyILW5qs3q3hkvMsLZjPamnA80/kH3
 o8Iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Dib6Eb3DQt4kG1W0gmDzq+03P2TOOgXlB2nh8nubk/WX28pJTPTOMnhY28Y0AODQXsV0EklVD62I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJW+wVvY0YIClv3SXIVkc6UpZ9jHuh2fJAUfM1ux2shD/G3OxN
 tR2DU9Mzq4IKC2A7JplcQUKjZ8DLAcnUCT0rVpVIRel0+d9W+z9FeMBtP9vMMuhW
X-Gm-Gg: AeBDieuZu63k9RA1y4CwCjOl+XR8wVVxdiDygnA+JF+IBo8JmmIE2TitfxXf9zc+jQV
 3LFkBgp6oErhXd1layXGDSRZCqbWfliYCuX7rg8Zbcdo0MQ7ocTbttMeXH5Y/G24iLPW0el2mYM
 +CCQ47dfgcdDh80pulasmHmh7txaNB+jFvowRRJnC0M4ygZe4Q7llc2oNub6OtH/DGgRUGxHMFW
 uAgK5NQ8yh3Zvp88WRPVo2SiCgn4Kj7vg3Eo6/7s1Z4FhmJKjMEscKM/DjmbQEUj/jyCdv1KaZF
 IS5uz3Ezlzfme8MOV8LBSqdr+TTpvsn19dyXZtV9aqDExO1suwdaDHqgmtmyBmelQy0KAzlzAHM
 133OVnzGIvqD32M0II5RrIWB7KQe1T6CYJp+t8FM8c4Q7FBTSluly2x1LKEBapuwGamJTqcDQkL
 ouTIiFZiYXVT9wbDA67kcjKx9Acssphi1Qi/xDwW7YBYP+NZn3UnG/FH76Qykv7MOqezTZyfsi5
 kXUIpYAB3NQxA==
X-Received: by 2002:a05:6102:8096:b0:605:5e1b:1d2a with SMTP id
 ada2fe7eead31-62d86b1ad14mr3314866137.18.1777898482080; 
 Mon, 04 May 2026 05:41:22 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com.
 [209.85.221.174]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95ce068694csm5473640241.0.2026.05.04.05.41.20
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 05:41:20 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-57513a91514so425525e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 05:41:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8avGqmYEWWqlRrrOGrCxiWS1twvi18pvMYVrEk74TV66y7g6Zoy1FjjEItF4+XTJO5gQoYb2l5USA=@lists.freedesktop.org
X-Received: by 2002:a05:6122:130a:b0:56c:da22:6921 with SMTP id
 71dfb90a1353d-5750c5281a9mr3577419e0c.5.1777898480344; Mon, 04 May 2026
 05:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 May 2026 14:41:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUqdEZaK4C2zNjZ3Rh0TaiLrROUeWK-R5WZU+ULpArBrQ@mail.gmail.com>
X-Gm-Features: AVHnY4LvtR9sYYwFkbyXTFSDx7n1q3qDBs-g1S0RCiV3vvmXtOpqt-05ZZXwFh0
Message-ID: <CAMuHMdUqdEZaK4C2zNjZ3Rh0TaiLrROUeWK-R5WZU+ULpArBrQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/21] Add support for DU and DSI on the Renesas RZ/G3E
 SoC
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, laurent.pinchart@ideasonboard.com, 
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
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

Hi Tommaso,

On Wed, 8 Apr 2026 at 12:37, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> This patch series adds support for the 2 Display Units (DUs) and MIPI DSI
> interface found on the Renesas RZ/G3E SoC.
>
> RZ/G3E SoC has 2 LCD controller (LCDC0 and LCDC1), both are composed
> of Frame Compression Processor (FCPVD), Video Signal Processor (VSPD),
> and Display Unit (DU).
>
> LCDC0 is connected to LVDS (single or dual channel) and DSI.
> LCDC1 is connected to LVDS (single ch), DSI, and GPIO (Parallel I/F).

Thanks for your series!

> Tommaso Merciai (21):
>   clk: renesas: rzv2h: Add PLLDSI clk mux support
>   clk: renesas: r9a09g047: Add CLK_PLLETH_LPCLK support
>   clk: renesas: r9a09g047: Add CLK_PLLDSI{0,1} clocks
>   clk: renesas: r9a09g047: Add CLK_PLLDSI{0,1}_DIV7 clocks
>   clk: renesas: r9a09g047: Add CLK_PLLDSI{0,1}_CSDIV clocks
>   clk: renesas: r9a09g047: Add support for SMUX2_DSI{0,1}_CLK
>   clk: renesas: r9a09g047: Add support for DSI clocks and resets
>   clk: renesas: r9a09g047: Add support for LCDC{0,1} clocks and resets

I have queued these in an immutable branch, targeted for renesas-clk
for v7.2, and for consumption by the DRM patch(es) that have a hard
dependency on the addition to include/linux/clk/renesas.h.

>   dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL
>   dt-bindings: display: renesas,rzg2l-du: Add support for RZ/G3E SoC
>   dt-bindings: display: bridge: renesas,dsi: Add support for RZ/G3E SoC
>   drm: renesas: rz-du: mipi_dsi: Add out_port to OF data
>   drm: renesas: rz-du: mipi_dsi: Add RZ_MIPI_DSI_FEATURE_GPO0R feature
>   drm: renesas: rz-du: mipi_dsi: Add support for RZ/G3E
>   drm: renesas: rz-du: Add RZ/G3E support
>   media: dt-bindings: media: renesas,vsp1: Document RZ/G3E
>   media: dt-bindings: media: renesas,fcp: Document RZ/G3E SoC
>   arm64: dts: renesas: r9a09g047: Add fcpvd{0,1} nodes
>   arm64: dts: renesas: r9a09g047: Add vspd{0,1} nodes
>   arm64: dts: renesas: r9a09g047: Add DU{0,1} and DSI nodes
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable DU0 and DSI support

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
tags/clk-renesas-rzg3e-plldsi-tag

for you to fetch changes up to 272a6e2ad164094045af520299b5df3ce1763061:

  clk: renesas: r9a09g047: Add support for LCDC{0,1} clocks and resets
(2026-05-04 14:03:08 +0200)

----------------------------------------------------------------
clk: renesas: rzg3e: Add support for DSI clocks

RZ/G3E Clock Pulse Generator PLLDSI limits, shared by clock and MIPI DSI
driver source files.

----------------------------------------------------------------
Tommaso Merciai (8):
      clk: renesas: rzv2h: Add PLLDSI clk mux support
      clk: renesas: r9a09g047: Add CLK_PLLETH_LPCLK support
      clk: renesas: r9a09g047: Add CLK_PLLDSI{0,1} clocks
      clk: renesas: r9a09g047: Add CLK_PLLDSI{0,1}_DIV7 clocks
      clk: renesas: r9a09g047: Add CLK_PLLDSI{0,1}_CSDIV clocks
      clk: renesas: r9a09g047: Add support for SMUX2_DSI{0,1}_CLK
      clk: renesas: r9a09g047: Add support for DSI clocks and resets
      clk: renesas: r9a09g047: Add support for LCDC{0,1} clocks and resets

 drivers/clk/renesas/r9a09g047-cpg.c |  84 +++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.c     | 181 ++++++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  12 +++
 include/linux/clk/renesas.h         |  20 ++++
 4 files changed, 297 insertions(+)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
