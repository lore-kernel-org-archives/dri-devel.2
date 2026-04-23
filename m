Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376BAFB44C8
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EE510F3CD;
	Fri, 24 Apr 2026 07:44:56 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61EC10F28B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:24:48 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g1plY2qWhz9tPg;
 Thu, 23 Apr 2026 23:15:21 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of linux@timmermann.space designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=linux@timmermann.space
From: Lukas Timmermann <linux@timmermann.space>
Date: Thu, 23 Apr 2026 23:14:40 +0200
Subject: [PATCH 4/5] clk: samsung: exynos5250: Define more clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-manta-display-v1-4-196f80c5673a@timmermann.space>
References: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
In-Reply-To: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Lukas Timmermann <linux@timmermann.space>, 
 Alexandre Marquet <tb@a-marquet.fr>
X-Rspamd-Queue-Id: 4g1plY2qWhz9tPg
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

Add defines for mout_fimd1 and mout_vpll to enable display support for
exynos5250-manta boards.

Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
Signed-off-by: Lukas Timmermann <linux@timmermann.space>
---
 drivers/clk/samsung/clk-exynos5250.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index e90d3a0848cb..a43d05d3014f 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -102,7 +102,7 @@
 #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
 
 /* NOTE: Must be equal to the last clock ID increased by one */
-#define CLKS_NR					(CLK_MOUT_VPLLSRC + 1)
+#define CLKS_NR					(CLK_MOUT_VPLL + 1)
 
 /* list of PLLs to be registered */
 enum exynos5250_plls {
@@ -283,7 +283,7 @@ static const struct samsung_mux_clock exynos5250_mux_clks[] __initconst = {
 
 	MUX(0, "mout_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
 	MUX(0, "mout_epll", mout_epll_p, SRC_TOP2, 12, 1),
-	MUX(0, "mout_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
+	MUX(CLK_MOUT_VPLL, "mout_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
 	MUX(0, "mout_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
 	MUX(0, "mout_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
 	MUX(CLK_MOUT_GPLL, "mout_gpll", mout_gpll_p, SRC_TOP2, 28, 1),
@@ -304,7 +304,7 @@ static const struct samsung_mux_clock exynos5250_mux_clks[] __initconst = {
 	MUX(0, "mout_gscl_wa", mout_group1_p, SRC_GSCL, 24, 4),
 	MUX(0, "mout_gscl_wb", mout_group1_p, SRC_GSCL, 28, 4),
 
-	MUX(0, "mout_fimd1", mout_group1_p, SRC_DISP1_0, 0, 4),
+	MUX(CLK_MOUT_FIMD1, "mout_fimd1", mout_group1_p, SRC_DISP1_0, 0, 4),
 	MUX(0, "mout_mipi1", mout_group1_p, SRC_DISP1_0, 12, 4),
 	MUX(0, "mout_dp", mout_group1_p, SRC_DISP1_0, 16, 4),
 	MUX(CLK_MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_DISP1_0, 20, 1),

-- 
2.53.0

