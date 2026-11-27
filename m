Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41743606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xMqBhq7k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2523F112887;
	Fri, 27 Nov 2026 08:43:25 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7F811287B;
 Fri, 27 Nov 2026 08:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1C2/amVafrEHo9NHtCL8g4JFxwPsk6+rJitbRl00/dQiFGuWPxcuNhsyooKCgH9xMcK9TooWrOQAQd53pOcEOTRKDmDuJBBl5hJi6J3gMcZcoyicFQIYRCPo0qBvd/tIzNRPXJSqIcKRAxtWKzioDMYj7uk9YRRdoNeNxV4ZjohDldse5GL0k5WCjfUD4EqwFo+6HZZEban1gWqq5U+jD4mTzdI2mSLDxwCG+4hiS4+ObqeoU+SH+gBlX9N6edouuWjJ9pYRNfZWJA3qKsdzYp+HIzbDBRBYdZYEkzUa2WAZGB1QIelyO7i0Y8wH2LiG4r0ao4kJYV47MJFMCqpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6ASadsQpzqgJQ9Zv69L6861B6dGMYo7f/DmpF3Ae8E=;
 b=RaREGr+Sxnra158d0fXJrpuTx6QytdefZNQt7LdOAkoV/9cRcy+nOfbM46qcIwz+y2w0onHLykQLo7I2+8Ef64nRue7fQLeyj/Sujb3+xDtZdx0stApQ6qRqUttYX2eMWSR/zElhf2ChU6OuAP3QF0EgHesRkaEQ+PNvn3OBF2Gfwmp0LghmwOEQbQYUB9QPk4XQ4Ife0IyaiHrbWAlErEqV/LIXFQJxpCcaUVCh7Dy40mqlvJWPjtGSI0bQo9xSBNDuP5OsXMS7wbRgR8YtrqRmQIoSqKg1Lc+E7XR0yot4wx2n9UyfJBoY66I02v4itzbP0enoDGqzC/5oY6U3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ASadsQpzqgJQ9Zv69L6861B6dGMYo7f/DmpF3Ae8E=;
 b=xMqBhq7kVJK5Hhsq+y/RNIbXNAOsPlcbyrJdgYFtiUrtitWQvalilrkmhjtJ+/LUNntsCaJTNHiCVuo3sTMS5NY8tLfJJCaVvUN3/lOLKF5ZhjAEFTqHIoF2rcIWxBdxu1krc5Qzuy6GQoqxWFlPqsW9nw8KruRm1L2QbBv4BW8=
