Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0BFC44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9582710F832;
	Fri, 10 Jul 2026 09:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="euW0X0f4";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC20910E15E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:00:53 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so410794f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783674052; x=1784278852; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yd1dFdW3DE1YeT+fprMXo0jAXkdXd9jG5OHl8Qzt964=;
 b=euW0X0f4DkbNgU3s1LW5aKQPQf0QUeZLaoZA/n110rUIwBdy75OOiMu8urr01k2lUb
 AUdsraCYvldU1RQvu15hX9GSAEdP1tZT3T1qPuXrHuFgdCdGXhR9A9AtDkPPB0MG1V9r
 F48eolvoVpUFXsIduAFnPdMOnDk56O9A+R4H9pmrwt2rvaaoc6URaa6SivMVd78KJXJE
 gyWTOUQb/P8QEttlEZvmkZQf6Pr65cZlsPfTRMbG3OvjiG4zknLv333ewvieCvMDxh/m
 GQSWmPpdDurUAefsWsS1dXxnXBBiDk00Rs9CWgU8r7bcwgUA256t7oAGdjPlvAL7cNKH
 oIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783674052; x=1784278852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yd1dFdW3DE1YeT+fprMXo0jAXkdXd9jG5OHl8Qzt964=;
 b=C2IR5wyoCb83TZUSzJ/50lYT3gRgehnmC8ffCglft1VjFgXjyM+sig9iW3YdgMGCiH
 fCPe3BQbixzED0yoyrjD8HPnlOG6NalAxfjKEwd4T5RUzNrPI0eUvlOuA8fR5srnn+xO
 sc+AV/1mz8llBgkUQZFxRMEZdI5qaAnIOiLxQqhBh6qHD83L7UkVojtpNUcjSKwStyNh
 TSfzm9ouC+IV6wwAsO9W4H8PMXn8hpnlhfMqLYUH15/Q6l+f7U+WwuZrjikoRpTIIhtj
 E98xSP59oRQtKQyx/oxL2PJo8SW4bJiaZZBh4fD694VtOMxMd3rFi6gOWSQ2n2IC+eLV
 8mDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCj8Wty7HNlVAMG3C9cvF/5345HqxVKDm+Z5xVuHs9hzmDXbcbGUCH/hWgEKC3KT6VoXoMrPVR1l0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlgWhPFgDjRtrGoKaLL5mBxczRc3gytRmrP7GlWXN1Snpe796x
 uvaHi9EGNFmAjHDRUWi0U96cuA9aeOoi610ZawHG03A4REuIkE/t/QMycZhUvuo/
X-Gm-Gg: AfdE7ckKdALz+SCNvbgwGB7zmKG2ELGUM6tBm+Y/J1n3plkgfyHkjNqDQxlC8mLFLNm
 ceYrOAaS1nLSUhbvyS+hBtSvme7q/1/RWjhqbioQWdXSTP78pI68dZRyifWU7vqkV1DZEOvZj00
 uC7sYfJnk0bU1eW/YKEUTQaQuZreJgIxaYUr2J6bM0rliFut+Kxu9+bAB0moY1qqZeiRxRlMD1u
 ZM4uZQ1IqD1eLbTS43S5wRF3Pb/7mXCjMsNLXE+FkpqwGb9MG9GOkoA7zl8crhydo0oPky7+naE
 fs6nNHxqXLwPRGbYa5vqYP14BayIIbNwmNW2VsAsxxwBaocljQXGS19AIOr9mDVTCnvLS60dpB3
 gPJCHR5ABdj6h9uruKD1UWX+e7bFomB0EVmRAuYfargPvaNa8nL9DJMvMQ3ew6+lobbW1Uufc6A
 tO8yuA3UzFVd+3Qq0i6RGhNf7kwip3xqrrkmPB/KVfAHCkHJwmOtrhXuhwCzlxhkyQIWye8KpnA
 qL5mikh1SRosH+7LSBS8HarL/z1sn6ZQw==
X-Received: by 2002:a05:6000:41fe:b0:47d:efd0:c026 with SMTP id
 ffacd0b85a97d-47df071e085mr11361324f8f.11.1783674051647; 
 Fri, 10 Jul 2026 02:00:51 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at.
 [62.178.82.42]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm59386076f8f.22.2026.07.10.02.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 02:00:50 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 10 Jul 2026 11:00:46 +0200
Subject: [PATCH v2 1/2] drm/etnaviv: Reference count struct
 etnaviv_file_private
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-etnaviv-reset-notification-v2-1-90cfebcf22a2@igalia.com>
References: <20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com>
In-Reply-To: <20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com>
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

