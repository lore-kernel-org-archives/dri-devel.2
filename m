Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C872606AEDF
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PdBZM30n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F172D10EF2B;
	Mon, 19 Oct 2026 16:48:49 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC8910EF57
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MktJ3ZVDzAGoFYcf5ekHFjxBw60CHFbgkc/Iya0cpGzzOHiWYow1MgynFDTJy2tDH5nCNV7zJ1oD3oSK1qGl/RuGJMH9A0yYFOVJvZH0jgSXllWeAaCDLsPbsCO9cJkzY57GLXvwD+vlDn5uGgA8/HG16xYD+uLgzs+iOd19LFaKz/qsZuQC2WTQXgSmTwLhpRD1173Nbb9vZ2/TkYEs3Gau49R4wt4WsX2U49NcKapncrIVO6gF/1ZD7jopbMq4WV52ZfKLj+B3JVFRiTPuZTZUoX8NtgeW0C4C8/OjaYe8lX3QyiFQ7XAdatsFMAdX+yDKm7qOZn/x1uExP0Ir6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLXGRQwswZnb1Kd19TJE9kYAj2HrIj+AJnZcASUxK1M=;
 b=UwmdlJZ7iPRGrUHooKUMlbN6MfRqyXmgZH+0ZryYn4dhkYt5uHQWw44VbLRc0A6UPxHjRvOaHhnNqqeE0xT05s3nX7KZzrBcMtzbtvBwKm4Eahw0Iqm6IUbYxABJrKwGf0OgfzIsoCpqiOA6R1VEhQ4Lh7GLmqVlpaPup17f+sSUjQhAEz3gQ5XglLF3UjJ56yyaheXcndsMr8s8geBEOVlh6a0zGt8Z+gMbB3HYDT5BAMek8q+y0lMYNrhsvyXFNwsg/ZsbEDnBbl4cJqPzRvcns26+E5bXSOEa+J4Y/L9PKHYm3tmHSCUJBo8waX2jGSQnHBp+h9bvdlyn9wtV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLXGRQwswZnb1Kd19TJE9kYAj2HrIj+AJnZcASUxK1M=;
 b=PdBZM30nUmiqA9RLpMx93uk3CBNSFsXcUoBlaFjXPpS4umbt+ynUEDeauEUOMFnLWA2AiXSEuK5qP08XQ6KCiWen2G2tq7e+tCaJYZm/2YCyabqFamXFIquyNWKPAprJUaDmeBLkCysRzQAZrKCkKw5+pFhTIbZKTXNrOPXeVFc=
