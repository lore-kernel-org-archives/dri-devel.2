Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7842CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4984510FDF3;
	Fri, 29 May 2026 12:05:34 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF90810FDF3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:05:32 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-6c28e1511adso173127137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 05:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780056332; x=1780661132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OX8XoUF7IFu/te1KTNA1tAU1bbe6/Z6QcoLJKS7O78=;
 b=CwsdpaOZ7KQU69yNA0vr8GGQ/0sBlQF+GwYiBdF4ZXuaxNFdgyLqIcBHRN3yQAXPaa
 4xuh6xPoFLtH1upJXtQynGOUogE1o5lKGJb0sJY8qeSCM6MQOJkKAfTtsFiaEtrdlcos
 PmGJJ/46xheGTy3r45j27E74ISl9X952zf1AsVu4QmWwq64+XvwEIZZD3TDCebvukeIp
 fze2GKdDLOkaCi6ODFBiEgSzInF2L55+DotA0sIL31O3C9uvQLFeTcvZ6NEKSOLNVRRX
 Y232TBf/Vl3YhqIvO/TZV3mD0+qMQVwZGp5xs2kPFiDTxDj9PbvJ1Pwxk8Xdy0BmvsSB
 yptQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Vp7Lnj20auyAZ6UQ1NNis1RFH0bZWJ6cLgmpcjjAEH0aFPc4oJE783SD6wnT/CqrKbn1WHDwbtvM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr0hYdkhog/+Tzpqo6RBCyHq2hTHZFGX5H3Lf+x1veaQ1aY6Cl
 Da1mzByvi/G1L0WPXRzKPYl1ijp1u6xNDSBFzdz7exYO10JbMgkJq5p5gpKWn3RqQP8=
X-Gm-Gg: Acq92OFv78iWb2GGW/9y1UihomxxtlXJ7G7T+zH2C7KlDGcpJ22JLqwMRQtLu5Td9LA
 B0u/++r3RF2L1smjcNJ8GTmv1vadV8/8mjReLsC0EufF7kqLnTO1CRSISM4u/o1jMf+RvWFoXOR
 azUwmBH7MEnuWBimq6btqfWs+ZFcgph0Qhfd8K+jB245/oYn09fPZYuh0R17kalSbmZs0YlPXrK
 zstqopuCnGSgO+/3tnvf6TOl4mnDDT2E4cErcWMHo3aMKi+KH9vsMDX5Cy1lCKh3ZncI7nr7+U0
 2sV0NeoAKaPHvwUVCpDg4iNDWFlkWg3TPr515ChgP4l0npi6Y89feWmlGNrWg1jRAKHJeMJr4yl
 RbWCjiYQ2I5LFrY4nF1wG1TgWYUQN+ZBD/em2ySelkhh8/HydL485+mT9SGV87XTZh2wpdjZIza
 gu8g/lpL8/mFaBIhEsiacQMuUWrTeBZZGi0o3Gtriop8G9KedCK1Q6zaemXok2SOWz+rpkdR73i
 V8=
X-Received: by 2002:a05:6102:26c1:b0:631:8665:3510 with SMTP id
 ada2fe7eead31-6bf40e862a9mr895548137.31.1780056331908; 
 Fri, 29 May 2026 05:05:31 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com.
 [209.85.221.169]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6bfbae51f62sm819222137.6.2026.05.29.05.05.29
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 05:05:30 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-5771954bcd0so9657255e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 05:05:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/nxzkjizjF4HgLUEKSgAmy0Rpyh6O9dtDWhploLN2WspxpLlid3C+BWl/KuNb9m1PA94QdZth1vkU=@lists.freedesktop.org
X-Received: by 2002:a05:6122:4d85:b0:56c:ca03:b668 with SMTP id
 71dfb90a1353d-599f53537c8mr819640e0c.3.1780056329661; Fri, 29 May 2026
 05:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <46547aaff3cdb8ea6e17cf1fdec699d83a1cd71b.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <20260408113358.GE1928916@killaraus.ideasonboard.com>
In-Reply-To: <20260408113358.GE1928916@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 May 2026 14:05:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5xfpj6_5o4Ed+KMLg5MMDuaNUjsUBucrC3nCkkG9vaw@mail.gmail.com>
X-Gm-Features: AVHnY4JwL8_eHuTqhLIZ-49xr1MV4gGX3lGZE_rNlXQ8x2vrv47pvQNALVqlDj0
Message-ID: <CAMuHMdV5xfpj6_5o4Ed+KMLg5MMDuaNUjsUBucrC3nCkkG9vaw@mail.gmail.com>
Subject: Re: [PATCH v6 19/21] arm64: dts: renesas: r9a09g047: Add vspd{0,
 1} nodes
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, tomm.merciai@gmail.com,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
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

On Wed, 8 Apr 2026 at 13:34, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Apr 08, 2026 at 12:37:04PM +0200, Tommaso Merciai wrote:
> > Add vspd{0,1} nodes to RZ/G3E SoC DTSI.
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
