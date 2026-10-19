Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF31606AEEA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Dmzyeor+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B6E10EFC7;
	Mon, 19 Oct 2026 16:48:43 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322AC10EF3B
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQPGrq4dvALTajXrZBQDX2PC3pd160zMY5yl4+PH8LihPHv+gjN6QK76xNiEjpcITldvVTqCVwq8EajBSodBOakcHR0V150Qp0sTuIIzArKW3MyJMCO3+FUTda8RABkXkRO8MaylytxUHuNTyYyIyOJORrkJaoIxMbnDrY/GVTTbgb0bApePuZ2471THbE+Lk8pTEtxDQJSzdwzY0ZldhQ2USc03+kxYmReGye7dMeFreOmTy3dWbmqbr7nGIBunPTwb8cUPhMOn3bfG+k71VOpx53LYGadfrfHe2iYd+4lOUqFg+6M5H5eZqPfo9Jlzs+5UrUEdfUjtFdXwl7CKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtVjqCTVUQ4kz6F3x3pqOOxNEzFQJmQlAeiv1gujuyM=;
 b=U8SuYzaGNbzVxILzHWh+wc0RRtmt4CXpxwACdbmXLFw+jZJXMd8+4PMMchqESViT4TWLoUjj8LT0lBPI24WyoA48y7ySKun8wEntnyWup+V72ALVpS2qSkRnDF8A6JCfXCRC4ifvmVq/WD/bLSPeQUZ7zRmTIe1mL05nESSEcBYxw1nV4sJipRxax16ZH8/6EVzSdNW/enu6FUmzS8GnlJMzCnL/q5b07iqDgoeu3FrLe7CijNj2SprQyHccGcFEsSqE/1eLbgzoDEdfRfoYAUXmac0O/NIV+5zz6qmrBpgtGw2vuHjPKxVT32FhnMMzQ1cfFyN3UdBACritep/vOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtVjqCTVUQ4kz6F3x3pqOOxNEzFQJmQlAeiv1gujuyM=;
 b=Dmzyeor+hScEzZdSgIhoEbW0o2HQHpZK6QUgVDyN7nLnGp3TlKigCtPZ0uUHMM32k0s/iSjUIbA7yNktoCgBKY7AIqTZLsQ2PN/jjvhaCwplKGuzSyeFPrT/Tg19gsePdf6bNGCOvKDnYe1AEYZoj9rsaRWJZc/IWvNxHgz140o=
