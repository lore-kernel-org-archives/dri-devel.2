Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA8ACD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEB410E1E7;
	Wed,  6 May 2026 16:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fx5tkXoy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1886B10E1E7
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 16:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6OKl7PVBOVy4tF6jvsbzovso6pmLWPIcVZ9jhVFgdwQxCdnyJk7ykFLj+4zvBKnGdqoYmS5O0JfoLbZwhB35oXojtXe1ZS40OIvduQfqGphMZXpg9d3lN1AGPDBfnkdaVHdATzuu73KOm8hcOmPYprinFEh32m9YDi8QkhHtHKYCV6KMvcCJt5SHUd8KYTTQp7QgDxOigjDQ8c6K4wZ3XL/CYNw+xJorNYLRCexA+yMletK+rkPy+cRCift4deR+VvvgOPG2krD+ypbUwoswIAZJiv/5fATuB0Q+jQ1HCbUqJRSBM5QZcYaqAatrAEHl6Su57smRGcqxUiCZpzVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shCzsizNq6WHJR1Hb3ockdLFQn3LzPu/Elqm+JkGViM=;
 b=YFfvCexm1egN6eGLe7fYr9LTYfiScQLFdrFsIZxGRmmAeOoj/MUr+vFrTkCWdTs5A6hVTbtjHgOwZAfX8MSBZfTqsddY+VWYXxjU7ZLdAN/2Jk/ZzQ8nXeb14y+Xs36oRaTvBYuZHlX+AIR+HJlV6ZvJtpF31XeFTI/4qWOFlFIcSCoe2maMIGh2A+oMK+Aqw8vI3//lKD8DZSgxqLBrpDz2FTkblNmx1YwEsrpEmCgeroIsi7ahiJq76VXdDHbGoHQ1pOYCnBwUiicVwEsb9A6XMI9HYZgbqiiPEyxp1QqjBRekgiU3NIqp/ifIZueMXWcgaO5VHTVLqSzUYaHx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shCzsizNq6WHJR1Hb3ockdLFQn3LzPu/Elqm+JkGViM=;
 b=fx5tkXoy0SviZNZupRXnOuRrYc/Z5WsVXF56QzawgWr1QSAhRyLmf675OX8DRRi7VC9nE/suoVYaRthCgxfN+mtrHaqtZc5ZIGtujMxXiRYXf9a8b6InPLmkGnZ32gcTqvlK9gzWFjtxFgBS8qJs4eCISws8pHlYXSro30TPBOY=
Received: from CY8PR12CA0014.namprd12.prod.outlook.com (2603:10b6:930:4e::16)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:17:00 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:930:4e:cafe::d2) by CY8PR12CA0014.outlook.office365.com
 (2603:10b6:930:4e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Wed,
 6 May 2026 16:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 16:16:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 11:16:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 11:16:59 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 11:16:58 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V2 5/6] accel/amdxdna: Add AIE4 metadata query support
