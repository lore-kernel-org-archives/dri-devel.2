Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC743606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=SWpXiQsc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E476110E502;
	Sun, 22 Nov 2026 15:30:58 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC6210E502
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:30:50 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so23576115e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795361449; x=1795966249;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ir0OKyo+y1SL2HEj72iu85DZejzl7//zFmRmBJel+xA=;
 b=SWpXiQscHvPMFxnY6aov3Z6pXmh0wFh1g5582sRpNQytWdX1AFp3YvkBjhlUpqi0cn
 Z3a4ppwZAhVg1JJsmTsDJORraJop+c7Q6VdIfjXweZ1kPYWgRh/ROq7HISXOOvcnNs+4
 dg7ZJEy4h9Zq/DTVz9b7jwYbl8DQy17hd+SCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361449; x=1795966249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ir0OKyo+y1SL2HEj72iu85DZejzl7//zFmRmBJel+xA=;
 b=o/ocZvZcB5YOE/O/bd7tLqXSls+n9l2VGt8lxTli8z7QxIP/1yElmSk3Nd0bToC1o0
 5ncTB+qLZUDjiQn0E6CmahXu2GORmwo81gfhq3Rzxy+yW4MTWjUGrIW9GjuS9lShpjQp
 krtorseE+8LVlmWNAyPDmxKEYWrNjm7tNABp1T2fe1DQOqDduABaB0PtSjmBvf5YTI4T
 oee2pF3gS0s9fJbPv2UFvJnbhSfq/9UGlMNslRm6UJ53g0B19nX9e75aJQabQ8WhWx2M
 a8ZVAc84KNA16rEAjWipYl9HZnZLlkBReKbKpBRe6IJmc+8ceyic2UCHglDKSTdgj3hC
 Gveg==
X-Forwarded-Encrypted: i=1;
 AL+hErECFAlrufKMSeEy/5XV4+mABrd7xiJLGaRpJMSl9UXzaMIg2xpYVVnD5p4Zp7/6u6t0RB3nE8nJ+OY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9beaOhuUBYomxR6GHsb8ymEvkUwDVnyOALN+Uf0btgGiKHQnYy
 i9TAvLGE5kkjxRfVBXC5rJrwsd+BblTg7ykNqNXggjrfHmiltf6UewDvqUtEVQVw5kc=
X-Gm-Gg: AZFdTZfsve/Z5mJqOoX0ZK+0anxZMoNdBE4wxOduPRUkZHiXIjt0AQ+1PArpePKC9/U
 Y50ITE2XZO/jow2e5jsNqrVZ1BYNPQ34V6u2hQIQp3SoGIoFGIiqsZTjwRWqrugOheq280jhSZG
 XTK3Opak9nfGErD5gJc//hduuXNBjm8VXfH4Xt+BPXN8CYKJ9Pa2coCkMhlqokOt4pLiROvW9Nh
 vELZk3tR83G9r+ThsYvP1bd6zW7Htsq7WzpInPyFo6nMy1bFhMXTTkiCd6ur569kEBji0LJnZ+C
 h88Eldn2WAzjVcae7lR55gMx2fzE87se4jPXTVbP7/si/eq+pCbZ+7LDuPaayGKKSMfw6omgRYQ
 ZRz/aKR/yCQ93AmXuM4RSL20TAVSPys9HXq8ET0dsJcLXur40pPt74QjZAEKMpRx5lAh2HTeoGo
 g/nse2SZEjjSGPbZjgp1cFsZDsRBqHzwLoWsam6E/6XJASYOpOT4yGbUjCPSeiyS1q646/a5e4r
 A18JH/4Nyb5aK6lAJ/ryHFcviqmWv05BhYvxs318esEshVkdQsp3nV+7AGAvXvsTDAGJ1XSMN9A
 HQdwFtJVKaxeCeQlYhPz6USNi3oQE98tNE9GcI2NX9UgEmK/3IpR3FJ3FQFOQcKbXVwjtKhgI5y
 UAYXUF6NCriQZHykXk2EqrjJTaqL6HGCe4ZHCKWv4fVdpKQCR38q9HJIUcCdZLIPUkevd+vE3mb
 +p9Svia9OVAu0lsy8ZsbWJbwJ4vg==
