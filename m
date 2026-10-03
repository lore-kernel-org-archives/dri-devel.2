Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7095CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3103110EAE9;
	Sun,  4 Oct 2026 17:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJqcWv/J";
	dkim-atps=neutral
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com
 [74.125.227.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC9C10E2E0
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 09:35:05 +0000 (UTC)
Received: by mail-pj2-f10.google.com with SMTP id
 d9443c01a7336-2e2f352108bso1400435ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791020104; x=1791624904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zWQSpGzLG7DWALbabuPoeKknlGH7FdAX1uCS5SSDZcY=;
 b=eJqcWv/JDv4baf5F2ltm3pnlqFw2WQC+ZQqLVE1VCRRbqY/grDC05KUDkjh//JSA35
 VX5aOmoBTAJY3rEL1sosr85dr8J4XBxo35efSonGewoSGcmXEtTZNyOxA0vzTkYLWQPq
 CfvU0QQoxvayRP3BrtYKyufvFMA+rM0GFus/bY99n9LVcViHXUdPnJVf19WUDXFHBub5
 +gbXXGmbSzqbgT1ZYQqoM1Ipf6W+YcG50ntU4TZzQaWn4btYok/bqXRX6l4Z0z6RZIt2
 +XkeJcQ8Y48Q4hVPBSnifcK3p214WQgjufdSw2z/U69Vgixtq7m9sK9SGUXdxlSYuj6B
 arGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791020104; x=1791624904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zWQSpGzLG7DWALbabuPoeKknlGH7FdAX1uCS5SSDZcY=;
 b=t6IHOJoHoSpzWRVONC/+AxM9Kp8eGwdK6Yc1A/bdQJipHj527Qykzfx+XbNPBJr6hT
 15smaym7sftWfO6tBTkPvGVv1Mah7pDtECPvBNLgcHieJ2rUOdUZz7JYTBLmqAJXfHZv
 sSDXOTitcdk0jkCUROLXVxrtbkNmWyGd9zQisKS1p0u/vVNW8yfchrXaONmEApua2JGs
 DVjvDaJdlK8KZKkREv/ML+wJqSmU6aqgfNRDadnnVqvLutMrl/T12yrpODl6y5GGIgvW
 B/9xPgQwX9vSaMMeqAdn1CqdNIQe1yRR1J702WDCKiyCf6ytWiHS+ozjHoH03ISLDuNs
 vNsQ==
X-Gm-Message-State: AFuF++lvfEzoFxPLZ+zLyjmypK6mHvLYHDuefHrGJujaG1ny0j6kt8px
 7xcTF/VwWobidPi2UiJ782v0+5jUdgfUanh0xsx90fkBZENoPiRO9mAIUKf0+/24eG6scbOL
X-Gm-Gg: AYBFou1fovhOmfUkraiI+LoQt63X0FtgTArLNOd88Wd6RsZUEqEhxfDvYzN6maVrgKx
 +zz5DzdEDtA2BxVoJaCk2y19g6rxT2bEkUEE5/2rh+eWthlA5tVi6qUjeQRumLQhtSlLHh7DBfM
 e8+pmtG5wllT9Nd6aShkE/F9jtZX56kecTOtwknmMsexp0Pg/JkUK8263kFNYUKDBBKouk21omP
 vcNk02MIqJ9qqdqLak5lxgkqtJGrAUowoUCLei4djEKv6z57OKJkHwi5WQSZdS0VeKLePHZmckx
 5PGFWlei3qzAltdOTmNg38NtSqOIFr9pnSA0jbDzKverSiko3DlgAgIUhSSKrEEIZvdnyeVbUrw
 5EXBdL9Knn9GrJ49ZLI31bUEB/Q71Kb4nK1vw/L3FjznlZMUByT/MrJAdwMsj5OX0jR7Rwt/Tio
 z6xrtyX1JXVfFzGKOT86pUIqFzyTjWF1CoQEwWNQeBRLLHxw56exvG+hnz/OBZYSKH
X-Received: by 2002:a05:6a20:94ca:b0:3e0:b680:c3cd with SMTP id
 adf61e73a8af0-3e0bd2900d8mr5555662637.49.1791020104397; 
 Sat, 03 Oct 2026 02:35:04 -0700 (PDT)
Received: from localhost ([129.227.235.110]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f739cba5sm1956261a12.28.2026.10.03.02.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 02:35:03 -0700 (PDT)
From: Evanshenf <archwse@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Sui Jingfeng <suijingfeng@loongson.cn>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Evanshenf <archwse@gmail.com>
Subject: [PATCH 2/2] drm/loongson: Handle buffer mapping failures when
 clearing a BO
Date: Sat,  3 Oct 2026 09:34:59 +0000
Message-ID: <20261003093415.902f89244043-2-archwse@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003093415.e64386de1e64-1-archwse@gmail.com>
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

lsdc_bo_clear() ignores the return value from lsdc_bo_kmap() and writes
to lbo->kptr unconditionally. When the first mapping of a newly allocated
buffer fails, kptr is still NULL and the subsequent memset accesses it.

Return the mapping error without touching the buffer and propagate it
from lsdc_gem_object_create(). Install the GEM object functions before
clearing so that drm_gem_object_put() can release the buffer correctly
on failure. Do not add the failed object to the tracking list or return
an uncleared buffer to the caller.

Imported buffers still skip clearing, and successfully mapped buffers
are cleared and unmapped as before.

Tested on LS7A2000 with a one-shot range error in ttm_bo_kmap(). Its
-EINVAL return reached userspace, the object was destroyed once, and
no GEM handle was published. Normal create/map/zero/write/read/close
cycles passed, with the tracked BO count and VRAM usage unchanged.

AI assistance was used for the lifetime analysis, fix, fault-injection
tools, build and test execution.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Evanshenf <archwse@gmail.com>
---
 drivers/gpu/drm/loongson/lsdc_gem.c | 12 ++++++++----
 drivers/gpu/drm/loongson/lsdc_ttm.c | 10 ++++++++--
 drivers/gpu/drm/loongson/lsdc_ttm.h |  2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_gem.c b/drivers/gpu/drm/loongson/lsdc_gem.c
index 2fb0348..9eba4e1 100644
--- a/drivers/gpu/drm/loongson/lsdc_gem.c
+++ b/drivers/gpu/drm/loongson/lsdc_gem.c
@@ -157,14 +157,18 @@ struct drm_gem_object *lsdc_gem_object_create(struct drm_device *ddev,
 		return ERR_PTR(ret);
 	}
 
+	gobj = &lbo->tbo.base;
+	gobj->funcs = &lsdc_gem_object_funcs;
+
 	if (!sg) {
 		/* VRAM is filled with random data */
-		lsdc_bo_clear(lbo);
+		ret = lsdc_bo_clear(lbo);
+		if (ret) {
+			drm_gem_object_put(gobj);
+			return ERR_PTR(ret);
+		}
 	}
 
-	gobj = &lbo->tbo.base;
-	gobj->funcs = &lsdc_gem_object_funcs;
-
 	/* tracking the BOs we created */
 	mutex_lock(&ldev->gem.mutex);
 	list_add_tail(&lbo->list, &ldev->gem.objects);
diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongson/lsdc_ttm.c
index 88536e2..7b30dea 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.c
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
@@ -388,9 +388,13 @@ void lsdc_bo_kunmap(struct lsdc_bo *lbo)
 	ttm_bo_kunmap(&lbo->kmap);
 }
 
-void lsdc_bo_clear(struct lsdc_bo *lbo)
+int lsdc_bo_clear(struct lsdc_bo *lbo)
 {
-	lsdc_bo_kmap(lbo);
+	int ret;
+
+	ret = lsdc_bo_kmap(lbo);
+	if (ret)
+		return ret;
 
 	if (lbo->is_iomem)
 		memset_io((void __iomem *)lbo->kptr, 0, lbo->size);
@@ -398,6 +402,8 @@ void lsdc_bo_clear(struct lsdc_bo *lbo)
 		memset(lbo->kptr, 0, lbo->size);
 
 	lsdc_bo_kunmap(lbo);
+
+	return 0;
 }
 
 int lsdc_bo_evict_vram(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.h b/drivers/gpu/drm/loongson/lsdc_ttm.h
index 843e147..df47d9b 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.h
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.h
@@ -89,7 +89,7 @@ size_t lsdc_bo_size(struct lsdc_bo *lbo);
 
 int lsdc_bo_kmap(struct lsdc_bo *lbo);
 void lsdc_bo_kunmap(struct lsdc_bo *lbo);
-void lsdc_bo_clear(struct lsdc_bo *lbo);
+int lsdc_bo_clear(struct lsdc_bo *lbo);
 
 int lsdc_bo_evict_vram(struct drm_device *ddev);
 
-- 
2.43.0

