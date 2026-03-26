Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2F6109E535
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 01:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDD910E114;
	Thu, 26 Mar 2026 01:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3qAlu+En";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A47310E114
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 01:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMzLBpVzxjI6VQG6NO4Z8n17mJMnAFRbOUh2XHdzWXgk9yChCHhGzFTzBXH3/ZNflm8z58DbJkW84TMEfokZXYlA9eSn8zjNd/ZkdJXAF2Gj3rTGCqwCOhAic9G7axAFKJOn14vSzRoL+1FaWqaD++Qvot/SZRwDEUrqSP6BRku2WPlcgV2mNcYt4Olm04aPeMlsZKGVMiz0swzXU15t62p6nvzYkTXJxXBke/GLdRYVM80GRaUABNr/mk8YCn4L+rwrxOkXpEDmPMUi+4fdff7RxepuApjiODiMmuFTCB3JEdr8WQ62yxxFT4yzEcbKSNsswQ8bslFbmfbOSECKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQiYuWMD40WM4Ynu3i6qD1dNU6uPs8iWcnHNayzSWBc=;
 b=WVleulkFBh235eGZ9nvecpR/Ehrg0B/2/dnY7UP3e/h1qefTvQ0m2u3Xu/Sp65p/XzcE73BGeWSBj6YuF9bHHIk1Nfo/4dcFMVwousYSj1JhuaHLQ2dKSKMZv1MidvNzv9mbJWNJPB/uvCY6D9TkPy4Cn+r8cyIQ8dM6R9L1qotApeY4UfT1wlw7/HB0a5L35M66QuR9fDDMiqHIkbn7EUyeFPX4Ph8NJ/cBwmvlENSNJUFsfp0bmnfkz+3LNAFCOR9t3kmfuqxJfYns8TGGNUNr85H6gdcOkLKe3kgkSumpBLAG9rvrMfnTlF8zJe4pjCWeYRbN1YoFN9MswTMPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQiYuWMD40WM4Ynu3i6qD1dNU6uPs8iWcnHNayzSWBc=;
 b=3qAlu+EnSZ8fkJVv4oCfd8aIk3M7YlymuhnRBCGycVPoJUy65itutMEZPhQm7oAB9rELDklyhoE5S6lTZJJVK2jmXxoMOgjzUI/vc5bvrSR18AmiFOqd+fp7EABK44E74Uhcyul2Vqk1DTnoqCdFPN9HQiIpmGXofEt4VClIV3I=
Received: from SJ2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:a03:505::22)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 01:07:03 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::2f) by SJ2PR07CA0018.outlook.office365.com
 (2603:10b6:a03:505::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 01:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 01:07:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 25 Mar
 2026 20:07:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Mar
 2026 20:06:49 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 20:06:49 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix leak when pinning ubuf pages
Date: Wed, 25 Mar 2026 18:06:42 -0700
Message-ID: <20260326010642.2596525-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: ab68b9e0-db1b-4117-9ce3-08de8ad3fda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZpXwy7vDQiPeheul73sKS+9WRbmm6+Z8yEg4RB/yS5xdsLtHIqSNxnC2kPtgH1HgSbB3xu7IOfq6QlUsOjieg5xSeM86kBL8GxkdZf9RV1TKqwQ29gup2cgrMc1IBJFsINihe+hr5Bs2sIMWIaA0K30wQPJck+YeiTIewsLfcNBTla9yixNReeiOIOsomRUSwxTdYJkuRj1N9viEXQOMoYClnctRH/EgWCUgL5J39CBLMQ+wI01h84W0Im4B2D8PEl1vrAxMiTEwyf5lOS3bGicOheUf5RlB8JSmRVZIdenJq4p4u+LB9C9e2LdtvAYraQ67QK6tGEoIEwEfZrLrmFy5++biy1XnvtT5h4BzCVTRF8nt9vg5aChV6RtNqh6JLy2oD7zmGTv+BDboJuDOadScY+CrUuCm8eKWiQTw5cHWSlgN7f8rk9X5TxSfjAogrqeKvSUvymYzuxlegCKL/sIc9KY7yA5/xLViV7LGAgY0wN6mZGSEjL1+A9MHpsF6yHlWFOUUHj6y0zLhFo0hETplbl9ytYR0tYta8VXLlAsKMZHmDVv43ql8XosoPDC+zG5PbLdzkW4aAUxvsscosSz7xcWhMlK1SNzW0a00idrsh0xPsIrzjlTLp+CI/Wk1ESzW8Oas563bL+dRiMWEloS5VTeTzKIq7iswWzs0o75YcCIUdeoNdfcIU30vPWQkvAAZKkX0Qx+8HAsW0AIea9PIavgOc/GFe8FU/yHPdxAMiKybZaL0a0uGnpVwfgjFLhNIldWJnR1GBE8gBXGICg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VyuwwV8Jbh/vMku4SzlW2JVnFhcozny+NMQn7EChVBwivDNYSun50fkZaHWZiuUTMfi73Q0NO2o2OSsXg/mFi+Pe4RsTUvDe4EVYIobWstW+3mt47Q2axNys67JWZBfnUkPiBdGh41PsM2sA0oJQaVL/ja+olw0eHp/czceur/xjZqD+UgmluxVS36kBOEfQX/4vqx9DDA0ofv1BUXIxwXh46Vt5Rz0xUxPERPMxTlQoEscUNY6/hBBB/kmoUsHEBIZJU5e6BTpVIUUd414RWqLxLx/oKZLM4080G0p2XXtrjQQn0IMLd1K11WYaAIpHaJW5zXIflDpz1s/jpyAGyhDobStzHa+b3gt/S4K1GhjIjij8XGqoY8Ex1ZZDhRPHix1iqvtB+Q2hCgiJKOKNsEpnhuyRxCrlFkbsRMRA/4CXOizZDMfhj9F+TJNCJVl7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 01:07:03.0306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab68b9e0-db1b-4117-9ce3-08de8ad3fda5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
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

From: Max Zhen <max.zhen@amd.com>

When pin_user_pages_fast() returns fewer pages than requested, the pages
that were successfully pinned are not released, leading to a leak.

Fix this by unpinning any partially pinned pages before returning failure.

Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_ubuf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index fb999aa25318..4c0647057759 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -196,13 +196,17 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
 					  FOLL_WRITE | FOLL_LONGTERM,
 					  &ubuf->pages[start]);
-		if (ret < 0 || ret != npages) {
-			ret = -ENOMEM;
+		if (ret >= 0) {
+			start += ret;
+			if (ret != npages) {
+				XDNA_ERR(xdna, "Partially pinned pages %d/%u", ret, npages);
+				ret = -ENOMEM;
+				goto destroy_pages;
+			}
+		} else {
 			XDNA_ERR(xdna, "Failed to pin pages ret %d", ret);
 			goto destroy_pages;
 		}
-
-		start += ret;
 	}
 
 	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
-- 
2.34.1

