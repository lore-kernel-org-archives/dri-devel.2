Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DC5CD6E58
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0216111281D;
	Sat, 30 May 2026 14:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PNbcnctR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237DA112814
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0ACE443655;
 Sat, 30 May 2026 14:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675181F00893;
 Sat, 30 May 2026 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149656;
 bh=nqufeOgdI3m73uNj2m62LOMyWkhFB60TxXUtkSeqRxU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PNbcnctRB1quiniGCEay5gjZRfFdiB/CQ4NV/HyQLvlHIhou5xYeNdl1oz54nwfZY
 8jxFkYeHOGpORM7Z6ZDch4q1fgxMaOoQ86XQl7SLuXWqHpJY6eK7A+hBEIdjuacbVG
 fVz2ioDy7c0c6KlpSZhvlD3+Le2o3yaYghjTK/2b4sQuIfnJ/xqN86KRnRCLnkE/1U
 RdJh856u5r7OrQyTKYoFy2lBprvz15A9DkqXnOlRP8iyqEeFUfI96zqsHtARcV93dQ
 pRmP3+atNznLr5jXOWOJwrDC57ZelNsOjd55XWm1QnIltB1wgIv9NWjKatlKMzlQ01
 hx2u3y26/Lorg==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:28 +0200
Subject: [PATCH 23/76] drm/bridge: lontium-lt9611: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-23-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=mripard@kernel.org;
 h=from:subject:message-id; bh=GsZe9iYrObL9BehQl4lMjU8ENTMdCEfuuUdaHSfKlZo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb+136jbNDv/xuNL3VNn6J9MPnt0W0HdA6mXYhug0p
 m+/oo9od0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJyG9kbJhgeHXegpSDJQ8U
 zzisVXD5vL4tsEAnxSrcmWlbaf75/bkNUb9nm+afCTG1f9yR7d35grHe9+GWNbsuCsr+MVhsydU
 j1my/uWLKHVG5vcy2b5TDHY6IW7Z/9NfIst+zZk1u9eHtFp4A
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
 drivers/gpu/drm/bridge/lontium-lt9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 21305296e111..b6a368f71285 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1024,11 +1024,11 @@ static const struct drm_bridge_funcs lt9611_bridge_funcs = {
 	.atomic_enable = lt9611_bridge_atomic_enable,
 	.atomic_disable = lt9611_bridge_atomic_disable,
 	.atomic_post_disable = lt9611_bridge_atomic_post_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = lt9611_atomic_get_input_bus_fmts,
 
 	.hdmi_tmds_char_rate_valid = lt9611_hdmi_tmds_char_rate_valid,
 	.hdmi_write_audio_infoframe = lt9611_hdmi_write_audio_infoframe,
 	.hdmi_clear_audio_infoframe = lt9611_hdmi_clear_audio_infoframe,

-- 
2.54.0

