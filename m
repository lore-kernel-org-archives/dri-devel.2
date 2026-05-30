Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94DBCD6E56
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0881A112810;
	Sat, 30 May 2026 14:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KZIsQZvQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DF711280B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E85F41B11;
 Sat, 30 May 2026 14:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C11E1F00898;
 Sat, 30 May 2026 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149646;
 bh=Tj8unCUkhbDUBSl+Xj0tYq1Zh52zIBj6K9rHKUc36FY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KZIsQZvQQPf32J1FrDtcwJ07sYVILK4/fTfiBSlRdf0S21yuVtlgFayVZo1P2I6Il
 T7hu259sHMnwc7N8G/mgO3ba0n8c1imW8bb8bqotbv4G37LbXuWoR4YMH7lzIiaXgx
 pacthe5jBpdG5l9Nn4qx8ihCP2g0d4tRh3aXH8nexXgvq+uACbbgv0MLlrMJSk5SNP
 pgrTg/4oqqjel+G1IAUQtihyWyi+Z7n3DZM375geboe+xe+E8GNgT/BZb+OfKjUFKt
 xywtGDv1r2x2NV+pEx3mxDbShY5fAnu1Uf3986HtgLl1lYm53om5bBSDVSiqVpHgbD
 Tvhi+bsKy/+1A==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:24 +0200
Subject: [PATCH 19/76] drm/bridge: ite-it6263: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-19-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/wfbqM/Oa38y3ZtgAKXqe9/RK1YmjUUfRfsT1j+waCY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb237p7gmTQ65sl3Rt+mnntcG18hPvKKPbnvudPXKC
 1hb/dCuYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkYChjfcYdR62LbluND3y8
 7rXchCvzeUrAN5ENDprMAk9+8r2I/fTIlrPu05ZFK2/pvzoadrf3MmPDa+5LZm3zlS1jl0hfqjt
 gwp1+9LsrQ2SCyN/+WZPYCqruzTn040KU7J53ld4xl6fsT+oGAA==
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
To: Liu Ying <victor.liu@nxp.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index c7d588be12cb..4c0b670806cc 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -827,11 +827,11 @@ static int it6263_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs it6263_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it6263_bridge_attach,
 	.mode_valid = it6263_bridge_mode_valid,
 	.atomic_disable = it6263_bridge_atomic_disable,
 	.atomic_enable = it6263_bridge_atomic_enable,
 	.detect = it6263_bridge_detect,

-- 
2.54.0