Date: Wed, 6 May 2026 09:16:42 -0700
Message-ID: <20260506161642.141257-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b257b5-a6d6-489d-c88a-08deab8ae6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qSB3DJwBKft+lBSx1md45H0+fLJr8rQhT3CkwUoYx+Uwf1URTKVgla67R7ipfYZiaFgGNNYHYJpthj5BURGxUyyyQjFiVKbwjD267z297/uvhzmw1YhnQt/h0sAqQCPnsEHYO0SK5k8A+/z6srKLaaB+822C7c2+hWnfLQnFkyAwGquuUAwxH7pkxjOK/6gI2nPbxtrQZvJZRMr/6GT0U4YmoLJE+mFMrJyEeXkWIKwwKq6oFeeLbST/K73xlejmKohbkWJyx8olCVaHSJF+nSZxIKd/atVgvjREncsc5Rf0ehJzrY8Cy/m3FJOVqp62Irqe1FcMO0aWADdXKDNNS/fXboSjhlnGi4YMLridtqpdpCfj2oFgHpHMVkfMqVHkhZq24z4aGHXwn/IhhrtAfqSo2pCUnByDLXwkUMy6Nk+ir4rnlGs330kgAxj+CZj/0CismLNU9YCn4YGiE7rU5e+gwF6w9xYDp9+wnrW4b3pcY+OZ8lxYES8Ng4YT2r02/tk5k8JQU0RCa4xQnUTAFdJ1vDnOXqZ19KArTHDPYo67WqEfXj/PDXYLdwq2U3s/PIHy/PrXOoFdl9ZdxQE3oUi1wjXYTwqO0rIx1KWyeMYHOucEpD8ErHcSRH6cLB2kkNf+EYuv9KOdFKLqd92sg123LiwTN1gkQuZE+5+rCiKHIbCv3TDGt4gWP7kPlyW6HaBX5Ixvxu7DnSfornoLnVvCTJxHXIu4W4Kdicg2yhQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 71CQKOigcv+NEwwQptq4YbFEnSpS3V51HRp0EZza1fEiJra42wmRR8Dkg4OLtS/85T16gV4usQU277KnEEbUo1Yfn7mvDaZhInVg3+BVvL7Mg171rKUmiC7wzAb0kGgXjSP93kcT6rt/t6KqkbLkPQeNI7kROwCohl8RkOTwME0AwSBkt+BZpX+GNG+cycTEKknpmL69xfQtEEDFPN8XL6yHeE5oD9bnK0vLgNQZrYzyGy4Kzpk5lt2nmf1xsb5wBwlFlCXViblohO88EHPGPsD18BPZnsrg7lKOy5MNdE2OmSqnFr5D0AxWdnbhMwPmr7cFEMTvOzA8p+TJz5chEOT1eG6E6vVOqZCjEOP5hZLZHl6gk0R0hAq6QXp5dEqsAu7fixBWzJogxygI3EAR8+RjZ6+7lRj2P4wB5wsQBkxmU/zgzCHkpUzLVHbO38sx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:16:59.9026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b257b5-a6d6-489d-c88a-08deab8ae6d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
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

From: David Zhang <yidong.zhang@amd.com>

Add support for querying device metadata on AIE4 via a mailbox message.
Refactor aie2_get_aie_metadata() into a common helper by moving it to
aie.c and renaming it to amdxdna_get_metadata(), allowing both AIE2
and AIE4 to reuse the implementation.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie.c           | 14 +++++++
 drivers/accel/amdxdna/aie.h           |  5 +++
 drivers/accel/amdxdna/aie2_ctx.c      |  4 +-
 drivers/accel/amdxdna/aie2_message.c  | 10 +++--
 drivers/accel/amdxdna/aie2_pci.c      | 54 ++-------------------------
 drivers/accel/amdxdna/aie2_pci.h      | 32 +++-------------
 drivers/accel/amdxdna/aie4_message.c  | 38 +++++++++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h | 34 +++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.c      | 30 +++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |  2 +
 10 files changed, 140 insertions(+), 83 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
index 66849ba9026a..94747fb72340 100644
--- a/drivers/accel/amdxdna/aie.c
+++ b/drivers/accel/amdxdna/aie.c
@@ -117,3 +117,17 @@ void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
 
 	amdxdna_update_vbnv(xdna, info->rev_vbnv_tbl, rev);
 }
+
+int amdxdna_get_metadata(struct aie_device *aie,
+			 struct amdxdna_client *client,
+			 struct amdxdna_drm_get_info *args)
+{
+	int ret = 0;
+	u32 buf_sz;
+
+	buf_sz = min(args->buffer_size, sizeof(aie->metadata));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &aie->metadata, buf_sz))
+		ret = -EFAULT;
+
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 7a68b114f235..cca0cfdeee1a 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -5,6 +5,7 @@
 #ifndef _AIE_H_
 #define _AIE_H_
 
+#include <drm/amdxdna_accel.h>
 #include "amdxdna_pci_drv.h"
 #include "amdxdna_mailbox.h"
 
@@ -26,6 +27,8 @@ struct aie_device {
 
 	struct psp_device *psp_hdl;
 	struct smu_device *smu_hdl;
+
+	struct amdxdna_drm_query_aie_metadata metadata;
 };
 
 #define DECLARE_AIE_MSG(name, op) \
@@ -94,6 +97,8 @@ void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
 int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
 int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
 void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
