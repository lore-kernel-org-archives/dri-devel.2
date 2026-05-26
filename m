Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE75CD6E48
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA98310E711;
	Tue, 26 May 2026 16:47:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X2BUSXUg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C27E10E720;
 Tue, 26 May 2026 16:47:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27EBD42A2B;
 Tue, 26 May 2026 16:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511541F00A3E;
 Tue, 26 May 2026 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779814029;
 bh=K2UPYbhPtSXUMDOwtfdlf//YUN1fGrJchSE9r9ljFSs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=X2BUSXUgB7r56xydA7YoZlmwwRW+Og2tBCRtZtZFtYabf3aj/eIQiFTGKaTOCUy7+
 IPU6k8dgJHKCduq78Addw8yor2it5KxWK9JtWhqkwlmdCSpY1ylEjjhIoCAw4beCfQ
 S7zH4ib+8zdIL+YCmJyCVAR5fYvReB1CiCVINDiQWxPisryCliv9/dBWKYR0LhdeJC
 pyrYFnkCR/7ZexBHngI12QS4IPhPGGFrdhF800B5o43EUn6eiRCF94Yu17Rb41q391
 02+/M96h4uXUzQhkrwnJzaloEvveNOxWatXU1JhHSo0FQVCycSJ0RHs1JEo0lD5VbM
 tDaJ3ambTeNhA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 May 2026 18:46:27 +0200
Subject: [PATCH v6 15/19] drm/connector: Add new atomic_create_state callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-drm-mode-config-init-v6-15-852346394200@kernel.org>
References: <20260526-drm-mode-config-init-v6-0-852346394200@kernel.org>
In-Reply-To: <20260526-drm-mode-config-init-v6-0-852346394200@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Simon Ser <contact@emersion.fr>, Harry Wentland <harry.wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Sebastian Wick <sebastian.wick@redhat.com>, 
 Alex Hung <alex.hung@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8349; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+uyL1hB7aSv5FAMP3njLcYeI/kcEL2d3N0SXzQ4QHoY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmi52L/9vbVrlRxrdnQv+bqrpYd3n9dRCPOGHWukhJba
 z/dS/hpx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIfAljwxe5ZOOtO6quvl31
 Y0atqpu5yrrCb7nRHP3SpkH71/9mTbCUULp0SVI2mMfZkKll2WRexjqF4B/HVfbvtdctf2TiL7V
 K/FLcsiUrln2c6+3Zena/RHp/Vsk3vtU/RPUK0y04PpYypgMA
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

Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
to drm_private_obj") introduced a new pattern for allocating drm object
states.

Instead of relying on the reset() callback, it created a new
atomic_create_state hook. This is helpful because reset is a bit
overloaded: it's used to create the initial software state, reset it,
but also reset the hardware.

It can also be used either at probe time, to create the initial state
and possibly reset the hardware to an expected default, but also during
suspend/resume.

Both these cases come with different expectations too: during the
initialization, we want to initialize all states, but during
suspend/resume, drm_private_states for example are expected to be kept
around.

reset() also isn't fallible, which makes it harder to handle
initialization errors properly. This is only really relevant for some
drivers though, since all the helpers for reset only create a new
state, and don't touch the hardware at all.

It was thus decided to create a new hook that would allocate and
initialize a pristine state without any side effect:
atomic_create_state to untangle a bit some of it, and to separate the
initialization with the actual reset one might need during a
suspend/resume.

Continue the transition to the new pattern with connectors.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c           | 10 +++++++++-
 drivers/gpu/drm/drm_mode_config.c         | 31 ++++++++++++++++++++++++++++++-
 include/drm/drm_atomic_state_helper.h     |  2 ++
 include/drm/drm_connector.h               | 16 ++++++++++++++++
 5 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index e2e5a1b8a820..07686e94aae0 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -532,10 +532,36 @@ void drm_atomic_helper_connector_reset(struct drm_connector *connector)
 	kfree(connector->state);
 	__drm_atomic_helper_connector_reset(connector, conn_state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_reset);
 
