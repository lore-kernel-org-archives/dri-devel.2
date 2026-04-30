Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4683FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 12:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC62210E19C;
	Thu, 30 Apr 2026 12:07:21 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5C410E436
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 12:07:20 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-662efd1bdd4so547355eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 05:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777550840; x=1778155640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksIL4rip+tLI1Yx6QhQXSN6krUTnsd9SRkVzjQXrZjA=;
 b=nGm43cLd14D50Drks0x4PrPjnYS0sh81pqkbnsvppmVHSGSep2mp7DZp9WJfZjJY3Y
 OrtJTZsGNbnoW3PGEzjB4XSSeKFlmhvfW9sKmvpyK2XcwMMq075SSDoGtEr2Y05NJVJ/
 aICYlgVfwvxoTONvuD89h96RcOcZ3uv9Hcf7Pw052tvdYA6DQrx9BZ2VyDzRTYiYrae0
 +nmoLhVK+fjJ+3a694PmMtUkDYpTUBtp2wTGrvvV41mmpwWkFVdocxT04P3qcXExYFwT
 TLlFqBWidbQG+l2t09Rj/2LC2M1tgnrrhgH7PBAYTaxvNDsg7y4275j2t8R1LQxNuIac
 Gq7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/04oT5IGujIGAKdOt8hTO5AcM27fyTIO+1w+e2c1QAFuK8mPgGUBqJXwT/V7UyHbDEXm7Sl9NXG20=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpGIPxNnHXR3WCdUQr2iEqh0YdCao/8EODtdtSHsKBH4I2La3E
 j3uHtOYNbKJhYhX26Rhfrc7TJqp6UaUOHM714yD/r2ts8rwIJgWasaSejKmHUaQ5SS4=
X-Gm-Gg: AeBDiesVgYZYuUmfIcN4nWgHLCeY7Amsec2w8ZiPaZHXQSZQzgiWvfJsfLrVLxs9QOF
 ZktlzHgBjNBjLHFDf8oH+d7IzW1UlN7HW+EHn0LNaajKkVRRzTUC5LVfmB1IV5Tb7cH97qXRzBP
 o9cKNUSnqx/WbTiXZHu78nCVB/XEVeBggBOKFeWGXT/p8NrxtTPD6FOF5zZ5/4hALmYtioPSnCH
 K+EHARsHa6/EVsV2pBSwdQawidlOCzklcSoqAxfdv2PVvPmLbYeMpUH0t1APZoZXgkFGUnPhHTQ
 Y+nnxV7NkEvydPKLH8qWfLjXREaP/KFbf7Vn6yAmxi9vmLxGOOmYksyW15gzsDV0ZZawbxKIUi0
 0g4Fczg0fD+/qBnSRWTYqG/vQEbOAKGbBoNfFTEScnZtduBLq92TcfTbglzVqjf9o1HStZNe3cj
 lH8ADt/lYT9sAcXQy4v7QJFFfPyBI6nO4cy1peHiwXm9bdzYT9KFjv96F4NUMgxeCikPoNyjU=
X-Received: by 2002:a05:6820:1608:b0:696:2b13:6c63 with SMTP id
 006d021491bc7-6967bd1bc0emr750487eaf.10.1777550839497; 
 Thu, 30 Apr 2026 05:07:19 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com.
 [209.85.210.50]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966be5fa1fsm2991011eaf.12.2026.04.30.05.07.18
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 05:07:19 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7d1872504cbso688036a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 05:07:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/aC/dW9tsjkAz+EiPRrfyZ6hke3wyDjKvD7oMgj4w2/f4RZ2XPGVqrWWH6f/DgD3a/J+AC6GdTdPw=@lists.freedesktop.org
X-Received: by 2002:a67:e708:0:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-62afc506100mr613209137.3.1777550404889; Thu, 30 Apr 2026
 05:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260430110652.558622-18-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2026 13:59:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
X-Gm-Features: AVHnY4K0yYb6vTu9KdtDciwvAziqboYRX_ITZ386sa6ttixZ1EP_Mzy9gi4Pi0E
Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
Subject: Re: [PATCH v7 phy-next 17/27] phy: introduce phy_get_max_link_rate()
 helper for consumers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
 UNGLinuxDriver@microchip.com, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
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

Hi Vladimir,

On Thu, 30 Apr 2026 at 13:07, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> In CAN drivers, the transceiver is acquired through devm_phy_optional_get()
> and NULL is given by the API as a non-error case, so the PHY API should
> also tolerate NULL coming back to it. This means we can further simplify
> the call sites that test for the NULL quality of the transceiver.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Markus Schneider-Pargmann <msp@baylibre.com> # m_can

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 3 +--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # rcar_canfd

> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
>  int phy_notify_state(struct phy *phy, union phy_notify state);
>  int phy_get_bus_width(struct phy *phy);
>  void phy_set_bus_width(struct phy *phy, int bus_width);
> +u32 phy_get_max_link_rate(struct phy *phy);

This (and all the existing getters) should take a "const struct phy *".

>  #else
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
