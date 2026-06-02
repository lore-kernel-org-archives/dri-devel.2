Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ED9C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 04:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F02910EB7E;
	Tue,  2 Jun 2026 04:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ssamgDno";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B822810EB7E
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 04:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/NeQ/6rtv4BAd4EWafuO4GE8CnIf5eYO6IJC4D+jQE7PC77WBiqYRBOUu5RdOctD5u6wpZthpFiv3sTgjj0ZHIDyebylX8YUK751vg+uYXFAFjPX93zClJmlq8QDRBNG9VIP6fJWiqQG7/Nm8TqMOcRAmM1rMSoubQOtbvueeQqSau5X5iXqBGBrvihlV2Ad7L2m871rR6aSHBo706fnZUPbbad4q9i3Fo+yJMWdkfKwrdD8fjD0o9BV6tF9xo94vhGD4HCdko4G9ZQpk3KW38AoiF/SPXFbwU9e0VmOpz3Sk0Ez0/h7JtHt6K+1tqhMT0rOXar5iV2ehLThGGgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bWaTr6V3bjm6hvkW1U5V1nAKhmZAKbTZZAQR9AipkU=;
 b=H7YtNSpRim9dbM34EmeG9/qxig4otRN4x/zwonjs0SAtAuXZ219gxSnR1RI2dQBBEy6b2e2cFRhH0HeZNicbd10cCr1Ycyh2yllMJHYd1/JPgyK+zMkAbc1OpSjKfpDwhyZF1vbCB7ea6k7Z6ShzVjZ1Fovc8BSj6fADanbnBeqEVPHYTOpn+JmdeHdH1QAloFRoSo11IYYEJpK0mNarvkMdKY3fEv6aCz4R/ZVSNIFj3043MUF4NGF0H4wDskfBJIPaB1I0NGkBG72mm3UhFYBI91x4gY04KTfsTHhoWauLUkp99caEFgZvx3b6kwLQd7wQN5DPOXj8Pf+24zeDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bWaTr6V3bjm6hvkW1U5V1nAKhmZAKbTZZAQR9AipkU=;
 b=ssamgDnoTN2HnHhhEfdoSQVeDTRY5Cyv6RffzSfIHUHNQ3xoBiige2iXwni73h4CRedTsdNxstQOXdR1ux+ZSO1DnysTas+u+lv00Xtp8FBXoEQVQ/nPZTB4oWchLjgsPr6D03auwKR6WnAi7BQR1lf/oDSu/OQFeMZWoeqQb24=
Received: from CYXPR02CA0013.namprd02.prod.outlook.com (2603:10b6:930:cf::24)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 04:06:33 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:930:cf:cafe::d) by CYXPR02CA0013.outlook.office365.com
 (2603:10b6:930:cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 04:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 2 Jun 2026 04:06:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 23:06:33 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 23:06:32 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Preserve user address when PASID is disabled
Date: Mon, 1 Jun 2026 21:06:24 -0700
Message-ID: <20260602040624.2206774-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: ae975519-9704-45c4-d8c7-08dec05c5544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: In2UOtIVx5935AGl1oPQ5Q1wqO4j36JyksIgW3CFUMjnNds6Z26B6tEnDPBQpt90nK+FHlVbi6HziLhwSrb3U9+fjDNjMBqEcmidXw0qMVuRWN8FcdSrzOf4Z4nygg52RR6xY8pXwFdlWNatyh5N877NgnHnu53FG14IB2RJ81QA6nAO7cQm2qC56qcr+Wn4ipjjyMssVID2dBgqFUG/LFxQ6OWV/8/73+w3tEMsLzewSThMmw5kdxZ9eiROGaiyJK7lUYfDxurtI8FtxBYaQJPBFGPbZZMLiLmCNFc8JY6/xcqOGkyYqcuAn1naxHCb4/DiIwHJf6Nojhypw+3kw23ttYtbuZ4PJrxXK8ew03zITj4e2OLDG+NLyeR0wsdA8yO4fyN1sbZS7DDpPYqWWd7eMykxvioZKdpWJ+PJisTlEiLubHqLiVQugDc/4Rj7JwN9G7vkWrEksC2pGyDFoS3nQmrYGAZtCvXLvf6TfuLnNupGn/cTtmG1Tmg1VbO4rNbm4YoT+jEvWy3a0TFNAVtohw6jOTfaDYRVPKamBh4NKFX2ApRf8XfFPw8Dnmyx+PUaoTBNNKPg8Y2iIRDpB1M5VJ7IX4rIhTxcschLWErkZ90rLeR3sgcxn8PlFrPI0ziag2LT1uJO2ReLnFomzSkJEyAYx06H7PxBZSv9fOpMES6FUmjBH02Jai66QdNUY39dZQBJie0lgxzbeOpdbc4CpeKrK3DzQ7M92pJ3U6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: paesZelWdqxOQuAFDEP/K4yWe34h2p6OBvS8HZTMPZbxObWhaRgJ1lLNVVhxqKRStI7dYfdWHg/Kj9WXE1jq52ck+qlFcNQEgoNFWSx9iTQ2ILRXbeU45ZwDC6SaPbKs1hbGAuTGXL8aVMfjZKXdnM09p+EKBFUwu/xu4lS94hSsdVB/MEJZDaQKfGEBhq5Kcs7qgNwOqJQQ/1stIHZtaFIyKInZg9kx8rTzqMaKlaE2OmuUAmSsBvufNDLv4G7MtfC+vjPixXex69BHWgl9SBDaMlD3BZSiy18F+zOtR9j94i5rpEwNmTdlNM99+wKxBJSUX4cjXP4c7jGyC8q00bKjgLHa78xPHDitxUUQs75NwbwocG+X01WNjmE6CuOqgoPmX8w5/oApkeU4v399jvBmofN4oR6uHwUsd9fyk+SBsv9mGOqIp0QVWQeFwgd9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 04:06:33.2963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae975519-9704-45c4-d8c7-08dec05c5544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

When PASID is not used, the buffer user address is set to
AMDXDNA_INVALID_ADDR. As a result, heap buffer user address validation
fails even though the original userspace address is available.

Preserve the userspace address regardless of PASID usage so heap buffer
address validation works correctly.

Fixes: dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap support")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 77e5fad08ae5..33cf5af98ceb 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -349,8 +349,11 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	u32 nr_pages;
 	int ret;
 
-	if (!amdxdna_pasid_on(abo->client))
+	if (!amdxdna_pasid_on(abo->client)) {
+		/* Need to set uva for heap uva validation */
+		abo->mem.uva = addr;
 		return 0;
+	}
 
 	mapp = kzalloc_obj(*mapp);
 	if (!mapp)
-- 
2.34.1

