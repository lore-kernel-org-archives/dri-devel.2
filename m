Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DE606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LQMEhJSc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0EB10E090;
	Sun, 25 Oct 2026 13:38:23 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268FB10E090
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 13:38:17 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c2afa22e1dcso286534366b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792935495; x=1793540295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oThZuqK7w1i+OXOYJkEjXQGANLykMD/PqGXxTtL3rmE=;
 b=LQMEhJScuenER3Lz7PRyqqAXihKVsT4oCH3eUoHLOvH069f1jNbmUXWDUJnB8YNqwE
 BNFSQ90+7dHc1sBaDqGTiMwywesHcuT5zRv1rzQ/ZH/77H3q9eC/XVfbxoGEBwwH4kKk
 iMRkzbk426Af2gTj3nB3SU1DdSyWCW6XjiEsbNBL8n1xtJqQ+y2q68VOJ6OGCPi8J/0q
 qIcRc+MbetP3k2Dz7a4KPcJCidTrPP9c6tM0WPznXeYqUppygipgHfv19m1limNk71uj
 myjOipASQEzT5GHuBTDhauL2/nhlQhtcZF8J0zY1WxCtB1xDFdnNzGpO86tRSOmTzxWJ
 QoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792935495; x=1793540295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oThZuqK7w1i+OXOYJkEjXQGANLykMD/PqGXxTtL3rmE=;
 b=y9RvutfHf8G+GemB4n+EkAb8kQKYj6pu5DL+vIeInjiwFysJ4qZI5VSh+2Yuse4p5v
 NAUa6eqfwa9tUfRlELKljYXO6OlFNNDHNc3JXyNv8NJXoAeUI2wO0DWNEDGIAwcRHFjT
 8dDWKKeZW2sa5YWotk3kc2fX8LJbB4tPM1FuR+zW+0CeACXocHAnlxRFcKqcrXsoMJKb
 jssZtr/J05TtBTVYQbcBFHCnoepCMY5i2JE+4xSgYZ4LTBKYDJSmb+RF4tMIY6pbxV7+
 PVDTDzUJLmhgOIoL9nOZZ9QtDkEtk6cVMuGMNkMMW2YJt6grLScI+yTb+td6I9p4NUK6
 o1kg==
X-Gm-Message-State: AFq9FYImkR+HBnw7a+K7+VX117ImX9ub++dVjG5fr7ZoeNLi0xcSuZQg
 txahIuJjuIMTz7lh0UjGUM9UgVKAyOvU+L7wjSUjozgC33oC6UOxASQL
X-Gm-Gg: AYBFou1IOddJP+XPAlQMCcQKB/iAhMKJ7BHrPUb3AEokIhbcOeTuQZqjW71ID0Dvls7
 3gdMYTsnjUEiKcJgM6YiO+HSNlWhq7J3ZnoFdSifOSpkLAg00Og83KEByYJ5YxxqV9TF1UPW73s
 3Gdj7Kp3Cig5uNAZm91o1ipZi3BsSPjtFwATM3fEPUCTmPOp8Zz9qkXxR23s2HeOgoOn1lFfyck
 mYE2F+6o7S/beu1Yh6vlcjryADfbt8+GeI6EKcPc5YpmxlwFSahWMrK89vm/WUlEDnVyhwIuaPC
 6rccwgc5y8vRlAAaoIyz4qW5pbgUvo+o4OZmnvoVZmVREbkP0EzVuQoFlA9GIKkM8w6Kk8LEX++
 vzk8XHXL/wkO+GlVDPde8PCzWJzA3dSBaT63aCfYSiiXwjVUG3IR7dZuemreUP/x1R0cQV0EbmI
 pu8/13mbg4NLrfcKeo5nA8qXftgP9hMp96yocAGpZyntCtMF8muYc1Z9aS7nbV6I6PH0INFeInv
 lO0kkIPfogTuJQBikKmHt0mwpMcpwN6D0uS6P+fTLpkrAeIn0rl3R3osIb/TpygFuDjrHGPqxHG
X-Received: by 2002:a17:907:9c05:b0:c3f:8c92:3b51 with SMTP id
 a640c23a62f3a-c46bdaf8c9bmr502296666b.4.1792935495107; 
 Sun, 25 Oct 2026 06:38:15 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd34f874sm208114466b.9.2026.10.25.06.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 06:38:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/bridge: ssd2825: Fix panel enable sequence
Date: Sun, 25 Oct 2026 15:36:36 +0200
Message-ID: <20261025133636.253505-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, in the case of a single bridge and a single panel, the DRM
framework calls panel prepare() > bridge pre_enable() > bridge enable() >
panel enable(). While this is fine for most cases, the SSD2825 requires
the last two steps to be swapped. There is no meaningful way to achieve
this using standard bridge chain configuration, so the bridge previously
called panel_enable() directly at the end of its pre_enable() hook to
gain fine-grained control over the sequence.

Commit 554d36acf5e0 ("drm/bridge: ssd2825: don't create a panel_bridge")
removed this call, resulting in a regression where display output is
missing because the panel enable function is now called after the bridge
completes its configuration.

Since panels are now automatically wrapped into the bridge framework,
invoke the next bridge's atomic enable directly, similar to how panel
enabling was handled previously.

This restores panel support on the LG Optimus 4X HD (P880) and
Optimus Vu (P895).

Fixes: 554d36acf5e0 ("drm/bridge: ssd2825: don't create a panel_bridge")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/bridge/ssd2825.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ssd2825.c
index 71877699dfab6..9216cee09115f 100644
--- a/drivers/gpu/drm/bridge/ssd2825.c
+++ b/drivers/gpu/drm/bridge/ssd2825.c
@@ -475,6 +475,7 @@ static void ssd2825_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					     struct drm_atomic_commit *state)
 {
 	struct ssd2825_priv *priv = bridge_to_ssd2825(bridge);
+	struct drm_bridge *next_bridge = priv->output.bridge;
 	struct mipi_dsi_device *dsi_dev = priv->output.dev;
 	const struct drm_crtc_state *crtc_state;
 	const struct drm_display_mode *mode;
@@ -569,6 +570,14 @@ static void ssd2825_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	/* Initial DSI configuration register set */
 	ssd2825_write_reg(priv, SSD2825_CONFIGURATION_REG, config);
 	ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0);
+
+	/*
+	 * The SSD2825 requires that the next bridge be enabled first;
+	 * otherwise, the SSD2825 cannot complete its configuration and
+	 * there will be no output.
+	 */
+	if (next_bridge->funcs && next_bridge->funcs->atomic_enable)
+		next_bridge->funcs->atomic_enable(next_bridge, state);
 }
 
 static void ssd2825_bridge_atomic_enable(struct drm_bridge *bridge,
-- 
2.53.0

