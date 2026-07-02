Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0687BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4640510E2BB;
	Thu,  2 Jul 2026 09:28:11 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4543610E2BB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:28:10 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-738bcf9a573so483840137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782984489; x=1783589289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xiqnp7i51oc7KGFElhrnKuIK1In1osntTe68gEGmGg=;
 b=QnYWDTG0GowJcIsTNmbIT4q25ghAmsIjInexGcnnqg31fpvsXgwt82OyMSduM+kff3
 dbQwNmq14lYQOp+HM2IZe6DvL6MCVGezWDMOWH/Tx9F0VBAPeQRzE7CSvEwhakzkJxPk
 uFhqLkYwqxy1/lmLAGL26y4DhvU0ctSi80JPcCXnSAx6bICuWGLgU/cMCy1oX468RLKn
 HNCfXxciT1hhtep2HDum5jF08OXVR0PPqPxnege/21VE8osn6NsnUmgGfc1kMmnl0Wvl
 OrHbSwLANIfRY7TWpO9PqIX4YngPtFu83501JXhnmCnIpgFeEEkm3At+lW1jW3FNKjq1
 DwTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9O0axYhw8QRNV51K7CDBeK2N2zS1W5+oGQh721xj/PBREJF9FMB/uaY442NThFJDXp/eu1SwqRL4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHdPH+1GueIVJXjQQWQDaoc+kAl1xkV/J+jcP8mJk/IYbDJ12a
 tFd81l8g28cui3StmiVUGI76p1XbaIbOHtEBmOGf6OIZBe5NeGAVJL3p1MCku9a5vIM=
X-Gm-Gg: AfdE7cnoS6Bi+AQakGoSExoFstbCJugrmNVpJSVkz0clMVqEyrTwJsDONkPlPRSiDR/
 RAAWfnIOBAuVeNK0P5tsLozgLx29FLR9T9Q3dichdbp52wYZBuOUeUbTuFYQ9pL3wA2+i+lMaVB
 N5Va99wkeRhfugb8nDiqru3Gk3fRXAFUrxglLnVD1NPyRekjyFcaeVHNjZQxhd47ar7cz0zGaF6
 iR9Q29tcNfwp+wqgd2iQTtv97azpIJVgpHF3WDN4ObT4RrMoG2Xd5TB7XEPBalmd8fHqTA5HAj9
 94gPrx5dz5tiQ9whD8A+JFFAZVMYcsRMqqtpFSYc9TtABjySVTYGFaVFuNEyqI58/QldRQ/sHxt
 H9NJFKbGJk2lt0zrQOmqlfnO5DXWaligJuDi1uE/54Hh9yzavmEp8RkjTyWSU+TFkNRoU0qd3Oy
 2kAH+KmhcND6bCdIJMJc4Hj+ExhQ8VWGjSapIWRNYibivP3jRjdQ==
X-Received: by 2002:a05:6102:f87:b0:738:ff1b:942 with SMTP id
 ada2fe7eead31-73daa9bb6c7mr2129752137.22.1782984488944; 
 Thu, 02 Jul 2026 02:28:08 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e19f3f781sm1016544137.2.2026.07.02.02.28.07
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 02:28:08 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-738f3419eedso432534137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:28:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2JVzrCY1//5n4KuiMzs9NwWypB74hBy4c5klcwCK0GgzcOIhWkE7JluydTCbTt5PXdNixcSeX8p8=@lists.freedesktop.org
X-Received: by 2002:a05:6102:dd4:b0:650:aa33:5dd7 with SMTP id
 ada2fe7eead31-73da8519caamr2375794137.2.1782984487236; Thu, 02 Jul 2026
 02:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260615-rcar-du-dsc-v5-0-aed1a28610e4@ideasonboard.com>
 <20260615-rcar-du-dsc-v5-3-aed1a28610e4@ideasonboard.com>
In-Reply-To: <20260615-rcar-du-dsc-v5-3-aed1a28610e4@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Jul 2026 11:27:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUoR_dUG9gHKpaR_53EcS5gm68=gqF3UE3aNApBZ5Wd_g@mail.gmail.com>
X-Gm-Features: AVVi8Ccj1J5pvkR0bSkeR64npr1GsYH8otXyCLdk_qEnm1EVAcQxHJFY-QII4Ko
Message-ID: <CAMuHMdUoR_dUG9gHKpaR_53EcS5gm68=gqF3UE3aNApBZ5Wd_g@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] drm/rcar-du: dsc: Add rudimentary Renesas R-Car
 V4H DSC driver
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

On Mon, 15 Jun 2026 at 15:12, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
>
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> The Renesas DSC Display Stream Compression is a bridge embedded in the
> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> 8k or 400 Mpixel/s. Add rudimentary driver, which currently acts as a
> pass-through bridge and allows DSI1 to be operational on R-Car V4H.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [tomi.valkeinen: use bridge->next_bridge, minor changes]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c

> +static const struct drm_bridge_funcs rcar_dsc_bridge_ops = {
> +       .attach = rcar_dsc_attach,
> +       .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +       .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +       .atomic_reset = drm_atomic_helper_bridge_reset,

As of commit 57acfbe5bbc16624 ("drm/atomic-state-helper: Remove
drm_atomic_helper_bridge_reset()") in drm-misc/for-linux-next, this
no longer builds:

-       .atomic_reset = drm_atomic_helper_bridge_reset,
+       .atomic_create_state = drm_atomic_helper_bridge_create_state,

> +       .atomic_enable = rcar_dsc_atomic_enable,
> +       .atomic_disable = rcar_dsc_atomic_disable,
> +       .mode_valid = rcar_dsc_bridge_mode_valid,
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
