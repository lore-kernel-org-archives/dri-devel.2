Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C414DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3354C10E216;
	Tue, 30 Jun 2026 16:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hp9+9Unj";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6EF210E216
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 16:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8q+UgXu1+vn2/6pX+yoAyuXnrTEAL9tqmg2Wb6gY1+RHsu4UUFP8PRtDRvndOrHQzYgA18YOTUtr7r5Q/HRym4FC2HzVecHKFfX/a5UQ3NTSOHQhQq1/gxlTiNpfv1Rp5PYPkhNblRnsme74JrIWizcScqxiVol+ZzgnFgv5YJExvS/8j+Rn3gHP5ea+MW/tpTSQuxgIEM+5uAvXhQuC4IDJ/CGnPMD5DmP6CEnYsDB/DJwpjbTWeFa1YPCAx7LuXSiTm7ea44Jo9kXEz99gAjeW9YzN53feCUMEotQ9mg7y2be5RdhHBKm8qio2gsNf+VZpvT5mgnVBD7jJHTKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJAfV8ugprdkrLND+nsWF7e8BS0VEqFPZlOfFofj8oY=;
 b=sjcpEO5LypC8DFkBtuKauB8DXi2R/o025MJq+KKevs59JsAUlzkqPeKKDIpNKIWwSo7ERAkM/QRjWWDX11hTIU4GBimIATqfFtNAeMIAvlKcjh4rBXgYcmRh7/ZyNpcLABs0cgOJlcRFroSM7Ue0bEXUaA0V6MnEPL6buSpq0rW2zAgDfLyEjG/Qr7n6M2JZqeSARz+CSlB+d1NSRe606lAUq7Hsr8SPq4gFERoDLK/vVig0EQDiI5pUOqfGVwS4uxYvbXwXdsF4glkQlzDkZGPS1s6cX7RLQLKbS2GR2aOkAHfzRKNftcNTNcJS1g1R8u5/n77KHzoopaeTwmmOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJAfV8ugprdkrLND+nsWF7e8BS0VEqFPZlOfFofj8oY=;
 b=Hp9+9Unj47oW4J3gxxs7hJABoRI/dt+RGPzIfpbihDa4SHa3eCbzwI/2LjeGtn2tEqUjxT9QFl1GE0YnRBcjW0xwq0u/WG4RI+pqGPDMW/eC+zUt7r0DLlw/NHrnD9xiK3BWAlwCoJR7Zt97g2sKEecZ2ZHFZM4eD6RofEdXd9o=
