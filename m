Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36463C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9899710E4D9;
	Mon,  7 Sep 2026 13:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Na5hXW/o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D58010E4D9
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35C6640F3E;
 Mon,  7 Sep 2026 13:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884161F00A3D;
 Mon,  7 Sep 2026 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787460;
 bh=/7ox7DIYgQNq86UvUHGlfCYvsJBrMAEy2D6OhC3LS7g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Na5hXW/ouR3iufK6fX8RwQoUHsIJtZpIeV7pBYONiIPya/wfQvKD3QbcFO/WDs+Y2
 jNPCt+LG7jLyCm/x3G/eqINN59WC21FltzM8Db3bhLMqjlaDm83FwJynWvJIt/ZRN0
 WZbOlrQ5QQKUfkYQfT+TTHoyGy9m1cE01Ls/ZyahNcOh73dlmcPcAhXeaWFqYgcbxP
 2mL/5gvOQUyJ7YaoP0GrX3yqQjuRpkMRkWRaoZGSGXWLwNaa0d/uUCB/H66sy0gxqd
 kzukNeJLjFIKPbrV/HaD/y1V6fRNqqv3pnunIsB0K6d0V/oeJDqwMYgJNi5i8JI5jc
 yx2j4Yeb8O3Og==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:41 +0200
Subject: [PATCH v5 05/33] drm/bridge: Add drm_private_obj_is_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-5-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Tjoxr5h12qhkQtuFScfANaQoaijiwnwFKD/53bsTpKA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj3oe/3O47/6CuPpYXPLz294mv0kjeGzCb969LWll
 x48OFlm2TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmcvwxY8NO/lvF4XZXjALd
 J7h7f/y/Vbi6mnFezKeM3qlzeVcUrdnm+XL+Cf3sL3uP3ozddHCn3kvGhmMLyycUyIde/Llm39r
 5TuKPFBgv/2zuOvdg/kuOObyHQi4nnVQLWP692v/Z1YBLeVdMFwAA
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

The SRO readout helpers need to distinguish bridge-backed private
objects from other private objects, because bridges require special
readout ordering through the encoder bridge chains.

Add drm_private_obj_is_bridge() which checks whether a private
object's funcs pointer matches the bridge private state funcs.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 15 +++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 27bb9963c234..186a4c14faef 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -554,10 +554,25 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 };
 
+/**
+ * drm_private_obj_is_bridge - check if a private object backs a bridge
+ * @obj: private object to check
+ *
+ * RETURNS:
+ *
+ * True if @obj is the &drm_private_obj embedded in a &struct drm_bridge,
+ * false otherwise.
+ */
+bool drm_private_obj_is_bridge(struct drm_private_obj *obj)
+{
+	return obj->funcs && obj->funcs == &drm_bridge_priv_state_funcs;
+}
+EXPORT_SYMBOL(drm_private_obj_is_bridge);
+
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
  * @encoder: DRM encoder
  * @bridge: bridge to attach
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 389dcab3c3f3..a6b0ad25eea8 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1183,10 +1183,12 @@ static inline struct drm_bridge *
 drm_priv_to_bridge(struct drm_private_obj *priv)
 {
 	return container_of(priv, struct drm_bridge, base);
 }
 
+bool drm_private_obj_is_bridge(struct drm_private_obj *obj);
+
 bool drm_bridge_enter(struct drm_bridge *bridge, int *idx);
 void drm_bridge_exit(int idx);
 void drm_bridge_unplug(struct drm_bridge *bridge);
 
 struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge);

-- 
2.55.0

