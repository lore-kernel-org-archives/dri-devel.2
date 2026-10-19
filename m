Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823E606A32E
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AgPXduZY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF5410EF1D;
	Mon, 19 Oct 2026 16:48:09 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320B410EEE9
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/J3wVNwKFyJAQnfTAJciCj5v3q2FPfuu1xWr09U/7RX8h9i/MuzAW/ckayKdrBbcHA1vK1NiOJ3DspmHeLbGnmfPexicu8gedIHrRc0wDrJEO0tTCufD8DABgjTrFFbu8ATo7AYdDIrwu/BcrufWqyAabQd6fkowq8xOLBxNyifFkJ+ZhjXDc5NEZf6G+z0eTu1PKuxJ8EPtb+bCKPFlhk6ngHID+RI2M4PnWDdwg6moIKzO8HX7kMTO659ix5EGdOTi64hotTxMrQA+qfUUaCCglcItWek3F/GB645xd5qtQ4/1C+AoFCarYGKlwLHKuVvMvnM1620yHn6dwf9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCjxbdA+69E/4v34cY8+Ei4dMEkcrTTsaDvlJUBzlc8=;
 b=WSrnb7RKxeOOEqp+bwWO5109Azr6rSBZV4A73GY//K7J3z1gWI875MgvA4w94KIJQ5I2ci62fxmZZ2nZ9Ni41Bko+VsUMUIdjv4bjn7HlOW7Rz5DyZoUDcjWx6KyLabHF9Vniq1+to2Mkeaf/M8G9SvmOF7wUIdnppl3N+MG+JM/l7OWujXBjTO8tYXYdC3H8hH0x7dPEDvVXYIgu/o2D0zweAaQlloetqsH526Juf8/XUCGM2MmZESuvlcTQb902qcNCBR1x8Xzlr9HLh6sydDw3WJH3Amr03cNnsdP5rRlSx6UuUbfT8V9KAscE2GAfe76Hp1MndJ7Rp7tWbDqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCjxbdA+69E/4v34cY8+Ei4dMEkcrTTsaDvlJUBzlc8=;
 b=AgPXduZYWxwuAGdyl9XPcZL061snZmfs3knbl+qIE+oiDnZ7xnHBJG7qVQgEpP8hpGCTOV+OSxtD9C337jA5BJ9zm4e3+Ml7cxf3skf9r5Gglzg2NTgdyor1fmE9hahjnLlVqp1ZnYMnZl7oy4NL2BrgpD39Z7p4sHxyqUqiw4A=
Received: from PH8P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::18)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:56 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::3) by PH8P220CA0014.outlook.office365.com
 (2603:10b6:510:345::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 16:47:56 +0000
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
 2026 11:47:44 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:44 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 03/19] accel/amdxdna: Add CERT firmware version support
