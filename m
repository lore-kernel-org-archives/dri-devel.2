Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D94CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 11:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08B610E0C5;
	Mon, 18 May 2026 11:41:08 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CFC10E0C5
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:41:07 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-575171b1ce7so511724e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 04:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779104467; x=1779709267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3bmWUZgjAYZamnd3Aw3Zf+CdNP9jYAgiNz9GJP8Rro=;
 b=hribzv7D4NdvBVBw1eiVesgmw9pIo5YD/QeYqR2x53SNXGm/ZvkXovGweiHrwF58jw
 KBN9jdbFYyGA6/Cz2N+y3W3uQ/+Dz2w9T3GlAvFOLW7p2oHzh0aK5RUY3UzVf3jOn0Yd
 RYz0/hUFoDVH95W4jokZzshXOtoa1UmydDunL67rDBB7n/Vy/t1PqD6NRFmF6OETGJNE
 Jw6FXNxMGgaOlf0a+6FflaX+OpiYDyzyNUz3Wf0WtVNyKDNYQCF1kMl5mH8e/JDnVvsA
 Vsrkdeg+uDgFEj92UVLCRYg7SNcSOuE6oTROMuhSHyxJV3xSGprbssRTOwCcGCkRvcgm
 XHLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ByciTic1g9WDGVukKjtDqlbexlVjfyzljmeqsU7smAufixElsFeXHBkGCqOy/T94CJzRoSUuW5yk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzV+qSakVWLVuwm79eDBy3MgsZrD2EfmgE1PVQY+cL3ejn9dLd
 LnUJn8SmDQ6uyPVbfnjqhs7rD8n+InjycSxkGAG9yoopx/IhzoCcdmRx873bb7mJ
X-Gm-Gg: Acq92OGjykIEKHPr1+iadhAGaVNkmhH1wqhtJvASgnP9OupaS4B0H2nQZxJYTdPOoDM
 dQVRvCUENgVzhkUVGS0Uu+kzY6gu9OXE8wZBKradU05B6izQn9U3JgtQpC5kSadx2mV13MgdGRP
 fpsoiDaNA0DirtQv3sQ2C64nwCpXEFfkgm1NyyH0zsjR2iHUeu4rWDVUBS0d1xAns1d2jeA0oqH
 xYfpo8kbMh/ph34iAX8M5IPl5ib6vKxGH8I8cp6RyygMuo4U2K/c0hiORucUQXqt3D2msv3vxBs
 zge1RBN5yOc1TcRXs4Jfgti3ZVUQhfs9xX2PWKk0kHpYH1t8w2aytxXx/c4b/tcHG0QOMYvEJhJ
 epqFjh+qJLBhlevLiOInmczU/uW6GEHU85dKD9hjtfdw+dP9RtmJKLNMXheN7hDHm1ylUq9zUht
 7vMS9m6JOzzR3qUjTIXG6etyt68AEOHGSiX3kd3hFL/GGqjb+7dKe8YTkt1YDy11xZ
X-Received: by 2002:a05:6122:338f:b0:56e:e68e:9fc2 with SMTP id
 71dfb90a1353d-5760c013b50mr8132671e0c.10.1779104466582; 
 Mon, 18 May 2026 04:41:06 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5760f622b05sm5896848e0c.8.2026.05.18.04.41.03
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 04:41:04 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-57513a91514so525419e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 04:41:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+PoRKniUBn8y7TLzN5Wk1wEKtXukILDMHXXV0xXM9WZPUO/esvhrFRQgNWyw4reiFQzYM9jZtvSQ4=@lists.freedesktop.org
X-Received: by 2002:a05:6122:4690:b0:573:a779:62cf with SMTP id
 71dfb90a1353d-5760beaed3bmr5626640e0c.7.1779104463611; Mon, 18 May 2026
 04:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
 <20260515-rcar-du-dsc-v3-3-164157820498@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v3-3-164157820498@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 13:40:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUf4dGnK4ooTyw_31Ueanr-Ym3nhML4a12exU+5nFYh2g@mail.gmail.com>
X-Gm-Features: AVHnY4Lo5h0gdtI7uD_PcBRMzgonT5rakDO4TjP7cpU7h0ngOw5-dH_yEpIVciE
Message-ID: <CAMuHMdUf4dGnK4ooTyw_31Ueanr-Ym3nhML4a12exU+5nFYh2g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drm/rcar-du: dsc: Add rudimentary Renesas R-Car
 V4H DSC driver
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
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

On Fri, 15 May 2026 at 11:10, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
>
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

> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c

> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
> +                                  struct drm_atomic_state *state)

drm_atomic_state is no more since commit 5164f7e7ff8ec7d4
("drm: Rename struct drm_atomic_state to drm_atomic_commit") in
drm-misc/for-linux-next (next-20260506 and later).

> +{
> +       struct rcar_dsc *dsc = bridge_to_rcar_dsc(bridge);
> +
> +       WARN_ON(pm_runtime_resume_and_get(dsc->dev));
> +}
> +
> +static void rcar_dsc_atomic_disable(struct drm_bridge *bridge,
> +                                   struct drm_atomic_state *state)

s/drm_atomic_state/drm_atomic_commit/g

> +{
> +       struct rcar_dsc *dsc = bridge_to_rcar_dsc(bridge);
> +
> +       pm_runtime_put(dsc->dev);
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