Received: from PH7P220CA0122.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::28)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:48:14 +0000
Received: from PH1PEPF00062F27.namprd02.prod.outlook.com
 (2603:10b6:510:327:cafe::45) by PH7P220CA0122.outlook.office365.com
 (2603:10b6:510:327::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 16:48:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F27.mail.protection.outlook.com (10.167.243.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:48:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:52 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:51 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V5 12/19] accel/amdxdna: Implement AIE4 kernel queue lifecycle
 and memory layout
Date: Mon, 19 Oct 2026 09:47:39 -0700
Message-ID: <20261019164746.827277-13-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019164746.827277-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261019164746.827277-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F27:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed52ab1-c059-43f5-941a-08df2e00c3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yYmggEGCPDFallav9ecbITOqehhdi4/IqKG3jJt5dmXiRRZD4fNZCS2HEuRQ/TNjlw7wRZpwyF6Qf8IcxzLDjmUT3Un9mdSwrwu8SsDP+Ngq1pAD8enVI84ksw6iZRO0QD1KqVEail3w4/UH90+XRJRNplRejiUQ+pBFLKRdMBJFYAbRj2sfjuwN6yKXE4eqkbqBVDJKqH1pAtj/J8pXZhQKNSJz0sB+XGw8t079MuXbgtiaQqkNahySA/Mzjq22Z3fBCIKPXKxGQXi6UBvwJmARBlTNYx74EOt0GehHVi48uadVjerv6zEdE8AqxFAcN6nPUUZKWGkVKP5PHXFupUbWvvJSY9JrRGxX4o/8cWww+znDaOo1mnl75z/MlC9W8T/xpWNMGW4Ja1p2sLFIeCLHBu0cWg8CNGOEaeK85YB1Ckmpombee2fq+6OMkYFOEdeZgtt23jGP6XHEun/kyUs2wTq6yePayBRW4Ao8vtzMAWS25rYM0AuahnFhL6l5NYhJZvE68OyrhSDSxO74xkW2+hYywQ6Es3wkgEX+xDQdmR5ckT6peNv4njbh3s3d8JoS/vCqSsHmrUSSXNCS3z0ZO9OhYclFdc5z14ytm2TbvPyK/fwKYtQmwlZ7P1MzJU7v75K5K92yYJYhYadEGaFUs8koIzue16PWW8ZGvFjoDBX9+F33mkU38sTv/pqnXh6M7Qa91XxwMKQ5N7xHqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: arOjvoSCKygYJ2NcmeE64vQhIWKixb+M5TfOa0//8Ig9Me7RMzm9Ah8l19ZvFBHn/ia0EmGXH2HffBCXfO4/uqFlRaA0W8h6g9pg2JXuzFzsBBoNg3SgCURMlHWHFNPDpQzvyN88zWO/gVCykXXOlDV8G//cWT87uNLDtKwUI1HYo35pBriBaTYO5ug/AIWqioxR7PmH5BRc5FGqPvJKegVhGI7ytaCrgLgdRm8FTVPr8L4g+ro0J5rALhfFNuchBATt4nczFvq5ZQf6NsFv9dDahPU626DLGm1YRx/W/bAv2UN9uTKofaq7d9yy5vdPvXIAM7o/B7uT/TrgOFDISLGWObyPB82VQxUNFLfSF3ikm1NQSioelxcmN6qeHLUf9wbo8nYp16Yltw8Cj6Hv6O0++awzvnfb+hWVojQMh4TMbV2cE3LJliJibQZAJ3W9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:48:13.1899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed52ab1-c059-43f5-941a-08df2e00c3fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F27.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Initialize kernel-mode submission required buffers, workqueue, and
hardware contexts:
- Update queue definition that is being used to send requests.
- Add job workqueue for pending and running jobs.
- Add mutex protection for each io.
- Initialize queue with direct and indirect packet, format queue header.
- Add kernel-mode submission required steps in hwctx create/destroy.
- Add aie4_get_cert_comp() to safely acquire a reference to the
  per-hwctx completion tracker under io_lock in aie4_cmd_wait() before
  waiting on the queue, preventing race conditions with
  aie4_hwctx_destroy().

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Co-developed-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        | 198 ++++++++++++++++++++----
 drivers/accel/amdxdna/aie4_host_queue.h |  65 ++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  40 +++++
 3 files changed, 270 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 20b725de6ab7..767ba6ecbfc6 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -22,6 +22,13 @@
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
 
+#define CTX_INVALID_ID			(~0U)
+#define CTX_INVALID_DOORBELL		AMDXDNA_INVALID_DOORBELL_OFFSET
+
+static void job_worker(struct work_struct *work)
+{
+}
+
 static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32 msix_idx)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
@@ -37,8 +44,10 @@ static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32
 	}
 
 	cert_comp = kzalloc_obj(*cert_comp);
-	if (!cert_comp)
+	if (!cert_comp) {
+		ret = -ENOMEM;
 		goto unlock;
+	}
 
 	cert_comp->ndev = ndev;
 	cert_comp->msix_idx = msix_idx;
@@ -68,7 +77,7 @@ static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32
 	kfree(cert_comp);
 unlock:
 	mutex_unlock(&ndev->cert_comp_lock);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static void cert_comp_release(struct kref *kref)