Received: from CH2PR20CA0006.namprd20.prod.outlook.com (2603:10b6:610:58::16)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 08:43:01 +0000
Received: from CH2PEPF000166BD.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::7) by CH2PR20CA0006.outlook.office365.com
 (2603:10b6:610:58::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 08:43:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BD.mail.protection.outlook.com (10.167.252.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:43:00 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:55 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>, Yu Huang <Yu.Huang@amd.com>
Subject: [PATCH v11 14/22] drm/amdgpu: recheck range validity after page table
 allocation
Date: Fri, 27 Nov 2026 16:41:37 +0800
Message-ID: <20261127084149.925625-15-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BD:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6ad77e-efcb-46d0-f2b1-08df4c6271cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|921020|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|5023799004|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: qU9dXtu6jJEp2t+ek2LCGnUiBkkwy1BhQr+pbPQvi7n8M+nORmawnhNw6Zoh7QYyX7fu2KvR71oz7oSI31Dt7C2Gc2PaOC26MwCd/1/+yxbPDloVNN+tLXscBnP5bL9ld1rhvxJG/RYTN4+Ujvu8qg7pTQQKP1meSc3GS5yPt7jxo3FwUza86EcPvW9CbMkKIACMPpq3HALF0ngfXLG2Mz6u7w4hdhG4VlKhIQlF4ReLD4vHku8XirTpnKQbmaX7GATo/d/saoE++Gg5ok8k0Vjtcq0A6hQx/bvh1J4KxeYrDPGTJVkTf4s26LX6BiV4Ju5ZqIhKTXKZJH/f6ZxRDypkiZryfv0btJ4IwEq8MFuX3uPWsyzdx3ANLlwvzMnfAZrkjE5TjVRpZkCoVp3ItraLSjSdVRFVg3dmD5qLHnNPOaARAV66XC2Ec7nSW7E+OuMZkVODEYFT/md3tJuQtiwIdZS+XH0Bhx68Q8vSJHitFxlsdE/Igh7vNqtr1vs9OR7YdlCiNIqXB/D4d2lfLkP2+LqeSMSyuZSiExmAsgcLHOrqh6gAcrslETcjR7eQBTePfEwDrtKi6Yqg96aUUOYqNzAArMkRBtVVpmmiiHdDfH/rcYwumYiOM0h8eZzGIty+Lm3ZR34KDJSKz58UMnlPaqbBGIv9Ba/mI8epNJUHodaDWWzu0SPXSlU5+QtP8Gy9NzN4xqPLWLcr3btDB/zAn2O6oK0Ok/ldvcFF71cmBdY10t7lsJnID0/T3wVL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(921020)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(5023799004)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8n2+wRCRR+UQ151F8V2HXHP88kSA5ZKXz4yjEc07DeFkAjhRHUFbEA326RfHqBYuTQwWb2jNriDO6OJLQ+Hux5p1Mz+NveLYztWFswFiTrHj5MXbDMUZUk+MvuKsc+OHDp08GFpVGDGo7HkMJuxQ7Sp1kT5ZbKlyqD2RiFAcHjQRUtVJ3RWN+l+SMo4h2yfelNMHDtRztxdxFRUj+bjV00tTj5p/DDRUGscIxEmQLV60WbgNsMb6Db7kKDS2m5hBNiKfn9crFFyIKM0LSSo4gt49ESf2YZeh/x+at+/Vb4/rrdTGjkVA7VOltlvoukl94FjDTFV2vR6iMilFQ4OigQkIFAr8aXlS+LV13czNUH+jVFETsDSNzhX11BtyKcCNDYy2cE7trErlyqyG5baph0fSIWatC/8qJNbXh3taV17ha4efwCGoLMhhqhmWi9nf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:43:00.9293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6ad77e-efcb-46d0-f2b1-08df4c6271cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Page-table allocation can enter reclaim and invoke an MMU notifier
that needs the same lock as VM eviction. Release the selected lock
around allocation and reacquire it before continuing the update.

Revalidate HMM or GPU SVM backing after reacquiring the lock, returning
-EAGAIN when invalidation changed it. For SVM, also reject range-level
unmap state before checking the device-owned page sequence. Guard the
SVM-specific check when that feature is disabled.

Allow callers to supply an eviction lock that they already hold.
Other callers pass NULL and retain internal locking. Update the VM,
KFD, command submission, GEM, user queue and UALink callers to match
the helper interfaces, and remove the obsolete allocation error label.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Yu Huang <Yu.Huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 24 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 77 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  9 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 29 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 31 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  7 +-
 11 files changed, 132 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6f9a2f1cde1e4..4507c3ae78621 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -514,7 +514,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
 	int ret;
 
-	ret = amdgpu_vm_update_pdes(adev, vm);
+	ret = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 38b454a3e8fc1..273e968ea1323 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1210,7 +1210,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 87022cdb79aff..496eccfa9f1c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -851,7 +851,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	}
 
 	/* Always update PDEs after we touched the mappings. */
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 
 error:
 	if (r && r != -ERESTARTSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index f201105e94c53..6cc491cdc3ca5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -73,7 +73,8 @@ int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm, struct amdgpu_svm_range *r
 		return 0;
 
 	flags = memalloc_noreclaim_save();
-	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, true, NULL, start_page, last_page, &fence);
+	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, true, NULL, start_page, last_page, NULL,
+				    &fence);
 	memalloc_noreclaim_restore(flags);
 
 	if (fence) {
@@ -148,7 +149,8 @@ int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm, struct amdgpu_svm_
 		 */
 		ret = amdgpu_vm_map_range(svm->adev, svm->vm, flush_tlb && is_last_seg, true, NULL,
 					  start_page, last_page, pte_flags, 0, dst, NULL, NULL,
-					  NULL, wait_fence && is_last_seg ? fence : NULL);
+					  NULL, NULL, NULL,
+					  wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
 			return ret;
 	}
@@ -263,7 +265,7 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm, struct amdgpu_svm_ra
 	dma_fence_put(fence);
 
 	if (!ret)
-		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm);
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, NULL);
 
 	if (!ret) {
 		if (flush_tlb)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 45654d9561abf..e8a00c0b59e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2064,14 +2064,14 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 
 	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
 				npa_addr + size - 1, pte_value, 0, 0, NULL,
-				NULL, NULL, &vm->last_update);
+				NULL, NULL, NULL, NULL, &vm->last_update);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
 		goto out;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during unmapping NPA: 0x%llx\n",
@@ -2117,7 +2117,7 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
 				npa_addr + size - 1, pte_flags, offset,
 				adev->vm_manager.vram_base_offset,
