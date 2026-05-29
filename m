Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D982CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F67A10F915;
	Fri, 29 May 2026 05:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lSYWK0y3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D9110F912;
 Fri, 29 May 2026 05:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpL4cp4IJNvPErIexP2s1XeaajHKeBIezkTAwCbyPjkgLKhE0o+u+nuTZBgfDfJBalPuvYrZt4N8JVQCVdg+ddY+9HE/Wa/zH7Em2kTi5Hrz7dWXlzdnsJFdsbRxU8PUUfVbhAB6TYLFOCQa7OydDOKD4mznRr62Nw1UHP4I4qSmsLpr4RRJI+bh2b6TBObblj+EPwWpOoDTOnfHMlYtBNqbOaGMSoIzah8MLlBoXeE3cWl57Y8+xZg7G6HffOihnQiCtztSOElzxoPua6kfxeWnNatJRphMJqV7dHvUyZIx0SbRczegEnlb5V0lDNnlbzjG5oKPgZpsgv07mlWWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3870aZWKmpepYvtBHdzmvpJhaEoH6VQofSwP15gAlzM=;
 b=DA83rLmEbafsowGJnFX+STzM6krC3BwzJl3hWfhcDiyv4Yb4ppHXvqQU251x9Aj6mBz7T7hjarzg2EZvt6y6WP67YNbo8nV9DOL2xcG8wuImX8o7JTPUnZsktlvcP33WTndrJawN0esIrzQ86LpBS9O0K4DzthM/C6s7ASOtQFyUKF/lOWSP0iZVxhIgr2oPQ3xOPCLYZEUN0ubQtjEoNN+GqRSjLTVoH3O6ar7r/ybVwumhvgV0QxU+07V01lMut0vqbQ1guJKy5/B2iKMoarHtAc/Zs0vbmjrTbVVMkUxS33vJjhvMT75/H9Ns0pVDPS0P+an1FQicedvw+9iTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3870aZWKmpepYvtBHdzmvpJhaEoH6VQofSwP15gAlzM=;
 b=lSYWK0y3e1dr2FO2q4OZ2Dn3p3K9StqAAl1+WAEZWe9P5HE1D15qAFrATZCt3JcIjkDbKACK49YfTU9CBRASeY2c3vVYnyr6p8ONLYY75mr1XWMiInbQ1500Lg2/swo/HTzG9kGv6cELhu07f8dG3qswMmMwlKJ43Oc8y6axYV8=
Received: from CH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:610:32::29)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:50:23 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::1b) by CH0PR07CA0024.outlook.office365.com
 (2603:10b6:610:32::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:50:23 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:50:17 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 8/8] drm/amdgpu: wire xnack-off restore into lifecycle and
 attr set
Date: Fri, 29 May 2026 13:49:28 +0800
Message-ID: <20260529054928.596825-9-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054928.596825-1-honglei1.huang@amd.com>
References: <20260529054928.596825-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 0068f635-4118-4089-6c93-08debd462ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|921020|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: l4D4OCB19Vt/m4QnH3keCimDrCj+DRUhTtXquq4sHRS8mqQe/yXBhPv8MXIu2GZ3h2YqbT+7ATd+EhqU1DNUI/Xw5o2j84EkZyf1yZCP/5UL05KCRzyzeTvD0qqJBMOm8NFDibTLEsViyLxB0x52uvVXM57WKLEXzpkL3RiAnfNjdVWlhCexGEBAC8wyo2plsHl09R8YlOMHK3/Z2w6h9FkvGOoiy+WqdaWoDP7heUJSHg+RTYOhyEI+ruQz6aDCqCXo4+mn6YhaJtdZi4B9OkDhnybfHVY+8vK5MbTmfuwGU3Bq4RSm5p4oCBOsjeyy4iM8Bm6yLj/9jNyDnYQa2/ajhhVDx0Ljb24+9oqlO7slRSfdfKhqfZ24BMlfPrs8XAY+sx+O8J0mruMZRxKz7hdUx+JL+bv4sCO12tI9qZsTs1zzdkiZSM/itr3/F2rUe4zx/yX8fkpZLXmAxhLLTLS/tdTrj/WJeKR9ly3895jibx5lAVghnHNIyy4S0MF3K97i8RttvpSNl8A9YicMeGRkS9R99GfU034W2lXwxhP4EgTR4B4PtbAOHsOtbGmTw5ZLQICIlCzjjpRmJGK/RoRfG3KbVP4y9AVnETRsXYuVGCutiHYuAs5uVoYzJGoHX3vin9VMDgHa+zvxSJmdcpxMsZS/K1mN+qW5XOo1BpsCUhcEhMdpfQH6+nXHFOIxCE8R8CMk1YsGVy3GCKZ37t0DC5ASE/BwXYI06aqp/OEV/pieQrvX3nDUFFkDCugUXl/Zz8W7pfqdvhUNUql4sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(921020)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kywKWLT9RbKgTNaQ+qFRMxjAhhbNOuyd0nepMCN/jDHwMB0kMNUKZ8SN+40WPBTY12HSt0cvfvAsTmFpjg73Z7CBmcOPy0RlasTyn0KT8O/e31xhcNVGnACfVQtba/IONiGN4XELwJEYyInegtl93DMymVA6m46Jx9cFc+96BicYVsP/vyn3WDrZ5N/m3v7Z48G7iihPFSKeMwI4wpD7LXk9CcQO28uK0pOyeSyWHnw1ZdtrBK0aI5itGh/MzpQN5keNWulK0c81W0rNwHYFlTBB1ZS2b5w0riikBOhL9AwfDsdjQefT4odPStXvkzcl/R0wP+PclRbumvc/OJ67nl3Kg28yJn+gTeRH6wlp7gQGRWBjvipqGCbGZZjdyDQbLN6MBe2I0FnI7DdEL+2tYj9HU0SObiEc7TDEE0jrylZqIN7tQj2hjmBlhSrmF94T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:50:23.1165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0068f635-4118-4089-6c93-08debd462ce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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