@@ -76,8 +85,6 @@ static void cert_comp_release(struct kref *kref)
 	struct cert_comp *cert_comp = container_of(kref, struct cert_comp, kref);
 	struct amdxdna_dev_hdl *ndev = cert_comp->ndev;
 
-	drm_WARN_ON(&ndev->aie.xdna->ddev, !mutex_is_locked(&ndev->cert_comp_lock));
-
 	xa_erase(&ndev->cert_comp_xa, cert_comp->msix_idx);
 	aie4_free_notification(cert_comp);
 	kfree(cert_comp);
@@ -85,20 +92,41 @@ static void cert_comp_release(struct kref *kref)
 
 static void aie4_put_cert_comp(struct cert_comp *cert_comp)
 {
-	struct amdxdna_dev_hdl *ndev;
+	struct amdxdna_dev_hdl *ndev = cert_comp->ndev;
 
-	ndev = cert_comp->ndev;
 	guard(mutex)(&ndev->cert_comp_lock);
 
 	kref_put(&cert_comp->kref, cert_comp_release);
 }
 
-static int aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context_id)
+static struct cert_comp *aie4_get_cert_comp(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct cert_comp *cert_comp;
+
+	/* Take io_lock to serialize against cert_comp link/unlink. */
+	guard(mutex)(&priv->io_lock);
+
+	cert_comp = READ_ONCE(priv->cert_comp);
+	if (cert_comp)
+		kref_get(&cert_comp->kref);
+
+	return cert_comp;
+}
+
+static void aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context_id)
 {
 	DECLARE_AIE_MSG(aie4_msg_destroy_hw_context, AIE4_MSG_OP_DESTROY_HW_CONTEXT);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	if (hw_context_id == CTX_INVALID_ID)
+		return;
 
 	req.hw_context_id = hw_context_id;
-	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_WARN(xdna, "destroy ctx id %d failed %d", hw_context_id, ret);
 }
 
 static u8 aie4_parse_priority_to_dev(u32 priority)
@@ -117,19 +145,20 @@ static u8 aie4_parse_priority_to_dev(u32 priority)
 	}
 }
 
