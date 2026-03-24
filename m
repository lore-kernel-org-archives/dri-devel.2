Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB200F532FA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B67610E631;
	Tue, 24 Mar 2026 08:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YrdDbir6";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412CE10E61E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:58:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 29C614E427C2;
 Tue, 24 Mar 2026 08:58:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F377B6011D;
 Tue, 24 Mar 2026 08:58:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D8C11045102E; Tue, 24 Mar 2026 09:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774342722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xkYRQmcUW+vz3mQLioPyVbL+TZwJhHqNYTwGvfKyZfE=;
 b=YrdDbir6GZlI1kcr4S2j6bOvWj3+3LGq6mg5uHOGYzBY44yHrZ45N4hH6mTZCvRI6Qviii
 6iAIaZU3VswrTmcMwwG91MYqA8bHx1PETYHGp4D7MS/ObgPaoKHZpNlpfoTAWGwFbjiDdC
 iNfxGpYhINg2tpoEmvSOBOfSkCMG02ZjdpxY3RUvoo5d4JtaGtywIrKaqbmpM0cnF0XrVf
 4nEjNSQ9N9Bqv2CVUv8uH8q3BxLRwACm8ZMu+uWeGZuv9h0H08aqnEADEbg6BQSwlD9e+t
 166XcDmuGWSTFR/LKIxE5t52ZI5eDHPnXPKwnPJ5v+NHJcAuFrHmhLr6VMy2vg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 24 Mar 2026 09:58:13 +0100
Subject: [PATCH v5 6/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_reverse()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-6-8bf786c5c7e6@bootlin.com>
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

These loops in drm_bridge.c iterate over the encoder chain using
list_for_each_entry_reverse(), which does not prevent changes to the bridge
chain while iterating over it.

Take the encoder chain mutex while iterating to avoid chain changes while
iterating.

All the "simple" loops are converted. drm_atomic_bridge_chain_pre_enable()
and drm_atomic_bridge_chain_post_disable() are handled by a separate
commit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- Lock encoder->bridge_chain_mutex directly, no wrappers

Changes in v2: none
---
 drivers/gpu/drm/drm_bridge.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 37feb8143de4..c76f3451af39 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -808,6 +808,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		return;
 
 	encoder = bridge->encoder;
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->funcs->atomic_disable) {
 			iter->funcs->atomic_disable(iter, state);
@@ -818,6 +819,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
 
@@ -1322,25 +1324,27 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 		return ret;
 
 	encoder = bridge->encoder;
-	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
-		int ret;
-
-		/*
-		 * Bus flags are propagated by default. If a bridge needs to
-		 * tweak the input bus flags for any reason, it should happen
-		 * in its &drm_bridge_funcs.atomic_check() implementation such
-		 * that preceding bridges in the chain can propagate the new
-		 * bus flags.
-		 */
-		drm_atomic_bridge_propagate_bus_flags(iter, conn,
-						      crtc_state->state);
-
-		ret = drm_atomic_bridge_check(iter, crtc_state, conn_state);
-		if (ret)
-			return ret;
+	scoped_guard(mutex, &encoder->bridge_chain_mutex) {
+		list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
+			int ret;
+
+			/*
+			 * Bus flags are propagated by default. If a bridge needs to
+			 * tweak the input bus flags for any reason, it should happen
+			 * in its &drm_bridge_funcs.atomic_check() implementation such
+			 * that preceding bridges in the chain can propagate the new
+			 * bus flags.
+			 */
+			drm_atomic_bridge_propagate_bus_flags(iter, conn,
+							      crtc_state->state);
+
+			ret = drm_atomic_bridge_check(iter, crtc_state, conn_state);
+			if (ret)
+				return ret;
 
-		if (iter == bridge)
-			break;
+			if (iter == bridge)
+				break;
+		}
 	}
 
 	return 0;

-- 
2.53.0

