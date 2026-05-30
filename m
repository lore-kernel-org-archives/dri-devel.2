Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128A8CD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EA110E340;
	Sat, 30 May 2026 14:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JhWctyZr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30CBB10E355
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A804E600CB;
 Sat, 30 May 2026 14:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C011F00893;
 Sat, 30 May 2026 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149608;
 bh=VAOzIxKiOxCsJYORz/ir10E8+jx0f7HwYrf3C9wWEXA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JhWctyZrs61ZU9MgVOewW9hmSFZKetgQsl4o0PpCZIqOXPCAr4WexU6LO/rpSvsw3
 bg6slQMY7tgGBuvNQj15q/My3ss3nzDha60xCr+ys4+vSDmb+cPYmGHS8vrUbdmdij
 w+c9Vbtlnc5MzBbSIhHuq9nEm8/NWYGx6HgKpz7DHl9GHtzqYMTtTw6y22gQT8o4Ka
 V+M9M3xFgp7AHSPlQWQrXlbcQ/CsvDsgq9O4UF6Z13nLhPpjfWdd7EuU4aEDhKmFzu
 K3Gr1TAlP3m8QH9VNOgcKgJIK9XFcCCQBtdPDnBeYVzEVov0LsiS3FOFZtwb2dFLvx
 3R96AcisN2vOA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:10 +0200
Subject: [PATCH 05/76] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-5-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+7pKJ6EdISDvyUug3WmfdG3fcs0q4XqQFIFBk+eWzdg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb811zmsfyk0O2/5cv/Bewwv/S/3nD3TZupW+57/tr
 pZz9/6LjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARwVeMtULT7J/0cnV8t5y3
 o/TlxHUGC3f++nijxuFG31qBByybdP0Lfp4/tPpNTHVP+TSzH6IvlzDWKcv1bQpbG7TZROzJ3v/
 XHh6/vsVLTERE6v+7rgq2xbWOhRzJb87kP5j7wVej7eL9cx3nAQ==
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

The drm_atomic_helper_bridge_reset() helper is deprecated in favour
of the new atomic_create_state callback.

Add drm_atomic_helper_bridge_create_state() as the counterpart helper
for this new callback.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 25 +++++++++++++++++++++++++
 include/drm/drm_atomic_state_helper.h     |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index f0688f2d83fe..b99dedbc4140 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -925,5 +925,30 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
 
 	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
 	return bridge_state;
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
+
+/**
+ * drm_atomic_helper_bridge_create_state - default &drm_bridge_funcs.atomic_create_state hook for bridges
+ * @bridge: bridge object
+ *
+ * Allocates and initializes pristine @drm_bridge_state.
+ *
+ * This is useful for drivers that don't subclass @drm_bridge_state.
+ *
+ * RETURNS:
+ * Pointer to new bridge state, or ERR_PTR on failure.
+ */
+struct drm_bridge_state *
+drm_atomic_helper_bridge_create_state(struct drm_bridge *bridge)
+{
+	struct drm_bridge_state *bridge_state;
+
+	bridge_state = kzalloc_obj(*bridge_state);
+	if (!bridge_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
+	return bridge_state;
+}
+EXPORT_SYMBOL(drm_atomic_helper_bridge_create_state);
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index cbc760598b9e..68c685ad330f 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -103,6 +103,8 @@ drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
 void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 					   struct drm_bridge *bridge);
 struct drm_bridge_state *
+drm_atomic_helper_bridge_create_state(struct drm_bridge *bridge);
+struct drm_bridge_state *
 drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
2.54.0

