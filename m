Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74E5CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04FB112816;
	Sat, 30 May 2026 14:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UFRf/i08";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D00112816
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1D98600BB;
 Sat, 30 May 2026 14:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306881F00893;
 Sat, 30 May 2026 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149667;
 bh=V8WFE7rShi5iiT+f5F5YQRBJhY5m9SPI8Hsl7g4pRFg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UFRf/i086GvPFDVhLEiAOt24JwpCXkr+19YZKfbAwyVgpacdDo9ngB/e40P220Fdx
 oxuFWbK7qbjWdV8BlvriuvqyhY2TVjGmSV14rzXrRQEQ4fOAxyydLdFsH7Z8tBlNE7
 7bNyrRfGxyot0eXRHK50X1RJW6yGEQaBNjiSaa6DM4/5fLq8hV5QfolLbjEAax3gPg
 BYrkZ8zTCIUz/VkpunTkN9aUnGDusksVD/uDN4PPC/vLrtHkouNaxPt6lkY0d1zXuP
 rsxJkUqTyk55hwHyWkwXLIZUoNrxKpjxK5AR3IqJn7FoJouXrPk37ftaiSaXYc7oCG
 xVAE5kpGqhm9g==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:32 +0200
Subject: [PATCH 27/76] drm/bridge: parade-ps8640: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-27-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=mripard@kernel.org;
 h=from:subject:message-id; bh=bPoeLRAr8mwRMpzHS9zQXK9JFNE7WeAv49OyZh0kQuU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSbx3rbsZN3pZ5MXWSiqTwtg1XlvC4XTe8Kit9aFpSf
 qRyR3Zgx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIyB3GWhmVB1MuTm74fiFG
 QVJm7d8dV7t3tRfWCJ9IUlvBKnCpV4bB2KI03N18hYP6N5/4h/+zGRtebNlo1Lfl/AORzc35jS/
 XXmvydy1JzFhfZy5dlP1p2sJNVrMtpKY7bNio/vyT/L47gXUA
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
 drivers/gpu/drm/bridge/parade-ps8640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index b93514023baa..96332721cb69 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -554,11 +554,11 @@ static const struct drm_bridge_funcs ps8640_bridge_funcs = {
 	.detach = ps8640_bridge_detach,
 	.atomic_post_disable = ps8640_atomic_post_disable,
 	.atomic_pre_enable = ps8640_atomic_pre_enable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 static int ps8640_bridge_get_dsi_resources(struct device *dev, struct ps8640 *ps_bridge)
 {
 	struct device_node *in_ep, *dsi_node;

-- 
2.54.0

