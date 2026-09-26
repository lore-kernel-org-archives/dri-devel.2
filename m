Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D398C98338
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A2810FD0F;
	Sat, 26 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OXrOz+6D";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4343E10FD0C
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnF7dLuOfQU/7Lv5DobS0SS3UXjzskXu5xvK4PLYitwcOHNdGKZrxvugBWoP9T16znTJCNpF4q3ax41D6L+O0gtEYkUfrAsXUPIcXNIlLwA+dbhNXX3zHb0K0aj8hF4muSF8fZAqmHsrPr1D+yoqxf5HTn5b85dbjUMeEWE0r0dcERWvrvP9MsAf3C4rBqt5o3GzejXfjRcGC8+pr56nW9A6ThN7s6A6uRaCVoDzzlvRNsm3efwv4/VJX1QRfbsnv7woCvqLboKF8jBYuV3z+mtQJdQzlxul5C/05BioFKRQ0vJRl4ARijN+e/7DjA5T7Fj3vlQ4nyR0DTldcH6sgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0MiSvFoVRudiCEX2TkCxuQolP3aft8yoAALBZLybtc=;
 b=I9PFRS52Md+azzyMe6iBXFFmp19viqbY4L51EpAxBzM7p0WTADb+EhBSMY9Hl3VWwVqN2SVug8PAKjPH3Lx6SKOK78gHXvGlRH6fSEzxbWXTOPW037ExDwypnCaAqbVSfP18sCzn78Q4FgMcMS7iD3GPUunj5VrUyvIEyM1qeS4opxNruGMP4g3iWcHWPhNIdsiC/mc935qo9PFCphQlLFZKs9e8Ld12jaJrOHoHa07d0y3GHl+or/GH3IeDqIuCxgF3R7/kGtz745x0mTL2WFtEK8gF37+3QPAHw68jkgoOK8dtc1FgZD+gBEuhJ+ieCk53djGQy1CX9uEh1pIvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0MiSvFoVRudiCEX2TkCxuQolP3aft8yoAALBZLybtc=;
 b=OXrOz+6D1apRBh3op7m5nymScBHZ2ZKwKTAto/vvnKLAmRuDub0fdSByyhMu3CujVW/WyBAVibbRWQSzy0ePdN9Zhg0pmJKUIYT0Tu5tgRH3PNVxps15N8NUOWA51PsvPZ+WsL+5jFjoV/mN/xCIHTnX1TmBp7RqqaczwXfAPT8=
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:34 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::98) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Sat,
 26 Sep 2026 01:35:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:33 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:32 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V0 19/21] accel/amdxdna: Link SR-IOV VFs for power management
 sequencing
Date: Fri, 25 Sep 2026 18:34:46 -0700
Message-ID: <20260926013448.3840921-20-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 93275815-1965-4d57-33d4-08df1b6e75bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|6133799003|18002099003|10067099003|11063799006|56012099006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: RWwaRePwVZX6fRehCqz6cB1lhJ5AnK/DqKvnUWod5ehEjXYRlehUu/MBtcogN/M+LiwNK9JrFYEU4wRnQiEo21M+FBeecysHjy+N3x+kjqWjw5KJrSiVsAKtf8gc59Oyq06FT/GKNuYNLHHlhyj/hRR1z2NHENxYevICoPvvHTyVHz1PnT/g8QdT6DUMONlRiFWEastMovpDis/gPptVS/NXOvR/ODvjYxQ0rt0yDF56cdaenGUSd3JRo44HMZaIDUByX0DX9GcJc8wS9N8uvkERfgi/O8NfQ9azzrHKAzavRv7JtGRa10Ne9Hq+BBEEGI+wSANxppyhfEJEihwx7m0WofaOm8tnBJZ/YZGYbNVTpE+wXOXxq1OaBVXnPA+Y7kuDuwPl7FqQVCD4qaCT5L8KpbaXT6nG6M3CwnvmNY8w7ittVdRw6efOABFD7MI2oRj+mJllPC455+YoariWbl+Dri7zLzPYwHzNue7LPnb21GwAXtFV7BM35r8/tRTHE3swCuhWP1bVDmwvbvksAVj8Ra92SxxMjznX1nFNvjX1uybx0mDqaHrk4wRKIzz8SHy36Tf9gKOViQBRQELCC9/htvx4XU7/nP850l1solFOOe84jp5xzkEeB1LKjdzqM/RSdQkLVJ1o7ffWevu1WMk3UZcJbGvRjRS/bwGpkrDdVH60x1bRdMBaWeHNkPOjH+evo4IOXGnuYh9DhHNWfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tn9b9rMhKbjYDOqNNl4M+HzBX3GpiykC9eeDAwYS9/GCn68AUT1k9R26jwt1lGJswEcMpF+vhNUsuCucXPnDW2jJtndGdojaWbxBZWAPY3sVq2qIKWSgZH6SQ2m6ArDAYhA81uoA36ZH4nwxUOuOfWGr2UGGSdp1K6n1OAv4rK5t8ny84Z5xUQaBfw3mY6T6fXe3gpMpKo6VKGly8abwMcNZCVJLsBcwGLzCqzWtY74EuaKarztJr9UbJwZrw36A+o3XIhx0e+49R856vLSJjsXB6P+1MuGHsz9hbgqFXw4lMPFAgQgIIeXJFlN0HCnS4obLdjTu9+WMPo7utLyjbpzvcDrYdop0oMLkJx9OaItUwXDcgLVvNjKmcqxswUGO7itUJQDPQaLS1XPJuC2KlYS9KF3J94ykJdwQuO9xCRvKlgfU+bQM3HeXytHPGVCE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:34.5013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93275815-1965-4d57-33d4-08df1b6e75bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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