+int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
+			 struct amdxdna_drm_get_info *args);
 
 /* aie_psp.c */
 struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 139825ac8515..7d6094aefb6f 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -489,12 +489,12 @@ static int aie2_hwctx_col_list(struct amdxdna_hwctx *hwctx)
 	}
 
 	ndev = xdna->dev_handle;
-	if (unlikely(!ndev->metadata.core.row_count)) {
+	if (unlikely(!ndev->aie.metadata.core.row_count)) {
 		XDNA_WARN(xdna, "Core tile row count is zero");
 		return -EINVAL;
 	}
 
-	hwctx->num_col = hwctx->num_tiles / ndev->metadata.core.row_count;
+	hwctx->num_col = hwctx->num_tiles / ndev->aie.metadata.core.row_count;
 	if (!hwctx->num_col || hwctx->num_col > ndev->total_col) {
 		XDNA_ERR(xdna, "Invalid num_col %d", hwctx->num_col);
 		return -EINVAL;
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index 6e98af7b74db..bbe701ad5574 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -127,7 +127,8 @@ int aie2_assign_mgmt_pasid(struct amdxdna_dev_hdl *ndev, u16 pasid)
 	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 }
 
-int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *version)
+int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev,
+			   struct amdxdna_drm_query_aie_version *version)
 {
 	DECLARE_AIE_MSG(aie_version_info, MSG_OP_QUERY_AIE_VERSION);
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
@@ -146,7 +147,8 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *ver
 	return 0;
 }
 
-int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata)
+int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
+			    struct amdxdna_drm_query_aie_metadata *metadata)
 {
 	DECLARE_AIE_MSG(aie_tile_info, MSG_OP_QUERY_AIE_TILE_INFO);
 	int ret;
@@ -155,7 +157,7 @@ int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *m
 	if (ret)
 		return ret;
 
-	metadata->size = resp.info.size;
+	metadata->col_size = resp.info.size;
 	metadata->cols = resp.info.cols;
 	metadata->rows = resp.info.rows;
 
@@ -375,7 +377,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 	u8 *buff_addr;
 	int ret;
 
-	buf_sz = ndev->metadata.cols * ndev->metadata.size;
+	buf_sz = ndev->aie.metadata.cols * ndev->aie.metadata.col_size;
 	buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
 	if (IS_ERR(buff_addr))
 		return PTR_ERR(buff_addr);
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index f0ddb843eb21..6c8a0f70b73d 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -219,13 +219,13 @@ static int aie2_mgmt_fw_query(struct amdxdna_dev_hdl *ndev)
 		return ret;
 	}
 
-	ret = aie2_query_aie_metadata(ndev, &ndev->metadata);
+	ret = aie2_query_aie_metadata(ndev, &ndev->aie.metadata);
 	if (ret) {
 		XDNA_ERR(ndev->aie.xdna, "Query AIE metadata failed");
 		return ret;
 	}
 
-	ndev->total_col = min(aie2_max_col, ndev->metadata.cols);
+	ndev->total_col = min(aie2_max_col, ndev->aie.metadata.cols);
 
 	return 0;
 }
@@ -658,53 +658,6 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
 	return 0;
 }
 
