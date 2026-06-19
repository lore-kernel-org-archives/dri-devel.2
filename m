Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2369ACD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EAB10F5B0;
	Fri, 19 Jun 2026 12:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RGwZpgKy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896F110F5AC
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:28:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70E4043EE5;
 Fri, 19 Jun 2026 12:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DEC1F00A3D;
 Fri, 19 Jun 2026 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872083;
 bh=64UJfQ2QSCW26/FM2EwjLVEGz51jQfPQ49vALeyVjLU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RGwZpgKy0zr2yf/9vuwJ/+fETf/1Re93m9CwIj7wWjdOVcKxuEkboJQHQhXJz/RRf
 O78mfilfD4Tsa2PLT1C//K/f4psfSzzNv22ejWtS3cYcogXQRtLh+L56BZHtGLnlMJ
 RQpq1qYvEFoABQAk/fGxV/qu1W6R1BFW2qgsV5CHuJmcGnWf22RA3gFoienT1NOKKj
 +SNtAoJqIgh41de85UvdAbQ4vDvMFxXMcK23u/D3zFCvaYuAq7lh/2/RFP0Dtb+6th
 pXaSD1V0xnlIqkGiIFALaUMVd3EVmfWANjmO9GC2/o38opUaJ2re8sCnkJY1OqKbLC
 2BoA21Nq3MuGg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:18 +0200
Subject: [PATCH v3 73/78] drm/xlnx: zynqmp_dp: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-73-ff399263111b@kernel.org>
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IH9PWtifm+BMyJqxfBp0AXO6boHBpVX3QAQphfjt5r4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmplxH+cXiN08MTQkzVDVMXNhaYHxF9H5H2xZzg+zdt
 +tDncM6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwEQ+zGCsszVuO5qsfIBHLfuf
 vpFD/+u/scdbJn2ekXBMYTLX8VNX+bje7m/nnO5jsYj91cuUFYs1GBsWNZk7vfr0bq9m10LX5ts
 cDYrsfow85/ZOmaj4hCHDZv2Fee6u+9/aRexe4JPxZn3HpSAA
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
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 7fb11b0a44f0..b209582bc130 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -2278,11 +2278,11 @@ static const struct drm_bridge_funcs zynqmp_dp_bridge_funcs = {
 	.mode_valid = zynqmp_dp_bridge_mode_valid,
 	.atomic_enable = zynqmp_dp_bridge_atomic_enable,
 	.atomic_disable = zynqmp_dp_bridge_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_check = zynqmp_dp_bridge_atomic_check,
 	.detect = zynqmp_dp_bridge_detect,
 	.edid_read = zynqmp_dp_bridge_edid_read,
 	.atomic_get_input_bus_fmts = zynqmp_dp_bridge_get_input_bus_fmts,
 	.debugfs_init = zynqmp_dp_bridge_debugfs_init,

-- 
2.54.0

