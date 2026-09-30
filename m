Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DF7CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD7510F164;
	Wed, 30 Sep 2026 03:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cn0Dxlf0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FA510F159
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zpz4K44epGRqu54I5S/I5BSjhCINdQmavRcmemi5sAk1ZVi3FUll72LEjJBNyHvi3TxedmC04o3G0QSKmKdlCvdh6eQ9AgChbhavQbVaiC9+FqTdvCs3fhuem901J33Jqg6VRKLLes/njz0QT55Y4d8+f76d30hsN6KVHrPNo00/94CTLgRiIJvZDRGcqw4UXPnBc8kqRlFFXAl3BmP8iusXGx1WDnerFGqwFWMjRQ5Qgs23PflTOrl41Ynb0pZoOBNeWKV7dvBXbRpvql26gTiQUmNIIZWbXmIE12r+nJA+9zcd0AO+uKu6ftoeHFpW/JUo+SdG9v0Cf3MeqKp8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0MiSvFoVRudiCEX2TkCxuQolP3aft8yoAALBZLybtc=;
 b=tyGThk6BaGkV+kOIJ47KK7q8ZoU4GBPbSxmewPNQFQWgoeA8k9NQU1/0SnIoDdUUO0LIYOmC/fiQQeODQixy6Oa/Uo5XZzyB5PDVCtsHS9C73X+NA3jge9YpV19cMWBVYx8NVI2rqBkpxmq0/A8qnktXJWA3TF+7KhEHMIgvdaWrbsp4aFM3rOwMkEeDPWHuhcgTU0f3l+GyyqJjNMDR58fO2C8arbJR9TkUNsz6C2MyUADvU076AenzDzb+gAQcG/JvH0Xa/c9ScoucXE0udKbXaXX4+FSS/mkCJ8n0j7SPJ5uBtxKqmbUvqhS/4k8d0tirTkIoP53xFspJOnH+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0MiSvFoVRudiCEX2TkCxuQolP3aft8yoAALBZLybtc=;
 b=Cn0Dxlf0w1/1xiPrCUhb2jbU1YlQwFG1hojaTFX9doQV9FkS+DUfaIESli67hsj1K8qnfHTI4PSJ81GeLYNLcj7AkjtOBYtwT1ZcZm/3Pf4Df2SCXzU/96sMgLSQ/2a2p7Fi1cD25CGK4gEnERRofA2H/0ZRJrUXapUn/uvg21s=
Received: from DS1PR07CA0016.namprd07.prod.outlook.com (2603:10b6:8:44d::19)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 03:33:06 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:8:44d:cafe::28) by DS1PR07CA0016.outlook.office365.com
 (2603:10b6:8:44d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 03:33:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:33:03 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:33:03 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 17/20] accel/amdxdna: Link SR-IOV VFs for power management
 sequencing
