Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1D4C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 03:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F4810E420;
	Wed,  8 Jul 2026 03:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DOWtHFiS";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE59F10E420
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 03:29:00 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2caced6038eso2599505ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783481340; x=1784086140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dWbuXPSLohRB/M8EIN/JzhKRKCDqHb+iOVssm+yt0m0=;
 b=DOWtHFiS1bBw+zznuc2MsoSMmpAKy5ii0gH16Uc9DBzmqO23bUdDQ3BQhOzkOwbMc2
 Y/VfMG0x2oAFAJuzfJZSARJLydQZxNYbuxW2JuauUiGw7FlNeWH98yTkKKv32ZZWh0xr
 GODGGdPtXE7EmgksRrwjjUSQbIl2QqYAKnPVmOs8uXwndo+zKi1lh/qBkV77Fhse2oHO
 K+HKYp756Ms6XDcyNpJsMXMkJLky6RCuXxs1U8lHR8EHpx0EuHAXErwqN0tc3hzlC2u6
 71U6w0WyvKHCSfkQL8itMjGJTMpVPBC6Eiq1DTQsFyLSJf/QPD3bvCc+VM3WNKIICbHa
 xhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783481340; x=1784086140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dWbuXPSLohRB/M8EIN/JzhKRKCDqHb+iOVssm+yt0m0=;
 b=S4NDhaSt+Tu12k9xXeG5IdPqAMPZrxmQqZ8sgZD2Kdz6FF14oNi47ff+hFRlc0Y4bM
 g+phPi12uQLHohQHTIKxT8vKCSqy65xvZElV09xmHaUl33ap/G4uDDTUsJ8X35lJ6iNE
 IyDlssM+B/WvZuWtul3X4bsj6oE8zPT2tCjNKAO82QAlPwoQRKJRA6xN5rCAh7Qqxk5n
 SBKsOILkn+Vztu7IcbAqN487Zn/5DoPBDSh8SOKvy2SKF5pWQqwrtI4AhQ2WLgw6AM67
 Ltm7Xxmr3Kb37NiOi1QXmT5++xhrxHere7ZOeSXjp6TFmim0M/wXIi7FQFGwn2YT2S5k
 GBSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoWCfeRkLofilAWauTH2269eMBcdGc3/yM8A9MXxtX8fhW4mOWfcSsKX5ULQnv/qhHDFjDhsIkrTE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3LjGjsibOzyQDT2Iigz307Re78YPKwc2vqZb4UqLL4sccQtxK
 ZROyuhOGZJKZIoGnZJAKUR8YNQhsNpxgFQP6BVNsIeuKRtbldC9yJVEg
X-Gm-Gg: AfdE7clKSeYxZ1Q9jvPb3gDuvcAikjkdVwcMVgJSz6pcznZD8OASIGJZ/Qgleq7lTQU
 1JpSz5MeiHUOnjJUWgf5qMKFyErSHgaPSS5UFtxlF4NaH6DJ6RDF5ab1pLq7GZG6UzqMKTjSRQH
 SCuFQuwBctTeFt+4FbMHPcz5LKdsXDp4tLjBeDiQpzgPLiggjSQ/QQNBAIyViaGSWNbBs5+otOK
 xCA4f+uNopIhpIEM0OBUizMoW1CDVcbglJ0Wvq/24XV/ncfAzAiKnguMtQkbMzz1DRAX4HqiNn2
 GKMxxwR8UNo3mGeocCu/8h63oyZ9WexvVqtBdHOIlrlgkYA23DyNztm0KSiSclD61dQh5mJnnaU
 xznYrOFZHiPB9RnX7wSLOZgbS2sEP6NK8PeGMSUeoCvnByGcOMhiNAxaQFY6LrjG+kNdl1uBr6o
 StWBE+f0PGMA==
X-Received: by 2002:a17:902:e84f:b0:2c9:d277:2cdb with SMTP id
 d9443c01a7336-2cce9fafe09mr7101655ad.9.1783481340217; 
 Tue, 07 Jul 2026 20:29:00 -0700 (PDT)
Received: from lgs.. ([101.76.249.46]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9c20616sm20602815ad.34.2026.07.07.20.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 20:28:59 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Jeongjun Park <aha310510@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/exynos: vidi: fix EDID leak on concurrent connection ioctl
Date: Wed,  8 Jul 2026 11:28:47 +0800
Message-ID: <20260708032847.712897-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The change referenced by the Fixes tag added ctx->lock protection around
struct vidi_context members related to EDID allocation and freeing, but
vidi_connection_ioctl() still checks ctx->connected separately from the
state update.

Two authenticated clients can therefore issue concurrent connect
requests. Both can observe ctx->connected as disconnected before either
one updates it, then both allocate a drm_edid and assign ctx->raw_edid.
The second assignment overwrites the first drm_edid pointer, leaking the
first allocation.

Keep the connection-state check and the ctx->raw_edid/ctx->connected
updates in the same critical section. If a concurrent request has already
changed the connection state by the time a newly allocated EDID is ready,
drop the new EDID before returning.

Fixes: 52b330799e2d ("drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 33 ++++++++++++++----------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 67bbf9b8bc0e..bc0af9e6bc81 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -252,15 +252,6 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 		return -EINVAL;
 	}
 
-	mutex_lock(&ctx->lock);
-	if (ctx->connected == vidi->connection) {
-		mutex_unlock(&ctx->lock);
-		DRM_DEV_DEBUG_KMS(ctx->dev,
-				  "same connection request.\n");
-		return -EINVAL;
-	}
-	mutex_unlock(&ctx->lock);
-
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
 		const void __user *edid_userptr = u64_to_user_ptr(vidi->edid);
@@ -293,21 +284,37 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 					  "edid data is invalid.\n");
 			return -EINVAL;
 		}
+
 		mutex_lock(&ctx->lock);
+		if (ctx->connected == vidi->connection) {
+			mutex_unlock(&ctx->lock);
+			drm_edid_free(drm_edid);
+			DRM_DEV_DEBUG_KMS(ctx->dev,
+					  "same connection request.\n");
+			return -EINVAL;
+		}
+
+		drm_edid_free(ctx->raw_edid);
+
 		ctx->raw_edid = drm_edid;
+		ctx->connected = vidi->connection;
 		mutex_unlock(&ctx->lock);
 	} else {
 		/* with connection = 0, free raw_edid */
 		mutex_lock(&ctx->lock);
+		if (ctx->connected == vidi->connection) {
+			mutex_unlock(&ctx->lock);
+			DRM_DEV_DEBUG_KMS(ctx->dev,
+					  "same connection request.\n");
+			return -EINVAL;
+		}
+
 		drm_edid_free(ctx->raw_edid);
 		ctx->raw_edid = NULL;
+		ctx->connected = vidi->connection;
 		mutex_unlock(&ctx->lock);
 	}
 
-	mutex_lock(&ctx->lock);
-	ctx->connected = vidi->connection;
-	mutex_unlock(&ctx->lock);
-
 	drm_helper_hpd_irq_event(ctx->drm_dev);
 
 	return 0;
-- 
2.43.0

