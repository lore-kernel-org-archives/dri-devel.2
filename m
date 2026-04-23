Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0797FFB44C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F90E10F3B7;
	Fri, 24 Apr 2026 07:44:55 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02F410F28B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:22:04 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g1plB2FTJz9twV;
 Thu, 23 Apr 2026 23:15:02 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of linux@timmermann.space designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=linux@timmermann.space
From: Lukas Timmermann <linux@timmermann.space>
Date: Thu, 23 Apr 2026 23:14:38 +0200
Subject: [PATCH 2/5] drm/panel-edp: Add support for Samsung LTL101DL02-002
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-manta-display-v1-2-196f80c5673a@timmermann.space>
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
X-Rspamd-Queue-Id: 4g1plB2FTJz9twV
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

From: Alexandre Marquet <tb@a-marquet.fr>

Add a panel entry for the Samsung LTL101DL02-002 panel, as found in
Samsung Manta (Google Nexus 10).

Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
Signed-off-by: Lukas Timmermann <linux@timmermann.space>
---
 drivers/gpu/drm/panel/panel-edp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 415b894890ad..2004699db41b 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1542,6 +1542,34 @@ static const struct panel_desc samsung_lsn122dl01_c01 = {
 	},
 };
 
+static const struct drm_display_mode samsung_ltl101dl02_002_mode = {
+	.clock = 268627,
+	.hdisplay = 2560,
+	.hsync_start = 2560 + 48,
+	.hsync_end = 2560 + 48 + 32,
+	.htotal = 2560 + 48 + 32 + 80,
+	.vdisplay = 1600,
+	.vsync_start = 1600 + 3,
+	.vsync_end = 1600 + 3 + 6,
+	.vtotal = 1600 + 3 + 6 + 37,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc samsung_ltl101dl02_002 = {
+	.modes = &samsung_ltl101dl02_002_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 218,
+		.height = 136,
+	},
+	.delay = {
+		.hpd_absent = 200,
+		.unprepare = 500,
+	},
+
+};
+
 static const struct drm_display_mode samsung_ltn140at29_301_mode = {
 	.clock = 76300,
 	.hdisplay = 1366,
@@ -1696,6 +1724,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "samsung,lsn122dl01-c01",
 		.data = &samsung_lsn122dl01_c01,
+	}, {
+		.compatible = "samsung,ltl101dl02-002",
+		.data = &samsung_ltl101dl02_002,
 	}, {
 		.compatible = "samsung,ltn140at29-301",
 		.data = &samsung_ltn140at29_301,

-- 
2.53.0

