Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54036CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CF410FE7D;
	Wed, 14 Oct 2026 17:28:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EAA10FE9B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D82CC602D3;
 Wed, 14 Oct 2026 17:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DAC1F000C4;
 Wed, 14 Oct 2026 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998879;
 bh=2FB8M7EumKISKdC58rwc+VWvevt9m8ArJeyNEiYnTiI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nEKqOVF/KA8zDmTb0wpSG9souHth04Mt5fnuovowMRSuDpcVyZk6HBhCLiUeqa2Tf
 kHndCe0OVJsVmUnfcNKV/IWOFvap4DdkIKhhKAlJRVdp1adNEPsSwURIKzlbCQOoi/
 b1V1C/6WtCPnjHiE0ZOOZYdGZPW22Ys6hrgKsGybhtMTyuCtwPtXVQZIazdy+xoNEy
 DVDK4SpI5+u52ByQfPAkvm63bQ1Gu8F0mfKzO9/JP1UFeUpbWJ3UnubT6utG+FDMz4
 eI9ESQEV8ODf2pWxzLwOcxnHN1SESWRDxRUVeAMqc00r90PXmhPCXMAcuuKgN/GJzU
 rGNucGL7Rh30w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:36 +0200
Subject: [PATCH 13/75] drm/bridge: nxp-ptn3460: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-13-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gzXvueeoMmrBwD7vwkDnilxCS1WMtN5rOC9tuohWvBA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndwfseBhn9VL7o5laSMnxKTqpV98zuMsnt/vFsTQ3r
 T7rVvOlYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyknIWxYXFHqwGD4cGHCz7n
 blvx4i1Pxkef/gPLVi3ZU9+RGuNuINvk9O7EY/sUm1oNU+9Pc/JEGOu0YleJu3h+DttaXfpmWVB
 j7PQnX05vlvRMXyg/9avH/r+9U1lf7/FK8NSXq+d9LLr9gSsA
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

The bridge: nxp-ptn3460 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index f9eff8bfceb7..be6a06130ba9 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -208,11 +208,11 @@ static const struct drm_connector_helper_funcs ptn3460_connector_helper_funcs =
 };
 
 static const struct drm_connector_funcs ptn3460_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int ptn3460_bridge_attach(struct drm_bridge *bridge,

-- 
2.55.0

