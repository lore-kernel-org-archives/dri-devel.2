Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398EAC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B64510E596;
	Tue, 21 Jul 2026 16:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y5nG5VIX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A52610E39B;
 Tue, 21 Jul 2026 16:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZLz8C0XwHgrPJU09coghfk437OEHBtq5X3kYD30y6JvyghBqV+ZeB6oJ7XY16hEP6DWrZcRL2PPsg6rPLp/JLaqR33QgfqyFg22myFJGY//OJX6Vqg+qd640HhspW7xWJ3XnPHKDETrDtA8MHPxiq2OsJpc8Hb8uuTDJX5B4zsa09OIOyLNzHkeU6PI8mj/5YDLxoxGJIFGbgET0l04fbJ7bJVJD6PhJw+UgL4KlvcNOmopL3ygfnNOLndfP7PZ57fgZdc6P9/qMlv7UFCs9taLJWyhkT5gAqT0JEu9MpWmtdxlWFCIMvZVcQR7BIRZJ/Bh97b4ysMkR4BKV+NgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/QehRmoIskYdUsC/TGxYCV8xG9hzp4xwQBL3k0SHV4=;
 b=iglCkqR1+dabhiE5fVnWOu7+aGbTH3qhvlZno1fES1KldxWV3EW2tz5beHqhL4PVNHipnjssMbUKIIJ2/lF/MzweVj1st7/1BGXfQIZN2tr3/nWZXtLEen7y53EA0Yao9ISGS1CVcfqixEZc0TVIQmX8YHF5FtbczDoqkxiEm3xGWBdXLcrT4ki0Z5OzHXmUiGP/tbTyOIhuW3d0r1PSQYo2j9Xh69nsqEsrpFu74w/3Ta5eB07OcEddgaP5CceItrCUWEutWwAysVcvYsO6I1XvZVXmLXFhVb1xCwOehOwlEXP9E7m6lNjvK47r0Ms+Z60rChEHWFvQkTSQqVXaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/QehRmoIskYdUsC/TGxYCV8xG9hzp4xwQBL3k0SHV4=;
 b=y5nG5VIXtQQ414npK4NF+1yPKUjyqZA9IIG3DnItXVUzapZi1EYkX/Nw/5/IPEaIG7PZda+neGxVY96Gj3iVaOJBAicC4Lquia1ee5JLW/FvG609PlDbqNEQOtuzphXHmVODJ4oUZnqsRRS0RXnsCCh8UdddSIGbKcH6kaOkpcc=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:46:10 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::5d) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 16:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 16:46:08 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 11:46:06 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH 1/4] drm/edid: Parse AMD VSDB for FreeSync refresh range
