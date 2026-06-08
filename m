Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38929CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA6410F6A5;
	Mon,  8 Jun 2026 16:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eAJ/a0tK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A590A10F6A5
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmGFB+qpigP3ecAAeJqtTvwINaPTh2pnbzHHUd4I2Z0jvJEMdLiK5yRlC0Vqg9Ya9y2ZCBaiA2jrqFY5uvKIyXbBrLtVl001eju3bl7QbaKEf/3JN5eu55sLnoQfdp15aUEGpwGeUczs+/vVUa+mUcYsg5MIQA30eznWNzur1U+rcI/JTp8HP7EbZuLLRrk466gqM3JHUHxWpLe7LmU4qvwWDiFBwJfW1cuCX2/9xBxMCWpz0jFmHLWSx9bTu3dX5OB7YDaeyw6TNwxJz69VgfY2XEoWcHMDLAfBVuWX/Mae9YKuvnIZLhAQ19kHbONY5ny7jD4fFOAw2uOD6LU/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fclyj+euD4HrZFoNa3W5SAh1zLVQdFMOlX78KqxN7Uk=;
 b=QFUK59vYaXQClqxiASnw/BnTyKSWpERBWmPTLgALOr8rKvk71MnhRrpK5YrbSmTFFdoJH6e9SEJUdnfa7Na94mbitWxw7j22xSwFet46XpSvlULk96GA0gpj2DnRhekoR9hPymWL+EOSo9+EVYwBo7QmjylxRCnsohch+C+yBmOW9hTRGU9a/Oa8ySzNuYUA6Cgsa8dufqCU++CCtTXuEu/gmhFtJ+PxRVy7shNZqXF7vSt6iMFiqxak8lCqkktxM08CDiwFgS5vNDSl8piJf+6pg7gTiajy4Z1T4fojpmXC1S4QsM4QnPx6yeccSW439bMmRoPvm1PoqASxaRkrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fclyj+euD4HrZFoNa3W5SAh1zLVQdFMOlX78KqxN7Uk=;
 b=eAJ/a0tK0CbUFlq6Kg+r31yCspFlFo4hACgNTU3hQJ1p+4raki3zc7M+MOn6wYFGwd2KvIT64Vm2n+uZfMHFwGJfHKnxReQGcEEuZrfcCMcX+qTvvPlLpOwPpsD8qI9HcRSbDrTQRxz6NBq7jegQoiN0Y5aLAHbJnGbzXhGugxk=
Received: from SJ0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:a03:3a1::12)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Mon, 8 Jun 2026
 16:14:40 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8d) by SJ0PR03CA0367.outlook.office365.com
 (2603:10b6:a03:3a1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 16:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 16:14:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 11:14:38 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 11:14:38 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2 1/3] accel/amdxdna: Fix amdxdna_client lifetime race during
 device removal
