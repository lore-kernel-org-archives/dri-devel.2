Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38BCCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EBB10F56C;
	Fri, 19 Jun 2026 12:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HWHf5Spt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C09D10F571
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3B72601E1;
 Fri, 19 Jun 2026 12:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329BC1F000E9;
 Fri, 19 Jun 2026 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871919;
 bh=VEk8rW0VJW22qayA+LJXB3Kzq1Mp1NqCDGzMy9+0kSI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HWHf5SptPKpcD0lOsyEmadpSj1cdswbJk8tfNfo2FpHoXKMVaFDHrYgc0uCT6pzb7
 o+6nBh21yEPuNyZ0Z0XMLe5p0SUygWF11GermFH5te8rL9/o3BdDi3LhtoL3BoRiDM
 QEw40zlbj7s8aO9Z1Zq0B3J9Vm8oah4JdnoJ0Uc7xM6kKRR2SwseIB0GjZiWQ27OWj
 IlgQwaS+MOsnElL+4prmVQ+J357XFH3jfA3uSc7NR5Aya+20ozaWGZbQD1UhcQMcgB
 BcYaz+ihHUTPb29fIvRWpngWtLmTYfgJ7A7U317SMY+cInTfg+oD5OOp5nJbNzM6vH
 VL7PvKs0c81ZA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:17 +0200
Subject: [PATCH v3 12/78] drm/bridge: display-connector: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-12-ff399263111b@kernel.org>
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476; i=mripard@kernel.org;
 h=from:subject:message-id; bh=db4twVvVK6DFRkd6SRVRrYRvNY+RmVMBsBEcjDElvF8=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGo1NO+gAdFEcfBcfVNEXP4VhJ6dQp4Zzv3K2hAqpFOYA5oXe
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmo1NO8ACgkQJ1/OGaI9vnaJRgF+Kcqh
 lEZO452j7xDmEaqix6CMhrsMdj+WConyAKF+Lq0DLHbV0+0GqUjr8UJ654CHAYD3tyjv9MxvPHB
 Xr+MJOTk9IiFJqI4xk9Z8sycbU4BiA7cmyuZcAl2DDX6V60XMPN0=
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

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/display-connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index f7a5bfd9c075..d1e74dd2e051 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -214,11 +214,11 @@ static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.edid_read = display_connector_edid_read,
 	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 static irqreturn_t display_connector_hpd_irq(int irq, void *arg)
 {
 	struct display_connector *conn = arg;

-- 
2.54.0

