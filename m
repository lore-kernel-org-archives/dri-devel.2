Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F989606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGdOGybZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AFD10F73D;
	Fri,  6 Nov 2026 13:16:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E45D10F73D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 962F6601BF;
 Fri,  6 Nov 2026 13:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67141F008A3;
 Fri,  6 Nov 2026 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971005;
 bh=hXaeP1HSgWK/rh/akJ1NHWuWrhvmBuk6yhlJ7X+pTiY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mGdOGybZiy6OGv3YeXz+c1JaK4zXwEhH6Z88IgRby0YVsMzXPwJc758942FIraLi1
 dKK1ieUZ2Oam/d0ZIIC4qxGZmwREtzDT4mbQeQz/Z6kXsc0T/VAvCIEbLUkomjkXGw
 ch591cWmzdSYaD24600tX2aiYMEG0sF8r9bMsMO8nq6vo8S0+0+gcF7WTGJ0PWyk3L
 G6S5bGUA9j6wwPHMpnHX0WsJH7+2+7f012g004hYvnZOqhl6u+MGDzxFLfNPObGQGP
 NXRTFrZ6pKciua5p+gbLChdD7mJM54FBEGIhR5PxIn3uYqxpJNsxBtI1HWOntOPBmH
 42Fg8iM4qL3kA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:47 +0100
Subject: [PATCH v8 34/39] drm/tidss: Implement hw_reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-34-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5410; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iX7BMU20DMiKTCftPhrQvC6bICKGq1Ll0jGYQbZyY9I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+3W1w3mb2P+eGEjj//HlW6JFdm8k1g2rtzZqTH7c
 r336z+/OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEjq5grPfYmblJS3tWQsKD
 sh+2T+w2Z58rOnXjdF7dluq0O8XqwV9O1Pp/9vgxed7inFcTE1TnJjDWV7N7WXLWLPqmvufm/Gf
 vyyUc1DoUNRZf3P62WkGGO2rTC/5Xog8WJmxmZ1KLN+PzPcUAAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dispc hardware needs to be put in a known-good state when the
driver starts. This was previously done unconditionally during
dispc_init(), but it should only be performed on the reset path when
implementing state readout.

Rename dispc_init_hw() to dispc_reset_hw(), export it, and remove
the call from dispc_init(). Implement &drm_mode_config_funcs.hw_reset
through tidss_hw_reset() which performs the dispc soft reset and then
calls drm_mode_config_helper_hw_reset() to reset the rest of the
objects.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 48 +++++++++----------------------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  1 +
 drivers/gpu/drm/tidss/tidss_drv.c   | 22 ++++++++++-------
 drivers/gpu/drm/tidss/tidss_kms.c   | 14 +++++++++++
 4 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index b5fb296fddcc..8720403af9ed 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2932,43 +2932,21 @@ static int dispc_softreset(struct dispc_device *dispc)
 }
 
-static int dispc_init_hw(struct dispc_device *dispc)
+int dispc_reset_hw(struct dispc_device *dispc)
 {
-	struct device *dev = dispc->dev;
+	struct tidss_device *tidss = dispc->tidss;
 	int ret;
 
-	ret = pm_runtime_set_active(dev);
-	if (ret) {
-		dev_err(dev, "Failed to set DSS PM to active\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(dispc->fclk);
-	if (ret) {
-		dev_err(dev, "Failed to enable DSS fclk\n");
-		goto err_runtime_suspend;
-	}
+	/*
+	 * The reset runs from drm_mode_config_create_initial_state(), so
+	 * after the driver has enabled runtime PM. As
+	 * pm_runtime_set_active() is only allowed while runtime PM is
+	 * disabled, rely on the regular runtime PM references to power
+	 * the device up for the reset instead.
+	 */
+	tidss_runtime_get(tidss);
 
 	ret = dispc_softreset(dispc);
-	if (ret)
-		goto err_clk_disable;
 
-	clk_disable_unprepare(dispc->fclk);
-	ret = pm_runtime_set_suspended(dev);
-	if (ret) {
-		dev_err(dev, "Failed to set DSS PM to suspended\n");
-		return ret;
-	}
-
-	return 0;
-
-err_clk_disable:
-	clk_disable_unprepare(dispc->fclk);
-
-err_runtime_suspend:
-	ret = pm_runtime_set_suspended(dev);
-	if (ret) {
-		dev_err(dev, "Failed to set DSS PM to suspended\n");
-		return ret;
-	}
+	tidss_runtime_put(tidss);
 
 	return ret;
@@ -3082,8 +3060,4 @@ int dispc_init(struct tidss_device *tidss)
 			     &dispc->memory_bandwidth_limit);
 
-	r = dispc_init_hw(dispc);
-	if (r)
-		return r;
-
 	tidss->dispc = dispc;
 
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index df3daccf3f31..caf0f8c58739 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -149,4 +149,5 @@ void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
 const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);
 
+int dispc_reset_hw(struct dispc_device *dispc);
 int dispc_init(struct tidss_device *tidss);
 void dispc_remove(struct tidss_device *tidss);
diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index e258f656cf03..409d599bb2ff 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -152,4 +152,18 @@ static int tidss_probe(struct platform_device *pdev)
 	}
 
+	drm_kms_helper_poll_init(ddev);
+
+	/*
+	 * drm_mode_config_create_initial_state() resets the DISPC when
+	 * the state readout isn't possible, which also clears the
+	 * interrupt enable registers. Install the interrupts only once
+	 * that's been done, so that the reset can't wipe them.
+	 */
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret) {
+		dev_err(dev, "failed to create initial state: %d\n", ret);
+		goto err_runtime_suspend;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -165,12 +179,4 @@ static int tidss_probe(struct platform_device *pdev)
 	}
 
-	drm_kms_helper_poll_init(ddev);
-
-	ret = drm_mode_config_create_initial_state(ddev);
-	if (ret) {
-		dev_err(dev, "failed to create initial state: %d\n", ret);
-		goto err_irq_uninstall;
-	}
-
 	ret = drm_dev_register(ddev, 0);
 	if (ret) {
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index eefe2221bdde..a3bf94e56fcb 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -11,4 +11,5 @@
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
@@ -117,8 +118,21 @@ static int tidss_atomic_check(struct drm_device *ddev,
 }
 
+static void tidss_hw_reset(struct drm_device *dev)
+{
+	struct tidss_device *tidss = to_tidss(dev);
+	int ret;
+
+	ret = dispc_reset_hw(tidss->dispc);
+	if (ret)
+		drm_warn(dev, "Couldn't reset dispc");
+
+	drm_mode_config_helper_hw_reset(dev);
+}
+
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.atomic_check = tidss_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
+	.hw_reset = tidss_hw_reset,
 };
 

-- 
2.55.0

