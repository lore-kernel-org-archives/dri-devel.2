Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94F6C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5046510EF99;
	Thu, 20 Aug 2026 10:07:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228C010EF7B
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:57:46 +0000 (UTC)
X-UUID: 339091649c7511f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:e2ebe949-accd-4390-88b4-ebe25a26028e, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:7db8b62, CLOUDID:f607fdb8deb6c97bb96975fccc9b115e,
 BulkI
 D:nil,BulkQuantity:0,SF:81|82|102|136|865|898|915,TC:nil,Content:0|15|50,E
 DM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
 0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 339091649c7511f19a56ed5b684f684d-20260820
X-User: liupeng01@kylinos.cn
Received: from t14 [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <liupeng01@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1527712827; Thu, 20 Aug 2026 16:57:41 +0800
From: liupeng <liupeng01@kylinos.cn>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, zack.rusin@broadcom.com, christian.koenig@amd.com,
 bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, matthew.auld@intel.com,
 matthew.brost@intel.com, liupeng <liupeng01@kylinos.cn>
Subject: [PATCH 2/2] drm/vmwgfx: Fix typos in comments
Date: Thu, 20 Aug 2026 16:57:37 +0800
Message-ID: <20260820085737.52124-3-liupeng01@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820085737.52124-1-liupeng01@kylinos.cn>
References: <20260820085737.52124-1-liupeng01@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 10:07:27 +0000
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

Fix misspellings of "separate", "whether" and "compatibility".

Signed-off-by: liupeng <liupeng01@kylinos.cn>
---
 drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h | 2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c                    | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h b/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
index f84376718086..d4cdd9f14294 100644
--- a/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
+++ b/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
@@ -125,7 +125,7 @@ typedef __attribute__((aligned(32))) struct MKSGuestStatInfoEntry {
  * interpret the pointers.
  *
  * Because the host side code never acknowledges anything back to the
- * guest there is no strict requirement to maintain compatability
+ * guest there is no strict requirement to maintain compatibility
  * across releases.  If the interface changes the host might not be
  * able to log stats, but the guest will continue to run normally.
  */
diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index f9042bafdc93..38b6a1787865 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -431,7 +431,7 @@ ttm_object_device_init(const struct dma_buf_ops *ops)
 
 	/*
 	 * Our base is at VMWGFX_NUM_MOB + 1 because we want to create
-	 * a seperate namespace for GEM handles (which are
+	 * a separate namespace for GEM handles (which are
 	 * 1..VMWGFX_NUM_MOB) and the surface handles. Some ioctl's
 	 * can take either handle as an argument so we want to
 	 * easily be able to tell whether the handle refers to a
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e89..7bf128edfd4a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -445,7 +445,7 @@ static int vmw_legacy_srf_create(struct vmw_resource *res)
  *                  vmw_surface.
  * @val_buf:        Pointer to a struct ttm_validate_buffer containing
  *                  information about the backup buffer.
- * @bind:           Boolean wether to DMA to the surface.
+ * @bind:           Boolean whether to DMA to the surface.
  *
  * Transfer backup data to or from a legacy surface as part of the
  * validation process.
-- 
2.53.0

