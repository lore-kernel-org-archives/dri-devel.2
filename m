Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEA606AEF9
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1Sciw4qr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA9510EFC5;
	Mon, 19 Oct 2026 16:48:43 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A3C10ECC4
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM+w145Tr35QefwOfWy9yYzUEp/1+mowdm5UVKdlrI68JjkXnuPaRJ1F/jc3AegXdbaPwP9DqT84lNja9ZZ0TzDJJyvXyp5hzmIHmZBedXiDaDeudrWOrm4+c/KjcDvKp4zCjGhqTU3I/WFSTlGHGzMuXugevzSisqJWqeXVKdgIiJr09QzZAdXaRs9c5biOM8VWUB0I09k2zIYuT+0hDVyO3Vw3AOskgh2kr6xyrpK4cIeYCDQxUYG1SdDU2cMPGUlJ0rRxqk+8VU9hUWoDcxdHzIw8e/bGw1qKv+4uNa0H8KNza/OToyIunojHDM4FvIgGb/9mmVDxJcGrWYKvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPEG3zOYa8oLJEr6L9n2nF0Rz2xXr3vNGdkTp9aTHFc=;
 b=V+Mwoh+JSnxKOjVQEoabk0yWnI2/BfvZUwvl2FZgcsujkDoOmBLuFbfgXU6NbwO170IrHUFG68IwMm1U3yg/8gHUwDNMcTKK8/uDBA65D4SyEkuYvnKesUubKAymR46SvGN6u42LdZ5Kh8o5DBvDcgITu2Zo8TnXbPMM0gqbhqta+ROrOocsov2AEU/HByYXQQEhlytiHBgLzLdY4xFuKCeFAku/XCz41AIAKlBTyfGebZhYORv4gYbcWwpZX7OgCniQ9hJDyFePyskOwXCjFlxcPzNG/6XvdghRux4X2zBvAti3d3gDeFJUknbLrARLON+pOhnXfMWFM6EUOBLkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPEG3zOYa8oLJEr6L9n2nF0Rz2xXr3vNGdkTp9aTHFc=;
 b=1Sciw4qrYwwWI6KGJw3On/B0E/gW0teYla7i8uBjM3QRN8V1MRUphsEX8/wktvuEdEpnRbaKlFzlhwS1TbNwbsS/XjHiMtlYnRKxZ/pW6aTuJNxR1JkPaI+HMnD9r6crVGMWA0EDuVJOZatAOe6GOmbUNYXh1eSIBVNudenXtjU=
