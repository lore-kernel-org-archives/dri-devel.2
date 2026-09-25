Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC00C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E7B10FA32;
	Fri, 25 Sep 2026 12:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="RSadp3k1";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E04E10E281
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:47:37 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so8752005e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790340455; x=1790945255;
 darn=lists.freedesktop.org; 
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hVgejJErSi/df8/6avC+kCC2kZbgZL+1y5/eEh1fX5I=;
 b=RSadp3k1UFFWS42dVyqQoYbam/TY0gtauPxy5C7ZR18O6uoam5+ksIo35+qIaL8hsv
 hF1zJlgMWsHzsUQKk8whxlYQuzokhrkg55MgzMuh3YQIKsUEBowDdZI7nq0n/GfdGupG
 IT3wPiznAt3QKqXkUrNZvPks+TyjSEz4Epyir7bpYjOoTb9s65AOH2/FzdPGpVjWNeEl
 G5aUWSAMsLt6Nst2J24WNuLhEcl8pxzl56/hgzp8FWrf60xosIQ921crOuor6q8j32e6
 axBybzBRjla5ik6QwCr+r0pcaQycuTkYTrkk4FRLAgu/rAbgkD0dX6RuXXjhO1JoY7ll
 dpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340455; x=1790945255;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hVgejJErSi/df8/6avC+kCC2kZbgZL+1y5/eEh1fX5I=;
 b=JlOFYs00Zg5mY+e8A7cyCVQN3ryvLFQyJcy2pJEfUPnkhy1ql5rHoNj1nRqmY86nEF
 mZCP0LXsJs+SmR8Z8Jh0PhW9mgOAdBjttdICpzgkCVMgTnUSHnBkR0WCR3x6BsoxKhzJ
 ULnQmqeDhmZYjuGRWkZ3z/FSnNyG1BYmkrIgwVxBKMNDoQpMFV9gmI+iqiapRSW2GEnm
 pBe1s7SqKDeWxsw/EDYVgCDNZ9qErtei2IL+48y/GsgSdOFrQpEVA5YhXQbbVyGlhIhc
 v4s51FuWN8bH2ZYTLsO3NA3zMYYBbPg7SAK4erZQzXM+/xV1G88SBg+4GjvQv7WAZBM9
 WCdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGiBwPKcoh9ragiQK3E/vVVPWHe4HgA7vr7LZIlJWsFGfks81dMfDWFZWwGM+hLy8V2knPsGKWftE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nvBf1Zu7oWc+vS3hx9oHibKhr6wdpfMbS8DdBGDvs+32qXknyE
 bbIkbQkQgs51BHfXYfbKl++IKNrccmaZfTIFb6+o5JrtNgJaFVZfoEIGje9MALL0T1Q=
X-Gm-Gg: AYBFou0M3hxKqHE55cEJo/OJyeSW6uVd94QF9GUSi6sKtkxmnqQUKwXncuaSkD6D3gR
 Sn2TgJ9Bja4v3eUEU88kfjJ7wrZ8VMoorVZUnTzRxLSshDtgKrOE45anHHatwGGspzgTjGWsMBp
 UWdgizUAowiBQPz6rYqQ/xtQQ+nB60j/qgMfD3KrGrte5muQPSI3ceh9L3kMWkUiWnPoD9E7Z41
 7DQCfDmbpHQHRUGKbEvMYR3KS57yQGpnRnGGjpTpreP8Cmx3w4J9pm3OSmLnSBQhwIyqh0rR6Th
 yFtQos4feOUKzzG4EQsRdr+0hLkQ8YFQQQHkAv6UFj7ZvDBquuFa3TsE2h/nWIP98wAg8qMI94J
 KxSSylsucFNuqL8Y/271wVVM6FR+IH9Wx1DdKzv5xrqpBeqf34Kq8DBJ7yFhq2OiCvj//tZO3dX
 t+B6R1tdtHKRPVJIOODK+EeJSwfmcxQAljdfNlNi9NL6mFQzn4Vquh0YBB/ddYtFGCcadJfcexM
 SkM93Qz807Ho+BBBQ==
X-Received: by 2002:a05:600c:6090:b0:49e:6e94:7cae with SMTP id
 5b1f17b1804b1-49fe670424cmr91000685e9.28.1790340455565; 
 Fri, 25 Sep 2026 05:47:35 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff27eabc1sm58460335e9.15.2026.09.25.05.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:47:32 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul
 <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Emil
 Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Heiko
 Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Michal Wilczynski
 <m.wilczynski@samsung.com>
Subject: Re: [PATCH v3 13/19] clk: starfive: jh7110-vout: Allow pixel clock
 rate propagation
In-Reply-To: <20260904-jh7110-clean-send-v3-13-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132733eucas1p1a6529cb2ea97bc75c9cd190d1ba901c0@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-13-484f9ae72715@samsung.com>
Date: Fri, 25 Sep 2026 14:47:30 +0200
Message-ID: <1j5wzt8plp.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On ven. 04 sept. 2026 at 15:27, Michal Wilczynski <m.wilczynski@samsung.com> wrote:

> The dc8200_pix0 and dc8200_pix1 MUXes feed the display controller, and
> the rate they carry is ultimately produced by the HDMI PHY, which
> registers hdmitx0_pixelclk as a clock provider.
>
> Add CLK_SET_RATE_PARENT to both MUXes so a rate requested on them
> reaches that parent, instead of being clamped to whatever rate the
> parent already happens to run at.
>
> Co-developed-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/clk/starfive/clk-starfive-jh7110-vout.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> index bad20d5d794a72f071b4d547b7304786a8ba9afa..aeba42cd3c44ba205ced52b1826d2d2de82ad78f 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> @@ -40,10 +40,12 @@ static const struct jh71x0_clk_data jh7110_voutclk_data[] = {
>  	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AXI, "dc8200_axi", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
>  	JH71X0_GATE(JH7110_VOUTCLK_DC8200_CORE, "dc8200_core", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
>  	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AHB, "dc8200_ahb", 0, JH7110_VOUTCLK_VOUT_TOP_AHB),
> -	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", 0, 2,
> +	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0",
> +		    CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, 2,

I see that you've added CLK_SET_RATE_NO_REPARENT following a previous
sashiko advice.

Note that saying it will 'hijack' the parent without it is kind of
strong. It is fine to let a mux reparent while setting a rate, as long
as you understand the possible consequences for the rest of the tree.

Regardless

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

>  		    JH7110_VOUTCLK_DC8200_PIX,
>  		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
> -	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", 0, 2,
> +	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1",
> +		    CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, 2,
>  		    JH7110_VOUTCLK_DC8200_PIX,
>  		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
>  	/* LCD */
>
> -- 
> 2.34.1
>

-- 
Jerome
