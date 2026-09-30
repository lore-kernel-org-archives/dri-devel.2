Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45C9CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957C610F158;
	Wed, 30 Sep 2026 03:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a2xLs1vI";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA0310E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:32:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSUxX68MQTb2HIX4MOIkXUvYMVXBvoDdiK97OnyvJmBZT4pCrpzpRB2/AG9O0bMkRocTpyaNqwaSP3ScxZgLYFz4NfdiCBYf9eGIMmJuxnefjFa7viUXNyfRaxoy9i9IUZdHjG0SbP5FKuu6kDTofugxz4HNZtkAbACNaPiCcerkEsstRbNM0uJb6GB84lsB0tUUrs0t0ykXkP92rXoMGNQwRpS6wCQBtBi9w/eNKYO/E1EF2KSvMEt+ddnwjRioCRGn89aLNCm0cxThM4abggKhbVHJp7V6HRUMida3wOuDebnaOIY0m6Tkp14pNh4TsweTqgbZfqFb1CCw7EQxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1LmFbJ4PpRb/kmRoo7D3ASAorRoMJwdqkFH6R5TgSY=;
 b=XlmgDBTt9D13UJ4GKGgEwZODkRSUFCJUqA7FLlcpBCWKv9jqE5B0hJeahqY7Bh06gi+h8wyC3N4JUK4VYCtUf5l3jUPMGfYL0B326MS05odSEgQUvZnTTV7y8STfsSnoHjXy9rkEfRxaMFtYKCD37kxj7VasNpMclIQZdV3V4AQBoG1Apvdak4yvmb+F13Y/w+pvIN9EOgM64b2fEJCdSfiW8vtg/KdO17uvz1mVukgy22GmSnx+Z1is4nxxyfbJsQRJY685YvAXzIpwqsQeuPZ79eSXpfKNZQpXKYfRU8gAdxmFqH2PejhCafZKuEn2WxbTsZLgx7DQJqXVEMLNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1LmFbJ4PpRb/kmRoo7D3ASAorRoMJwdqkFH6R5TgSY=;
 b=a2xLs1vIYbfI0XbBsKSD6kJ03s5gioEC9mp68DSnBHsQqBAfi4XiToLsZSivwAyVAcYeTgjgb0yma6ijj+hS3+0BlKpwmvr//YMMd889IpCwHYfHifyaT5+u3nch1gyLTq4o4mMpEltrsy+2UCmJqWeTrJpZ6BogSllaQLKXQXU=
Received: from SJ0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:33b::34)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 03:32:53 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::2a) by SJ0PR05CA0029.outlook.office365.com
 (2603:10b6:a03:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.11 via Frontend Transport; Wed,
 30 Sep 2026 03:32:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:32:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:51 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:32:51 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 03/20] accel/amdxdna: Add CERT firmware version support
