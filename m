Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4577606A330
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6FD5112402;
	Thu, 19 Nov 2026 13:41:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8401A112401
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:41:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 540954081D;
 Thu, 19 Nov 2026 13:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B091F000C4;
 Thu, 19 Nov 2026 13:41:01 +0000 (UTC)
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
Subject: [PATCH 3/6] clk: renesas: Convert to dev_clk_get_from_provider()
Date: Thu, 19 Nov 2026 14:40:36 +0100
Message-ID: <55d67b95c675924fb67d13ecbab47bb45c8af372.1795094688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Renesas clock domain callbacks use of_clk_get_from_provider() to obtain
clocks used for power management, so the latter show up as "deviceless"
in the consumer column of the clk_summary file in debugfs.

Fix this by using dev_clk_get_from_provider() instead, letting us pass
the consumer device, too.

Sample clk_summary change snippet on R-Car H1 Marzen:
    - sata 1 1 0 62500000 0 0 50000 Y deviceless    of_clk_get_from_provider
    + sata 1 1 0 62500000 0 0 50000 Y fc600000.sata dev_clk_get_from_provider

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on R-Car H1 and H3.
---
 drivers/clk/renesas/clk-mstp.c         | 2 +-
 drivers/clk/renesas/r9a06g032-clocks.c | 2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 drivers/clk/renesas/rzg2l-cpg.c        | 2 +-
 drivers/clk/renesas/rzv2h-cpg.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 1bd2acb7e175f9c7..79d3a0b9cf7bb08a 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -276,7 +276,7 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 	return 0;
 
 found:
-	clk = of_clk_get_from_provider(&clkspec);
+	clk = dev_clk_get_from_provider(dev, &clkspec);
 	of_node_put(clkspec.np);
 
 	if (IS_ERR(clk))
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 871a915c24b8b609..9ae716dc6ede3438 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -748,7 +748,7 @@ static int create_add_module_clock(struct of_phandle_args *clkspec,
 	struct clk *clk;
 	int error;
 
-	clk = of_clk_get_from_provider(clkspec);
+	clk = dev_clk_get_from_provider(dev, clkspec);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1ed11ce4a04c8b44..1fc12132acfe4a8b 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -641,7 +641,7 @@ int cpg_mssr_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 	return 0;
 
 found:
-	clk = of_clk_get_from_provider(&clkspec);
+	clk = dev_clk_get_from_provider(dev, &clkspec);
 	of_node_put(clkspec.np);
 
 	if (IS_ERR(clk))
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 06ae7228a95480fd..fb57d26947e1647c 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -2557,7 +2557,7 @@ static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device
 				goto err;
 			}
 		}
-		clk = of_clk_get_from_provider(&clkspec);
+		clk = dev_clk_get_from_provider(dev, &clkspec);
 		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			error = PTR_ERR(clk);
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index fabeaef8e62fba33..4b685f7250f661bd 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -1483,7 +1483,7 @@ static int rzv2h_cpg_attach_dev(struct generic_pm_domain *domain, struct device
 				goto err;
 			}
 		}
-		clk = of_clk_get_from_provider(&clkspec);
+		clk = dev_clk_get_from_provider(dev, &clkspec);
 		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			error = PTR_ERR(clk);
-- 
2.43.0

