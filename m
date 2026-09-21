Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1E6C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C818210E129;
	Mon, 21 Sep 2026 09:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QJ1efCIc";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBA210E129
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:45:01 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-530e28a62abso42863441cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789983900; x=1790588700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oBbp6Tv1H7s0oDL74B6mQmNuAwqzSV4oH5wsqON5NBY=;
 b=QJ1efCIcTngecBZiikPjtvYUXB9ttX9zouhroACrYknbeQIpRF+PzoAWnlSUR69BDB
 Gbpw/vz5kPKANQ0G3K+ToJJbrZvHxWtoadbUqXn7oyWupd5X9+izK9KlyHCAWguiJeEw
 nxQKAUa4djeeM96/+X57YLB3Bzqa4DpSN9rsW8GNFdbht2BqZdLfcg6V62px4GHpIHjO
 x90tSlMn8yaKdkGDNyGjhVPwPey5dkXewwB/RbXeWSGsWo40bvuX2Q6VVrvwqu1ctkKe
 eQSPkdiHakJ/C598bYkRKSOIAGYUdAEpD5AJqLh5H+jOKOEtFKHGBZFzGawF0Au/RblN
 4Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789983900; x=1790588700;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oBbp6Tv1H7s0oDL74B6mQmNuAwqzSV4oH5wsqON5NBY=;
 b=Ayd9GfSuE+hsbctQNvC7EVNPHcnqvrKBvk3GNEZMLjvZspqubeqjM/5+Uo3yMzCnmn
 hJEAFB5L+wfvXvzNyydU3sostCf1Zd+rASBZEoaNwz3b0E9ozXOquJD80sKn4UjBfHCk
 SGuZr+ptJRbbRoXZ/HW6RLJlwseDrNCGdVMWYqm03JFq1UB8i5rsCvSF2bl1bxHVbOWl
 4oSQcUudYZJrQ3LjIw1UjgxsJPGaz/RLzSlyGEAnMNpZM3lESsmquQYoMk53FjL9WLf0
 L6TxnJkDrCuEer5zDtapyoevXWAVk2mGm9X5DP4M9bCn3gzgIQI7dCkGMyNlHlBStyeU
 BgMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEcCSG4Y+uqw2wyCYF9bP0KwnK0s5cIduHwQkKqs8zid4Heb8eHw4xTjNHJ23XjrQDdic1+omqIbo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5+2nja+T39wdYRUV+nCSAT3YSecptt2E6BYR41s++T6h1GF4r
 fwHitjIg11f6jJkw4K2AuTDqi9mPHR8FtylswdlSj6sKwBFZvH7Cgik8
X-Gm-Gg: AYBFou3H/qAqLYKIEnFKiRSB0g8pzrgpKUnnLfBgmITFIg5g+T2NnRCI5v76Y9gor3E
 zEdhmqi8hyxwn4l1gX+u5gAHRJdvL5bOVyGHQ5Zhh8bpQtQxQfBohb8aJWZjE0NSuF4BdXLCcy0
 B2sbQ763ekVqKhwRCtfcjLVg/yuwsFpEkMY2UU24LSBMTh6gA4SpQEQt23c/XCXub4EAyyD7wRz
 joSgBSbIvZ2C4eTDVAP24zOCMFBSLf49B+HdpifWs+M6dXqv5QldFASrwL+98Xjhd3IPhkLpS4o
 J6GfhdeaYMM1cJTaIJUzkQ8ool+3yn0A/QgEv0KwuToyp3tJmFFo2YU0yxL5iFx39xzzDZdDRi2
 gFT6SmmkDrahWPVLlNEcj2qNFyyewmmDr3jI4LZ8g0QioyzSOcsjbesvM/NanakMm+1ALzWxgbA
 SmhMQDPd1LNqaTidC0Qsah/a0Mwkr0mGJI5jXRtLlnHB+6YKTUqpQXf39Uw/D5/0iEFLXwFb+ds
 sUUQQKavKnURcU=
X-Received: by 2002:a05:622a:5a0b:b0:531:21c0:667 with SMTP id
 d75a77b69052e-532b71f647cmr88271481cf.26.1789983900221; 
 Mon, 21 Sep 2026 02:45:00 -0700 (PDT)
Received: from laptop.amd.com (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532ae616e65sm59567391cf.15.2026.09.21.02.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 02:44:59 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: kevin.tian@intel.com, nicolinc@nvidia.com, jgg@nvidia.com,
 leonro@nvidia.com, leon@kernel.org, dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] dma-buf: remove pci-p2pdma include from dma-buf.h
Date: Mon, 21 Sep 2026 11:44:52 +0200
Message-ID: <20260921094452.679455-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

That is unecessary here and creates an unwanted dependency to the PCI
subsystem. Move that into dma-buf-mapping.h instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/dma-buf-mapping.h | 1 +
 include/linux/dma-buf.h         | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-buf-mapping.h b/include/linux/dma-buf-mapping.h
index 09bde3f748e4..fb5e52260700 100644
--- a/include/linux/dma-buf-mapping.h
+++ b/include/linux/dma-buf-mapping.h
@@ -6,6 +6,7 @@
 #ifndef __DMA_BUF_MAPPING_H__
 #define __DMA_BUF_MAPPING_H__
 #include <linux/dma-buf.h>
+#include <linux/pci-p2pdma.h>
 
 struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 struct p2pdma_provider *provider,
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d15b2b31d3c9..159271fcf3d2 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -22,7 +22,6 @@
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
 #include <linux/wait.h>
-#include <linux/pci-p2pdma.h>
 
 struct device;
 struct dma_buf;
-- 
2.43.0