-static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
+int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 {
 	DECLARE_AIE_MSG(aie4_msg_create_hw_context, AIE4_MSG_OP_CREATE_HW_CONTEXT);
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_hwctx_priv *priv = hwctx->priv;
-	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct cert_comp *cert_comp;
 	int ret;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
 	if (!ndev->partition_id || !hwctx->num_tiles) {
-		XDNA_ERR(xdna, "invalid request partition_id %d, num_tiles %d",
+		XDNA_ERR(xdna, "invalid request partition_id %u, num_tiles %d",
 			 ndev->partition_id, hwctx->num_tiles);
 		return -EINVAL;
 	}
@@ -139,7 +168,6 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	req.pasid = aie4_msg_pasid(client);
 	req.pasid = req.pasid == IOMMU_PASID_INVALID ? 0 : req.pasid;
 	req.priority_band = aie4_parse_priority_to_dev(hwctx->qos.priority);
-
 	req.hsa_addr_high = upper_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
 	req.hsa_addr_low = lower_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
 
@@ -153,72 +181,142 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	}
 
 	XDNA_DBG(xdna, "resp msix: %d, ctx id: %d, doorbell: %d",
-		 resp.job_complete_msix_idx,
-		 resp.hw_context_id,
+		 resp.job_complete_msix_idx, resp.hw_context_id,
 		 resp.doorbell_offset);
 
 	/* setup interrupt completion per msix index */
-	priv->cert_comp = aie4_lookup_cert_comp(ndev, resp.job_complete_msix_idx);
-	if (!priv->cert_comp) {
+	cert_comp = aie4_lookup_cert_comp(ndev, resp.job_complete_msix_idx);
+	if (IS_ERR(cert_comp)) {
 		aie4_msg_destroy_context(ndev, resp.hw_context_id);
-		return -EINVAL;
+		return PTR_ERR(cert_comp);
 	}
 
 	priv->hw_ctx_id = resp.hw_context_id;
-	hwctx->doorbell_offset = AMDXDNA_INVALID_DOORBELL_OFFSET;
+
+	hwctx->fw_ctx_id = resp.hw_context_id;
+	hwctx->start_col = 0;
+	hwctx->num_col = ndev->total_col;
+
+	/* Set up driver doorbell and return invalid offset to userspace. */
+	mutex_lock(&priv->io_lock);
+	ret = aie4_doorbell_setup(hwctx, &resp);
+	if (ret) {
+		mutex_unlock(&priv->io_lock);
+		aie4_msg_destroy_context(ndev, resp.hw_context_id);
+		aie4_put_cert_comp(cert_comp);
+		priv->hw_ctx_id = CTX_INVALID_ID;
+		hwctx->fw_ctx_id = -1;
+		return ret;
+	}
+	WRITE_ONCE(priv->cert_comp, cert_comp);
+	mutex_unlock(&priv->io_lock);
+	hwctx->doorbell_offset = CTX_INVALID_DOORBELL;
+	wake_up_all(&priv->job_list_wq);
 
 	return 0;
 }
 
-static void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx)
+void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags)
 {
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct cert_comp *cert_comp;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
-	aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
-	aie4_put_cert_comp(priv->cert_comp);
+	mutex_lock(&priv->io_lock);
+	cert_comp = priv->cert_comp;
+	WRITE_ONCE(priv->cert_comp, NULL);
+	mutex_unlock(&priv->io_lock);
+
+	if (cert_comp)
+		wake_up_all(&cert_comp->waitq);
+
+	if (flags != AIE4_HWCTX_DISCONNECT)
+		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
+
+	if (cert_comp)
+		aie4_put_cert_comp(cert_comp);
+
+	priv->hw_ctx_id = CTX_INVALID_ID;
+	hwctx->fw_ctx_id = -1;
+	hwctx->doorbell_offset = CTX_INVALID_DOORBELL;
+
+	cancel_work_sync(&priv->job_work);
 }
 
 static void aie4_hwctx_umq_fini(struct amdxdna_hwctx *hwctx)
 {
 	if (hwctx->priv && hwctx->priv->umq_bo)
-		amdxdna_gem_put_obj(hwctx->priv->umq_bo);
+		drm_gem_object_put(to_gobj(hwctx->priv->umq_bo));
 }
 
 static int aie4_hwctx_umq_init(struct amdxdna_hwctx *hwctx)
 {
+	const size_t indir_pkts_sz = CTX_MAX_CMDS * HSA_MAX_LEVEL1_INDIRECT_ENTRIES *
+				     sizeof(struct host_indirect_packet_data);
+	const size_t pkts_sz = CTX_MAX_CMDS * sizeof(struct host_queue_packet);
 	struct amdxdna_hwctx_priv *priv = hwctx->priv;
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
 	struct amdxdna_gem_obj *umq_bo;
 	struct host_queue_header *qhdr;
+	u64 data_dev_addr;
+	void *umq_va;
 	int ret;
+	int i;
 
+	/* Queue lives in user-allocated BO so device can access it under PASID. */
 	umq_bo = amdxdna_gem_get_obj(hwctx->client, hwctx->umq_bo_hdl, AMDXDNA_BO_SHARE);
 	if (!umq_bo) {
 		XDNA_ERR(xdna, "cannot find umq_bo handle %d", hwctx->umq_bo_hdl);
 		return -ENOENT;
 	}
-	if (umq_bo->mem.size < sizeof(*qhdr)) {
-		XDNA_ERR(xdna, "umq_bo size is too small");
+
+	/* Ensure user BO can hold queue header and direct/indirect packet arrays. */
+	if (umq_bo->mem.size < sizeof(*qhdr) ||
+	    (umq_bo->mem.size < sizeof(*qhdr) + pkts_sz + indir_pkts_sz)) {
+		XDNA_ERR(xdna, "umq_bo size %zu is too small",
+			 (size_t)umq_bo->mem.size);
 		ret = -EINVAL;
 		goto put_umq_bo;
 	}
 
-	/* get kva address for host queue read index and write index */
-	qhdr = amdxdna_gem_vmap(umq_bo);
-	if (!qhdr) {
+	umq_va = amdxdna_gem_vmap(umq_bo);
+	if (!umq_va) {
 		ret = -ENOMEM;
 		goto put_umq_bo;
 	}
+	qhdr = umq_va;
 
 	priv->umq_bo = umq_bo;
 	priv->umq_read_index = &qhdr->read_index;
 	priv->umq_write_index = &qhdr->write_index;
 
+	/* Lay out direct packets after header, followed by indirect packets. */
+	data_dev_addr = amdxdna_gem_dev_addr(umq_bo) + sizeof(*qhdr);
+	priv->umq_pkts = umq_va + sizeof(*qhdr);
+	priv->umq_indirect_pkts = umq_va + sizeof(*qhdr) + pkts_sz;
+	priv->umq_indirect_pkts_dev_addr = data_dev_addr + pkts_sz;
+
+	/* Clear only the driver-managed header and packet regions. */
+	memset(umq_va, 0, sizeof(*qhdr) + pkts_sz + indir_pkts_sz);
+	priv->write_index = QUEUE_INDEX_START;
+	qhdr->read_index = QUEUE_INDEX_START;
+	qhdr->write_index = QUEUE_INDEX_START;
+	qhdr->version.major = HOST_QUEUE_MAJOR_VERSION;
+	qhdr->version.minor = HOST_QUEUE_MINOR_VERSION;
+	qhdr->capacity = CTX_MAX_CMDS;
+	qhdr->data_address = data_dev_addr;
+	for (i = 0; i < CTX_MAX_CMDS; i++)
+		priv->umq_pkts[i].pkt_header.common_header.opcode = OPCODE_EXEC_BUF;
+	for (i = 0; i < CTX_MAX_CMDS * HSA_MAX_LEVEL1_INDIRECT_ENTRIES; i++) {
+		priv->umq_indirect_pkts[i].header.opcode = OPCODE_EXEC_BUF;
+		priv->umq_indirect_pkts[i].header.count = sizeof(struct exec_buf);
+		priv->umq_indirect_pkts[i].header.distribute = 1;
+	}
+
 	return 0;
 
 put_umq_bo:
@@ -230,28 +328,52 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 {
 	struct amdxdna_client *client = hwctx->client;
 	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 	struct amdxdna_hwctx_priv *priv;
 	int ret;
 
+	if (!AIE_FEATURE_ON(&ndev->aie, AIE4_HSA_COMMAND))
+		return -EOPNOTSUPP;
+
 	priv = kzalloc_obj(*priv);
 	if (!priv)
 		return -ENOMEM;
 	hwctx->priv = priv;
+	priv->hwctx = hwctx;
+
+	/* Initialize io_lock guarding cert_comp binding. */
+	mutex_init(&priv->io_lock);
+
+	INIT_LIST_HEAD(&priv->pending_job_list);
+	INIT_LIST_HEAD(&priv->running_job_list);
+	init_waitqueue_head(&priv->job_list_wq);
+	INIT_WORK(&priv->job_work, job_worker);
 
 	ret = aie4_hwctx_umq_init(hwctx);
 	if (ret)
-		goto free_priv;
+		goto destroy_lock;
 
 	ret = aie4_hwctx_create(hwctx);
 	if (ret)
 		goto umq_fini;
 
-	XDNA_DBG(xdna, "hwctx %s init completed", hwctx->name);
+	priv->job_work_q = alloc_ordered_workqueue("aie4_job_%d_%d", 0,
+						   client->pid, hwctx->fw_ctx_id);
+	if (!priv->job_work_q) {
+		XDNA_ERR(xdna, "Create job_work_q failed");
+		ret = -ENOMEM;
+		goto destroy_ctx;
+	}
+
+	XDNA_DBG(xdna, "hwctx %d.%d init completed", client->pid, hwctx->fw_ctx_id);
 	return 0;
 
+destroy_ctx:
+	aie4_hwctx_destroy(hwctx, AIE4_HWCTX_NORMAL);
 umq_fini:
 	aie4_hwctx_umq_fini(hwctx);
-free_priv:
+destroy_lock:
+	mutex_destroy(&priv->io_lock);
 	kfree(priv);
 	hwctx->priv = NULL;
 	return ret;
@@ -259,8 +381,14 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
 {
-	aie4_hwctx_destroy(hwctx);
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	aie4_hwctx_destroy(hwctx, AIE4_HWCTX_ERROR);
+	cancel_work_sync(&priv->job_work);
+	if (priv->job_work_q)
+		destroy_workqueue(priv->job_work_q);
 	aie4_hwctx_umq_fini(hwctx);
+	mutex_destroy(&priv->io_lock);
 	kfree(hwctx->priv);
 }
 
@@ -304,10 +432,12 @@ static inline bool check_cmd_done(struct amdxdna_hwctx *hwctx, u64 seq)
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 {
 	unsigned long wait_jifs = MAX_SCHEDULE_TIMEOUT;
-	struct amdxdna_hwctx_priv *priv = hwctx->priv;
-	struct cert_comp *cert_comp = priv->cert_comp;
+	struct cert_comp *cert_comp = aie4_get_cert_comp(hwctx);
 	long ret;
 
+	if (!cert_comp)
+		return -EAGAIN;
+
 	if (timeout)
 		wait_jifs = msecs_to_jiffies(timeout);
 
@@ -318,5 +448,7 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 	if (!ret)
 		ret = -ETIME;
 
+	aie4_put_cert_comp(cert_comp);
+
 	return ret <= 0 ? ret : 0;
 }
diff --git a/drivers/accel/amdxdna/aie4_host_queue.h b/drivers/accel/amdxdna/aie4_host_queue.h
index 95ebbb714c6f..d2ed2fd65fb1 100644
--- a/drivers/accel/amdxdna/aie4_host_queue.h
+++ b/drivers/accel/amdxdna/aie4_host_queue.h
@@ -6,9 +6,14 @@
 #ifndef _AIE4_HOST_QUEUE_H_
 #define _AIE4_HOST_QUEUE_H_
 
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #define CTX_MAX_CMDS                    32
+#define HSA_MAX_LEVEL1_INDIRECT_ENTRIES	6
+#define QUEUE_INDEX_START		0
+#define HOST_QUEUE_MAJOR_VERSION	1
+#define HOST_QUEUE_MINOR_VERSION	0
 
 /* Host queue header layout. */
 struct host_queue_header {
@@ -24,4 +29,64 @@ struct host_queue_header {
 	__u64 data_address; /* The xdna dev addr for payload. */
 } __packed;
 
+/* Payload for an OPCODE_EXEC_BUF host-queue packet (single command). */
+struct exec_buf {
+	u32 dtrace_buf_host_addr_low;
+	u32 dpu_control_code_host_addr_low;
+	u32 dpu_control_code_host_addr_high;
+	u16 args_len;
+	u16 dtrace_buf_host_addr_high;
+	u32 args_host_addr_low;
+	u32 args_host_addr_high;
+} __packed;
+
+#define OPCODE_EXEC_BUF		1
+#define CHAIN_FLG_LAST_CMD	0
+#define CHAIN_FLG_NOT_LAST_CMD	1
+struct common_header {
+	u16 reserved; /* MBZ. */
+	u8 opcode;
+	u8 chain_flag;
+	u16 count;
+	u8 distribute;
+	u8 indirect;
+} __packed;
+
+struct host_queue_packet_header {
+	struct common_header common_header;
+	u64 completion_signal;
+} __packed;
+
+struct host_queue_packet {
+	struct host_queue_packet_header pkt_header;
+	u32 data[12]; /* total 64-byte packet */
+} __packed;
+
+struct host_indirect_packet_entry {
+	u32 host_addr_low;
+	u32 host_addr_high_uc_index;
+} __packed;
+
+#define HIPE_HOST_ADDR_HIGH_SHIFT	0
+#define HIPE_HOST_ADDR_HIGH_MASK	GENMASK(24, 0)
+#define HIPE_UC_INDEX_SHIFT		25
+#define HIPE_UC_INDEX_MASK		GENMASK(31, 25)
+
+static inline void hipe_set_host_addr_high(u32 *val, u32 addr_hi)
+{
+	*val &= ~HIPE_HOST_ADDR_HIGH_MASK;
+	*val |= (addr_hi << HIPE_HOST_ADDR_HIGH_SHIFT) & HIPE_HOST_ADDR_HIGH_MASK;
+}
+
+static inline void hipe_set_uc_index(u32 *val, u32 uc_idx)
+{
+	*val &= ~HIPE_UC_INDEX_MASK;
+	*val |= (uc_idx << HIPE_UC_INDEX_SHIFT) & HIPE_UC_INDEX_MASK;
+}
+
+struct host_indirect_packet_data {
+	struct common_header header;
+	struct exec_buf payload;
+} __packed;
+
 #endif /* _AIE4_HOST_QUEUE_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 9fcdfcc5a15f..3d3301ce11ae 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -8,7 +8,10 @@
 
 #include <linux/device.h>
 #include <linux/iopoll.h>
+#include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
@@ -25,7 +28,20 @@ struct cert_comp {
 	wait_queue_head_t               waitq;
 };
 
+/*
+ * aie4 kernel-submission job states (stored in amdxdna_sched_job priv.aie4.state).
+ * Anonymous enum - the aie4_job_state identifier is already a field-access macro.
+ */
+enum {
+	AIE4_JOB_STATE_INIT,
+	AIE4_JOB_STATE_PENDING,
+	AIE4_JOB_STATE_SUBMITTING,
+	AIE4_JOB_STATE_SUBMITTED,
+	AIE4_JOB_STATE_DONE,
+};
+
 struct amdxdna_hwctx_priv {
+	struct amdxdna_hwctx		*hwctx;
 	struct amdxdna_gem_obj          *umq_bo;
 	u64                             *umq_read_index;
 	u64                             *umq_write_index;
@@ -33,7 +49,22 @@ struct amdxdna_hwctx_priv {
 	struct cert_comp                *cert_comp;
 	u32                             hw_ctx_id;
 
+	/* Direct and indirect packet storage aliasing umq_bo. */
+	u64                             write_index;
+	struct host_queue_packet        *umq_pkts;
+	struct host_indirect_packet_data *umq_indirect_pkts;
+	u64                             umq_indirect_pkts_dev_addr;
+	/* Transport doorbell target set by aie4_doorbell_setup(). */
 	void                    __iomem *doorbell_addr;
+
+	struct mutex                    io_lock; /* serialize submit, protect job lists */
+	struct list_head                pending_job_list;
+	/* Head of pending_job_list, read locklessly by wait conditions. */
+	struct amdxdna_sched_job        *pending_head;
+	struct list_head                running_job_list;
+	wait_queue_head_t               job_list_wq;
+	struct work_struct              job_work;
+	struct workqueue_struct         *job_work_q;
 };
 
 struct amdxdna_dev_priv {
@@ -107,9 +138,18 @@ int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us);
 u32 aie4_msg_pasid(struct amdxdna_client *client);
 
 /* aie4_ctx.c */
+enum aie4_hwctx_flags {
+	AIE4_HWCTX_NORMAL = 0,
+	AIE4_HWCTX_GRACEFUL,
+	AIE4_HWCTX_DISCONNECT, /* sets has_error, do not destroy context */
+	AIE4_HWCTX_ERROR, /* sets has_error, destroy context */
+};
+
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
+int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
+void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
 
 /* aie4_pci.c */
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
-- 
2.34.1

