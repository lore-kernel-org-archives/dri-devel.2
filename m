Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8B7C43602
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 06:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B947210E582;
	Sun, 28 Jun 2026 06:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZ2LP7SU";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B0C10E582;
 Sun, 28 Jun 2026 06:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe6cxi7IyjUhtZ/pKWRf8MFIkSu3fMicG1glLLd/BxKN2BilocExaHcTtgvT7kHOVF4SZvraHbbFzPH0gkSfvGjxgRO8QOv58rLrglWJO5aijzvCCyEQ6JrVLOOXwOseyE7mhAqoeDaGq78bhv6a5vcEDY7VORERmsVrDooOMmv3fHkVWp8XYxjhBSnkv61u5Bc6iM9SdRWboRoVser2cIuqqniZ6vH1DbZgZSGfyJhu1dhhnk30yufvjyf/CH1UpJKNlVCFo6oZ6aiTJulDAgTr+LalcYJ9rsOgwBEdtR1qiLLncb+oRoM3MqbXBbaeK1V0egXPQDMdJjeC3yfgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBLYkBzH4rLIANyBxYFz1oAoZdII400u3aynoVMisV4=;
 b=lXrkrpeMJHpBh7V0ZMmxaxNlaJTqH/ZQ+7t/bs0g3aKYT0jIrYyxBIXiZ9PoKXsffZLzMN2fvSCEw/klrcfNM0IhWi2lv27hr6OERcW4SrhxEh0rHVFmMSxxhxQtXnlDzRZj0O6YymVAHWonRKgjTTCzc2zOP38RPqSNOjbIEX8du6GI0ALCEpwgEtxznk7zM+vXYdu2LApqDKChdE9gp1Ya+lAb8lRnMyEJ/YszAygwnunwOl9TYxhzY78BAnAwhR5Ku8wzbHHrVTzuBAZ0RbLYQ+NvJumynZXiFTQGWPJ0L//lyMrHRM39/48DQAIKoW3KLchr2/U/6Z2ApcrhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBLYkBzH4rLIANyBxYFz1oAoZdII400u3aynoVMisV4=;
 b=VZ2LP7SUYfDxPRrcbGReuJyn9jG2/EAR5OzIsoElYiGPNNBMOUTnA4oHFPz7+XytxtwasPKlxnFkaMtWv/WjjtMhzjbL6w1UODNmwxU5gm8SsHC84c/KAJ/qp6oTEyWsFNgTUqyinmnl159bS5EPQcgIyGu+Mu/aTdK+Ou8Y9g4=
Received: from CH5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:1f4::9)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 06:18:26 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::3f) by CH5PR04CA0024.outlook.office365.com
 (2603:10b6:610:1f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 06:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 06:18:26 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 01:18:23 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 1/3] drm/gpusvm: free the whole IOVA reservation on unmap
