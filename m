Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5B6D6AAEC
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C0210E2EB;
	Thu,  2 Apr 2026 17:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i64tcfuH";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E698A10E23D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 17:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuKKtuc6t6YWGbB5C1fdolt+8P3zc/Yj9+qS05nJo0iJ6khvl6bd190sLyXzI1B5m+TGn+sUrcQQ9FY1q2xppjuZQJcB+II3XZ2In0rh2082CFL60marHncGXMuOzxAiTVFNa2ByEZPuREhxQe4r/x6ljFoCK0CZn4RDXOaqT9awHhGBK95kmr9seMCkF8go2pIdhF5LmbmsusrgMG0ecwXvxVHzop2v4ECTUT3MHAanzBujlf06aluB5jImw6Vyum/sFZ4rWi5b4TF9oicK/WSqNGxxpwQMifPd9sMkL7Yo6dCWqkFPC7+uezAkMfmJBWXFq8OudoJs8XDLmKX5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlkA71sL0L3rDDx9ToYaitDIoqfBxb9u2Rc4B1Svx0o=;
 b=U6pDyB0yk1UhZ7aljFnPAWXZi7FBrpN7tCq5XCadAnJDrfeFaK/ZNrxYbhDs1u7rlw7gAWXOt//buHazI387EJSmHNppisMRtnSj0DLSKu+J0UN18lgYwQ3xa44sNN0yVhc+1NjyS6fXXxNaBFhJJJyNoribZDBmAC2BTyMzcrpTExRJepqiJaQUhkFN1LSLZicyPVQuoUXUorKm3QCFeSJAM/2gYZsALqqnjmu96PGDr+t4K/vq1nB+5y68IQcnPV4ACDKD30Vfat9XPLIgWR1VU+a5fYfayoo6y5qFNSP8LmhdSZYuUUILgA7Fn4+LLeZmRnruAW/NDrTnMXcwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlkA71sL0L3rDDx9ToYaitDIoqfBxb9u2Rc4B1Svx0o=;
 b=i64tcfuHTkOBujB/0b0/+ChDlvhLFmIm2i0VX+TECmAY4X07SFt9hnHMHYwq3CIMWxxBSjlLN+v/D9f8fjqYpuSev6Faar6SEiXA8n9wGqUSuVH7jcd+Mdjxf3fvWN1z69vKlpsZ4ofReCubM8GjHIb5971j63iJvaMwfAhPssQ=