Date: Mon, 8 Jun 2026 09:14:16 -0700
Message-ID: <20260608161418.2748988-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be41176-1ddb-4a0d-1a06-08dec5790b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: FeFBpA8SZGDBxc2VH+kAoh1DlRSI9p8qkYkmPJzEwCu6pmBzGrvEUUOCV5Mp391olZyw0Ahwd1Zikd7b07zNRe0t3ADO1ud3bLyqGNHzp97njisLYF9r/7iPr0O0of3Z/VQ37Jp17ZJft7qOC2rsbph4XhOirmXSX+cKclLJyQ0gpzDX2BWikJ+QJLGvsyBEKMpD2w9dlpkjBL1ZzYD3t7mEGhE1jZWDfdNmzqw0oMPmfTrCB9L3n8UPjNEJy1pTbWF4i/+Lz+auFbmF4OloJi31ZVVgUaCV/TH3A2geHg2OPVIBBwt2jo8oiisPp0Rzvyv7E5k4dyyM/llF9u56ndk7a4NUEyMJx57YEydXv6U9vNML1/8ppUX/kpNKlNyA4mQdG5LwHqsDUh1gpbqoDeYhn6hX11otpofAsRbbFu6uYorfaFBIR/gf7svySL41rxK/HIfVs/l9jRe6dti2/pKsUMAbd335h5cq/qKS7VqDeXBddc5QtoyTqx237/Ab8kHRuxew115PCQuoCPycVqhCIGQuMHWeWZ0MHj/SxJvmK7TdAFtBvHR/GQ39qnHDaYnCI9RkM/JujjZEPeT3qLVNkTW84F8lE28m8yJhnceh/aEZ/qU2ZV8u5Xw7AX8gZFb8lg9pMJwkv8urCIL8uKFNAdQ5rGuSYDDkDMGuQCsw8430z6gAXmEH1LpYDJYKZHMyZ3QFVjF8cggLCdiPgtfxOHe7hRnVCr2XRa1JVw4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zIoAT4KI01q7pZHk/s013azuYCBdFws4RkO/FdorH0C3FhCBYtrNNCCK8J1tPFtzVM2gbUsrjZ/fVQtnsR/Q0zWcmVAKPfKAcjJgBO0OM0JZGHabCmKV5Om98LZJVc32m3IXMBYPTQLN2ouTN+5RUhkh5sRfd9EGQNYduvtLoPgaXaWUjNP2O3rB3/Rs9LxpmP1QLB+REJns9eggPWgCPT+qFNanvUuaMc5OPJA4/gFXlD4tiK/3CV5WoAQm0kf2NeHIaPp9iD2iRH9/2Nd4DLAUr4YKRRX4mqTNcMiakLo6uA5btOrQ+6fNmmDYBvbZRKKUbnRGuZpSNzILz5E29tkQQlMaFxPFfouNb4oUMURL/dNl60S+Zzmh8zYy+x7uLesqUYpQwdbcGPxbjI1Rv4JCCqcJsAlpC15H+mMO24FWqhW/9OgW7+n1uVAAiYfn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:14:39.8649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be41176-1ddb-4a0d-1a06-08dec5790b08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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

In amdxdna_remove(), all amdxdna_client structures are freed after
calling drm_dev_unplug(). However, drm_dev_unplug() does not force
existing file descriptors to be closed, so amdxdna_drm_close() may be
called after amdxdna_remove() has completed.

As a result, accessing client->pid for debug output in
amdxdna_drm_close() can lead to a use-after-free, since the access is
not protected by drm_dev_enter().

Fix this by moving the debug output after drm_dev_enter(). Similarly,
add the drm_dev_enter() protection for amdxdna_drm_open().

Fixes: be462c97b7df ("accel/amdxdna: Add hardware context")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 1f066ed8d236..a22c986f1b33 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -108,10 +108,16 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
 	struct amdxdna_client *client;
+	int ret = 0, idx;
+
+	if (!drm_dev_enter(ddev, &idx))
+		return -ENODEV;
 
 	client = kzalloc_obj(*client);
-	if (!client)
-		return -ENOMEM;
+	if (!client) {
+		ret = -ENOMEM;
+		goto dev_exit;
+	}
 
 	client->pid = pid_nr(rcu_access_pointer(filp->pid));
 	client->xdna = xdna;
@@ -125,7 +131,8 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 			if (!amdxdna_use_carveout(xdna)) {
 				XDNA_ERR(xdna, "PASID unavailable and carveout not configured");
 				kfree(client);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto dev_exit;
 			}
 		}
 	}
@@ -145,7 +152,11 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 	client->filp = filp;
 
 	XDNA_DBG(xdna, "pid %d opened", client->pid);
-	return 0;
+
+dev_exit:
+	drm_dev_exit(idx);
+
+	return ret;
 }
 
 static void amdxdna_client_cleanup(struct amdxdna_client *client)
@@ -175,11 +186,10 @@ static void amdxdna_drm_close(struct drm_device *ddev, struct drm_file *filp)
 	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
 	int idx;
 
-	XDNA_DBG(xdna, "closing pid %d", client->pid);
-
 	if (!drm_dev_enter(&xdna->ddev, &idx))
 		return;
 
+	XDNA_DBG(xdna, "closing pid %d", client->pid);
 	mutex_lock(&xdna->dev_lock);
 	amdxdna_client_cleanup(client);
 	mutex_unlock(&xdna->dev_lock);
-- 
2.34.1

