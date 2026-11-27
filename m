Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFF606A33B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tr50cMQh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F35211292B;
	Fri, 27 Nov 2026 09:54:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F1111292B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DE4F62632;
 Fri, 27 Nov 2026 09:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21341F00A26;
 Fri, 27 Nov 2026 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773285;
 bh=zW2LbJq3hFWAcU9+1guQEGP4RhFAi15WyrcBmV2NRco=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Tr50cMQhCwMRLxrf3UNTV0bI3llfKxmZGN093dimiU78nRksvB8wClooa60+QBikO
 20qN59HYJBNqcSCtAONBAgpFW0gm7hGSMBPx7WqOYvpsvaTeJMPdJuhBFrxhKpXKiB
 3pen9LKZV8EhG1PjcoO+71kSmQUPT/dBaUU78oqHMT2o3ZQ5XX1jkN77meYL6teErX
 umNAHqerxlFHaLG6chrTcaNa80bjlgVnQYsAXewdHDyeRUJhd02JamyLUNWCUXIZ4Y
 EqisNWaIQzvZ9OTJSY056D88J/blo6xXoFYlw7bS9jQCGSgDdAEsrcmB8P6a8iO41u
 gfIZysthAGoDw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:07 +0100
Subject: [PATCH v10 25/36] drm/tidss: Implement hw_reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-25-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5564; i=mripard@kernel.org;
 h=from:subject:message-id; bh=he0kfipsyci89asEzm43tf5Dtg+tGeaMbOhfjoyvj7A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwezK/Mo39f75v4k9zcvhvb9u1rxNannfjzSK/9j3b
 Nn0JewCHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiZycxNrxS27p7xrYLGfN6
 ejfrf3m44/hjTfurDByLbdYuUon6/u/L8Sa3s8I5cVacUawTTRc6RzM23PBf5CX2xI0/8kbGxXP
 2ynPnWN/5WTf/+yeFGxnf7527uXt2RmqlhHaO4bKK4OnK1f6LAA==
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

The reset now runs from drm_mode_config_create_initial_state(), once
runtime PM has been enabled, so it can't use pm_runtime_set_active()
anymore and has to take a regular runtime PM reference instead.
However, the runtime resume programs the initial dispc configuration
and the interrupt enable registers, which the soft reset then wipes.
Program them again once the reset is done.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 55 ++++++++++++++-----------------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  1 +
 drivers/gpu/drm/tidss/tidss_kms.c   | 14 ++++++++++
 3 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 8c4d7e148eb0..e186c63ba5fb 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2853,49 +2853,40 @@ static int dispc_softreset(struct dispc_device *dispc)
 	}
 
 	return 0;
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
+	/*
+	 * The reset runs from drm_mode_config_create_initial_state(), so
+	 * after the driver has enabled runtime PM. As
+	 * pm_runtime_set_active() is only allowed while runtime PM is
+	 * disabled, rely on the regular runtime PM references to power
+	 * the device up for the reset instead.
+	 */
+	ret = tidss_runtime_get(tidss);
+	if (ret < 0)
 		return ret;
-	}
-
-	ret = clk_prepare_enable(dispc->fclk);
-	if (ret) {
-		dev_err(dev, "Failed to enable DSS fclk\n");
-		goto err_runtime_suspend;
-	}
 
 	ret = dispc_softreset(dispc);
 	if (ret)
-		goto err_clk_disable;
+		goto out;
 
-	clk_disable_unprepare(dispc->fclk);
-	ret = pm_runtime_set_suspended(dev);
-	if (ret) {
-		dev_err(dev, "Failed to set DSS PM to suspended\n");
-		return ret;
-	}
+	/*
+	 * The runtime PM resume above has programmed the initial
+	 * configuration and the interrupt enable registers, and the
+	 * soft reset just wiped them: program them again.
+	 */
+	dispc_initial_config(dispc);
+	tidss_irq_resume(tidss);
 
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
+out:
+	tidss_runtime_put(tidss);
 
 	return ret;
 }
 
 int dispc_init(struct tidss_device *tidss)
@@ -3001,13 +2992,9 @@ int dispc_init(struct tidss_device *tidss)
 	dev_dbg(dev, "DSS fclk %lu Hz\n", clk_get_rate(dispc->fclk));
 
 	of_property_read_u32(dispc->dev->of_node, "max-memory-bandwidth",
 			     &dispc->memory_bandwidth_limit);
 
-	r = dispc_init_hw(dispc);
-	if (r)
-		return r;
-
 	tidss->dispc = dispc;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index d07352f7b2bd..dcd4d3b18ef4 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -142,9 +142,10 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 		       struct drm_plane_state *state,
 		       u32 hw_videoport);
 void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
 const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);
 
+int dispc_reset_hw(struct dispc_device *dispc);
 int dispc_init(struct tidss_device *tidss);
 void dispc_remove(struct tidss_device *tidss);
 
 #endif
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index cf79051cb57c..fd7bb2c88931 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -8,10 +8,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
 #include "tidss_crtc.h"
 #include "tidss_dispc.h"
 #include "tidss_drv.h"
@@ -114,14 +115,27 @@ static int tidss_atomic_check(struct drm_device *ddev,
 	}
 
 	return 0;
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
 
 static const char * const tidss_internal_bridge_compatibles[] = {
 	"ti,j721e-dsi",
 };

-- 
2.56.1