Received: from CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 16:04:37 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::7) by CH2PR03CA0026.outlook.office365.com
 (2603:10b6:610:59::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 16:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 16:04:37 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 11:04:22 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <christian.koenig@amd.com>, <sumit.semwal@linaro.org>
CC: <phasta@mailbox.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
Subject: [PATCH] dma_buf: change unsigned int and int types into size_t
Date: Tue, 30 Jun 2026 12:04:01 -0400
Message-ID: <20260630160401.67544-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 8baf8129-eb53-4759-0e99-08ded6c14911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HvVezq+rI/yWU5vN6HEDqr3Ke7VIl0P2835bHU+fnywxLCQTicGgyxNZdzkbLmXQ7MEtjf4dHMpjeUWbes/Bv1Ew/Tv1OfReb6JHX459DIEHDXKgosNUA1+wLj8bek7TgNubVn/14y3KLCHvf4SCuCYUY/yoVtZd24E6jhfpR413y6uLzTUwzkYItIqN7TetyfAXPuF9/hFQ2ZtU3Zolcpo+q5vNIwKM8gCmbh6mjfC5hTjYgYljkN4wsMBgQHH7KzMhQ52oDpXvMzg5vi+2c78h6hrbSFWmBBGc6ROpjP5Y32NpJK8hf52IX3GaRC70A3RPJlRJsQKDp9Qr5Ne7W+OzPEKrw1pdugUgoNAfQB6K68XcM+7zYEzBsissZ3w0PBQU9kdgISQTS3am6cC60psv8SwTTHfeBPzkHj3gudnyO4OIiuO3+Z3VfvkmNrXtx3zAllZ1NFwjuo++OOYRzCdBk9O0QU2jKJfhFCzXZG57jO8oVXZIxJ1NA+rTUeEnU5oyl8V75CpmMd238AeF9erh5uXTbqh5XkEkm4MgJVcGkyRXA5OGjL2PT3QoOLmZ2URPT3bTCdc6DBfl/rN35tXsk8KijjiaRhEdeWE8ikpfmC+2tGPAXmYOY/jLO+pZE2QgQR1whKQ3gNnAH4PuqH3MgLb5teyPBua07nk839NvAghW0bo3O3JUdOW2xLYAOLwQn3BBoyUw+SPESS5a6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BP25YUpcvSMYVvF1McUX4dlCoXzXtO3Cmv4za4+hr3s77Os+6gDtyDKdzSIP8ltl/+OnjF8f1iSIouPSa8hgL0yoODTKGpV1d8y24BrKbUYbDUTIRqmGJcRuRw82R+gBb9ikVmZN8gqQORgYmwOEvSvIW2Ph9jXzTjfAcdkKMs00k6Bh8rbHiVn109+uzbWbdn9VcYvpvw9IEuQqkR2OV4oD4JKIKm7jj9I3XV4VjQyEbTgdEvu+Z/lxPXw5jnQJKdub4BA7pa4AJnr92XpeMRnjQCSJAJMg2sQe8b36KwxvnWNX16pzbUI9XlNBwhREGJkx0KHVEXl1YSDxxa4GZU9sOy7HraeINPQkIvhYxRUMydEDu9nImzdOS9WVH3DULsurmBJQiFXi5WAFEo0Z4/Im7E0kSfejX1pa+R0lQMH6aUNl6fJkJi3MO27j+vgw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 16:04:37.5758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baf8129-eb53-4759-0e99-08ded6c14911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748
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

The num_fences, count, i, and j variables in dma_fence_dedup_array() and
__dma_fence_unwrap_merge() have inconsistent integer types, mixing both
unsigned int and int.

Use type size_t consistently for these instead, and update the return
type of dma_fence_dedup_array() accordingly.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
Suggested-by: Philipp Stanner <phasta@mailbox.org>
---
The rest of the subsystems (dma_resv_reserve_fences, drm_exec, drm_gpuvm,
xe, nouveau, etc) uses "unsigned int" for num_fences, for example the
amdgpu caller in amdgpu_userq_fence.c.

 drivers/dma-buf/dma-fence-unwrap.c | 8 ++++----
 include/linux/dma-fence-unwrap.h   | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 53bb40e70b27..65e87d263c3a 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -93,9 +93,9 @@ static int fence_cmp(const void *_a, const void *_b)
  *
  * Return: Number of unique fences remaining in the array.
  */
-int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
+size_t dma_fence_dedup_array(struct dma_fence **fences, size_t num_fences)
 {
-	int i, j;
+	size_t i, j;
 
 	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
 
@@ -115,14 +115,14 @@ int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
 EXPORT_SYMBOL_GPL(dma_fence_dedup_array);
 
 /* Implementation for the dma_fence_merge() marco, don't use directly */
-struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
+struct dma_fence *__dma_fence_unwrap_merge(size_t num_fences,
 					   struct dma_fence **fences,
 					   struct dma_fence_unwrap *iter)
 {
 	struct dma_fence *tmp, *unsignaled = NULL, **array;
 	struct dma_fence_array *result;
 	ktime_t timestamp;
-	int i, count;
+	size_t i, count;
 
 	count = 0;
 	timestamp = ns_to_ktime(0);
diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
index 62df222fe0f1..7bfacdf79de2 100644
--- a/include/linux/dma-fence-unwrap.h
+++ b/include/linux/dma-fence-unwrap.h
@@ -8,6 +8,8 @@
 #ifndef __LINUX_DMA_FENCE_UNWRAP_H
 #define __LINUX_DMA_FENCE_UNWRAP_H
 
+#include <linux/types.h>
+
 struct dma_fence;
 
 /**
@@ -48,11 +50,11 @@ struct dma_fence *dma_fence_unwrap_next(struct dma_fence_unwrap *cursor);
 	for (fence = dma_fence_unwrap_first(head, cursor); fence;	\
 	     fence = dma_fence_unwrap_next(cursor))
 
-struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
+struct dma_fence *__dma_fence_unwrap_merge(size_t num_fences,
 					   struct dma_fence **fences,
 					   struct dma_fence_unwrap *cursors);
 
-int dma_fence_dedup_array(struct dma_fence **array, int num_fences);
+size_t dma_fence_dedup_array(struct dma_fence **array, size_t num_fences);
 
 /**
  * dma_fence_unwrap_merge - unwrap and merge fences
-- 
2.54.0

