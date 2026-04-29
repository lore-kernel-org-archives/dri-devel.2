Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27FAFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A21310EFA0;
	Wed, 29 Apr 2026 11:32:48 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 875AB10EFA0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:32:46 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-56d958880ecso4188172e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777462365; x=1778067165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4uRNs5kbsz3D4/C3TCXfPmMeHwT6iVUCZwC9U3W8vY=;
 b=HsmEvtDiL5B9qNhjFa4sFR83GUGgBud81ZEWCqNMza3I/6QAKaKZF9DTbu9Ha75Fij
 GQaUfsAvxtFUQUrtU2XtyWUUM/MaRQPtnoLy/mc8VUUX40hRChvsUcTxAmApkVVlxLbi
 7QFzpTTQY/g+zag7lhOR5oOc2m2vjT9eOqQbcSKmKi2dnUR2/dF5dtnokq/nDew5J5Xg
 e6XIqUpD5CdwdhiCcr52n3npBgGN1r953TKWCOzhF8mExKIqwWFZV9uC5S5faQTi6U+S
 bCtnNVT6SE8g7GiqEUdTDJBG4SLtErm+1DSergdwhTw+j6E0ZDrLjL5aexMrrZ0HITRO
 eOXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HilhdlBRMd8jNfXSSBs0qARfbg9RRIPZZJGanGpyqkgwnKKxvEHECqLnMLJI/wBelZ3MjIORnhs4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeQGVoJ9nn30wFk8+2bOAKFHSPKPFrnrcZHXRN0F4dxbna1qRv
 wOYyDn4Mp1Ver4hF33ouyBPtkipV6ZRMgMopWb0zUMceYW32Fz9Nefl8GZhXEEU73oY=
X-Gm-Gg: AeBDietO8H+BYyayjRLQrn9tF7zwEv4Dv+b3mIno+J9TrHH2X+tERnF+UpZ4AGazv0Y
 NnNEpU+eujEYaqHgebQlsw3ndRNxNj1EytICGX8hJ/npS1n2oZXnoozKeD/7Wawt8fWQ/ugR46n
 LFfk/BwY5qHPVw6NUsL9pWruGJZSRxvgzj/d+ci/zMYoy1aFqufOI1gntCrVPfsgbwpq0pOUn7e
 hbdm+uRWwwM6CInDySOzXmuPblsEwHTtjIwwmzCRk/JmpqNjTRT3cI/e1MDHvjBohY4kq3tZabv
 H3irkosDynAz55Cd/QetAQPU4lf8GepdoNfsM8MpkMruo3dhDRCkHpLCK1gRjlG1d2whVavmlF4
 vcpISGNaxkjiKaybi1ntdBD65Yg5+dUcEzQD7jSHbNHSIRDAzHkZ7RG4tfs27CZgIEAVE8PH96p
 xvQNamytgHJODfziaqIrqY7oZepkl43K3onxjqNtKROCk67qv3Sd1fI80YL3VHuOFp3h6K+Vzf+
 KE=
X-Received: by 2002:a05:6122:4084:b0:56c:d66b:7516 with SMTP id
 71dfb90a1353d-573a56c2ed5mr3672830e0c.13.1777462365419; 
 Wed, 29 Apr 2026 04:32:45 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com.
 [209.85.221.180]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95cb717d119sm836447241.0.2026.04.29.04.32.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 04:32:44 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-56a9c5cb48bso4537674e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:32:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9t8M311PysiVXU6hYg6KIjVGRggNXI7vcjFP/5PGeDap0/BIf8VwZnBh14LB9yZjLFu/AZoh+2ZZM=@lists.freedesktop.org
X-Received: by 2002:a05:6122:1814:b0:56f:b2df:1791 with SMTP id
 71dfb90a1353d-573a566e6camr3723066e0c.9.1777462361508; Wed, 29 Apr 2026
 04:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260419193718.133174-4-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Apr 2026 13:32:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUkT6wO=mCSbJt1dQueW62=_o3r589MvFyHhz-zSfw_9w@mail.gmail.com>
X-Gm-Features: AVHnY4LCd6eTq9wcyp22X0zMAv4PuhD2Uo4vLw9bsPU9plD7Rc1VJGY_TMU-X5Y
Message-ID: <CAMuHMdUkT6wO=mCSbJt1dQueW62=_o3r589MvFyHhz-zSfw_9w@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: clock: cs2000-cp: document CS2500
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
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
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

On Sun, 19 Apr 2026 at 21:37, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Document backward compatibility support for CS2500 chip, which
> is a drop-in replacement for CS2000 chip.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
> +++ b/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
> @@ -11,14 +11,18 @@ maintainers:
>
>  description: |
>    The CS2000-CP is an extremely versatile system clocking device that
> -  utilizes a programmable phase lock loop.
> +  utilizes a programmable phase lock loop. CP2500-CP is a compatible
> +  drop-in replacement for CP2000-CP.

While CP2000 exists in two variants (-CP and -OTP, cfr. the link below),
there is just "CP2500"[2].

>
>    Link: https://www.cirrus.com/products/cs2000/
>
>  properties:
>    compatible:
> -    enum:
> -      - cirrus,cs2000-cp
> +    oneOf:
> +      - items:
> +          - const: cirrus,cs2500-cp

cirrus,cs2500

> +          - const: cirrus,cs2000-cp
> +      - const: cirrus,cs2000-cp
>
>    clocks:
>      description:


[1] ttps://www.cirrus.com/products/cs2500

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
