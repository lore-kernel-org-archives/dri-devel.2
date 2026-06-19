Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF174CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1161410F592;
	Fri, 19 Jun 2026 12:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CKmg2JcR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7900010F595
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 620CF43F9A;
 Fri, 19 Jun 2026 12:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17541F000E9;
 Fri, 19 Jun 2026 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872011;
 bh=N0aYHoLw4a9WCSRYIkEaYVmLp34yYsasBX41fmiQL7o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CKmg2JcRP/CTtT6BfVY1zQlz3VdMwG6hyRJFx4x9A+R/HQ4AEzRyEb//qJ/7h/zRX
 d0e77BjUgvSqzgnOAsPV3ZJYoTBeqnry7ZOCfJVMrAiK5djNU9zsNpcIlUPTpS1S0N
 4wBJFo2kk/BelkkKdfP7Jbj6qGk+/oUV7JlrZMqm7aKo7Z86dEHwcCIVe89bC5GYvT
 5qb1VCkg/NrDFo0smdiN03zE5lcPwdqU9M2Xak9xzIZCFvRpAMMa3qa4JiWpnBK3Zf
 FP2Qp8pEIjyjcqsjd1kDXWfbZE2M9a15iy0WPlV8DrFTH/W3O53tia/6NbR7igCMcL
 WL/ALZKxPjHjQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:51 +0200
Subject: [PATCH v3 46/78] drm/bridge: ti-tfp410: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-46-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EnpogQkVHFUzuHhCwZElBtsf9GJZ3CotxILZLO6ulVY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJv+UL25xqaxOD7VX2zzHUdZNZ5r4tYxtU0OF4wzjf
 P8JO3Z0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIm0RzLWR07enXmmUMGqQJHr
 b6RHexeLxBnb2AlJ/POf/ea7ybCOJULR/uzEjTxuVj/df5xc0a7J2ND2Voff0cb9rTp/iMBa882
 MqpIOwu9dvzr+UIrcMe262o2EnJ1XLPUKfkeW6AV4J5VfAAA=
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

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index bf4ab4eaf269..6f06f7b4e992 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -243,11 +243,11 @@ static const struct drm_bridge_funcs tfp410_bridge_funcs = {
 	.attach		= tfp410_attach,
 	.detach		= tfp410_detach,
 	.enable		= tfp410_enable,
 	.disable	= tfp410_disable,
 	.mode_valid	= tfp410_mode_valid,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = tfp410_get_input_bus_fmts,
 	.atomic_check = tfp410_atomic_check,
 };

-- 
2.54.0

