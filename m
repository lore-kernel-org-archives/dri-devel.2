Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB8DCD6E56
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80846112848;
	Sat, 30 May 2026 14:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oPwgZmoI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21F511283D
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AADA040A77;
 Sat, 30 May 2026 14:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189541F00898;
 Sat, 30 May 2026 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149745;
 bh=BTKaBelxUM/qCcGqOEQNGd4yhVkJO9bWIJELzlwEBx0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oPwgZmoIHYt9VuiWnAMNbhT4UO038MrNuMDyM9YiD5xFSyPlBvKvJ+xcdtHTvst5r
 u+gejggR7cX40apR54v5KPywX5uSNji5+5otzgJTsfbhMmNZ8VvmAhkhIs4pPIYs0k
 eXGG6tJdUN69x4IcTatAB1PU0ueDpLpTzcx4aK0y+fPUYsUdnnkaiAcr94cbAmfBh8
 AeliI5nHeUc/3e0bRQz0j5yDymInVUJWbpVu+4/GVsiSt0oet3GySJ8v5h0yAoKK29
 3MNColTxJ+oO1nq5larfNFah7FOqnQ5YP10IZCK6OG8ozNhLE30tM1bqMSg6D0mPFv
 TtHcbpgB0kfUw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:01 +0200
Subject: [PATCH 56/76] drm/msm: hdmi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-56-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=mripard@kernel.org;
 h=from:subject:message-id; bh=afUk+XxiqZHyr9iSd9H3jebCZHV+7yMLkFllehElhaU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb/1aWi6etshauVX225GGU6Grlqr8rJ9d8uzV5oJLS
 uyS89h/dExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICLbGOsT9k1+aZ/YLrZRGdN
 RRPJi8HRNhn7l22XsNvCmf491cm9Xu331JqX1xUPXzxhrx0i/vI0YxXTrLwVGyP0uHZMm3rO7t3
 ZLZ6hn643X9M5dGnJwwui78PvJmj/qdfK2dqz8FBteM5nzqkA
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
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index c4d5e0faf3b3..7abb9243dba5 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -453,11 +453,11 @@ static enum drm_mode_status msm_hdmi_bridge_tmds_char_rate_valid(const struct dr
 }
 
 static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable = msm_hdmi_bridge_atomic_pre_enable,
 	.atomic_post_disable = msm_hdmi_bridge_atomic_post_disable,
 	.edid_read = msm_hdmi_bridge_edid_read,
 	.detect = msm_hdmi_bridge_detect,
 	.hpd_enable = msm_hdmi_hpd_enable,

-- 
2.54.0

