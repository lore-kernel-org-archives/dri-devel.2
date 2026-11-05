Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFB60A2619
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ULAS4RRJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364D510E2F5;
	Thu,  5 Nov 2026 15:51:49 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BD110E2ED
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDBJQRrcUNwr3dK0Es48g3WreV7o/4TITS4QHxpUwkMEKC8CKgEh3/qArR/cuYYvbnD4j+SzR8a9awMhjpqvn8bT6892Gq8ZHUGG2FkCGehzlzvYM1MsJlKUDiKupsXqvRUGEnyuhqMl6XGu+NuOfzOLJoTWnaHZSD+RZmY0eWSflFy5l3y8RRmdW6K71lhYYqUg5IIYPMIyR/eLZL0oOmlZs23GRGB/yUme1AZovfc3MuGdkwxIxZfV4P+BpR2SyRbMVb393cNVJfv/G+VulsU3Sh5BfBob7zfW5ORxxa4OiMWpqDiIuTX2rbDY/8dJdoaFHof68QWQ8sizaFUHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb1nds3N1n1E4eNTokf+Kj95VGWvI0/rKQqniWGByQY=;
 b=o0EODFgzyG/yyNwD9gf2R/KeNjqrxhlhSofZxIQ+Ot1zAIbWtVvCxtHJ4qN7E8a90K6ffkSA8fd/gGZEn9KDpBfrNcQVn5V6nvkbnfMbQLrcVU8zgNmWoXASDZqjravyoFhJxO5k7lSDxpVS485p9qk7DN/7bcfchI4z4S+kCAAHnWUp70JDSKC/jNGcjQjSf/6t6ER2ksIne2JEoNxAdtudh/Ndld+y6bvyZTO0QA1ktSXSLfmtI8oOeFbSsuYlBvGOS4o7uV01TTuTvaW6MiGS4W2/G+rVGsv2mLoC1S1VruW9gFgauZB78XE6t3tTq6/dY50dEvCaGyI2W+Iuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb1nds3N1n1E4eNTokf+Kj95VGWvI0/rKQqniWGByQY=;
 b=ULAS4RRJ+BPxikUc1vAhhMxQxmxPD52PHyYM1d9MkkqHFwgJCmGOIVVzHYmjBFceB6hSxdanL7z++90Mv4QVE2StJw/V/VYUXAPxH1WzyqANtAYaNsDEAtPNT4zSspxUoIn1QRRng9xPGL4TexUtVpgvPqjKjl3Z3VVDEauQZ/Y=
