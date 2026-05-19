Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3EBCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6375A10EBD7;
	Tue, 19 May 2026 09:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tldctFwe";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B22310EBD7;
 Tue, 19 May 2026 09:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3+89+ojSKFSjcxt9zevci3H1RPWOlDOugBuT8N9Es/GKI/iUDVy11V0NQTAHA+5SehmUsX5+t0E3roiBXre+yWccURmJcFWA+0e2D5o4/9abX4Pvn+oo82CBY3vbEygVDUTWGk5QniQB9UWyvATScqhYvZW6Yrz2XmljyzNxUTWj1yFHVD6IQYqw6611KfzQFVivkinnFj8dtyK8OfUp6rWXlOhPDUFK3TSV/3AKeMM3I9rwGq5L+0q/wRr82WfI1CbGkwUkgMryDj//hNeHPxO3ek0UE8OA9t+hWygQZZbEYtUAoA8ITBbIvBduK6REfzy41krV3+UGIDJZb4OMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D58esjUbXi32+yQ0d9fyN1gjafmaevogTDQSz4CFHLM=;
 b=LvBv+UewnQgAGocuE7lLo9ogY5K3iyDoH0Fh9GdeznxCWxMaRuHIkGDTVqmiDnGbIRAkUgz8wC6U06XLAQCVIvWyh1vStSBuUSNR+LnPdYprwPoQNbh99H222iE6CFFX/SCnZh6LoOcmileLyYK+W/PcOePrhDoykHVJtBkGLzBTaBgI7XZ1r5I7JSOv1tRDZGFpwuJ1BHnAmGfmWqD3qJjH5sWpx58+THYBga6o0Gf4Gs160Pg0adOr3lxsy/SSennJqK19Uf++e911FO8XUgaLf4CNAgKtGbMMONTVa4zTJr+hiup5Jhf0Q6JgQ0BzyNQPMXRDWkeNKZf12ox13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D58esjUbXi32+yQ0d9fyN1gjafmaevogTDQSz4CFHLM=;
 b=tldctFweoJslLkKMWJVk6BLgu03wNTJeupBWbSfgbCaE3cHOOUti1sHwLmyZAtn+WixjQKXi4MHmM1T2brGW0gkeYnCoWnPwmi3NbW8GyMlJ7+5hUbjgHsDo728eCn0GQ7bpNsQlaNm4AJLYq/xCb1MRvzdLLPizTvJMhEAd7hs=
Received: from CYZPR17CA0014.namprd17.prod.outlook.com (2603:10b6:930:8c::10)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 09:24:09 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:930:8c:cafe::6f) by CYZPR17CA0014.outlook.office365.com
 (2603:10b6:930:8c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:24:08 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:24:04 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 8/8] drm/amdgpu: wire xnack-off restore into lifecycle and attr
 set
Date: Tue, 19 May 2026 17:23:13 +0800
Message-ID: <20260519092313.3115848-9-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519092313.3115848-1-honglei1.huang@amd.com>
References: <20260519092313.3115848-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5019a3-7a14-4ca8-0163-08deb588615d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|921020|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xuy1a5+J4uQT7wPX1HUbTXbz0oEHQEMrR/+SEQS//YBL3sPvxcrqN+pdD4xBslzro3mGcRwwUQpIMGihjvA2Llo1qaJEtrM1QEx0yC/saFwN1csetxZdCy4KDRfwULJaOJm2gwyKFT41W8OdrDQzrXep/4i+osq/16BDcEF9e0WluDdOHU9+avMFOg0e9xM038lPAC98HO2vzQWxGQwzRN1Sbdo4FcEo56a/SdFSfV5myLT7X5ssUpcpihTzsZHZFsWVgu/BTzxDhFURCUTn7QXbMAXajPQLfIzUagwMH2IMI1ZntzY2X32yIqExCnbgNxZToS/OnM3Iap3nKlw+i/7a7L14Win0OMmg6Ow8FfetvrIU9tZmbP0El2gvAQXwyun0B3dMAQq2mrN0tuD03JHCuuyWnB4OZs2yrKrV+8j84dtLfOSxsNa9FSoTlLmbJa4h3E3rDUS9xQ2fA1zY4CpOhLKH5ILYQIFsrzT3adOkcU8Fe+CR+yR3pqGIQ2mT5q4yONm7m3Mhvxbm9c+uHTE530Fw7RiCzouJPOqHFn5IgvmUNIsJ81Bhnsv4fvyLjT8NSW2oLDyM70J4I4ayyw+SkekaQ2FMeqTx8Kaymu0uK06FPGLOMP7L7mQnsCvmeB8x29c3G5vFS391NzsfDM1Tyqq+cy179dKeBP9KqIUzrwZ35adRaEdrZiYMsQi5IytOhC5p7gDBqlC4luHPrHaqavNpUlB65hbmMc8cq2dcGBrn5nX61/xdQ7ElviY4gavvSU+bXXmOe/wZE4a33A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(921020)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FpiojLEKveTZN/L5mbdpsQe+E9a+PIDxKnwV+NmfxhcoYbJg6D3PDd+oJBwhCKO32zjH/1AZIaeKGPIhj95Fennby0eFghe1UeOU0GYLzkC++ZL+J2Z+LbLq9V/m5RbEzgKrWcm1j7Q823CUiNEnzbWLSYtKkEA78TzlbwV86ldaXAj/UlqKCwry1cSr3P4RffT29Ob4p/45si9BK9GXOID63Wf3YLjtupe/AyMu4u8DuXuaCUw33TYIs6i7/aQTp68zTT8CJNzoJ5IzPG2DWEO/6tAkqfoDn91p1gR1XH2fseDwLLyi/EHm70yc8AOtZh8olYVr6w+9JUBwt3vSrV+0MS/RPdSWPYIhmGxnQNvJ/U56pAA7RBFWmjCwZY7eWLhbnTy0nRSUwVlwkl9ieW4HvM7/sCe3yRmOW0if14BC3br8A67Tdk7XY6rqslsF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:24:08.6260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5019a3-7a14-4ca8-0163-08deb588615d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