Received: from CH0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:610:e7::9)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 17:41:58 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::ed) by CH0PR03CA0214.outlook.office365.com
 (2603:10b6:610:e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 17:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 17:41:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 12:41:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 12:41:57 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 12:41:56 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Adjust size for copy_to_user()
Date: Thu, 2 Apr 2026 10:41:48 -0700
Message-ID: <20260402174148.3527757-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: a003f671-6b60-4777-091a-08de90df2351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Gypk6mQs+9sAfSuhroXdW7KGkTzi88CacB3iAKsvP522+aVTmtKZ/LBqfpyf/LCBx21p2M1hULg9rlNwriDrnT+83rkwyfgg0AtKY+iUn58x6zChp1761sle+2qNC2TmCsxbfo3p9yBOfUQT4U5LP05uPb1rW8FbAPfwTcBy8bGc718mJcRb7Df9L9cQoG2Se98uYYfI7q51CTPKMbP2Gd7G8SmH44bDzOGbFL5z/n2sqHYI7iyl8gwBGnwblWJx1X6YDBBLszzs2OFUJcMfDoPIiAgh3JoSnYf201rB7kbKk4/Ij/ODLN29mNCQGZfXbYyHgMJ1aHJRVcToyYPyFI4j6yaAXYda9zsFB8g9SEeKj64fDRoiYqzZiNS3j6IrU/aUdr3JDSB5p9KvcavNaUDtUCwscX3O99XRXUzNRwz6jJ61W98mhCry6CesApV/eFg2Kh4zMEPuMec0Ku/AGrKJBpHVlaEB+kqh2OCG1C2AOHltjZzIQ8XRG1snHiPjjtxWqmt8J+xmjjd8UfxObpoETtihnmSpIPlWDHeigp5THp7xosBNIi0u3jP4gBMXikhAXPDLwImdWRUVEUoAQNUE7ZfsHmueDK8i9potQOFHh0rdakjCHy7fkQjl3Y4rBexT28LoA9omjS3QoAhJddBlG5TMFLjb6zSemszx/fhTNKHxgDU88hS4SFpPwlWaTA8jEktfherAb6k0GZJdLGuf01lZF2fx7EJRaAy5Tr2DgfiMBdtsN4pJM/o48qxhUZuIxUJgnZKeSOD8hOr4mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nFoW3peD6b649MCHJCQeNVT506QaW84Gv/HXOd1izHiwnRXvkPByKR3SjHurWB6MeF0oPOsSGBvRK4Lg02Z6yA3faNVc0RrmPl767S2sFAPkujSqf5nc0ZYxTt5CWTepOq9YrJjM4iKqQSwhoWQWTGFUy8dmBOwsNoYr+FS9YsdaWQdotFzrpXDG2GfMFX0IObHZgpjDDiwMHyZfCglfGq0UYpznDW+FPpaKjSJnBc+xfS5o87+R5RX5MMuOM+HLrivIxEu49QlxD6aP1vSaAFp1gUAi2Dkwfg36rO4v9NacTcggj0uO4YGEAWeWq6EdlG1430E+RP4GwOqZb7jV45xVNZ6HOx59JtHoXajTWh1bgUGhEEY8i8GMFpPVMGUEH1puBMS5Fj4Ay1dd8HPXGdjJTWAq2sZnlSjdqgVxFXJ0rWEowAQlua02Umk5LXKl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:41:57.6729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a003f671-6b60-4777-091a-08de90df2351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
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

The amount of data returned to user space should be limited by the buffer
size provided by the application. If the buffer is smaller than the data
size, return only the portion that fits instead of failing.

Fixes: 850d71f6bf4c ("accel/amdxdna: Add query functions")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_error.c   |  5 ++-
 drivers/accel/amdxdna/aie2_message.c | 20 ++++++----
 drivers/accel/amdxdna/aie2_pci.c     | 59 ++++++++++++++++------------
 3 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
index 9d20e956c020..70007b4363cd 100644
--- a/drivers/accel/amdxdna/aie2_error.c
+++ b/drivers/accel/amdxdna/aie2_error.c
@@ -406,8 +406,11 @@ int aie2_get_array_async_error(struct amdxdna_dev_hdl *ndev, struct amdxdna_drm_
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
+	if (!args->num_element)
+		return -EINVAL;
+
 	args->num_element = 1;
-	args->element_size = sizeof(ndev->last_async_err);
+	args->element_size = min(args->element_size, sizeof(ndev->last_async_err));
 	if (copy_to_user(u64_to_user_ptr(args->buffer),
 			 &ndev->last_async_err, args->element_size))
 		return -EFAULT;
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index e5e7da7a8f40..e52dc7ea9fc7 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -369,12 +369,13 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 {
 	DECLARE_AIE_MSG(aie_column_info, MSG_OP_QUERY_COL_STATUS);
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	u32 buf_sz = size, aie_bitmap = 0;
+	u32 buf_sz, aie_bitmap = 0;
 	struct amdxdna_client *client;
 	dma_addr_t dma_addr;
 	u8 *buff_addr;
 	int ret;
 
+	buf_sz = ndev->metadata.cols * ndev->metadata.size;
 	buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
 	if (IS_ERR(buff_addr))
 		return PTR_ERR(buff_addr);
@@ -398,13 +399,14 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 
 	XDNA_DBG(xdna, "Query NPU status completed");
 
-	if (size < resp.size) {
+	if (buf_sz < resp.size) {
 		ret = -EINVAL;
-		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", size, resp.size);
+		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", buf_sz, resp.size);
 		goto fail;
 	}
 
-	if (copy_to_user(buf, buff_addr, resp.size)) {
+	size = min(size, resp.size);
+	if (copy_to_user(buf, buff_addr, size)) {
 		ret = -EFAULT;
 		XDNA_ERR(xdna, "Failed to copy NPU status to user space");
 		goto fail;
@@ -424,13 +426,14 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
 	DECLARE_AIE_MSG(get_telemetry, MSG_OP_GET_TELEMETRY);
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	dma_addr_t dma_addr;
-	u32 buf_sz = size;
+	u32 buf_sz;
 	u8 *addr;
 	int ret;
 
 	if (header->type >= MAX_TELEMETRY_TYPE)
 		return -EINVAL;
 
+	buf_sz = min(size, SZ_4M);
 	addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
@@ -446,13 +449,14 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
 		goto free_buf;
 	}
 
-	if (size < resp.size) {
+	if (buf_sz < resp.size) {
 		ret = -EINVAL;
-		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", size, resp.size);
+		XDNA_ERR(xdna, "Bad buffer size. Available: %u. Needs: %u", buf_sz, resp.size);
 		goto free_buf;
 	}
 
-	if (copy_to_user(buf, addr, resp.size)) {
+	size = min(size, resp.size);
+	if (copy_to_user(buf, addr, size)) {
 		ret = -EFAULT;
 		XDNA_ERR(xdna, "Failed to copy telemetry to user space");
 		goto free_buf;
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 164e188ba501..041cbc8cd7e5 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -620,23 +620,19 @@ static void aie2_fini(struct amdxdna_dev *xdna)
 static int aie2_get_aie_status(struct amdxdna_client *client,
 			       struct amdxdna_drm_get_info *args)
 {
-	struct amdxdna_drm_query_aie_status status;
+	struct amdxdna_drm_query_aie_status status = {};
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev;
+	u32 buf_sz;
 	int ret;
 
 	ndev = xdna->dev_handle;
-	if (copy_from_user(&status, u64_to_user_ptr(args->buffer), sizeof(status))) {
+	buf_sz = min(args->buffer_size, sizeof(status));
+	if (copy_from_user(&status, u64_to_user_ptr(args->buffer), buf_sz)) {
 		XDNA_ERR(xdna, "Failed to copy AIE request into kernel");
 		return -EFAULT;
 	}
 
-	if (ndev->metadata.cols * ndev->metadata.size < status.buffer_size) {
-		XDNA_ERR(xdna, "Invalid buffer size. Given Size: %u. Need Size: %u.",
-			 status.buffer_size, ndev->metadata.cols * ndev->metadata.size);
-		return -EINVAL;
-	}
-
 	ret = aie2_query_status(ndev, u64_to_user_ptr(status.buffer),
 				status.buffer_size, &status.cols_filled);
 	if (ret) {
@@ -644,7 +640,7 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
 		return ret;
 	}
 
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &status, sizeof(status))) {
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &status, buf_sz)) {
 		XDNA_ERR(xdna, "Failed to copy AIE request info to user space");
 		return -EFAULT;
 	}
@@ -659,6 +655,7 @@ static int aie2_get_aie_metadata(struct amdxdna_client *client,
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev;
 	int ret = 0;
+	u32 buf_sz;
 
 	ndev = xdna->dev_handle;
 	meta = kzalloc_obj(*meta);
@@ -690,7 +687,8 @@ static int aie2_get_aie_metadata(struct amdxdna_client *client,
 	meta->shim.lock_count = ndev->metadata.shim.lock_count;
 	meta->shim.event_reg_count = ndev->metadata.shim.event_reg_count;
 
-	if (copy_to_user(u64_to_user_ptr(args->buffer), meta, sizeof(*meta)))
+	buf_sz = min(args->buffer_size, sizeof(*meta));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
 		ret = -EFAULT;
 
 	kfree(meta);
@@ -703,12 +701,14 @@ static int aie2_get_aie_version(struct amdxdna_client *client,
 	struct amdxdna_drm_query_aie_version version;
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev;
+	u32 buf_sz;
 
 	ndev = xdna->dev_handle;
 	version.major = ndev->version.major;
 	version.minor = ndev->version.minor;
 
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, sizeof(version)))
+	buf_sz = min(args->buffer_size, sizeof(version));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
 		return -EFAULT;
 
 	return 0;
@@ -719,13 +719,15 @@ static int aie2_get_firmware_version(struct amdxdna_client *client,
 {
 	struct amdxdna_drm_query_firmware_version version;
 	struct amdxdna_dev *xdna = client->xdna;
+	u32 buf_sz;
 
 	version.major = xdna->fw_ver.major;
 	version.minor = xdna->fw_ver.minor;
 	version.patch = xdna->fw_ver.sub;
 	version.build = xdna->fw_ver.build;
 
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, sizeof(version)))
+	buf_sz = min(args->buffer_size, sizeof(version));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
 		return -EFAULT;
 
 	return 0;
@@ -737,11 +739,13 @@ static int aie2_get_power_mode(struct amdxdna_client *client,
 	struct amdxdna_drm_get_power_mode mode = {};
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev;
+	u32 buf_sz;
 
 	ndev = xdna->dev_handle;
 	mode.power_mode = ndev->pw_mode;
 
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, sizeof(mode)))
+	buf_sz = min(args->buffer_size, sizeof(mode));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, buf_sz))
 		return -EFAULT;
 
 	return 0;
@@ -754,6 +758,7 @@ static int aie2_get_clock_metadata(struct amdxdna_client *client,
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev;
 	int ret = 0;
+	u32 buf_sz;
 
 	ndev = xdna->dev_handle;
 	clock = kzalloc_obj(*clock);
@@ -766,7 +771,8 @@ static int aie2_get_clock_metadata(struct amdxdna_client *client,
 	snprintf(clock->h_clock.name, sizeof(clock->h_clock.name), "H Clock");
 	clock->h_clock.freq_mhz = ndev->hclk_freq;
 
-	if (copy_to_user(u64_to_user_ptr(args->buffer), clock, sizeof(*clock)))
+	buf_sz = min(args->buffer_size, sizeof(*clock));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), clock, buf_sz))
 		ret = -EFAULT;
 
 	kfree(clock);
@@ -792,12 +798,14 @@ static int aie2_get_sensors(struct amdxdna_client *client,
 	scnprintf(sensor.label, sizeof(sensor.label), "Total Power");
 	scnprintf(sensor.units, sizeof(sensor.units), "mW");
 
+	if (args->buffer_size < sizeof(sensor))
+		goto out;
+
 	if (copy_to_user(u64_to_user_ptr(args->buffer), &sensor, sizeof(sensor)))
 		return -EFAULT;
 
+	args->buffer_size -= sizeof(sensor);
 	sensors_count++;
-	if (args->buffer_size <= sensors_count * sizeof(sensor))
-		goto out;
 
 	for (i = 0; i < min_t(u32, ndev->total_col, 8); i++) {
 		memset(&sensor, 0, sizeof(sensor));
@@ -807,13 +815,15 @@ static int aie2_get_sensors(struct amdxdna_client *client,
 		scnprintf(sensor.label, sizeof(sensor.label), "Column %d Utilization", i);
 		scnprintf(sensor.units, sizeof(sensor.units), "%%");
 
+		if (args->buffer_size < sizeof(sensor))
+			goto out;
+
 		if (copy_to_user(u64_to_user_ptr(args->buffer) + sensors_count * sizeof(sensor),
 				 &sensor, sizeof(sensor)))
 			return -EFAULT;
 
+		args->buffer_size -= sizeof(sensor);
 		sensors_count++;
-		if (args->buffer_size <= sensors_count * sizeof(sensor))
-			goto out;
 	}
 
 out:
@@ -909,6 +919,7 @@ static int aie2_query_resource_info(struct amdxdna_client *client,
 	const struct amdxdna_dev_priv *priv;
 	struct amdxdna_dev_hdl *ndev;
 	struct amdxdna_dev *xdna;
+	u32 buf_sz;
 
 	xdna = client->xdna;
 	ndev = xdna->dev_handle;
@@ -920,7 +931,8 @@ static int aie2_query_resource_info(struct amdxdna_client *client,
 	res_info.npu_tops_curr = ndev->curr_tops;
 	res_info.npu_task_curr = ndev->hwctx_num;
 
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &res_info, sizeof(res_info)))
+	buf_sz = min(args->buffer_size, sizeof(res_info));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &res_info, buf_sz))
 		return -EFAULT;
 
 	return 0;
@@ -956,12 +968,7 @@ static int aie2_get_telemetry(struct amdxdna_client *client,
 		XDNA_ERR(xdna, "Invalid buffer size");
 		return -EINVAL;
 	}
-
 	telemetry_data_sz = args->buffer_size - header_sz;
-	if (telemetry_data_sz > SZ_4M) {
-		XDNA_ERR(xdna, "Buffer size is too big, %d", telemetry_data_sz);
-		return -EINVAL;
-	}
 
 	header = kzalloc(header_sz, GFP_KERNEL);
 	if (!header)
@@ -1002,6 +1009,7 @@ static int aie2_get_preempt_state(struct amdxdna_client *client,
 	struct amdxdna_drm_attribute_state state = {};
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev;
+	u32 buf_sz;
 
 	ndev = xdna->dev_handle;
 	if (args->param == DRM_AMDXDNA_GET_FORCE_PREEMPT_STATE)
@@ -1009,7 +1017,8 @@ static int aie2_get_preempt_state(struct amdxdna_client *client,
 	else if (args->param == DRM_AMDXDNA_GET_FRAME_BOUNDARY_PREEMPT_STATE)
 		state.state = ndev->frame_boundary_preempt;
 
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &state, sizeof(state)))
+	buf_sz = min(args->buffer_size, sizeof(state));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &state, buf_sz))
 		return -EFAULT;
 
 	return 0;
-- 
2.34.1

