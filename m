Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65E2C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4EA210E948;
	Mon, 31 Aug 2026 15:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RIabVrNW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8125810E948
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:34:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AF5A601FD;
 Mon, 31 Aug 2026 15:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BBC1F000E9;
 Mon, 31 Aug 2026 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190473;
 bh=EI6FI471ih0Gf67L6RMf41DXIZrk38tyP7yAMmlVF/U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RIabVrNWIu3AqSLL6fM9rvbKCcOfkVKoN0NQg70nafPABWafGcqb89HRp9ZGHlTHK
 i4Yh12PYEIRbSLz2pdO1X4fW0nhqFpxGznq13ceRA9TFuVaLbVI1sLnS0pKemTrbFT
 Z89Xm2TeEMJZm8Twly4E5DRtViJg7qEWocqVmHmQufQ3sLiWuOW3cERVgh/Dn+pwH3
 7a6PkrW7ewVV4Pt3JUv9faG2ycYEjXA9qaEpIJ3oUxqFJncHVslwCa02YB2Q9w5BIl
 3waY+MHKewpJntjlYXlQKXvR12xMfTOsejtZj50jIKw3JXk4XM9VOP1+KoEzDR8mg/
 azLQV6MYUc0iQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 17:34:14 +0200
Subject: [PATCH v2 01/13] drm/crtc: Introduce hw_reset helper hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-crtc-reset-v2-1-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3343; i=mripard@kernel.org;
 h=from:subject:message-id; bh=++5t+RRp6os8FNAEVlC7DGVm5CTycfHRe9U9bwOPbOU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5/1+I++4u+KdesohoVctt/M9L6468/6lc6GH5eYNZ
 QIz7xz41DGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmIqrI2DA5LE7v9tZDHgUr
 o7pVeU9F1Dxdw3yUYd8b7we2d7mWuMvtY1oYVTnniHmf3hWfjddOljA2bH1h89f07p70C4UXzsq
 XGR+/cv5ioqXC49SUXW+kFPnKWyQ7b51ImHl04fkkzZV52fGpAA==
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c        | 13 ++++++++++++-
 include/drm/drm_modeset_helper_vtables.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 366f6d821242..bb2efc274323 100644
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
+	const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
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
+	if (crtc_funcs->hw_reset)
+		crtc_funcs->hw_reset(crtc);
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

