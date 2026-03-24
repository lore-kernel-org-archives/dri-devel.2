Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BE7F532FA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBE310E625;
	Tue, 24 Mar 2026 08:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hpkP6J7/";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC87510E623
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:58:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B43C04E427C2;
 Tue, 24 Mar 2026 08:58:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8AED06011D;
 Tue, 24 Mar 2026 08:58:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7088310451136; Tue, 24 Mar 2026 09:58:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774342726; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=KDcXJhmNEUUmoUs1F4dCWoL111Iv/TOQpcOGX7p6LwQ=;
 b=hpkP6J7/ceasAGc4roQHbAcxUkDzFIlRwwdfhixAyYTvs6CppC0BvruQIu3Em6CvB9JA8+
 HXwDLh1JRHly2H5djOEEDsA3LTobz7Eywl7i2gXe6Ui78LQEQVh/5QRD0QSX9tppfcE6GM
 uu+flGJSL7cbWNuhutUOknqF8yW5E1J7VaPb0d776kXNZnrpqW8MQJE5V1FUczyPuzEPkg
 qzyj8qttT5/Psnd7hqlTAssYkJ/d1yQUuotde3jNU6hrerZ5vhkjaAUs3XcRv45wMdCa2c
 2Gy2UpKvKO8QQF11NxNxNhu8pUKIidWXJXvL5qgxAWUGNF53OoLNjQUvpp0ZLA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 24 Mar 2026 09:58:14 +0100
Subject: [PATCH v5 7/7] drm/bridge: prevent encoder chain changes in
 pre_enable/post_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-7-8bf786c5c7e6@bootlin.com>
References: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-0-8bf786c5c7e6@bootlin.com>
In-Reply-To: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-0-8bf786c5c7e6@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

Take the encoder chain mutex while iterating over the encoder chain in
drm_atomic_bridge_chain_pre_enable() and
drm_atomic_bridge_chain_post_disable() to ensure the lists won't change
while being inspected.

These functions have nested list_for_each_*() loops, which makes them
complicated. list_for_each_entry_from() loops could be replaced by
drm_for_each_bridge_in_chain_from(), but it would not work in a nested way
in its current implementation. Besides, there is no "_reverse" variant of
drm_for_each_bridge_in_chain_from().

Keep code simple and readable by explicitly locking around the outer
loop. Thankfully there are no break or return points inside the loops, so
the change is trivial and readable.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v3:
- Lock encoder->bridge_chain_mutex directly, no wrappers
- Improved commit message

Changes in v2:
- Improved commit message
---
 drivers/gpu/drm/drm_bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c76f3451af39..29231730e1f8 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -867,6 +867,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
 		limit = NULL;
 
@@ -915,6 +916,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 			/* Jump all bridges that we have already post_disabled */
 			bridge = limit;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
 
@@ -961,6 +963,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->pre_enable_prev_first) {
 			next = iter;
@@ -1003,6 +1006,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 

-- 
2.53.0

