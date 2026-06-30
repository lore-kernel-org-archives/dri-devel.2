Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203EAC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51EA610EC1F;
	Tue, 30 Jun 2026 10:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OgcEVG8r";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78FA10EC1F;
 Tue, 30 Jun 2026 10:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUAG6zxNDSXQyNUZZDSC5NB9RasPg9nUIaORmH9ouNqihkHDU6FW8TqUDjZBPFZK0pbyy+DkSNiGXD+oAQHb9VG5QZZkjCH/1E4tLwGBIvedGJdNvvMyZsGMjmb8vHwAOkTH0tE/N7cPbTQIQDzaHyPXAbIZPEeG27xOcXYoYpcZJLzSu896alNvnwjySGUhjJy5xJkQYRhWq4pvL3x2y9JwA2ACOGs8gZP2Wd8fTFrca1etBTi25UX1A5G7egXDy/HvpZqQ/tyQMy/J99FVciCfvAAhSdRWbxCY4j9y03j2EY1Idnyxlbn/ZsKXw4tRbX00lMZvaszlj5hWMY5b/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xBkJZ9akLca8b/RLfE7UCpyqgJhT7kmLBPcOkUq6ak=;
 b=JcN8WGfjjX2XnOPRoT71uWmJ4czxZu0++cObjvtb7IhLBefVhUBQmCeEWDtTJuHO51m1eoPUCYFBlYcRdMuEkj5CFymY04815LcxmccQJKci9HXRWLebu+yiJYkH2amwlgyjKN539fG2IeGPhChv0JMHLmVMsWVGmWrTek05ufU7t6ixuOIy2F43kinXvlw+5CH4MsNmuKaWisJLRB1i8IcM3ApZqUPIRf9LF4CNHShGz23JFxsoaQF1g0SN7YRBHMZ8+VbNnV4/MucuhGQpcWzc2fNB7LDJKj6xWK7j1t45PqG0dotDc1BO3tkHUx+mXqXStQY4eRKt7Grn99z08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xBkJZ9akLca8b/RLfE7UCpyqgJhT7kmLBPcOkUq6ak=;
 b=OgcEVG8r+PvzuJaFiVDqZD2TvF2r2G6rfw58HA8Hcvxl6f3wwJxxJc4FkqH2rQxgd5rkxGX0e17aeMFjy1FTwgLzpYiL6I7j5LQ24rm74JoBkXct3rxtP117AZds76faJH+pPECveyPX96n0j9t8YpdmbCrYX0/h+kqVYvtNfME=
