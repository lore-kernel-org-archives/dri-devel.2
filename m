Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686B7C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F46C10EBA6;
	Tue,  8 Sep 2026 12:17:07 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353A910EBA6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:17:06 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-785d603efdeso1494022137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788869825; x=1789474625;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1ITJx792r+ituep1jxzGor7V94Ftkp9w2SLxSuD0zdE=;
 b=LwTPUoS4K/Z3lct/mBrre0hpoDFmo8ckF0gfT9YG7oeHl4D4yVfCBvZPSRtNsP7qgD
 Mnvv5IF1K7gLTOC6o7q3GKJMJROnQ6jmtp/2T91tj9oqwNsw4Al0bdLOjbXQ0l6ClcZj
 Ne/VRU4qkW9i+zkX2mRvIbJ+fGlrPXW+mpkeA2W1dOh1IsjHYEPTwofCyKZFMS0iE0s9
 WSw+vzLtDVTYe4yTDf5Ilumq+hBbg3plbB1K6t85ECf+AYK8FsYCbFDcZeMca43Xmj+V
 mwaNWQAz4UIqjE4M4UIlgIKIVo9BjAoWKi1nAKxnEc0yARmbZWSUFYfDAAdaVtan/v3E
 btGA==
X-Forwarded-Encrypted: i=1;
 AKwUvByE+cfbkrp3ZUljMRvFeDJV0HFXVZMVMm5IcW/CeSwrcyVEwdQQZLpiaZ+cScHnDM5HJGDCXKQUZnQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l34QArXPJiZYwCa0gOPKFVUnU1ytR1EdXLlWE8E259paZnQH3o
 Q6/N08xTeo3yCSy8o5ss75tY2bG3z2fqGJjaksOkbJnxbCHkqTrnvNX2PS/hZkKx
X-Gm-Gg: AYBFou10U63DB3qnwu1308zHf8g8yyQYPunM17WgWXIf1ZWitxzJtmMI6r7RmCOi2y4
 iV8o2e9s19xTEJ5obNYANWfw2SuqhBezFtKm5hONQiid+nqVKDOkcnvQgd/AY+gt1NyW+2P5d7h
 lCA7yS7CLaRzHQsvf+/zxxBfmH3hhftpUkFNtw78RF4zrATfVxUS7azsP6FlBQnNXyx0O+wLtBi
 LCVrrhfgTyzw3rf5KtLzl3Wtp9QkLxpd+TyznrVyfsmul4rXSCXl4E1fqpPUobeLSuzYaLa0WHE
 JpXvqwlaMbVDm/kVEniQxLQb25DPiKIA6PSmZ09dWCgcFaQ7bihwUPb5o0jSqeRwyxRLGxXG3Gs
 V8G8SZ15huuMC3N2VpDQP9/LgIHZU4ig/pg9hwF2lZMdOXAaUP0FG9KQZVXoaL6bKPdPN0q/Cft
 8FyD0AJbkWHluYo9iiVqkF93sASf2qxkz6kpNSvUao5fM9KQiTNFoW+CtHjvSXHfgWz4eRdSxJl
 id+/uxvSubjKcnVlRRq6DFMSXb1Xg==
X-Received: by 2002:a05:6102:644c:b0:786:d33d:af15 with SMTP id
 ada2fe7eead31-78a4a94a067mr10638165137.6.1788869824367; 
 Tue, 08 Sep 2026 05:17:04 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com.
 [209.85.221.172]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78a47b3468csm8865312137.11.2026.09.08.05.17.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 05:17:03 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5bf83925ddaso2591610e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:17:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwvi9AmCffR/vSw9UZOb+xfN0XcQG43OVr2vdk9+u5yaf3uvCXte1fYeKFQKi4Y9R2FeVq/6+oDZ9k=@lists.freedesktop.org
X-Received: by 2002:a05:6122:4698:b0:5bf:4522:fca7 with SMTP id
 71dfb90a1353d-5c7ed3b2275mr10642726e0c.4.1788869822558; Tue, 08 Sep 2026
 05:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
 <20260907-rcar-du-dsc-v6-5-f8ef711a7494@ideasonboard.com>
In-Reply-To: <20260907-rcar-du-dsc-v6-5-f8ef711a7494@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Sep 2026 14:16:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpLrjtUh5pGP9ys_PSFt10vKdQCyo3UGaedcwaf8UEww@mail.gmail.com>
X-Gm-Features: AcwNN1XnePIl5mdE7u2itKH3ZKW58ZQZ46L6E5RD6lZgFL-MnDqW0nO0uTjSR8c
Message-ID: <CAMuHMdUpLrjtUh5pGP9ys_PSFt10vKdQCyo3UGaedcwaf8UEww@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] arm64: dts: renesas: sparrow-hawk: Enable
 DisplayPort by adding DSC
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

On Mon, 7 Sept 2026 at 11:30, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> DisplayPort on the Sparrow Hawk board uses sn65dsi86 bridge, which in
> turn gets the video stream from the SoC's DSI1 port. DSI1 pipeline has a
> DSC block in between the DU and the DSI1. However, there was no DSC
> driver in Linux and also the DSC was not defined in the dts files, and
> thus the DisplayPort output did not work.
>
> Now that we have DSC defined in the SoC dts file (r8a779g0.dtsi), we can
> enable DSC for sparrowhawk.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [tomi.valkeinen: separated the sparrow hawk changes from the soc changes]
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.4, pending acceptance of the
DSC DT bindings.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
