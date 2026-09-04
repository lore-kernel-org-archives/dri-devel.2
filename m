Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592C3C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8D310F996;
	Fri,  4 Sep 2026 09:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WNWZoLVQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 950C710F996
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:07:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3A3560211;
 Fri,  4 Sep 2026 09:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CAB1F00A3D;
 Fri,  4 Sep 2026 09:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512856;
 bh=uRaQftbgEP0PttIpvfcoOGPaowkp63FAMZbBvwuXN5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WNWZoLVQNL4c0fPg6sOx0bpUy9DO3IIKgubKobetQF58YcL9ULGt4lqHUcBR0wwyf
 nT4gb5452MrLVvIHfqsd8Imh311f7A/F54k277rsnLBFb6ijBy7mFf5KLEYduVocK/
 Dges9JouEz8azcV8wb0B+6wDa7G7eRtzjLPT3YT1FfZc5agaRKEC0Zl8WCNPy6PNRB
 QYR060VEqHbHn34Bb9C8XUefBbytm/27EKVlLpxptymJFewazV7M/mWuSxaZo5hbuI
 Ya1C/QRc0v2M8DlMMeXaFfFL10y5eejnfR1BYfE5aiUabkxfuk42E76opksGbsOGtJ
 oq03vf4DyVZTQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:19 +0200
Subject: [PATCH v3 01/13] drm/crtc: Introduce hw_reset helper hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-1-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3419; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+qvhLdgGe34r266GT6meSYYKIU9OKp5n91KfZSbBzEU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzurzVL2wx/rS/Uqk3+sit75U8UT6bW41f5tw1WOg1i
 2GREp9Ux1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI5HzG+oKQembXwpWXJeZ9
 +vRB19g8KkJD9p5z7+WnaT/Crj977fBX+dBS6ZXmYr7JhdtmtAU9ZawzlmRLZ9/70HleXSKr17T
 sr7vOfFt6ZnpcUurV5xNbrq0vTPh+cc01Ka0C5YoDxq4rw5YAAA==
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

The CRTC reset hook conflates initial software state allocation with
hardware reset. The atomic_create_state hook addresses the software
state side, but drivers may still need to reset hardware to a known good
state during drm_mode_config_reset(), for example during suspend/resume.

Separating hardware reset from state allocation is also useful for the
pending atomic state readout and userspace atomic reset flag series,
which need to create pristine software state without affecting the
hardware.

Introduce a hw_reset hook in struct drm_crtc_helper_funcs that only
resets the hardware, without touching the software state at all. Call it
from drm_mode_config_crtc_reset_with_create_state() after the state has
been successfully created.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c        | 13 ++++++++++++-
 include/drm/drm_modeset_helper_vtables.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 366f6d821242..f95cd9695b43 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -28,10 +28,11 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_colorop.h>
 #include <linux/dma-resv.h>
 
 #include "drm_crtc_internal.h"
@@ -228,16 +229,26 @@ static int drm_mode_config_crtc_create_state(struct drm_crtc *crtc)
 	return 0;
 }
 
 static int drm_mode_config_crtc_reset_with_create_state(struct drm_crtc *crtc)
 {
+	const struct drm_crtc_helper_funcs *helper_funcs = crtc->helper_private;
+	int ret;
+
 	if (crtc->state) {
 		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
 		crtc->state = NULL;
 	}
 
-	return drm_mode_config_crtc_create_state(crtc);
+	ret = drm_mode_config_crtc_create_state(crtc);
+	if (ret)
+		return ret;
+
+	if (helper_funcs && helper_funcs->hw_reset)
+		helper_funcs->hw_reset(crtc);
+
+	return 0;
 }
 
 static int drm_mode_config_connector_create_state(struct drm_connector *connector)
 {
 	struct drm_connector_state *conn_state;
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index ca6268945c28..4965356a6314 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -279,10 +279,24 @@ struct drm_crtc_helper_funcs {
 	 * drivers still using legacy CRTC helpers, which is different from the
 	 * rules under atomic.
 	 */
 	void (*disable)(struct drm_crtc *crtc);
 
+	/**
+	 * @hw_reset:
+	 *
+	 * Optional hook for CRTC hardware reset.
+	 *
+	 * Unlike @drm_crtc_funcs.reset, which both resets hardware and
+	 * creates new software state, this hook only resets the
+	 * hardware to a known good state without touching the software
+	 * state at all.
+	 *
+	 * This hook is called by drm_mode_config_reset().
+	 */
+	void (*hw_reset)(struct drm_crtc *crtc);
+
 	/**
 	 * @atomic_check:
 	 *
 	 * Drivers should check plane-update related CRTC constraints in this
 	 * hook. They can also check mode related limitations but need to be

-- 
2.55.0