-				bo->tbo.resource, NULL, NULL, &vm->last_update);
+				bo->tbo.resource, NULL, NULL, NULL, NULL, &vm->last_update);
 	if (r) {
 		dev_warn(adev->dev,
 			"Failed to map NPA addr (%llx) into NPA VM\n", npa_addr);
@@ -2125,7 +2125,7 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 		goto out;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		dev_err(adev->dev,
 			"failed %d to update page directories for NPA: 0x%llx\n",
@@ -2656,7 +2656,7 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 					pte_flags, 0,
 					adev->vm_manager.vram_base_offset,
 					bo->tbo.resource, NULL, NULL,
-					&vm->last_update);
+					NULL, NULL, &vm->last_update);
 
 		if (r)
 			dev_warn(adev->dev,
@@ -2667,7 +2667,7 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 			break;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during force retry rpcs\n",
@@ -2792,7 +2792,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 		r = amdgpu_vm_map_range(adev, vm, true, false, NULL,
 					npa_addr, npa_addr + size - 1,
 					pte_value, 0, 0, NULL, NULL, NULL,
-					&vm->last_update);
+					NULL, NULL, &vm->last_update);
 
 		if (r)
 			dev_err(adev->dev,
@@ -2804,7 +2804,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			break;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during all NPA addresses unmapping\n",
@@ -4622,7 +4622,7 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
 				npa_in_pages, npa_in_pages + size_in_pages - 1,
 				pte_flags, offset, adev->vm_manager.vram_base_offset,
 				bo->tbo.resource, NULL, NULL,
-				&npa_vm->last_update);
+				NULL, NULL, &npa_vm->last_update);
 	if (r)
 		dev_dbg(adev->dev, "failed %d to map npa 0x%llx to NPA VM\n", r,
 			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
@@ -4656,7 +4656,7 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct a
 	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
 				npa_in_pages, npa_in_pages + size_in_pages - 1,
 				pte_flags, offset, 0, bo->tbo.resource, NULL,
-				NULL, &npa_vm->last_update);
+				NULL, NULL, NULL, &npa_vm->last_update);
 	if (r)
 		dev_dbg(adev->dev, "failed %d to unmap npa 0x%llx from NPA VM\n", r,
 			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
@@ -4920,7 +4920,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, NULL);
 	if (r) {
 		dev_dbg(adev->dev, "failed %d to update directories\n", r);
 		goto out_unreserve;
@@ -5065,7 +5065,7 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, NULL);
 	if (r) {
 		dev_dbg(adev->dev, "failed %d to update directories\n", r);
 		goto error_npa_mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 93b088d2ea0aa..2fbc2b2c1aa14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1190,7 +1190,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		goto retry_lock;
 	}
 
-	ret = amdgpu_vm_update_pdes(adev, vm);
+	ret = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (ret)
 		goto unlock_all;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6f7043bdd2020..b1b90075a023a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1028,13 +1028,15 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
+ * @eviction_lock: optional caller-held eviction lock
  *
  * Makes sure all directories are up to date.
  *
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			  struct rw_semaphore *eviction_lock)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry, *tmp;
@@ -1053,6 +1055,16 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	params.adev = adev;
 	params.vm = vm;
 
+	/*
+	 * Keep PDE updates under the SVM eviction lock so MMU notifier
+	 * invalidation won't happen between the PTE and PDE updates.
+	 */
+	params.eviction_lock = eviction_lock;
+
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error;
+
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
 	if (r)
@@ -1079,6 +1091,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		amdgpu_vm_bo_idle(entry);
 
 error:
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -1155,6 +1168,8 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
  * @hmm_range: to check validity of DMA addresses
+ * @eviction_lock: optional caller-held eviction lock
+ * @gpusvm_range: optional SVM range to revalidate
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last. Allocate and free
@@ -1170,6 +1185,8 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			uint64_t vram_base, struct ttm_resource *res,
 			dma_addr_t *pages_addr,
 			struct amdgpu_hmm_range *hmm_range,
+			struct rw_semaphore *eviction_lock,
+			struct drm_gpusvm_range *gpusvm_range,
 			struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
@@ -1182,10 +1199,25 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.pages_addr = pages_addr;
+	params.hmm_range = hmm_range;
+	params.eviction_lock = eviction_lock;
+	params.gpusvm_range = gpusvm_range;
+	params.override_pte = allow_override && adev->gmc.override_pte;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
+
+	/* Enter noreclaim before allocating the small tlb_cb. */
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error_critical;
+
 	tlb_cb = kmalloc_obj(*tlb_cb);
 	if (!tlb_cb) {
-		drm_dev_exit(idx);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto error_critical;
 	}
 
 	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
