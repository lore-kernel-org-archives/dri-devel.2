Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0019C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 22:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBB910E0E9;
	Thu,  9 Jul 2026 22:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="njWfmEfS";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500B810E0E9;
 Thu,  9 Jul 2026 22:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZXPNmYD5XW8e7O8pomGSBRNzIe6PF4+6UcdZ67C97OC3ibjso9A1CXG3Y9LB0RLZl3/5cuK1Zylj61FDlmEmyhrJjXsxBkgxwT/PoOi61NwywhOAuohvLsPlQpyU96bohJ69jYQ3MVwYCH+MuOc7MQ6IF4i3WjOzkdXyGrRnWruhBMi3WwnCrfSkN1pxIQviSw4Nvlj2iNVfiwa9CSY2KXj+iV1uTQq8V75L82aIcefnluUHmyNe/s6qp2PaC1nVbdg3OzrhjNQPg2KHzmlk3SCXYKqXY5IYsGlXJINOVscUx0+CfYOAsGfPutkumUL0BBYe0ylCHpR4IOBHBNqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+95dXxt9DrH6+PFMz29917tTnzcnkYlMZ+JrXzdAsns=;
 b=B/T3uD21VhXrN3tovX2E0q+Di95plqQxQT7Dd9nckDZ6mW04k8zc3T9GNhPJcDaAE7RFO9t7pm1GqeYWV181BLp1XB+AyGZTDAO6DI7vo6pglQBzi5IcMXtYeB0PoLutsCVEKMJPDah5L3olFtJkaQU6JJycwOJp8YP3NFtyfjlg5Y30trSHQIABfmirayV2UUGkrHlgBy8eK5xKICMkpdfGCOUHdWmo6W2WfbcxKH4QPHq8JRysRO5ljx2LKf1NCYRunu2Ry/UeFQbUMsJAE6QZRGwkuycQxvLqwsWwKjBkwJm+/7+LkeXxpuS0Evyy1PU1dodi4zmnN2PFKpBx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+95dXxt9DrH6+PFMz29917tTnzcnkYlMZ+JrXzdAsns=;
 b=njWfmEfSyyEyiiq11MBGRQUXPwBEr+nHgl/RBCLN7AjRo0zkz7uozRIvXLJvm1jHXzYsbpoleLUb/Exs+k9xy7n9I+wM3Lz62EJyKdtxL7eZw5QitECKfa4dtgTpyMN7aMaoCnsu85+EO4nypc4WygNvcD5Tr9MaG10u2gxEj1M=