+/**
+ * drm_atomic_helper_connector_create_state - default &drm_connector_funcs.atomic_create_state hook for connectors
+ * @connector: connector object
+ *
+ * Allocates and  initializes pristine @drm_connector_state.
+ *
+ * This is useful for drivers that don't subclass @drm_connector_state.
+ *
+ * RETURNS:
+ * Pointer to new connector state, or ERR_PTR on failure.
+ */
+struct drm_connector_state *
+drm_atomic_helper_connector_create_state(struct drm_connector *connector)
+{
+	struct drm_connector_state *state;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_connector_state_init(state, connector);
+
+	return state;
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_create_state);
+
 /**
  * drm_atomic_helper_connector_tv_margins_reset - Resets TV connector properties
  * @connector: DRM connector
  *
  * Resets the TV-related properties attached to a connector.
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3fa4d2082cd7..a0b132c658a1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -616,11 +616,19 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 
 	/*
 	 * drm_connector_attach_max_bpc_property() requires the
 	 * connector to have a state.
 	 */
-	if (connector->funcs->reset)
+	if (connector->funcs->atomic_create_state) {
+		struct drm_connector_state *state;
+
+		state = connector->funcs->atomic_create_state(connector);
+		if (IS_ERR(state))
+			return PTR_ERR(state);
+
+		connector->state = state;
+	} else if (connector->funcs->reset)
 		connector->funcs->reset(connector);
 
 	drm_connector_attach_max_bpc_property(connector, 8, max_bpc);
 	connector->max_bpc = max_bpc;
 
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 2e2cd18a14b4..9d240817f8b6 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -235,10 +235,36 @@ static int drm_mode_config_crtc_reset_with_create_state(struct drm_crtc *crtc)
 	}
 
 	return drm_mode_config_crtc_create_state(crtc);
 }
 
+static int drm_mode_config_connector_create_state(struct drm_connector *connector)
+{
+	struct drm_connector_state *conn_state;
+
+	if (!connector->funcs->atomic_create_state)
+		return 0;
+
+	conn_state = connector->funcs->atomic_create_state(connector);
+	if (IS_ERR(conn_state))
+		return PTR_ERR(conn_state);
+
+	connector->state = conn_state;
+
+	return 0;
+}
+
+static int drm_mode_config_connector_reset_with_create_state(struct drm_connector *connector)
+{
+	if (connector->state) {
+		connector->funcs->atomic_destroy_state(connector, connector->state);
+		connector->state = NULL;
+	}
+
+	return drm_mode_config_connector_create_state(connector);
+}
+
 /**
  * drm_mode_config_reset - call ->reset callbacks
  * @dev: drm device
  *
  * This functions calls all the crtc's, encoder's and connector's ->reset
@@ -278,13 +304,16 @@ void drm_mode_config_reset(struct drm_device *dev)
 	drm_for_each_encoder(encoder, dev)
 		if (encoder->funcs && encoder->funcs->reset)
 			encoder->funcs->reset(encoder);
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter)
+	drm_for_each_connector_iter(connector, &conn_iter) {
 		if (connector->funcs->reset)
 			connector->funcs->reset(connector);
+		else if (connector->funcs->atomic_create_state)
+			drm_mode_config_connector_reset_with_create_state(connector);
+	}
 	drm_connector_list_iter_end(&conn_iter);
 }
 EXPORT_SYMBOL(drm_mode_config_reset);
 
 /*
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 9634a70e0401..f4b6d8833bc2 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -73,10 +73,12 @@ void drm_atomic_helper_plane_destroy_state(struct drm_plane *plane,
 void __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					       struct drm_connector *connector);
 void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
 					 struct drm_connector_state *conn_state);
 void drm_atomic_helper_connector_reset(struct drm_connector *connector);
+struct drm_connector_state *
+drm_atomic_helper_connector_create_state(struct drm_connector *connector);
 void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
 int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
 					 struct drm_atomic_commit *state);
 void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
 void
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5ad62c207d00..529755c2e862 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1569,10 +1569,26 @@ struct drm_connector_funcs {
 	 * when a connector is being hot-unplugged for drivers that support
 	 * connector hotplugging (e.g. DisplayPort MST).
 	 */
 	void (*destroy)(struct drm_connector *connector);
 
+	/**
+	 * @atomic_create_state:
+	 *
+	 * Allocate a pristine, initialized, state for the connector
+	 * object and return it. This callback must have no side
+	 * effects: in particular, the returned state must not be
+	 * assigned to the object's state pointer and it must not affect
+	 * the hardware state.
+	 *
+	 * RETURNS:
+	 *
+	 * A new, pristine, connector state instance or an error pointer
+	 * on failure.
+	 */
+	struct drm_connector_state *(*atomic_create_state)(struct drm_connector *connector);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
 	 * Duplicate the current atomic state for this connector and return it.
 	 * The core and helpers guarantee that any atomic state duplicated with

-- 
2.54.0