Date: Tue, 29 Sep 2026 20:32:16 -0700
Message-ID: <20260930033233.1727265-4-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 033dfffc-1c6f-46b2-b8fe-08df1ea38292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|11063799006|56012099006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4zOJkiG7yfoNG0J7O49otayQPtINquQRT6OZtz1qeB/MX4VnE4L9T2YxkDLRwBFRoIvvHG5gGgY2+5sB46Sb1afQ0YKtoVDkfYucrV/Ov4Ubw9SQB4Qks27WU4L9agiJ/yZURnCVafp6M3CxIO1bo1ow0t7XTESyLM3ipIaIdz9AgJoZBkoTt+DZo+nd9xg3C+38zo68aB9CTSB6RDWbuyhBljqSfV0JmtrTN2EfuwEkOsg30vjOCqcYFqVYiP51RXog1PBWqLCnVxizfgIqynrztDo0dmm0drIaGOABsI8a8tnRCvKtT47ixBS5NHcGM/8iUzNKOtKFBE6cFoZYxzuB7NMbR5lX/t6seUPRuyZqnKj4ts1sgY63xKb+Ht2sHHQjKlyjvk6l7jFJHYTq+HWumnwQ04anGkZAehg8wbPHGtsXJx6Taw4Xcnv+nD8+pH5dWPNhP0hh4xN9lp3gxu9LmruCQkgcFFZ5llL0+gIihbhFu8Jys1rUJL1CUN9U1QXC1AUPHOo6BtYOBwcxCX7ioiU4DZXSLrR5EGerr1x58Et7noJRr2MDrbg2OaTKRXg7h9oWRHz9+6HGeiT5+1KZgNlV41g94vU5O+0o6vy/IdSZuoBWdQGDnOMrPCYQivK36F44+aHmu2wA6Wf+8i9T0DSvH5xAwuerHAc0E89KR2k89N+Fxf7v43pC4kaAOilB27yfPUtZuWvmr48W1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Eo6gA2oe35OIloKG6UMiQ3c0/akR4Asn1zpKUOsvjNyvuDZrOsAzR3gp9z8Bb+Gz7IoH7OW5KuITCrhLlrW6ZT0Q6USExkUTH5LSVWq8ew6JpZHvogxqXNc+mhhdGu1qnETEkmTuF9GfHECCjviwWE9l1p2h+AqTvJHXKop1M4gxe9Df2xpe2vaPjIuzE1fdnApXUQMdIT8ZufXPHuwmK0e/UzNtLimwB/OYCatFOQK6BfG4K4MCcMZv+K+Emmz6Jhia+haAdvnsPn2SyLB48/CbXa1YU0ot+o5bFogj3oxz5Mv/C0QsCs4u++nGpDeOsYvkZ6pnWm0zEJuQcG+34ahVpiK1ZEb19siWyxyp2FCNlArzP3NZyg49p++pJUb0LNvpuJldHzrTUzfgNzI3IlnImkl2DuVN/mVooR8aCVqdcc/BiZ8I/o/4Ju6EiELz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:32:52.7801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033dfffc-1c6f-46b2-b8fe-08df1ea38292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046
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

AIE4 platforms run two separate firmware binaries: NPU firmware for
management and CERT (Column Embedded Run Time) firmware for
handling execution contexts and queues.

Add support to query and validate CERT firmware version:
- Add mailbox opcodes and structs to query NPU firmware version (identify)
  and CERT firmware version.
- Unify firmware version storage by using struct
  amdxdna_drm_query_firmware_version across the driver.
- Introduce aie_check_cert_protocol() and cert_feature_tbl to validate
  CERT firmware host queue protocol compatibility against driver
  capabilities.
- Add helper functions amdxdna_get_firmware_version() and
  amdxdna_get_aie_version() to share version query handling across
  generations.

Note on patch ordering:
Introducing CERT firmware protocol validation prior to the firmware 6.0
upgrade ensures host queue protocol compatibility (host_queue_major/minor)
is validated before the host queue layout restructure, preserving
bisectability.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie.c             | 45 ++++++++++++++++++++---
 drivers/accel/amdxdna/aie.h             |  9 ++++-
 drivers/accel/amdxdna/aie2_message.c    |  4 +--
 drivers/accel/amdxdna/aie2_pci.c        | 47 +++----------------------
 drivers/accel/amdxdna/aie2_pci.h        |  4 +--
 drivers/accel/amdxdna/aie4_message.c    | 45 +++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 30 ++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.c        | 17 ++++++++-
 drivers/accel/amdxdna/aie4_pci.h        | 11 ++++++
 drivers/accel/amdxdna/amdxdna_pci_drv.h | 10 ++----
 drivers/accel/amdxdna/amdxdna_sysfs.c   |  2 +-
 drivers/accel/amdxdna/npu3_regs.c       |  8 +++++
 12 files changed, 170 insertions(+), 62 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
index dd6f36f222c7..01a439c0ccf4 100644
--- a/drivers/accel/amdxdna/aie.c
+++ b/drivers/accel/amdxdna/aie.c
@@ -65,13 +65,12 @@ int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg)
 	return ret;
 }
 
