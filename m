Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D643606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kg6uPett
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA9F10EE92;
	Mon, 16 Nov 2026 09:13:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC4910E9DC;
 Mon, 16 Nov 2026 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794820417; x=1826356417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R2jtCYJzpoIMcias7P6pJiZdvsxl+IKsmM3AiTZ415c=;
 b=kg6uPettSnNMMUv1qAVAtlGVTrLZa/V5s6B93wq/6vi6qNXMedZfP/Qb
 5JEIBFo0rCIcOylIG4Atz5oezL1+hJyIPTS1mi8fXw4WvIfEEz6hYKdvs
 RCv+wWdlKBVFtPR/xgH+LTm5NC6tkTHrD2EhkH9B5aTpbv+82wFFoTI+V
 Zw2V1xQ/nUmPVNPD3OSdZZ4A+JCw05ZpnWzJ6T3ISNnym6nBr19EW38+a
 TW0XxE5q/0Q+kHOVz86ZKIXnepLnPrQSdIE/8DvAPsGeh9zha9Bi0YBvM
 HobkR0drWoiE/xyU+BJZB3PUSCZ43q3O8+yje9cQfzG+IUg91JgEWIbui A==;
X-CSE-ConnectionGUID: +Q+sri+uS8GvsFlhjYewlg==
X-CSE-MsgGUID: wF09Cns9TOq8EEBv+KAOsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3579247"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3579247"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:13:36 -0800
X-CSE-ConnectionGUID: LJd/t5j7RBuvfs/0Ms9siA==
X-CSE-MsgGUID: hHJSOhWCSuqX5dqc8w6vYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; d="scan'208";a="10032418"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:13:30 -0800
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
Subject: [PATCH 11/12] drm/atomic/uapi: Make async flips a bit more palatable
 through atomic
Date: Mon, 16 Nov 2026 11:11:29 +0200
Message-ID: <20261116091130.13950-12-ville.syrjala@linux.intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Userspace developers are supremely lazy, and apparently not willing
to spend any effort on trimming out no-op property changes from
their atomic commits.

For normal atomic commits it just means that the kernel and/or
hardware will need to do a bit more work to deal with the redundant
updates. Eg. on i915/xe we don't bother doing an exhaustive comparison
of all the state to filter out no-ops, and thus we end up feeding
most of it to the hardware. Apart from wasted power (not an
insignificant amount probably in some cases) that is kinda fine.

For normal atomic commit the rule is also that all side effects
of the commit must be observed. For example, if the plane's
framebuffer appears on the property list, we have to make sure
that any shadow copies of the framebuffer contents (PSR,
i915/xe FBC, etc.) are updated (even if the FB_ID stays the
same) in case there was any front buffer rendering done to
the buffer.

But for async flips the uapi has completely separate rules,
essentially saying that a plane that is part of the atomic
commit can be completely ignored by the driver if none its
properties are changing values. Ie. side effects need not
be observed.

The current scheme can sort of work without any extra state
comparisons, but only if every plane on the device supports
async flips. That is generally not the case. Eg. on i915/xe
we only support async flips on the primary plane. Later
hardware generations do support async flips on sprite planes
as well, but we've not hooked that up yet. And cursor planes
don't support async flips on any hardware generation.

Currently the only way to implement the no-op checks is by
having the driver perform that exhaustive comparison of the
full state. That would be tedious and supremely fragile as
it would be very easy to forget to update those checks when
adding a new piece of state.

Let's avoid that whole mess by doing the no-op filtering
directly in the atomic ioctl handler. It's pretty easy on
this level as all we really have to care about is the actual
uapi property values, not how they get stored in the state
objects (since we reuse the normal drm_atomic_get_property()
for that), and derived state is not a factor on this level
at all. The code is in fact mostly already there, just for
input validation purposes. It just needs to be extended
slightly to completely filter out the no-ops.

This way we can completely skip adding planes and connectors
to the state if all they have is no-op property changes. The
driver never even sees the no-op objects, and thus can't think
it needs to reject the commit due to their presence. CRTCs
we have to add even if none of their properties change state.
This is because the uapi rules say that any CRTC named in the
commit (either directly, or indirectly via a plane/connector)
must actually perform the commit, and send back the completion
event. For that reason we must also always add the
plane's/connector's current crtc to the state in the new
bespoke __drm_atomic_get_current_*_state() helpers.

TODO: igt tests for atomic+async uapi don't really exist :(

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
 drivers/gpu/drm/drm_atomic.c        |  97 +++++++++++++++++++
 drivers/gpu/drm/drm_atomic_uapi.c   | 139 ++++++++++++++++++++--------
 drivers/gpu/drm/drm_crtc_internal.h |   9 ++
 3 files changed, 205 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 81591173265d..176520aec21c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -497,6 +497,28 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
 }
 EXPORT_SYMBOL(drm_atomic_get_crtc_state);
 