From: Honglei Huang <honghuan@amd.com>

amdgpu_svm_attr.h:
- Add AMDGPU_SVM_ATTR_TRIGGER_NEED_REMAP macro as an alias for
  AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE. Both cover the same
  trigger set today but carry different semantics: NEED_INVALIDATE
  is used by xnack-on (invalidate GPU PTEs, rely on fault to
  rebuild), NEED_REMAP is used by xnack-off (eagerly rebuild GPU
  mapping since no fault mechanism exists). Keeping them as separate
  macros allows future divergence without code churn.

amdgpu_svm.c:
- amdgpu_svm_apply_attr_change: xnack-off remap decision now uses
  AMDGPU_SVM_ATTR_TRIGGER_NEED_REMAP instead of open-coding the
  four trigger flags.
- amdgpu_svm_work_init/fini: call amdgpu_svm_restore_init/fini for
  XNACK_OFF; unwind gc on restore_init failure.
- amdgpu_svm_init_with_ops: accept begin_restore/end_restore
  callbacks and forward them to work_init.
- amdgpu_svm_init_compute: xnack-off path now calls init_with_ops
  with amdgpu_svm_restore_invalidate,
  amdgpu_svm_restore_gc_work_func, and
  amdgpu_svm_quiesce_compute/resume_compute as the begin/end-restore
  hooks (replacing the previous -EOPNOTSUPP stub).
- amdgpu_svm_sync_work: XNACK_OFF path flushes restore -> gc ->
  restore.wq -> gc.wq so any work re-queued during draining is
  fully drained.
- amdgpu_svm_apply_attr_change: in XNACK_OFF mode, dispatch to
  amdgpu_svm_map_attrs_with_restore(); XNACK_ON path unchanged.

amdgpu_svm_range.c:
- amdgpu_svm_range_put_if_dequeued: add RESTORE_WORK branch to
  re-queue ranges into the restore list when restore ops are
  pending, mirroring the GC re-queue logic.

Makefile:
- Add amdgpu_userptr.o to obj-y/build/clean targets so the restore
  worker translation unit gets linked into amdgpu.ko.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 56 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  8 +++
 4 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 608d30d9a..b15a8e23e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -328,12 +328,12 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_fault.o amdgpu_svm_range.o
+	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_userptr.o
 
 .PHONY: clean-svm
 clean-svm:
-	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o \
-	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd
+	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o $(obj)/amdgpu_userptr.o \
+	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd $(obj)/.amdgpu_userptr.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 96b8f9454..626c5790e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -270,6 +270,18 @@ int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
 
 	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_PREFETCH)
 		needs_mapping = true;
+	/*
+	 * With xnack off there is no page fault mechanism to lazily establish
+	 * GPU mappings, so they must be in place before the GPU runs.  The attr
+	 * layer has no visibility into actual GPU mapping state, so force a
+	 * mapping pass whenever the range is accessible, even when attrs are
+	 * unchanged, to guarantee the GPU mapping is current.
+	 */
+	if (XNACK_OFF(svm) && new_access && !trigger)
+		needs_mapping = true;
+	if (XNACK_OFF(svm) && new_access &&
+	    (trigger & AMDGPU_SVM_ATTR_TRIGGER_NEED_REMAP))
+		needs_mapping = true;
 
 	if (!trigger && !needs_mapping)
 		return 0;
@@ -296,6 +308,11 @@ int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
 	if (!needs_mapping)
 		return 0;
 
+	if (XNACK_OFF(svm))
+		return amdgpu_svm_map_attrs_with_restore(svm, new_attrs,
+							 start_page,
+							 last_page);
+
 	return amdgpu_svm_range_map_attrs(svm, new_attrs,
 					  start_page << PAGE_SHIFT,
 					  (last_page + 1) << PAGE_SHIFT);
@@ -331,7 +348,9 @@ static void amdgpu_svm_flush_tlb_compute(struct amdgpu_svm *svm)
 }
 
 static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
