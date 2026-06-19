Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A18CDB466
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0031610F587;
	Fri, 19 Jun 2026 12:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AvEXcx/1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7377210F582
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AB79409F8;
 Fri, 19 Jun 2026 12:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94EB1F000E9;
 Fri, 19 Jun 2026 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871965;
 bh=DZaxq2/pBjSyZ9bfL/DMoud79v9LpJc9FKLh+lGkfzA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AvEXcx/1TULQVhRzyLmkrw5B47/nbRS9fhz2Xw/Cj3XUwZrNkl8MvrX85C5VMVhD7
 nB5dOBamHYe8balrDv76UgUzIJWJ8aDw8C/+DMkCaG9ivgSLH9eHMZ+GYgfRbbBy5k
 0AscB0QDteGd+PJcc/s2FdI7iRq1oX3uRrDErFbdcGt28sfIifFJdDz+ZN4b/Ut02f
 3+lmxK2SgwJzaePOUW56AzU9kfGAtg5JiY23TXGtYArWXOzdgKbFk5N3MjHMZBT5TJ
 k28eZc+6hmwQxwBn1WepWQ82Lz3NmHSXRO2JfdrMD0RWB9jdHauEUjXUfxprqDRlMC
 swiXcSm5EOJNg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:34 +0200
Subject: [PATCH v3 29/78] drm/bridge: parade-ps8640: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-29-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=mripard@kernel.org;
 h=from:subject:message-id; bh=THXFphzWwi4ujC9/JSDUBxu8SEfaVz7VGYjkTK2C1rA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJt/mfHw4N+6k9KGrryvm3O92Ncg8c9vslpFyK+uS+
 UzBpbq+HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAie68x1pnd2bg9ovJc0TvF
 h+94j/vv+fD0sMrFb4J/XR5JHbM8xL71ytWAigs5wnNXRp6YU3fm5mvGWjFHXbNW2zr/BzHb/Zh
 Pe+pc/3BLbF6xlqGW9/mWlsfBP84rbVXZslfgniRTy9FZRe+3AwA=
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Acked-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index b93514023baa..96332721cb69 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -554,11 +554,11 @@ static const struct drm_bridge_funcs ps8640_bridge_funcs = {
 	.detach = ps8640_bridge_detach,
 	.atomic_post_disable = ps8640_atomic_post_disable,
 	.atomic_pre_enable = ps8640_atomic_pre_enable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 static int ps8640_bridge_get_dsi_resources(struct device *dev, struct ps8640 *ps_bridge)
 {
 	struct device_node *in_ep, *dsi_node;

-- 
2.54.0