-static int aie2_get_aie_metadata(struct amdxdna_client *client,
-				 struct amdxdna_drm_get_info *args)
-{
-	struct amdxdna_drm_query_aie_metadata *meta;
-	struct amdxdna_dev *xdna = client->xdna;
-	struct amdxdna_dev_hdl *ndev;
-	int ret = 0;
-	u32 buf_sz;
-
-	ndev = xdna->dev_handle;
-	meta = kzalloc_obj(*meta);
-	if (!meta)
-		return -ENOMEM;
-
-	meta->col_size = ndev->metadata.size;
-	meta->cols = ndev->metadata.cols;
-	meta->rows = ndev->metadata.rows;
-
-	meta->version.major = ndev->metadata.version.major;
-	meta->version.minor = ndev->metadata.version.minor;
-
-	meta->core.row_count = ndev->metadata.core.row_count;
-	meta->core.row_start = ndev->metadata.core.row_start;
-	meta->core.dma_channel_count = ndev->metadata.core.dma_channel_count;
-	meta->core.lock_count = ndev->metadata.core.lock_count;
-	meta->core.event_reg_count = ndev->metadata.core.event_reg_count;
-
-	meta->mem.row_count = ndev->metadata.mem.row_count;
-	meta->mem.row_start = ndev->metadata.mem.row_start;
-	meta->mem.dma_channel_count = ndev->metadata.mem.dma_channel_count;
-	meta->mem.lock_count = ndev->metadata.mem.lock_count;
-	meta->mem.event_reg_count = ndev->metadata.mem.event_reg_count;
-
-	meta->shim.row_count = ndev->metadata.shim.row_count;
-	meta->shim.row_start = ndev->metadata.shim.row_start;
-	meta->shim.dma_channel_count = ndev->metadata.shim.dma_channel_count;
-	meta->shim.lock_count = ndev->metadata.shim.lock_count;
-	meta->shim.event_reg_count = ndev->metadata.shim.event_reg_count;
-
-	buf_sz = min(args->buffer_size, sizeof(*meta));
-	if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
-		ret = -EFAULT;
-
-	kfree(meta);
-	return ret;
-}
-
 static int aie2_get_aie_version(struct amdxdna_client *client,
 				struct amdxdna_drm_get_info *args)
 {
@@ -1039,6 +992,7 @@ static int aie2_get_preempt_state(struct amdxdna_client *client,
 static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
 {
 	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 	int ret, idx;
 
 	if (!drm_dev_enter(&xdna->ddev, &idx))
@@ -1053,7 +1007,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 		ret = aie2_get_aie_status(client, args);
 		break;
 	case DRM_AMDXDNA_QUERY_AIE_METADATA:
-		ret = aie2_get_aie_metadata(client, args);
+		ret = amdxdna_get_metadata(&ndev->aie, client, args);
 		break;
 	case DRM_AMDXDNA_QUERY_AIE_VERSION:
 		ret = aie2_get_aie_version(client, args);
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index f12073175676..fe51d516a358 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -77,29 +77,6 @@ struct amdxdna_fw_ver;
 struct amdxdna_hwctx;
 struct amdxdna_sched_job;
 
-struct aie_version {
-	u16 major;
-	u16 minor;
-};
-
-struct aie_tile_metadata {
-	u16 row_count;
-	u16 row_start;
-	u16 dma_channel_count;
-	u16 lock_count;
-	u16 event_reg_count;
-};
-
-struct aie_metadata {
-	u32 size;
-	u16 cols;
-	u16 rows;
-	struct aie_version version;
-	struct aie_tile_metadata core;
-	struct aie_tile_metadata mem;
-	struct aie_tile_metadata shim;
-};
-
 enum rt_config_category {
 	AIE2_RT_CFG_INIT,
 	AIE2_RT_CFG_CLK_GATING,
@@ -177,8 +154,7 @@ struct amdxdna_dev_hdl {
 	void			__iomem *mbox_base;
 
 	u32				total_col;
-	struct aie_version		version;
-	struct aie_metadata		metadata;
+	struct amdxdna_drm_query_aie_version version;
 	struct aie2_exec_msg_ops	*exec_msg_ops;
 
 	/* power management and clock*/
@@ -283,8 +259,10 @@ int aie2_resume_fw(struct amdxdna_dev_hdl *ndev);
 int aie2_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type, u64 value);
 int aie2_get_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type, u64 *value);
 int aie2_assign_mgmt_pasid(struct amdxdna_dev_hdl *ndev, u16 pasid);
-int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *version);
-int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata);
+int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev,
+			   struct amdxdna_drm_query_aie_version *version);
+int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
+			    struct amdxdna_drm_query_aie_metadata *metadata);
 int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
 				struct amdxdna_fw_ver *fw_ver);
 int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index d621dd32ac40..8d19af2a186f 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -25,3 +25,41 @@ int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev)
 
 	return ret;
 }
