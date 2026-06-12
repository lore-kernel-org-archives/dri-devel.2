Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF2ACD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C0810E9A6;
	Fri, 12 Jun 2026 09:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qK7HeU8Y";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E22E10E9A6;
 Fri, 12 Jun 2026 09:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ6gkcL0zJBLGywvWD87A4cIiLaIViXQnNYPTizZOQZnw5DsMcUXoW2vO6Uot2lzDDlhEyR2lLOTkpfFE4nyvHTNxZku6lNGMezcz44UonqZ40TJrW3nxjvkl5bjQ2jdOm7G4TiQvkVqxFBXuwkHR6eA7s2yo0ktHJAHACiYS7VnF5TceWMOyHLhE3mnVIqxa1twJk42ZB9R18pnSZkPVrXWvTw6oaqwgq5omJbCzkre1Glm9rd9JBHc+84jC5Eof5XbxXbjr78tOWVQ0xiloxEE2B7fGvcS0lE+OzzVn2SvDTuz26HLvN/A68gfH57cXu+u3Sjb72KymFyr+yaeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRjpj0ZHISsVYFvjs4isFGL6HfLQOHuiz2dUmftdrdg=;
 b=vLD5wLDn5F7oRfVdr4HDTWx9vcBWmRHLKCKY7kSLxe9uMi54xQoNKMwKCU4BshB5OQRy4DfI7/serm/cOd7MTgkoxIOMzEnYFeJ/kK3jc3+4EOoKTfiRsNXc286GFSoMwcdyWK4b8u67pgiKOK/pagvj4jlWKVBzaPj1wZmyb2exMeW5awCHDr4vMetaOq0VXccf1RXYXV5LrMo2sBqwC0z1XJduLzS3p1ofLfPXLE0GwYxqhXQA1k6fW4d0Jl2y3DlUeqYpNmFZthIYo07YuZVxYxeaxY/v++g7MHIrTH5Wxf8X0LxGyx5HGTzsEqfWPji6GF5UV4YVnnsfSuXyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRjpj0ZHISsVYFvjs4isFGL6HfLQOHuiz2dUmftdrdg=;
 b=qK7HeU8Yv5tFTkdo8Q7SGBmGzclvMfdeIlIrj8nk3v3fs3sTN8qN3NQamy62lvPU/8AfeoR5vv8qA95IaLvfS/hvTweLXtzJKYVYvarCQmKyDzVvFLaEKgfo603f4NB+/hgQbA33H8fdJTzyASrCUbCSjwa8vnGy55GIAgOshxA=
Received: from CH0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:610:11a::11)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:10:45 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::4c) by CH0PR03CA0360.outlook.office365.com
 (2603:10b6:610:11a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 09:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:10:44 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:10:39 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 09/18] drm/amdgpu: add SVM notifier invalidate callback and
 checkpoint
