Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B23CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F0310F279;
	Thu, 30 Apr 2026 07:48:23 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA5210F273
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 07:48:21 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-56d8d479149so198578e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 00:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777535300; x=1778140100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SE8U24d9+nmbb0Ym2Vjd+YsrRui7aXN0DwD087novig=;
 b=GNHREE7XTxr40GIfaZlhjvA6PDWyK/TJkqv7sLBc0HqgzdjBGiYySWNapgf7vJo8rm
 d2Ql/+APPA5D9nzTB/8YFoad6qGAMpBH4sb5XTe+XOaptWg1FTtZNu+CPbGPhBrEnCEn
 52heN4OQx9rXh5nLTh3EsyHHflpWTVq6OmQ5xZ8hlsXvHznk8+dkCPh9BDtTYKC6C89p
 BXEwgsuvldgxtcx/KKjh9Z32zeKKiKBEwzVuseKd1Nk1j0q9R5EmS/izdlOioZ9nAd3g
 KYbv0l3FQIE+yZfYmD3pdiLWq1PSJR5GpcDe9AqMJRxc93qTQG4pO9qfBMBMkCYCu17S
 lIHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cZgE5XIhl0/Y4ltFHafiKt61yipARFnOGXBW5S3nsvzAqUu8QCop/lqnQHLhDPSgmp5QwXELDr+g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywy3d52aiVY/5DVlsUQ+Hv5OjXAs5iWfI72iX7ECb4siL9vjYC2
 id6z+h9IomVKBCalXbPCf7Szr6Ri5DP2AghLZFMYszlH72cMXEUAPnMYToLRncSODg8=
X-Gm-Gg: AeBDietJ4pXBDMIARGkvPqNii5lPrMLjL8+eg/AKldMiKopN/qtcjFh/RTlcwvQOXMX
 qSMZsb2Ke9xzf7cEeGfOzBC9SOF12m4fq2HwGtult/EjDZonyRK9yti8y2OVZ4g89qpBH1+TPbV
 CWt/CDtk4+78uGDZ1Mu2eJFjKVEcgNRsD8E4PXdgkmXzyUtcLSHW2wVO56FBUeE3mMN3BXDzmaJ
 ZOG55WIirUnf1oSPg6B5/IV+NfaVSg+9luAhC70ljjCil6CakMKdTwC+obFHzs/QGEUub+5ltNI
 s7x3m3Y1vKoLd4eATajKJtV8UhrmOO/IBMyL6NbGdEpa89baihUjhGOZ4gDHLR9YFe6yXO09QBk
 YoZMAVGOzlMTwak4Cc3mNKYRoTB0sl/c1KBzmqWKlfV6Q64dLCaZckTdC9suAcY/BUvJ817WZWd
 MXZjWE5lJZxPYxiODxJ9BwXo0TE19YRv+zpLPB3L1tRLMOSEfLAoK3+8sPZzo7G6Cs9UbETvQ=
X-Received: by 2002:a05:6122:8f8d:b0:56e:e68e:9fc2 with SMTP id
 71dfb90a1353d-573c9754177mr454433e0c.10.1777535300105; 
 Thu, 30 Apr 2026 00:48:20 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com.
 [209.85.222.52]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-573b6d88d77sm2615555e0c.11.2026.04.30.00.48.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 00:48:19 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-95cc1a5fe9cso191882241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 00:48:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ86ZfH0jEWbxeja5pVs9uZX4xGX00Ei2BuhdS+l5gOGdaupbTSl679nqxXhx+J+B62s4QnoB4SkOqM=@lists.freedesktop.org
X-Received: by 2002:a05:6102:2c03:b0:607:97b7:c283 with SMTP id
 ada2fe7eead31-62adc184803mr537851137.14.1777535299133; Thu, 30 Apr 2026
 00:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260429170012.366537-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2026 09:48:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUne5vUermQ7NnN67-QL_PM-SxJQogFpmSVUo1ussohXw@mail.gmail.com>
X-Gm-Features: AVHnY4JziB5Cy-6q6RNu-Sgl0OAxCbsRcDaFW7edOENQcMoEBistztZzpXDIEcw
Message-ID: <CAMuHMdUne5vUermQ7NnN67-QL_PM-SxJQogFpmSVUo1ussohXw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm: renesas: rz-du: Add support for RZ/T2H SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Wed, 29 Apr 2026 at 19:00, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/T2H (R9A09G077) SoC includes a DU with a DPI interface,
> supporting resolutions up to WXGA with two RPFs for layer blending.
> Unlike earlier RZ/G2L SoCs, RZ/T2H requires explicit assertion of a
> DPI output-enable signal (DU_MCR0_DPI_EN) during CRTC startup.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -20,6 +20,8 @@
>  struct device;
>  struct drm_property;
>
> +#define RZG2L_DU_FEATURE_DPIO_OE       BIT(0)  /* Has DPIO output enable control */

Note that this addition conflicts with

    #define RZG2L_DU_FEATURE_SMUX2_DSI_CLK BIT(0) /* Per output mux */

in "[PATCH v6 15/21] drm: renesas: rz-du: Add RZ/G3E support"
https://lore.kernel.org/11313371ef0b31cb5f014e171ba0d9868eb0710d.1775636898.git.tommaso.merciai.xr@bp.renesas.com/

> +
>  enum rzg2l_du_output {
>         RZG2L_DU_OUTPUT_DSI0,
>         RZG2L_DU_OUTPUT_DPAD0,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
