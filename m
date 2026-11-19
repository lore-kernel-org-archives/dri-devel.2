Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737B606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51EB112401;
	Thu, 19 Nov 2026 13:41:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEAA3112401
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:41:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00EC06299B;
 Thu, 19 Nov 2026 13:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F551F000C5;
 Thu, 19 Nov 2026 13:40:57 +0000 (UTC)
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
Subject: [PATCH 2/6] clk: Add dev_clk_get_from_provider()
Date: Thu, 19 Nov 2026 14:40:35 +0100
Message-ID: <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
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

Clocks obtained through of_clk_get_from_provider() show up as
"deviceless" in the consumer column of the clk_summary file in debugfs.
Add a new variant dev_clk_get_from_provider() that also takes a consumer
device, so callers can provide it, and consumer's name will be shown in
the clk_summary output.

Reimplement of_clk_get_from_provider() on top of
dev_clk_get_from_provider().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/clk.c   | 11 +++++++----
 include/linux/clk.h | 10 ++++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 858f4d60ed2d97c4..195c7d80e4f2b579 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5377,20 +5377,23 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 }
 
 /**
- * of_clk_get_from_provider() - Lookup a clock from a clock provider
+ * dev_clk_get_from_provider() - Lookup a clock from a clock provider
+ * @dev: clk consumer device
  * @clkspec: pointer to a clock specifier data structure
  *
  * This function looks up a struct clk from the registered list of clock
  * providers, an input is a clock specifier data structure as returned
  * from the OF phandle parser.
  */
-struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+struct clk *dev_clk_get_from_provider(struct device *dev,
+				      struct of_phandle_args *clkspec)
 {
 	struct clk_hw *hw = of_clk_get_hw_from_clkspec(clkspec);
+	const char *name = dev ? dev_name(dev) : NULL;
 
-	return clk_hw_create_clk(hw, NULL, __func__, NULL);
+	return clk_hw_create_clk(hw, name, __func__, NULL);
 }
-EXPORT_SYMBOL_GPL(of_clk_get_from_provider);
+EXPORT_SYMBOL_GPL(dev_clk_get_from_provider);
 
 struct clk_hw *of_clk_get_hw(struct device_node *np, int index,
 			     const char *con_id)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index db9cf184fd999b85..45c6eb09436036bb 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -1261,7 +1261,8 @@ static inline struct clk *clk_get_optional(struct device *dev, const char *id)
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
-struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
+struct clk *dev_clk_get_from_provider(struct device *dev,
+				      struct of_phandle_args *clkspec);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
 {
@@ -1272,10 +1273,15 @@ static inline struct clk *of_clk_get_by_name(struct device_node *np,
 {
 	return ERR_PTR(-ENOENT);
 }
-static inline struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+static inline struct clk *dev_clk_get_from_provider(struct device *dev,
+						    struct of_phandle_args *clkspec)
 {
 	return ERR_PTR(-ENOENT);
 }
 #endif
+static inline struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+{
+	return dev_clk_get_from_provider(NULL, clkspec);
+}
 
 #endif
-- 
2.43.0