Received: from CH2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:610:51::31)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:51:35 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::99) by CH2PR15CA0021.outlook.office365.com
 (2603:10b6:610:51::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:51:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 15:51:34 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 09:51:33 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 5 Nov 2026 09:51:28 -0600
Subject: [PATCH v2] accel/amdxdna: Load the aie4 firmware variant the PSP
 reports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-superm1-lms-npu-v2-1-ad6704226d47@amd.com>
X-B4-Tracking: v=1; b=H4sIAP+l7GoC/3WNQQ6CMBBFr0Jm7RjaKlFX3MOwoMMgNRaaDhAN4
 e4WXLt8yfvvLyAcHQvcsgUiz07c0CfQhwyoq/sHo2sSg851oVR+QpkCR6/w5QX7MGFhyVjL5kL
 6CmkVIrfuvRfv1Y9lsk+mcctsRudkHOJnv5zV5v2vzwoVNrZtic61JW3K2jdHGjxU67p+AXIn8
 Oi+AAAA
X-Change-ID: 20261104-superm1-lms-npu-6bc3bbe38c29
To: Lizhi Hou <lizhi.hou@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 026e9ba4-48bc-4b8b-4fcb-08df3b54ab1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|10067099003|11063799006|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261022115727099003|261022105027099003|261022075727099003|261021123027099003|56012099006|261021121427099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: XsY4uQAQIssoWrf5js6nWCFMJ8AMhZwzPv8X7GqmiO9cSsTyzf8xKHrMS2BRDB5AP0PEyHGOeRX6aEw/VhncGvPzQfPWiarTIZNxV6mlMKQBq1P8NEkMAXjnOUuMv4zYbxjcdpPFNARL16/WOobS/86gfpXT2PIvIRsfuq4TumeYokaBI/d44lPXtHRICCBD9SSBtQQwUzu+xIRm1wrQuOB/U+T5zZ9Tyb81LG6b5LKiroftAFFpetH8aEXCr0nSSCeQpu8boa4ndNppUFRbCQQovemSkXYXGOq+Cj4XO3Fo6LDFhTIhiWSj1uhTdFREWP5e1gLu3oAzPOWePoN7hcnrlAe3aIgVGr5rxK/zwHX7hyQVr9IbXjtDZ4NIkvSG5QEO0XqkLdE6RGVuyMpa233y7yteTa4MVYZDyN/Q+7MAr+iBIP05cKY/qn3lPdLnOznH4Q3ltaTGY+NygZDXY9IjoFl4F1M6O3nkMZ6UTWkoZ9fZvzNi/tE3HaKu+6pM8nWMuh1+uXZiFzOYD+L97H7UFysu2AW3gYBVXsrfxTZalGIPrEEeHFApBs74TCn1x6KMd0LpamXNJYTx/VN0Ev7tLTfuwKldNu2H9sVpgDrmOTWTfxScN6yM5Kiast8e0zToiMziz+RpLivqcdfMtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(11063799006)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xTHUz3bEU57lytdKcTkuPfDjLa6tqQtS+nvu/dqHdAXfT/hox4bvcUI9eyL5CVbpOyOAt4oUUpzSCuhLyJ7gwD5mONWKBcJPzUS6B2jR/GwSBP9iWiZpCUosWgWleoby9ylWBk2wBg/iLfhMKBNp6XmQUU4QbfisSYEeVQ5N6nVXmScMna3XvTtvOrH+i7UAcHEI7ha6gWzKd6KDwP+Pw9gmIYKKNCumw3aUOEm2f/C0n/xznKkSXQQ1v+NXUuFJcGXpZpe56JyTJ+W6eHY5SseqbhQX0PT5zZQU0oHc1pPRIFcFyQMADA+CLixzBV9oyd/zSDhImrUoEhLUlM5J8wbHt40zfN23qGUKDPvRVM83+EV+Fz2TzavjRHy/BNVN5mn6QpvtOj4vP78V4X4jbpCdSjqmFgcn5ZgvMjlfig1SM4xS0bE4EjJKCAyIt018
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:51:34.3651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026e9ba4-48bc-4b8b-4fcb-08df3b54ab1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some Platforms ship BIOS with either a default or an alternative trust
authority. The PSP validates the NPU firmware, so it must be signed with
the matching scheme. Firmware for the alternative scheme is named with
an "_l" suffix before the extension. A preproduction part needs firmware
of its own, named with a "_p" suffix.

The PSP reports the signing type in bit 6 of C2PMSG_63, and in bit 28
whether this is a preproduction part. A preproduction part that also
reports the alternative scheme is not expected, so warn about it and
use the default firmware.

Add MODULE_FIRMWARE() entries for the "_l" variants of the npu and cert
images of the aie4 devices so that initramfs generators include them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes in v2:
- Initialize val in aie4_psp_fw_variant() so a failed SMN read can't leave
  it uninitialized
- Only read the PSP firmware variant after the npufw/certfw path check, so
  VFs (which have no firmware paths) skip the SMN access
- Drop the redundant all-ones check, amd_smn_read() already returns -ENODEV
- Link to v1: https://patch.msgid.link/20261104-superm1-lms-npu-v1-1-dbffcc5abc23@amd.com
---
 drivers/accel/amdxdna/Kconfig           |   1 +
 drivers/accel/amdxdna/aie4_pci.c        | 162 ++++++++++++++++++++++++++------
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   8 ++
 3 files changed, 141 insertions(+), 30 deletions(-)

diff --git a/drivers/accel/amdxdna/Kconfig b/drivers/accel/amdxdna/Kconfig
index eddff490b4f75..cd17a89cf4146 100644
--- a/drivers/accel/amdxdna/Kconfig
+++ b/drivers/accel/amdxdna/Kconfig
@@ -6,6 +6,7 @@ config DRM_ACCEL_AMDXDNA
 	depends on DRM_ACCEL
 	depends on PCI && HAS_IOMEM
 	depends on X86_64
+	depends on AMD_NODE
 	depends on AMD_PMF || !AMD_PMF
 	select DRM_SCHED
 	select DRM_GEM_SHMEM_HELPER
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 02dcb2f813d45..26c6162893760 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -11,6 +11,8 @@
 #include <linux/debugfs.h>
 #include <linux/firmware.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
+#include <asm/amd/node.h>
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
@@ -558,46 +560,124 @@ static void aie4_classic_hw_stop(struct amdxdna_dev_hdl *ndev)
 	aie4_fw_stop(ndev);
 }
 
