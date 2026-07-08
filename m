Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46704C44506
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B24910F273;
	Wed,  8 Jul 2026 19:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="khvMhWRl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19A610F263;
 Wed,  8 Jul 2026 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2bVYxJwoG4VcqNxuqsrCz9jXePbutmFBjzEkvnMrk2w=; b=khvMhWRlTJ7fOLB8AlckCwuj9u
 TYkQ4mY0FnUS9dNOD8Fr06bqDTmfPA0E3cqlVYM8xOuX7L4yY+/dK6FBNJcrWgn+0e9JI/80yWSPg
 D4B0yLDzSkzAOBEAD54NkCIr6STOck8yZ1n+hOJNEpefAell5dXqB4WQNbPOM0T7BDKqV0xPZUHiH
 si7lBoz48nlcVSVjmLawBzkup6Wd6o9Y9szCohed8aJUMiOtSk7TiHLBl0JBWPuHyS2uoMzJTi/a4
 owYlOJrX7r47HoGr/41NYUwV/XhUauou+K5ociP2BPsnszvnyTXjUZTCuortchUSNihRm6YtrOurz
 Z8ToMHTw==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYBT-00BtrH-BM; Wed, 08 Jul 2026 21:43:51 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Louis Chauvet <louis.chauvet@bootlin.com>,
 dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 02/19] drm/colorop: Allow parenting colorop to CRTC
Date: Wed,  8 Jul 2026 21:37:17 +0200
Message-ID: <20260708194343.2578387-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708194343.2578387-1-mwen@igalia.com>
References: <20260708194343.2578387-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

In order to allow for post-blend color pipelines, colorops need to be
assigned to a crtc rather than a plane. Add a crtc to the colorop
struct to enable this. Either the plane or the crtc will be set for any
given colorop depending on whether it is part of a pre- or post-blend
color pipeline.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic.c  |  6 +++---
 drivers/gpu/drm/drm_colorop.c | 25 +++++++++++++++++++++++++
 include/drm/drm_colorop.h     | 18 ++++++++++++++++--
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index c95e18393d32..c41759aedc6f 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -700,7 +700,7 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
 	if (colorop_state)
 		return colorop_state;
 
-	ret = drm_modeset_lock(&colorop->plane->mutex, state->acquire_ctx);
+	ret = drm_colorop_modeset_lock(colorop, state->acquire_ctx);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -2141,10 +2141,10 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
 
 	list_for_each_entry(colorop, &config->colorop_list, head) {
 		if (take_locks)
-			drm_modeset_lock(&colorop->plane->mutex, NULL);
+			drm_colorop_modeset_lock(colorop, NULL);
 		drm_atomic_colorop_print_state(p, colorop->state);
 		if (take_locks)
-			drm_modeset_unlock(&colorop->plane->mutex);
+			drm_colorop_modeset_unlock(colorop);
 	}
 
 	list_for_each_entry(plane, &config->plane_list, head) {
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 7eb9035ab013..422c70a40bed 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <drm/drm_crtc.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -780,3 +781,27 @@ void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_color
 	colorop->next = next;
 }
 EXPORT_SYMBOL(drm_colorop_set_next_property);
+
+int drm_colorop_modeset_lock(struct drm_colorop *colorop, struct drm_modeset_acquire_ctx *ctx)
+{
+	if (colorop->plane)
+		return drm_modeset_lock(&colorop->plane->mutex, ctx);
+
+	if (colorop->crtc)
+		return drm_modeset_lock(&colorop->crtc->mutex, ctx);
+
+	drm_err(colorop->dev, "Dangling colorop, it must be attached to a plane or a CRTC\n");
+	return -EINVAL;
+}
+EXPORT_SYMBOL(drm_colorop_modeset_lock);
+
+void drm_colorop_modeset_unlock(struct drm_colorop *colorop)
+{
+	if (colorop->plane)
+		drm_modeset_unlock(&colorop->plane->mutex);
+	else if (colorop->crtc)
+		drm_modeset_unlock(&colorop->crtc->mutex);
+	else
+		drm_err(colorop->dev, "Dangling colorop, it must be attached to a plane or a CRTC\n");
+}
+EXPORT_SYMBOL(drm_colorop_modeset_unlock);
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index a8af7f1025f5..a165a887c05d 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -29,6 +29,7 @@
 
 #include <drm/drm_mode_object.h>
 #include <drm/drm_mode.h>
+#include <drm/drm_modeset_lock.h>
 #include <drm/drm_property.h>
 
 /* DRM colorop flags */
@@ -391,11 +392,21 @@ struct drm_colorop {
 	/**
 	 * @plane:
 	 *
-	 * The plane on which the colorop sits. A drm_colorop is always unique
-	 * to a plane.
+	 * The plane on which the colorop sits if it is a pre-blend colorop.
+	 * In this case it is unique to the plane.
+	 * NOTE: plane and crtc are mutually exclusive.
 	 */
 	struct drm_plane *plane;
 
+	/**
+	 * @crtc:
+	 *
+	 * The CRTC on which the colorop sits if it is a post-blend colorop.
+	 * In this case it is unique to the CRTC.
+	 * NOTE: plane and crtc are mutually exclusive.
+	 */
+	struct drm_crtc *crtc;
+
 	/**
 	 * @state:
 	 *
@@ -636,4 +647,7 @@ const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix
 
 void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
 
+int drm_colorop_modeset_lock(struct drm_colorop *colorop, struct drm_modeset_acquire_ctx *ctx);
+void drm_colorop_modeset_unlock(struct drm_colorop *colorop);
+ 
 #endif /* __DRM_COLOROP_H__ */
-- 
2.53.0

