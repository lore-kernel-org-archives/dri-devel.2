Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4025DFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934DD10E3B0;
	Wed, 29 Apr 2026 10:15:56 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE98B10E3B0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 10:15:55 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-506a7bbe9d0so100214501cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 03:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777457755; x=1778062555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlgSQf9TVaIeapbi36V5Bh/+HrPzPP7kpOmKArKJl0Y=;
 b=A/0THPMqPwWhXkWq8Wkrlq4rAZn/z8TiyHTuEEcnNzUy/mpDUexTQ06ycFcEn+ssrJ
 KyroqXTI2xCOQ2uSe38sbO/N3HVUADqJWZBHY4keK4oNmZE9+DmnxPvz/sGgkosVPo7v
 G0hbkCRwH4E7JrXuP38SHFgmNJtaIFYlHqiAFvdpngHoPgIVBrL6RHIuRqm21zY2B570
 r3E8rd0620Za6vyIkyrYkC91lIIdsfJBvHSKwyd+pAbJXn4NlNET6rQVY0NL6dhzAVz5
 TSn4Q8NSI1xkeyE5X83vAOGvRka8mdxCZXX1XiriQUQzc1ZHQueUX/EC3vXZxIDsXm/4
 9bYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eGTCXf71UYOvWSEvs/4BLmw/XwFuvK/IWCfjXt+OXW2owWzu7kfo6ky35JayghoEl0VK7U0P83Hk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEPBACdh6e1U7jMmNONxl6nn54cV6K0iCnJibNvgjFJLJon5nt
 mDhv4z+Cze+uTDIu7SoDV8NfkPslrn5wErk1TOG4WPutBaBRky5zgatdkPnpD9Dp0uY=
X-Gm-Gg: AeBDieutyIUDJag4U+k0q+MLDxhlUY6q7QUtBVXfen/0485lc1Ew5u5w9xutGw7EtY2
 fJytUu+9ZFnxTGQEJaUduELfJX0em2Eh5/d35mMpvP+nNeiRQ5aQ2ytXSFFKGWBk/cu+NjegaA0
 MT3L5GcESPVB+5lBgNkiylngO2eQ6nhGg0J12rCtfPDN1PnBMoYOrvbkSv3TC616ASV5DZZYtEf
 1aKQeQiAyO9KzWjflvA8Sdx1wlV6GAknpR6GhGCLK2qcqeqOBhTPhaPGMXQIGUDzlyJIoLt/W0P
 6L8d+Ml6dNMDxy+jGTk54ThOEWJLr32hklsTorXSLI3/N0rsE7Yj4ruK2840gsHSepiW98h8ghm
 YexY701i9U9P/naF0QnBOod3mxe1OrZdZcrZ3Y0QOMFgN+2ElDVeHMTZx4FqIvF2HaXvIucuiYI
 VFCF86Y3GnfVIRvaIwrEAdgqNgLbzGwyjCEaN1sUobenzQyzN/Tr+AuO8fgxE3cUJtyhf1AzA=
X-Received: by 2002:a05:622a:190f:b0:50f:bdeb:1e47 with SMTP id
 d75a77b69052e-5100e1da7d3mr97562031cf.44.1777457754773; 
 Wed, 29 Apr 2026 03:15:54 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com.
 [209.85.219.54]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101aca02b5sm13645221cf.5.2026.04.29.03.15.54
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 03:15:54 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8b038a00370so106161576d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 03:15:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ88ZtquzSlzHTGgCDjngP6kbtaUi0+bsFhieWN/FD2W99GbZ2NLn6y8160XSX3ydr1D0M8kzoROUUg=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5808:b0:5fd:f2ad:c653 with SMTP id
 ada2fe7eead31-6280a4a8859mr3233756137.16.1777457422707; Wed, 29 Apr 2026
 03:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260419193718.133174-3-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Apr 2026 12:10:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHKQwX43=c9JR67=x1EvWzdHTiXdUnPV2bDKU7PV_EnA@mail.gmail.com>
X-Gm-Features: AVHnY4JG2nQR3icySEfGRtnnQzDT9zHNQTQkbpTpvtHZyLM3-S0niXuSWkJz0jc
Message-ID: <CAMuHMdUHKQwX43=c9JR67=x1EvWzdHTiXdUnPV2bDKU7PV_EnA@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/rcar-du: Add support for Renesas R-Car R8A779MD
 M3Le
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

Thanks for your patch!

On Sun, 19 Apr 2026 at 21:37, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add support the Renesas R-Car R8A779MD M3Le SoC. This SoC is
> similar to R-Car R8A77965 M3-N SoC, except the HDMI port@1 is
> not present.

"and DU1 is unused." (whatever that may mean...)

>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
> @@ -564,6 +564,30 @@ static const struct rcar_du_device_info rcar_du_r8a779h0_info = {
>         .dsi_clk_mask = BIT(0),
>  };
>
> +static const struct rcar_du_device_info rcar_du_r8a779md_info = {

Assuming for this review we do need a new compatible value...

> +       .gen = 3,
> +       .features = RCAR_DU_FEATURE_CRTC_IRQ
> +                 | RCAR_DU_FEATURE_CRTC_CLOCK
> +                 | RCAR_DU_FEATURE_VSP1_SOURCE
> +                 | RCAR_DU_FEATURE_INTERLACED
> +                 | RCAR_DU_FEATURE_TVM_SYNC,
> +       .channels_mask = BIT(1) | BIT(0),

 "BIT(3) | BIT(0)", given R-Car M3Le dropped DU1, not DU3?

> +       .routes = {
> +               /* R8A779MD has one RGB output and one LVDS output. */
> +               [RCAR_DU_OUTPUT_DPAD0] = {
> +                       .possible_crtcs = BIT(1),
> +                       .port = 0,
> +               },
> +               [RCAR_DU_OUTPUT_LVDS0] = {
> +                       .possible_crtcs = BIT(0),
> +                       .port = 2,
> +               },
> +       },
> +       .num_lvds = 1,
> +       .num_rpf = 5,
> +       .dpll_mask = BIT(1),
> +};
> +
>  static const struct of_device_id rcar_du_of_table[] = {
>         { .compatible = "renesas,du-r8a7742", .data = &rcar_du_r8a7790_info },
>         { .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },

I also don't know where "M3Le does not support 4K output." (which is
a VSP2 limitation) is to be handled.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
