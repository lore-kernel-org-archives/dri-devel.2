Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3276CD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 04:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C05510E07A;
	Thu,  7 May 2026 04:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZpphytMN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0676710E07A
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 04:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi6fK9J9+/mWQTf5bC6O5QWh2H58NAGaP6dFHSCFSrKohsaZ7rcbKUZ0JWx0jSo2NPoSR5o1tqgDkcKqxAT8NJcXGQu9O1lIWEkpoOQ0iw5l2XGD7n+G9CzBUP+VBvX10jPlV8BF48jNAjIrDs+UAdBMZSIarj9UJKBLBhomhzOGh0uYBO1ogasKyOQLVguMHXQsJTMz4Ig8MVPiN9Iv1/JnK91patOUqrvHRXybAmDTQ3vAOHi+UIq/IxR5/vMNZsotKJU7cK0m4bId1ZKWNM24qANpr3T3pLITPSkwA/bEtVUMb7k2MWK3qaZVCSsS3CLlmHVG3jkBCQ3cOCnylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wLUI6XLCFEHbehwQIKuGIGd8QIUzJ4hiB64wX+eGew=;
 b=k6JYiNyxqd26SdmvliHDJwnT41Wuzv9TBXMcrZ0Pws8l60+rQdS1goIdvrSzIH6H/R+r5KFrCfvG/EseqWgSUFD+jz/P+qA8+DzEp9TM6E5AcU+hIbfbFv4O700+O4nakCq8QeSYOGCNzAh32wxJS1JkBSiJblf+jypLT1VRGOAICtiBluqg/wDV7f5BEykYGw3Zr/eemqLGKoYJ+9NFDme10eVtu9ZTMkIIW0S+jHNpeWn5h8wO/c7Gm47OPn9bI2lVE4qWR2kWy36rqKKp7Idk+Fb2bwh2iQQnZpokdliCGI/ghQY51AQnvRcPUMhOctbY2AcnynW+22m9mZWnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wLUI6XLCFEHbehwQIKuGIGd8QIUzJ4hiB64wX+eGew=;
 b=ZpphytMNyDqx1qXbS9O9lr+p/k37Y857hoUpWBQ4h9AGUzllzV/gGtaBGiGfvomZ6G9v+1BkIyHDYCLF8UO1QrO5/UxcyHus7uywO316+TiKi4uvw7ApoC9FuQeWlgD6lWPEHue72b3nHDvOg7SGYjCKVLIGXtE+QwGWkQfQs3U=
Received: from MN2PR06CA0020.namprd06.prod.outlook.com (2603:10b6:208:23d::25)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 04:02:10 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::d9) by MN2PR06CA0020.outlook.office365.com
 (2603:10b6:208:23d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 04:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 04:02:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 23:02:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 23:02:09 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 23:02:09 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix clflush buffer size
Date: Wed, 6 May 2026 21:02:07 -0700
Message-ID: <20260507040207.178111-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2bdf86-f68a-41d2-6b98-08deabed69c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: on4iBzNS/4ic4Xx+4WmisvcRG1deRLgzU4HOlsZfYn+IP9jmNBaegC0Mkwy49MT9r0wSrKik8Z1RgWTobzHE1ZeselI2xsot+1uh7xmW/2JIGrEKTwqyfMHB8rj9Lcbfk4w5PxP90359y86i6Tm3TvyzEsJ0neVIGs7aUsoyc55+dxynoEPInAKQ1msTHrXeUq4SNuSdsF+/FJeor6JK7B7QhNg2AnRDIbLposQzbKcNlbJB3/lUepij+Cg4A6pOoelkzBtRNi4QZCdIwmMv+WQA62KQCwRU9MBIOvlvgzvJiee0vog1mgglCYDOU66ASaKyURuEI1EzhMYqeAkKrv1Ww1ZGu3mo5qaOw8B7NpYOm0RF9fb5J7q0OI39OHRGFDy5Kz5kOLggzjTh3rhtdFHKTsWanPaMCASUzJkwSp9Npw0youa3hZp1XoJHSheAsBHNkEDf90kFy9N38TyvFIlvkr4ebgXMhBVJzubjbPjZzZrdF2DCYKculuHk11NmFPLUDN/7u8DbvWWqxjJt3oqkphPqiKnFRvVj3o8tYUJJJTgauyWwOgj3HRDqCoQa0efaMRn6Eb6NOwp9M1RAgR16F515Sm8mKXzYO6JfvMsG9q2k04SSvGvl7AjvrCA4gv/1A3Oj+gHCxlEM8Jrg45nb0UBNe9y9zrJTxeOF31qpKu8dYmgSeTDP1J1gpvbxzOByT2wjLKk1VVvnFhQVAwkdgwOLOBJ6WsD4tn/2mwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MO/nREGvD7rhMj2as1PTniSblEzsJUO9TaECMNVR2YMBdNkpagvUrk8KawllDUgUAREKueqDZWtqBIm/ZzRM14NgW22H7HxdU9Pb1SXYnck7QrjpCCIn2/2ciZkCuobq7BvtNmqs0j+0rI7nBSPVeD87iQj4YkFfIRBZdbKFN5zYVa3wWRDQthl0PQN4Y6Y0vCgh5ZnThhWJuqd4F/em29IxkSwNBRE3EWczPjxLiiWalchYFk+nfPX+Ku0U9KOFFi+ncs3cn8890vf2X2iMjJQPrbuY5UdHT40r2zayk4bYMPwIcO76BjOJzJFg49DoD/BqCq77fwG8G+Xg667eD5uUnU1edfyt8bcDV15tJO7m1NXDnOlqhV2XFHPnXDn7/FOqIKaTdwfBofqD9+W0KWWD+/icEHmdowt4WSZRZ0T7psdhjUZti6pfvoPuf8Cl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 04:02:10.2947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2bdf86-f68a-41d2-6b98-08deabed69c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

The firmware is told the buffer is req.buf_size bytes. It may read/write
the entire region. If the CPU only flushes a subset, the remaining cache
lines could contain stale data, causing the device to see garbage.

Fixes: 6e87001fe19f ("accel/amdxdna: Adjust size for copy_to_user()")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_message.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index 6e98af7b74db..a012e7e935ad 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -390,7 +390,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 	req.num_cols = hweight32(aie_bitmap);
 	req.aie_bitmap = aie_bitmap;
 
-	drm_clflush_virt_range(buff_addr, size); /* device can access */
+	drm_clflush_virt_range(buff_addr, req.dump_buff_size); /* device can access */
 	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 	if (ret) {
 		XDNA_ERR(xdna, "Error during NPU query, status %d", ret);
@@ -442,7 +442,7 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
 	req.buf_size = buf_sz;
 	req.type = header->type;
 
-	drm_clflush_virt_range(addr, size); /* device can access */
+	drm_clflush_virt_range(addr, req.buf_size); /* device can access */
 	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 	if (ret) {
 		XDNA_ERR(xdna, "Query telemetry failed, status %d", ret);
@@ -1186,7 +1186,7 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 	req.context_id = context_id;
 	req.buf_size = buf_size;
 
-	drm_clflush_virt_range(buf, sizeof(*report));
+	drm_clflush_virt_range(buf, req.buf_size);
 	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 	if (ret) {
 		XDNA_ERR(xdna, "Get app health failed, ret %d status 0x%x", ret, resp.status);
-- 
2.34.1

