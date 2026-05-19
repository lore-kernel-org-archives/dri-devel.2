Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F6FCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F031C10EBB0;
	Tue, 19 May 2026 09:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DLQcymtc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E80910EB9D;
 Tue, 19 May 2026 09:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJHCQLcY4YorPxDdGEvt0f35v0RrY0zTMsfEL+3P6cRA3w5GLHfptiCmP00EiH1GQVxgUYTrj42j/pFk0Je0gh+yvgVIXUF2RaaLBKE9dIEnmFpLNkkGZik1++Prp+DcOwv7cd+WHUzYD1lmXSRmnymhSyAxZHZQSz/lauropPWh2Jm9qXVF2mo1NywlYlsWUIuW1LI6Z5a1WmGBtU3CtyA3eU/JNisVmdRhYvJ+MKNcNzInusKGzSTXmaJvAWPfd+51Y4Mh47W/FO96/hLWzuTXB/XPEEjpmW01QSzVsH6JOxraNfPdpDq2cSkBfep0qgd4N7vtOObTdCj3q+3SJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgdHiSzfsnrW6o1Yn/asSQHSIi+qV7rvoUiKDeDwg+4=;
 b=FqCO4is3zAtjfWMBTFiQqFmpyyW7vKqZpy16UJ2F91KsU+xQunKcFXHhkePb6sWDM7ND7RTXP0amsPGtCweu8m8F2a/CMiuC3lcsLIY1jkgT63NLiX+D7u7SVkSRmKJGkyCtQ8H2p9goFd60jnJD6lQdypXxIVlO0WKLppqJ7mIoAklnNHOprG58u2ZQpokttTqmo30KQY65p/0l7jLlWvRe10Wy0Ht9HfmgAIi3+ewtOzjPkomuEMdEZk8od6m43fSbrEsSEn/fu8nHnh+JL1H2CV8nok3Rygx5PAhNK2M3yORNSQ/DIzJe7wXnilbeH/ZajTPy9GMgIrwOSFWsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgdHiSzfsnrW6o1Yn/asSQHSIi+qV7rvoUiKDeDwg+4=;
 b=DLQcymtccWzysFWMwzfq7LqN6vYlFC9+Nmuz9rNsQj5tErOJEfq8knFJ1/gUJfrWWK1ZixNDuo5XIebdyt0PRcQ+Fd7vyBjWlDt/ubQDlvNRFRMXlNY/mU8QU6zVcwq5G6v+YW4L5aJJPJwRe1pqrsZJFsvgMN9WHxQc47erLJw=
Received: from DM6PR06CA0084.namprd06.prod.outlook.com (2603:10b6:5:336::17)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 09:23:41 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::f8) by DM6PR06CA0084.outlook.office365.com
 (2603:10b6:5:336::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 09:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:23:41 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:23:36 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 2/8] drm/amdgpu: integrate xnack-off restore types into core
 headers