Date: Mon, 19 Oct 2026 09:47:30 -0700
Message-ID: <20261019164746.827277-4-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbc0727-4d5f-4157-f3af-08df2e00b9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: M/O1SFhPAeVwBonx22cxWgMmsN61aklZoUYL/sJlx/uoZtyxVEg4KhKrJZK1xpTU9vRfgZS+Syavw/zEvLMq4NsZtUvgj2U6cIXZFKCe6AOzk3bI3g7AYDvvBOb9bFwI44ES4tM+0J99Ll5b18cfNYqbbW5SsyAgIqSjaAeJMBc9KxE1jh02JB7lVfcs3B/V4qGLXtDIkKpk8iKlW0at/OFSV8kKJNsuErPQWcD10J10hnGGoVug1xAQt+9kJoZdMNR9lYsRmAt8Whvgr9O/x1YXvswjPq0wydIcQ8L9geUd+0d9/2VpWHO3yt0GvYQpeozbWTByC8hnKQz4ScsnHZeQRa/roJ3HaL+cQf7sU7/iP1STC/PX1AuowrHwxLjfZIGz2/Mzr1xoHAxr6u0V8Ajgi2Kb9MoX5KFazaCd/Kqw1Ll9zNpeNjovPiF+nLDS8aXbnkH5uF06IDSpXPNORQ3qrdVAcNA0BVktW2RMwNvYwhnPilr/lell0Xu8tUhw+WazHeVfQ3I/nQ+heDP9Oqx4z4ZFcDpuGnBoa/gJMGVCDcsUeWfeFh0veKeVOvgFf+QO8mRJQnYsa/guJWRkT1BCC+7lSqxDrB5QDu1gq4uo7/XXyBMeDxVYEtPjab+SPDaHK0tcI62my0eA9pYY9W20QCBIzdv+cl5sE7nBpd1l3yn8lpLS7lzg3OEUno4fAbMkiinV6qy+87sXIrHniw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r0+Z3vGWT4fEHTetBli6k/Nlj5CQlpjCekS3Dfymvou1s7Qa2SMo2yqnMThmdAQOqSN3vlwdlJ0uLT5hEo8x9C2Xl3/VpcIaaAubE+4/6bd9LhAKS01bCunCEXwJdzzfJYzIIRzaX9XcesAktqy8+trcxqzDdNcD8r97RtQ6fsq9TWkpjOVcKGMXQdFgdSBXGc6YTJmy7Dk87o5pkkdRwbtjzmZet/HrNBSUeryv4BqFjz7V9vhx23fAkuBqTnNNupQYPHmbsKF7rFD+au+7eZ9gp6g96RLuJ4MIuHhm7BO4a3ImFevQjLjYg2XCh8exeIBNudrJI6gvF3WsgPFcJIdlxq8NjS2mhlJWSFZHfblyFjQ8kpIiWvMgjw07HaJkzMVEJJIp/XrxrCSnwpWNmOobSJghyyXgaV46C4qRhHKaaWAvv2ysapUv981NJdCf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:55.9237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbc0727-4d5f-4157-f3af-08df2e00b9ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
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

Add support to query and validate CERT firmware version:
- Add mailbox opcodes and structs to query NPU firmware version (identify)
  and CERT firmware version.
- Unify firmware version storage by using struct
  amdxdna_drm_query_firmware_version across the driver.
- Pass the feature table to aie_check_protocol() and add
  cert_feature_tbl to validate CERT firmware host queue protocol
  compatibility against driver capabilities.
- Add helper functions amdxdna_get_firmware_version() and
  amdxdna_get_aie_version() to share version query handling across
  generations.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie.c             | 33 ++++++++++++++--
 drivers/accel/amdxdna/aie.h             | 11 +++++-
 drivers/accel/amdxdna/aie2_message.c    |  4 +-
 drivers/accel/amdxdna/aie2_pci.c        | 50 ++++---------------------
 drivers/accel/amdxdna/aie2_pci.h        |  4 +-
 drivers/accel/amdxdna/aie4_message.c    | 46 +++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 30 +++++++++++++++
 drivers/accel/amdxdna/aie4_pci.c        | 20 +++++++++-
 drivers/accel/amdxdna/aie4_pci.h        | 11 ++++++
 drivers/accel/amdxdna/amdxdna_pci_drv.h | 10 +----
 drivers/accel/amdxdna/amdxdna_sysfs.c   |  2 +-
 drivers/accel/amdxdna/npu3_regs.c       |  7 ++++
 12 files changed, 163 insertions(+), 65 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
index bf8eb66baab8..fb57c4b8d85d 100644
--- a/drivers/accel/amdxdna/aie.c
+++ b/drivers/accel/amdxdna/aie.c
@@ -65,13 +65,12 @@ int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg)
 	return ret;
 }
 
