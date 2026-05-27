Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40069CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 13:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8D710E7FF;
	Wed, 27 May 2026 13:43:05 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A4D10E7F6
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:43:03 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-57746408b3eso7172405e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779889383; x=1780494183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNs9y+loQ3B7k+4+DTGFYd+r0HnydJFAxPOIKSPX9Cg=;
 b=lRNVZwxrnhDuazrKJ04JHYWvVEjxSAGCBMtqIJEOA/3+uksmYpCVg+ofYotVV1QzhE
 93NOGcFy75gZKSfHluiD+drNszevK1zh4PuhMGfu3WPRtQ5l6svuitYcQ0FPBqjalNvF
 i6OAGIDB2HpXrRptnwf4ynfKu1snETqU+I0NfNYZeOeJKyvbAP2w/NcrFi3nvhKhxT7V
 kLlXW1Z/OMsIJY/atX9g5ZmgPS9m49ckepZqJqiz8faLcIOuQp0ABWGXdmPa0HDxydPQ
 HqWfzKUw+9hnx1cupByUmsTpELNOcXIbvn2B7ykAo+WuA6fr6RCpGLihW4tRJd9p6T+k
 yvsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+b3OW4C2khfv7cMjTNEjK0eXtsbxCd/s0qLwnw9Gp3ECL8clwF+U8FoW007B7XioRnCIF8ptU5CoQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZfsOVQCjKzfeTFB6k+/4vOg7xRRtUaHE5ER644brd1uF9H79J
 mUEVHsWJsJACNOxyeoYbeRM18JxAfnorAOjO+LxMMIAZBM1seAbSupyKRDiGnMOMYSk=
X-Gm-Gg: Acq92OGQEiuK9n23Fg0zYnYNTZL0rDs60P4VAVJ+YKqRnCPM2k/3E8dHxexanWR5r9z
 hHm8SiR/JH2wOpB0Sab/dY5JW6pP72f2DDTf7AGIAD+CD8Gkj5YO/UwQcrwcG4iw5jk2nD7yhgB
 bDN4ZPauLAMayE/M98T5Z0lb2LjOgaHxTNTltoyB66+hL3yFB2FilJei3S08d9XA43cZ1CGp6OG
 Tkh7YIyKqMmn//t0JyTDPYZwyhnZYH64zlpYJrdw5rpH54zJdYEPzANg93EKR6Q8feaxuCYMgD6
 7rmQxEU+SqaXiHB/1z01PJwnO26OSi9rGwvDAm8rj9XqA9nBOHKQJz9NRWdFFY2CfWUXn0U9ZHb
 LYlxoOwX5ABwHccesFWfqskck2X/HceJpvg1Ym4ACRjoc41cpI+0EtzuXd6ln6/bCdtxtBgB4xA
 w3PSi/7yDmrcbTTx4/2QaJq33nPxu5APEKyO15IPTcnEpOioZVRHrcRoU6MOpj
X-Received: by 2002:a05:6122:8c8a:b0:575:3b34:28bd with SMTP id
 71dfb90a1353d-58661d0ecfamr11368459e0c.8.1779889382795; 
 Wed, 27 May 2026 06:43:02 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com.
 [209.85.222.49]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-586f23ee3adsm20198130e0c.2.2026.05.27.06.43.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 06:43:02 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-96387efc30aso102407241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:43:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8EfAujaSxGalkkk88ivfqrGitYnDTUzEfnYWD/3XuyDnPxNVd9zBlarxualhBLShJj8QxOHgOzwA4=@lists.freedesktop.org
X-Received: by 2002:a05:6122:32c5:b0:575:2ac3:4166 with SMTP id
 71dfb90a1353d-5865fdf6488mr11991906e0c.6.1779888899429; Wed, 27 May 2026
 06:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
 <20260515-rcar-du-dsc-v3-1-164157820498@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v3-1-164157820498@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:34:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQ5TDEx1Qj+3_LAGLrgNkiYxADkDox70pApZUtbam9Jw@mail.gmail.com>
X-Gm-Features: AVHnY4JU-pRdfRlPcY6GhkzF7rJsa1sewBAKfT1mHVG-dL_G2g5Q1LYyK6-SKY8
Message-ID: <CAMuHMdXQ5TDEx1Qj+3_LAGLrgNkiYxADkDox70pApZUtbam9Jw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] clk: renesas: r8a779g0: Add DSC clock
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

On Fri, 15 May 2026 at 11:10, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Add the DSC module clock for Renesas R-Car V4H (R8A779G0) SoC.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