-static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
-				 const struct firmware **npufw,
-				 const struct firmware **certfw)
+/*
+ * PSP C2PMSG_63 (SMN) bit 6: 0 = default firmware signing, 1 = alternative
+ * PSP C2PMSG_63 (SMN) bit 28: 0 = production part, 1 = preproduction part
+ */
+#define AIE4_PSP_C2PMSG_63_SMN_ADDR	0x38109fc
+#define AIE4_PSP_FW_SIGN_ALT		BIT(6)
+#define AIE4_PSP_FW_PREPROD		BIT(28)
+
+enum aie4_fw_variant {
+	AIE4_FW_DEFAULT,
+	AIE4_FW_ALT,		/* "_l" images */
+	AIE4_FW_PREPROD,	/* "_p" images */
+};
+
+/*
+ * The PSP only trusts firmware signed with the scheme the platform firmware
+ * uses and a preproduction part needs firmware of its own. Reading which one is
+ * in use is optional and only used as a hint for which images to try first:
+ * anything but a clear answer is treated as default.
+ */
+static enum aie4_fw_variant aie4_psp_fw_variant(struct amdxdna_dev *xdna)
 {
-	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
-	char fw_name[128];
+	u32 val = 0;
 	int ret;
 
-	ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
-		       pdev->device, pdev->revision, ndev->priv->npufw_path);
-	if (ret >= sizeof(fw_name)) {
-		XDNA_ERR(xdna, "npu firmware path is truncated");
-		return -EINVAL;
+	ret = amd_smn_read(0, AIE4_PSP_C2PMSG_63_SMN_ADDR, &val);
+	if (ret) {
+		XDNA_DBG(xdna, "PSP firmware variant not available, ret %d", ret);
+		return AIE4_FW_DEFAULT;
 	}
 
-	ret = request_firmware(npufw, fw_name, &pdev->dev);
-	if (ret) {
-		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
-		return ret;
+	if ((val & AIE4_PSP_FW_SIGN_ALT) && (val & AIE4_PSP_FW_PREPROD)) {
+		XDNA_WARN(xdna,
+			  "Preproduction part with alternative signing, using default firmware");
+		return AIE4_FW_DEFAULT;
 	}
 
-	ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
-		       pdev->device, pdev->revision, ndev->priv->certfw_path);
-	if (ret >= sizeof(fw_name)) {
-		XDNA_ERR(xdna, "cert firmware path is truncated");
-		ret = -EINVAL;
-		goto release_npufw;
+	if (val & AIE4_PSP_FW_PREPROD)
+		return AIE4_FW_PREPROD;
+
+	return (val & AIE4_PSP_FW_SIGN_ALT) ? AIE4_FW_ALT : AIE4_FW_DEFAULT;
+}
+
+/*
+ * Images for the other variants have a suffix before the ".sbin" extension.
+ * Returns -ENOENT if @path has no such variant.
+ */
+static int aie4_fw_name(struct amdxdna_dev *xdna, char *name, size_t size,
+			const char *path, enum aie4_fw_variant variant)
+{
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	const char *suffix;
+	size_t len, base;
+	int ret;
+
+	ret = snprintf(name, size, "amdnpu/%04x_%02x/%s",
+		       pdev->device, pdev->revision, path);
+	if (ret >= size) {
+		XDNA_ERR(xdna, "firmware path %s is truncated", path);
+		return -EINVAL;
 	}
 
-	ret = request_firmware(certfw, fw_name, &pdev->dev);
-	if (ret) {
-		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
-		goto release_npufw;
+	switch (variant) {
+	case AIE4_FW_ALT:
+		suffix = "_l.sbin";
+		break;
+	case AIE4_FW_PREPROD:
+		suffix = "_p.sbin";
+		break;
+	default:
+		return 0;
 	}
 
+	len = ret;
+	if (len < strlen(".sbin") || strcmp(name + len - strlen(".sbin"), ".sbin"))
+		return -ENOENT;
+
+	base = len - strlen(".sbin");
+	if (strscpy(name + base, suffix, size - base) < 0)
+		return -EOVERFLOW;
+
 	return 0;
+}
+
+static int aie4_request_one(struct amdxdna_dev_hdl *ndev, const struct firmware **fw,
+			    const char *path, enum aie4_fw_variant variant)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	char name[128];
+	int ret;
+
+	ret = aie4_fw_name(xdna, name, sizeof(name), path, variant);
+	if (ret)
+		return ret;
 
-release_npufw:
-	release_firmware(*npufw);
+	ret = firmware_request_nowarn(fw, name, &pdev->dev);
+	if (ret)
+		XDNA_DBG(xdna, "firmware %s not loaded, ret %d", name, ret);
+
+	return ret;
+}
+
+/* The NPU and cert images are validated together, so both use the same variant */
+static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
+				 const struct firmware **npufw,
+				 const struct firmware **certfw,
+				 enum aie4_fw_variant variant)
+{
+	int ret;
+
+	ret = aie4_request_one(ndev, npufw, ndev->priv->npufw_path, variant);
+	if (ret)
+		return ret;
+
+	ret = aie4_request_one(ndev, certfw, ndev->priv->certfw_path, variant);
+	if (ret)
+		release_firmware(*npufw);
 
 	return ret;
 }
