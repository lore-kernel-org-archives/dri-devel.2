Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0617606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4E51123F8;
	Thu, 19 Nov 2026 13:40:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E460B1123F8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:40:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C30FD41E9A;
 Thu, 19 Nov 2026 13:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B921F000C6;
 Thu, 19 Nov 2026 13:40:48 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/6] clk: Improve consumer field in debugfs clk_summary
Date: Thu, 19 Nov 2026 14:40:33 +0100
Message-ID: <cover.1795094688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

	Hi all,

When a driver uses of_clk_get_from_provider() to obtain clocks, the
latter show up as "deviceless" in the consumer column of the clk_summary
file in debugfs.

This patch series aims to improve that, by introducing a new variant
dev_clk_get_from_provider() that also takes a consumer device.
When callers provide it, the consumer's name will be shown in the
clk_summary output.

Sample clk_summary change snippet on R-Car H1 Marzen:
    - sata 1 1 0 62500000 0 0 50000 Y deviceless    of_clk_get_from_provider
    + sata 1 1 0 62500000 0 0 50000 Y fc600000.sata dev_clk_get_from_provider

Overview:
  - The first patch removes the unused "dev" member from struct clk and
    the "dev" parameter from clk_hw_create_clk(): it felt wrong to add
    yet another user of clk_hw_create_clk() passing a useless device
    pointer,
  - The second patch introduces the new dev_clk_get_from_provider()
    function,
  - Patches 3-6 convert users to the new helper:
      - The Renesas clock patch was tested on R-Car H1 and H3, and
	should work fine on other Renesas SoCs,
      - The Rockchip HDMI patch was only compile-tested, but is probably
	fine, too,
      - The OMAP2+ patch definitely needs testing,
      - The Renesas pmdomain patch depends on work in progress.

This series has been tested on R-Car H1, H3, and X5H.

Thanks for your comments!

Geert Uytterhoeven (6):
  clk: Remove unused clk.dev
  clk: Add dev_clk_get_from_provider()
  clk: renesas: Convert to dev_clk_get_from_provider()
  [RFT] drm/rockchip: dw_hdmi: Convert to dev_clk_get_from_provider()
  [RFT] ARM: OMAP2+: Convert to dev_clk_get_from_provider()
  [RFC] pmdomain: renesas: r8a78000: Convert to
    dev_clk_get_from_provider()

 arch/arm/mach-omap2/omap_device.c           |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c            |  3 ++-
 drivers/clk/clk.c                           | 23 ++++++++++-----------
 drivers/clk/clk.h                           | 11 ++++------
 drivers/clk/clkdev.c                        | 14 ++++---------
 drivers/clk/renesas/clk-mstp.c              |  2 +-
 drivers/clk/renesas/r9a06g032-clocks.c      |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c      |  2 +-
 drivers/clk/renesas/rzg2l-cpg.c             |  2 +-
 drivers/clk/renesas/rzv2h-cpg.c             |  2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |  3 ++-
 drivers/pmdomain/renesas/r8a78000-mdlc.c    |  2 +-
 include/linux/clk.h                         | 10 +++++++--
 13 files changed, 38 insertions(+), 40 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
