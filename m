Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462DF106B539
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F34110E113;
	Wed, 25 Mar 2026 13:30:43 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF3610E113
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 13:30:42 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-38bf85e4810so19475711fa.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 06:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774445440; x=1775050240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stp9ZXzQjSgCaz4WCE1iOcAb662w0+RcOPCoDeQo2tE=;
 b=QA5MjlZR56VF8xN8dLjXbFqXcFOKPofFeoLnqGrWGXx4BMxFfZVhBkNEWLfCGy9UsB
 vQNQn007FEr+rjmB+5VLn8lAwxvOsrGJk3aVHI4VjllVCl9zqlzY+BOyb+dCuKjjxct0
 6ckyKh18ggKEzYlMQNr9ZPAi501W5WIK+OSXFNUDnw0BAYQjezJiBZUulSdvgyUQS0Ue
 DuE0dFVZTCMqZaMJxXdH0VHd+v/6DDUuZqfvNiWdh48D1+SIMnGfcP64FNcE7NYaMxY0
 zXv1FkkshQEbgc9qVuL6scKFZmNIrcjAXrFldvdWncR4+OTbrQCNBzTtB8+1bexywlbb
 jF5g==
X-Gm-Message-State: AOJu0Yyl+2tTd4XsnT8hRznaQSAqxHIpN0ftEv4GC3yVRuH1aZlycAV3
 pT4qTuRTlhH6ZCxMl3+9WfsaaTZHfTyNUB75VxRkCNTrJ1Qn/6Yzy18lStwZzSYj8lM=
X-Gm-Gg: ATEYQzyjSA4V9/sdFuFPC0zcwicqahf7SBdzw6bXEap7cugWk4/+PMhNiELRJmCqjTB
 LiWYpbzN8C46QBF/XGcMT0OzJtyU5p4oD9lOfv32cvalD1hNeEdDKKXcEy+2RSzBPJ2mX227hTj
 rNGh5oW0z5CtFr2wYZ8jPfmU23bAr6xBbbUUS2w7ACngtEm/O3l6YMQp7UyPy5bp0EnHeM4Sz0P
 9B3RpeSALChGRx8vfZ9FWY5hMhH39hKkW4GtDIcNH0ylomTVVfB2s+sDirGn4yfAZ0knixwdgaE
 xuRCSaHa5g/w7oMqay5VglRM0ORn4LM1tROVWt4ovM7sfznEpy/R9+RYhUDmUKBckH76/Chizp6
 EM6Vt9fHylj4UxYHRKxokBbK1S9S2kkSNdsDUf6itmPa6liTXScu3imEbC79chbHKRAtsv+wuFu
 AtOI09zi7irN0BKLIRlyUa+3XehUeIa9ZGVmyAh9+7MDLj0SPqZubyYDYRkwxP
X-Received: by 2002:a05:651c:4404:10b0:38a:5584:ce7a with SMTP id
 38308e7fff4ca-38c431880d3mr10793111fa.20.1774445439928; 
 Wed, 25 Mar 2026 06:30:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9aa3575sm41314841fa.30.2026.03.25.06.30.39
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 06:30:39 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a27a90a7b6so2857593e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 06:30:39 -0700 (PDT)
X-Received: by 2002:a17:907:8690:b0:b98:2b55:f7c6 with SMTP id
 a640c23a62f3a-b9a677f3293mr242621366b.57.1774445026817; Wed, 25 Mar 2026
 06:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260117005028.126361-1-marek.vasut+renesas@mailbox.org>
 <20260117005028.126361-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260117005028.126361-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 14:23:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUM5W7PLEaX_7SEwxXuc2aUvRUX7L0cT5Fg7YEZ1n3AwQ@mail.gmail.com>
X-Gm-Features: AQROBzCABV8bWPZtK2TcL9-PzQxkhTblJ0GblRNzGWfFAoDGkar56sRfrxg7ob8
Message-ID: <CAMuHMdUM5W7PLEaX_7SEwxXuc2aUvRUX7L0cT5Fg7YEZ1n3AwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: renesas: sparrow-hawk: Add overlay for
 WaveShare Display 13.3"
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
 Simona Vetter <simona@ffwll.ch>, 
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

Hi Marek,

On Sat, 17 Jan 2026 at 01:50, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add a DT overlay to bind the WaveShare 13.3inch 1920x1080 DSI Capacitive
> Touch Display on the Retronix R-Car V4H Sparrow Hawk board.
>
> Current device link is at https://www.waveshare.com/13.3inch-dsi-lcd.htm
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-ws-display-13in.dtso
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Overlay for the Waveshare 13.3 MIPI DSI panel connected
> + * to J4:DSI on R-Car V4H ES3.0 Sparrow Hawk board
> + *
> + * Copyright (C) 2025-2026 Marek Vasut <marek.vasut+renesas@mailbox.org>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>

This include is not needed, so I will drop it while applying.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