@@ -1199,18 +1231,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 */
 	flush_tlb |= amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0);
 
-	memset(&params, 0, sizeof(params));
-	params.adev = adev;
-	params.vm = vm;
-	params.pages_addr = pages_addr;
-	params.hmm_range = hmm_range;
 	params.needs_flush = flush_tlb;
-	params.override_pte = allow_override && adev->gmc.override_pte;
-	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
-
-	r = amdgpu_vm_begin_critical(&params);
-	if (r)
-		goto error_free;
 
 	if (!dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
@@ -1294,6 +1315,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
+error_critical:
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -1308,6 +1330,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @sync: fences we need to sync to
  * @start: start of unmapped range
  * @last: last unmapped entry
+ * @eviction_lock: optional caller-held eviction lock
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last with a fixed flags
@@ -1320,6 +1343,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  bool unlocked, struct amdgpu_sync *sync,
 			  uint64_t start, uint64_t last,
+			  struct rw_semaphore *eviction_lock,
 			  struct dma_fence **fence)
 {
 	struct amdgpu_vm_manager *vm_mgr = &adev->vm_manager;
@@ -1331,22 +1355,24 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
-	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
-	if (!tlb_cb) {
-		drm_dev_exit(idx);
-		return -ENOMEM;
-	}
-
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
 	params.needs_flush = true;
 	params.unlocked = unlocked;
+	params.eviction_lock = eviction_lock;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
+	/* Enter noreclaim before allocating the small tlb_cb. */
 	r = amdgpu_vm_begin_critical(&params);
 	if (r)
-		goto error_end_critical;
+		goto error_critical;
+
+	tlb_cb = kmalloc_obj(*tlb_cb);
+	if (!tlb_cb) {
+		r = -ENOMEM;
+		goto error_critical;
+	}
 
 	r = vm->update_funcs->prepare(&params, sync,
 				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
@@ -1368,8 +1394,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
-
-error_end_critical:
+error_critical:
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -1509,7 +1534,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 					mapping->start, mapping->last,
 					update_flags, mapping->offset,
 					vram_base, mem, pages_addr, NULL,
-					last_update);
+					NULL, NULL, last_update);
 		if (r)
 			goto error_free;
 	}
@@ -1717,7 +1742,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		list_del(&mapping->list);
 
 		r = amdgpu_vm_unmap_range(adev, vm, false, &sync,
-					  mapping->start, mapping->last, &f);
+					  mapping->start, mapping->last,
+					  NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2951,7 +2977,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_svm_close(vm);
 	amdgpu_svm_fini(vm);
-
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 05e332c1e01f6..f0d9025f6ef72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -39,6 +39,7 @@
 #include "amdgpu_ttm.h"
 
 struct drm_exec;
+struct drm_gpusvm_range;
 
 struct amdgpu_bo_va;
 struct amdgpu_job;
@@ -289,7 +290,7 @@ struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
 
-	/* SVM can replace this pointer with its notifier lock. */
+	/* SVM uses gpusvm.notifier_lock, other VMs use default_eviction_lock. */
 	struct rw_semaphore	default_eviction_lock;
 	struct rw_semaphore	*eviction_lock;
 	bool			evicting;
@@ -461,7 +462,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       void *param);
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		     bool *need_pipe_sync, bool *emit_gds_needed);
-int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			  struct rw_semaphore *eviction_lock);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm,
 			  struct dma_fence **fence);
@@ -481,10 +483,13 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			uint64_t vram_base, struct ttm_resource *res,
 			dma_addr_t *pages_addr,
 			struct amdgpu_hmm_range *hmm_range,
+			struct rw_semaphore *eviction_lock,
+			struct drm_gpusvm_range *gpusvm_range,
 			struct dma_fence **fence);
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  bool unlocked, struct amdgpu_sync *sync,
 			  uint64_t start, uint64_t last,
+			  struct rw_semaphore *eviction_lock,
 			  struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 920d0b3935807..2344a56169558 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -24,9 +24,11 @@
 #ifndef __AMDGPU_VM_INTERNAL_H__
 #define __AMDGPU_VM_INTERNAL_H__
 
+#include <drm/drm_gpusvm.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include "amdgpu_hmm.h"
+#include "amdgpu_svm_range.h"
 #include "amdgpu_vm.h"
 
 struct amdgpu_device;
