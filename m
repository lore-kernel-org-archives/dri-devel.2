Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F688C98324
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17C110E0A7;
	Fri, 25 Sep 2026 13:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AdDQhcy7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B9A10E0A7
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:56:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75B0960238;
 Fri, 25 Sep 2026 13:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5439B1F000FF;
 Fri, 25 Sep 2026 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790344583;
 bh=6gKBCHyZM9t19y0TtvPgLwl6VVr2Q87MiH7gta/2BgQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=AdDQhcy7Ypf3G+sugD0QWJnzJHXj3FDWOJRMlcyBgHqF62ruwGlrt0buPNwPfjzHd
 FgWuP2jPvQesdyB/mcrkbRlEC7XYtEJrHiPb9luUZPM5JpOOIzm/GFHhyBtUW5BGwJ
 0NpW6Mh9ewRDxA989YpPpLZhzcUJiCBFanBzi0UgwR2C4rZdi0MG18cBkUTO0VloXI
 +l+VzpnrpNQAmtyvO92FjUCHmwogaEx55JcuBjF0WNxfYR6pTUjLx5LTIAEJNgvWLG
 NTtXNzlWj5KqzSxxmXaTMWUvId951qvRYGqqhnk9ExnoK1kl5r6BhJrOtvSuhu7UNh
 OTTd0c5Cybjrw==
From: Brian Masney <masneyb@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Lee Jones <lee@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Dominique Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
Subject: Re: (subset) [PATCH v4 00/20] drm: starfive: jh7110: Enable
 display subsystem
Message-Id: <179034455473.303481.8868788975078073035.b4-ty@b4>
Date: Fri, 25 Sep 2026 09:55:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=685; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=lkHMUyvPXXAoNeHQAE8KXfy1Ci9unePRn3tlP5thzt4=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLK21TaVm22OqmC6N2mm46xdO+8svMPwWql/sfn0fzqfm
 AJFey+c6ShlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAi3u2MDLc6BUuj5M+GuQlt
 /NLKd5nb5Z5cRdyXvIikDJ3S4ohVLowMb2Jv67feVFxk+GBC1Uv3okbpX2qPfn83MPKP41BpuTG
 bAwA=
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
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


On Tue, 15 Sep 2026 17:32:08 +0200, Michal Wilczynski wrote:
> drm: starfive: jh7110: Enable display subsystem
> 
> This series enables the display subsystem on the StarFive JH7110.
> 
> The dom_vout block holds the display controller (dc8200), the clock
> generator (voutcrg) and the HDMI IP, all inside PD_VOUT. The HDMI IP is
> a single register block containing both the controller and the PHY, and
> it has a circular clock dependency with voutcrg:
> 
> [...]

Applied, thanks!

[14/20] clk: starfive: jh7110-vout: Allow pixel clock rate propagation
        commit: af384d6e0573b416a7a28e0ab6300d797cae369d

Best regards,
-- 
Brian Masney <masneyb@kernel.org>

