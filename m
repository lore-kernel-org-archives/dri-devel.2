Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A42CA6001
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C26E10EF86;
	Tue,  6 Oct 2026 04:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EunWWVLW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0755210EF77
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egTLv1AeturIDMJgQZza8+YeDuO32kgYeGzYpzuExaQjREt6pgZOeJw8YyJ4M68RcEr1fmQTuaDUUYgcX0iPeKJtlQDjS/6iJufU/B+nFIh+1rTJg6LCBSISXSvszuV7gvTS1QN3dPP0ZgWnhjzJaUyylY6M+5ovcCY8Gdep+Er4EvekLOvXWNKLVUFWXtss6xmEH6Kmt2IuZ9uWGyAvTI/yRicKo3QQSeo6RsjsH7OSxcjVC4xkBFKSSnET5nh/z2OFbJVvXjUaK4OInvCdu8kvmSdoV4ujOoqkxSJxx6SYI9fnPEb8s22Yj7q2+Q7tU1Pbcre6Tc4GojZ/4TPCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGhat2rSBYvWbBYr6rmr593Pc79vpHZexE6Cjzm7HAI=;
 b=JOHnivMV5NmRACwf31yQmRCHNU4PrwlQGrBCYPPLyiB1LTjozHjtfZUEYB2tSH2zPZ1X8fXM7tAkrSU5U7tkm9NOTBgPpw/PnmVrr51Qk6KZKBsTpWVOXERf8iV8l1PijjJoT6CvFencU7QaJOVIx7G/PhqBHe16iOVlgEnuBQnBOe2ZAtbnL3M8GLWqoEE7hvjcf3oAU2B/PdiWAFz2yzWEmoT3TR4PAnhixdA42eeLr89YnUYxsGFTnrNwxCZMxjWQ4q6kw0u7T1z1wABUy8Z3GKOg37bRPzzhAYpF1+ljL6IjZp9OV76Kt/euky3UU7zXhiGmGNmpSPYPVHva5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGhat2rSBYvWbBYr6rmr593Pc79vpHZexE6Cjzm7HAI=;
 b=EunWWVLWC4le+pQSyNpZKpnW6bsGhY9eYrURvY/uUKKYDTyz6ejteN7hQZXn9hzdERYmSgf6kcCwP52z7bphBlAtkHaBfJrQpdB26Cm4tF0Te00YovnjNfcRT20z8+x6DKgEFqdJW/JXU0BD657SyiuYptgmAzr0xcitLL/aFiM=
Received: from CH0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:610:75::31)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Tue, 6 Oct
 2026 04:23:01 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::75) by CH0PR04CA0116.outlook.office365.com
 (2603:10b6:610:75::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:23:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:23:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:23:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:23:00 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:59 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 17/20] accel/amdxdna: Implement AIE4 suspend and resume