Received: from DS7PR03CA0282.namprd03.prod.outlook.com (2603:10b6:5:3ad::17)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:48:05 +0000
Received: from DS4PEPF000001C4.namprd21.prod.outlook.com
 (2603:10b6:5:3ad:cafe::5d) by DS7PR03CA0282.outlook.office365.com
 (2603:10b6:5:3ad::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:48:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C4.mail.protection.outlook.com (10.167.23.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 19 Oct 2026 16:48:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:57 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:56 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 18/19] accel/amdxdna: Implement AIE4 suspend and resume
Date: Mon, 19 Oct 2026 09:47:45 -0700
Message-ID: <20261019164746.827277-19-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C4:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 0020a3d3-f081-4c9c-2f87-08df2e00bf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: HLfXk6SVbFMRUOlYbX62rD4svc3r9EbD3EDL/MxKyD3MyhRZGtYZGV5krFnKkYs4CrZSn2dW7UWTsMQR2cklu89qS7SEw+SlVvCzJJToHTYXM7d2b8mTsBsFijOKEwflwXrs7dB1S5t794BPOhFOhOF+42VIg9ImGI/m8Vwy8i/1B1Zs6j9mO1b4ej2BchtZnxXuOsbvKYrxFm6Rw1OGZnDgcIJVJl0kn/kHVttqZ/eXMTjm975UFveV5UoghjBGiG/gLvgTj2g4KSRa20zILy3owNdwY6DpIgyVgywKrqUEqjPsLede5aIVxwbtdgmKzJ+2biBvQCY15gnIzzAL2IPVdmaLUViZf4+XqrI5VNal8O+lXd7giHU6mVmKEl8Ov8G13ixOUk1SNfUhFG6o9P9j+4v4fKXNy+pwISnzMKKVT5ZGVlMlmLZyNGV4pn/yLvbhwbnX8yDh7wj5pPzo6PSBMOxp/jOO1gYC9HzlbBXIbVEUdBgElK06uJYsv60fhR4lP9ZPaihusgMKWjWfrBCVI+TjbgkYF1Cjf1IRmLmEZsCj98fpD510yJqlhvvYU8RcB4wKdxYiYoRGgOoLRX9CiAxwTwKF7z1ts0YY1t3zog4JmfPO+mpBqCBuhuQ/UJqPPSyoh4RYFYPcNLNKXLfI46rx3rDEc88S2dAgtjg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Rdigf1hAES/hOaMgYWd0FRku/AiBIm2JAxmE4J7IUgekq2x5x6FzI3FuYuCJCVmwt167DiFHiAdb+1Hvcyv+Sgy6Do+FvobzdI7NRVkYNBUynBAhK1txkP1hlfbUMCGGjA+0hiXj65IbwGyTR54LQu6Mxw9kRefWp989DiK6jlAUL1/wS7XwNzWOxxa+2hg2KQK9nLNhH7AnLg26ofvUtOrRzLIr1dgPfIm7H+Z6T7Syvudp2UqA6R/STgRZWOMIY6rg8zDCeqTdIUFupRRcFxba+pS5LRz61/u2NT9hNi+yudywCMGRjSlxFVbk2anSmIIxYJB1PkNMbcYsFchdUOHbVZgwWRYyHfH3be4rCk8wYMNjoLcGTtYxI76t7LdGmlk2vCpMgfC4HQ8IAuwwtJwLdegr27lpxSuX/42kTbtQmA+dw6L9aWB7YOvXVW6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:48:05.4849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0020a3d3-f081-4c9c-2f87-08df2e00bf62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

Implement suspend and resume callbacks for AIE4 Physical Function (PF),
Virtual Function (VF), and Classic device types:
- Implement aie4_hwctx_suspend_all() to destroy or drain contexts across
  all registered clients and wait for in-flight jobs.
- Implement aie4_hwctx_resume_all() to recreate firmware contexts and
  kick doorbells via aie4_hwctx_resume_jobs() to resume hardware queue
  consumption.
- Guard firmware destroy message in aie4_hwctx_destroy() when context
  ID is invalid.
- Restore SR-IOV virtual functions on PF resume via aie4_restore_sriov().
- Link each VF to the PF with a stateless device link when SR-IOV is
  enabled, so system suspend handles VFs before the PF and resume
  handles the PF before VFs. The link survives VF driver rebind and is
  removed before SR-IOV is disabled.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c        |  18 +-
 drivers/accel/amdxdna/aie4_pci.c        | 251 ++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  11 ++
 drivers/accel/amdxdna/aie4_sriov.c      |  66 ++++++-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   3 +
 5 files changed, 347 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index 43d26454be6c..a2b6b0fa2934 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -255,7 +255,7 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	if (has_error)
 		wake_up_all(&priv->job_list_wq);
 
-	if (flags != AIE4_HWCTX_DISCONNECT)
+	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID)
 		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
 
 	if (cert_comp)
@@ -363,6 +363,7 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
 		return -ENOMEM;
 	hwctx->priv = priv;
 	priv->hwctx = hwctx;
+	priv->hw_ctx_id = CTX_INVALID_ID;
 
 	/* Initialize io_lock guarding cert_comp binding. */
 	mutex_init(&priv->io_lock);
