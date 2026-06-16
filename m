Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26123CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B69F10E63B;
	Tue, 16 Jun 2026 06:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cgj31TmA";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D2A10E63B
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 06:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZ9OFmeT6rXkGhiXZV7iMw9ixYMCfFJ3oRBN4HQIw7v+ealn63QJNWlJt1t9Zx+hHx+28h+aSgIxMujW3fv2ezP7HrBdYP1hPItoBxjhj0S0yROlxkE4naLMvE90TJUJKQpWLnBIqvZQeOv3PzvKKZSmrkxV9nspqeud2UOMnO11hgf/lwW8zgPbBjFp+Kxq1PajUT57S0PeaYgGRRaLPky/jhkIiGJVn6fD/AgtXxDNT6iQg4oLJ8tCipw0yCBdCAtVNYEd0l7JI6zxqBCKmFFJyyi6d0KPBd0ONy6zIqQot3Gzn9Ygb+m0DX7uY5iQOxpuuVEl/Gv+HStB7qMk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI7I/4TjW7q9BWbNjUP/btkfjGaG38YwgCAcokP2nBM=;
 b=RJo0snk/7p3vytsLY9qGDfJW8IBmd9BAORqHDe3vYvbvzffM3XTTNXU9E1iDbQSzTtntakc1cAVs0DS02lf7ve/VoSr/XI/1ei55iZ4g8sXhIkCae2PEt7kURAXdF3m4a4RErpm+9w4YCstziscnIfodJFzEH9qvL72ktG6qSb/xe33SNEXon39VnTBhu9zVtJYfIM/1wmxBRqn4oiZppGTX6qVJh65FyA8YwzmfZL+AYakcmZrW07j18CZgGhXvi69m2/GUEAY3zizkMX6q6IeV8hq2z6zhGlBN8Qpuu8HlUO+FU0vZIVE2VG1EOMFrsfPSAkZsdrAKVX0p/6zxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI7I/4TjW7q9BWbNjUP/btkfjGaG38YwgCAcokP2nBM=;
 b=cgj31TmAwmY4DbJXdm4KL/RIL4mTHJsnaDGR/2pQCq3eYw7+r7WGpUCRHAxpKwmmWYh8fofsoAIReBCROSHAZ7ABW3GIk8QCnH0vBcfodIpPywhD2chLDq2gmuRbfaQZnhyiB9wQKTgYEQjwFYHjO1UZQuXfTxU9CW8AwrvTzCs=
Received: from PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::16)
 by SA1PR12MB999110.namprd12.prod.outlook.com (2603:10b6:806:4a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:16:07 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::47) by PH7P223CA0021.outlook.office365.com
 (2603:10b6:510:338::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 06:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 06:16:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 01:16:05 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 01:16:05 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1 09/13] accel/amdxdna: Use unsigned long for nr_pages in
 amdxdna_hmm_register()
Date: Mon, 15 Jun 2026 23:15:32 -0700
Message-ID: <20260616061532.3533469-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA1PR12MB999110:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a99b494-ccd8-4024-43a1-08decb6ec057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: EacKsl1LnN8euc7ZuV6TFQMakP4UneJm1xTFFnTcB9zcfAiXRt8biQMPCT81hk9Wu/gmjOanMG8AisP+76x/5kzTUOm5j9DqxnP0NTfOrUDlxET8EIIbhTpn0b2EuTxZGsBiONMOuZI8zgGiKUN//AnJcBDqunEDTKAEnK8yVj0Ie+VbI8BxDEaMPuLLIWUDyQpCglxjfn3pJl/l96ht8nMfXRyMG4ItK7ot3StSVr0jrcbGKqsRwhE9YbOJTlMojBprwTh8A9dUqc5Vn09RvVP1OdagFoscahSLi/ssQycT5tEvDfimtQmrmmiaflYyjX1rn1Z8niDbWSesGMe1uGnI/b9dVc9cpKCp4VW8P4k8s7lVqd/sxEaGfmhSheJfhqRODhaKfPiDhOq34SI8/Ikp0hrsqeU/7zIR81r28KPEGH68k5gzQzNwexBe6SO6Vca3wen8EUPw4RIQ0u63MX+oSthSVQ5vk3vhF6KcxTDx58M+5bUVjjGgCJ3DWKIe4QIyOmYrWLk/xuSYMA+H3y+CPpPBijS3xP+Ey+ZpJf1fpJsS/r3QwBbcuUOiuTcj7HMawaUybB+5QRLi12lQ8ExjFn9MvlvdacQInBJDO66NMCQX5azOlwlZjAUtAoBs4nVl0k34v4WsPYaZTaQfkuO9qBGEVQ7jVNk/KDqx9rrXYvbX+Qb1tSNpZf8VMfHb34jRveR+QRY2pxrnZLCzo/wizy5JoCxaAbJirm7mmnk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aAMzo122pNkdXlglHIx9GTDIYOHnoYPb3jFe9RMvv5QXzFfkfuGzcrwBaHNrGXxfDQaFyMluA1cBaC4VJS3FC8eWTFxVF4nztw3osdoksNJmmwQxw5dClHpBaOo375tJwdHXdAb9DU0z/QZ0XpaB2P3MTcfEAKRdADECxMV7/L66y3Sn7k9JXc7EkGsrcjYRMvj2tyhjjhDtZoEIEHl8Ef74/16dOuSE4G+wVCccXGglH/9oRrD7lUWlRg7nU6TQ88lagrlZskWrUKyxEny0HBshFoTQTiGqWF9gLeU//fb1gNlAXLzXDDrM6wVQxf/gRuOyWWO27v2VRmXOCrFZt63Duirz47V6Fv0HOMoP70PPscRwsytZXo2Yk/Qp7scWKxhN7OuXk6STUsrJWtwC4r+pZG0bnbuO7F1DBFSOGanuY2qqDZsGFlmqvzRJPly2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:16:06.6101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a99b494-ccd8-4024-43a1-08decb6ec057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999110
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

nr_pages is declared as u32 in amdxdna_hmm_register(), which may not be
large enough to represent the number of pages for large mappings.

Use unsigned long for nr_pages to avoid potential overflow.

Fixes: ac49797c1815 ("accel/amdxdna: Add GEM buffer object management")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index aef4c23a1a66..201536aff440 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -351,7 +351,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	unsigned long len = vma->vm_end - vma->vm_start;
 	unsigned long addr = vma->vm_start;
 	struct amdxdna_umap *mapp;
-	u32 nr_pages;
+	unsigned long nr_pages;
 	int ret;
 
 	if (!amdxdna_pasid_on(abo->client)) {
-- 
2.34.1