+const struct drm_crtc_state *
+__drm_atomic_get_current_crtc_state(struct drm_atomic_commit *state,
+				    struct drm_crtc *crtc)
+{
+	const struct drm_crtc_state *crtc_state;
+	int ret;
+
+	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, state->checked);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	if (crtc_state)
+		return crtc_state;
+
+	ret = drm_modeset_lock(&crtc->mutex, state->acquire_ctx);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return crtc->state;
+}
+/* Do not export! Only meant for drm_atomic_set_property(). */
+
 static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
 				 const struct drm_crtc_state *new_crtc_state)
 {
@@ -704,6 +726,43 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 }
 EXPORT_SYMBOL(drm_atomic_get_plane_state);
 
+const struct drm_plane_state *
+__drm_atomic_get_current_plane_state(struct drm_atomic_commit *state,
+				     struct drm_plane *plane)
+{
+	const struct drm_plane_state *plane_state;
+	int ret;
+
+	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, state->checked);
+
+	plane_state = drm_atomic_get_new_plane_state(state, plane);
+	if (plane_state)
+		return plane_state;
+
+	ret = drm_modeset_lock(&plane->mutex, state->acquire_ctx);
+	if (ret)
+		return ERR_PTR(ret);
+
+	plane_state = plane->state;
+
+	/*
+	 * The plane's current crtc must always be added
+	 * to the commit for completion/event purposes.
+	 */
+	if (plane_state->crtc) {
+		struct drm_crtc_state *crtc_state;
+
+		crtc_state = drm_atomic_get_crtc_state(state,
+						       plane_state->crtc);
+		if (IS_ERR(crtc_state))
+			return ERR_CAST(crtc_state);
+	}
+
+	return plane_state;
+}
+/* Do not export! Only meant for drm_atomic_set_property(). */
+
 static void drm_atomic_commit_set_colorop_state(struct drm_atomic_commit *commit,
 						struct drm_colorop *colorop,
 						struct drm_colorop_state *colorop_state)
@@ -1496,6 +1555,44 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 }
 EXPORT_SYMBOL(drm_atomic_get_connector_state);
 