Received: from MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:21:53 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::18) by MN2PR22CA0007.outlook.office365.com
 (2603:10b6:208:238::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 10:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 10:21:53 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 05:21:49 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v10 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
Date: Tue, 30 Jun 2026 18:21:24 +0800
Message-ID: <20260630102127.392396-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630102127.392396-1-honghuan@amd.com>
References: <20260630102127.392396-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: f38f4574-7fc9-43a2-d395-08ded69167a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dVmsiif0So4dAr8H2xKWfuohVgteQzlUgqF0eE3L5/5Y/AlZUAFMhtKLKa7xlQncpUQnsXc2q/FeMy6WuDAEDU/XeW+xCvWOiOlASYPhYvsTCoNRxrg+SOK57sV7PVOur6kVnZ+2/o+zf/ium6U2s6ZPd2RplbBIn7mCCOxP7fTbh+v3DsAWvadmlkw+ldn9Xn62desWF7IrqDx0EEj7NFAP9i3oRwDUIsJ8+59F0URj4HIYmPBirMfBIj9pWWSOAEdCHUw2ZfahkpbuBPjgrG02jaHdjQrm90Ejd4fvw9i889PbZ0z9sVDAuh7o6lCQqvHcVbU5nObVQNJxyzCIJYOhZTk3k6hkbKcCyoRR7JCwpL4Gx8ns8WddW6y+NsbP3W5NxR9dkbw/81pOiB4izjxl5aGdHRSddkih4kYtTbdAqbwS3gWulKpSzqlA6qNOOmUN2II5PyGkAZyOFtfJhVRtWe38/rftRvOND5/u+p+469+DkQnurwhPqGG29nQZpkoTpuRZ3Fsfc/MMWD4Q8Ww11yxT8RGfPwbZ32PhELroLjJvemKIXNtFYUpqUF9AZfrLrPqq44OI/ZykVykWi+Jf8pi0tm1oNlIigZrpmRCSaCt+4V4RfTjf4hi/rolFpYOIJT2UkYIj1KetPRCjLti6SyJqXDYHLhzLvnwU/J2U8lKFuA+r69twC9aiOE2orXkfJATirwWcXFgMVmstbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VhwB2igqclB9vSOsubNEPt1zY8IwE8ZkowevVfPhkdHFzSjJSviXZFhhHsMXGXFJNrd4opVeUsXnKPEf+iQ5bsvv4MHvL1L0QV6VJGBdZ4i4qM6q7JEuF+Kf2INC6UZ2snEufDTVuU8cdRw/KqVBvvg/7gytBjNpiPII0cYEZopGAKm+QUdSSIkMW5sSS7kPH03sNjcVr/Q2S3M8AAe/kB93ejpBVOoHlkkEmGj0Hk7AT61bg7zgmS0hc/u4xneDaLn+yt/l8uMmhUhY1HHn0ArSXBMxxMZtOA0BkksIwb/Q88NifIzvXQ3xIB7Kx6U+sHmMM+jPgTKhaKJUaVRLANBKu6Y2zFh429NFYUcqQy+bpX1CLxlLtUn4lZYY2809bD7zoeZpEZuUloAPK7qabFl8tI4/f1Hesyi4qSZMN/q5pEEU4mLEUpyi0Rk70r+V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:21:53.0156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38f4574-7fc9-43a2-d395-08ded69167a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999
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

drm_gpusvm_pages is the layer that actually represents physical
pages/mappings it owns the dma_addr array, the dma_iova_state...
With the previous patch, so drm_gpusvm_pages is now strictly about
physical pages and their DMA view.

Since now the drm_gpusvm_pages instance is inherently bound to one
specific drm_device, make that ownership explicit by giving
drm_gpusvm_pages its own drm_device handle, and drive all DMA through
it instead of through the gpusvm:

  - Add drm to struct drm_gpusvm_pages and route all DMA in
    drm_gpusvm_get_pages() / __drm_gpusvm_unmap_pages() through
    svm_pages->drm instead of gpusvm->drm.
  - Bind svm_pages->drm where the pages object is initialised
    (drm_gpusvm_range_alloc() and the xe userptr setup) and require
    it to be set on entry to drm_gpusvm_get_pages(); the dma device
    is immutable for the lifetime of the pages instance. A later
    patch introduces drm_gpusvm_init_pages() to centralise this.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c    | 30 ++++++++++++++++++++----------
 drivers/gpu/drm/xe/xe_userptr.c |  2 ++
 include/drm/drm_gpusvm.h        |  2 ++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index abdfdaaf5e2..604554e40f6 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -641,6 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
 	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
 	INIT_LIST_HEAD(&range->entry);
 	range->pages.notifier_seq = LONG_MAX;
+	range->pages.drm = gpusvm->drm;
 	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
 
 	return range;
@@ -1135,11 +1136,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 				     unsigned long npages)
 {
 	struct drm_pagemap *dpagemap = svm_pages->dpagemap;
-	struct device *dev = gpusvm->drm->dev;
+	struct device *dev;
 	unsigned long i, j;
 
 	lockdep_assert_held(&gpusvm->notifier_lock);
 
+	if (!svm_pages->drm)
+		return;
+
+	dev = svm_pages->drm->dev;
+
 	if (svm_pages->flags.has_dma_mapping) {
 		struct drm_gpusvm_pages_flags flags = {
 			.__flags = svm_pages->flags.__flags,
@@ -1421,6 +1427,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 							   DMA_BIDIRECTIONAL;
 	struct dma_iova_state *state = &svm_pages->state;
 
+	if (!svm_pages->drm)
+		return -EINVAL;
+
 retry:
 	if (time_after(jiffies, timeout))
 		return -EBUSY;
@@ -1520,7 +1529,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 				pagemap = page_pgmap(page);
 				dpagemap = drm_pagemap_page_to_dpagemap(page);
-				if (drm_WARN_ON(gpusvm->drm, !dpagemap)) {
+				if (drm_WARN_ON(svm_pages->drm, !dpagemap)) {
 					/*
 					 * Raced. This is not supposed to happen
 					 * since hmm_range_fault() should've migrated
@@ -1532,10 +1541,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			}
 			svm_pages->dma_addr[j] =
 				dpagemap->ops->device_map(dpagemap,
-							  gpusvm->drm->dev,
+							  svm_pages->drm->dev,
 							  page, order,
 							  dma_dir);
-			if (dma_mapping_error(gpusvm->drm->dev,
+			if (dma_mapping_error(svm_pages->drm->dev,
 					      svm_pages->dma_addr[j].addr)) {
 				err = -EFAULT;
 				goto err_unmap;
@@ -1555,11 +1564,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			}
 
 			if (!i)
-				dma_iova_try_alloc(gpusvm->drm->dev, state,
+				dma_iova_try_alloc(svm_pages->drm->dev, state,
 						   0, npages * PAGE_SIZE);
 
 			if (dma_use_iova(state)) {
-				err = dma_iova_link(gpusvm->drm->dev, state,
+				err = dma_iova_link(svm_pages->drm->dev, state,
 						    hmm_pfn_to_phys(pfns[i]),
 						    svm_pages->state_offset,
 						    PAGE_SIZE << order,
@@ -1570,11 +1579,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 				addr = state->addr + svm_pages->state_offset;
 				svm_pages->state_offset += PAGE_SIZE << order;
 			} else {
-				addr = dma_map_page(gpusvm->drm->dev,
+				addr = dma_map_page(svm_pages->drm->dev,
 						    page, 0,
 						    PAGE_SIZE << order,
 						    dma_dir);
-				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
+				if (dma_mapping_error(svm_pages->drm->dev, addr)) {
 					err = -EFAULT;
 					goto err_unmap;
 				}
@@ -1590,7 +1599,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	}
 
 	if (dma_use_iova(state)) {
-		err = dma_iova_sync(gpusvm->drm->dev, state, 0,
+		err = dma_iova_sync(svm_pages->drm->dev, state, 0,
 				    svm_pages->state_offset);
 		if (err)
 			goto err_unmap;
@@ -1640,7 +1649,8 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 			       struct drm_gpusvm_range *range,
 			       const struct drm_gpusvm_ctx *ctx)
 {
-	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->mm,
+	return drm_gpusvm_get_pages(gpusvm, &range->pages,
+				    gpusvm->mm,
 				    &range->notifier->notifier,
 				    drm_gpusvm_range_start(range),
 				    drm_gpusvm_range_end(range), ctx);
diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
index 6f71bc66b14..9df98bcd3ca 100644
--- a/drivers/gpu/drm/xe/xe_userptr.c
+++ b/drivers/gpu/drm/xe/xe_userptr.c
@@ -390,6 +390,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
 		     unsigned long range)
 {
 	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
 	int err;
 
 	INIT_LIST_HEAD(&userptr->invalidate_link);
@@ -402,6 +403,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
 		return err;
 
 	userptr->pages.notifier_seq = LONG_MAX;
+	userptr->pages.drm = &vm->xe->drm;
 
 	return 0;
 }
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 251a7266a73..842353afb27 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -129,6 +129,7 @@ struct drm_gpusvm_pages_flags {
 /**
  * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
  *
+ * @drm: The DRM device that owns the dma mappings
  * @dma_addr: Device address array
  * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
  *            Note this is assuming only one drm_pagemap per range is allowed.
@@ -138,6 +139,7 @@ struct drm_gpusvm_pages_flags {
  * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
  */
 struct drm_gpusvm_pages {
+	struct drm_device *drm;
 	struct drm_pagemap_addr *dma_addr;
 	struct drm_pagemap *dpagemap;
 	struct dma_iova_state state;
-- 
2.34.1