Date: Tue, 19 May 2026 17:23:07 +0800
Message-ID: <20260519092313.3115848-3-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a13fd5-ba46-407e-bb5f-08deb58850ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|921020|22082099003|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2C2vQnu4Z34bgtMiD77xjMoTXO05hfWVWMle2V2vEAIAL8g15G2+YzzVrC/aa9mislG7bnIIBZJPFd7qm8R8NXVY8SLCdYJ48XsSLbFG03lnqwfa5metfDnO21ltkjqykhO5OaCPM79hnouWBKdI5N5uncE+FLgdzp6RU3NHzCDtsXFWxe7DCGU2zb/DAaEKN6fyuq/oYaV8BbMUMtI/OYXcN19mpOwexa3zxj92XkkXgcjyzB2sRraC6ykMBBcTeOp6KpJnanF7IQiBKNcuzk89cI5EJgbituVEP7taJEnZsIv4w6iMKAOl8peMuaS+K6nI3lOeb3VpIWJAUGYTXxx4LkEAecfscF3/0O8BWqGtPqYnZnuHp3+INf9K5PtY2nErYo1lNq6IbvlxyEi7mu2QxgVsphpcLSb80bNu6mWp9wEtTZ4pxKs3WP8m+dy9xSAmnE23rgikKgm47mHeX7qOusugGKPHpY2lEHhJEpNZMg2q9hlEIqjZFkp0wPmOWOHZKgYADiAl7e2gGNyl9j6sLnH/2KnRJ0ek8HYs7MY5BSROJbyMGuI8I8nNEGcJnfSR40Lr8rAhMoWbZdT8lUlcU7KV+lPwtijdDREBCxK3ING2IBcC3w+PlTksv7kR0UKs8qPpcFD+YcqJXWy7Li+tJnoUrCnDPZG9gI2ZDIBO7EXvBTQUfAPo7wbXeHa7UWHeqvRF/2nYqblQSXqhnm1UZkvsmnPNd/EgIdjE+gqUVmXHABdn0u7pjGY6Is0BfSNjsVvM7X5IZc5dxUqaKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(22082099003)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qxjSel74+vF00f9PJJyJJ69mbHn10KBThVJMJEMLc2SKQJJGd+SjT+XV346rIU071c5oBe8pfn/GYnzt5CM0t3+BPggF6zEsyxRufcfzgAOaOwq+bKo4ekyaTUCLEYWm1bbDTA/7iNz1L/bj4EPQNZQxmRXRHPsXLLUobqMPWVDZKPc/QKFOA2xmseXhrmP/AR0MpmL+dPCwtsBAGRbAxZV2s5nWa6MTwGdF3dCOO8d91Wy7yOcINq2mEKrZMrSDvs3Rk1ZXu017uvGr9wJ6BFjlnL904DO+/A9L4mVVe9kgYi2b0DBB5LbhcL5Lz2pOsjMCyoez8leMLQ/CyqnaS49LLUJ5Xmf9iJEJikFYCbNU5uEGMlV0Hu8+bvVZzdz+OVQelJ0VXRCn4j/zjbM0wLJI5RY33cJtxLMnaJpmqLXaR4LOAiSDC7tAyd4jBzNd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:23:41.1556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a13fd5-ba46-407e-bb5f-08deb58850ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
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

Wire the restore types into existing data structures:

amdgpu_svm.h:
- Include amdgpu_userptr.h, add restore field to struct amdgpu_svm

amdgpu_svm_range.h:
- AMDGPU_SVM_RANGE_OP_RESTORE = BIT(1) in range_op enum
- RESTORE_WORK() helper macro

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index b04ef1617..1ab9c84ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -38,6 +38,8 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include "amdgpu_userptr.h"
+
 struct amdgpu_device;
 struct amdgpu_vm;
 struct amdgpu_svm_attr_tree;
@@ -92,6 +94,7 @@ struct amdgpu_svm {
 	struct rw_semaphore svm_lock;
 	spinlock_t work_lock;
 	struct amdgpu_svm_gc gc;
+	struct amdgpu_svm_restore restore;
 	atomic_t exiting;
 	uint64_t checkpoint_ts;
 	u8 default_granularity;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index 82d4b353b..2d677f096 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -90,6 +90,7 @@ amdgpu_svm_range_invalidate_gpu_mapping(struct amdgpu_svm_range *range)
 enum amdgpu_svm_range_op {
 	AMDGPU_SVM_RANGE_OP_NONE    = 0,
 	AMDGPU_SVM_RANGE_OP_UNMAP   = BIT(0),
+	AMDGPU_SVM_RANGE_OP_RESTORE = BIT(1),
 };
 
 struct amdgpu_svm_range_op_ctx {
@@ -100,6 +101,7 @@ struct amdgpu_svm_range_op_ctx {
 };
 
 #define UNMAP_WORK(ops)		((ops) & AMDGPU_SVM_RANGE_OP_UNMAP)
+#define RESTORE_WORK(ops)	((ops) & AMDGPU_SVM_RANGE_OP_RESTORE)
 
 void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm);
 
-- 
2.34.1

