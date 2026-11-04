Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B7606AC12
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kLHwYUaT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E9510FF56;
	Wed,  4 Nov 2026 22:18:59 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C2D10E27D
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JltLpLV5CBNPf21XeZJllvEcBlzSUEK545/CfRDbASepF/40dCa54gu4DRhqr116vOm5QDoJ8BH7oMfbBk/BWM/xV9cMHuLhUXcZxFb45eh1lmpVxtY6Uen4RCdoSjdswXes5id+wKgy/vtY/hWrnDvO/zUlHOQFp4VUokNvtcWOOAsvoO2TZ2LqmJmbJLNbYnKDT6gSnOg0m3jZnxEi1gebKbT0A07O1XnPP7tT6UnwzVUSlF7c1mCV/o88m23eq4/Sl2x2qyY0ahproySGU3FVkD5Vxc+NBMNwZd6RQsg6vj8xLw8O8aBOB9n2LyG49qBcRbvPB7i+Rkivxcg0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rQUyUQYft7eX/sEgDEjd3ESFb8ULSqrSx2i93/MEas=;
 b=UgM3Gfj8rVNkp2oq4yDCwDDHENM6BZjd1z6Mah5AETJX3RNfBP3jjWfIBa83Q8ajVtYgn3ZpHVBjBGTWLyXUCn3etx+S1RiwFSeokxvesrfnsBPm3z4k06QGTnldmP+2r86PjdJP1dD+kEcUFPujw8dYOnO9DP2po/JNE5NRWnVf4VKDv+6ngYty4xz8DKHpwnAHfkA8vGsig7ZyZ7TTaOfPJ+pfRQhBjcpEmqehnmpZBLpPGYLGnMxZBZLOCOtITquzaa/Z0Mo6dic3yW0quwoWkXp+TiAweZaEsxZ9cLvjpUSgmoG0xvnhNkDpXK6ewsPLc3Xx0IsheFdm0ZoKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rQUyUQYft7eX/sEgDEjd3ESFb8ULSqrSx2i93/MEas=;
 b=kLHwYUaTIb0C4SC6AgiNnSoNxNeiOYw1yEtwcp0jJj1u7UragfyEuiVPTJbsSX4y+Fk+3YqN2/gRFSq0aEQnjaSoNzKn26IY+s3nuEKIY32wHblDS0TZwWdCn7ENXlXhMbQrlDHyv5IIcObX9KwUetkewOxJp/v7oB80TYFJiSA=