Received: from BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23)
 by CH1PPF93AB4E694.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 22:42:55 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::32) by BN8PR04CA0049.outlook.office365.com
 (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 22:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 22:42:55 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 17:42:53 -0500
From: Alex Hung <alex.hung@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <YiPeng.Chai@amd.com>, <Hawking.Zhang@amd.com>, <yunru.pan@amd.com>,
 <lijo.lazar@amd.com>, <chongli2@amd.com>, <xiang.liu@amd.com>,
 <harry.wentland@amd.com>, <alex.hung@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix __rcu fence pointer accesses
Date: Thu, 9 Jul 2026 16:33:11 -0600
Message-ID: <20260709223312.475563-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|CH1PPF93AB4E694:EE_
X-MS-Office365-Filtering-Correlation-Id: 347ebc9c-50d4-45a7-2918-08dede0b6acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|56012099006|6133799003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: iOeMJYUgXoOFA8XWQkSmZEF5ZwtbI88mMDzUL2SI34d7LYW2BB16DzfPQ5uTrPcksMEnNbIjwQ21IqdcjByEYP65X+ewYflUXZGzl+SX01oR6AblfYokMae+jQ2Kc2eBI7lZtz+I+7uFoPkZ56DyAsd/gOEq792AQeRMz7NOkyQtNK25tZr9QaFoD9buC2wftkDSPCSfCYULuoeQWzRLMpaWiXYP+yct0R78M89Bx7UlCNquPRQeb3nl5F5px6b5QEVuhP5Y8nvc1hZV/MvhMgo6mKTmjvdGh/C2pjAonJw1bhfyLCdWabEwz64YxzG94AdSHhuKlBu3p07dnpCol2o5iGfSer7bkO3o69XLYF4gpFFEXfVuKDp2RBpxt8uyK/QnyQzu54NtSXVaYN7Av3btaxJ1YdI16IEp5KuXyYRgg+JVcR1wC6HzoirG7AgHJ8NfeU3c2UA+nubqIctqrB6Ejc4IebWWSbxMrb5G7epXE6CUr71SgPChBG6YxX9Zbd8xL38EDDFJpmKFSg2Wl5OHmVWYit+P9KXtNdzhtwFV+nRjkJBmkAK7etDiT91QkfCU0hRaTRvTBi/hNEkZqup7RtrUcrmZWkurn5RLtoZJa9hHUIXnq7q2PmzxZGh/F1VciK0GCkBfKRzkyQBrF9B6+ojkp9Yf1+/eTe+cgtsvMWXY+Qc4I9YoXuiDqG9wOlrU43ojNUud2K1VxSMAl+i7q54vfRI28cZMZc6clOKZCryDT+DkXQByzkLWS6XZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(56012099006)(6133799003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EiArUl2Y3RmDTGt0U4FWP5ZwI1ztZ9Q1GUnK7/ckKOmPFliNEDgvK4dijv51q9AOo7nRkFjJAo/CbrPnB2RM90nilQFnAh+W8LMGGXlBu1CT3UB54xDeiY+UPFkWR1oA2gX4ASJr6e9JqNTkPzZL+rvekSH+c8geUZ+KDEvWS0aY37arV77Z2cZ89Uuke7iuJ2nUJ89gw/3ICQ8mDpfB5elGW/qgOX9Er3fPyF+kJOUoxnyi6VNRnvFNizIaBC4o98cQbfUZM/zSX92+kHkoVKrjtC2ZvIU7dUD2NMN0ecCVANguIwVLTIuLbUlNY5sBJAmjg9tKwrh1Qw1egRqo10XS1vEMT8s6oyVTG5ha/xUpgr6AWVk5dXHlbqOR+SxHJzEZVQkglv4vroQezgKmWX7w03ZdQkTO0XxmL72ztpAk4NqNVs9i1CCaJUyNkfs4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 22:42:55.0733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347ebc9c-50d4-45a7-2918-08dede0b6acf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694
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

Building for ARCH=um with W=1 C=1 makes sparse report "incompatible
types in comparison expression (different address spaces)" warnings in
the KFD code, exposed after UML builds were enabled:

- amdgpu_amdkfd_fence.c compares the __rcu-annotated dma_fence.ops
  pointer directly in to_amdgpu_amdkfd_fence().
- amdgpu_amdkfd_gpuvm.c compares the __rcu eviction fence pointer
  directly in amdgpu_amdkfd_gpuvm_restore_process_bos().

Fixes: af3f2f5db265 ("drm/amdgpu: Remove UML build exclusion from Kconfig")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607091659.SHEscT0c-lkp@intel.com/
Cc: Harry Wentland <harry.wentland@amd.com>
Assisted-by: Copilot:Claude-Opus-4.8
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 6a364357522b..b0299d861903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -92,7 +92,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 		return NULL;

 	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
-	if (f->ops == &amdkfd_fence_ops)
+	if (rcu_access_pointer(f->ops) == &amdkfd_fence_ops)
 		return fence;

 	return NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 35fe2c974699..f0f516a79424 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -3096,7 +3096,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 		process_info->eviction_fence = new_fence;
 		replace_eviction_fence(ef, dma_fence_get(&new_fence->base));
 	} else {
-		WARN_ONCE(*ef != &process_info->eviction_fence->base,
+		WARN_ONCE(rcu_access_pointer(*ef) != &process_info->eviction_fence->base,
 			  "KFD eviction fence doesn't match KGD process_info");
 	}

--
2.43.0

