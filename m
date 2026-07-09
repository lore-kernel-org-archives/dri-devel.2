Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C736C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963B410F61B;
	Thu,  9 Jul 2026 14:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8hWhCOM";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EE210F61F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:57:59 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so8110215e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783609078; x=1784213878; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yd1dFdW3DE1YeT+fprMXo0jAXkdXd9jG5OHl8Qzt964=;
 b=h8hWhCOM8W+APxHBY3/WQi/m7f67SZnUtzO8s7baD8/30uDji9topMXThI3sayKLaO
 ZBF4DVL2dSfJhef9vmnQzrHRb/tG4Tc9FIcrKPEJfUzEXgw8dDLb07bzF6+xHP18IxIl
 bj2Vq/x0ojAs8A+Aghh7MHY3+qbQrdN8hobVCIL0Kv38CHg9lt/JMIAoSkXb7B3AdY20
 bvPdL1w10zxscoW5gD6cVuElB7uOOjCnny4nXGHindDVEP77VACTSajmNoDZb4c8Cn+k
 gKzW7h6/jIdp5JUHObIncD+Ro64hDwuDopSKoOXDeKWy7lpLmA6hmGQ4jfBa1WsVjFFP
 +Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609078; x=1784213878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yd1dFdW3DE1YeT+fprMXo0jAXkdXd9jG5OHl8Qzt964=;
 b=CQHoZBdLxK9xgBUCWf5I19yg7QHd1yi/nbXHrzKq6xGEIUsHJQ1kcIc/tEaOEVKdhw
 ZR25fL8L6ZNhPBpHR+xqVfAjK2ifhj9lsl47Fe7CVDkeI3I2Mq8H4gg3uBBoUpGM8VEs
 D8X3wSmXPKFO4ZQKtPYjBHY78+5lNsO5Wa7RXB6McTgZvJcj0mu+nyQp4apDKaRu7XbF
 pkK3Y1vo81UqKRadsuZRC2niTGybY+jRss4M5Nmban3fhIFGnTA/gw54bBadMErOAXAT
 5tBcA1o7rYkz5fn/9VsGZHAmE1Edh61ENJsBbkgznwp3CN9nmeifTzsRgx4nCOMrtabY
 Kaiw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqli9aXSI1bYeBoZxTahPS4cJJIxzxDIQ+Tn7nV0jLDF/1sUKG1DtvOdO1/vtiS0CjYMVE1sBFfC3A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvQFv51VZaSOD3t42Bn2mQxplYiF53EGKJK/rxnv7NgEEOcAZN
 FmnIjU0+1uJfnkwOTmHZHVPlXiYzroicwFuXlqHpCcaN/1ehIsJnjaRg
X-Gm-Gg: AfdE7cmw/UK4hbVhObx+IxErze91WiEPYIHMSH87sB5DTSJ7v+q6R1sRtMTNtKhdYos
 GDeJuiPYH7sPTX2EuxSmoPiZdivxzZJ47E5SM5iXrCbZCiaw2Tc5CfdG9rKTe/ecs67qXLcogJI
 uP5WsiN1STndMF1vpSir2uougmnr2juh/70o3m8LPkbWM4khIJ2fS4hnzVoBe3sWJXFmDeL45Pd
 5xg8JI06fzjDVZh8l/I0c/Ce2FcdgxBViA5smfEooOp0YJaH9jUiRZZ+KGwpJNhMq0WyUFKkelt
 KrMkKFE0XUpK5phnwGxXiIaVCofH74m+aKeXETtLQiFTsC7lKoo3X0QLHvwUD7n3DdB+vayKr/D
 Q5PBbmbwYkvn06fNKDn88WSp/SIKQuXnKxEasBTai+GXCZXwkqgwaIXQT6vZ4+/oolTg1dr8oV8
 mVJpIq0BIy1S8XR484xGNFgDb13Xxp6AUorjeiglpPaqKy+T0pxvW/qnduoNuoMl95FERPUrO2M
 vjE2fO+en5qB+qTnMusvbEalt2vOygEdg==
