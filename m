Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C6606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p/iQGiln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C949D10E799;
	Mon, 16 Nov 2026 13:27:24 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EB710F15F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:16 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so1691865f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794835635; x=1795440435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qnR50NHSzbJZeR3bRCn/LqR9OGvdrFlstj/3NEkqIu4=;
 b=p/iQGilndNfLN1x7F6y1fe1N8g/W/Ekm1pJBs3oL2LZvZP6O5g+WmJgySEupvLJOfQ
 9OKjUsMywulLIhK1Ia74M+Wt/mAprtrc+ks/wnqgRacn4TigxrmMI8iXipeEMpecQp3W
 zKxL6sXKOAKzvTtBJxCY0Tw+hm2hThwzH9z39rficG9gmS4w2H3M2Xjj/qWYHrhlW9BG
 KBeLxjVakd9+jckNq9/QOU16Z6dZFSVOFkUXPWGl65j1nMO0KHgknR+L8k816dGCe6hr
 bH7ta0dyXAgPPkIaWyzFybU8f1U8VuqUbQY9OFsttPsShEAv3qi5uC/f4esLAV31MyRi
 9nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835635; x=1795440435;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qnR50NHSzbJZeR3bRCn/LqR9OGvdrFlstj/3NEkqIu4=;
 b=njoodR8NeJtHJrlVtMG2Fl1Wh/iR5w/OQR68AOuV7LgWSMiU54+eJMHonS+SiE3TSG
 BeRfo0b4B20D8pqMfslm49KVu/pOj5NDVBSpaEF4BpVUaOkoiKUlFEyv+8uxF5EH31N2
 r83kSKpW+FXuzkwo5S87mcAAG7I6EPnhNva3tsqrUxuFi8cIBWeFarMr13Oia/rMOWz8
 G80JYhZsmnONgAWAspKsFYOO0mASk38zLEz+yH9rh2JqHRh4ziwspYnFlD/hiK/ahu6e
 oO1CffkGUo5ktFZZlGFEnRXR6P1+xgJ5c0cTpjjNKpFdKvODUppsX774h8W1lnjneP9C
 z12w==
X-Forwarded-Encrypted: i=1;
 AL+hErGLPKhnpGlJXRFC0+6FjEOBO7jW0XmesWKyeRQACwL4easpiat8sxSs1t0Ce1Fa51InDgzUlOoVDkI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8q22EAUFJ0DDcyTW7tXAIw72u4NhxoSIxM8gOZbQHciek3IDsj
 0ozGJIBy020Ku75yeZeNAab8lOz2b5YRTOILsEA/d5L4emjoWzGsqqIV
X-Gm-Gg: AZFdTZdAdcoqXtK3vga/SyebBsDinH3FWWZucEblftg+1xceS1FfrN5KfogopgJh+q0
 Ydy2GkSwsCAe5iIiostH73G1Ma3IJPkHtaFANpRL4qLxiVBhNRObPKgLH1Ti2ezk954Yeo/7CXL
 PMXtord19QlKL0awRxaOtAZctq+Iy9gm6dbVbQtrxNxTx9rW+qmjxqpycLyRbyt7ZQWFaBsGvVR
 f1TKr1LCDIR4yMvAENoAXGZwK6HNr+k+CZEoqLOoF71fCAylUocnJl0CDAShmwdijnnvZw4odUT
 yZwvxsERop2UJz+lKF2yo8BRmqh2iMWcvbd8fi0xYPymrAEjlF/BttVXi9k2ygly3u5BjvF9QME
 90DqtsQfhGqKKUmG7193nOgojUyJplv0rgzTyoz1oJ9bBeHx9toYMj60Uavvp3P6SBYf6fE1Z6a
 zIzcuQmj7k0BM6e6Dh/paKqhCdg1vLUbqbsPe02FMqMlRGJtoyNpTGrHwXqERF1upalo2lO6D8c
 2HPle3ulXV3Dqoc5blgLUK2aMBs2lcQJlsuLrNa0wuiZ4iA/gFpubmHT8FpHGJsuZYSPqbh6v87
 UHMWUnupCNxF4yPXuAGizf2XZc7Hd/v8/AdiFdnW1bwt5qK9KqD+hBw=
X-Received: by 2002:a05:6000:2f81:b0:48e:62a9:1a65 with SMTP id
 ffacd0b85a97d-49c73a05861mr23918000f8f.49.1794835634472; 
 Mon, 16 Nov 2026 05:27:14 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm40370240f8f.7.2026.11.16.05.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:27:13 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] drm/panel: Implement state readout in the panel bridge
