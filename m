Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40905C43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EEF10F632;
	Fri, 26 Jun 2026 13:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PZAkiack";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8E510F62E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:57:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4C27408A1;
 Fri, 26 Jun 2026 13:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253B31F000E9;
 Fri, 26 Jun 2026 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782482278;
 bh=xJ9YLAOi6cvhXhZjm2sovtV7w90aXE2ZF+4WAZnfUeU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PZAkiackJuSx+ZvqGfK3SUf7h19RNQHC5p2EiF29Gnxp8Mmkx1NmlwGwneHrHdLYK
 EM9xvLu7urxvNFerYd3M7dpxCH5NT9RSOYwYFB6SWH/r/tuN0ACyqO4T9Fhp7+l202
 pzqr0hyHsXnHmCSt+kMjjirEm6pB2sXJSb7WZwZNEzCK8lSyes8yh+vuT5Xf6PaBid
 un+u46xOl+3foY18Z+7BmSP1U7ATf6AUVMKsiKEIsTr/a6YAZZddZMflMnwzYY90xo
 MIn9/438tdMzm7NBj09LC4zEmYqMIMKRiIFLz9qddCzzUr5nmr3SerGOS8M1SpOSDh
 Odz94lkskP/fQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 26 Jun 2026 15:57:12 +0200
Subject: [PATCH v3 11/30] drm/atomic_sro: Create kernel parameter to force
 or disable readout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-drm-state-readout-v3-11-d5825e3299a8@kernel.org>
References: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
In-Reply-To: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2924; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jIqrg8VEoNDWgJogPGgR92xvAgyoJDE9udAbdeWe5Ko=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl2raYOtn3b1kyOOCsSm7/HTNpV++GXbbGzXzuHPr/CW
 LPjmlh/x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI1yvGhqUavwpjXvo0i4S1
 c50+cK1428HoI1c15rF9crRfE2axNtHR9uLm+PKiq/eOls3vC6jUZWzo15spP98xIOr9s7RP6xb
 xidbOOLh+UXOJVF9Ifmp6TFPaRe/IMyVXJyRrO8/8zb58UR4A
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

The hardware state readout is useful, but might need to be disabled
in case of bugs, or its checks relaxed during development when not
all hooks are implemented yet.

Add a module parameter to control the readout behavior: it can be
disabled entirely, or the checks for missing compare or readout hooks
can be skipped independently.

Suggested-by: Simona Vetter <simona@ffwll.ch>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_sro.c | 36 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic_sro.h     |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 177b97d451f5..28beba4de0ce 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -11,10 +11,46 @@
 #include <linux/module.h>
 
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
 
+enum drm_atomic_readout_status {
+	DRM_ATOMIC_READOUT_DISABLED = 0,
+	DRM_ATOMIC_READOUT_ENABLED,
+	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
+	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
+};
+
+static unsigned int atomic_readout = DRM_ATOMIC_READOUT_ENABLED;
+module_param_unsafe(atomic_readout, uint, 0400);
+MODULE_PARM_DESC(atomic_readout,
+		 "Enable Hardware State Readout (0 = disabled, 1 = enabled, 2 = ignore missing compares, 3 = ignore missing readouts and compares, default = 1)");
+
+/**
+ * drm_atomic_sro_device_can_readout - check if a device supports hardware state readout
+ * @dev: DRM device to check
+ *
+ * Verifies that the device is an atomic driver, that readout is
+ * enabled, and that all KMS objects implement the relevant hooks.
+ *
+ * RETURNS:
+ *
+ * True if the device supports full hardware state readout, false
+ * otherwise.
+ */
+bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
+{
+	if (!drm_drv_uses_atomic_modeset(dev))
+		return false;
+
+	if (atomic_readout == DRM_ATOMIC_READOUT_DISABLED)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
+
 struct __drm_atomic_sro_plane {
 	struct drm_plane *ptr;
 	struct drm_plane_state *state;
 };
 
diff --git a/include/drm/drm_atomic_sro.h b/include/drm/drm_atomic_sro.h
index 5a9333a05796..6e5262384c71 100644
--- a/include/drm/drm_atomic_sro.h
+++ b/include/drm/drm_atomic_sro.h
@@ -13,10 +13,12 @@ struct drm_plane;
 struct drm_plane_state;
 struct drm_printer;
 struct drm_private_obj;
 struct drm_private_state;
 
+bool drm_atomic_sro_device_can_readout(struct drm_device *dev);
+
 struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_device *dev);
 void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state);
 void drm_atomic_sro_state_print(const struct drm_atomic_sro_state *state,
 				struct drm_printer *p);
 

-- 
2.54.0

