Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B589ACD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A5110F594;
	Fri, 19 Jun 2026 12:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GuztrvR8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A0010F58F
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC46741A5C;
 Fri, 19 Jun 2026 12:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282581F000E9;
 Fri, 19 Jun 2026 12:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872000;
 bh=lHQIntAFjgWuDJ5wWRQlEIZFw4sZEb0oMKuHDn83VVw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GuztrvR8WwkRMHid4GOz2QQcigD3bB9URKSu4BFAdiWvqjIJmT8f99eaUpDWcCQuv
 raL9dRoTMXbU9Iq18fxbGSCvujq8x/DSXx8hvvdST7mdk8MRIDD/6g4uMV++rL5sR8
 WkpS4ffP5huDGBp8/2/gB9dkf6t2yp9OW2s3ikOJqUZRoHxOsDtTyYQYrxY69CY3VH
 ftMDUuBjxgJuNcDbeh6+HQvIwrCp6dfXPc9OKKvi1tecEoLwn0T8Mdf8KBqLWW6cmF
 UpR1v68XpusZ59TwhfSB3Bn1e6I2StOvwQWxqRTjJtmF8+LgcfOeMILWt3pV72F3Da
 XZnxSjnAhY24w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:47 +0200
Subject: [PATCH v3 42/78] drm/bridge: ti-dlpc3433: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-42-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0nh/mhlnO6W+nh/nDhkpTbd0uDKOXYCQVRnfybHdQ1k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJn+efVsQ8NEi+ZLQ+tBdjyUuS1Y951g/j9lGd9cXv
 XvnChliO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEwmsZ6/QNpfvvP8y4ffLk
 vF9Rezq2y/NOmCltYfdrKWPahakW694Lyl9rLlF3eKF2X3NfnaBwImOtHNPRXre4uTJnFdVfhZ6
 fmWH7137KX+1L0x9NUa40PiR/ft2mg5HN1Z6Sedkafg/XmVYDAA==
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/bridge/ti-dlpc3433.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index 9c35eade0a78..c16eb3a05cfa 100644
--- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
+++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
@@ -252,11 +252,11 @@ static int dlpc_attach(struct drm_bridge *bridge, struct drm_encoder *encoder,
 
 static const struct drm_bridge_funcs dlpc_bridge_funcs = {
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts	= dlpc_atomic_get_input_bus_fmts,
-	.atomic_reset			= drm_atomic_helper_bridge_reset,
+	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable		= dlpc_atomic_pre_enable,
 	.atomic_enable			= dlpc_atomic_enable,
 	.atomic_post_disable		= dlpc_atomic_post_disable,
 	.mode_set			= dlpc_mode_set,
 	.attach				= dlpc_attach,

-- 
2.54.0

