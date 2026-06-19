Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD884CDB46D
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E99B10F59C;
	Fri, 19 Jun 2026 12:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lCAmBpsl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7329210F598
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C266432CC;
 Fri, 19 Jun 2026 12:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10E21F000E9;
 Fri, 19 Jun 2026 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872019;
 bh=xPcGnIadXQOwdqe+TLymtDkJ8fTrIgYe8CjnB+YDSLQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lCAmBpsl5ipVMFJmVYV0YTjteebawj3Kz0juNyJYA8153YQmO6rYZABY5c9WdKbdD
 uL2GxXtCxyus+M8qTtnI+MNehSo74iCUN0sWB9oOenpBYSyjkSMYp+s7vt98JNkgcA
 Hfwe8Vsu9K2zNPR9VgBimotzdcMI9xUdWHsWisY8lruboAVvQM2CBuWEEg9YmTilKT
 iVppiBPZ0L8XG3+NQpv+laOKXmIJqGLFxkkEJ5bm4BOl31qqWUVYBUjJ6ZtVDSPXja
 O9eXCEBIpOwOqyaJ1gXc2ON+ryUzSJRPSd1wcP6NnarSa9oXNKkm7BJYOo/3psgF+B
 obxa6RVKh1/MA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:54 +0200
Subject: [PATCH v3 49/78] drm/mediatek: dp: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-49-ff399263111b@kernel.org>
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jz6L3HbTOuL/AOU5+FFO6YQirDqIpCsslS4eatsCy0Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJv+PR+R8rVOWqY2z0dvJ7PXS/eRDOWH1dxtnWRVtm
 7nJ7t/RjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRmB2MDTc9nuUuZaj9XL5b
 he2i976W1xO2f8i+lzD5lovRYa4Lfra5Ka7tvSVzM9dq/fB2fnvqBWPDp9TD8dnRMvefiFxI+eP
 z45nTmlOcFWcLriz52CbtPYmPT/fZmZPFefXd9z+90Nuarr4MAA==
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index eefbc7e0f9c8..f656b85b8421 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2576,11 +2576,11 @@ static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
 	.atomic_check = mtk_dp_bridge_atomic_check,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_output_bus_fmts = mtk_dp_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = mtk_dp_bridge_atomic_get_input_bus_fmts,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = mtk_dp_bridge_attach,
 	.detach = mtk_dp_bridge_detach,
 	.atomic_enable = mtk_dp_bridge_atomic_enable,
 	.atomic_disable = mtk_dp_bridge_atomic_disable,
 	.mode_valid = mtk_dp_bridge_mode_valid,

-- 
2.54.0

