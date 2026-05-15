Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10FCCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485BD10F472;
	Fri, 15 May 2026 08:08:56 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F53910F472
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:08:55 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-50e5dbd8e0eso88726321cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832534; x=1779437334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mk3+gk0uvDvPr4J0ZYYOynNFHdcw9MrgwNKr9DcQAuQ=;
 b=hKFJzWkZPtUZslVaFHpT87Ko0BoCeQHm78GL73l5NU/J1pHe8akhBFdOrt2wesUCae
 NuQzxiXgrdxX3ttWa8G0N7oFCYTStUfrFL5ckE1vc34wWBLf1Wvvx9jKkZWQ0HGfLBVd
 u11YzRXva/z2EbGSk4ORwNgjX+5ULHoM0I0fVpfJ47YwOf4eA0mBPCWs08uibDaYEQH2
 Ps6RJyXVcs8H6dVHTG9r3ZCtkMra/r/yslNvHTU0sY0DvHZK6Wfdnp/1T3jk8PZby5iJ
 STD96b1kvQaOZMDL+uD+Z81MsitFkDE2Pi7+bNW7GKH7i2NQiAEW6F9c3mbNzBpGN+VL
 +/vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CuXaK1IX2mEoe6yfe4JOH8hWwPYzvtCBqud9GkbOpJtXhoa+La4D0vqJXsz8Bb5t4rrtfmX99FBQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwW2t7fDMriQ9mh3fILtmUd/2QV8BCQDnetuLhbgrf7V0mxmq0Z
 UMLK1x7fJbuTwa2Ng0LRPlUNfKzZGOe8K6tpWwRkJjsvWk1krpvQx7BadHeGF4vS
X-Gm-Gg: Acq92OFDFEgqfNE/IeNv4QEZS16j9DIuQg9RQ+2EVXx78F2wntEa/+k0+E6e3PtITf1
 nB/FbjYxxCHEbmPfRfnWvYdn0Q5dJsdATknz8jmCNZP2ntEX+jd4IYQAcB/2cu7Oe/JQsw84t57
 ICIjCX0QTJ4Pg06lUwWE8tOzMrsCD8kiCUfC70f4ACkg2IEkTozrU9v1oNbqEDPO79yD/Lm1rc3
 s0gPMA+ZnN2omsq7pG4x+aVNfWtGreD3m7fHjUN1QxrpyY59yV7eNg+Ap9Gl/pMHsTTCIYg/kL+
 gFgt/jvPXR6Apy1/Q87MAtuPX1GiUxaWDyEt2WCyrUSAczADp1Np9V9DHuE1eRK8dLHCKGkDBa8
 gBwK1FODBnsfFCaP/I/M6ojP58kHod/e9TpwthOYg7/dfSWGILs+4IXtPanrsE/qNVX4+Z2P5Nq
 RJ7ejvWixSemwaiaEjE7zPN2zWWkTjRFVHiKnJ5ag/ryhuHcKEe63GkaKER1zmXtEA
X-Received: by 2002:ac8:7f8e:0:b0:510:12d0:3d74 with SMTP id
 d75a77b69052e-51659fec867mr41037591cf.15.1778832533710; 
 Fri, 15 May 2026 01:08:53 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com.
 [209.85.160.174]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516457d630csm37473591cf.14.2026.05.15.01.08.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 01:08:53 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-516389a9b70so22381161cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:08:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9fkarpK+M9Izt7dX23mdxrJg5ICweDVsScr6MI/6E209WFF08vQEFr1iUdMfpnuDSbviMV5EeSdZ0=@lists.freedesktop.org
X-Received: by 2002:a05:6122:ec7:b0:575:44b3:300d with SMTP id
 71dfb90a1353d-5760c0528f5mr1639450e0c.10.1778832080852; Fri, 15 May 2026
 01:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 May 2026 10:01:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_HF-L+KrMNTUMO0_ukfVJE=nZLjoadFFWf0qDopKs8A@mail.gmail.com>
X-Gm-Features: AVHnY4Juo1yrSdWSEhGd8PIKGe45raKjJnOdNJywoBplErTdAE8Qpe6uxcK4nzs
Message-ID: <CAMuHMdU_HF-L+KrMNTUMO0_ukfVJE=nZLjoadFFWf0qDopKs8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/rcar-du: Add support for DSI pipelines with DSC
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Fri, 15 May 2026 at 09:56, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> Some DSI pipelines have DSC (Display Stream Compression) IP block
> between the DU and the DSI. Even if DSC is not needed, the IP must be
> enabled for the DSI output to work.
>
> This series adds a basic DSC driver, so that the DSC IP gets enabled in
> bypass mode. This enables DisplayPort output on Sparrow Hawk board, as
> the DP output comes from DSI and sn65dsi86 bridge.
>
> Original series from Marek.

Thanks for your series!

Now we can revisit "[PATCH/RFC 1/1] arm64: dts: renesas: white-hawk:
Add mini-DP output support", too?
https://lore.kernel.org/05e43f61321b4191d5f97dec2349facd4b56c899.1729240989.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