Date: Tue, 21 Jul 2026 12:44:27 -0400
Message-ID: <20260721164430.2121326-2-Alex.Huang2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721164430.2121326-1-Alex.Huang2@amd.com>
References: <20260721164430.2121326-1-Alex.Huang2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: c2310580-b493-4cad-3959-08dee7479051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|921020|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nFomYEoj83ZyTV0B2zxvMHUlXdPn3hYbOG4uvEAkHBQdHiiEWaoIxfUy1bzoKR5kOrubrVTn5KQywRFASiPdc0d4OZVD1ku5mgwo29OVWJxgc3+jVy6YBKFX9MQSNr7qQamz+0NPsR65OuurLKVMWTbSirjtsO6kxjzTx5LNysisVpL7YPRxllEswlXYsEpSh5Jcg5caFgKVzH4TXH5vvJwsrtXwmmOtOReMUU+0BeCH7OI+bLECZaGd3ruV8k0PbK7Dm/2K8ZAi3MPcHdTZ6JJTbK0njSpWTeVU2RLlhsWqaU/JrjADLFkvEqzQ4DmTO02OcJm54B1WUcDTmRTjAjBTFOfJZi7R6c2RF+K9DS8ZxoLiifQQVwtq7zM2eeIeDzxFm123iQ0vUHwfMYUfZD8CgB7iAsauZfC5puFlwwsddRaWsQ8botjJo5JTl1gAPcxnVS/XyMGYCRM/jdI19XnuBBqTTZ6cJv0bJmvajHpYsza72DIt64yhCGttA7G5NFQd6D409mR6uSVAwDknHYaYtZ51xTLbjPqy+1g9RSoE0Dra6R5aIx8B/ocYO6y9mnpQhtMwtAeO7kwdKU33l40Gs8YTULhtzvnSE/tBj/gPDXjXojCu/Dr8ysZZjwygrA8c5H+Yt0/MiaQX1TxapltS0D+Kx5FpMhVSLEv4+WfP2nILhFdbbBQV7qzDId9Jo86kfq3g6qYyj2ufBxDXEoa4gqWymgwWa405GJ1qNnyI0MwwJ/MpXR2qgJ5Rc3xB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(921020)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2cAB/ipDU93FtR42Qc0j9flKNuDwW9JbhRjNiT1HSP2jFsG72zDQhYE9mPpcYQmifTZEj5C7TZ3eSyn6DX8VDx58M6AdpK5JvgzmsnIEnUcooQ9fKe0PYY5NNQ/m7rG3XJUtBOlTVeeq7NnZjcuvdnnLoPQzKjewO2XDN/xTf+bA3YUGaxLYt99MrBVzXQ6t1q7U7Ndyb09dB0dN1G4fPtd6P1/qYh06SNFerMdtZy3qiQB09vcX5WeXqj1SGJwKcRkSbhcf+OJQgM3ZCogYWjlv4FpxoA11RGIzN1iqs94+iUR9NrUVWLc27l1dwlFtpu4V3MqXLFSWUQ3iCKgasFACfBZ6OYnBM55Xnc2fKYiBlvNUzIC2c4QQAzOXqEZHqXbTatKHFuS0zVKs02XO9RRVhgFG9cwTHVvJJ/U6gEQ98m23FoSghOW3hholcCRh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:46:08.2695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2310580-b493-4cad-3959-08dee7479051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741
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

Commit 118362a96286 ("drm/edid: Parse AMD Vendor-Specific Data Block")
added parsing of the AMD VSDB, but only for version 3 and only for the
replay/panel-type/luminance fields. Monitors that only advertise
FreeSync through a v1 or v2 AMD VSDB therefore get no variable refresh
rate range from the common EDID parser.

Restructure drm_parse_amd_vsdb() and implement parsing for the FreeSync
refresh range fields provided in the AMD VSDB.