-int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
+int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor,
+		       const struct amdxdna_fw_feature_tbl *feature)
 {
-	const struct amdxdna_fw_feature_tbl *feature;
 	bool found = false;
 
-	for (feature = aie->xdna->dev_info->fw_feature_tbl;
-	     feature->major; feature++) {
+	for (; feature && feature->major; feature++) {
 		if (feature->major != fw_major)
 			continue;
 		if (fw_minor < feature->min_minor)
@@ -88,6 +87,32 @@ int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
 	return found ? 0 : -EOPNOTSUPP;
 }
 
+int amdxdna_get_aie_version(struct amdxdna_client *client,
+			    struct amdxdna_drm_get_info *args,
+			    struct amdxdna_drm_query_aie_version *version)
+{
+	u32 buf_sz;
+
+	buf_sz = min_t(u32, args->buffer_size, sizeof(*version));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), version, buf_sz))
+		return -EFAULT;
+
+	return 0;
+}
+
+int amdxdna_get_firmware_version(struct amdxdna_client *client,
+				 struct amdxdna_drm_get_info *args,
+				 struct amdxdna_drm_query_firmware_version *version)
+{
+	u32 buf_sz;
+
+	buf_sz = min_t(u32, args->buffer_size, sizeof(*version));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), version, buf_sz))
+		return -EFAULT;
+
+	return 0;
+}
+
 static void amdxdna_update_vbnv(struct amdxdna_dev *xdna,
 				const struct amdxdna_rev_vbnv *tbl,
 				u32 rev)
diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 1fc5ddfe696a..3f58abcaa632 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -28,6 +28,7 @@ struct aie_device {
 	struct psp_device *psp_hdl;
 	struct smu_device *smu_hdl;
 
+	struct amdxdna_drm_query_aie_version version;
 	struct amdxdna_drm_query_aie_metadata metadata;
 };
 
@@ -95,7 +96,8 @@ struct amdxdna_rev_vbnv {
 void aie_dump_mgmt_chann_debug(struct aie_device *aie);
 void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
 int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
-int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
+int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor,
+		       const struct amdxdna_fw_feature_tbl *feature);
 void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
 int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
 			 struct amdxdna_drm_get_info *args);
@@ -103,7 +105,12 @@ void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
 			       dma_addr_t *dma_addr);
 void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
 			     void *cpu_addr, dma_addr_t dma_addr);
-
+int amdxdna_get_aie_version(struct amdxdna_client *client,
+			    struct amdxdna_drm_get_info *args,
+			    struct amdxdna_drm_query_aie_version *version);
+int amdxdna_get_firmware_version(struct amdxdna_client *client,
+				 struct amdxdna_drm_get_info *args,
+				 struct amdxdna_drm_query_firmware_version *version);
 /* aie_psp.c */
 struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
 int aie_psp_start(struct psp_device *psp);
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index 56b919b350ac..d95a18af9b09 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -149,7 +149,7 @@ int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 }
 
 int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
-				struct amdxdna_fw_ver *fw_ver)
+				struct amdxdna_drm_query_firmware_version *fw_ver)
 {
 	DECLARE_AIE_MSG(firmware_version, MSG_OP_GET_FIRMWARE_VERSION);
 	int ret;
@@ -160,7 +160,7 @@ int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
 
 	fw_ver->major = resp.major;
 	fw_ver->minor = resp.minor;
-	fw_ver->sub = resp.sub;
+	fw_ver->patch = resp.sub;
 	fw_ver->build = resp.build;
 
 	return 0;
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index d2fa46e4d3a4..6fa79698f9d8 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -115,7 +115,8 @@ static int aie2_get_mgmt_chann_info(struct amdxdna_dev_hdl *ndev)
 	ndev->aie.mgmt_prot_minor = info_regs.prot_minor;
 
 	ret = aie_check_protocol(&ndev->aie, ndev->aie.mgmt_prot_major,
-				 ndev->aie.mgmt_prot_minor);
+				 ndev->aie.mgmt_prot_minor,
+				 ndev->aie.xdna->dev_info->fw_feature_tbl);
 
 done:
 	aie_dump_mgmt_chann_debug(&ndev->aie);