Date: Mon, 5 Oct 2026 21:22:27 -0700
Message-ID: <20261006042230.547807-18-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a201c85-fd20-4581-f0b6-08df2361823b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|22082099003|18002099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: GSh6T5pFhmZX0vRkmaap/Z8RanEL6HUMj4zZOXDAsUTwJFMfv6aBgvFcbRV9vCEy2eyD1gHj8TJa0aLjmlocqErIOd5SfzUnkC7buLzCld952Ukm+K7pLbwcFkSCmPQNT248Q8EnlJOWQ/gU+G/QhyuWRpSKvd1Xchw31GNCMm861Jy17//K46Fw9eDaKL6dhClBHTPjzjPg1GBmqkLdwtBzd2oy4EUE7SuYZ+Oaw7HvnjoqoLgBpQXW2ZDTA0fFilCR7sgvViOvek5acHrfaDxsN74bGA7dL0lrLlmZtoAMjxDNq2T2uknBf5Z6lnasxfMPGpBEgiKCf7GGWDv969rZ+NNHNqxoHmZCuywzjfRjvq6VzzPdvJ74W/iYixpr6K19L0aWurjecYITP8PQ0DppnrGEzNN95Y1+Xqb0ba9wo/zz2kxy63LFgMGIa0ojuZa8FkoadoWOioi2mB48EEFi9t+x1//clsY0dpXe8/HFI9hwDMCm9O+YxukMwsi01Aul1L3slUIvLVo6CD6OI8kT3w9d5cZYMdpZR/XPRDaEOlet1xaASXl04J+DipOsEwZMqDgzWVmkBcPbfJ5GYst1nP/MAmLWgCxrPwWpydJLrrSStHRezb0K/vtRVZOufuP0ZESD3n+V9yPEYAh+WUwIA/jaCTMHWpug5BD3ugQ2lPVy/QRl6TJcFgepax5YR1RZMxUmKkeblrjfxqO8yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jIWvNykN7cZcgVCPQeShpQY8t3nPDZv33dfxm8gFpkYB+599748AQN2jOET9vZaXabcjY9e51DxRHKUCU/ex0coCKm166N6dENl4n1p61mnWXSTL6uN61Ojo1EX2ZQyis2yG7cHqpSfQnokTQsBwVmg1IhAdBxVNxNibLgRHnZw+K2R26Yqu6+FGMiJTDAjAuCaTdt/ijROnn44XJaGMqYOJ8cLNy/Cfd+daWo70NwstaKzI9ZM3rOkkpa/CHbY9SBazvHPA8qiYJ+6egYPd6EWLQCJtH5wgmgeU1JH8kFnLYjQfwnbChFZl74F6hhgu0MUWNdOuPeuyu19IOQaKVRNajQhnk85g+IV7BOhmG2UmJcoLAhw2pCjL0aot+7wsTFdxAdQLHcESK+P+iNH3Vl9Gu/DFhBZmpp4Tw34jqTGE2+htfkleNbWAXGfru8r4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:23:01.3248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a201c85-fd20-4581-f0b6-08df2361823b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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

Implement suspend and resume callbacks for AIE4 Physical Function (PF),
Virtual Function (VF), and Classic device types:
- Add .suspend and .resume hooks in amdxdna_dev_ops for aie4_pf_ops,
  aie4_vf_ops, and aie4_classic_ops.
- Implement aie4_hwctx_suspend_all() to destroy or drain contexts across
  all registered clients and wait for in-flight jobs.
- Implement aie4_hwctx_resume_all() to recreate firmware contexts and
  kick doorbells via aie4_hwctx_resume_jobs() to resume hardware queue
  consumption.
- Guard firmware destroy message in aie4_hwctx_destroy() when context
  ID is invalid.
- Restore SR-IOV virtual functions on PF resume via aie4_restore_sriov().

Call pci_disable_device() in the suspend paths to balance
pci_enable_device() in the resume paths.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        |  18 +-
 drivers/accel/amdxdna/aie4_pci.c        | 247 ++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |   9 +
 drivers/accel/amdxdna/aie4_sriov.c      |   4 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   3 +
 5 files changed, 279 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 882938d368ef..5dc079d3f564 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -248,7 +248,7 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	if (has_error)
 		wake_up_all(&priv->job_list_wq);
 
-	if (flags != AIE4_HWCTX_DISCONNECT)
+	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID)
 		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
 
 	if (cert_comp)
@@ -356,6 +356,7 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 		return -ENOMEM;
 	hwctx->priv = priv;
 	priv->hwctx = hwctx;
+	priv->hw_ctx_id = CTX_INVALID_ID;
 
 	/* Initialize io_lock guarding cert_comp binding. */
 	mutex_init(&priv->io_lock);
@@ -906,6 +907,21 @@ int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx)
 	return ret;
 }
 
