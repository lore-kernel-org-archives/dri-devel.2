Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4511CCD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99ECF10E03B;
	Fri, 15 May 2026 07:56:38 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE8F510E03B
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:56:36 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2ba928852a5so59887985ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 00:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778831796; x=1779436596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAZHu6XpvwN5l5f2FSQxtIsJfHFz80+bclBZd6bS4os=;
 b=SgRv56YmNymDNpcE2BPNutolkkot3GygYT7pU7FDga4mN4vjp3ZLhttnN8qWikFecX
 sAbizjIj63Hl36//kpsYVDxR+D0i43veFKNziwvnKu/dOiUB1hjjPq0NSALD7AQgXAKi
 PQj1QzPwmCukmQxD+zP9/M8oGV4T/Kn3Gm9AODElrFzoP1jQGJWE58u5rzaLdfaR3PF/
 nC4slhw13n1MdgUEMg8xSG9vU+JVxPd6OhuX7BW/JJpc8xQsTdsj5/19NVExRE0Owg4G
 1TIfiTQeXrKFAMmNHjbsiqRXsXlAVvDs2e6GZi81MHwfydqQUVSu95snP/BNwUMI4Q8z
 76Pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5/oE0vLaAbLw4iXIjDYDdDfKXYEnQSDAz9Q5vuF9K/HjPmOIyed58BvacKtKigZytu+nP0dTcGLA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFJGJT76y4P4eiUBQsNgzcJZILLLbUg7NmjvcCjQB8171++AQn
 Wr50DRm9YjXOXeUfyDaz3YBRlZCCFM9YF5n07xyQd5kuhQ+QagsSvKWwMsPnvuK/
X-Gm-Gg: Acq92OGYTkvLAjxHyyDNx3MMDRUitzmcaeF60pKcRtZXz3Zbi1qhkwbR+LDeJ07xkF3
 i8syV7jOq2gMC+uLaxwRDOu+x2vZspwyIPeNAZqdGT4+UlBBfe7b8wKQccIp5nFmnE9E1TLpCSl
 KE7cDSzddakP6wwQ6JEiznKIZu9dItRhmi1Gge0ZNhdnTGAlXb/Y1BRuiDqXu5zXJ7veA+I4Xu+
 wXPf5+/J7Y0GUA1r4dH14tv1HqO4ciecHYM+NC7BTNDizgIEE1A7r9iq3szEEXRilkYgdEWuwwC
 p/64uCOeh01MfdKOf/NTkL6/vWq7JANWK7FS73+qPABg5zJZZyElJJv0R+I9zG/wea2Jwkx+g51
 lijL+ZXx8NQ6L7S92ecAIFoMJX8cr/097E7S10SNPnW1NyP/upxbl+gP6C9tN2s+4KlG3y8++qW
 9GuPoZSnMjjIr6mnE4eeAPbZaoIAWZRQpMoZjVix9ycaBtN45kJR6bJhwODjmkEjA=
X-Received: by 2002:a17:902:8647:b0:2bd:7b82:bc71 with SMTP id
 d9443c01a7336-2bd7e887088mr22979245ad.20.1778831796226; 
 Fri, 15 May 2026 00:56:36 -0700 (PDT)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com.
 [74.125.82.179]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f5d2sm49176505ad.23.2026.05.15.00.56.35
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 00:56:35 -0700 (PDT)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso5091188eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 00:56:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/rx5b1HxRRC1Gx87d1JJCUVUct8Vvi35owOoqd+kgtnhSH7wFjvIjgBabPFLn9xO/ISCrgI3nM1jI=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3f05:b0:62e:63e8:427b with SMTP id
 ada2fe7eead31-63a39a5f9e4mr1494077137.0.1778831365156; Fri, 15 May 2026
 00:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
 <20260514-rcar-du-dsc-v1-3-d65f7a9e9841@ideasonboard.com>
In-Reply-To: <20260514-rcar-du-dsc-v1-3-d65f7a9e9841@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 May 2026 09:49:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTgQp9WRiFpLX+pP7kOGF2v6oButALPu1B8QkYhVyvJA@mail.gmail.com>
X-Gm-Features: AVHnY4KQ6u1JetcDt3qGv1sa7SAF13W-c5qtL3drtJoKYhKLpQQVXnl4eLgch0w
Message-ID: <CAMuHMdVTgQp9WRiFpLX+pP7kOGF2v6oButALPu1B8QkYhVyvJA@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H
 DSC driver
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
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
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

On Thu, 14 May 2026 at 14:25, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> The Renesas DSC Display Stream Compression is a bridge embedded in the
> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> 8k or 400 Mpixel/s . Add rudimentary driver, which currently acts as a
> pass-through bridge and allows DSI1 to be operational on R-Car V4H.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [tomi.valkeinen: use bridge->next_bridge, minor changes]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c

> +
> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
> +                                  struct drm_atomic_state *state)
> +{
> +       struct rcar_dsc *dsc = bridge_to_rcar_dsc(bridge);
> +
> +       WARN_ON(clk_prepare_enable(dsc->clk));

Who don't you use pm_runtime_resume_and_get() instead, like
rcar_cmm.c? Then you don't need to get the clock at all, and the driver
will keep on working if the DSC ever ends up in a power domain.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