@@ -645,18 +725,40 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
 	return 0;
 }
 
+/*
+ * The firmware can only be started once. It is the PSP that decides whether it
+ * accepts the images, and it does that when the firmware is started, so there
+ * is no trying a variant and falling back. Pick the variant that the PSP
+ * reported (the default one if it can't be read) and use the others only if
+ * its images are missing.
+ */
 static int aie4_load_fw(struct amdxdna_dev_hdl *ndev,
 			void __iomem *tbl[PCI_NUM_RESOURCES])
 {
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	const struct firmware *npufw, *certfw;
-	int ret;
+	enum aie4_fw_variant order[3], hint;
+	int i, n = 0, ret = -ENOENT;
 
 	if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
 		return 0;
 
-	ret = aie4_request_firmware(ndev, &npufw, &certfw);
-	if (ret)
+	hint = aie4_psp_fw_variant(xdna);
+	order[n++] = hint;
+	if (hint != AIE4_FW_DEFAULT)
+		order[n++] = AIE4_FW_DEFAULT;
+	if (hint != AIE4_FW_ALT)
+		order[n++] = AIE4_FW_ALT;
+
+	for (i = 0; i < n; i++) {
+		ret = aie4_request_firmware(ndev, &npufw, &certfw, order[i]);
+		if (!ret)
+			break;
+	}
+	if (ret) {
+		XDNA_ERR(xdna, "failed to load firmware, ret %d", ret);
 		return ret;
+	}
 
 	ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
 	aie4_release_firmware(ndev, npufw, certfw);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index f233eb70a2957..dab8603e2381f 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -37,6 +37,14 @@ MODULE_FIRMWARE("amdnpu/17f1_13/npu.sbin");
 MODULE_FIRMWARE("amdnpu/17f1_13/cert.sbin");
 MODULE_FIRMWARE("amdnpu/17f2_13/npu.sbin");
 MODULE_FIRMWARE("amdnpu/17f2_13/cert.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_10/npu_l.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_10/cert_l.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_10/npu_l.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_10/cert_l.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_13/npu_l.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_13/cert_l.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_13/npu_l.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_13/cert_l.sbin");
 
 /*
  * 0.0: Initial version

---
base-commit: e32e83a6c5ec031a7f59d4794113d8484b220254
change-id: 20261104-superm1-lms-npu-6bc3bbe38c29

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