+void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	mutex_lock(&priv->io_lock);
+	if (list_empty(&priv->running_job_list)) {
+		mutex_unlock(&priv->io_lock);
+		return;
+	}
+	aie4_doorbell_ring(hwctx);
+	mutex_unlock(&priv->io_lock);
+
+	queue_work(priv->job_work_q, &priv->job_work);
+}
+
 /*
  * Submit job command(s) to host queue. Called with io_lock held.
  * Returns 0 on success or if partial chain is queued for worker abort.
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 3b930197d5ee..f7fa55c82baa 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1066,11 +1066,254 @@ static void aie4_debugfs_init(struct amdxdna_dev *xdna)
 					   &aie4_ctx_hysteresis_fops);
 }
 
+void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct amdxdna_client *client;
+	struct amdxdna_hwctx *hwctx;
+	unsigned long hwctx_id;
+	int idx;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	amdxdna_for_each_client(xdna, client) {
+		idx = srcu_read_lock(&client->hwctx_srcu);
+		amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
+			/* clean up workers and drain running jobs */
+			if (clean_jobs) {
+				int ret;
+
+				aie4_hwctx_destroy(hwctx, AIE4_HWCTX_ERROR);
+				ret = aie4_hwctx_wait_for_running(hwctx);
+				if (ret)
+					XDNA_WARN(xdna, "hwctx %s wait for running failed %d",
+						  hwctx->name, ret);
+			} else {
+				aie4_hwctx_destroy(hwctx, AIE4_HWCTX_NORMAL);
+			}
+		}
+		srcu_read_unlock(&client->hwctx_srcu, idx);
+	}
+
+	XDNA_DBG(xdna, "Finished hwctx suspend");
+}
+
+int aie4_hwctx_resume_all(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct amdxdna_client *client;
+	struct amdxdna_hwctx *hwctx;
+	unsigned long hwctx_id;
+	int ret, idx;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	amdxdna_for_each_client(xdna, client) {
+		idx = srcu_read_lock(&client->hwctx_srcu);
+		amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
+			ret = aie4_hwctx_create(hwctx);
+			if (ret)
+				goto error;
+			aie4_hwctx_resume_jobs(hwctx);
+		}
+		srcu_read_unlock(&client->hwctx_srcu, idx);
+	}
+
+	XDNA_DBG(xdna, "Finished hwctx resume");
+	return 0;
+error:
+	srcu_read_unlock(&client->hwctx_srcu, idx);
+	XDNA_DBG(xdna, "Failed hwctx resume");
+	return ret;
+}
+
+static int aie4_restore_sriov(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	int ret;
+
+	if (ndev->num_vfs) {
+		if (pci_num_vf(pdev) != ndev->num_vfs) {
+			XDNA_ERR(xdna, "inconsistent vf number");
+			return -EINVAL;
+		}
+		ret = aie4_create_vfs(ndev, ndev->num_vfs);
+		if (ret) {
+			XDNA_ERR(xdna, "create vfs failed, %d", ret);
+			return ret;
+		}
+		XDNA_DBG(xdna, "restored num_vfs %d", ndev->num_vfs);
+	}
+
+	return 0;
+}
+
+static int aie4_pf_suspend(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+	aie4_pf_hw_stop(ndev);
+	pci_disable_device(pdev);
+
+	XDNA_DBG(xdna, "pf suspend done");
+	return 0;
+}
+
+static int aie4_pf_resume(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	int ret;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		XDNA_ERR(xdna, "enable pci device failed %d", ret);
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = aie4_pf_hw_start(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hw_start failed %d", ret);
+		goto pci_disable;
+	}
+
+	ret = aie4_restore_sriov(ndev);
+	if (ret)
+		goto hw_stop;
+
+	XDNA_DBG(xdna, "pf resume done");
+	return 0;
+hw_stop:
+	aie4_pf_hw_stop(ndev);
+pci_disable:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static int aie4_vf_suspend(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+	aie4_hwctx_suspend_all(ndev, false);
+	/*
+	 * partition_fini and mailbox messages should not be called here
+	 * because PF suspend will do the cleanup for all VFs.
+	 */
+	aie4_mailbox_fini(ndev);
+	pci_disable_device(pdev);
+
+	XDNA_DBG(xdna, "vf suspend done");
+	return 0;
+}
+
+static int aie4_vf_resume(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	int ret;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		XDNA_ERR(xdna, "enable pci device failed %d", ret);
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = aie4_vf_hw_start(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hw_start failed %d", ret);
+		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
+		aie4_hwctx_suspend_all(ndev, true);
+		goto pci_disable;
+	}
+
+	ret = aie4_hwctx_resume_all(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hwctx_resume failed %d", ret);
+		goto hw_clear;
+	}
+
+	XDNA_DBG(xdna, "vf resume done");
+	return 0;
+
+hw_clear:
+	aie4_hwctx_suspend_all(ndev, true);
+	aie4_vf_hw_stop(ndev);
+pci_disable:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static int aie4_classic_suspend(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+	aie4_hwctx_suspend_all(ndev, false);
+	aie4_classic_hw_stop(ndev);
+	pci_disable_device(pdev);
+
+	XDNA_DBG(xdna, "classic suspend done");
+	return 0;
+}
+
+static int aie4_classic_resume(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	int ret;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		XDNA_ERR(xdna, "enable pci device failed %d", ret);
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = aie4_classic_hw_start(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hw_start failed %d", ret);
+		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
+		aie4_hwctx_suspend_all(ndev, true);
+		goto pci_disable;
+	}
+
+	ret = aie4_hwctx_resume_all(ndev);
+	if (ret) {
+		XDNA_ERR(xdna, "hwctx_resume failed %d", ret);
+		goto hw_clear;
+	}
+
+	XDNA_DBG(xdna, "classic resume done");
+	return 0;
+hw_clear:
+	aie4_hwctx_suspend_all(ndev, true);
+	aie4_classic_hw_stop(ndev);
+pci_disable:
+	pci_disable_device(pdev);
+	return ret;
+}
+
 const struct amdxdna_dev_ops aie4_pf_ops = {
 	.init			= aie4_pf_init,
 	.fini			= aie4_pf_fini,
 	.debugfs_init		= aie4_debugfs_init,
 	.sriov_configure        = aie4_sriov_configure,
+	.resume			= aie4_pf_resume,
+	.suspend		= aie4_pf_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
@@ -1085,6 +1328,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.hmm_invalidate		= aie_hmm_invalidate,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= aie4_vf_resume,
+	.suspend		= aie4_vf_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -1099,4 +1344,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.hmm_invalidate		= aie_hmm_invalidate,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= aie4_classic_resume,
+	.suspend		= aie4_classic_suspend,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 87de22e80ae6..011d2f4f0b68 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -97,6 +97,7 @@ struct amdxdna_dev_hdl {
 	u32				total_col;
 	u32				max_aieclk_level;
 	u32				max_npuhclk_level;
+	u32				num_vfs;
 
 	struct dpm_clk_freq		dpm_clk_tbl[AIE4_MAX_DPM_LEVEL_COUNT];
 
@@ -156,8 +157,11 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
 int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
+void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx);
 
 /* aie4_pci.c */
+void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs);
+int aie4_hwctx_resume_all(struct amdxdna_dev_hdl *ndev);
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
 
 /*
@@ -173,9 +177,14 @@ void aie4_free_notification(struct cert_comp *comp);
 
 /* aie4_sriov.c */
 #if IS_ENABLED(CONFIG_PCI_IOV)
+int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs);
 int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
 int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev);
 #else
