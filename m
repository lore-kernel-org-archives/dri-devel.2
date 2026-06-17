Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A45CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6871510EE59;
	Wed, 17 Jun 2026 07:24:49 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DA310EE59
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 07:24:47 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4863cd41330so441430b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 00:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781681087; x=1782285887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8u7Gki8p4EM6XMlf4misGHyXuNmTvOX4Ry5GM+DWUec=;
 b=Niq8zrbhMMOWY0KFamKCsJie42xMSBQGfIJ1qQmmnqxyBgMPn8soHJYOSJe07hFE2J
 C/FKErWrNVar08me9C+TRi4TSkoDwo9CS9nYZma9D+cf6IjzKjUqVR3jYXxY9yYcGlOQ
 HToYrmcP1kxDvjWfqJgApBQSX2ofFapBlWUXNcfdwTvdy8loDuEa/La5OR02Q7eRT3Mw
 MSPOm4sJ58ROReydpdb+hbQ1z4aulxbLxkiB+eB5YNVBn/ge07egvFdoPhnRPUqjibk5
 LpwspvpQ6wxhfXiTA7MhQzquiHfjYiT0XUfIyIEeGHGd0m2icU7dQCfgsB9ZRAMWJ83d
 pkOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wjlEZvmdW8cCVK9fhMGWER93E3ubJqWox193C2nb5inVgFk48Q51hyYNwaNdRAQ2Q8vgQc3ffWnA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2WGUxTWICPCLz2mAXR7Fmq144G1ShgD4hxR97SeakgJ7LvyFh
 rtqQ8cGMWsxWEA7zY2d/HNVj+TcPWUKpUlbD6ZIUIHed11Mv0CvCoXaPMd9rFpXT
X-Gm-Gg: Acq92OG5I1pRJZ9INmc+Q4drG7ab2ZcuZw7m0ebSmLZvoVWMJM/fGW5ydeGSQSqNgIr
 jx10AChLp/4PrXYaKPcf4UTR8On7XAeNntIbwV9ukloewVxXqlP0BK11k9LCMKgFox/QYQ7FGPr
 P8iQYdnYGPcA7qV5KGTTa7a0oCR5r7EFn1azAGos26r/Jddy/woQrMXEo2WM1S+wSOT4jPa349d
 /Nv4Y1i0qW/6X7QdHFLalp/sDqpgSXS7JJHO4O7iScupweYEvFPxmw8rFBMWN782dxXTN940GVF
 r6BgflqfAbM4mhIxNtQejrfgQq54280c99e+9hGMH1VQIOQQR1RpHaACtCyamkYI9TjcnzGakqx
 2sfkL7FlJNsrynStdtqV4yvM+8APV/GGj2Wp+0BExQRI6UIXAUdS2Ra95fZ/BV3g9IXYr4qxz/R
 YoYGc+fC0DeaEzvDNZu82/eb05YYF0fEUv2BzmwKYcG/pXTp0kEA==
X-Received: by 2002:a05:6808:1a09:b0:486:4715:ef39 with SMTP id
 5614622812f47-489460cbf2emr1321610b6e.3.1781681086624; 
 Wed, 17 Jun 2026 00:24:46 -0700 (PDT)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com.
 [209.85.160.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f5a11efsm8679331a34.1.2026.06.17.00.24.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 00:24:46 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-442ce0c2770so615721fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 00:24:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+blNiqbsd9SHLjHFxSmulNYWFa/R96uGEj+bRCplas5zP+1VKO42gXc9Pg6UD07E09Ae1RE0k//nI=@lists.freedesktop.org
X-Received: by 2002:a05:6122:6315:b0:59e:2a50:39ab with SMTP id
 71dfb90a1353d-5bbc106a67fmr555519e0c.2.1781680625185; Wed, 17 Jun 2026
 00:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260615-rcar-du-dsc-v5-0-aed1a28610e4@ideasonboard.com>
 <20260615-rcar-du-dsc-v5-2-aed1a28610e4@ideasonboard.com>
In-Reply-To: <20260615-rcar-du-dsc-v5-2-aed1a28610e4@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Jun 2026 09:16:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGpxip_h1dCCQ1mdpW8m+hP_PjmjzVmyRpDUtGQWR0AQ@mail.gmail.com>
X-Gm-Features: AVVi8CcYLQHmYJC_gazcaRIfqz7y7D9l_HFtGh-yRcroThw0DCba9TthKbXFofA
Message-ID: <CAMuHMdUGpxip_h1dCCQ1mdpW8m+hP_PjmjzVmyRpDUtGQWR0AQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
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
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
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

On Mon, 15 Jun 2026 at 15:12, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> The Renesas DSC Display Stream Compression is a bridge embedded in the
> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> 8k or 400 Mpixel/s .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [tomi.valkeinen: fix the example]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
