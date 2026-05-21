Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982ABCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 01:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055FF10E46B;
	Thu, 21 May 2026 01:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="X/gyd8CW";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FADF10E46B
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779327867; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ULzSrVRp9RVwjsezFfpkJHaYY1BxZJUdGpAebQJjo0xXSadPSiRC7+6Vd+X0OfcoeHPlf/AWTrQj4aKLIo7mvYcyc36yaKYA+lJr/ibM1xJTvpcdrmG66+4bNeKHxj4cmvtTyQ0XMyrT0t2F5sNKTymCWerZsririUkdiibd25A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779327867;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EfjCy2BVplWmVofRr3phBJpfErYYqQ0OAw8WLwN7lYI=; 
 b=Pf91WVT8PxOFl6Rc1jNIYkMXEIuxuZXNyt5iIElzq7lBLHiUJFO/rZVPvbTNm5+q+f4AEVfsar8LMWbXbHUwQwJYsfZSuWFrZ3a6ES2TKJz9k8LIj6WtzwAZ16X6EiQt5teGv70JPnB5zJAgmRc45gtIC9jNQdaNCwJ9ZDX0pyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779327867; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=EfjCy2BVplWmVofRr3phBJpfErYYqQ0OAw8WLwN7lYI=;
 b=X/gyd8CW+7MOK0NcDyZ0SUrHfrMt2cFCzH2OOHqxOSMuEtRkLvgkkKVpHVqnpwjJ
 KcUJYS4AiK+Twuldp28hB9OPQYnyNKV76FQvJWNHalupOh/VncJgS/miAJwfvX/CvkK
 kfVFD7XDSvzuDxueve5cp7kgKUS/yilJFPxiumRY=
Received: by mx.zohomail.com with SMTPS id 1779327866608525.1735394194826;
 Wed, 20 May 2026 18:44:26 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v12 1/6] drm/panthor: Expose GPU page sizes to UM
Date: Thu, 21 May 2026 02:43:08 +0100
Message-ID: <20260521014359.2011484-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521014359.2011484-1-adrian.larumbe@collabora.com>
References: <20260521014359.2011484-1-adrian.larumbe@collabora.com>
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

In future commits that will implement repeated mappings, only repeat
values multiple of GPU page sizes will be tolerated. That means these
values must be made known to UM. Do it through a queriable GPU info
value.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h |  3 +++
 drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c    |  9 ++++++++-
 include/uapi/drm/panthor_drm.h           | 13 +++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4e4607bca7cc..72bf48ee635b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -161,6 +161,9 @@ struct panthor_device {
 	/** @csif_info: Command stream interface information. */
 	struct drm_panthor_csif_info csif_info;
 
+	/** @mmu_info: MMU info */
+	struct drm_panthor_mmu_info mmu_info;
+
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e8dc4096c1d2..bfb49fe2a306 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -175,6 +175,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 	_Generic(_obj_name, \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_mmu_info, page_size_bitmap), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
@@ -954,6 +955,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(priorities_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
+			args->size = sizeof(ptdev->mmu_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -984,6 +989,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		panthor_query_group_priorities_info(file, &priorities_info);
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, priorities_info);
 
+	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 452d0b6d4668..46fadb487679 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2782,7 +2782,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	refcount_set(&vm->as.active_cnt, 0);
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= SZ_4K | SZ_2M,
+		.pgsize_bitmap	= ptdev->mmu_info.page_size_bitmap,
 		.ias		= va_bits,
 		.oas		= pa_bits,
 		.coherent_walk	= ptdev->coherent,
@@ -3227,6 +3227,11 @@ static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
 	destroy_workqueue(res);
 }
 
+static void panthor_mmu_info_init(struct panthor_device *ptdev)
+{
+	ptdev->mmu_info.page_size_bitmap = SZ_4K | SZ_2M;
+}
+
 /**
  * panthor_mmu_init() - Initialize the MMU logic.
  * @ptdev: Device.
@@ -3239,6 +3244,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	struct panthor_mmu *mmu;
 	int ret, irq;
 
+	panthor_mmu_info_init(ptdev);
+
 	mmu = drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
 	if (!mmu)
 		return -ENOMEM;
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 0e455d91e77d..b462752c793d 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -253,6 +253,9 @@ enum drm_panthor_dev_query_type {
 	 * @DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO: Query allowed group priorities information.
 	 */
 	DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO,
+
+	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
+	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
 };
 
 /**
@@ -487,6 +490,16 @@ struct drm_panthor_timestamp_info {
 	__u64 cpu_timestamp_nsec;
 };
 
+/**
+ * struct drm_panthor_mmu_info - MMU information
+ *
+ * Structure grouping all queryable information relating to the MMU.
+ */
+struct drm_panthor_mmu_info {
+	/** @page_size_bitmap: Allowed page sizes */
+	__u64 page_size_bitmap;
+};
+
 /**
  * struct drm_panthor_group_priorities_info - Group priorities information
  *
-- 
2.53.0