+static inline int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
+{
+	return 0;
+}
 #define aie4_sriov_configure NULL
 static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 {
diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
index e1ce633768a5..0eea28f62676 100644
--- a/drivers/accel/amdxdna/aie4_sriov.c
+++ b/drivers/accel/amdxdna/aie4_sriov.c
@@ -26,7 +26,7 @@ static int aie4_destroy_vfs(struct amdxdna_dev_hdl *ndev)
 	return ret;
 }
 
-static int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
+int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
 {
 	DECLARE_AIE_MSG(aie4_msg_create_vfs, AIE4_MSG_OP_CREATE_VFS);
 	int ret;
@@ -55,6 +55,7 @@ int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 	}
 
 	pci_disable_sriov(pdev);
+	ndev->num_vfs = 0;
 	return aie4_destroy_vfs(ndev);
 }
 
@@ -75,6 +76,7 @@ static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
 		return ret;
 	}
 
+	ndev->num_vfs = num_vfs;
 	return num_vfs;
 }
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 632f8ba74b72..fde48ef0ca6c 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -169,6 +169,9 @@ struct amdxdna_client {
 #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
 	xa_for_each(&(client)->hwctx_xa, hwctx_id, entry)
 
+#define amdxdna_for_each_client(xdna, client)			\
+	list_for_each_entry(client, &(xdna)->client_list, node)
+
 /* Add device info below */
 extern const struct amdxdna_dev_info dev_npu1_info;
 extern const struct amdxdna_dev_info dev_npu3_classic_info;
-- 
2.34.1

