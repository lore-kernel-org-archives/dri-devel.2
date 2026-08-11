Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F2DC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAA510E3A0;
	Tue, 11 Aug 2026 21:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="DigjjoyN";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA1A10E3A0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484573; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KnFifsz6rvo6S+OB0FcP9xFJ5iCRrn5VWAmyplcZhvDF5CZmapn1m/85kSlNwLF2Qh9WGbY2yLFbG1FTnDxtmnqFRTWHGFHXUdUuGPkJ4mRW5UG+IK8DARlfUxVFp/aD4oqPRPapVExSMXU3UKuLmFrsYVbsJo5fW5ytFKR8l0o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484573;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fV9fD8bgmvHXHK1qr2jRmcc6W9iioJtZGfVCDQR1IvE=; 
 b=GjEDmfRp9enTrEGyLIoL6KR7905/soXa9q8iSvN8CEq+N1grdunKZJrtUGRB9ByuqQ6A+v0M8LLAxrhhm3gkrwwEO6Q0uA6oH+XK0sT7Ts7ZYvKshMHH+IA2FdsHezNdDEgjceoPYPdgen623wkum+0/5FhF8vUGRwv5cQ4DT2w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484573; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=fV9fD8bgmvHXHK1qr2jRmcc6W9iioJtZGfVCDQR1IvE=;
 b=DigjjoyN+8PchRTuShb0ZeZX8xqGryk+cGtJoxpxYNXP8vJmM8KJCnIKaHQePTXn
 6a3oVmuDBX6R2S9FhRykILjOE7nRW/QLNShc49ajpfgMMUls1gv4J6iE/MwAeBpWoH/
 7smanr4Xf0HnWkuBmgauT3HB+/il2c9z1gKMp5rA=
Received: by mx.zohomail.com with SMTPS id 1786484570766616.1773047792694;
 Tue, 11 Aug 2026 14:42:50 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:15 +0100
Subject: [PATCH v5 06/11] drm/panfrost: Explicitly enable MMU interrupts at
 device init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-6-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=pkUQoVA/o7xB9fGZuFOjj02/lCPXGAK8d1Hu2m8L7o0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5czxwXiJTezHbtkSptyoWBVkVWsy5QWUVR6T
 LcQNv4BOeqJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PfHSC/9ypcWRGJcLWceL0YBGlmpVA287c8a9wHKu0RSjtAitUwkKUUVVeEYrkgWnvopbQGj2pQh
 pYSeT7nE0Ai8zNX9/WpdDImuYR/8RlSACPmFRQUWHvTzJmpXaFTeOf/cSewV4XxnuCOBmTnEcnU
 DPhKLWJtvhO+vOIY37lk73OTc2D+2Qrl0DECEJOUf+jPk3qZWiWKyKe6U4O/CFBFoZhvB2b9E7W
 X/Kk+hVJMGKY+kDmAKZuop+Wb43iABCgrbYGGMX9oslRBWHG2wiSlxfaaONIfsXNNJsM+eGR9Fh
 yJvd+hjACvcJiXQhGbUluyXQTLs/cXGhcMXJCbhBSPrgEKGExh86BANnPY7asQd+pfhvQr+DLRD
 o080wq3YHS4QtitJdg55tob7GSsqgmkQguGqVruCsi5RYIu7mKoEOMMNjGMcvA2MH7/Kmr/WtIo
 Z8Y8UBqaLoUnSaWxcpKj3W+DHNDZo+il7BdOyFMjfd/tG8fAuIneBFbUIlGKwBMekDroc=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Because the device must be in a position to accept jobs between the time
drm_dev_register() is called and autosuspend first kicks in, there's a very
narrow window inbetween during which jobs targeting the tiler buffer
object would time out, since the device's PM status is 'Active', but no MMU
interrupts were enabled at device initialisation time.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 3fe37dd12360..a8ce5d65825c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu
 	WARN_ON(atomic_read(&mmu->as_count) < 0);
 }
 
+static void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
+{
+	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
+	mmu_write(pfdev, MMU_INT_MASK, ~0);
+}
+
 void panfrost_mmu_reset(struct panfrost_device *pfdev)
 {
 	struct panfrost_mmu *mmu, *mmu_tmp;
@@ -355,8 +361,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
 
 	spin_unlock(&pfdev->as_lock);
 
-	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
-	mmu_write(pfdev, MMU_INT_MASK, ~0);
+	panfrost_mmu_enable_interrupts(pfdev);
 }
 
 static size_t get_pgsize(u64 addr, size_t size, size_t *count)
@@ -970,6 +975,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
+	panfrost_mmu_enable_interrupts(pfdev);
+
 	return 0;
 }
 

-- 
2.55.0

