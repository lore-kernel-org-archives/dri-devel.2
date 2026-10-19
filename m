Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE7060A5BC7
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AO4cl/yR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5CC10EF51;
	Mon, 19 Oct 2026 16:48:08 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D334C10ECC4
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBDhuSfS8/Im1FJiUM4uh+Dfg+EH+u2UeWaVDW9uW6+WYIj6NCKZllOP0HIvROnzpAXIRm16kl9OHn8VxQ5QoppudPcfCOFufs49QqAzbdyBzNNaOUhTY8oUL9uHn+Nysy52WL8TApTFjGWFA/UpE7UuS3eydW1hcFMzJP6e1ZyFOhXf5Q/RUVPYnE0syRbJw+RwllsmUUL21QD39yJhC+0WcUFFT9IxACaWh+/gUK3OLCviW9QdkDZIjlRlzkP4DR2A1JNhHtamiu1KSr5PsD8beYM22BnDsNLY+inb0BlNcAj2TIlnP86P7dmph8TqxHWLYwLM5Dm4ozyyUsTOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFbAniR7CsOP6vXBI2a+iH5t15NgN6ZVEGeuPkIRqa0=;
 b=iYpQs7PnDEsHPFUORTd6kB1c1ap4QRGnxd+3A9F2qcg9Gl+Mom/FtiD0MQ+cfRdyTJMqNSPfQbvsA+MuTQYCPgNrdeZH2ZMYapBPIlimAB+Qz8nVJh13TpUVNKLyyunJIp+1ckKSdhiWE3WVoZ732xmcJ/uSs+E6DJ5D4GK0glTP1VZnAG4cavsgRJwDVBmfkBdf4ddj/RXj8fxOcg6xB6vz3K6OvcW6j4U/PxG9nDNeJUNr5qt42Z0QCfAz3+pVB+gvaa+6OcCFv0DhLCPF/D9xpkwH5QZFyI0KvUTZtv/fdw4x7t/xTnprnEzWhQr01BAmNrezNbw2p6xEkw8skQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFbAniR7CsOP6vXBI2a+iH5t15NgN6ZVEGeuPkIRqa0=;
 b=AO4cl/yRhD0oGEwYs/z6A1oYN06Tgr/aCSPzW/TOtE4CxpbGRgyyAT4GDFsup0dUq2Qq1lnsmFRSwbpm2GOdVZrgfcogS4XpTXsbnL/eCekVrEzh8IX4fIpE9RxzrPmaUnUp9VYZbBF1c93A86y3xq5EwrFfO/9I7KZ5IliyXS0=
Received: from PH8P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::6)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:55 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::4b) by PH8P220CA0002.outlook.office365.com
 (2603:10b6:510:345::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 16:47:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F2A.mail.protection.outlook.com (10.167.243.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:47:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:43 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:43 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 02/19] accel/amdxdna: Remove mmap for doorbell
Date: Mon, 19 Oct 2026 09:47:29 -0700
Message-ID: <20261019164746.827277-3-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: 866b0aaa-4889-42b6-bfb9-08df2e00b936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|22082099003|18002099003|4143699003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: thhLLowANRmWXM7MdSw3MkQrfLSYujwJw10K/vS+F9vGOcDzuc7GF7YtjyzRon1daCdMv/qmLUGYabQKFXr5SoZDfEpWXSLQR23TiGMMpFrIG+G+3hou6IbawOZrP3Y0AtbMVz/FCqcJm2b2oCOiTUIn4/f+s6+x6XTN0fKRq/YMb/3CHAz4mNVvCf39QTGlqTASQ2+liqFsmCKhP26+ccGeuZ1bRmOefy4rVKa9OZpn0cPM7lEHo6dVXLvBkwq6ThZJ8MUQFBQIprq5wDoTfb8OGZ9ieCnFGZltpYfqc4yZhBAj10eAa/wJdXOdl9YOneeUrruf5caVBATplpxv2WzHlRqNmad95MtQDERC1/TbqvmkKdw45zACPox4t1QT5DYBGckslLP5ZeCEnVFguyG+uiY2qV1ey5TwHEAE3FqrH5npPn1eCr9khEA/eMwIVn1QA2b9n/7N5NQAU0Muk0kLJBBKkOBjnoSzBghzg1Iade+WA+TWej8QbM3ZKMBOlZn67SbTit9VTihopbNCBoQP1GtHq2SgX3tbTmE2thPGuev8/1KQmmSx0o8lVzqMZl8Ax+HUMo04nhs2iplgB3UY2NH+NMsAIyES1AOBBK+3Crry2tTaWcB1o6PJJeRulve+J0kuKMUaZlwspB7MjVB2usbRYQTesEfFhzaPlq0JsNyj3cr3TSZYsBicJsT2WqhKyPVpme5FMo4HGHO7WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UcVRaTo+8VgcxN+HSN8eumaWXz2VNQjDgoN9G/w+BwJKS/uyRiensUPK7z0Xi21N/2rpJZ4xix5QvARYjhsKdtQA8jVsRybX/o/9ScMV2pwlZYicT296FqWf/xMC7W8t9QynNkiYvqWEn727wJPpXGxh2d1Ql6Axge4W44CkgQNKLU8HtrgPMq0jwvsbGaV55p+2/GGyycUJOOmC2g2mxXvuM7wRl1bu4WwatzXiujk7naPZI99fFcZ6uwrzdiXRiM1v35sJdYD5DzCHTk23lUaYw2MSX5xNV56Fu81TjFTTE82EM8K8PXzRENDZgWo4Aok34R+hXtKC90HH0vppz5v/ekhcLqoHsfOobso2zSgd4rfPmYtH35IQGUp6uHbUc3LyOYoCMoib3DaXvS/N9OYgsvmOpI6buLERXIUak8js5L9qvmKCygv+oNRm8Jpi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:55.1015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866b0aaa-4889-42b6-bfb9-08df2e00b936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599
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

Make kernel submission the default, so mapping the doorbell back to user
space is not needed:
- Remove .mmap handler and use standard drm_gem_mmap.
- Set hwctx->doorbell_offset to AMDXDNA_INVALID_DOORBELL_OFFSET on
  context creation so userspace does not receive a valid-looking BAR
  offset.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        | 20 +--------------
 drivers/accel/amdxdna/aie4_pci.c        | 33 -------------------------
 drivers/accel/amdxdna/aie4_pci.h        |  1 -
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 17 +------------
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
 5 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 8408b0d2696f..8157f2a6fd10 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -158,7 +158,7 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	}
 
 	priv->hw_ctx_id = resp.hw_context_id;
