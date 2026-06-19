Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC5ACD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFC110F566;
	Fri, 19 Jun 2026 12:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TWY2xrzA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9063C10F56C
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 735964006B;
 Fri, 19 Jun 2026 12:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F371F000E9;
 Fri, 19 Jun 2026 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871914;
 bh=NPO3FcIiWDfmeQJkzBV9bTYrsuTU87auHXDZIVN6Xu0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TWY2xrzAGfwLLkU6VmfugBxhYiSkACoes/ZiClXoSjaHqU1JqgvogVLqmd1o6LzI8
 DarV43aqbDzmHdWuWlE4cia9uAjJaumXdJj6/zuwpV3WdWdW1PcNEZdd2K8aeLRUb+
 fXeqFAzxHXvt6T68EWB9FhF2FPkuTc8BKIb7ZdmnObKvtyJwQQcMMYMkZpEZS36zG3
 DfiVrkXE/AkwDj/b54mJwo3x1LxxCO+e7M/ZR0thf/DvxBNjraB7gpZ35Q4+xNzvUB
 6Fd5MNBDGXf09Am6irvv1fAnWtyexk56Tk1eCUBtq0B8OBqwyI+D6Jr7Hv1cuhFxdk
 1xRVsiop9M3GA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:15 +0200
Subject: [PATCH v3 10/78] drm/bridge: anx7625: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-10-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QFAEATal3+wjPn8ucBdTKyeRgZtJRXxn8AK1ehiK0MY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJu9ED4j3zjmb4tj1KuH4jn7tWuvjU8SOJzFWN7J0c
 O74kXmsYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyE/ydjrdTzID4R3r3OehwL
 ftt9nfrvwNPLJj7fz1SJTzXKd/ryxeldYeFDi/X7O22Ct/4Om/ghm7Hhfdbi58f7Z12+vfiRGYu
 9sJOwmFzg0quSK37uCt5+2ZJpytbtS/68mjBXQMcz6NPlbWVLAQ==
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
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 513c11cdbc74..2e2c6d925506 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2677,11 +2677,11 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
 	.atomic_check = anx7625_bridge_atomic_check,
 	.atomic_enable = anx7625_bridge_atomic_enable,
 	.atomic_disable = anx7625_bridge_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.detect = anx7625_bridge_detect,
 	.edid_read = anx7625_bridge_edid_read,
 	.hpd_enable = anx7625_bridge_hpd_enable,
 	.hpd_disable = anx7625_bridge_hpd_disable,
 };

-- 
2.54.0