X-Received: by 2002:a05:600c:6219:b0:4a1:d087:f6ab with SMTP id
 5b1f17b1804b1-4bb8880badfmr181373425e9.18.1795361449293; 
 Sun, 22 Nov 2026 07:30:49 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm237833815e9.9.2026.11.22.07.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:30:48 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/8] drm/bridge: Add atomic_sro_install_state hook
Date: Sun, 22 Nov 2026 16:30:01 +0100
Message-ID: <20261122153032.2782768-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CRTCs, planes, connectors and private objects can acquire the
resources needed to keep the hardware state active when a state read
out from the hardware is installed. Bridges can't, even though they
usually hold a runtime PM reference and track their enable state
while the pipeline is active.

Add the atomic_sro_install_state hook to the bridge funcs. It is
called only for the bridges of a pipeline that was read out as active.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/drm_bridge.c | 41 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 20 ++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 81174015309f..f4b66a3b38fc 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -637,6 +637,46 @@ drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
 	return 0;
 }
 
+/* The connector and CRTC states are installed before the bridge ones */
+static bool drm_bridge_sro_pipeline_is_active(struct drm_bridge *bridge)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+	bool active = false;
+
+	drm_connector_list_iter_begin(bridge->dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		struct drm_connector_state *conn_state = connector->state;
+
+		if (!conn_state || conn_state->best_encoder != bridge->encoder)
+			continue;
+
+		if (conn_state->crtc && conn_state->crtc->state)
+			active = conn_state->crtc->state->active;
+
+		break;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return active;
+}
+
+static void
+drm_bridge_atomic_install_priv_state(struct drm_private_obj *obj,
+				     struct drm_private_state *priv_state)
+{
+	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
+
+	if (!bridge->funcs->atomic_sro_install_state)
+		return;
+
+	if (!drm_bridge_sro_pipeline_is_active(bridge))
+		return;
+
+	bridge->funcs->atomic_sro_install_state(bridge,
+						drm_priv_to_bridge_state(priv_state));
+}
+
 static bool drm_bridge_atomic_compare_priv_state(struct drm_private_obj *obj,
 						 struct drm_printer *p,
 						 struct drm_private_state *a,
@@ -682,6 +722,7 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs_with_sro = {
 	.atomic_sro_compare_state = drm_bridge_atomic_compare_priv_state,
 	.atomic_sro_readout_state = drm_bridge_atomic_readout_priv_state,
+	.atomic_sro_install_state = drm_bridge_atomic_install_priv_state,
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index b73f3424ed62..eb65e1807410 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -341,6 +341,26 @@ struct drm_bridge_funcs {
 					 struct drm_bridge_state *a,
 					 struct drm_bridge_state *b);
 
+	/**
+	 * @atomic_sro_install_state:
+	 *
+	 * This optional hook is called when a state read out from
+	 * hardware is about to be installed as the bridge's current
+	 * state, and the pipeline the bridge is part of was read out
+	 * as active.
+	 *
+	 * It allows drivers to acquire the resources needed to keep
+	 * the current hardware state active, such as power domains,
+	 * clocks, or interrupts, and to align their internal state
+	 * with what a regular enable sequence would have left.
+	 *
+	 * This hook cannot fail. It is called during
+	 * drm_atomic_sro_install_state(), which is part of the
+	 * hardware state readout initialization sequence.
+	 */
+	void (*atomic_sro_install_state)(struct drm_bridge *bridge,
+					 struct drm_bridge_state *bridge_state);
+
 	/**
 	 * @atomic_duplicate_state:
 	 *
-- 
2.43.0

