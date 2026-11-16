Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556B606A334
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f4JXUQVI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D0F10EEA6;
	Mon, 16 Nov 2026 09:13:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D2510EE93;
 Mon, 16 Nov 2026 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794820429; x=1826356429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6RcgTJRMkf6knyitWUlwWvr0eo1SGio0/PgROTWQTvY=;
 b=f4JXUQVI7gVezUeQqJPUCql+BDGX948l1e6f7kBScr45Z7G1zzHakfY9
 v0mEFvxh8Lpj3dFk8QjxTopBfHKt+Kxb5864bCDI18mtf1CvEavvQgfdx
 8JudFJCuCrhnSAKQBrR683IuzH38BtR0xVHKhVbe1bllrIDOB4bovdNFc
 KYNmPpvQeHQ/O39Wx7KUwkyG8Ta8nEmKbhbrW4YMH9ssI9raxxLuiYs02
 ZSjgvYn25enXGuLKw8pZSN2cYPmTnvW8LONw2Mq0GVUY9b5cxgM3BvQsZ
 34UfnfpSrW7ic+J1/HPKKBOdvC7bo5A4dEWwFST6Si00DOMJVHpn+UwV5 w==;
X-CSE-ConnectionGUID: RfRy1rh8RNi4+boOo3F/ug==
X-CSE-MsgGUID: CIQVBZdBS/e3KiXG4qR1FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3458240"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3458240"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:13:47 -0800
X-CSE-ConnectionGUID: bvoRwiFQRNi3Az4Cm0njaA==
X-CSE-MsgGUID: pGwRFgaZQoqDY1QJ87JxXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9692160"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:13:40 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Erwin Springer <aot.lerwin@gmail.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Christopher Snowhill <chris@kode54.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dharma Balasubiramani <dharma.b@microchip.com>,
 Dmitry Baryshkov <lumag@kernel.org>, freedreno@lists.freedesktop.org,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jianmin Lv <lvjianmin@loongson.cn>, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Maxime Ripard <mripard@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 nouveau@lists.freedesktop.org, Qianhai Wu <wuqianhai@loongson.cn>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Simon Ser <contact@emersion.fr>, wayland-devel@lists.freedesktop.org,
 Xaver Hugl <xaver.hugl@kde.org>, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 12/12] drm/atomic/uapi: Extract {connector, crtc,
 plane}_async_flip_check()
Date: Mon, 16 Nov 2026 11:11:30 +0200
Message-ID: <20261116091130.13950-13-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
References: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Reduce the clutter in drm_atomic_set_property() by
extracting the async flip related checks to
connector,crtc,plane}_async_flip_check().

Cc: amd-gfx@lists.freedesktop.org
Cc: André Almeida <andrealmeid@igalia.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Christopher Snowhill <chris@kode54.net>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: freedreno@lists.freedesktop.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: nouveau@lists.freedesktop.org
Cc: Qianhai Wu <wuqianhai@loongson.cn>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: wayland-devel@lists.freedesktop.org
Cc: Xaver Hugl <xaver.hugl@kde.org>
Cc: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 215 +++++++++++++++++-------------
 1 file changed, 124 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 87181aba1451..65e1be6c4ad5 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1194,6 +1194,124 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_commit *state,
 	return ret;
 }
 