Date: Mon, 16 Nov 2026 15:27:05 +0100
Message-Id: <20261116142707.1299360-3-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116142707.1299360-1-maximpedraza@gmail.com>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The state readout core gives up if a private object doesn't implement
readout, so a driver using a panel bridge can't adopt the firmware state,
even if it implements readout itself.

A panel has no state to read back: it's part of the pipeline if the CRTC
feeding its encoder is active. Implement the connector and bridge readout
on that assumption, relying on the encoder's
atomic_sro_get_current_crtc hook, and fill the bus configuration with what
the commit negotiation would give.

When the state is installed, prepare and enable the panel, since nothing
else would until the first modeset.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/drm_panel.c | 92 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index c00529bfb706..7cee228f798b 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -9,10 +9,14 @@
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/of.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
@@ -216,6 +220,88 @@ static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
 		panel->funcs->debugfs_init(panel, root);
 }
 
+/*
+ * A panel has no state to read back: it's part of the pipeline if the CRTC
+ * feeding its encoder is active.
+ */
+static int panel_bridge_connector_readout(struct drm_bridge *bridge,
+					  struct drm_atomic_sro_state *state,
+					  struct drm_connector_state *conn_state)
+{
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+
+	if (!encoder->funcs || !encoder->funcs->atomic_sro_get_current_crtc)
+		return -ENODEV;
+
+	crtc = encoder->funcs->atomic_sro_get_current_crtc(encoder);
+	if (!crtc)
+		return -ENODEV;
+
+	crtc_state = drm_atomic_sro_get_crtc_state(state, crtc);
+	if (!crtc_state)
+		return -ENODEV;
+
+	if (!crtc_state->active)
+		return 0;
+
+	crtc_state->encoder_mask |= drm_encoder_mask(encoder);
+	crtc_state->connector_mask |= drm_connector_mask(connector);
+
+	/* Released by __drm_atomic_helper_connector_destroy_state(). */
+	drm_connector_get(connector);
+	conn_state->crtc = crtc;
+	conn_state->best_encoder = encoder;
+
+	return 0;
+}
+
+/*
+ * Same result as the bus format negotiation of a commit, which doesn't run
+ * during readout: the panel asks for its first format and flags, and passes
+ * them on through drm_atomic_helper_bridge_propagate_bus_fmt().
+ */
+static int panel_bridge_readout_state(struct drm_bridge *bridge,
+				      struct drm_atomic_sro_state *state,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	const struct drm_display_info *di = &conn_state->connector->display_info;
+	u32 format = di->num_bus_formats ? di->bus_formats[0] : MEDIA_BUS_FMT_FIXED;
+
+	bridge_state->input_bus_cfg.format = format;
+	bridge_state->input_bus_cfg.flags = di->bus_flags;
+	bridge_state->output_bus_cfg.format = format;
+	bridge_state->output_bus_cfg.flags = di->bus_flags;
+
+	return 0;
+}
+
+/*
+ * The firmware left the pipeline running, so the panel is taken as part of it.
+ * Without this it would stay off until the first modeset.
+ */
+static void panel_bridge_install_state(struct drm_bridge *bridge,
+				       struct drm_bridge_state *state)
+{
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+
+	if (!encoder->funcs || !encoder->funcs->atomic_sro_get_current_crtc)
+		return;
+
+	crtc = encoder->funcs->atomic_sro_get_current_crtc(encoder);
+	if (!crtc || !crtc->state->active)
+		return;
+
+	drm_panel_prepare(panel);
+	drm_panel_enable(panel);
+}
+
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
@@ -228,6 +314,10 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
+	.atomic_sro_readout_state = panel_bridge_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_sro_connector_readout = panel_bridge_connector_readout,
+	.atomic_sro_install_state = panel_bridge_install_state,
 	.debugfs_init = panel_bridge_debugfs_init,
 };
 
@@ -600,7 +690,7 @@ void drm_panel_add(struct drm_panel *panel)
 	mutex_unlock(&panel_lock);
 
 	panel->bridge.of_node = panel->dev->of_node;
-	panel->bridge.ops = DRM_BRIDGE_OP_MODES;
+	panel->bridge.ops = DRM_BRIDGE_OP_MODES | DRM_BRIDGE_OP_CONNECTOR_HW_READOUT;
 	panel->bridge.type = panel->connector_type;
 	panel->bridge.pre_enable_prev_first = panel->prepare_prev_first;
 
-- 
2.39.5