+const struct drm_connector_state *
+__drm_atomic_get_current_connector_state(struct drm_atomic_commit *state,
+					 struct drm_connector *connector)
+{
+	struct drm_mode_config *config = &connector->dev->mode_config;
+	const struct drm_connector_state *connector_state;
+	int ret;
+
+	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, state->checked);
+
+	connector_state = drm_atomic_get_new_connector_state(state, connector);
+	if (connector_state)
+		return connector_state;
+
+	ret = drm_modeset_lock(&config->connection_mutex, state->acquire_ctx);
+	if (ret)
+		return ERR_PTR(ret);
+
+	connector_state = connector->state;
+
+	/*
+	 * The connectors's current crtc must always be added
+	 * to the commit for completion/event purposes.
+	 */
+	if (connector_state->crtc) {
+		struct drm_crtc_state *crtc_state;
+
+		crtc_state = drm_atomic_get_crtc_state(state,
+						       connector_state->crtc);
+		if (IS_ERR(crtc_state))
+			return ERR_CAST(crtc_state);
+	}
+
+	return connector_state;
+}
+/* Do not export! Only meant for drm_atomic_set_property(). */
+
 static void drm_atomic_connector_print_state(struct drm_printer *p,
 		const struct drm_connector_state *state)
 {
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 7517950d2e51..87181aba1451 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1212,15 +1212,19 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 	case DRM_MODE_OBJECT_CONNECTOR: {
 		struct drm_connector *connector = obj_to_connector(obj);
 		struct drm_connector_state *connector_state;
-
-		connector_state = drm_atomic_get_connector_state(state, connector);
-		if (IS_ERR(connector_state)) {
-			ret = PTR_ERR(connector_state);
-			break;
-		}
+		bool is_noop = false;
 
 		if (async_flip) {
-			ret = drm_atomic_connector_get_property(connector, connector_state,
+			const struct drm_connector_state *current_connector_state;
+
+			current_connector_state =
+				__drm_atomic_get_current_connector_state(state, connector);
+			if (IS_ERR(current_connector_state)) {
+				ret = PTR_ERR(current_connector_state);
+				break;
+			}
+
+			ret = drm_atomic_connector_get_property(connector, current_connector_state,
 								prop, &old_val);
 			if (ret)
 				break;
@@ -1238,6 +1242,21 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 				ret = -EINVAL;
 				break;
 			}
+
+			if (old_val == prop_value)
+				is_noop = true;
+		}
+
+		/* No-op connector property changes can be completely skipped */
+		if (is_noop) {
+			ret = 0;
+			break;
+		}
+
+		connector_state = drm_atomic_get_connector_state(state, connector);
+		if (IS_ERR(connector_state)) {
+			ret = PTR_ERR(connector_state);
+			break;
 		}
 
 		ret = drm_atomic_connector_set_property(connector,
@@ -1248,15 +1267,19 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 	case DRM_MODE_OBJECT_CRTC: {
 		struct drm_crtc *crtc = obj_to_crtc(obj);
 		struct drm_crtc_state *crtc_state;
-
-		crtc_state = drm_atomic_get_crtc_state(state, crtc);
-		if (IS_ERR(crtc_state)) {
-			ret = PTR_ERR(crtc_state);
-			break;
-		}
+		bool is_noop = false;
 
 		if (async_flip) {
-			ret = drm_atomic_crtc_get_property(crtc, crtc_state,
+			const struct drm_crtc_state *current_crtc_state;
+
+			current_crtc_state =
+				__drm_atomic_get_current_crtc_state(state, crtc);
+			if (IS_ERR(current_crtc_state)) {
+				ret = PTR_ERR(current_crtc_state);
+				break;
+			}
+
+			ret = drm_atomic_crtc_get_property(crtc, current_crtc_state,
 							   prop, &old_val);
 			if (ret)
 				break;
@@ -1274,6 +1297,24 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 				ret = -EINVAL;
 				break;
 			}
+
+			if (old_val == prop_value)
+				is_noop = true;
+		}
+
+		/*
+		 * CRTCs must always be included in the commit,
+		 * even for no-op property changes.
+		 */
+		crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(crtc_state)) {
+			ret = PTR_ERR(crtc_state);
+			break;
+		}
+
+		if (is_noop) {
+			ret = 0;
+			break;
 		}
 
 		ret = drm_atomic_crtc_set_property(crtc,
@@ -1285,16 +1326,19 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 		struct drm_plane_state *plane_state;
 		struct drm_mode_config *config = &plane->dev->mode_config;
 		const struct drm_plane_helper_funcs *plane_funcs = plane->helper_private;
-
-		plane_state = drm_atomic_get_plane_state(state, plane);
-		if (IS_ERR(plane_state)) {
-			ret = PTR_ERR(plane_state);
-			break;
-		}
+		bool is_noop = false;
 
 		if (async_flip) {
-			/* no-op changes are always allowed */
-			ret = drm_atomic_plane_get_property(plane, plane_state,
+			const struct drm_plane_state *current_plane_state;
+
+			current_plane_state =
+				__drm_atomic_get_current_plane_state(state, plane);
+			if (IS_ERR(current_plane_state)) {
+				ret = PTR_ERR(current_plane_state);
+				break;
+			}
+
+			ret = drm_atomic_plane_get_property(plane, current_plane_state,
 							    prop, &old_val);
 			if (ret)
 				break;
@@ -1318,25 +1362,40 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 				break;
 			}
 
-			/*
-			 * FIXME this is in the wrong place. Whether to do a
-			 * bypass commit for async flips would is a driver
-			 * decision. Drivers that want this need to just do
-			 * these checks themselves somewhere.
-			 */
-			if (old_val != prop_value && plane->type != DRM_PLANE_TYPE_PRIMARY) {
-				/* ask the driver if this non-primary plane is supported */
-				if (plane_funcs && plane_funcs->atomic_bypass_check)
-					ret = plane_funcs->atomic_bypass_check(plane, state, true);
-				else
-					ret = -EINVAL;
+			if (old_val == prop_value)
+				is_noop = true;
+		}
 
-				if (ret) {
-					drm_dbg_atomic(prop->dev,
-						       "[PLANE:%d:%s] does not support async flips\n",
-						       obj->id, plane->name);
-					break;
-				}
+		/* No-op plane property changes can be fully skipped */
+		if (is_noop) {
+			ret = 0;
+			break;
+		}
+
+		plane_state = drm_atomic_get_plane_state(state, plane);
+		if (IS_ERR(plane_state)) {
+			ret = PTR_ERR(plane_state);
+			break;
+		}
+
+		/*
+		 * FIXME this is in the wrong place. Whether to do a
+		 * bypass commit for async flips would is a driver
+		 * decision. Drivers that want this need to just do
+		 * these checks themselves somewhere.
+		 */
+		if (async_flip && !is_noop && plane->type != DRM_PLANE_TYPE_PRIMARY) {
+			/* ask the driver if this non-primary plane is supported */
+			if (plane_funcs && plane_funcs->atomic_bypass_check)
+				ret = plane_funcs->atomic_bypass_check(plane, state, true);
+			else
+				ret = -EINVAL;
+
+			if (ret) {
+				drm_dbg_atomic(prop->dev,
+					       "[PLANE:%d:%s] does not support async flips\n",
+					       obj->id, plane->name);
+				break;
 			}
 		}
 
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 3492787c3697..5ae86d33e3ae 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -252,6 +252,15 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 
 void drm_atomic_print_new_state(const struct drm_atomic_commit *state,
 		struct drm_printer *p);
+const struct drm_crtc_state *
+__drm_atomic_get_current_crtc_state(struct drm_atomic_commit *state,
+				    struct drm_crtc *crtc);
+const struct drm_connector_state *
+__drm_atomic_get_current_connector_state(struct drm_atomic_commit *state,
+					 struct drm_connector *connector);
+const struct drm_plane_state *
+__drm_atomic_get_current_plane_state(struct drm_atomic_commit *state,
+				     struct drm_plane *plane);
 
 /* drm_atomic_uapi.c */
 int drm_atomic_connector_commit_dpms(struct drm_atomic_commit *state,
-- 
2.56.0