Received: from PH8P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::10)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:57 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::97) by PH8P220CA0019.outlook.office365.com
 (2603:10b6:510:345::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 16:47:57 +0000
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
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:47:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:47 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:46 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Hayden Laccabue <hayden.laccabue@amd.com>
Subject: [PATCH V5 06/19] accel/amdxdna: Add AIE version query to aie4_get_info
Date: Mon, 19 Oct 2026 09:47:33 -0700
Message-ID: <20261019164746.827277-7-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8fee0b-24dd-49c8-bbb8-08df2e00ba85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: hQ0lsvzeqdCowDJ6LGMhU7N1ODjhfEMqdVCTf15sqaEGdB4BQonkhC0lggRWQlliP2OVdiVWSBzfOl1S5ZWAkZWia12lJpJ2UsremcC32lgy2FSkVIA2rKOjjndoZb6jWob7Q1xo64e4QYFMkvwl+7fWVcayLywo2Qowq4o4JUA22I4wn59pOQE/vwBSxwad4rbFNZWbvgMlKkgxVn3XHdTcKisEWpu6z11GgnhwLUBUTUtd1EpkKIiRveLWXJ40fYSYZI1WYa8WNAK6Hwim5ZqmitRb3ECEKVe/KY6+jr7r0zgHzRXRDQQ1hkQBo2lL179vZW9s0BKKe0N0FRMcrho6d0mnJaUJV9dBJNMsppDG4+QcYnsZ5fOHCrJ4X+kuznCaSTd3a80L0tZ/RVjrQx2f2XbidRY2csrX5AX3hLDMzNPGrLuV0ALMzBstQ6hXcXySK++igi2ZZwDiu3bmbUJ1elHgadvC6LNxGyn4tdFO4FbZknqDPgBufGl2IucmXcua5I8udSNGUwLSOWpHAsOiYvQFVOM2rpABmU9XezFkBqqwimMhO617wMiwoU+hji8CA+1L+Z0k01l4OmsPGsT9jBuqbWiXoICijzRARAm8sec6mS1ZiHwyHw6fLPJgSvvTS1RUTgy3bcdqqW3xEBzjU9ppEwIexlf9YayatVa3o2BUBbI64Ns1Y2c8V2cPBd01Xw7/Z4j0gpquksyRSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z/TWPMB37+lOXPSlIFmKgzhilPCvFoI1wJNySXmOZ3A10olGIx5EMdy5GqkTrNOU+lhpr7Ly7gLy2w4OTD5f+5KC8OnrRCtCx1rcomoXFUG5/1dSiLpFbuLLJ5fjnYqWexVvlmv1Lh0xKjrIel+UeW+sD1mBpZXSA/8EIIKaOK+ef4puq/dRIimuEr/5s0eu1SPl1ukGuRK2ahwf7caQoZ1ebpbz5HexHpuy/7oQjU0+IoAalAs55kT9t+32PNYB9nb7shznjs0IfU9wmuoG5jZZ7FKl4wfJh3wpxCxgsDocsnXS0r1OZBFDLJrD9QuT8ueDbg8/arFCJhAR0xU/S9Rnhgzlgg6BSUIVj7pOjrF3LoTOIwi+NR3eAo8hJUD4hn3mq1ScwzGHOTgjMEI6pBHp5q5xNAzI9UsBh1wtjk/Vvy4lSgWu+2N591KhQmYC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:57.2991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8fee0b-24dd-49c8-bbb8-08df2e00ba85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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

Add AIE version query via DRM_AMDXDNA_GET_INFO. The NPU firmware
version query already existed internally; it is now also exposed
through this ioctl alongside the new AIE version query.

These versions are mandatory once released, the firmware management
interfaces must support those queries in their stable version.
Propagating any failure to abort device initialization is intentional.

Co-developed-by: Hayden Laccabue <hayden.laccabue@amd.com>
Signed-off-by: Hayden Laccabue <hayden.laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c  | 20 ++++++++++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h | 11 +++++++++++
 drivers/accel/amdxdna/aie4_pci.c      | 10 ++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index f67aa8ba943c..c83f81a0e65b 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -75,6 +75,26 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 	return 0;
 }
 
+int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
+			   struct amdxdna_drm_query_aie_version *version)
+{
+	DECLARE_AIE_MSG(aie4_msg_aie4_version_info, AIE4_MSG_OP_AIE_VERSION_INFO);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		return ret;
+
+	XDNA_DBG(xdna, "Query AIE version - major: %u minor: %u",
+		 resp.major, resp.minor);
+
+	version->major = resp.major;
+	version->minor = resp.minor;
+
+	return 0;
+}
+
 int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
 				    struct amdxdna_drm_query_firmware_version *fw_version)
 {
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index b9f7c61f36e3..81842fa1d6ce 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -22,6 +22,7 @@ enum aie4_msg_opcode {
 	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
 	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
 	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
+	AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
 
 	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
 };
@@ -160,6 +161,16 @@ struct aie4_msg_aie4_tile_info_resp {
 	struct aie4_tile_info info;
 } __packed;
 
+struct aie4_msg_aie4_version_info_req {
+	__u32 resvd;
+} __packed;
+
+struct aie4_msg_aie4_version_info_resp {
+	enum aie4_msg_status status;
+	__u16 major;
+	__u16 minor;
+} __packed;
+
 struct aie4_msg_query_cert_firmware_version_req {
 	__u32 resvd;
 } __packed;
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 1eeb1cb73b27..1cbd1665a28f 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -289,6 +289,10 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		return ret;
 
+	ret = aie4_query_aie_version(ndev, &ndev->aie.version);
+	if (ret)
+		return ret;
+
 	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
 	if (ret)
 		return ret;
@@ -595,6 +599,12 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	case DRM_AMDXDNA_QUERY_AIE_METADATA:
 		ret = amdxdna_get_metadata(&ndev->aie, client, args);
 		break;
+	case DRM_AMDXDNA_QUERY_AIE_VERSION:
+		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
+		break;
+	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
+		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
+		break;
 	default:
 		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
 		ret = -EOPNOTSUPP;
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 940e67347d74..5ae5e8427a3b 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -69,6 +69,8 @@ enum aie4_fw_feature {
 /* aie4_message.c */
 int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 			    struct amdxdna_drm_query_aie_metadata *metadata);
+int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
+			   struct amdxdna_drm_query_aie_version *version);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
 int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
-- 
2.34.1