Received: from CH2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:610:51::17)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 22:18:44 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::6e) by CH2PR15CA0007.outlook.office365.com
 (2603:10b6:610:51::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 22:18:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:18:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:18:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 4 Nov 2026 16:18:35 -0600
Subject: [PATCH] accel/amdxdna: Load the aie4 firmware variant the PSP reports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-superm1-lms-npu-v1-1-dbffcc5abc23@amd.com>
X-B4-Tracking: v=1; b=H4sIADqv62oC/yXMQQqDMBBA0avIrB0wSZHqVcSFidN2isaQMSKId
 ze1y7f4/wChyCTQFgdE2lh48RmqLMB9Bv8m5DEbdKVrpaoHSgoUZ4XTLOhDwto6Yy2Zp9MN5Cp
 EevF+H7v+b0n2S279beA8L8lBmnxzAAAA
X-Change-ID: 20261104-superm1-lms-npu-6bc3bbe38c29
To: Lizhi Hou <lizhi.hou@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: d3266948-7523-4306-950d-08df3ac196e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|10067099003|11063799006|261021121427099003|261022075727099003|261022115727099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|261021123027099003|261009223027099003|56012099006|261022105027099003;
X-Microsoft-Antispam-Message-Info: Y1ZnVhnNFjueW35oDludX5nP7vt8hMM7V0mXyWxGehstHtrmBPGglsWQPMa4N3h1cyd8VmMcEkI335wzRx/yw/hFx5bH4EG9LZn8dmUqFBqaer9Z6J7zjIPiE0Q+YsmarKkq1156xZt6Vwl1UKP9GznWWa6Ysv+tsMG8Hx0LiJBkY11UIcLRK/8MpIQgZxwWqPzGNkiy1Ki0S5KTKxnhP0Gr2llROz3ZgX7Vb3s0aWPt6rQqprCNSe+/ETlaMblQ3DEFfRUZCKmdPP2wvZPBmPzWBProd4Ov1vUGh6bp4hy2UNV3Q/iAVUzR8q0Worwf1QZw0IQvicnRoDevTI3XN4gji78NALm9kKzJTOdcDhk3aXkZMGGMvjBRajX2jMIwYowmr2ngXQbJZhRC75hU9PHnJKQ+Tw76YqaHZ47w+VJAIpwEawX6uA7nmYTmptDfUn1oB8dpxFf1xJDp0uW1EUNxdcZSkC5cfcfejrSOnWQ6MhxSWdCjDAru7FaJ5DUuFX81cX4vwDRhVcISwOYpdwKREDwHRDP9RByvnKTwPJx283UNF8f3j2xBugLxETy+cb/L+TjXnrlKkOIPBSzKYPZhvEo2QFJIr2bdQgJa8f5QcIsxgxf7ZwGOWffAWOJYlWXsqb81VlU1FnLEZQ2VQjsh7l8U82GETJfE6dJD9j0s/fa+O9ac3qUBDH7AbrF1dlvYPdkkaIbVXm2v/RQgZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(11063799006)(261021121427099003)(261022075727099003)(261022115727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(56012099006)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BeAdaMuBRWD3v3OSFB+7K7gsQv6rXfePNsTCrpjec3CiZafOpBODIbYzgHKpR8pRHgNoiRce0WsSG9ofPEVR3etspMnFkwgUNpGeuoTpx1PStzpvbz8U4aRRbkfJfAGIURS0vLZmTCKNE7UzYdMZmlOGyxt1F9uh8xef50k2oanJxRu+SsqGYGqu195T8Lpd4hHRnNPbtABMSOMxICEhJVNWQWYI9vFbxSrtmYc8lhuBp8NHSqFP6d8MofwcVG4szneiY3x/vlIdX1NApUqJtB+7HqodvfL5BPuWb1kR5FV6j8QN9oTsnri9w/1Lv4aO3jRJ3oCKzVvg9NkZ/8JekOBqz2vn0wR8gXvx/4zKM177K+Bto2x/teyRw+qIpFWSmyeIgZR+ts6G/zU0AFtZNoPij/Pg/kXXEALzjpPxI0RbX1nJHIh2LwvY8l3c4R1w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:18:44.4072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3266948-7523-4306-950d-08df3ac196e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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
 drivers/accel/amdxdna/Kconfig           |   1 +
 drivers/accel/amdxdna/aie4_pci.c        | 166 ++++++++++++++++++++++++++------
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   8 ++
 3 files changed, 145 insertions(+), 30 deletions(-)

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
index 02dcb2f813d45..fa8f99d1be361 100644
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
@@ -558,46 +560,128 @@ static void aie4_classic_hw_stop(struct amdxdna_dev_hdl *ndev)
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
+	u32 val;
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
+	/* all ones means the register isn't accessible */
+	if (val == 0xffffffff)
+		return AIE4_FW_DEFAULT;
+
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
+
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
 
-release_npufw:
-	release_firmware(*npufw);
+	ret = aie4_request_one(ndev, certfw, ndev->priv->certfw_path, variant);
+	if (ret)
+		release_firmware(*npufw);
 
 	return ret;
 }
@@ -645,18 +729,40 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
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
+	enum aie4_fw_variant hint = aie4_psp_fw_variant(xdna);
 	const struct firmware *npufw, *certfw;
-	int ret;
+	enum aie4_fw_variant order[3];
+	int i, n = 0, ret = -ENOENT;
 
 	if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
 		return 0;
 
-	ret = aie4_request_firmware(ndev, &npufw, &certfw);
-	if (ret)
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

