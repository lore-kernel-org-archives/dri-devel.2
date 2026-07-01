Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243CAC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4948D10E316;
	Wed,  1 Jul 2026 06:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="taoV2YB8";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5757510E2FF;
 Wed,  1 Jul 2026 06:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYVs9CDVjwLohGfduNOpSFpj+clh43F4EXdU8IrdAEoJcZGrOZaENpe/oS7LTbPydWSmTnCHtEjSXeC5DeR4ASNX033ciuJDIn+Zg4Yb5/P7GHYHGjZtHjzH2URHuzV0ph+BhdRb3YKwD70ZOl6tB3OT7SDB51d7MKdwLKdqw5+rUc3ObDNTZlCvII/41qBRln4qoGQs0lxuV+Q0pQFrs49ug2Jk3vLrRDNb9yzfaXRqeIVOB27T89zbP98G3aVC56ZBHF9NHdfY8VAkCzS1oTMT26OWwmaFSjFekKooQs+W9fBG6tM14XONhBBSOloYrgCfws5uQE9OUiidAfo8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsxQLgRMH6IW7B2u9jyhxICkSleEw85FXdhirVPGhhM=;
 b=cfI1+LXci5iqzQD8TogtHCG1fzt23MK6RugrvKmFLxKHtFkIA4SZFD1LumNEnvhQKvLPTyrUkwdhrd0AuoeIAIWD9zp9OqYip/ZbUgohjOfEB95XSqV/iJykkt/IRaVZm62Yt4h4AqEFJ3RuUS2krPpRMbL6LVRgRuRjOW0ISF9CDZS4j4AvdXj02IaClH7h8HaS4ZCmK8U+tilTUU4kFdEOiP+krTg+HZmuozKOnci15gS8PlU70AlT5guVxzpspXBJxvkV0VKhocoQMxpNccUS/BN1rO+DF1+yQUT57fSH0SyKCfvy+5bmIihp/usMIT8nFE9csf9G4Q875Mcduw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsxQLgRMH6IW7B2u9jyhxICkSleEw85FXdhirVPGhhM=;
 b=taoV2YB8zz95vw7ExCGmdUCJQT9OK5kzqp9tMCY9y3MqdxGPwKtfiRmUqXCEtkXKmw50WUEPpii0R8RsgB1Z33a3Msu3FH280d5EiedOVvrFvLqzK7WKa0AMB2HyN7gwE7SytK+sJ0yMbcbw68YYDXgVrt/3ZTCZmMo0YfqmtWU=
Received: from CH2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:610:4d::36)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:28:17 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::24) by CH2PR19CA0026.outlook.office365.com
 (2603:10b6:610:4d::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 06:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:28:16 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 01:28:14 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 1/3] drm/gpusvm: free the whole IOVA reservation on unmap
Date: Wed, 1 Jul 2026 14:27:58 +0800
Message-ID: <20260701062800.409248-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701062800.409248-1-honghuan@amd.com>
References: <20260701062800.409248-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7135e185-edc0-4151-2782-08ded739efc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: KbsXIZJ6YrJqlKWlXPtxSOZoMsJ4UP9a2RmAkmoGsDgR0qVd285P6KYTtFSb9d9cuvAWKQJetB81HitJpk30tAg15ZkOcYjpa0/tXCl+VXGf+Mwh5Ms2zQy+WaPO2dKsEV5Jbc/m2ijIqgZeluktqjJhIuYVjJtWfSC5at+ekd0HBPqTd9WMVes345/Fw1biUjV1bNt7otT4+0NJb78PuMRaheNthCmk9sEVE+IQMEft8aXFgjxKeQIRt4o6LncFa0n/L1v9LQLJll98XaGKSpKNsNdVjGX9yblbK6YqDAoWotFj0Rp8vIxAy1FPbhpPZYAxWxxjtoh/Mg+1OO6w5vsF8c0mhLg2Ko9c/jy+sopTi7K1fNpeFjty4dZKlc0l/K0SHcdE6HoqDxev4kElPnhBFWfuIAJnxEYwGpQAWG7iu531G6e5D+RIyyrB0MY3gwLDpqisA9U8/fCLGDQZOP57V4tO6eYAHCwyisxdIV13AGYjgQRVy2iZc6xy5xnTQFD6dAK07WhNTCKTH/KoYKvp8oG3wVA7loss3EGQv1eKAogXVoZQ6Wos4vB+1NLcJfzoZF4uSwP8sBwMZFVY4jqTEAuwAL2WOELxZpNlhE69OQ4djU2UoOCcw0hM8/okf0VKp5iUWCmjdX7E30GBAYQxqOEJbDW31rL5VQm3GprAbSkVJ3eVEFicph2Dh9Cg4vUuiNhVbaM9bWtSsCMvxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: urfgJ1RDZKsnr8v3l7gVq9sLjVL54TCWnZg8qplDHMmAqGPXlAHUXCEqvpGoZnjTPW8ysrfup98zJ9lqBRPs9av1+HJ/KvnWkw6AF3Nm2qAcd0A+cHwqt43SMNlw7pcd0ICah4oMLSQe5LH6N0SpfUdGkeNDTFhBsdiAKHsUA1WuOeV7erg8m7u7sZL0ACCnv32+U0exZeO1jVYr+MJyQA8kAkU41kKJf0aDessKW2dxGi7LCjXJv6ZN+51iWqL3Dk9Y8F3/UXcq0QVKGKI+Rh3BwvHQDW7p0JyEq8/RVV7scPBNac9w3iGYfaH1RPtmZqoUhBkXRm73afnMpLFUrUPY+ZbLfrhcLomT0rg4IVS2jXkl7LrohCEfIKzvQ1gp5PPz32r4qkQn7MkQM9Npc73jyP5JvVLbod8EeXk3b2RV6BlSPDTGEffLiy38dIvM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:28:16.8616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7135e185-edc0-4151-2782-08ded739efc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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

This issue was found by Sashiko AI review.

Fixes: 37ad039fb367 ("drm/gpusvm: Use dma-map IOVA alloc, link, and sync API in GPU SVM")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
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

