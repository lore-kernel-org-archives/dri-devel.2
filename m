Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADC4F483DD
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF51A10E0FB;
	Mon, 23 Mar 2026 17:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wVwPFGHb";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3736E10E0FB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jys8xu67WG6D7QTFW89TNXWGmh6tB6yhyG2z8US/otHAmcH6omVQ3K8G0kQ9JWw1iI9ZHcWHIidb8hvDy0y035h4jDukEzDo5RGoMHmZQxYj+PYaISdEE5YYUVPf1Z9O9n/eLPIz8Rx1uGHNoQ+sg7yfRELh1Zf4SbSGilJAiDirL2fkoGIDE7hSRo57QDhVSQZkso/eHXGdTFNUcpJzgxC4TtQ0vsEDgqUqvZaFKre9jT5TulRwsi4GWRM7hJ415mu+HpiHqFn2pbsCr+6pS9HWFdxbKDa9F9UywGPCs1b9u4eMiZq4wLqNaZRIWb2o+zUgn3YhZCzgbAUil6xrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE38oGIZCbp9yACYsZ8GDc5OZQghk/G6AFG4jGn42kk=;
 b=p1IpPNCtAF77IkIVXgISdJPqdjISrN8T2q/T9Tsp/F8nRz3uzDjhHxBZ61rI7emzrHFiG+yz9TkU4NJ6Cym1GGF/Z7tjCpEVr5+Uviaz1WvWKNK9xe8JwsnsrWxbhjhX2P2jANdTRXWO3U7ZJ0pzIt1cWRA0zTlsU1IngDlr7adDaWSZyGoV4zKaFJQwlzAmu9lr1wyDL0bCoWVaKQJ/9EijYBFleHCsiDmEn8vc5WCiOFMIpA9LjTMUQrWEjt8FEKbVmxiRylizkOe2A3ZRfq8sSnX7W4Qot3bA6r3YDquqH1jQDl/Ujf/Ocft7kOOPc0GrNjl016+Yh1Cceq2sgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE38oGIZCbp9yACYsZ8GDc5OZQghk/G6AFG4jGn42kk=;
 b=wVwPFGHbx0BACSi8w5/+KNphBZzz2QLeNAVxrJ3lg5Ebvairzsc1oZ64bPl5PRf71/VT7JY0vPayEigAf+HGw2gyyluXYOn6gB8Osp9uR4ZbDX7DvtUsBGSL4xVenhtyqNTR8WsmyfGvTflB+uEB0Ya5l0sXoXpIW6o8Sg/VXgk=
Received: from SN7PR04CA0164.namprd04.prod.outlook.com (2603:10b6:806:125::19)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 17:37:23 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::60) by SN7PR04CA0164.outlook.office365.com
 (2603:10b6:806:125::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 17:37:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 12:37:21 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 12:37:21 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Wendy Liang <wendy.liang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Return ERR_PTR on dma_alloc_noncoherent
 failure
Date: Mon, 23 Mar 2026 10:37:19 -0700
Message-ID: <20260323173719.2311474-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f5eecf-3d4d-45ee-1388-08de8902d713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q4iiRa32mZXRyYt2gCus6z7Gfv41csV2izmYKovkeneSIleJgpCDE4HNz6Q00cZgzSB7/3UpJfRyiYiFATZRk8qV0AT5aPojG4kE1wsHr9EenHAEsEgY8Na1JYNsKaAhwx1WQ6QlhcAifeZVR9ZZrRjC+U5aoWekISJjiQ9+qcXWWy7/8hsZygjNvYzPnzflWbK2X9VS6rhdNWy0tSBpN1vPpxuBDWgejmC8d3cmGRUlDNXZ2FIJUyJqo1VddTJUB85xCLufUifKTI14dbunrSgu3zOgcSRl1QO/px9+xaVH5l61CFwUmcE46T1fEWX3TL1/5DBNYYATnpr1zCKIGFY4wYmsu4fvuF3zUx43CvxtMnx+gurEH1UpvqqNw+GSwQTFBf50h4koNiRLMoVAkRH7XUUV694zCv0ntUFZ6g0lGiXNzADyLE7V5FVqI+351LAfzICM2Pc3V2YBCNbP2gfgoA1/nhi6dpei0N6TNTK9PArw1ILJJW5IGzLZNAE4rvmf2nr1zyBGQsoJ479CgFZ0hsvm5aYoMznwErCdDeXy88Q6FduBLudqiwQRDt6uMGn3SaO5K5efH7FYILnoCrv+iv1AVi/EbZNzniEbwKgiKmTFvaDZx6SR7hi/4qemSd4kfCGjKSbP9TV7fhQnTPg445uu3XH2S5WKYnvNMzh3OEpLpeLcYszH7izZj0yZyHPBJeSSqO8AXMUiy25j8mRZYLM5K2sdO4GYVkscnPkUcIXIQJvOCG4YF6/64RMZofr7L6kW7DQKcrktX/Lknw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O7cfJJjk+nsfvHGN1zdO2YEwUdCfF3Ydm+IzFNuR3a5VjZvF1CyPWc6gz06BEpBK6w2w6TSAvji7yU8zlMJyJErK5qf73M2eaygZq22rZW++TfNfVMwRk7M+KnJ3dlPGxCpZ8CrOMmBg9M2yAZ+EyS1378mLAsgkeJ1PLsdknowlboV4ZPUcD72KG6T67KiaiPSUadXUAgYfODat8YvvwETroULIHO135W+2M3gXLBfqPqD3ObbRoobWBm+LEbIeUbiGj56btnhYdzZpwLXKw19gcK0h9AF2Udo+cuQ2Nkwvw1Wjw5J2jJTPz1j3nWtLzMH1agFmQfzAG2AeDXsf9E/Qz2NSybLpa7Eh+8CBjG1gqCcVdYJcysWKXh1vC21c4cTty8TKiSz7tzry2N/09GIClrC1ZOv+zsTGbFNUBT25F1zfFPYsl6DnuuF+JnlI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:37:22.3817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f5eecf-3d4d-45ee-1388-08de8902d713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

From: Wendy Liang <wendy.liang@amd.com>

dma_alloc_noncoherent() returns NULL on failure, but callers of
aie2_alloc_msg_buffer() check for IS_ERR(). Return ERR_PTR(-ENOMEM)
instead of NULL to match the amdxdna_iommu_alloc() path and the
caller's error checking convention.

Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_message.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index 7e219a5eda56..a1c546c3e81c 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -56,6 +56,7 @@ void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
 			    dma_addr_t *dma_addr)
 {
 	struct amdxdna_dev *xdna = ndev->xdna;
+	void *vaddr;
 	int order;
 
 	*size = max(*size, SZ_8K);
@@ -67,8 +68,12 @@ void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
 	if (amdxdna_iova_on(xdna))
 		return amdxdna_iommu_alloc(xdna, *size, dma_addr);
 
-	return dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
+	vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
 				      DMA_FROM_DEVICE, GFP_KERNEL);
+	if (!vaddr)
+		return ERR_PTR(-ENOMEM);
+
+	return vaddr;
 }
 
 void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
-- 
2.34.1

