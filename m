Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85FBCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A26210F142;
	Thu,  7 May 2026 13:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="m+OAwk2t";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5074110F142
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:45:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9A36BC5DC5D;
 Thu,  7 May 2026 13:46:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DB18060495;
 Thu,  7 May 2026 13:45:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5AA3A108194AD; 
 Thu,  7 May 2026 15:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778161548; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gtuI/NuanHD3U7tvwm+d4uFTl+RmPkrMLjBzX+k18nU=;
 b=m+OAwk2t4Ac8cHrRYkYZUa5uRS0OoY57d22x3n808lZ9QUmHq6CMrfW7TXzozYC8iVYxnj
 eE2hdix7M+pOTDpv+XryjILyFNloZt+0yAZIgZ6VxbL8hXZUHOLy+iJwAk8Eb+rOBXZ40Y
 VMvz6ifEKJLHN7I+6I+iTquJ16/HphHDbnpgbZEBTCFLVpbp5zulKs1dKfKe6jL/R2It/G
 YLqvTLyWRe5CFJVBVn/ktBGC+A6nKKLyCBHp26mvo9/q7h42nADRxfAtvuDAq9CXgIUeJG
 BEOgBwvYOaRC8EAzQOrT+Xmru7UiqfYix9SslCGgPLkXMt2GN11AMpwIoqk36Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 07 May 2026 15:45:19 +0200
Subject: [PATCH v5 01/11] drm/bridge: drm_bridge_put(): ignore ERR_PTR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-1-472b913b5cb7@bootlin.com>
References: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com>
In-Reply-To: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
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
code as an ERR_PTR describing the error kind.

In preparation to have new APIs that can return a struct drm_bridge pointer
holding an ERR_PTR (and for those which already do) make drm_bridge_put()
ignore ERR_PTR values, just like it ignores NULL pointers.

This will avoid annoying error checking in many places and the risk of
missing error checks.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/all/20260318152533.GA633439@killaraus.ideasonboard.com/
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/all/omlnswxukeqgnatzdvooaashgkfcacjevkvbkm6xt33itgua2k@jcmzll2w6kdq/
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v5:
- don't change drm_bridge_get(), only drm_bridge_put() has known use cases

Changes in v4:
- removed incorrect change to drm_bridge_clear_and_put() kdoc

Patch added in v2
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d4b3478258ec..4aaea517b436 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
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

-- 
2.53.0

