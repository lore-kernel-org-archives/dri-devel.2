Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C0BCA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 23:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB8110E11F;
	Thu,  8 Oct 2026 23:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1FMigVHa";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6F410E11F
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 23:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+OIsHXbK7LnDNEPHBuhxdbH6Fp4V1K3n6NYyCs7DWgzor7kb1mHsSGTVWYEKCPQxPwLBYyyrs8L20tVICIX/UlRFyg7CoVe6nabb8skf53X/tDsHhFQBhEgx4Afm4B2mkNipfbxJd8MQur1sqRtrCrqhKfjVxtJ56mY//T16iKSa700QBKEm4jDCLiC265sOpn95vIvNP8quJOqH0HrK700QCHChWlVNuFdRXPW/xjrTvhqmgRj9WBpzJhHW1hjVA7CQheQ6Q/Hw7fnouM8simdFvSm4t23hcH2tKiLOR4zJW6Deyp98vZfOWHfgq6QpqwtW4zwwDBKMLch+vjkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y62j6lcAZyTVN01jVSyEcTwPcUxyW1Uzd+mAoRuXpCY=;
 b=gNn2BvqWtHPBlC/Wka+yssqkrkUyxNqJNUhz5ticP/S91sgiT4/kpglByLkdN8fhLlArLUx5zUNTFCeOAqkmiTaWXo/e2XTOZ2F19Dg1JS65L/OrmVnYjh9A9j4RXkwY7B/xDhxknmp3LO4mzyJEyRlTZ4g2UHJKaWSaOIvKuSrWh71hd0LS0OOmJRCLqlWRszoeIY4YjJZCUrObw22s3KFErQ/sjB9QEh67rfJh9ZWyB77a/6nQHmqDQD5kvNsL0uqp881nB9A9HU1kY+VA4/fAPrRgqUV6PZOMZcOt3DwucigsG7NrMkDLsJF+OgPbNl64scEdbQ+Nx23rSmYQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y62j6lcAZyTVN01jVSyEcTwPcUxyW1Uzd+mAoRuXpCY=;
 b=1FMigVHaj9xFcBla4d1GSmn+MdYaUacZCZKggh8m8AhONmWB3Cpck90a6RdUiG+e5RLyRe/mptVynx76Ap1YIARvSDp+9Kyc/1KphZRv1m9R7Rm5/stxm6OHqJjJobq9TVvaY/M4kzOWIlhTk8xhnEMgd5LzrLgAKZ4/roicaOQ=
Received: from BN9PR03CA0886.namprd03.prod.outlook.com (2603:10b6:408:13c::21)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 8 Oct
 2026 23:24:21 +0000
Received: from BL6PEPF0006C3DD.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::72) by BN9PR03CA0886.outlook.office365.com
 (2603:10b6:408:13c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 23:24:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DD.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 23:24:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 18:24:16 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Thu, 8 Oct 2026 18:24:15 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH] accel/amdxdna: Reject device heap BO when dev_mem_size is not
 set
Date: Thu, 8 Oct 2026 16:24:16 -0700
Message-ID: <20261008232416.2646054-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DD:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 085be6e4-71a0-4a55-d6a5-08df2593485c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: X5IMYtxOInxEPaT9ZcOY02uMmJIMlZU8FEiF4LrDDsvpMxd33+xtFQu/YhNK1xwuv0hdVJB8Vt2OHmtedw5YD+103K6ss02dWQUfbJ3yogxHWYZXKa1igKMKaTju7kZVkyD+VOFVHxmhiL343uR1RNefwag2+GqhP9ED2Q02spPGyKlZyrA1rhGreaTfSFNKkn/L1+r1OQf4bK3760g4lJi+FgY57YnZ4dMc+7sxy0Thm7tsZNR7ReDuIiRhGo8mwRCitYzGhDmVYfdlTK+LOVULsJnfwaEHrot+i0o/0rZYA81fW+nW3fe7LimgzYMmMFys6ViQkwtyFDAuNWjMatVuh8SPa70A2rEr3m+ZJ4Jdc41NIbDNu3leu11f86DbCaXJHkAq8AWwv278/Xe+G2ujpM/ARkkKpxTcMjWJgSqsrh9rd3zuNUpEjXSUJG0WdW26c71H78pzMs1ocx468PJOPsQZzeZaEJ5GVO140JZEj4rd1mX0FmOOpVM14qGO8cxNczs4HC4MawvMuByP4yV4C5ndBJ9pG9QEh/w+e3OS6/WEdotoECuo+Rsx22fpvGNTLjutQwc0p4g6nV39BtWSxy2c5QzCGQzZdilzFitvCeNA6MUP6ZoTJiCr/n0Tzk8dmgESe5RMJdI87POJAHajeL++5mJEc+nSVBbplG/K4jiTSqpQUAZ6XzOyWn4tradjBuVMtUaosZlTD1/1DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kBxzBtLcG4cPlWZqGosmvzfL7IshlkxbzZjxgtLH58k9Hax9en9dBobdAlLtmPsqAMwqLliaBCsfhZHsqSyQmQdy9rWW3QJ3pVs7U5Po45Aq9pBu8Kr9CcVhCt+66VU3qrDdDCsyHVquiuLtSeszWw7xMNqmSQFbNPwxAsHiqwxil+ctllCUUcW8JusYbqIKy1rX9rthYvUYua5GRjJmakIMC3x+TjS0pDKvvAvqntKClSg1Ir5meWE0Z3w4SYc5QJYGqD8Xkdj/jV//c56ofhFDiRCZZU+eaQbxZxynt3S/D9tPQHHbEob4HefUfqLFFKjH21vtlPenlEo2D8a11L24OBygyVEPT+9/M52QsQxEFeIgPuMCEOA5zVJXvr2JEBE3ytFJLTdemHCeaSm/QxfDnv+KoH11WVyXpgg+o0GG63e6myxsPYdAIj+6DbGG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 23:24:21.3915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085be6e4-71a0-4a55-d6a5-08df2593485c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
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

NPU3 devices do not set dev_mem_size, since they do not use a device
heap. Creating an AMDXDNA_BO_DEV_HEAP BO on such a device hits the
WARN_ON(!is_power_of_2(dev_mem_size)) check, which any user with
access to the device node can trigger.

Return -EOPNOTSUPP when dev_mem_size is 0.

Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index f4832337ec31..f14484bc31ec 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1140,6 +1140,11 @@ amdxdna_drm_create_dev_heap_bo(struct drm_device *dev,
 	struct amdxdna_gem_obj *abo;
 	int ret;
 
+	if (!xdna->dev_info->dev_mem_size) {
+		XDNA_DBG(xdna, "Device heap is not supported");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	WARN_ON(!is_power_of_2(xdna->dev_info->dev_mem_size));
 	XDNA_DBG(xdna, "Requested dev heap size 0x%llx", args->size);
 	if (!args->size || !IS_ALIGNED(args->size, xdna->dev_info->dev_mem_size)) {
-- 
2.34.1

