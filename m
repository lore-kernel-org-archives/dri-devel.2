Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EA9CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E8E10F473;
	Fri, 15 May 2026 08:14:04 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FF910F473
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:14:03 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-834f1075805so6247866b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832843; x=1779437643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTMs9H2zcG/hkZo7rCavYzdXjSvd0E+3ghPib3tFoJI=;
 b=ozWqPPLx+9XqL57SyJvsGsSPj4bHLo2nVGL6qfuap74cUxj78ecUh7eC58M0gmUdMj
 54x9H3klJTesDt9hg2n2UtQ3+KpU5erHP9fkNtF5MnO1mS9N1GMDBh6z3jG4P+Wl+A7t
 CpAu1CrUPLVJXXaqxJLm7DtqPLNqf3h2xu9aUPTL0snpXQyw2BzNTz7tLdOqdafd4Y3T
 fw7yNhfVzzeTTNUhy38iwkuZmwjNqwc789/4gDYazDdOG4EKys4Xx6AiMxOsZ6IyRzaH
 eaDGeOsV+4oaSFOrTEoHD96BLT34VHixt4ewmJkPqFvgtdRADWtcoYMq+1S6D3sTtfp8
 lomg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gihEcFsnaL6uADAuJeKDu6Gj/it8Rx8bXRG8Tbw+oMOWYNvCk9Tlxjzl5/QfxwPSl/X1bQVG0Nkk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQmq6Zrr1LyDSWQq1ihNWx+IDu8+KBOQf6kuQZ5Mmt8vPNFrbm
 2eVKCrPFlIrfiIZCMRFv0PvATfKrgGPe1daG926MsTdAVpqGP72Jeq0Z0RXhWBCb
X-Gm-Gg: Acq92OGQS/Sd8sg/8jGbodjCq7q7Vy54jtZkmhpeR1t6Kr6/saeB8zg0akVSPJ0Nrzz
 zYnhwPYQqXlsc5ibl0EfntajE5hDMPI984NA0Lzp38C2HtazqwCq3DQGks7nrJK97kkxSshXMKe
 qYRnFcRwhkEAClBR0qUh7u1o4ovt2MDlhx9uvktFWub+6QgqPvgMJGUq3nktpgZoTY6lS8NMw8m
 QLVfYNAgU9a2QU/x9EtMnjcjxeZGZvDtfBnOfkiHxRbS0pWQVpPe4HAAvo/ccdpjIXFIDbnojHO
 nMwtXbcAA+Qg0aHS3YrjVj4SRdvUBF0YoUuTYDde6o40QPMthiOn/G/N32x+pbSCvWBRlkoS46+
 chdaoCaNB1tTTVAqjOS4OoHpy4Bwo6gQjnDnlf5VRTeu77v25UCTig2rhUpGh5EI0ytckY6AK+I
 RSSfZtrgXXlKhNzNrm8ZRpFpHDpIm6r1sPC0v6O30feCwwTrgr1o6LaBPcl/c=
X-Received: by 2002:a05:6a00:2395:b0:82f:280a:d888 with SMTP id
 d2e1a72fcca58-83f33cac05dmr3502095b3a.12.1778832843217; 
 Fri, 15 May 2026 01:14:03 -0700 (PDT)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com.
 [74.125.82.47]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19f7cd19sm5196277b3a.54.2026.05.15.01.14.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 01:14:02 -0700 (PDT)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1329507c387so7342638c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:14:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/BbHk2GOlmsWDIEzpCU6Lp6gxNFQARJYh2NyLb/oe+kFs+6NnOP/YmmFgX/nzej6YKvOCpqBTEzsk=@lists.freedesktop.org
X-Received: by 2002:a05:6102:f94:b0:631:5ef5:8325 with SMTP id
 ada2fe7eead31-63a3d93b73cmr1247586137.8.1778832352115; Fri, 15 May 2026
 01:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
 <20260514-rcar-du-dsc-v1-3-d65f7a9e9841@ideasonboard.com>
 <CAMuHMdVTgQp9WRiFpLX+pP7kOGF2v6oButALPu1B8QkYhVyvJA@mail.gmail.com>
 <6db159d9-56af-4d79-a1f1-9d5a6349b5ac@ideasonboard.com>
In-Reply-To: <6db159d9-56af-4d79-a1f1-9d5a6349b5ac@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 May 2026 10:05:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVL9s=EHbw38kBzEVGa5-LawVY4YBUfSMA-6U+i3OSrbw@mail.gmail.com>
X-Gm-Features: AVHnY4IeYtwx3NtqULFNQ1UNiQVfhuhx7vVBY8D7FKyQ3HU9Ed8VUzHO4jOvKfs
Message-ID: <CAMuHMdVL9s=EHbw38kBzEVGa5-LawVY4YBUfSMA-6U+i3OSrbw@mail.gmail.com>
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

On Fri, 15 May 2026 at 10:03, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> On 15/05/2026 10:49, Geert Uytterhoeven wrote:
> > On Thu, 14 May 2026 at 14:25, Tomi Valkeinen
> > <tomi.valkeinen+renesas@ideasonboard.com> wrote:
> >> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>
> >> The Renesas DSC Display Stream Compression is a bridge embedded in the
> >> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> >> 8k or 400 Mpixel/s . Add rudimentary driver, which currently acts as a
> >> pass-through bridge and allows DSI1 to be operational on R-Car V4H.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> [tomi.valkeinen: use bridge->next_bridge, minor changes]
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >
> > Thanks for your patch!
> >
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
> >
> >> +
> >> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
> >> +                                  struct drm_atomic_state *state)
> >> +{
> >> +       struct rcar_dsc *dsc = bridge_to_rcar_dsc(bridge);
> >> +
> >> +       WARN_ON(clk_prepare_enable(dsc->clk));
>
> Ah, just missed your comment and sent the v2.
>
> > Who don't you use pm_runtime_resume_and_get() instead, like
> > rcar_cmm.c? Then you don't need to get the clock at all, and the driver
>
> Hmm, why wouldn't I need to get the clock? What does the runtime PM do
> on Renesas?

Runtime PM powers on the power domain (if present), and starts
the device by enabling its module clock.

> > will keep on working if the DSC ever ends up in a power domain.
> I can add runtime PM. I just felt that it was overcomplicating a "dummy"
> driver that just needs to enable the clock when the video pipeline is
> enabled.

Funny, I would say you are overcomplicating a dummy driver by adding
explicit clock control ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
