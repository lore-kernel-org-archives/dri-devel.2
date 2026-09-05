Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDC2C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C2410E278;
	Sat,  5 Sep 2026 13:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ss4pjLyC";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9A310E278;
 Sat,  5 Sep 2026 13:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2KFMPYdowN4L/o0lY2dRk6HnGZsmHiAQxCrCHr9FEJw/9ZG91Sd7K7DvO0ot7rWLNhJ6G9GL90FHAMRQcTtqp6pyxshfyiNeoACqBwOc8gtTBbQt1zmN/LhFDV72aftwHzBoVLyo9R7eEbsqZy++KZY+qpRYDHGnB0cqvBAClnGXOHFpu2QyAPA+YL777IKwm0Z4LxnR/xTGc18PjUgRxQ4hFI+E9QlXBkUAdqsOi8vxBe2DLJKT3apKLGhDJtFRT8Kg2vRHOnJQWRxhuSYY7HR5bUDYhsxZuSwqEiv6z9wY4edZD+/KrFH9LRPLcuf/+fdR759HXauOAbLXHa9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnIH29MvLpv+XU+Zi/Aghx+Flan/2kmFgGPql9LPAgg=;
 b=Ec0+3rc6QNJjxJg+lqDGQQ6gFrH6LkcioOO7qcfcN1G8/uTPyfqVwKfIUgFbg0nbMNCZVXxWrm5cBKN4x8U4Mx/P0G9KOqJgIoGcrC6Gfq8CRr+2V6eoWOngfycdX/fWiZ0Mh8WLN+JwR6MI+WzCbllJHJvUwIG+bNEvYfnpo7q5WFfwbdORlgIJ2IJ8UBIgWxPGXF2XD2fScWkYTzq8wr2YDHqdnjvaSF3t1KzHZhNjO7F/M3948Y4zDnukJfd0jX4GTR1HoxJvlzwXEqymBr2yD8Ig/dk4SmCBCP83MaLpBUtq+Jv95M2U/rTgIcwE9S9ljXHNo4cAHxWKzFp2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnIH29MvLpv+XU+Zi/Aghx+Flan/2kmFgGPql9LPAgg=;
 b=ss4pjLyCMw+OoSwUAAHCm/Q5apRHsPiH3UEHp1FHt0tXKceoet8kTyhWYPgUNF+3m7KPezUp9qicdjwCOIzUH6KrjYmmm8vL/87cEBEgzYMMC0DTMFNsYe8TY4mLVTfRyhVYcr1b4nE+h5GOSYoxEth7N1eH4luzYiPeabAMG/4=
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sat, 5 Sep
 2026 13:32:05 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::11) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Sat, 5
 Sep 2026 13:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 13:32:04 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 08:31:59 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 1/6] drm/gpusvm: move dma_addr allocation before the
 notifier lock
Date: Sat, 5 Sep 2026 21:31:37 +0800
Message-ID: <20260905133142.3628027-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905133142.3628027-1-honghuan@amd.com>
References: <20260905133142.3628027-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a57e05-e9b1-4a21-dd49-08df0b521314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: QzgsMDK2ShHkYuVu2eYvfoA/hmm807XUW2uVRfjhU0gLBiLcVbXweQUjTgmKVFxeaWaNkak4MJurbccUNTtr90BMfsgSRff9z5lFNDx3Kh12cq/XAy45lGKgHYQ6+4/+YgiILMczBtHkPuC/w6YIdJbFmbW+GwprGZWSuNhclN6VUEvWTqRjhZFRcu48Je60h856yqboQV/oYOUgfFX20YDVqlAS1lSXFRgR22WgtN73TV+4WjwkYi/tycAWjdaGhQ38dVQUsGEdZ1LOqcsTBLbKy2dcRVM4wOlLvep8KioOtJZ8TTapJ4dgtbulAlmK1n+8nfoNVYPs9KV0HINBmyk9rPCIl4wU5wzEp6NmQo4Sr/G631vYb8jG+iQl8GtLcmqUcBAHfKBiAZsmzcgI/mWGlsfwqzWYsSakVCV3sr7z7pC8ZJ8VPYDO0jaZ/PLCGs8dbZdAQKGdSYDBQwuM3T+w1r4yJOrmFMFWEa7shhqMMxdi/UWJQaXarXmvLrnaB26l74hw3s+d2d1fWQXJfpL2PsuD0nsxb/3O7f40tC9MENOG1sczsnf5pzNzW8UONZAxol3bswoUlPFtRTj2C+2ADbk9PS4LkyXRZQASD6KLzXRW5Uh0qpt/grkIQkptD22aiwn94v9EUMqyST4vGU/gZ7gQtkxD0BYWciZG633L+/lVXyncuDfB41anr63IyA8oT1sO3UDV96B8yQx7lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Lu/k8MWYCLosNmEd52QglUVis/dUkywYklrjH6nwvSiilwDnxDUY+pYtpnMBT7Po11lpxT3QkrSKqzvx3YOMggCRqMwMVSEuu5C4PyxGa/GUzK4gU+uBg4LLBZl0EGuCQCY8/TG7KPPO0Ri3ON6NU7rvlNsfwsU3SQQA7Cn8jR3aQ4vpIU7vN7KgxXgrAPzhL5HbHErxECiwQxtXW6lZ91xnClRUesI+RxkPUZ+hJX0ps0r/0xz4eIg0PCcVf6VKLO4qUTKfsn4RMDor/0X7BUnQvd2cHrHsFCuWjX6AXxTOWNJRLBg+iVdGSkkZOs/zAywhmGWvB9Bl9sO2lvBKk/8kYKtXzZvU6XfDGdnj5PsSvEh/kLFtsjkfGbobAe7A+cUMTS+NT4rZI3Pn2NNy1T/us0D7DliptroRKLij/aeg2ktvQMsvhhOddwlZv7P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 13:32:04.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a57e05-e9b1-4a21-dd49-08df0b521314
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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

The dma_addr allocation was in a lazy allocation flow, it needs unlock
and goto map_pages. The allocation only needs npages, so just do it
before taking the lock. Drop the map_pages label and the relock flow, so
the sequence becomes fault, allocate, then lock, validate, map and
unlock. No functional change intended.

Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index a93eee7ddb9..b507de539e6 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1516,10 +1516,18 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
+	if (!svm_pages->dma_addr) {
+		svm_pages->dma_addr =
+			kvzalloc_objs(*svm_pages->dma_addr, npages);
+		if (!svm_pages->dma_addr) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+	}
+
 	*state = (struct dma_iova_state){};
 	svm_pages->state_offset = 0;
 
-map_pages:
 	/*
 	 * Perform all dma mappings under the notifier lock to not
 	 * access freed pages. A notifier will either block on
@@ -1540,18 +1548,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		goto retry;
 	}
 
-	if (!svm_pages->dma_addr) {
-		/* Unlock and restart mapping to allocate memory. */
-		drm_gpusvm_notifier_unlock(gpusvm);
-		svm_pages->dma_addr =
-			kvzalloc_objs(*svm_pages->dma_addr, npages);
-		if (!svm_pages->dma_addr) {
-			err = -ENOMEM;
-			goto err_free;
-		}
-		goto map_pages;
-	}
-
 	zdd = NULL;
 	pagemap = NULL;
 	num_dma_mapped = 0;
-- 
2.34.1

