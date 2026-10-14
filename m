Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE60CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C597410FECB;
	Wed, 14 Oct 2026 17:27:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACB610FEB1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E29396022E;
 Wed, 14 Oct 2026 17:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC2D1F000C4;
 Wed, 14 Oct 2026 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998868;
 bh=AolVmKEED5sCbLGkAUjBaKgNF5mwr1Lh9+BEy1xv2E8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=D4tjrGYx4lHwufmBCMgPusH2VLEpqgb7w54Mbl+mvyIt3SbNm4yiEvvaoYSjJGa1w
 F6w6UGoEwIhZXnFvMNkmrPbBCMyJ3bOX1LaVpeDR0JnT9ZkqoElZcndDO2v6wZko0r
 aIJSdNKhGbutmWuUqj2hFKi3wuLTTBwU6SIEnO9IrspANworHNXHDuPmPKFVgQCDIQ
 3ml23Vc3BK/Ki7emaBCIviQATxyTkjF/C6/MFKXH+8O9Z0Mq9fHsU7+hLWVRBiLUud
 K+TUAMgQwJlJ6G3fssj+sregeKwzowYJhnwDDUiT9mc94MkIhsW11sJLss+1XnR4Uf
 pUBSgNfWmLfuQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:33 +0200
Subject: [PATCH 10/75] drm/bridge: chrontel-ch7033: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-10-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ol0W4L/iY6600posSMQ0cOwKszT2pCmeyp14Ixs+ohs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd/vVvA8OKI5vZ7cyN+Ypt70qY/bm0du3rQYXgjru7
 dTuvfSgYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyEg4GxVma3w8HFtasV55oX
 2zt9kX4baGfmtO/B1iP3K9vjyhp8cxz97bxUxAtF3XaoPZ1gsXI9Y7139zK+OZz70/dpXf9V2xz
 3plVcxei2d0jL1htVp6UeJ0vxPX7iebR6Hc+xL24L9j9h1AcA
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

The bridge: chrontel-ch7033 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 4bc64b2885f7..a0ce41aa2f4d 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -216,11 +216,11 @@ static enum drm_connector_status ch7033_connector_detect(
 
 	return drm_bridge_detect(priv->bridge.next_bridge, connector);
 }
 
 static const struct drm_connector_funcs ch7033_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = ch7033_connector_detect,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