+static int connector_async_flip_check(struct drm_atomic_commit *state,
+				      struct drm_connector *connector,
+				      struct drm_property *prop,
+				      u64 prop_value, bool *is_noop)
+{
+	const struct drm_connector_state *current_connector_state;
+	u64 old_val = 0;
+	int ret;
+
+	current_connector_state =
+		__drm_atomic_get_current_connector_state(state, connector);
+	if (IS_ERR(current_connector_state))
+		return PTR_ERR(current_connector_state);
+
+	ret = drm_atomic_connector_get_property(connector, current_connector_state,
+						prop, &old_val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Note that for WRITEBACK_FB_ID and WRITEBACK_OUT_FENCE_PTR
+	 * the old value will always be 0. So any commit that sets either
+	 * property to any other value will not be considered a no-op.
+	 */
+	if (old_val != prop_value) {
+		drm_dbg_atomic(prop->dev,
+			       "[CONNECTOR:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
+			       connector->base.id, connector->name,
+			       prop->base.id, prop->name);
+		return -EINVAL;
+	}
+
+	*is_noop = old_val == prop_value;
+
+	return 0;
+}
+
+static int crtc_async_flip_check(struct drm_atomic_commit *state,
+				 struct drm_crtc *crtc,
+				 struct drm_property *prop,
+				 u64 prop_value, bool *is_noop)
+{
+	const struct drm_crtc_state *current_crtc_state;
+	u64 old_val = 0;
+	int ret;
+
+	current_crtc_state =
+		__drm_atomic_get_current_crtc_state(state, crtc);
+	if (IS_ERR(current_crtc_state))
+		return PTR_ERR(current_crtc_state);
+
+	ret = drm_atomic_crtc_get_property(crtc, current_crtc_state,
+					   prop, &old_val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Note that for OUT_FENCE_PTR the old value will always be 0.
+	 * So any commit that sets the property to any other value
+	 * will not be considered a no-op.
+	 */
+	if (old_val != prop_value) {
+		drm_dbg_atomic(prop->dev,
+			       "[CRTC:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
+			       crtc->base.id, crtc->name,
+			       prop->base.id, prop->name);
+		return -EINVAL;
+	}
+
+	*is_noop = old_val == prop_value;
+
+	return 0;
+}
+
+static int plane_async_flip_check(struct drm_atomic_commit *state,
+				  struct drm_plane *plane,
+				  struct drm_property *prop,
+				  u64 prop_value, bool *is_noop)
+{
+	struct drm_device *dev = plane->dev;
+	struct drm_mode_config *config = &dev->mode_config;
+	const struct drm_plane_state *current_plane_state;
+	u64 old_val = 0;
+	int ret;
+
+	current_plane_state =
+		__drm_atomic_get_current_plane_state(state, plane);
+	if (IS_ERR(current_plane_state))
+		return PTR_ERR(current_plane_state);
+
+	ret = drm_atomic_plane_get_property(plane, current_plane_state,
+					    prop, &old_val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Fail everything that isn't no-op or a pure flip.
+	 *
+	 * Note that for IN_FENCE_FD the old value will always be -1.
+	 * So any commit that sets the property to any other value
+	 * will not be considered a no-op.
+	 */
+	if (old_val != prop_value &&
+	    prop != config->prop_fb_id &&
+	    prop != config->prop_in_fence_fd &&
+	    prop != config->prop_fb_damage_clips) {
+		drm_dbg_atomic(prop->dev,
+			       "[PLANE:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
+			       plane->base.id, plane->name,
+			       prop->base.id, prop->name);
+		return -EINVAL;
+	}
+
+	*is_noop = old_val == prop_value;
+
+	return 0;
+}
+
 int drm_atomic_set_property(struct drm_atomic_commit *state,
 			    struct drm_file *file_priv,
 			    struct drm_mode_object *obj,
@@ -1202,7 +1320,6 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 			    bool async_flip)
 {
 	struct drm_mode_object *ref;
-	u64 old_val;
 	int ret;
 
 	if (!drm_property_change_valid_get(prop, prop_value, &ref))
@@ -1215,36 +1332,10 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 		bool is_noop = false;
 
 		if (async_flip) {
-			const struct drm_connector_state *current_connector_state;
-
-			current_connector_state =
-				__drm_atomic_get_current_connector_state(state, connector);
-			if (IS_ERR(current_connector_state)) {
-				ret = PTR_ERR(current_connector_state);
-				break;
-			}
-
-			ret = drm_atomic_connector_get_property(connector, current_connector_state,
-								prop, &old_val);
+			ret = connector_async_flip_check(state, connector,
+							 prop, prop_value, &is_noop);
 			if (ret)
 				break;
-
-			/*
-			 * Note that for WRITEBACK_FB_ID and WRITEBACK_OUT_FENCE_PTR
-			 * the old value will always be 0. So any commit that sets either
-			 * property to any other value will not be considered a no-op.
-			 */
-			if (old_val != prop_value) {
-				drm_dbg_atomic(prop->dev,
-					       "[CONNECTOR:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
-					       connector->base.id, connector->name,
-					       prop->base.id, prop->name);
-				ret = -EINVAL;
-				break;
-			}
-
-			if (old_val == prop_value)
-				is_noop = true;
 		}
 
 		/* No-op connector property changes can be completely skipped */
@@ -1270,36 +1361,10 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 		bool is_noop = false;
 
 		if (async_flip) {
-			const struct drm_crtc_state *current_crtc_state;
-
-			current_crtc_state =
-				__drm_atomic_get_current_crtc_state(state, crtc);
-			if (IS_ERR(current_crtc_state)) {
-				ret = PTR_ERR(current_crtc_state);
-				break;
-			}
-
-			ret = drm_atomic_crtc_get_property(crtc, current_crtc_state,
-							   prop, &old_val);
+			ret = crtc_async_flip_check(state, crtc,
+						    prop, prop_value, &is_noop);
 			if (ret)
 				break;
-
-			/*
-			 * Note that for OUT_FENCE_PTR the old value will always be 0.
-			 * So any commit that sets the property to any other value
-			 * will not be considered a no-op.
-			 */
-			if (old_val != prop_value) {
-				drm_dbg_atomic(prop->dev,
-					       "[CRTC:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
-					       crtc->base.id, crtc->name,
-					       prop->base.id, prop->name);
-				ret = -EINVAL;
-				break;
-			}
-
-			if (old_val == prop_value)
-				is_noop = true;
 		}
 
 		/*
@@ -1324,46 +1389,14 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 	case DRM_MODE_OBJECT_PLANE: {
 		struct drm_plane *plane = obj_to_plane(obj);
 		struct drm_plane_state *plane_state;
-		struct drm_mode_config *config = &plane->dev->mode_config;
 		const struct drm_plane_helper_funcs *plane_funcs = plane->helper_private;
 		bool is_noop = false;
 
 		if (async_flip) {
-			const struct drm_plane_state *current_plane_state;
-
-			current_plane_state =
-				__drm_atomic_get_current_plane_state(state, plane);
-			if (IS_ERR(current_plane_state)) {
-				ret = PTR_ERR(current_plane_state);
-				break;
-			}
-
-			ret = drm_atomic_plane_get_property(plane, current_plane_state,
-							    prop, &old_val);
+			ret = plane_async_flip_check(state, plane,
+						     prop, prop_value, &is_noop);
 			if (ret)
 				break;
-
-			/*
-			 * Fail everything that isn't no-op or a pure flip.
-			 *
-			 * Note that for IN_FENCE_FD the old value will always be -1.
-			 * So any commit that sets the property to any other value
-			 * will not be considered a no-op.
-			 */
-			if (old_val != prop_value &&
-			    prop != config->prop_fb_id &&
-			    prop != config->prop_in_fence_fd &&
-			    prop != config->prop_fb_damage_clips) {
-				drm_dbg_atomic(prop->dev,
-					       "[PLANE:%d:%s][PROP:%d:%s] Unsupported property change during async flip\n",
-					       plane->base.id, plane->name,
-					       prop->base.id, prop->name);
-				ret = -EINVAL;
-				break;
-			}
-
-			if (old_val == prop_value)
-				is_noop = true;
 		}
 
 		/* No-op plane property changes can be fully skipped */
-- 
2.56.0

