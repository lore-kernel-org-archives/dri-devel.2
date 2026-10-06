Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17680CA6004
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C7510EF8A;
	Tue,  6 Oct 2026 04:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O60oiDYB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC3010EF79
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DR3BsvE6fewd78vtpFL60ld62aNI08HOkaH6/KeOeSJ0qw0MwePLmFBCRpzQUvA/WIQ7ZOJcOdI6BQJGr6rL89/DBMB1awwTG3lrItiK4timV3Ll3vL6OmF3HAjN4F0p+Q6cqZlUtGEnho9qQyB42EZGYpzqnptBqh5kpAYMascMZc55goD0X3zY9pUpI7Yp7OzIOAuIjsZm0vI4vQcWlsbr1CYoy3Z9SS85DjXrkphOwuFb1r8u3EkppXBLbtGtZA+di/au0GOxiRTEJflQ1J2J4Huhq9MpSxumasEA9OQ9UJn8C17RYmgvmZRjYMZ5nWP01qnkpSmHKUXA69x9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weR67bQFj5EI5XR5ChOaKP6vZSHrfUSzn0YjQZV7IBs=;
 b=CrFh7SR/PO5AD7rUTndNj0DEPwJtsmNh0+LDAG/jHeJcgCtSP5fBD4xMrV8wC9U4dISygKEpYSJlImCtzX/cajmtmNRxAUrzAY4W3/mCluCzRZ/a2DsEr2+T4ZUq6VoTkKlUeRBw7mbpCdtHN46hJt3qxHC/k/ZQ8YMQzNDarV6Tedvmc9qt6S5ZBJM6FWF7KTS1ChJVX9wjLilZmUAMxfVEyGa7alCyxzqajsHdH0KmpN+tpG11KWoKn7cIH0xcM990MXPxhPcEymjQ5UpstxeLLy28Kov32SvM2hioR4WD1MrNh0hOoD3M/BW4Ut0yfOQSqFFnxUQrJhuB1aNapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weR67bQFj5EI5XR5ChOaKP6vZSHrfUSzn0YjQZV7IBs=;
 b=O60oiDYB7d2MUzCJV7uR+WSePgLeLwRsA1oWgnDuevwHN6UDl4bOHcaco7Bjjij6RqsL0AewlGRotO2SOmBW9up1aPoa9C1Rv2Vnw54yQ+pHOS51fGdhlDFX+z/mj5ykfWx8Y6EVaddegGoEAdyJcZigX1lqI21RJMGX32ausF0=
Received: from CH0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:33::21)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 6 Oct
 2026 04:23:02 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::43) by CH0PR08CA0016.outlook.office365.com
 (2603:10b6:610:33::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:23:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:23:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:23:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:23:00 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:23:00 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 18/20] accel/amdxdna: Link SR-IOV VFs for power management
 sequencing
Date: Mon, 5 Oct 2026 21:22:28 -0700
Message-ID: <20261006042230.547807-19-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0259d1-bb48-4df1-2ecb-08df236182bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|4143699003|11063799006|56012099006|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: /j3PZtxE6XLe8msmo1wj6Bjhtv4Wn7S4YUuKDJsoIyjEJxLrUnOa1c7gS0e2Euwn6u3VDBUiujNwii8TVe4H7JeuFDWyll3fAai2nNDjGeITQ3NbYCWEiVNnQzmPVcKgDcb+4RsJ3KjpYGE8jcseApcGygYtiJU3C3COhZ9wF9+ab8t+9CvYyswNt+n4skEd7Hzk/QcHnyDGQSgLlN16zDnHreIFCak++MU122l+dRB7X3IKlKBM6quuYiPhO1PQv/9beuQ0eEyqiz+3dJfOgfVvje/UZzeu+/SRnjtNeC7glheuRhY46t3gHEtsnT5Vs/8/NIN7zpACUEoLW8t0Nu2FNzN+F4RumrMIv5U5KBUYF2iq4nrZMA8Ni0XTvq7UY2qE4pqk5s8N5UehjgJgv3UgM3Ui+rLF0w1lMqLHFGD9dx/lqIMPvIu7gTKdLEKcdEVQ7sIvAhWylLlpJ8JJlNTeom3VjWjAx6RvyZ63AOBu/OQmvFKE4r4pW8lq+Zj2fIP0HDztdg/rHZfRybbLXGdUPSNfdBJMCvl1Cwi8Jz7F4tTkIc5DjWqwKdu9qtqJMZRLNq+C7U42+NiltfOMGNNYnHZxhVddQBtdMR+G8mM7XEfh/0n0eiCmE6XK+xM2e1n9rMSoAETVBEB0w7VCuDmCGPHTP7FXTeEASYadp3+QEBKsiItsZRHpaXL2YLjdYCGsJOik12vIgPwhc5/FZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(4143699003)(11063799006)(56012099006)(22082099003)(6133799003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JZUziEhPpMauY3oPKwH8KO5bfjeWRXXnwK1tiqJTepl2zuFU1vIflUVBEIgP0g5+0WXlziD5ukO4iCKoJMFROZWlFt4R9JyvzdCudzqmDK+ZyR0jtL7fsAsrt7VQIB9bLzmMZPzmDLDKtNA4fIKgE1yTLSr+qe5VUP7kyI9nDKx0DKfa5HOgLVj33j7q9H4BAG5EC5XMk+OnzPpWUVhvvsnjeAqXn6neTQURqhOhdCPAXtOWhkW0XRYEqJrYGHzCVB3EHBAVCCsRhW/dzyjHjbNVyxAvTm4rY7PpXyGXM2T/dXlSmpn5zAeYEhadz5xFY9zZOkRey9SRzdfcFBrGuXjww6XZM3wWX3sw/UMkUnryhsFrCmhQy7odeuD0lj5cLsaP2VRYxBXZoiSPLb1C5LlLoJJbFMQ+bCNRwXaSIvt3LEI5NDITipnODuUW6x/s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:23:02.1641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0259d1-bb48-4df1-2ecb-08df236182bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

The links are created only when SR-IOV is enabled and are removed
when a VF driver unbinds. Rebinding a VF driver alone is not
supported; to rebind, disable and re-enable SR-IOV by writing 0 and
then the number of VFs to sriov_numvfs, which recreates the VFs and
their links.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_sriov.c | 73 ++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
index 0eea28f62676..3cad0526087d 100644
--- a/drivers/accel/amdxdna/aie4_sriov.c
+++ b/drivers/accel/amdxdna/aie4_sriov.c
@@ -56,9 +56,74 @@ int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 
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
+	struct device_link *link;
+
+	/*
+	 * The link is removed when the VF driver unbinds. To rebind VF
+	 * drivers, re-enable SR-IOV via sriov_numvfs (0, then N).
+	 */
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
@@ -76,6 +141,14 @@ static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
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

