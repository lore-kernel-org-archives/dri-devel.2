Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BB3CDB466
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9400610F5B2;
	Fri, 19 Jun 2026 12:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZmdhAFU+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73A610F5AC
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:27:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49BE6601EF;
 Fri, 19 Jun 2026 12:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1CB1F000E9;
 Fri, 19 Jun 2026 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872078;
 bh=kqKaaC3v0jftNxK3Wv7qNrpaKJIE6YDkOzG1iVSZsVk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZmdhAFU+icY0kMfSCGbPmQGQYrAQAfG94T8fIziyILAWXc+JIVvNltIQ2pAkqfdsz
 k6J3PP0NlPgr56Xt1gsqvOj+6efZ4FY8QY88gOKZqwFc/TDIgUF4yRaHszoXFi4P6h
 ikayePBj3oGWlc00aGu3PLK16xQLe2uXeSps0Q3gA4LfBfHJEja5jmYvwDqp/FMOV3
 Vh2rtFGkDVL3ottojCPyBvZzLANWGc7/jpReK6Nvq6mw+mbmgmLZ1Igx5FDt8A1PpL
 V1PXu4vVY2HiiZu2ZSCDVHEszytuYhWrrw/apkskBcw3xkCzsoAFXEujH00ZGC6ZKZ
 Iq1ASUrHstOBA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:16 +0200
Subject: [PATCH v3 71/78] drm/vc4: dsi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-71-ff399263111b@kernel.org>
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
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=mripard@kernel.org;
 h=from:subject:message-id; bh=N07fpT7RFhzY+cBJI2CirVvZhrhZnk3weeRBRiuiE4I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmppyBM8/+82cSnd5Q6ztxZnzisqJf/W+cUz1eu746w
 lD7MN6sYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzERoWx4exsBt8/xQzuNyVP
 Pes7cqLw20lGs+0vpOS+xT+PYlghOOGvi0PGjBvK7r3detv7jYIWMjZMOc1/JvKR0q6r2zze935
 eV1gd8/Ps3yIPLcmy6X+v/svp/5SsuPTq2oI5yydcMHsykzsJAA==
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

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Acked-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Maxime Ripard <mripard@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index fc76018b044c..0148f2befed1 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1409,11 +1409,11 @@ static const struct mipi_dsi_host_ops vc4_dsi_host_ops = {
 };
 
 static const struct drm_bridge_funcs vc4_dsi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable = vc4_dsi_bridge_pre_enable,
 	.atomic_enable = vc4_dsi_bridge_enable,
 	.atomic_disable = vc4_dsi_bridge_disable,
 	.atomic_post_disable = vc4_dsi_bridge_post_disable,
 	.attach = vc4_dsi_bridge_attach,

-- 
2.54.0

