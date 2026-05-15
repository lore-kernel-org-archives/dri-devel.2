Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D19CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6024D10F47D;
	Fri, 15 May 2026 08:48:01 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB67110F47D
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:48:00 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-95695190911so2292215241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778834879; x=1779439679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVgJPqzdVEsAMlVw8p1sldLEqlhvUsFX5k1afv6GStQ=;
 b=hK5VDpbEoh8iRmjZgUOegLPevYMqPi18eSnXu3M1flsQ/3J5w6Az1UsR/KqW21Cdip
 coRuzUdFMusOplQ7u9BFOoNT5h/TQ43531yLbKgpPhFJ0bbsUrSqQ42b8x+v95UDzE3c
 V1yB8THRwkbJ2MF7QPT1cdL2DuvWnWfuEWzQDKExfzj49zZMTOohwM7UcuJnXsdeWKFH
 3xk+8Xj6h25RUMJcdnM9QHVKpvSssbOChBlR1+jdqDZyHOfqFClB09UNhi1rQqz7e7VA
 7OXXvq6EvK04q1wy7xYPylEE1vLJF/2+amq8vHfgwIZ/RtRGV7zI5qCdch1KNYB6hRWV
 ftdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ItBzFaKeaBU/NE21ULkn9UxeqQOf1noe44zfv3BKTDYlf6Pso6f7XFHykPgLv5nobJtKzT8ZU10A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMmRC97cezNkk+oqDNf560S/CpI+6pTuZEGfs9O6fLU+9RRalI
 /+yluF+/5a96GiR4VtgwkRoNtcR02bHOwmEzb+muxgRjMPaKCXpSKz+K3YQbPmyd
X-Gm-Gg: Acq92OF6S0K/9lkRfhqv+CDleHYdxVAXDogFhnAXS/6EEjkGA5VC9cw2yuOco/AV2M1
 OfANLU/RWkFlf6Hgt+JEVYceKzP4SDv8ga/y/JEc5lDmPZk/993MELuPHu6HJRJFJ43YmPHujLu
 e0EFJxXoV5h/gWqFpX3nnmSMUPFu8TxieAVKptE6eicdrDqfxSK90MDfEq1Nrc4QQLuDPf98CQC
 ju3gRhZvKZZjM/qN/Wcx0E60gjqRrkk5xdbDDX39CllzFUHjMggpjNeCwNERKM48ZZHHGPhCEvH
 b/ay/yAW+BtO9LyXwnSi/091vyK6Kf55RpYHQQYuJKADeiN4AIuLyJgEo64gDXa/uYDEewhB/Qc
 o8Usxmq5OdIUfpXb0WReP4xFW+y3r4bWV+4fSKo96llnwAS41D2ryxEbP2lnbs4cOiY4fAk2mt2
 K02Isbw791raRur+bBBU0DiEKTtwuPGUfh2jlTaw0Zro/fCgDjrgIjrB/bVZWabnzm
X-Received: by 2002:a05:6102:1528:b0:630:2428:7abe with SMTP id
 ada2fe7eead31-63a3cf11014mr1283721137.9.1778834879441; 
 Fri, 15 May 2026 01:47:59 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com.
 [209.85.221.170]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95fc2f874easm692733241.9.2026.05.15.01.47.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 01:47:58 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-57513ac61f0so2673044e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:47:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+LTjrI2x2+8GG3MOkfrvUminzMf9Ymknvt8VGR6/CLyf/tBqz33WlSQeNGMdCbhPUYggC3DNHo7J8=@lists.freedesktop.org
X-Received: by 2002:a05:6102:358e:b0:62f:34db:9474 with SMTP id
 ada2fe7eead31-63a3ee86884mr1297663137.20.1778834878086; Fri, 15 May 2026
 01:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
 <20260514-rcar-du-dsc-v1-3-d65f7a9e9841@ideasonboard.com>
 <CAMuHMdVTgQp9WRiFpLX+pP7kOGF2v6oButALPu1B8QkYhVyvJA@mail.gmail.com>
 <6db159d9-56af-4d79-a1f1-9d5a6349b5ac@ideasonboard.com>
 <CAMuHMdVL9s=EHbw38kBzEVGa5-LawVY4YBUfSMA-6U+i3OSrbw@mail.gmail.com>
 <d7447f51-c2f7-4947-9fd0-ac0d45027c59@ideasonboard.com>
In-Reply-To: <d7447f51-c2f7-4947-9fd0-ac0d45027c59@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 May 2026 10:47:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUS9jrsjqqPRKXJa9978kj1aYZ9aPrepv5kueiHGGLkCg@mail.gmail.com>
X-Gm-Features: AVHnY4JCOAjr3bsj3LmrYGms2JUgvp1AhIShwYqx91e-BUfZ61J5zvr2A9mA72E
Message-ID: <CAMuHMdUS9jrsjqqPRKXJa9978kj1aYZ9aPrepv5kueiHGGLkCg@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H
 DSC driver
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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

On Fri, 15 May 2026 at 10:17, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> On 15/05/2026 11:05, Geert Uytterhoeven wrote:
> > On Fri, 15 May 2026 at 10:03, Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >> On 15/05/2026 10:49, Geert Uytterhoeven wrote:
> >>> On Thu, 14 May 2026 at 14:25, Tomi Valkeinen
> >>> <tomi.valkeinen+renesas@ideasonboard.com> wrote:
> >>>> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>>
> >>>> The Renesas DSC Display Stream Compression is a bridge embedded in the
> >>>> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> >>>> 8k or 400 Mpixel/s . Add rudimentary driver, which currently acts as a
> >>>> pass-through bridge and allows DSI1 to be operational on R-Car V4H.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>> [tomi.valkeinen: use bridge->next_bridge, minor changes]
> >>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >>>
> >>> Thanks for your patch!
> >>>
> >>>> --- /dev/null
> >>>> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
> >>>
> >>>> +
> >>>> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
> >>>> +                                  struct drm_atomic_state *state)
> >>>> +{
> >>>> +       struct rcar_dsc *dsc = bridge_to_rcar_dsc(bridge);
> >>>> +
> >>>> +       WARN_ON(clk_prepare_enable(dsc->clk));
> >>
> >> Ah, just missed your comment and sent the v2.
> >>
> >>> Who don't you use pm_runtime_resume_and_get() instead, like
> >>> rcar_cmm.c? Then you don't need to get the clock at all, and the driver
> >>
> >> Hmm, why wouldn't I need to get the clock? What does the runtime PM do
> >> on Renesas?
> >
> > Runtime PM powers on the power domain (if present), and starts
> > the device by enabling its module clock.
> >
> >>> will keep on working if the DSC ever ends up in a power domain.
> >> I can add runtime PM. I just felt that it was overcomplicating a "dummy"
> >> driver that just needs to enable the clock when the video pipeline is
> >> enabled.
> >
> > Funny, I would say you are overcomplicating a dummy driver by adding
> > explicit clock control ;-)
> Well, now that I know the runtime PM does magics behind the scenes, you
> are right =).
>
> How's "module clock" defined? Is it the first clock in the clocks DT
> property?

It's the clock pointing to the cpg device node, and having "CPG_MOD"
as its first cell.  Usually it's the first clock.  Note that e.g. the
DU is special, as it' is represented by a single device node with
multiple module clocks (and multiple (but less) resets), due to the
tight integration between the individual channels.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
