Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737FBCD6E59
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C02112858;
	Sat, 30 May 2026 14:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y2UXDDN8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8566311281B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08DB6600CB;
 Sat, 30 May 2026 14:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D27F1F00893;
 Sat, 30 May 2026 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149675;
 bh=mTOWSmbcZfvRFjVGwih3S7AYBPVcPOSYHnTQZQvvyHA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Y2UXDDN8UYvnU/IXJy8z9kHuV7ndTmgBK+LJrCWPSFuu5lvQ+cJAHeAfbjfXIZaMp
 dgdLiLOq96Om3Upz/FkUDglaGyZhbDXBl1V3aCseLE9cQrCJ538p6A/M7slPPniERe
 AdicHh4FbsMf7QLC1AQ+0CNN8jCxybtfFlVt8+JPgPec9U+H+wzccWzi/qPy8Znvy1
 ZoIfvbAJZDqdz1C/LTKbopAhpYKwlge8eFHP+/6GPpLXb6YVqjBoLk7X+hRqAfFX60
 nvdZhz98NWLHx49HgyY3alfpVemYGbfUSDNAva51ocLfcenlDH4Co1C7dzpiNdP7p/
 DoxtxR87SkHDQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:35 +0200
Subject: [PATCH 30/76] drm/bridge: ssd2825: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-30-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ud09aQ8GBvlpgJuIMcsm/eGEsqqTyXRDZtAYig1fyz0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb51arTqWa5dVvlj6sDLIkTl+TmN4RMyPZmlpVtaOa
 6YSVxd3TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIls/M5Yn3bxxs7rjuUxxz/7
 yv950np/svX2SOUD+w7rWt/g+R1y9+r2gEszV6nM+end38M5h6svmrHhk6luXcbXuZOiNiQpWpj
 5XP0n5rPsK8/muY9TNjyYMENLP2X/Tx/ryo6bBu/jVjUFKYsDAA==
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
 drivers/gpu/drm/bridge/ssd2825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ssd2825.c
index 91f1510fc2d4..e345f3a652c2 100644
--- a/drivers/gpu/drm/bridge/ssd2825.c
+++ b/drivers/gpu/drm/bridge/ssd2825.c
@@ -678,11 +678,11 @@ static const struct drm_bridge_funcs ssd2825_bridge_funcs = {
 
 	.atomic_pre_enable = ssd2825_bridge_atomic_pre_enable,
 	.atomic_enable = ssd2825_bridge_atomic_enable,
 	.atomic_disable = ssd2825_bridge_atomic_disable,
 
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 };
 
 static const struct drm_bridge_timings default_ssd2825_timings = {

-- 
2.54.0