Signed-off-by: Alex Huang <Alex.Huang2@amd.com>
---
 drivers/gpu/drm/drm_edid.c  | 134 ++++++++++++++++++++++++++++--------
 include/drm/drm_connector.h |  22 +++++-
 2 files changed, 126 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index df3c25bac761..c9452066b9be 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -101,20 +101,58 @@ enum drm_edid_internal_quirk {
 #define MICROSOFT_IEEE_OUI	0xca125c
 #define AMD_IEEE_OUI        0x00001A
 
+#define AMD_VSDB_V1_PAYLOAD_LEN 8
+#define AMD_VSDB_V2_PAYLOAD_LEN 13
 #define AMD_VSDB_V3_PAYLOAD_MIN_LEN 15
-#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 20
+#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 21
+
+#define AMD_VSDB_V3_MAX_VFREQ_EXT2_LEN 21
+
+struct amd_vsdb_common_payload {
+	u8 oui[3];
+	u8 version;
+} __packed;
+
+struct amd_vsdb_v1_payload {
+	u8 oui[3];
+	u8 version;
+	u8 feature_caps;
+	u8 min_vfreq;
+	u8 max_vfreq;
+	u8 freesync_vcp_code;
+} __packed;
+
+struct amd_vsdb_v2_payload {
+	u8 oui[3];
+	u8 version;
+	u8 feature_caps;
+	u8 min_vfreq;
+	u8 max_vfreq;
+	u8 freesync_vcp_code;
+	u8 cs_eotf_support;
+	u8 lum1_max;
+	u8 lum1_min;
+	u8 lum2_max;
+	u8 lum2_min;
+} __packed;
 
 struct amd_vsdb_v3_payload {
 	u8 oui[3];
 	u8 version;
 	u8 feature_caps;
-	u8 rsvd0[3];
+	u8 min_vfreq;
+	u8 max_vfreq;
+	u8 freesync_vcp_code;
 	u8 cs_eotf_support;
 	u8 lum1_max;
 	u8 lum1_min;
 	u8 lum2_max;
 	u8 lum2_min;
-	u8 rsvd1[2];
+	u8 max_vfreq_ext_low;
+	/*
+	 * byte 14: bits 0-1 extend MSB of max refresh rate
+	 */
+	u8 max_vfreq_ext_high;
 	/*
 	 * Bytes beyond AMD_VSDB_V3_PAYLOAD_MIN_LEN are optional; a
 	 * monitor may provide a payload as short as 15 bytes.  Always
@@ -5231,7 +5269,7 @@ static bool cea_db_is_microsoft_vsdb(const struct cea_db *db)
 static bool cea_db_is_amd_vsdb(const struct cea_db *db)
 {
 	return cea_db_is_vendor(db, AMD_IEEE_OUI) &&
-		cea_db_payload_len(db) >= AMD_VSDB_V3_PAYLOAD_MIN_LEN &&
+		cea_db_payload_len(db) >= AMD_VSDB_V1_PAYLOAD_LEN &&
 		cea_db_payload_len(db) <= AMD_VSDB_V3_PAYLOAD_MAX_LEN;
 }
 
@@ -6431,43 +6469,81 @@ static void drm_parse_microsoft_vsdb(struct drm_connector *connector,
 		    connector->base.id, connector->name, version, db[5]);
 }
 
+static void drm_parse_amd_vsdb_v1(struct drm_display_info *info,
+				  const u8 *data)
+{
+	const struct amd_vsdb_v1_payload *p =
+		(const struct amd_vsdb_v1_payload *)data;
+
+	info->amd_vsdb.freesync_supported = p->feature_caps & 0x1;
+	info->amd_vsdb.min_frame_rate = p->min_vfreq;
+	info->amd_vsdb.max_frame_rate = p->max_vfreq;
+	info->amd_vsdb.freesync_vcp_code = p->freesync_vcp_code;
+}
+
+static void drm_parse_amd_vsdb_v2(struct drm_display_info *info,
+				  const u8 *data)
+{
+	const struct amd_vsdb_v2_payload *p =
+		(const struct amd_vsdb_v2_payload *)data;
+
+	info->amd_vsdb.luminance_range1.max_luminance = p->lum1_max;
+	info->amd_vsdb.luminance_range1.min_luminance = p->lum1_min;
+	info->amd_vsdb.luminance_range2.max_luminance = p->lum2_max;
+	info->amd_vsdb.luminance_range2.min_luminance = p->lum2_min;
+}
+
+static void drm_parse_amd_vsdb_v3(struct drm_display_info *info,
+				  const u8 *data, int payload_len)
+{
+	const struct amd_vsdb_v3_payload *p =
+		(const struct amd_vsdb_v3_payload *)data;
+	u16 max_frame_rate;
+
+	info->amd_vsdb.replay_mode = p->feature_caps & 0x40;
+	info->amd_vsdb.panel_type = (p->cs_eotf_support & 0xC0) >> 6;
+
+	/* vfreq is provded in a different set of fields for v3. */
+	max_frame_rate = p->max_vfreq_ext_low |
+			 (p->max_vfreq_ext_high & 0x3) << 8;
+
+	/*
+	 * The AMD VSDB v3 payload length is variable (15..21 bytes).
+	 * All fields through max_vfreq_ext_high (byte 14) are always
+	 * present, but p->extra[] (bytes 15+) may not be, so any access
+	 * to extra[] must be guarded with a runtime length check to
+	 * avoid out-of-bounds reads on shorter (but spec-valid) payloads.
+	 */
+	if (payload_len >= AMD_VSDB_V3_MAX_VFREQ_EXT2_LEN)
+		max_frame_rate |= (p->extra[5] & 0x3) << 10;
+
+	info->amd_vsdb.max_frame_rate = max_frame_rate;
+}
+
 static void drm_parse_amd_vsdb(struct drm_connector *connector,
 			       const struct cea_db *db)
 {
 	struct drm_display_info *info = &connector->display_info;
 	const u8 *data = cea_db_data(db);
-	const struct amd_vsdb_v3_payload *p;
-
-	p = (const struct amd_vsdb_v3_payload *)data;
+	const struct amd_vsdb_common_payload *common =
+		(const struct amd_vsdb_common_payload *)data;
 
-	if (p->version != 0x03) {
+	if (common->version < 1 || common->version > 3) {
 		drm_dbg_kms(connector->dev,
 			    "[CONNECTOR:%d:%s] Unsupported AMD VSDB version %u\n",
-			    connector->base.id, connector->name, p->version);
+			    connector->base.id, connector->name, common->version);
 		return;
 	}
 
-	info->amd_vsdb.version = p->version;
-	info->amd_vsdb.replay_mode = p->feature_caps & 0x40;
-	info->amd_vsdb.panel_type = (p->cs_eotf_support & 0xC0) >> 6;
-	info->amd_vsdb.luminance_range1.max_luminance = p->lum1_max;
-	info->amd_vsdb.luminance_range1.min_luminance = p->lum1_min;
-	info->amd_vsdb.luminance_range2.max_luminance = p->lum2_max;
-	info->amd_vsdb.luminance_range2.min_luminance = p->lum2_min;
+	info->amd_vsdb.version = common->version;
 
-	/*
-	 * The AMD VSDB v3 payload length is variable (15..20 bytes).
-	 * All fields through p->rsvd1 (byte 14) are always present,
-	 * but p->extra[] (bytes 15+) may not be.  Any future access to
-	 * extra[] must be guarded with a runtime length check to avoid
-	 * out-of-bounds reads on shorter (but spec-valid) payloads.
-	 * For example:
-	 *
-	 *   int len = cea_db_payload_len(db);
-	 *
-	 *   if (len > AMD_VSDB_V3_PAYLOAD_MIN_LEN)
-	 *       info->amd_vsdb.foo = p->extra[0];
-	 */
+	drm_parse_amd_vsdb_v1(info, data);
+
+	if (common->version >= 2)
+		drm_parse_amd_vsdb_v2(info, data);
+
+	if (common->version >= 3)
+		drm_parse_amd_vsdb_v3(info, data, cea_db_payload_len(db));
 }
 
 static void drm_parse_cea_ext(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5f5ca023cd65..0914a2bd8ef1 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -697,7 +697,7 @@ enum drm_bus_flags {
  * struct drm_amd_vsdb_info - AMD-specific VSDB information
  *
  * This structure holds information parsed from the AMD Vendor-Specific Data
- * Block (VSDB) version 3.
+ * Block (VSDB) versions 1 to 3.
  */
 struct drm_amd_vsdb_info {
 	/**
@@ -705,6 +705,26 @@ struct drm_amd_vsdb_info {
 	 */
 	u8 version;
 
+	/**
+	 * @freesync_supported: FreeSync (variable refresh rate) supported by panel
+	 */
+	bool freesync_supported;
+
+	/**
+	 * @min_frame_rate: FreeSync minimum refresh rate in Hz
+	 */
+	u16 min_frame_rate;
+
+	/**
+	 * @max_frame_rate: FreeSync maximum refresh rate in Hz
+	 */
+	u16 max_frame_rate;
+
+	/**
+	 * @freesync_vcp_code: MCCS VCP code for FreeSync
+	 */
+	u8 freesync_vcp_code;
+
 	/**
 	 * @replay_mode: Panel Replay supported
 	 */
-- 
2.34.1