@@ -206,15 +207,16 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
 
 static int aie2_mgmt_fw_query(struct amdxdna_dev_hdl *ndev)
 {
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	int ret;
 
-	ret = aie2_query_firmware_version(ndev, &ndev->aie.xdna->fw_ver);
+	ret = aie2_query_firmware_version(ndev, &xdna->fw_ver);
 	if (ret) {
 		XDNA_ERR(ndev->aie.xdna, "query firmware version failed");
 		return ret;
 	}
 
-	ret = aie2_query_aie_version(ndev, &ndev->version);
+	ret = aie2_query_aie_version(ndev, &ndev->aie.version);
 	if (ret) {
 		XDNA_ERR(ndev->aie.xdna, "Query AIE version failed");
 		return ret;
@@ -684,44 +686,6 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
 	return 0;
 }
 
-static int aie2_get_aie_version(struct amdxdna_client *client,
-				struct amdxdna_drm_get_info *args)
-{
-	struct amdxdna_drm_query_aie_version version;
-	struct amdxdna_dev *xdna = client->xdna;
-	struct amdxdna_dev_hdl *ndev;
-	u32 buf_sz;
-
-	ndev = xdna->dev_handle;
-	version.major = ndev->version.major;
-	version.minor = ndev->version.minor;
-
-	buf_sz = min(args->buffer_size, sizeof(version));
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int aie2_get_firmware_version(struct amdxdna_client *client,
-				     struct amdxdna_drm_get_info *args)
-{
-	struct amdxdna_drm_query_firmware_version version;
-	struct amdxdna_dev *xdna = client->xdna;
-	u32 buf_sz;
-
-	version.major = xdna->fw_ver.major;
-	version.minor = xdna->fw_ver.minor;
-	version.patch = xdna->fw_ver.sub;
-	version.build = xdna->fw_ver.build;
-
-	buf_sz = min(args->buffer_size, sizeof(version));
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
-		return -EFAULT;
-
-	return 0;
-}
-
 static int aie2_get_power_mode(struct amdxdna_client *client,
 			       struct amdxdna_drm_get_info *args)
 {
@@ -1036,7 +1000,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 		ret = amdxdna_get_metadata(&ndev->aie, client, args);
 		break;
 	case DRM_AMDXDNA_QUERY_AIE_VERSION:
-		ret = aie2_get_aie_version(client, args);
+		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
 		break;
 	case DRM_AMDXDNA_QUERY_CLOCK_METADATA:
 		ret = aie2_get_clock_metadata(client, args);
@@ -1048,7 +1012,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 		ret = aie2_get_hwctx_status(client, args);
 		break;
 	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
-		ret = aie2_get_firmware_version(client, args);
+		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
 		break;
 	case DRM_AMDXDNA_GET_POWER_MODE:
 		ret = aie2_get_power_mode(client, args);
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index a5fd71329b93..b31f73082c17 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -74,7 +74,6 @@ enum aie2_sram_reg_idx {
 };
 
 struct amdxdna_client;
-struct amdxdna_fw_ver;
 struct amdxdna_hwctx;
 struct amdxdna_sched_job;
 
@@ -150,7 +149,6 @@ struct amdxdna_dev_hdl {
 	void			__iomem *mbox_base;
 
 	u32				total_col;
-	struct amdxdna_drm_query_aie_version version;
 	struct aie2_exec_msg_ops	*exec_msg_ops;
 	struct drm_gpu_scheduler	*hwctx_sched;
 	struct ida			hwctx_sched_ida;
@@ -263,7 +261,7 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev,
 int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 			    struct amdxdna_drm_query_aie_metadata *metadata);
 int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
-				struct amdxdna_fw_ver *fw_ver);
+				struct amdxdna_drm_query_firmware_version *fw_ver);
 int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 			  struct app_health_report *report);
 int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum aie2_dev_revision *rev);
diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 88037edbb02a..53f8e366b66c 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -64,6 +64,52 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 	return 0;
 }
 
