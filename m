Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5B6CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918A610F575;
	Fri, 19 Jun 2026 12:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b5Amosli";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D6110F571
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EEEE601E3;
 Fri, 19 Jun 2026 12:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FE31F000E9;
 Fri, 19 Jun 2026 12:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871922;
 bh=LEm5wW2HzzeUEuH+nCs0Q83EmjnOooRyg8U4sHfNzVw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=b5AmosliwKiry8/LTDdJ+LWFljE486HN3NGXpDT/9DVhlhoyqipl1/+ijW0fA/nc+
 kcqkrVF3ECGDdrul1NWdmJ51VahZr5le7EALOZTkf6CFISprHNn42m182gtFezFF33
 XfezOkJqSK39UwA5Uln4fxfcyM7LJd71yiXUMcgjCRO0/ZMg7/W3HMZlLSsxDmvWB6
 wXqHsPpjtUFEarp0sgMkotmQcKyjJ77X1a+dl8pYVq9lP3bvKJkAa1l/S8nn2EKnui
 38F9GVQxRsfR6Li26YDIoCruDEOR9H7wtlI71kz2uAb9s9OWG3JtrFah+asyO2+KuA
 1CpGkO0SSzz+A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:18 +0200
Subject: [PATCH v3 13/78] drm/bridge: fsl-ldb: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-13-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xArlQ1/BDN54BOV0GASWRuwEWV/K4cYzcPlWiJAatJ8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJu8jsmT2Vh3jM9VJq1LQfXveVk5h9vHEvZ63H0tfO
 Kuc+96lYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwkPYyx4VKgkuyrNs2T+z5K
 ywSVT/VTapjs9GbnPO7G37r7LVI/x+VZXq5l9xOb9ulaRaLHo2htxoaf/yos/HiFltvZ1F5YlWz
 M4563uOItm7frmbkZJ+a+m+7EeUf5rVe1kaGo86ei3bNTNwMA
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 9bfaa3f93370..cc1f88e7873e 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -287,11 +287,11 @@ static const struct drm_bridge_funcs funcs = {
 	.atomic_enable = fsl_ldb_atomic_enable,
 	.atomic_disable = fsl_ldb_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = fsl_ldb_atomic_get_input_bus_fmts,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.mode_valid = fsl_ldb_mode_valid,
 };
 
 static int fsl_ldb_probe(struct platform_device *pdev)
 {

-- 
2.54.0

