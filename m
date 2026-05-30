Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAA2CD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFE711282F;
	Sat, 30 May 2026 14:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SPu1HPR4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34ADC112824
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C7C040616;
 Sat, 30 May 2026 14:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797EB1F00893;
 Sat, 30 May 2026 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149708;
 bh=SA0dd92F8IAqI6peooaD9MwTBcNQsH5B8C1aoai/PNI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SPu1HPR4EXDunIsfYPdlYMnEZUnc6oYbO/kl/QuaftTe8lfCwjpC1QjcxdZRWWuQr
 ER9UtOGUNAVgBRC5133ylkjhBCVhE5Yt7P4E9tqCG7mvaLrGV4nR/gLYjrsTwfCFG7
 Kq+z/7OEtGo6qm4EJLw0s/993piAqeMufhgpdxKy5Jja7FK1KrTwwLP8jQyKINa3q1
 2zqLFPXSUQ8AGx51JmaDkq40ElhZOL3IO9BjDZqHd6o8+ivHzdNiEfjg1h5C0PtpYu
 HcrZ9OJkelMo3cvCyKPkFhHKeDZWLUXekXa7gEyi/po90W7eDjsA82wdVmcjfPOtlD
 Tg1K6FQtIpZWA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:47 +0200
Subject: [PATCH 42/76] drm/bridge: ti-sn65dsi86: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-42-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dZYaNdZB3HK0Hu3m/tVJHFwi4sOIfGlinljiJ/blunA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb915DJILdDd3ToqUV518wezjzY7nX97d3t36Wig15
 FnC5MenO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBENjIyNlye86oydWVBJeP0
 1ieMBVJvZ0wMS3PbXCNRKs5e33D105wlNQXWvc/qeWxStF6un58pwFif9ZbrGc93n3bx/ynCls3
 3lBcyGS65mr9bgmHzTx6hqnMl8x7t2fI86CAjm66ToHB1yX0A
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
To: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 0884ec459cc5..1da242f17413 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1300,11 +1300,11 @@ static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
 	.detect = ti_sn_bridge_detect,
 	.atomic_pre_enable = ti_sn_bridge_atomic_pre_enable,
 	.atomic_enable = ti_sn_bridge_atomic_enable,
 	.atomic_disable = ti_sn_bridge_atomic_disable,
 	.atomic_post_disable = ti_sn_bridge_atomic_post_disable,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.debugfs_init = ti_sn65dsi86_debugfs_init,
 	.hpd_enable = ti_sn_bridge_hpd_enable,
 	.hpd_disable = ti_sn_bridge_hpd_disable,

-- 
2.54.0