@@ -80,6 +82,12 @@ struct amdgpu_vm_update_params {
 	 */
 	struct amdgpu_hmm_range *hmm_range;
 
+	/** @eviction_lock: Optional caller-held eviction lock. */
+	struct rw_semaphore *eviction_lock;
+
+	/** @gpusvm_range: Optional SVM range to revalidate after taking the lock. */
+	struct drm_gpusvm_range *gpusvm_range;
+
 	/**
 	 * @job: job to used for hw submission
 	 */
@@ -152,6 +160,7 @@ void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
  *
  * Serialize all updates, check parameters and make sure that memory allocations
  * don't enter the reclaim path so that we don't deadlock with MMU notifiers.
+ * A non-NULL eviction_lock means the caller already holds the selected lock.
  *
  * Returns:
  *
@@ -161,7 +170,9 @@ void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
 static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 {
 	/* Use the write lock to serialize updates when the root BO is unlocked. */
-	if (p->unlocked)
+	if (p->eviction_lock)
+		lockdep_assert_held(p->eviction_lock);
+	else if (p->unlocked)
 		down_write(p->vm->eviction_lock);
 	else
 		down_read(p->vm->eviction_lock);
@@ -171,6 +182,10 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 		return -EBUSY;
 	if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
 		return -EAGAIN;
+	if (IS_ENABLED(CONFIG_DRM_AMDGPU_SVM) && p->gpusvm_range &&
+	    !amdgpu_svm_range_pages_valid(to_amdgpu_svm(p->gpusvm_range->gpusvm),
+					 to_amdgpu_svm_range(p->gpusvm_range)))
+		return -EAGAIN;
 	return 0;
 }
 
@@ -178,15 +193,17 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
  * amdgpu_vm_end_critical - end the critical section of the update
  * @p: The update parameters
  *
- * Restore the GFP flags and drop the lock.
+ * Restore the GFP flags.
  */
 static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
 {
 	memalloc_noreclaim_restore(p->saved_flags);
-	if (p->unlocked)
-		up_write(p->vm->eviction_lock);
-	else
-		up_read(p->vm->eviction_lock);
+	if (!p->eviction_lock) {
+		if (p->unlocked)
+			up_write(p->vm->eviction_lock);
+		else
+			up_read(p->vm->eviction_lock);
+	}
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 8c941476495db..57ea3eb17e31a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -505,6 +505,23 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return 0;
 }
 
+static void amdgpu_vm_update_unlock(struct amdgpu_vm_update_params *p)
+{
+	amdgpu_vm_end_critical(p);
+	if (p->eviction_lock) {
+		lockdep_assert_held_read(p->eviction_lock);
+		up_read(p->eviction_lock);
+	}
+}
+
+static int amdgpu_vm_update_relock(struct amdgpu_vm_update_params *p)
+{
+	if (p->eviction_lock)
+		down_read(p->eviction_lock);
+
+	return amdgpu_vm_begin_critical(p);
+}
+
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
@@ -528,14 +545,19 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	if (entry->bo)
 		return 0;
 
-	amdgpu_vm_end_critical(p);
+	amdgpu_vm_update_unlock(p);
 	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level,
 				&pt, p->vm->root.bo->xcp_id);
-	r2 = amdgpu_vm_begin_critical(p);
+	r2 = amdgpu_vm_update_relock(p);
 	if (r)
 		return r;
-	if (r2)
-		goto error_free_pt;
+	pt_bo = &pt->bo;
+	if (r2) {
+		amdgpu_vm_update_unlock(p);
+		amdgpu_bo_unref(&pt_bo);
+		(void)amdgpu_vm_update_relock(p);
+		return r2;
+	}
 
 	pt_bo = &pt->bo;
 	if (r2) {
@@ -557,7 +579,6 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 error_unpin:
 	if (p->vm->is_npa)
 		amdgpu_bo_unpin(pt_bo);
-error_free_pt:
 	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0d419268d8adf..343d405eb11c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1438,7 +1438,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		gpu_start, gpu_end);
 
 	ret = amdgpu_vm_unmap_range(adev, vm, true, NULL, gpu_start, gpu_end,
-				   fence);
+				   NULL, fence);
 	/* EBUSY here means "vm not ready for updates because it in the process of evicting."
 	 * If that is true, it's safe to not update the range now since the vm is not in use.
 	 */
@@ -1557,7 +1557,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					gpu_start, gpu_end, pte_flags,
 					(last_start - prange->start) << PAGE_SHIFT,
 					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					NULL, dma_addr, hmm_range, &vm->last_update);
+					NULL, dma_addr, hmm_range,
+					NULL, NULL, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
@@ -1569,7 +1570,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		last_start = prange->start + i + 1;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		pr_debug("failed %d to update directories 0x%lx\n", r,
 			 prange->start);
-- 
2.53.0

