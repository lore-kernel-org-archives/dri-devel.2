Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580321073CBA
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D0110E65C;
	Wed,  8 Apr 2026 13:29:21 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D401E10E65C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 13:29:19 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-50d6b9bca48so79589031cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 06:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775654959; x=1776259759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VHgesrf5StiprJKDytJNXvB7R5FJ2lBTM9ZJItFuhE=;
 b=s2sm/ALL3As2PxtdC2TpupPG1aaecPYHpQRJNtzpFAutcpmExpsh4wngOsW+86j7ql
 0C0kQeAovUSTGlVhY7GeGvaqVKIvufOnhw66+vXpt4TQrHFes088Yp219i2zrCOpa9GR
 mD3AsrcdfkmEYM1PZU+fvZceSU0L3VZOL9Ce3iVsnvWdLES4SRgaJynE3mYIRwn5ocpe
 pEsZnnGMK6H1CKSZZlE1TEYVjvb1VoGEayCI9OwS0YqmhWzAB3fx8KvP2q15AEe+x/TA
 dsIwpQ8D7KIdT1PSqBgWFSDQAdYmu0hAxU5xOREw7MbPTfGlj143cR3oCpYQsepCfZLe
 LQ4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqpt8xmqPHqVyiKr3QDc124S5UQKPZF1qGWWZ4HGzKGE94xhJEzLU/r++gkBpwa7459nVTEmrs9NU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3O/y2wZ49g5J/iatkNZtGv6CCybmkpINkgtvNpp+TQ6j1qKDS
 4RXXA+Dd3mswhuAEWJUOHSoRjsVFqChGcPzIexRF5YEDWPEcwdaP3x1hpcYzUkrF
X-Gm-Gg: AeBDieuQedsqusX22YtVhWR1ogYIizTThwJw1EYdbh8jODULlSFq5gbxrI6W0TIP+67
 d5rszo7Pbur8U6nEq4BSTwtV4jl95/c0a2/kLhKVzPVqf2NLLH2p5T1qTsE8Kh0mBQ+6/pPm9nd
 XUKzFxesbLjHynlizShzT1iuKzVpiBGUV8y2J3kBBJ/sNLO+nwKIypzZOKtsvUw2P5lP1TMloC+
 4U2LN3yZfogOwJSXudbIX4hTVwNnINnJQ5vlVXWtVvU2UxcGP7dmHLrJNGRTIwn0YdTX6tDV+ih
 mHtsVkJ7voE5kDdoVtQI/wJMLPu/bvaOq5Qs6LK7V/pek5UrD5a6llMyFvcAMG35WWuG3B4LFJA
 QVVxQ1tLtOprmxMFv+RwtbmnKkOQfNgS/o03m0qIhnMqU/1CkEFwe8LVz9CoytTPOzjTxOSzAjs
 NXSAlPdTdpywt3xn/n1JF/BRWWjYPVKBkXykbmjDFqkIAz/vnLJM59oISoZjSsVGZc
X-Received: by 2002:a05:622a:1893:b0:509:1a36:6aca with SMTP id
 d75a77b69052e-50d6273faf2mr311508811cf.17.1775654958467; 
 Wed, 08 Apr 2026 06:29:18 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com.
 [209.85.160.180]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b93dd05sm162222621cf.9.2026.04.08.06.29.17
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 06:29:17 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-50b392f1846so87383991cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 06:29:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5/jx3sj3aUyy/u3W8Lney3HNom3f9QbV1DpAvsWLsew9Qt8nmVf5C1PjD5s/XZjrDm36jhU0+uzM=@lists.freedesktop.org
X-Received: by 2002:a05:6122:3a03:b0:56f:1a26:563a with SMTP id
 71dfb90a1353d-56f1a265761mr1211064e0c.7.1775654605828; Wed, 08 Apr 2026
 06:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <9595f56ce8ab120477bfc11eaafb0f2b655d049a.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <9595f56ce8ab120477bfc11eaafb0f2b655d049a.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 15:23:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXr_=E+WhCd0Tfrehn+2Mo3L+GUUUCWX5vc-gunYx_oTw@mail.gmail.com>
X-Gm-Features: AQROBzCAS3tdwS4I5i1ony0ZYqV2Tos82DINalsSZpND3OxFU3AJc31boq9f15A
Message-ID: <CAMuHMdXr_=E+WhCd0Tfrehn+2Mo3L+GUUUCWX5vc-gunYx_oTw@mail.gmail.com>
Subject: Re: [PATCH v6 06/21] clk: renesas: r9a09g047: Add support for
 SMUX2_DSI{0, 1}_CLK
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, laurent.pinchart@ideasonboard.com, 
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
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

On Wed, 8 Apr 2026 at 12:38, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Add support for the SMUX2_DSI0_CLK and SMUX2_DSI1_CLK clock muxes
> present on the r9a09g047 SoC.
>
> These muxes select between CDIV7_DSI{0,1}_CLK and CSDIV_2to16_PLLDSI{0,1}
> using the CPG_SSEL3 register (SELCTL0 and SELCTL1 bits).
>
> According to the hardware manual, when LVDS0 or LVDS1 outputs are used,
> SELCTL0 or SELCTL1 must be set accordingly.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