@@ -951,6 +952,21 @@ int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx)
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
 static void put_cmd_bos(struct amdxdna_sched_job *job)
 {
 	u32 i;
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 71ce1842bd58..33f594835309 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1107,11 +1107,258 @@ static void aie4_debugfs_init(struct amdxdna_dev *xdna)
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
+		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
+		aie4_hwctx_suspend_all(ndev, true);
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
+		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
+		aie4_hwctx_suspend_all(ndev, true);
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
+	.resume			= pm_ptr(aie4_pf_resume),
+	.suspend		= pm_ptr(aie4_pf_suspend),
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
@@ -1125,6 +1372,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= pm_ptr(aie4_vf_resume),
+	.suspend		= pm_ptr(aie4_vf_suspend),
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -1138,4 +1387,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
+	.resume			= pm_ptr(aie4_classic_resume),
+	.suspend		= pm_ptr(aie4_classic_suspend),
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 4b7367af7cf1..fdc55e498246 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -95,6 +95,7 @@ struct amdxdna_dev_hdl {
 	u32				total_col;
 	u32				max_aieclk_level;
 	u32				max_npuhclk_level;
+	u32				num_vfs;
 
 	struct dpm_clk_freq		dpm_clk_tbl[AIE4_MAX_DPM_LEVEL_COUNT];
 
@@ -159,8 +160,11 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
 int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
+void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx);
 
 /* aie4_pci.c */
+void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs);
+int aie4_hwctx_resume_all(struct amdxdna_dev_hdl *ndev);
 int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
 
 /*
@@ -176,10 +180,17 @@ void aie4_free_notification(struct cert_comp *comp);
 
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
+
 #define aie4_sriov_configure NULL
+
 static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 {
 	return 0;
diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
index e1ce633768a5..d3df36644914 100644
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
@@ -39,6 +39,59 @@ static int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
 	return ret;
 }
 
+static int aie4_for_each_vfs(struct amdxdna_dev *xdna,
+			     int (*cb)(struct amdxdna_dev *, struct pci_dev *))
+{
+	struct pci_dev *pdev_pf = to_pci_dev(xdna->ddev.dev);
+	struct pci_dev *pdev_vf;
+	int pos, ret;
+	u16 vf_did;
+
+	pos = pci_find_ext_capability(pdev_pf, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos)
+		return 0;
+	ret = pci_read_config_word(pdev_pf, pos + PCI_SRIOV_VF_DID, &vf_did);
+	if (ret) {
+		XDNA_ERR(xdna, "read VF Device ID failed %d", ret);
+		return -ENODEV;
+	}
+
+	for (pdev_vf = pci_get_device(pdev_pf->vendor, vf_did, NULL);
+	     pdev_vf;
+	     pdev_vf = pci_get_device(pdev_pf->vendor, vf_did, pdev_vf)) {
+		if (!pdev_vf->is_virtfn || pdev_vf->physfn != pdev_pf)
+			continue;
+
+		ret = cb(xdna, pdev_vf);
+		if (ret) {
+			/* Release reference on early return. */
+			pci_dev_put(pdev_vf);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int aie4_link_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
+{
+	struct pci_dev *pdev_pf = to_pci_dev(xdna->ddev.dev);
+
+	/* Stateless so the link survives VF driver rebind. */
+	if (!device_link_add(&pdev_vf->dev, &pdev_pf->dev, DL_FLAG_STATELESS)) {
+		XDNA_ERR(xdna, "Failed to link VF %s", pci_name(pdev_vf));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aie4_unlink_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
+{
+	device_link_remove(&pdev_vf->dev, xdna->ddev.dev);
+	return 0;
+}
+
 int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
@@ -54,7 +107,9 @@ int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 		return -EPERM;
 	}
 
+	aie4_for_each_vfs(xdna, aie4_unlink_vf);
 	pci_disable_sriov(pdev);
+	ndev->num_vfs = 0;
 	return aie4_destroy_vfs(ndev);
 }
 
@@ -75,6 +130,15 @@ static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
 		return ret;
 	}
 
+	ret = aie4_for_each_vfs(xdna, aie4_link_vf);
+	if (ret) {
+		aie4_for_each_vfs(xdna, aie4_unlink_vf);
+		pci_disable_sriov(pdev);
+		aie4_destroy_vfs(ndev);
+		return ret;
+	}
+
+	ndev->num_vfs = num_vfs;
 	return num_vfs;
 }
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index a6562209efd1..815977560440 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -177,6 +177,9 @@ struct amdxdna_client {
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

