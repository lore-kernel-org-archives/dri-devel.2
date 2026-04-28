Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C260FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE46D10EAA9;
	Tue, 28 Apr 2026 09:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gZtWpc3Z";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB6710EAA7;
 Tue, 28 Apr 2026 09:16:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 505641A346B;
 Tue, 28 Apr 2026 09:16:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1C9D3601D0;
 Tue, 28 Apr 2026 09:16:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E8C610728631; 
 Tue, 28 Apr 2026 11:16:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777367772; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9eo/paXSzW8BfmZpRrcP3BLHcobk12GzzlOo9kVEISI=;
 b=gZtWpc3ZSRRnd4uPBXmVObuxc8b70mdizyNzto8rtZS1uImrEoGxPYW2eTiuMOOfzCqDjp
 Gw8wYAtxuRZInF9j7CBINLwawUlx+8x6aem3/QfVJSj+bmiTPXWXg0kTLu3vZUieVtk2wM
 n6ut4ZYM14a13BLpseFPBxKlMdcLVd88zkxJCzwIRgDx3f/fxoRgL02agg+PJ56wJPxsf1
 vuXmJAoFzrhpr9gWE4FcL7Df2HczNsU97jnIx+AXD3Uw89/vzRdru5i8q3lVsrAgd5vMQn
 0qdgr8ZQW+Fq2cevjahutli9RnM0D2qEv45DR87Eo1ZksS86gKaeuFbz1KsukA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 28 Apr 2026 11:15:47 +0200
Subject: [PATCH v2 01/11] drm/bridge: drm_bridge_get/put(): ignore ERR_PTR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-1-4300744a1c47@bootlin.com>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
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

Most functions returning a struct drm_bridge pointer currently return a
valid pointer or NULL, but this restricts their ability to return an error
code describing the error kind.

In preparation to have new APIs that can return a struct drm_bridge pointer
holding an ERR_PTR (and for those which already do) make drm_bridge_get()
and drm_bridge_put() ignore ERR_PTR values, just like they ignore NULL
pointers.

This will avoid annoying error checking in many places and the risk of
missing error checks.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/all/20260318152533.GA633439@killaraus.ideasonboard.com/
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/all/omlnswxukeqgnatzdvooaashgkfcacjevkvbkm6xt33itgua2k@jcmzll2w6kdq/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Patch added in v2
---
 drivers/gpu/drm/drm_bridge.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 986e4c79a4e0..cea5babbe99e 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -282,7 +282,7 @@ static void __drm_bridge_free(struct kref *kref)
 
 /**
  * drm_bridge_get - Acquire a bridge reference
- * @bridge: DRM bridge; if NULL this function does nothing
+ * @bridge: DRM bridge; if NULL or an ERR_PTR this function does nothing
  *
  * This function increments the bridge's refcount.
  *
@@ -291,7 +291,7 @@ static void __drm_bridge_free(struct kref *kref)
  */
 struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge)
 {
-	if (bridge)
+	if (!IS_ERR_OR_NULL(bridge))
 		kref_get(&bridge->refcount);
 
 	return bridge;
@@ -300,7 +300,7 @@ EXPORT_SYMBOL(drm_bridge_get);
 
 /**
  * drm_bridge_put - Release a bridge reference
- * @bridge: DRM bridge; if NULL this function does nothing
+ * @bridge: DRM bridge; if NULL or an ERR_PTR this function does nothing
  *
  * This function decrements the bridge's reference count and frees the
  * object if the reference count drops to zero.
@@ -310,7 +310,7 @@ EXPORT_SYMBOL(drm_bridge_get);
  */
 void drm_bridge_put(struct drm_bridge *bridge)
 {
-	if (bridge)
+	if (!IS_ERR_OR_NULL(bridge))
 		kref_put(&bridge->refcount, __drm_bridge_free);
 }
 EXPORT_SYMBOL(drm_bridge_put);
@@ -319,8 +319,8 @@ EXPORT_SYMBOL(drm_bridge_put);
  * drm_bridge_clear_and_put - Given a bridge pointer, clear the pointer
  *                            then put the bridge
  * @bridge_pp: pointer to pointer to a struct drm_bridge; ``bridge_pp``
- *             must be non-NULL; if ``*bridge_pp`` is NULL this function
- *             does nothing
+ *             must be non-NULL; if ``*bridge_pp`` is NULL or an ERR_PTR
+ *             this function does nothing
  *
  * Helper to put a DRM bridge, but only after setting its pointer to
  * NULL. Useful when a struct drm_bridge reference must be dropped without

-- 
2.53.0