-				void (*gc_work_func)(struct work_struct *));
+				void (*gc_work_func)(struct work_struct *),
+				void (*begin_restore)(struct amdgpu_svm *),
+				void (*end_restore)(struct amdgpu_svm *));
 static void amdgpu_svm_work_fini(struct amdgpu_svm *svm);
 
 static int amdgpu_svm_init_xnack_mode(struct amdgpu_device *adev,
@@ -370,6 +389,8 @@ static int amdgpu_svm_init_with_ops(struct amdgpu_svm *svm,
 						struct drm_gpusvm_range *,
 						uint64_t, uint64_t),
 				    void (*gc_work_func)(struct work_struct *),
+				    void (*begin_restore)(struct amdgpu_svm *),
+				    void (*end_restore)(struct amdgpu_svm *),
 				    void (*flush_tlb)(struct amdgpu_svm *))
 {
 	struct amdgpu_device *adev = svm->adev;
@@ -378,7 +399,8 @@ static int amdgpu_svm_init_with_ops(struct amdgpu_svm *svm,
 	svm->flush_tlb = flush_tlb;
 	svm->invalidate_ranges = invalidate_ranges;
 
-	ret = amdgpu_svm_work_init(svm, gc_work_func);
+	ret = amdgpu_svm_work_init(svm, gc_work_func, begin_restore,
+				   end_restore);
 	if (ret)
 		return ret;
 
@@ -445,10 +467,15 @@ static int amdgpu_svm_init_compute(struct amdgpu_device *adev,
 		ret = amdgpu_svm_init_with_ops(svm,
 					       amdgpu_svm_range_invalidate,
 					       amdgpu_svm_gc_work_func,
+					       NULL, NULL,
 					       amdgpu_svm_flush_tlb_compute);
 	} else {
-		AMDGPU_SVM_ERR("xnack off is not supported yet\n");
-		ret = -EOPNOTSUPP;
+		ret = amdgpu_svm_init_with_ops(svm,
+					       amdgpu_svm_restore_invalidate,
+					       amdgpu_svm_restore_gc_work_func,
+					       amdgpu_svm_quiesce_compute,
+					       amdgpu_svm_resume_compute,
+					       amdgpu_svm_flush_tlb_compute);
 	}
 
 	if (ret)
@@ -597,7 +624,9 @@ static void amdgpu_svm_gc_flush(struct amdgpu_svm *svm)
 }
 
 static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
-				void (*gc_work_func)(struct work_struct *))
+				void (*gc_work_func)(struct work_struct *),
+				void (*begin_restore)(struct amdgpu_svm *),
+				void (*end_restore)(struct amdgpu_svm *))
 {
 	int ret;
 
@@ -608,17 +637,34 @@ static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
 	if (ret)
 		return ret;
 
+	if (XNACK_OFF(svm)) {
+		ret = amdgpu_svm_restore_init(svm, begin_restore,
+					      end_restore);
+		if (ret) {
+			amdgpu_svm_gc_fini(svm);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 static void amdgpu_svm_work_fini(struct amdgpu_svm *svm)
 {
+	if (XNACK_OFF(svm))
+		amdgpu_svm_restore_fini(svm);
 	amdgpu_svm_gc_fini(svm);
 }
 
 void amdgpu_svm_sync_work(struct amdgpu_svm *svm)
 {
 	amdgpu_svm_gc_flush(svm);
+	if (XNACK_OFF(svm)) {
+		amdgpu_svm_restore_flush(svm);
+		amdgpu_svm_gc_flush(svm);
+		flush_workqueue(svm->restore.wq);
+	}
+	flush_workqueue(svm->gc.wq);
 }
 
 int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
index d8eedf578..ce7be1bc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -121,6 +121,9 @@ enum amdgpu_svm_attr_change_trigger {
 	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
 	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
 
+#define AMDGPU_SVM_ATTR_TRIGGER_NEED_REMAP \
+	AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE
+
 struct amdgpu_svm_attr_tree *
 amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
 void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index f1be2f2d5..ef913a236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -699,6 +699,7 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
 {
 	bool release_kref = false;
 	bool queue_gc = false;
+	bool queue_restore = false;
 
 	spin_lock(&svm->work_lock);
 
@@ -711,6 +712,10 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
 		list_add_tail(&range->work_node, &svm->gc.list);
 		range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
 		queue_gc = true;
+	} else if (RESTORE_WORK(range->pending_ops)) {
+		list_add_tail(&range->work_node, &svm->restore.list);
+		range->queue_state = AMDGPU_SVM_RANGE_IN_RESTORE;
+		queue_restore = true;
 	} else {
 		range->queue_state = AMDGPU_SVM_RANGE_NOT_QUEUED;
 		release_kref = true;
@@ -720,6 +725,9 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
 
 	if (queue_gc)
 		queue_work(svm->gc.wq, &svm->gc.work);
+	if (queue_restore)
+		queue_delayed_work(svm->restore.wq, &svm->restore.work,
+				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 	if (release_kref)
 		drm_gpusvm_range_put(&range->base);
 }
-- 
2.34.1