Date: Tue, 29 Sep 2026 20:32:30 -0700
Message-ID: <20260930033233.1727265-18-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 259e6b4f-8b2a-439f-e11e-08df1ea38a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: G8mklPHb75Bntmk4byR0czwsfydyj/B9zPxPoRzS+rQ41tiG7fobyG1bjbhqxiT/qs+Cy2ywDUMtPKH9mHDcEiArOYD3QgGEgvXl1vtdcDI7j+Ts2dUWg0UWzZo9V0mwNm2FVdJq0Z3cUi3nT15oCLKNAZ9AAhlYw4C8ClkdBevNw19lbqlHadXgcSKa2cQMrWcUNw7WziVPl2by4a+IraFYi9SheCfqE6oE0vKJvkbGVGonSl3VKWdktIO/PLCAwq92/Cq8TrnMcUYTpoR8GIJnHxuETW7A/vBLdT4nwIpnJMPybNsDMmRayVvjJ2qUJTTbHaE39RNYBwt6XCSK8CycCl7LieKrM3bWaHNcW0i0oUNQ+xaimXJbW4SI/AAcWa0dOKBh+AXN4vOXrVv8AhNqfDFhqTMi7TLW35CM2mm2KZRI/ZmiYWtCsvQb1tXP3hMLQf7h37sxxMf3TssXOzKwi4vLM47xUujNctNd2pN0pCa7yRqetmiGgH5obXQZYWBlw8Nn7gbrW6fsLcWSXHFLVnrFMRqilKiUm/Zkr0dg+v3/BcRMnZkxnzFuLEcFhsih0KQEz0CRjcsE2lyDx2ql7BUGnA9ytQkE912wzAx7PR51nzVjB3Ei3HW9KDFl9YY8rwmmFxzZuMT86jxXgszwoHUHbfhDgO9wGwFpvfy5OjQsHL7A0V6LvH7WSx3I8bJVsqbwejOCZWU3k+iCuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aMgzPaapamxa4zQ5UAJoFdT4YC2iN2NqEEHKf8pLNsu9eByfHeN6oc2o39cdXrvFM4za9EM8NgZwTH+izZGQVCpbsKOJY3XJnuJyLmIi3MnVf1XLYp4H7P32tqQfu/zGwmoKsoHQ0wzd0bPf8WHpYrn/h8MOO0LkASTxHOZpD9xdxw93jJmxA4GL9qQTs7fnUaY+NuOj04PHaeTz2OC4koQk3ul8TpF9ea/VDqrsomTYaHinXM9anQNoZTG6tzrB0r0IWlVMFXH7USp9VDLyvNxQQpI4VuGyPUjqO6uS2BHKzoUJ9IwCu5z04coRCIHlfv0oqArYUFuvWSou78LSnq78Ma8czDI6OGUOgU922+4skQAvCSZKEoizYW5nMGyOJFMvG8e0SVPrOQ/j1g5IpdO2lypT6SMcrkZD0NmEwq4EFZVL9HvjE+oBUIJXLM9r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:06.1826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259e6b4f-8b2a-439f-e11e-08df1ea38a83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
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

Add PM device links between Physical Function (PF) supplier and Virtual
Function (VF) consumers via device_link_add() upon SR-IOV enablement.
This ensures the PM core enforces the proper power management sequence:
suspending VFs before the PF, and resuming the PF before VFs. If linking
fails, roll back SR-IOV initialization.

Also add a comment clarifying that pci_disable_sriov() removes VF drivers
before firmware VF contexts are destroyed.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_sriov.c | 74 ++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
index 0eea28f62676..bfea6ff00ec0 100644
--- a/drivers/accel/amdxdna/aie4_sriov.c
+++ b/drivers/accel/amdxdna/aie4_sriov.c
@@ -56,9 +56,75 @@ int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 
 	pci_disable_sriov(pdev);
 	ndev->num_vfs = 0;
+
+	/*
+	 * pci_disable_sriov() removes VF drivers first; call destroy_vfs after
+	 * so firmware VF contexts are not cleared before VF drivers finish cleanup.
+	 */
 	return aie4_destroy_vfs(ndev);
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
+			/*
+			 * On early return the next iteration never runs, so
+			 * release the current device's ref manually.
+			 * On normal loop exit pci_get_device() returning NULL
+			 * already releases the last device's ref internally.
+			 */
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
+	struct device_link *link;
+
+	link = device_link_add(&pdev_vf->dev,   /* consumer = VF */
+			       &pdev_pf->dev,   /* supplier = PF */
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link) {
+		XDNA_ERR(xdna, "Failed to link VF %s", pci_name(pdev_vf));
+		return -EINVAL;
+	}
+
+	XDNA_DBG(xdna, "Linked VF %s", pci_name(pdev_vf));
+	return 0;
+}
+
+static int aie4_link_vfs(struct amdxdna_dev *xdna)
+{
+	return aie4_for_each_vfs(xdna, aie4_link_vf);
+}
+
 static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
@@ -76,6 +142,14 @@ static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
 		return ret;
 	}
 
+	ret = aie4_link_vfs(xdna);
+	if (ret) {
+		XDNA_ERR(xdna, "link VFs failed, ret: %d", ret);
+		pci_disable_sriov(pdev);
+		aie4_destroy_vfs(ndev);
+		return ret;
+	}
+
 	ndev->num_vfs = num_vfs;
 	return num_vfs;
 }
-- 
2.34.1

