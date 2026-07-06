Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34092C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F51B10E317;
	Mon,  6 Jul 2026 08:24:54 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4016810E317
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:24:53 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84783bce476so1829585b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783326293; x=1783931093;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dbFPkCHMyK2cMipYCshkg+R5wrSHUFxUQ6/ZQ0r9elE=;
 b=UwXGHSgx9pYCBLRhm++hZ4wkXjecEuqRJkDRF13oLsYQGB2n3g7EMXbrotgM6xUtWf
 g7PzIgGxZ+8Ok2bBQEOzCiSbmeko9GO/HWwuggRQDDjpBuLp/K51Aa3nYCKgrCmmLYcU
 S2Q6dLfoYPfvqYdKqJ8sjaNCQ/VfC29NgEKQhWpZ5zM1iZPbvhGyAoXx61E8zSSVyZL/
 NEQvcoo/plxHPLtlDrS6zxWpqy5US40x3gSsDpJ9ARUMfQZl9gg9mQzx5Uz4w9NLL2Z+
 1wMPu3rsAl7MVEjQsP1v43y30wL4+n60bIhsLmhYd+SkA+JYIOpQpwcZ1tT2O6AHN5+e
 UEMQ==
X-Gm-Message-State: AOJu0YyL+8F15bVmY8yFsI6/LisGxSlgK+NLqbXoybsDSbbDBkvqS7EP
 d9RiTGq25YlVnvaxu/0XBARLzbzxUquoEBDoLIa8wcMKir1gn+RBQ4ti0ns9tH09
X-Gm-Gg: AfdE7clNoQqa9Uu0U8LiH/c51CBmacIu+UY+oyYslmz0DLH2bsFLCXCnzIMDuvi5bYP
 iScDZmJ6qspDRYhC6r2ZkoWklvUhHZ8Q0LG6d9CznQYpWAFgyYH4u1DqyKjUWh8e21W8DDz/PqN
 Mo6QJm8UK3DiQXZ/CO6N8cTq3FwaespHuhwCBsUVcoNeg8M3LHgvNbeX0cYGYIp6vyoK6WWrM9o
 Xs75mf8qmRkLv4EccpwKnTLN6HvU9qgPdLpFrqHLvlwWpuus4ljtI/B9BNL9LBRieK1xCeTCVNS
 ubkf8elyT+giCAx2SikfI6WH28bXmdDipBn9vosyNDNI/p7PQ5Fv4GXNoXwqMcurgaIyQROV9sU
 DY1+HNIW7G5J4hW1hEaSySC+nhPPHDUARwMpKzhNKdCGTReQ0i0Mb1W+23ACHP8zufptHivVohw
 moewT8Iy10wFX49pH2xKhRLQdkGJLkhYIo5iAgI+XosrYkaJcTR/qy0Q==
X-Received: by 2002:a05:6a00:4c11:b0:847:7f65:7674 with SMTP id
 d2e1a72fcca58-847f6f5255amr7760958b3a.44.1783326292465; 
 Mon, 06 Jul 2026 01:24:52 -0700 (PDT)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com.
 [209.85.215.169]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b6162esm3424988b3a.11.2026.07.06.01.24.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:24:52 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca1328b8584so1976365a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:24:51 -0700 (PDT)
X-Received: by 2002:a05:6122:550:b0:59c:b1f7:4df3 with SMTP id
 71dfb90a1353d-5be102ec434mr2809370e0c.12.1783325795169; Mon, 06 Jul 2026
 01:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-5-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260705213542.28987-5-laurent.pinchart+renesas@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Jul 2026 10:16:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVtK2qKHLWfyWYaPx1cYgmF0jtzh3CAPrJ4QbZ0VxypXA@mail.gmail.com>
X-Gm-Features: AVVi8CfGdsdm5FTOvhTH4n31WpQq9-pZfeJYTHCuuEYLuLxyLezJUgX-zWbA-go
Message-ID: <CAMuHMdVtK2qKHLWfyWYaPx1cYgmF0jtzh3CAPrJ4QbZ0VxypXA@mail.gmail.com>
Subject: Re: [PATCH 4/4] [DNI] arm64: dts: renesas: salvator: Add overlay for
 Dell P1911 VGA display
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 linux-renesas-soc@vger.kernel.org
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

Hi Laurent,

On Sun, 5 Jul 2026 at 23:35, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Add an overlay that hardcodes the EDID of the Dell P1911 VGA display
> connector to the VGA port of the Salvator board. This is meant to test
> EDID hardcoding and should not be merged upstream.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/salvator-vga-dell-p1911.dtso

I know this is not meant to be applied, but nothing below is
Salvator-specific (except for the comment).  Hence this can be applied
to any "vga" connector, and I'd rather drop the "salvator-"-prefix
from the file name.

> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree overlay for the Dell P1911 monitor connected to VGA port of a
> + * Salvator-X or Salvator-XS board
> + *
> + * Copyright 2026 Ideas on Board Oy
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/vga} {
> +       edid = [00 ff ff ff ff ff ff 00 10 ac 74 a0 55 4b 55 30
> +               2b 14 01 03 80 29 1a 78 ee ee 95 a3 54 4c 99 26
> +               0f 50 54 bf ef 80 95 00 71 4f 81 80 95 0f 81 00
> +               01 01 01 01 01 01 9a 29 a0 d0 51 84 22 30 50 98
> +               36 00 98 ff 10 00 00 1c 00 00 00 ff 00 31 57 4b
> +               4a 56 30 41 4b 30 55 4b 55 0a 00 00 00 fc 00 44
> +               45 4c 4c 20 50 31 39 31 31 0a 20 20 00 00 00 fd
> +               00 38 4b 1e 53 0e 00 0a 20 20 20 20 20 20 00 ba];
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
