Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF971073CB6
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75D910E65B;
	Wed,  8 Apr 2026 13:26:45 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610EA10E65B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 13:26:44 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8cfdac74050so723031385a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 06:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775654803; x=1776259603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11iAo9dki9YzQOZbHMLoGuCa0VnV6ePIcYUznc5FWP8=;
 b=L4gHv9p/lD1d3nkkeXKmLMf0LCnDLMHmWw2x/2jLyenAPahH7gu1UmnQA5+U5R8bpY
 46Xs42q8nVjpDqIFIcv50rJyuam3V92lF257RlcR4in32GICHpkD9BhDwRzoM0MFDj/U
 a9moElnfMp0Gn7L8FP4UBRvTP3IQJnwnA1KIPKY9F3m+RcJ24ptWQllPJKarxArd8g4o
 cg3pDizTV0YdJWSxb2/+XZZF9Tn9lT7i2AA7DN00mcmynk545EdXc5QF9uleG2S8OBSn
 2h99BR8iYSG0YpLpfhrIDO8IinfAZHDxjvb1s3c6nt3Ia90b13E3Hz4WlCZJevIK87V1
 +L3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5Y3LRh8XmwBcxc9iF//77s19K2QDqy/zxAkaWrSW44VdacqsH/P3O6gj1kqEulxXPz/AcCmeuwRo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5rKaLn/pR+pLvQnSKOhIClAcfzBCEh3eoc36bajbb5wOcH405
 sdQdRgkgYqfjwdMp8/nE1R5IREl7esvJ3BIoCFgW4LO/3mdebm2vIAiJwJWaFI1d
X-Gm-Gg: AeBDietxUfGplLIDr/NUW7axYiOz4VgAeebbwQHZMYBKB4aaG1uysB1cL8Np7EY7R4E
 D1aBBqxjU2t86wjNKrHanl2iCJr/t9rJt4h83md+uebf1K1sRErTGMSQhPS6dPck4DE7Zhc73gQ
 CNbaiepcxvwMiyEv8IRMYPG2d+l0YhawCE5d3bdLsXHQ2flfWXUNivkx5hJtaSzH/qOm9kDj0Kv
 H9KZsFhr82cAZsLz4gLX0vGq/+ZXrNFNk3Texxd3QpfyW6gbKC+UsQkrgVG4C9iTm7Tjo3fBnb9
 V0xejfszFgT7h4sZKzrLwD0NNowsDds4wM1zLpbfhfirWhvD4hv58eMCVjKtJKtuTJSWG0e/OzO
 GRWFgueEbsURrnE/LMVLWwimz8ajiTETiGuAeQGN+djor2WTk6tAYuZ1Pvsxhx2NKTe/F5XlhV0
 r3DUWVopFDPc+GSE1fCJnuB/JK7JwNK+jGgMh6eTOguBhM6j+R7XJpqld8CeE0kALoGJVXwRLwc
 tM=
X-Received: by 2002:a05:620a:710a:b0:8cf:db04:8a22 with SMTP id
 af79cd13be357-8d41db50e60mr2746245985a.42.1775654803052; 
 Wed, 08 Apr 2026 06:26:43 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com.
 [209.85.222.172]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a8740491sm1536447985a.38.2026.04.08.06.26.42
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 06:26:42 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cbc593a67aso626721685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 06:26:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVd6P76TnC0AZS2zq+GGJfYG9AeMLqX+C1O0KQ9eEQe+aNxjLYSeusxCwZhJdZOiibqrZDnhV6PXI8=@lists.freedesktop.org
X-Received: by 2002:a05:6122:4b05:b0:56d:3b69:87d2 with SMTP id
 71dfb90a1353d-56dab9df26emr8767911e0c.11.1775654366102; Wed, 08 Apr 2026
 06:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <24d3853ca2522df21e6a071a23e23ba4ca4b7276.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <24d3853ca2522df21e6a071a23e23ba4ca4b7276.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 15:19:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-GrDWaKzxf09DRKwDkcY7W_cZrnubBWqD0w1iAYc8Kw@mail.gmail.com>
X-Gm-Features: AQROBzC36oVu26dy7QAue_JJJeRvfbuifO9CcFeX81T2keIzqU6JIH81ayIbX9M
Message-ID: <CAMuHMdV-GrDWaKzxf09DRKwDkcY7W_cZrnubBWqD0w1iAYc8Kw@mail.gmail.com>
Subject: Re: [PATCH v6 01/21] clk: renesas: rzv2h: Add PLLDSI clk mux support
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
> Add PLLDSI clk mux support to select PLLDSI clock from different clock
> sources.
>
> Introduce the DEF_PLLDSI_SMUX() macro to define these muxes and register
> them in the clock driver.
>
> Extend the determine_rate callback to calculate and propagate PLL
> parameters via rzv2h_get_pll_dtable_pars() when LVDS output is selected,
> using a new helper function rzv2h_cpg_plldsi_smux_lvds_determine_rate().
>
> The CLK_SMUX2_DSI{0,1}_CLK clock multiplexers select between two paths
> with different duty cycles:
>
> - CDIV7_DSIx_CLK (LVDS path, parent index 0): asymmetric H/L=4/3 duty (4/7)
> - CSDIV_DSIx (DSI/RGB path, parent index 1): symmetric 50% duty (1/2)
>
> Implement rzv2h_cpg_plldsi_smux_{get,set}_duty_cycle clock operations to
> allow the DRM driver to query and configure the appropriate clock path
> based on the required output duty cycle.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v5->v6:
>  - Fixed rzv2h_cpg_plldsi_smux_clk_register() removed u8 width, mask
>    variables and replaced with direct use of smux.width and clk_div_mask(smux.width).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