Date: Fri, 12 Jun 2026 17:09:11 +0800
Message-ID: <20260612090928.29682-10-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612090928.29682-1-ray.huang@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f5e84c-3133-4236-498b-08dec8627c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|22082099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: U2UA2kf/9n03HKv0Mq0/9Iu63HBzx8qgHcKaJh7021wOpXdfjrHZ7np+1Sx07PMtiMzN9IdYM4t5oRNw6eBttt8ERK4VqgU0807P+SW46ELDICHabdQ6U7bXAHj1LmuAoycY8Es2bY6mzgW8woc8kp+gFJn5TwLgHifz60jykoBapGCvoPTfgKJyA8PlK7uZPj2ch8Sg2JY71ujdK+Sf38LKh0SqfHzuaVfUyTpvrqNRqlI+5J8vi9VFi+6CVTvydBMYz/KhzdSV+cGuKYBh8Cm+SebZZ/bN2ARgzsb0CXsvmLTrMvaoC1XnYxwbLhKLxJO1tYVY2sn9K4pbCpuhoXmLAQ3A5HtwONWorKFB/DzTaGfXWBvRsCpLrPDMDvr6MpwiivWPNq6HfZNw+fY8fuSu3Q14f9/j8bTP0hBnYm1yOKXxvVihHoZuQBQkPCrOUFTnDxDoniYaRj3ytZFJgRUEQoqvwpJXHv/IdpHqZMA1kGRk/yK1ddCnLSHpSZP+D1LgSIDjZe9g6IFbsARSZ3XWeRcEQNyd+Qf5KI1bMUTw4Ng1CyO3VhbmkbCDAkN7TkSaGJWSAywC+joNzH3oIjwajzbsaDYkHapyO5+/LR1pWfa/xpRSZ72edZvgH2DvFtPkGk9od8lSok1DCPmoge77bGgsMlaXSUW6owrioZwgQmm5wqlbFrbcTuGSQh1FtDjGNVRlhvARMqAa3pX90ZV+YrUYjyfMWTERu1vVIHUs7tTVCCD3pfepxeAzJSp35sxM/O+/J4X/jv9CLJNoKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(921020)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l7k55fQaqi67/wjSXHZ1d5/HiB9CY6N8Tdi38iCZYMhu5oYkoA+Z0U0D+SvTBW8rYx33eEg/O+OWot6a8oKstNZuistiSNzUmSYIemqtU9oxkEcTQFtgjkNXHs0ycIt51NetKty6LZpYFeDvPfEYCBtIHUAZ0/liz3p576ANC0Aij+EjPJ8LMDzRuivOpJgrmvzQBfUgYdK1BN95r5YiWKekinRotxAKkEI70yHTg2FiMYDewuPL2CHGl2N2dgUgvqE/jqMs5w2N/l7IdQ3GZEgv8ImXJnkeA1h6H/PPChFEfl4AjHaxmXSzPah6/hWwRymT+BNq3Re9OqUSAX44lsSgUWSiXt+nwgSGEacybv7bOa/cZqIW0pgiACCn38wCQ+2483PSd3EJ4p0EyeiPnvrw6ICPkv2znF7VNd9ewf/6xkz0rDSgcj9peS0urWN1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:10:44.8700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f5e84c-3133-4236-498b-08dec8627c34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237
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

Add invalidate_ranges callback and checkpoint timestamp:
- amdgpu_svm_capture_checkpoint_ts: capture interrupt handler write
  pointer timestamp for stale retry fault filtering
- amdgpu_svm_range_invalidate: invalidate_ranges callback dispatching
  per range notifier begin/end with TLB flush batching, checkpoint
  timestamp capture on MMU_NOTIFY_UNMAP events

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 57bcbaf0fdd2b..6ac785a3b5cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -741,3 +741,52 @@ void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm,
 	if (put)
 		drm_gpusvm_range_put(&range->base);
 }
+
+void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm)
+{
+	struct amdgpu_device *adev = svm->adev;
+	struct amdgpu_ih_ring *ih;
+	uint32_t checkpoint_wptr;
+
+	if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
+		ih = &adev->irq.ih1;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			WRITE_ONCE(svm->checkpoint_ts,
+				   amdgpu_ih_decode_iv_ts(adev, ih,
+							  checkpoint_wptr, -1));
+			return;
+		}
+	}
+
+	ih = &adev->irq.ih_soft;
+	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+	if (ih->rptr != checkpoint_wptr)
+		WRITE_ONCE(svm->checkpoint_ts,
+			   amdgpu_ih_decode_iv_ts(adev, ih,
+						  checkpoint_wptr, -1));
+}
+
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range,
+				 struct drm_gpusvm_range *first,
+				 uint64_t adj_start, uint64_t adj_end)
+{
+	struct drm_gpusvm_range *r;
+	bool needs_flush = false;
+
+	if (mmu_range->event == MMU_NOTIFY_UNMAP)
+		amdgpu_svm_capture_checkpoint_ts(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r,
+								     mmu_range);
+	if (needs_flush)
+		svm->flush_tlb(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		amdgpu_svm_range_notifier_event_end(svm, r, mmu_range);
+}
-- 
2.53.0

