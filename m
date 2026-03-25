Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C6D106B535
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408DC10E1B2;
	Wed, 25 Mar 2026 13:26:36 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748B110E1B2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 13:26:34 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5a29b4404a8so940693e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 06:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774445193; x=1775049993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGKhB9qy7hiwPLOMIV/4ydxNNnNMBwmIgfNydUSJ0fg=;
 b=ZiUjWiqSF0l+VXbOjw20e/Jho5YAfiNdKnQAYplcEPd/9aAFcHpHIAOemu9SW7Aj+s
 8SlrS2XRUbjiH6J9y7zXmQfJUuBt2kILu7qyHtMqjwovC8y4YrC4Ur22YunLkKfOIJjn
 9/9gW/6zia3txO12V78gjthmPJCp6nG4ZSSA6xt3CccGdxfIDTd0bboT6sAVqiJJefLE
 hAEOCDVixW/aWEbar+IRtcvjA/6tHdtfpUk/+Hp6IeABAY5N3bumAjNLhb/TrDGBUAFM
 lRMsL6N319pgka+XXwkwVDZsQSRFx2obqLkP0tWRUJpP/KJwnlHsd4OJ0DwrdzEjf6Tb
 bhkQ==
X-Gm-Message-State: AOJu0YwEszyuS2Ffn1NZgy4a48IuymS82gwZj5UxpwcPLb6gBA6IcL39
 VJlrB3m2rBFSF5enHfM1jWwuHvXi1EQMTG4PezMM7C94IocxZkGHgwHuUoYxDnwMaRI=
X-Gm-Gg: ATEYQzyjF8x4bvv0/i0i5bUjRTe56OoCvk/LB1LquANtALfZHXjxuBouOUZruNQqIPK
 eEvaaTtWsGPDyRoemNIB7VGE95DgyxhoT6135AaN+YswijMDULJFmVZVz7a5e2gGN3K/ge3A3X+
 53xAphzGNNhhqLDAGYlBZ6DMZkcdUwZT8c0E787+queSF3Uqz0aEYpxw63YUbazuzK7pXsMzNiK
 R81jdWT+vxhn81ARap0igF2BavxiMzpSgTRDQxShc1BigFLN0ht+QcLqal/z+NDzUsv2Z6D0Loj
 CA0HIpzSGlvPByzn5RjY3R5DE+ThZgVLUvgAxSFMfA+H9F8cx5vayLnQWmjEDDw/BDCSPhfMTxh
 QBcq6DChOJ3Tii/a9jgbylNmeZWrGsn788S9BkCB8Jdue6y42O8WmNdIDR+YietRE/JxUZw6Cum
 jc3vszWPfskSCvAJe8i0ERGs+H6R6UYToMGaxkcKVVrBCvpCGCJQaYHcQqLBc8
X-Received: by 2002:a05:6512:3e0c:b0:5a1:db06:764c with SMTP id
 2adb3069b0e04-5a29b997ab8mr1233055e87.40.1774445192519; 
 Wed, 25 Mar 2026 06:26:32 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a28519285asm3853828e87.7.2026.03.25.06.26.32
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 06:26:32 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a2967e5de4so2243175e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 06:26:32 -0700 (PDT)
X-Received: by 2002:a17:907:7a89:b0:b98:3ffc:1c39 with SMTP id
 a640c23a62f3a-b9a542bc0ffmr242084966b.56.1774444843570; Wed, 25 Mar 2026
 06:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260117005028.126361-1-marek.vasut+renesas@mailbox.org>
 <20260117005028.126361-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260117005028.126361-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 14:20:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWXM8FOnwrCPXUdKmOKYUdB7qvgbrmXn8Je5FEgm6uSjQ@mail.gmail.com>
X-Gm-Features: AQROBzDEx4zWUiv2Aeo1TfPzF_xYHWi738ocpywTiKEOtgvD-VvYpp4M8-J7Tcw
Message-ID: <CAMuHMdWXM8FOnwrCPXUdKmOKYUdB7qvgbrmXn8Je5FEgm6uSjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: renesas: sparrow-hawk: Add overlay for
 WaveShare Display 13.3"
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>, 
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

On Sat, 17 Jan 2026 at 01:50, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add a DT overlay to bind the WaveShare 13.3inch 1920x1080 DSI Capacitive
> Touch Display on the Retronix R-Car V4H Sparrow Hawk board.
>
> Current device link is at https://www.waveshare.com/13.3inch-dsi-lcd.htm
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> DEPENDS:
> - https://lore.kernel.org/linux-input/20260112234534.225954-1-marek.vasut+renesas@mailbox.org/
> - https://lore.kernel.org/linux-devicetree/20260112234834.226128-1-marek.vasut+renesas@mailbox.org/

> ---
> V2: No change
> V3: Use compatible = "waveshare,13.3inch-panel" and drop timings
>     and dimensions, those are part of panel-simple

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