+int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
+				    struct amdxdna_drm_query_firmware_version *fw_version)
+{
+	DECLARE_AIE_MSG(aie4_msg_identify, AIE4_MSG_OP_IDENTIFY);
+	int ret;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		return ret;
+
+	fw_version->major = resp.fw_major;
+	fw_version->minor = resp.fw_minor;
+	fw_version->patch = resp.fw_patch;
+	fw_version->build = resp.fw_build;
+
+	return 0;
+}
+
+int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
+				     struct amdxdna_drm_query_firmware_version *cert_version)
+{
+	DECLARE_AIE_MSG(aie4_msg_query_cert_firmware_version,
+			AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION);
+	int ret;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		return ret;
+
+	ret = aie_check_protocol(&ndev->aie,
+				 resp.host_queue_major, resp.host_queue_minor,
+				 ndev->aie.xdna->dev_info->cert_feature_tbl);
+	if (ret) {
+		XDNA_ERR(ndev->aie.xdna, "host queue %d.%d is not supported",
+			 resp.host_queue_major, resp.host_queue_minor);
+		return ret;
+	}
+
+	cert_version->major = resp.major_version;
+	cert_version->minor = resp.minor_version;
+	cert_version->patch = resp.hotfix;
+	cert_version->build = resp.build;
+
+	return 0;
+}
+
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
 {
 	DECLARE_AIE_MSG(aie4_msg_attach_work_buffer, AIE4_MSG_OP_ATTACH_WORK_BUFFER);
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index af0866045b91..5b97c8057de0 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -10,8 +10,10 @@
 #include <linux/types.h>
 
 enum aie4_msg_opcode {
+	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
 	AIE4_MSG_OP_SUSPEND                          = 0x10003,
 	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
+	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
 	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
@@ -30,6 +32,18 @@ enum aie4_msg_status {
 	MAX_AIE4_MSG_STATUS_CODE = 0x4,
 };
 
+struct aie4_msg_identify_req {
+	__u32 rsvd;
+} __packed;
+
+struct aie4_msg_identify_resp {
+	enum aie4_msg_status status;
+	__u32 fw_major;
+	__u32 fw_minor;
+	__u32 fw_patch;
+	__u32 fw_build;
+} __packed;
+
 struct aie4_msg_suspend_req {
 	__u32 rsvd;
 } __packed;
@@ -132,6 +146,22 @@ struct aie4_msg_aie4_tile_info_resp {
 	struct aie4_tile_info info;
 } __packed;
 
+struct aie4_msg_query_cert_firmware_version_req {
+	__u32 resvd;
+} __packed;
+
+struct aie4_msg_query_cert_firmware_version_resp {
+	enum aie4_msg_status status;
+	__u8 major_version;
+	__u8 minor_version;
+	__u8 git_hash[41];
+	__u8 date[11];
+	__u8 hotfix;
+	__u8 build;
+	__u16 host_queue_major;
+	__u16 host_queue_minor;
+} __packed;
+
 #define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
 
 struct aie4_msg_attach_work_buffer_req {
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index f81c43a1f884..e9cd2af224d3 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -90,7 +90,8 @@ static int aie4_mailbox_info(struct amdxdna_dev *xdna,
 
 	ret = aie_check_protocol(&xdna->dev_handle->aie,
 				 mbox_info->protocol_major,
-				 mbox_info->protocol_minor);
+				 mbox_info->protocol_minor,
+				 xdna->dev_info->fw_feature_tbl);
 	if (ret)
 		XDNA_ERR(xdna, "mailbox major.minor %d.%d is not supported",
 			 mbox_info->protocol_major, mbox_info->protocol_minor);
@@ -277,7 +278,22 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
 
 static int aie4_query(struct amdxdna_dev_hdl *ndev)
 {
-	return aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	ret = aie4_query_npu_firmware_version(ndev, &xdna->fw_ver);
+	if (ret)
+		return ret;
+
+	ret = aie4_query_cert_firmware_version(ndev, &ndev->cert_version);
+	if (ret)
+		return ret;
+
+	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index c6219544dc0f..8c62ee6a9b23 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -57,6 +57,13 @@ struct amdxdna_dev_hdl {
 	void				*work_buf;
 	dma_addr_t			work_buf_addr;
 	u32				work_buf_size;
+
+	struct amdxdna_drm_query_firmware_version cert_version;
+};
+
+enum aie4_fw_feature {
+	AIE4_HSA_COMMAND = 5,
+	AIE4_FEATURE_MAX
 };
 
 /* aie4_message.c */
@@ -64,6 +71,10 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 			    struct amdxdna_drm_query_aie_metadata *metadata);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
+int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
+				    struct amdxdna_drm_query_firmware_version *fw_version);
+int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
+				     struct amdxdna_drm_query_firmware_version *cert_version);
 
 /* aie4_ctx.c */
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 0db56c51bb49..1b044646cc8a 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -99,16 +99,10 @@ struct amdxdna_dev_info {
 	size_t				dev_heap_max_size;
 	const struct amdxdna_dev_priv	*dev_priv;
 	const struct amdxdna_fw_feature_tbl *fw_feature_tbl;
+	const struct amdxdna_fw_feature_tbl *cert_feature_tbl;
 	const struct amdxdna_dev_ops	*ops;
 };
 
-struct amdxdna_fw_ver {
-	u32 major;
-	u32 minor;
-	u32 sub;
-	u32 build;
-};
-
 struct amdxdna_carveout;
 
 struct amdxdna_dev {
@@ -120,7 +114,7 @@ struct amdxdna_dev {
 	struct mutex			dev_lock; /* per device lock */
 	struct list_head		client_list;
 	struct mutex			client_lock; /* client_list */
-	struct amdxdna_fw_ver		fw_ver;
+	struct amdxdna_drm_query_firmware_version fw_ver;
 	struct rw_semaphore		notifier_lock; /* for mmu notifier*/
 	struct workqueue_struct		*notifier_wq;
 
diff --git a/drivers/accel/amdxdna/amdxdna_sysfs.c b/drivers/accel/amdxdna/amdxdna_sysfs.c
index d9e359ee8182..e20b7fb1e5d1 100644
--- a/drivers/accel/amdxdna/amdxdna_sysfs.c
+++ b/drivers/accel/amdxdna/amdxdna_sysfs.c
@@ -37,7 +37,7 @@ static ssize_t fw_version_show(struct device *dev, struct device_attribute *attr
 	struct amdxdna_dev *xdna = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d.%d.%d.%d\n", xdna->fw_ver.major,
-		       xdna->fw_ver.minor, xdna->fw_ver.sub,
+		       xdna->fw_ver.minor, xdna->fw_ver.patch,
 		       xdna->fw_ver.build);
 }
 static DEVICE_ATTR_RO(fw_version);
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index 8d287ef32fff..e82bc0a4f597 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -42,6 +42,11 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
 	{ 0 }
 };
 
+static const struct amdxdna_fw_feature_tbl npu3_cert_feature_table[] = {
+	{ .features = BIT_U64(AIE4_HSA_COMMAND), .major = 1, .min_minor = 0 },
+	{ 0 }
+};
+
 static const struct amdxdna_dev_priv npu3_dev_priv = {
 	.npufw_path             = "npu.sbin",
 	.certfw_path            = "cert.sbin",
@@ -85,6 +90,7 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
 	.device_type		= AMDXDNA_DEV_TYPE_PF,
 	.dev_priv		= &npu3_dev_priv,
 	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
 	.ops			= &aie4_pf_ops,
 };
 
@@ -96,5 +102,6 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
 	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
 	.dev_priv		= &npu3_dev_vf_priv,
 	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
 	.ops			= &aie4_vf_ops,
 };
-- 
2.34.1

