Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982E1F532FA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE7510E60E;
	Tue, 24 Mar 2026 08:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OKw1YMxP";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D0A10E60E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:58:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 025441A2FC1;
 Tue, 24 Mar 2026 08:58:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C689E6011D;
 Tue, 24 Mar 2026 08:58:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 151AA10451140; Tue, 24 Mar 2026 09:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774342719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=8mMcYEXUydZGS/Fj4aUMVLorw/18mDZTJVFYNGb7XMU=;
 b=OKw1YMxPQSbqPviE7lZb7Y5jieL3u4cLiz2S2nUo4eSx+5JokOgnDrZaIHHF0y02LT0mHt
 rss3/bSjgNYJsJ+aGjCOuWFEpeF0JBIbRxL4JwwT4OoO3UT3USGNerr3saWXm21Fcl7qDU
 nTDcc1SGM3YkqfobgsLsSywcHqYCtyjMrlTSYlon/km1jXQa4UEX6TdumtAHRYkUS7TaB5
 UTXebyG1KF9x9inoeUzDC394kwqG3Mc2laPbc2+mgsYz865T0806zuHysqXZJIARDgIH7s
 VLByfDXLWRSIvsfDjS+f8jFDS2xaczRYlAUz5KSsMAYdKGbn2jRlJvokQInGOQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 24 Mar 2026 09:58:12 +0100
Subject: [PATCH v5 5/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_from()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-5-8bf786c5c7e6@bootlin.com>
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
list_for_each_entry_from(), which does not prevent changes to the bridge
chain while iterating over it.

Convert most of those loops to instead use
drm_for_each_bridge_in_chain_from(), which locks the chain.

This also simplifies code.

All the "simple" loops are converted here. The only ones not touched are
those in drm_atomic_bridge_chain_pre_enable() and
drm_atomic_bridge_chain_post_disable(), because they have nested loops
which are not well handled by drm_for_each_bridge_in_chain_from(). Those
two functions are handled by a separate commit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 42ca4b243579..37feb8143de4 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -725,7 +725,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 /**
  * drm_bridge_chain_mode_valid - validate the mode against all bridges in the
  *				 encoder chain.
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @info: display info against which the mode shall be validated
  * @mode: desired mode to be validated
  *
@@ -739,17 +739,14 @@ void drm_bridge_detach(struct drm_bridge *bridge)
  * MODE_OK on success, drm_mode_status Enum error code on failure
  */
 enum drm_mode_status
-drm_bridge_chain_mode_valid(struct drm_bridge *bridge,
+drm_bridge_chain_mode_valid(struct drm_bridge *first_bridge,
 			    const struct drm_display_info *info,
 			    const struct drm_display_mode *mode)
 {
-	struct drm_encoder *encoder;
-
-	if (!bridge)
+	if (!first_bridge)
 		return MODE_OK;
 
-	encoder = bridge->encoder;
-	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
+	drm_for_each_bridge_in_chain_from(first_bridge, bridge) {
 		enum drm_mode_status ret;
 
 		if (!bridge->funcs->mode_valid)
@@ -767,7 +764,7 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_valid);
 /**
  * drm_bridge_chain_mode_set - set proposed mode for all bridges in the
  *			       encoder chain
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @mode: desired mode to be set for the encoder chain
  * @adjusted_mode: updated mode that works for this encoder chain
  *
@@ -776,20 +773,16 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_valid);
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
-void drm_bridge_chain_mode_set(struct drm_bridge *bridge,
+void drm_bridge_chain_mode_set(struct drm_bridge *first_bridge,
 			       const struct drm_display_mode *mode,
 			       const struct drm_display_mode *adjusted_mode)
 {
-	struct drm_encoder *encoder;
-
-	if (!bridge)
+	if (!first_bridge)
 		return;
 
-	encoder = bridge->encoder;
-	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
+	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
 		if (bridge->funcs->mode_set)
 			bridge->funcs->mode_set(bridge, mode, adjusted_mode);
-	}
 }
 EXPORT_SYMBOL(drm_bridge_chain_mode_set);
 
@@ -1013,7 +1006,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 
 /**
  * drm_atomic_bridge_chain_enable - enables all bridges in the encoder chain
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @state: atomic state being committed
  *
  * Calls &drm_bridge_funcs.atomic_enable (falls back on
@@ -1023,22 +1016,18 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
-void drm_atomic_bridge_chain_enable(struct drm_bridge *bridge,
+void drm_atomic_bridge_chain_enable(struct drm_bridge *first_bridge,
 				    struct drm_atomic_state *state)
 {
-	struct drm_encoder *encoder;
-
-	if (!bridge)
+	if (!first_bridge)
 		return;
 
-	encoder = bridge->encoder;
-	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
+	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
 		if (bridge->funcs->atomic_enable) {
 			bridge->funcs->atomic_enable(bridge, state);
 		} else if (bridge->funcs->enable) {
 			bridge->funcs->enable(bridge);
 		}
-	}
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
 

-- 
2.53.0

