Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEBACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A9710EF65;
	Thu, 15 Oct 2026 15:10:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2EB810F080
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 357A46022A;
 Thu, 15 Oct 2026 15:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F211F000C4;
 Thu, 15 Oct 2026 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077045;
 bh=M6KibURDjAn0MWxQ7KPGr5M5yEXHIS2Z4yW1vwe6OLU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j6NfzKYlgs8WfxbbpPm5o7C5cEePKLcjl+b8LshqsZH+uLiDESlJUUL+TDwEAd7yx
 sXjqlMRW7+TvfQulQ6mr2pEmrOT+gz6rDgONlS96ZQlQ9z5evqpYlM7H3K5icJQO5K
 Wn1/kpGTbvHRzRt9HE3BzuRoKIyry/GFZZmzZasdWLpPQ+2oYUpomCz760677J6fAz
 I023N16PSYCBxzm5X4RdEBNGsJfxcL6Rha3gU/wUpjiHeJqbQ5TtQEGFP2fE2GmYue
 QyNLzMj66BAAD2UbhWYxaJqTrqheCbdt3hLua6AP7XLSUiLvWgW/BTyQ7o4YkSOS4z
 VnCLUcAYLfFNw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:17 +0200
Subject: [PATCH v6 25/28] drm/tidss: Implement hw_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-25-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3599; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UyaJzTcI4M+Qap8OHSTY0z+SRcNc3EW9F6IkLnjnqKA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3kz9Kd7PvUTN/fLlPhWGL3rlXzS9e39NUOXc1tDh8
 lG7o668YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEwpaxzn5pWmZE0epCM9+N
 9i8e/jrAGKYVW7L78uR7a7RNDn76/NYz9avzd3u7xPfMn71iX0o8ZawvUJH+0rc7mJ3pV7bH9YP
 Gd8ud5f5N2Xwg7sOS9GbTO737rt8X7D5o+O+dS0Cix5T5s9cDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The dispc hardware needs to be put in a known-good state when the
driver starts. This was previously done unconditionally during
dispc_init(), but it should only be performed on the reset path when
implementing state readout.

Rename dispc_init_hw() to dispc_reset_hw(), export it, and remove
the call from dispc_init(). Implement &drm_mode_config_funcs.hw_reset
through tidss_hw_reset() which performs the dispc soft reset and then
calls drm_mode_config_helper_hw_reset() to reset the rest of the
objects.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c |  6 +-----
 drivers/gpu/drm/tidss/tidss_dispc.h |  1 +
 drivers/gpu/drm/tidss/tidss_kms.c   | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index a19b74b0ca30..fdd3b166c118 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2907,11 +2907,11 @@ static int dispc_softreset(struct dispc_device *dispc)
 	}
 
 	return 0;
 }
 
-static int dispc_init_hw(struct dispc_device *dispc)
+int dispc_reset_hw(struct dispc_device *dispc)
 {
 	struct device *dev = dispc->dev;
 	int ret;
 
 	ret = pm_runtime_set_active(dev);
@@ -3057,13 +3057,9 @@ int dispc_init(struct tidss_device *tidss)
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
index 2183254f1ab7..e51a2088b40c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -143,9 +143,10 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 		       struct drm_plane_state *state,
 		       u32 hw_videoport);
 void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
 const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);
 
+int dispc_reset_hw(struct dispc_device *dispc);
 int dispc_init(struct tidss_device *tidss);
 void dispc_remove(struct tidss_device *tidss);
 
 #endif
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index 70c14c3be10d..3b97c08c4f71 100644
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
 
 static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 {
 	struct device *dev = tidss->dev;

-- 
2.55.0

