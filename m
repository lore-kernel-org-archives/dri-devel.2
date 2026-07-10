Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84417C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4C410F896;
	Fri, 10 Jul 2026 12:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DWp3PnqA";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E4210F88B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:03:48 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso564927f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783685027; x=1784289827; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yd1dFdW3DE1YeT+fprMXo0jAXkdXd9jG5OHl8Qzt964=;
 b=DWp3PnqAglmSEZ6Y4MDGTy+1T5l5gYykGvPRP2rRKi1fhI3vOlIjSW/eGF4zU85mJ5
 47ccScB8Cj3bpraBwASUw+cwsTTEUjhkA92/AvQMm7WwEg5UXAdCe/NFAvnSOQFTryd5
 zJnywFQqwrDcfcZvLdsYEiWHcS3cfcP7KdJLEUEj5i5w+wKEZto9cVS9n/morTX1Kjwp
 IbVSljoz4RIFlLXac7TxqMO5MStkb5YZJdemFe29yLzwCiWN1ioLORFk00dFBmh/BW6E
 EOz5xq2mQE2BqVoRaPAgZHiNZIhaS0RDCe/fyUgjYj22LviNebAolvgPc8FSHOIZh0PC
 /l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783685027; x=1784289827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yd1dFdW3DE1YeT+fprMXo0jAXkdXd9jG5OHl8Qzt964=;
 b=MzQfWOMBs/juhK0Jps/CAI2s3obBdWm8c+zMoutcNCxvcHOr16xg+otqGBQ/zhZDdG
 /L5Pxa5fUURKS2nitMNCaGce7uZ5plqaBAXT/7j3WMSXixqkWxeRkdCjjjrmseZoZlHu
 eRFc4UcDPsZ0ihdPjYDBEdz9xI3VZvHvQrTW0L5J4qltvffkXGE0OG//KgOVhb4eRKj1
 61syG/mn8zvAmit19OMGnVNe7vnAXLFktgCvWtNuSKlLxT10KpXFFYMrLnNVrShz9DvI
 1HQd6Eik4sxd/DWNfIHPaA2r5wApzvG0LDViaIF+aio7qlfPtXcgBrXqXsg2snoR+Sls
 bgOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZQW64K4EZEGsROXw9MgxC7cgEk38uqGwAfhXCtSBjbA7rqFzqLVKpvbNai1437P4EcZapi1gjgac=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVP6QQ2EYvr0atPk8GXSeEzgPGyVphpaZVc60nYYMwQWzo4DZH
 BVt6Wzt23pHr5tOGETS87q8LSmr2Tw24z/Cs186uEvTxGyIe1/IcnNQL
X-Gm-Gg: AfdE7cnmYqHk3YpnO0+BgZeadRaEuvsxC+8oxeo4qtYsHsbK891r5dzPEjTkZOx4msp
 zIJ5KAuBYomKp/lvevd7NUuDGrTmtaYmEX1CKcV8j/Mb0bhwR5rVMx/5OWzOPrK9nL9WrLbTIkw
 yJ0WMaDZ3iLH1N/nhj5E4JZEnumTSp0xRzAOVBjIu8m+RnWOTHAc8YHICq8HHrTjkpsdApPh2f+
 ysFLuklKdKqx7kYr3G4Uq4Ci3JiVM66kf23+qIa5Isd+7XVUOLpQGSbcf92zMXyEF6bogswNV9W
 EKxR31m9uSxA6IHGvYc05g55Tvu9Mf0H8GTS61tL3hVH/6lDka25ZIZ4iUdNYN41kJ1z4E107Uh
 gDOw5x/KZwzKuhhmH67+QfuQeAr1C+66tZyM2KIZ5aafAQ0U6v75dwE3qMrXsfH6+XvItVzhJ0d
 9EE8J4c1A0np3TPas5BpfnFq0daomfJhI2wrKkUfZBpMCXdGUOkz1NbItxYR/E+WcRqha7hRHYY
 GftImIx7EPoTgHI7X2xbpbIVFnQQPIYEg==
X-Received: by 2002:a05:6000:41ee:b0:46e:6210:ad4a with SMTP id
 ffacd0b85a97d-47df071e518mr11370482f8f.5.1783685026628; 
 Fri, 10 Jul 2026 05:03:46 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at.
 [62.178.82.42]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm59637487f8f.13.2026.07.10.05.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 05:03:46 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 10 Jul 2026 14:03:42 +0200
Subject: [PATCH v3 1/2] drm/etnaviv: Reference count struct
 etnaviv_file_private
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-etnaviv-reset-notification-v3-1-7a145c8a1d01@igalia.com>
References: <20260710-etnaviv-reset-notification-v3-0-7a145c8a1d01@igalia.com>
In-Reply-To: <20260710-etnaviv-reset-notification-v3-0-7a145c8a1d01@igalia.com>
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