X-Received: by 2002:a05:600c:8b53:b0:493:e79e:da87 with SMTP id
 5b1f17b1804b1-493e79edc1bmr65507825e9.31.1783609077936; 
 Thu, 09 Jul 2026 07:57:57 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at.
 [62.178.82.42]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a572c3sm162226435e9.1.2026.07.09.07.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:57:56 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 09 Jul 2026 16:57:45 +0200
Subject: [PATCH 1/2] drm/etnaviv: Reference count struct etnaviv_file_private
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-etnaviv-reset-notification-v1-1-64c617496958@igalia.com>
References: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
In-Reply-To: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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

From: Christian Gmeiner <cgmeiner@igalia.com>

The next commit updates per-context data from the GPU reset path, which
runs in the scheduler timeout worker. This can race with closing the DRM
file: drm_sched_entity_flush() only waits until the entity queue is
empty, it does not wait for jobs still running on the hardware. So the
context can already be freed while the reset path still needs it.

Reference count the context and let every submit hold a reference, the
same way a submit already keeps its mmu context and pid alive. No
functional change.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 17 ++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        | 11 +++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  5 ++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 08aca9035fc1..a27ed014fb4e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -60,6 +60,19 @@ static void load_gpu(struct drm_device *dev)
 	}
 }
 
+static void etnaviv_file_private_release(struct kref *kref)
+{
+	struct etnaviv_file_private *ctx =
+		container_of(kref, struct etnaviv_file_private, refcount);
+
+	kfree(ctx);
+}
+
+void etnaviv_file_private_put(struct etnaviv_file_private *ctx)
+{
+	kref_put(&ctx->refcount, etnaviv_file_private_release);
+}
+
 static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct etnaviv_drm_private *priv = dev->dev_private;
@@ -70,6 +83,8 @@ static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 	if (!ctx)
 		return -ENOMEM;
 
+	kref_init(&ctx->refcount);
+
 	ret = xa_alloc_cyclic(&priv->active_contexts, &ctx->id, ctx,
 			      xa_limit_32b, &priv->next_context_id, GFP_KERNEL);
 	if (ret < 0)
@@ -120,7 +135,7 @@ static void etnaviv_postclose(struct drm_device *dev, struct drm_file *file)
 
 	xa_erase(&priv->active_contexts, ctx->id);
 
-	kfree(ctx);
+	etnaviv_file_private_put(ctx);
 }
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index 55a9e745604d..cba4323ae589 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -7,6 +7,7 @@
 #define __ETNAVIV_DRV_H__
 
 #include <linux/io.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mm_types.h>
 #include <linux/sizes.h>
@@ -29,6 +30,7 @@ struct etnaviv_iommu_global;
 #define ETNAVIV_SOFTPIN_START_ADDRESS	SZ_4M /* must be >= SUBALLOC_SIZE */
 
 struct etnaviv_file_private {
+	struct kref refcount;
 	int id;
 	struct etnaviv_iommu_context	*mmu;
 	struct drm_sched_entity		sched_entity[ETNA_MAX_PIPES];
@@ -53,6 +55,15 @@ struct etnaviv_drm_private {
 	struct etnaviv_cmdbuf *flop_reset_data_ppu;
 };
 
+void etnaviv_file_private_put(struct etnaviv_file_private *ctx);
+
+static inline struct etnaviv_file_private *
+etnaviv_file_private_get(struct etnaviv_file_private *ctx)
+{
+	kref_get(&ctx->refcount);
+	return ctx;
+}
+
 int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_file *file);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 1a77a09b3377..98f1f59a8b05 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -398,6 +398,9 @@ static void submit_cleanup(struct kref *kref)
 
 	put_pid(submit->pid);
 
+	if (submit->ctx)
+		etnaviv_file_private_put(submit->ctx);
+
 	kfree(submit->pmrs);
 	kfree(submit);
 }
@@ -526,7 +529,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (ret)
 		goto err_submit_put;
 
-	submit->ctx = file->driver_priv;
+	submit->ctx = etnaviv_file_private_get(file->driver_priv);
 	submit->mmu_context = etnaviv_iommu_context_get(submit->ctx->mmu);
 	submit->exec_state = args->exec_state;
 	submit->flags = args->flags;

-- 
2.54.0