-	hwctx->doorbell_offset = resp.doorbell_offset;
+	hwctx->doorbell_offset = AMDXDNA_INVALID_DOORBELL_OFFSET;
 
 	return 0;
 }
@@ -313,21 +313,3 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
 
 	return ret <= 0 ? ret : 0;
 }
-
-int aie4_hwctx_valid_doorbell(struct amdxdna_client *client, u32 vm_pgoff)
-{
-	struct amdxdna_hwctx *hwctx;
-	unsigned long hwctx_id;
-	int idx;
-
-	idx = srcu_read_lock(&client->hwctx_srcu);
-	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
-		if (vm_pgoff == (hwctx->doorbell_offset >> PAGE_SHIFT)) {
-			srcu_read_unlock(&client->hwctx_srcu, idx);
-			return 1;
-		}
-	}
-	srcu_read_unlock(&client->hwctx_srcu, idx);
-
-	return 0;
-}
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index e99ad35870ef..f81c43a1f884 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -524,38 +524,6 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 	return 0;
 }
 
-static int aie4_doorbell_mmap(struct amdxdna_client *client, struct vm_area_struct *vma)
-{
-	struct amdxdna_dev *xdna = client->xdna;
-	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
-	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
-	phys_addr_t res_start;
-	unsigned long pfn;
-	int ret;
-
-	if (!aie4_hwctx_valid_doorbell(client, vma->vm_pgoff)) {
-		XDNA_ERR(xdna, "Invalid doorbell page offset 0x%lx", vma->vm_pgoff);
-		return -EINVAL;
-	}
-
-	if (vma_pages(vma) != 1) {
-		XDNA_ERR(xdna, "can only map one page, got %ld", vma_pages(vma));
-		return -EINVAL;
-	}
-
-	res_start = pci_resource_start(pdev, xdna->dev_info->doorbell_bar) + npriv->doorbell_off;
-	pfn = PHYS_PFN(res_start) + vma->vm_pgoff;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vm_flags_set(vma, VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
-	ret = io_remap_pfn_range(vma, vma->vm_start,
-				 pfn,
-				 PAGE_SIZE,
-				 vma->vm_page_prot);
-
-	XDNA_DBG(xdna, "doorbell ret %d", ret);
-	return ret;
-}
-
 static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
 {
 	struct amdxdna_dev *xdna = client->xdna;
@@ -667,7 +635,6 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.fini			= aie4_vf_fini,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
-	.mmap			= aie4_doorbell_mmap,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 3fd5eace3ed7..c6219544dc0f 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -69,7 +69,6 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
-int aie4_hwctx_valid_doorbell(struct amdxdna_client *client, u32 vm_pgoff);
 
 /* aie4_sriov.c */
 #if IS_ENABLED(CONFIG_PCI_IOV)
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index bfc8bedf6de1..0842fd31c9f2 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -253,21 +253,6 @@ static int amdxdna_drm_set_state_ioctl(struct drm_device *dev, void *data, struc
 	return ret;
 }
 
-static int amdxdna_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_file *drm_filp = filp->private_data;
-	struct amdxdna_client *client = drm_filp->driver_priv;
-	struct amdxdna_dev *xdna = client->xdna;
-
-	if (likely(vma->vm_pgoff >= DRM_FILE_PAGE_OFFSET_START))
-		return drm_gem_mmap(filp, vma);
-
-	if (!xdna->dev_info->ops->mmap)
-		return -EOPNOTSUPP;
-
-	return xdna->dev_info->ops->mmap(client, vma);
-}
-
 static const struct drm_ioctl_desc amdxdna_drm_ioctls[] = {
 	/* Context */
 	DRM_IOCTL_DEF_DRV(AMDXDNA_CREATE_HWCTX, amdxdna_drm_create_hwctx_ioctl, 0),
@@ -329,7 +314,7 @@ static const struct file_operations amdxdna_fops = {
 	.poll		= drm_poll,
 	.read		= drm_read,
 	.llseek		= noop_llseek,
-	.mmap		= amdxdna_drm_gem_mmap,
+	.mmap		= drm_gem_mmap,
 	.show_fdinfo	= drm_show_fdinfo,
 	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 510356a31532..0db56c51bb49 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -57,7 +57,6 @@ struct amdxdna_dev_ops {
 	int (*resume)(struct amdxdna_dev *xdna);
 	int (*suspend)(struct amdxdna_dev *xdna);
 	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
-	int (*mmap)(struct amdxdna_client *client, struct vm_area_struct *vma);
 	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
 	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
 	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
-- 
2.34.1

