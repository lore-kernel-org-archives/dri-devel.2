Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB26CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 18:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF2410E0F8;
	Sat, 10 Oct 2026 18:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oFKbruGa";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56C510E097
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 18:07:23 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso4797865e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791655642; x=1792260442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+5j1pSqblDdPaBPvCTrZnRaS3nxEgPKJ9d7lIX0F3CQ=;
 b=oFKbruGaqnOW6m257DBgMJLE6RLglElPnia0jwVOdVX64Ba6BTwiXrK1XUD1/vG+ru
 fRnbfExX8+tWoYT9csNQSX/kiQ4j3MIeWS0nMoCEmcWghFxW7UO3dNfVzOx0eKTrqgK6
 81NNIxcc0/nhTokUHFbondtdbiSeJkPRUrbpux8vTjv8hEQjAXWY/9yAWpU4toFsLAXM
 UFDTeEz26MMUQRVGB7mcw0sTQBBUTScjPl/EVu9bVr0sr6gFx0qfRbw3eqy0MVkEP2u4
 TPw7oqgnecF3UtgA3e58gQg09NRTydRpoh27p8WWt3HCeoNc4xxkzE4TPEPRlaKgYzf5
 pIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791655642; x=1792260442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+5j1pSqblDdPaBPvCTrZnRaS3nxEgPKJ9d7lIX0F3CQ=;
 b=lLWlvkSympYSTTaBpMGVtH3WODVZqkTWc6ac+0wCIoXdSej29uojeFkAElpwYAEyRt
 psTMaXO4jIpiqHoQqv2sdqoRXdB1OEKb7L3fgrowhkNnXpLs87Vn5Lt3Ekdll67neBSL
 3e44QLnxysSNGCCypMjDyplcnf1lht5AB4ijgFb2yi7ACCaZONnSPwTA4o12Nk6YlQFT
 V1qW256Adgy+H9wmFMbXi/LA1LT7RPlHNNhukMOuRsBz5xpOUDSkwpC5bVtT1K8Xo9aI
 K9x06n6rJLPBR5I87SbeTwO2AGG3bSAOVRi1zdFGDzVbeVH9UDMlmiF9nI4MTGXCtUuu
 +XEQ==
X-Gm-Message-State: AFq9FYKGfTgHKam/EkU+xcJtqfV1HAvxMCTNMsZUm4HB7kmA4w5xBxdJ
 z1to5AVmnhnRsIgc98m7U9b3GfnUFdZv/G3BisGWuyf1Sq91qQyH79lx
X-Gm-Gg: AYBFou2FNMhDd/Uyq0sBglsAtzlfRv+kPLIHgcJqoXFuLdwl8x3TPoqeRfBDylKkH3G
 fXuiRKleC+9cEsRmOn5DG9Q9H0HkJMIqVIqGaT9lrXq8oqgnJNVtTZYhIdUI8+/Z77ULnT3JpPC
 KComoHIt7WsxAkX01ZMSNVhzJ13FKQRD7vsjs66sJMBBrUC3pejCl8x3WcukYa1QFDe5mklsPMZ
 H4sIEK2/ZZhFYatHSLWq8mVZfJPc8c4kLWs1aVFxhkCn+mE7IJgiOl8HTS48rWELAudCG2JFTzD
 etUoMHNclfttPAlyvvAurBfRusIILfXJvDt+5oknap5B5YqDAsskI5AIrRUPm6JH9R6R19ZJlOr
 faEByVvg9A0COBTSIM6hVREnAo6u3wRJU51+MzZs/bXkWS5vViwQIWQvTB5BxYsdMYhWrf9uKx0
 JwFQPVdIt1u1OIEpalTMkcmUxTWYrW3z3sqDMFr4+tHDHo/3fBK2QH8Uql8eWK8WW1zC5B6azvn
 ERVEZiMGr66Hnj90CxdAFipTxdweAk5repsyAVsQj0=
X-Received: by 2002:a05:600c:64c8:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a18e4c41b0mr91571535e9.21.1791655641777; 
 Sat, 10 Oct 2026 11:07:21 -0700 (PDT)
Received: from desk (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e530esm9617208f8f.13.2026.10.10.11.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 11:07:21 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Julian Orth <ju.orth@gmail.com>
Subject: [PATCH 1/2] drm/syncobj: fix fence and syncobj leak in
 drm_syncobj_import_sync_file_fence
Date: Sat, 10 Oct 2026 20:07:10 +0200
Message-ID: <20261010180711.1548333-2-ju.orth@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010180711.1548333-1-ju.orth@gmail.com>
References: <20261010180711.1548333-1-ju.orth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If dma_fence_chain_alloc() fails, the function returns -ENOMEM without
dropping the references to the imported fence and the syncobj.

Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index c23a5de27..5ca5163d0 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -730,6 +730,7 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 {
 	struct dma_fence *fence = sync_file_get_fence(fd);
 	struct drm_syncobj *syncobj;
+	int ret = 0;
 
 	if (!fence)
 		return -EINVAL;
@@ -743,17 +744,20 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 	if (point) {
 		struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
-		if (!chain)
-			return -ENOMEM;
+		if (!chain) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
 		drm_syncobj_add_point(syncobj, chain, fence, point);
 	} else {
 		drm_syncobj_replace_fence(syncobj, fence);
 	}
 
+out:
 	dma_fence_put(fence);
 	drm_syncobj_put(syncobj);
-	return 0;
+	return ret;
 }
 
 static int drm_syncobj_export_sync_file(struct drm_file *file_private,
-- 
2.56.0

