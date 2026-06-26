Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BA9C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F408C10F624;
	Fri, 26 Jun 2026 13:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jQ1qfZhO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D35B10F5FF
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:57:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EAEB412DD;
 Fri, 26 Jun 2026 13:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69FD1F000E9;
 Fri, 26 Jun 2026 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782482260;
 bh=WyDBBDoNX3b9zyHKpTwLMxOJ7f4TqP3mcfa6J6FjmGc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jQ1qfZhOXDBbp2xRIw1DBpOxeQ/N39m5MXFygtKdoiJbbbhkjdmSJ4QJt+UNXu1zf
 j+ha78u6rebGSYa1FsqiBt6FwLXTx/izfIt5EPq8UsGSp5KzZZ/iHTfqQjH4xRRitc
 WI82YeDLls/v6bNI8OYvCSTyYlk0xdfHPz2hkd1LzNzQ0KKtvORnFBuZK1U5kcKnh5
 OEcDBrJlCowUGC+PQMgNO4DpYwPjMG9MiGuYIzz29JP+5xPXqJC/B16mvGyE9fmc/N
 wqJ48uhrig9Y54tolPqIXrcMolbmo9oVbhI7oEqhRNnKlBbbxoD6Qh85MXG2gGv4Hv
 Mlcj9GFUtt4yg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 26 Jun 2026 15:57:07 +0200
Subject: [PATCH v3 06/30] drm/bridge: Add drm_private_obj_is_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-drm-state-readout-v3-6-d5825e3299a8@kernel.org>
References: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
In-Reply-To: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vqY36eQulMZuYmqMRjFJijLPcRN1xg9ucuf+UrVkt0k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl2rcZr2PRmJuQsnvR5btnEu1VnmeLWlEfHKdWeO/Y3w
 1hSKCy5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykvIKx4bHe9J+d20LS+S4l
 xXy55fpJtL2jKZ9v5fEJdn5LD86LtD9tfdt7g5dV7Zz5Z6YsrAi3YWz4uS2COT3T40JpyqO8pGP
 fIr9OD0iMcJ4/15xndnH6Qe/TDuos8hYrGV0qj3CnzuP13QUA
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
index 912ccc4e7c27..b7b0ec7c2d4b 100644
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
 static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
 {
 	return bridge->funcs->atomic_reset != NULL;
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index ea5c0f6a7e8d..d14c50460e94 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1289,10 +1289,12 @@ static inline struct drm_bridge *
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
2.54.0