+
+int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
+			    struct amdxdna_drm_query_aie_metadata *metadata)
+{
+	DECLARE_AIE_MSG(aie4_msg_aie4_tile_info, AIE4_MSG_OP_AIE_TILE_INFO);
+	int ret;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		return ret;
+
+	metadata->col_size = resp.info.size;
+	metadata->cols = resp.info.cols;
+	metadata->rows = resp.info.rows;
+
+	metadata->version.major = resp.info.major;
+	metadata->version.minor = resp.info.minor;
+
+	metadata->core.row_count = resp.info.core_rows;
+	metadata->core.row_start = resp.info.core_row_start;
+	metadata->core.dma_channel_count = resp.info.core_dma_channels;
+	metadata->core.lock_count = resp.info.core_locks;
+	metadata->core.event_reg_count = resp.info.core_events;
+
+	metadata->mem.row_count = resp.info.mem_rows;
+	metadata->mem.row_start = resp.info.mem_row_start;
+	metadata->mem.dma_channel_count = resp.info.mem_dma_channels;
+	metadata->mem.lock_count = resp.info.mem_locks;
+	metadata->mem.event_reg_count = resp.info.mem_events;
+
+	metadata->shim.row_count = resp.info.shim_rows;
+	metadata->shim.row_start = resp.info.shim_row_start;
+	metadata->shim.dma_channel_count = resp.info.shim_dma_channels;
+	metadata->shim.lock_count = resp.info.shim_locks;
+	metadata->shim.event_reg_count = resp.info.shim_events;
+
+	return 0;
+}
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index 7faa01ca3436..69e220e40900 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -18,6 +18,7 @@ enum aie4_msg_opcode {
 	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
 	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
 	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
+	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
 };
 
 enum aie4_msg_status {
@@ -96,4 +97,37 @@ struct aie4_msg_destroy_hw_context_resp {
 	enum aie4_msg_status status;
 } __packed;
 
+struct aie4_tile_info {
+	__u32 size;
+	__u16 major;
+	__u16 minor;
+	__u16 cols;
+	__u16 rows;
+	__u16 core_rows;
+	__u16 mem_rows;
+	__u16 shim_rows;
+	__u16 core_row_start;
+	__u16 mem_row_start;
+	__u16 shim_row_start;
+	__u16 core_dma_channels;
+	__u16 mem_dma_channels;
+	__u16 shim_dma_channels;
+	__u16 core_locks;
+	__u16 mem_locks;
+	__u16 shim_locks;
+	__u16 core_events;
+	__u16 mem_events;
+	__u16 shim_events;
+	__u16 resvd;
+} __packed;
+
+struct aie4_msg_aie4_tile_info_req {
+	__u32 resvd;
+} __packed;
+
+struct aie4_msg_aie4_tile_info_resp {
+	enum aie4_msg_status status;
+	struct aie4_tile_info info;
+} __packed;
+
 #endif /* _AIE4_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 9ff34ce57fcb..8b5eff0e45c1 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -269,6 +269,11 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
 		XDNA_ERR(xdna, "partition fini failed: %d", ret);
 }
 
+static int aie4_query(struct amdxdna_dev_hdl *ndev)
+{
+	return aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
+}
+
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
@@ -308,6 +313,10 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		return ret;
 
+	ret = aie4_query(ndev);
+	if (ret)
+		goto mailbox_fini;
+
 	ret = aie4_partition_init(ndev);
 	if (ret)
 		goto mailbox_fini;
@@ -535,6 +544,26 @@ static int aie4_doorbell_mmap(struct amdxdna_client *client, struct vm_area_stru
 	return ret;
 }
 
+static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
+{
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	int ret;
+
+	switch (args->param) {
+	case DRM_AMDXDNA_QUERY_AIE_METADATA:
+		ret = amdxdna_get_metadata(&ndev->aie, client, args);
+		break;
+	default:
+		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
+		ret = -EOPNOTSUPP;
+	}
+
+	XDNA_DBG(xdna, "Got param %d", args->param);
+
+	return ret;
+}
+
 static int aie4_pf_init(struct amdxdna_dev *xdna)
 {
 	int ret;
@@ -581,4 +610,5 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.mmap			= aie4_doorbell_mmap,
 	.cmd_wait		= aie4_cmd_wait,
+	.get_aie_info		= aie4_get_info,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index b69489acd53d..64a1955cab9a 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -56,6 +56,8 @@ struct amdxdna_dev_hdl {
 };
 
 /* aie4_message.c */
+int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
+			    struct amdxdna_drm_query_aie_metadata *metadata);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 
 /* aie4_ctx.c */
-- 
2.34.1