Date: Sun, 28 Jun 2026 14:17:55 +0800
Message-ID: <20260628061757.4093701-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260628061757.4093701-1-honglei1.huang@amd.com>
References: <20260628061757.4093701-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 7028fa4c-8d9c-491c-6804-08ded4dd107b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: V1/GvddoqiOOAJZbGXFGyoJRmYyi9OHWax8o2hXJ6aRvUIaTDWC7ktttTUsmwD2hW36eWZC8Ej0GKr6r4OSvDeW0Zmx6b1ndOZU66EoQn9NPKOFDPe46iCrWpDJdhGaYMuAgIptz3ygtIrcbqA/neofKNQ5qtIeE0Pnf+EDADMOmeEimrQJ8Y6Busm3YzRo/uFbvXVf+BP69n1OkAeO7Yk1NCtrNL3cFVxZmB0GxilH8lO+Sk8AhrMAPkTEASc0F0TIGTwBh59HWuIRnkwBbuM+AaRGcJXNKc9QUhbN+mLHE0SAc1Oe4YAkvQrAgyTzU2a0UOc8RBdc1oh4RtZW3gVL8u1GLcV52wTOUsBxttNeP1JtYJbql70Y7MlXDN5zkHuT0CeyQ/ChhCoV7uwHdZbb0iHdymP5SSOUwgdAkUN1isGXgCG9OcCboNMdmcaqdNhCPglqQXsgcpHRXUKEqFZ/+ANOeqBZ0LeSdlUkuRL/LGvDIodx/tIfylQ3c9eReLPNDzmiUxbjAWwZq8ZIP32gP5hGXJSPuiSe+pCNXoa+8bVtxfmIAb7v27wCR3EcTc222CkDEL8qgp61DsOzjNQhrIzxieE/ggyvzGkfGRObPt7vXwFy+D57qLRogdq3ISXbjrXeU2BtxCKvrh/K6gkyRDNlY5w/+cSQ53OX34aLeO3rDPqFWaBhUlqZlsat/EhGeXGqDZO19lxRFs+aYbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oTnwhf0Wt7n1cZDD/0Pn/EYSJ7kIUlcUK1G6X60Olv/P2CmRIzmyfBSeLffLeSyTizT2xRXP/lqcCV4uldNN8qZbwYyLlQ5Sl5DW84t331eikrY8NhgMDdAh8Z9vq+Tzv9ZrietZFTQVgLyPu4K2+imjDnDEzWB+RWQJ4SQKbxzliRqc95qufDssrsSzILw9D5QT/tPlJd8e0FEE/nn9HPiOoS/KfIiBLXLKnxh7oORA+pHYlfapFgv8hzQbl5upoDlU8e9LAGoLnzymFDOtcEK5RSBpzDs3TZYFp0J4bxmOSjCRt7aJ8M5uXIOnc8RmvpKzm4MW8g/M12TZ/Px6giJou36NDpXNs1Ogu5Y8CLhkfvns1IcwyXapgVD2YhhexG07BHQTzezGXB8zUoJRdfSrd0nq3BCZYxZNeZYKmp/whedkQMYt6/P1kTL8wKV4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 06:18:26.1784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7028fa4c-8d9c-491c-6804-08ded4dd107b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
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

dma_iova_try_alloc() reserves IOVA for the entire range, but in a mixed
range only the system pages are linked (their total size is state_offset)
while device pages never touch the IOVA state. dma_iova_destroy() with
state_offset only frees the linked part, permanently leaking the IOVA
reserved for the device pages and eventually exhausting the IOVA space.

Unlink the linked system-page portion and free the whole reserved IOVA
instead. On the get_pages() error path state_offset is 0 (no page linked,
dma_addr[0] unpopulated), so skip the unlink and just free the reservation;
this also avoids reading the uninitialized dma_addr[0].dir there.

Allocate the dma_addr array with the zeroing kvzalloc_objs() so every entry
has a well-defined value.

Reported-by: Sashiko AI review
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 958cb605aed..3145d55cd86 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1146,10 +1146,19 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 		};
 		bool use_iova = dma_use_iova(&svm_pages->state);
 
-		if (use_iova)
-			dma_iova_destroy(dev, &svm_pages->state,
-					 svm_pages->state_offset,
-					 svm_pages->dma_addr[0].dir, 0);
+		/*
+		 * IOVA is reserved for the whole range but only the linked
+		 * system pages (state_offset bytes) need unlinking; free the
+		 * entire reservation to avoid leaking the device-page part.
+		 * On the error path state_offset is 0, so just free it.
+		 */
+		if (use_iova) {
+			if (svm_pages->state_offset)
+				dma_iova_unlink(dev, &svm_pages->state, 0,
+						svm_pages->state_offset,
+						svm_pages->dma_addr[0].dir, 0);
+			dma_iova_free(dev, &svm_pages->state);
+		}
 
 		for (i = 0, j = 0; i < npages; j++) {
 			struct drm_pagemap_addr *addr = &svm_pages->dma_addr[j];
@@ -1486,7 +1495,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		/* Unlock and restart mapping to allocate memory. */
 		drm_gpusvm_notifier_unlock(gpusvm);
 		svm_pages->dma_addr =
-			kvmalloc_objs(*svm_pages->dma_addr, npages);
+			kvzalloc_objs(*svm_pages->dma_addr, npages);
 		if (!svm_pages->dma_addr) {
 			err = -ENOMEM;
 			goto err_free;
-- 
2.34.1

