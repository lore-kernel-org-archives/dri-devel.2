Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C14CDB466
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8DF10F598;
	Fri, 19 Jun 2026 12:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JBzDI3ho";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB9110F595
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 416C2601E3;
 Fri, 19 Jun 2026 12:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744B11F000E9;
 Fri, 19 Jun 2026 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872006;
 bh=oSJpS1z2vXHmxaGCPnf+v6pZUmXde2xn8LfrzqIj/po=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JBzDI3ho8dkWoyzo6MSsvT/kCox2YdkClXBhBFYZa4kzbvC1+e3xpJ3W31H8IEX/u
 XM3+wjvwNwncIuBQk0SNof3i9pmKq5ioyWq4EsSHb646PJT9tezVRHfc6S5o88U56p
 aKDRDV9QV9ASVTGCd/cfcfBLIJSi6CKgtTIMTQB0uVnD3/ozcuMQ2hgjz+PdXkZt/H
 lSHSkP5oix3Gry0P1qglG5LV/t4yOj9B0LJbqEH/Dezvnr99j7V3sJWSLhrLnRWxSO
 4O12Q/g5MQYRKgHKmk8HDXo5vCYvcygAMKrJ9BCD6dgMapT7MOc1RsoRUZ7Q2llkLR
 stUcprwch/Ldw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:49 +0200
Subject: [PATCH v3 44/78] drm/bridge: ti-sn65dsi86: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-44-ff399263111b@kernel.org>
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
 Douglas Anderson <dianders@chromium.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uDASBSXKnVoUUMH8XNAx7DjYkrwZFsU9fSmzKxyQT9Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJn9nJW3uON0W07rea/79B2923Zhxqqznf67B4XM+f
 D3lFT/yOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEfGIZ62OcvrMIseoc5y/6
 8OmppeTHr87rbl4IFJy1LqojuMzEK9dXrlVkKkfU46Kcqs9TzzD1MtYZXrwZZFl+LWpNXMglodp
 ertuCkz3uxy98ukORif+kFbNi/LkoXlnnk3vbLszdv0Q4YSIA
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

Acked-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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