-int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
+static int aie_check_protocol_impl(struct aie_device *aie, u32 fw_major, u32 fw_minor,
+				   const struct amdxdna_fw_feature_tbl *feature)
 {
-	const struct amdxdna_fw_feature_tbl *feature;
 	bool found = false;
 
-	for (feature = aie->xdna->dev_info->fw_feature_tbl;
-	     feature->major; feature++) {
+	for (; feature && feature->major; feature++) {
 		if (feature->major != fw_major)
 			continue;
 		if (fw_minor < feature->min_minor)
@@ -88,6 +87,44 @@ int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
 	return found ? 0 : -EOPNOTSUPP;
 }
 
+int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
+{
+	return aie_check_protocol_impl(aie, fw_major, fw_minor,
+				       aie->xdna->dev_info->fw_feature_tbl);
+}
+
+int aie_check_cert_protocol(struct aie_device *aie, u32 cert_major, u32 cert_minor)
+{
+	return aie_check_protocol_impl(aie, cert_major, cert_minor,
+				       aie->xdna->dev_info->cert_feature_tbl);
+}
+
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
index 0483d582b7f8..899399756661 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -28,6 +28,7 @@ struct aie_device {
 	struct psp_device *psp_hdl;
 	struct smu_device *smu_hdl;
 
+	struct amdxdna_drm_query_aie_version version;
 	struct amdxdna_drm_query_aie_metadata metadata;
 };
 
@@ -96,6 +97,7 @@ void aie_dump_mgmt_chann_debug(struct aie_device *aie);
 void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
 int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
 int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
+int aie_check_cert_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
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
index f658760c3d48..bae0cc4c3580 100644
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
index 7a4314ca843b..5dc6e5b97afc 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -205,15 +205,16 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
 
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
@@ -673,44 +674,6 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
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
@@ -1025,7 +988,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 		ret = amdxdna_get_metadata(&ndev->aie, client, args);
 		break;
 	case DRM_AMDXDNA_QUERY_AIE_VERSION:
-		ret = aie2_get_aie_version(client, args);
+		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
 		break;
 	case DRM_AMDXDNA_QUERY_CLOCK_METADATA:
 		ret = aie2_get_clock_metadata(client, args);
@@ -1037,7 +1000,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 		ret = aie2_get_hwctx_status(client, args);
 		break;
 	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
-		ret = aie2_get_firmware_version(client, args);
+		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
 		break;
 	case DRM_AMDXDNA_GET_POWER_MODE:
 		ret = aie2_get_power_mode(client, args);
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 2c7019bd26b5..67971f0c4acf 100644
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
index 88037edbb02a..b137a2a40b34 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -64,6 +64,51 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
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
+	ret = aie_check_cert_protocol(&ndev->aie,
+				      resp.host_queue_major, resp.host_queue_minor);
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
index db02d25e3f4a..3cb81bc1b627 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -271,7 +271,22 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
 
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
index 84c8973e9197..0002e6ef32ba 100644
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
index 8d287ef32fff..31208c42ad5f 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -42,6 +42,12 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
 	{ 0 }
 };
 
+static const struct amdxdna_fw_feature_tbl npu3_cert_feature_table[] = {
+	{ .major = 1, .min_minor = 0 },
+	{ .features = BIT_U64(AIE4_HSA_COMMAND), .major = 1, .min_minor = 0 },
+	{ 0 }
+};
+
 static const struct amdxdna_dev_priv npu3_dev_priv = {
 	.npufw_path             = "npu.sbin",
 	.certfw_path            = "cert.sbin",
@@ -85,6 +91,7 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
 	.device_type		= AMDXDNA_DEV_TYPE_PF,
 	.dev_priv		= &npu3_dev_priv,
 	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
 	.ops			= &aie4_pf_ops,
 };
 
@@ -96,5 +103,6 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
 	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
 	.dev_priv		= &npu3_dev_vf_priv,
 	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
 	.ops			= &aie4_vf_ops,
 };
-- 
2.34.1