amdgpu_svm.c:
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
 drivers/gpu/drm/amd/amdgpu/Makefile           |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 44 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  8 ++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a40a42995..0485128c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -323,12 +323,12 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
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
index b3cca1ff5..67a94086a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -315,6 +315,11 @@ int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
 	if (!update_mapping)
 		return 0;
 
+	if (XNACK_OFF(svm))
+		return amdgpu_svm_map_attrs_with_restore(svm, new_attrs,
+							 start_page,
+							 last_page);
+
 	return amdgpu_svm_range_map_attrs(svm, new_attrs,
 					  start_page << PAGE_SHIFT,
 					  (last_page + 1) << PAGE_SHIFT);
@@ -350,7 +355,9 @@ static void amdgpu_svm_flush_tlb_compute(struct amdgpu_svm *svm)
 }
 
 static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
-				void (*gc_work_func)(struct work_struct *));
+				void (*gc_work_func)(struct work_struct *),
+				void (*begin_restore)(struct amdgpu_svm *),
+				void (*end_restore)(struct amdgpu_svm *));
 static void amdgpu_svm_work_fini(struct amdgpu_svm *svm);
 
 static int amdgpu_svm_init_xnack_mode(struct amdgpu_device *adev,
@@ -389,6 +396,8 @@ static int amdgpu_svm_init_with_ops(struct amdgpu_svm *svm,
 						struct drm_gpusvm_range *,
 						uint64_t, uint64_t),
 				    void (*gc_work_func)(struct work_struct *),
+				    void (*begin_restore)(struct amdgpu_svm *),
+				    void (*end_restore)(struct amdgpu_svm *),
 				    void (*flush_tlb)(struct amdgpu_svm *))
 {
 	struct amdgpu_device *adev = svm->adev;
@@ -397,7 +406,8 @@ static int amdgpu_svm_init_with_ops(struct amdgpu_svm *svm,
 	svm->flush_tlb = flush_tlb;
 	svm->invalidate_ranges = invalidate_ranges;
 
-	ret = amdgpu_svm_work_init(svm, gc_work_func);
+	ret = amdgpu_svm_work_init(svm, gc_work_func, begin_restore,
+				   end_restore);
 	if (ret)
 		return ret;
 
@@ -465,10 +475,15 @@ static int amdgpu_svm_init_compute(struct amdgpu_device *adev,
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
@@ -617,7 +632,9 @@ static void amdgpu_svm_gc_flush(struct amdgpu_svm *svm)
 }
 
 static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
-				void (*gc_work_func)(struct work_struct *))
+				void (*gc_work_func)(struct work_struct *),
+				void (*begin_restore)(struct amdgpu_svm *),
+				void (*end_restore)(struct amdgpu_svm *))
 {
 	int ret;
 
@@ -628,17 +645,34 @@ static int amdgpu_svm_work_init(struct amdgpu_svm *svm,
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 98e66a301..5cd0d1540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -674,6 +674,7 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
 {
 	bool release_kref = false;
 	bool queue_gc = false;
+	bool queue_restore = false;
 
 	spin_lock(&svm->work_lock);
 
@@ -686,6 +687,10 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
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
@@ -695,6 +700,9 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
 
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

