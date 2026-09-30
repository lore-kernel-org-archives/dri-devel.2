Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514B7C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D39410F161;
	Wed, 30 Sep 2026 03:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKx9V8Ki";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F097410E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbYisFeFV15YQOWyVNGr74mEeNaYmvPXjzqBnVZtaLZtG9Jtg0TQ8nI6JPfA3+iFtKw9ayshcMPCkv0Ekoet+ZITkDyt/TfDNpxfQ+3thxBOQWSMdOuAX3DE9/jXB1hwvhw/baaZewVk5KuvOAWTFe8kehSlkwE0kxOc9ZIMRyaDOkdE3SnER9k1ljoCmkzqxQ0LrG5x83xgognQEyG48ySONpwXTbZOVbwr/xkLJSzDpAyC9byKhXS+WQhfonwBAOnPgnmFx+GcdCOpST+bPIBgfFPm8qwx1WmEM/uOvD0xwc/gv86lG72dkzwfDVHMg/H3okSr4OOxUusNlTUhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/yltlfQUYbBm5BQv8ARHHhzkmCaf4RAAi/x540w8TI=;
 b=Fn0krln+uM2garIdENlZFi1kxoN2dC9kDaAmOxzDVQ3Loij1q1qsUD2zZtTF0qLeo1r6oUFwJ3WbOa9NG72TEAnbXAzjOdLfW3Rbn5wBOKIrHJ5+LV0l1t4rscX2l9eOryLEHZWKz6y3dugNFKC55ckyN+tYIRsPniYgxAuId4mjwUVzRub2xVliSg/BMFCtyVL6ndCUIxyP/mgenY/GUV3k4wbPqJBBE9yBDHCdTbcUEmeZoQY7BaVxR9glUiUXme4Rygn+mEU3uOa1ZpA978DMo2OjBzjTQOOF1LCj55OZWXdNLLjIXf9d4/RFqkf84glHS9kkBzjIIov13qJYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/yltlfQUYbBm5BQv8ARHHhzkmCaf4RAAi/x540w8TI=;
 b=zKx9V8Ki52LEdPR660thMZa/LwWphz/1/K4mThyYg05squHFz+MSKSwgTXHupIvQlPg/raVCA/pk9d3Kaddky6Qo1NmE9K5L/LxLsJo+pu0Yq7bIOLlmpN6X/8kPPdsokCJE+KXco6tLFgIvJbSC1e0BJwT3B/RH2agmVA04vO0=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 03:33:11 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::36) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 03:33:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:05 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:33:04 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 19/20] accel/amdxdna: Add stub hwctx_config for AIE4
Date: Tue, 29 Sep 2026 20:32:32 -0700
Message-ID: <20260930033233.1727265-20-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff6c885-d7f6-45fc-a6c1-08df1ea38dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|22082099003|18002099003|6133799003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: sM7DlwSMKP5hSx4wljSGZTgRv/ALPWtAmLZ1lxnDhbl/KmAwVuu3GNr7g7gUAQsdhU2rZxYsvFV7c643fNenEEVJlGzuwF21XEELdSBUIdF7DaJBmx3KfRk+2VOeP2jl4KKePwutX1zHeaCnplpM4aHu6F5cQpxWtLwZB4aPNZBa8+2NZbEmBE/6ggql1G4KxK39bZkoclLPDaJOUZoXhIhPEuOCCP0fBMCZoUYWbaHf9s4C+lG1hwEKRWKZbQoHdqM/U/PNZbUsvblQJvAD5wr4IMvzhufF/6IzP9Owmjdwmjsu4Kyy3BkK5Q1KNUCf87wK8a4M+g0O66NLEI1URgR1T4U/PGc3LgeRl/sL6ofxuDZsmgrx2B0rNKvsGPQqjHAm3OSY7e4inAeOn1wYpDAVciApWH5bMAZCReDdjnHBh6ZBLSMdZ7Z05FIhxQ3BlqYdkT7zfz6SkNJgAAjE4QkIk4aa9VY93vStYvnE44kT8FayUfFEB8akdGAAZVO7XprMBOx9oBp4vlyxfMlZ/P4yH6lFPbMavg3dVKUXDoFufX0EQjL5mWbxs1pc5q0YAVb/Kfe7bpkFQui6S118EGTAG+c6mAht4A6Oug36cjfByiqngZFQeBdUpCwFQbAhqJz8n8Z6tCiNSQQjwncAWdH/5RP+9lmiCEBfDgWKIqdvPeJsaeFSQEsIFa803gNNfvO1fAbKaUMDgVTvHQJhqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eSWNZc9YN8Z4jqHrtIxjcWaHAQajkrsvigB96w4a7u3BFfbVsVp+//EhRCE0TIKeI0SiJ84E7bqn73f4i/WjYGx8HugIP3GNlSQSZG5BNKBdCneKskVEDbkB37DY7Agmsx4wEMIy96z4ElV79hvtfOpZd/s7vQGRM3SrszarnzY3e/46cVfnMOXMDvBxdv8GXOq2Innq4/P9fyF95iMw5CD6Ma5XKiHsP+9bbeVsc0v8fan30NYFmB1nAwa0N7UKv0u5vJumPCkJHQEJ+Z8GcI5FOTHS7zNsE2NdKx5z8FQ/E9lOC/5P9fAIzoAjBn8cEv/WKmDiGwNSigIN8ljcEYrolrmZ7ZH0/FwxMIDkN4Qz4a1a+zMPozmMhOJrtxbAoi9OGx7iKFAbmmSYWneeJ3veaUcp52XA3Q/7+ADE51K8dW5+2fGZGrRVWSkkqPfm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:11.6104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff6c885-d7f6-45fc-a6c1-08df1ea38dc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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

XRT issues DRM_AMDXDNA_CONFIG_HWCTX during hardware context
initialization. If hwctx_config is NULL, the ioctl returns -EOPNOTSUPP,
causing userspace validation tests like GEMM to fail.

Add a stub aie4_hwctx_config() returning 0 and wire it to aie4_vf_ops
and aie4_classic_ops.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 007b14be5245..62ee7dfc7bd3 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1369,12 +1369,19 @@ const struct amdxdna_dev_ops aie4_pf_ops = {
 	.runtime_suspend	= aie4_pf_runtime_suspend,
 };
 
+static int aie4_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value,
+			     void *buf, u32 size)
+{
+	return 0;
+}
+
 const struct amdxdna_dev_ops aie4_vf_ops = {
 	.init			= aie4_vf_init,
 	.fini			= aie4_vf_fini,
 	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
+	.hwctx_config		= aie4_hwctx_config,
 	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
@@ -1391,6 +1398,7 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
+	.hwctx_config		= aie4_hwctx_config,
 	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
-- 
2.34.1

