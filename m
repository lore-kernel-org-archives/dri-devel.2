Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B680010BA439
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB2A10E398;
	Fri, 27 Mar 2026 08:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rp3Dmc+3";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F6D10E186;
 Fri, 27 Mar 2026 08:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNI/AET2+6St0XKPSGnur9trJTVB0x0xH1GkSyILcnmk6dOgaQISlOExVIq2BTvQWYMbce1I2/2ehPioujFcKbwiLCpPMADCx/EL6zc2L7pEeCSMqP2FvkpkKDK6eF+qR4J+6RAz4cXciZ6zUNw3esLX5Rl+nJMwkSZUwCdH+0MOkkF3ckF2ACidhKJ7+3u91qIYmfqnq7dwFXOn9akm5GeqV0vs0iamT+p+7G9fj75TWUj9Wno79p4sULB2jPN//IMjpWwskaoz45ypYv48se4d/F9PNPLj2B5zqXamC8rjDhdjDuaKAfoRagDs+hgn27W10qmaGG8VeJoje3gO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6Gtr9jgLEqHuFZ2AZFNjNN/BphdTUuVY0Wgm6lpqZE=;
 b=iJeptjaXK1tx+olO0Xz0D9QqayVu1QLwR/M8w1OQe0vWg1iRBtnWUcRbEefJz/J10J/7ASvNxJ+J3chzmT0XutAN9T/vRy9RmIZziXi034MLi5LsPKUvdLTVo7Fr3yQNTMmrrUhAHuQcuIs6PBZ+oNyzSGPFwVlj5C0b8Db/v283f+CnkOdrDCTdeCtLDg6sfNOnXldSor92t0jv8/rXFOhgaNSetlEMDZ1V3BlxMXvJKP0fsl3eHLyyAZNViMewECBh67/r6xOrGmdnbQKKO+ND1gEOP0xZ5wObgqGgaPclhX2lDB5nnUuEEAXhQIjuBg2va9MeYVnmFgC18kCWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6Gtr9jgLEqHuFZ2AZFNjNN/BphdTUuVY0Wgm6lpqZE=;
 b=rp3Dmc+3wtEs7cg8SBkSBCyH7HzfIpMg1qbKLQWQocJaVH5hwzcndkwF/zpwQ2AICBoP0XlnM2Hq07kbwrX6YJ6TRHOVdEWP4cjHINBJuD1KsO5A7HlHyTW9ODQP9ZaLIPSC5U5YR6Xt/PFOBjrSk0RTsv4z1ZFIHfnIeaSt4fE=
Received: from MN2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:208:23c::17)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.8; Fri, 27 Mar 2026 08:24:03 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::19) by MN2PR18CA0012.outlook.office365.com
 (2603:10b6:208:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.24 via Frontend Transport; Fri,
 27 Mar 2026 08:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 08:24:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 03:23:54 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 03:23:53 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Limonciello Mario <Mario.Limonciello@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 1/2] drm/edid: Parse AMD Vendor-Specific Data Block
Date: Fri, 27 Mar 2026 16:21:58 +0800
Message-ID: <20260327082342.1286878-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327082342.1286878-1-chen-yu.chen@amd.com>
References: <20260327082342.1286878-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: dd660545-f0ff-4478-13c5-08de8bda3469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: kOBMFkdJRlY75G83zQJPpaKfMV8zxnC8GCYFmwkmPOUL1SieshSgPge5cI6RLKRIMyWh6NBIw1qTGB8E4eKnxNegUqE8s6Zz2w1uBofvwcADEulxKpGJdOoYjeP+DTpT3bKUh+AsBR2B1+OPTd/I+lf2tY3EmIprvup+wy1i2DVtyu19HBa0PrFptrL0CxYFdaMlQgWOXA2NfCLP9mrJsBeFVQR/mpc/nVnEpio4SdSE3tqLc9ggUUziWOUMhvRo/fGe8iuciwzoSFG3d6eyiTblSvz8RBCLORULOSSfmhgeZUELbjm6GuE3/BWDqvV84N5hX7UnXBSU7N+Cr0C9qNDgKITn3yPZ3U4z7hY+58LNjGur3Z/DtLmcg9Yh8kixO+4tPO1T8EEq6iRnBpfOQGYVbpzXnmcXDOCNySColJuQkSGEPgxD8pFU4LhkZMON7lk5evePr86bcyffr9VxbxhXHjYldlEfd00GQM55V+HXttydzrGG3tVB+FSHYdmZRtWoiFMEwkmx/xHYsLLc1a4G0p1Q+YXgS6En5Ggb3eL8IAx1r8KBk47t+nyr6wO9Hj+eZabSClEqVW6YWR7fu4nG+nMcqKpuW1paeEbxJV0v259xZXEzoORO2g9ULBpEiZtqkbmJGhdWgc5Y9+QGNGVbUHqSVEIhUEpzDFpGJXRk2FqUZEUdu4dfpuJ/SWHzXZSfYDp/lvWVMUrMjZ3Vi18fcB2huF3zCbwVQghsFvj7B2+QEGM4ArFTWkEMjr1C8JOov6vQf+lsCJI7R0ZsPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bAd/02a1otcp0Q9ScnuvD3zGMgKstOpPkQgjULwqNRo0S04sSzj33ynzPANCUneldsYVodVIJ9NdQNXlGF/KB59BZywMgKCte0swfintLoNkBTZAOEwBGL1XTUnKB8Zlmp3xk2zjKoP2BF7qyzjTyQAw3kfl7w4uv/rUYYnfEbHK+os3Z2MTSR1ts3owKYGNJHKBMK0x3Ra1wFZomuCk78JMUmdBPsa34THsho7fRhtup3ZlzD6vRZCfVs0gZIk2W9O5xila9RqY3N7tOx6nNHqHY87SvhIv0KrOjeZgvee/nxUuc9rkDt5qHsS+l7o5ORCV6WzIUSKYKRKxyFWd5ssjWoS99ickacZFNTbTYPjEy2SnDGHQhVV3LQpxISfHAtO4tQ/rn3vTUG5WLccm9msH7I7tL4KsGalnfWXBMFmC1gU/70H7ZySWRkRCm7/o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 08:24:03.1188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd660545-f0ff-4478-13c5-08de8bda3469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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

Parse the AMD VSDB v3 from CTA extension blocks and store the result
in struct drm_amd_vsdb_info, a new field of drm_display_info. This
includes replay mode, panel type, and luminance ranges.

Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/drm_edid.c  | 72 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h | 38 ++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 26bb7710a462..76280e6e1892 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -99,6 +99,29 @@ enum drm_edid_internal_quirk {
 };
 
 #define MICROSOFT_IEEE_OUI	0xca125c
+#define AMD_IEEE_OUI        0x00001A
+
+#define AMD_VSDB_V3_PAYLOAD_MIN_LEN 15
+#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 20
+
+struct amd_vsdb_v3_payload {
+	u8 oui[3];
+	u8 version;
+	u8 feature_caps;
+	u8 rsvd0[3];
+	u8 cs_eotf_support;
+	u8 lum1_max;
+	u8 lum1_min;
+	u8 lum2_max;
+	u8 lum2_min;
+	u8 rsvd1[2];
+	/*
+	 * Bytes beyond AMD_VSDB_V3_PAYLOAD_MIN_LEN are optional; a
+	 * monitor may provide a payload as short as 15 bytes.  Always
+	 * check cea_db_payload_len() before accessing extra[].
+	 */
+	u8 extra[AMD_VSDB_V3_PAYLOAD_MAX_LEN - AMD_VSDB_V3_PAYLOAD_MIN_LEN];
+} __packed;
 
 struct detailed_mode_closure {
 	struct drm_connector *connector;
@@ -5205,6 +5228,13 @@ static bool cea_db_is_microsoft_vsdb(const struct cea_db *db)
 		cea_db_payload_len(db) == 21;
 }
 
+static bool cea_db_is_amd_vsdb(const struct cea_db *db)
+{
+	return cea_db_is_vendor(db, AMD_IEEE_OUI) &&
+		cea_db_payload_len(db) >= AMD_VSDB_V3_PAYLOAD_MIN_LEN &&
+		cea_db_payload_len(db) <= AMD_VSDB_V3_PAYLOAD_MAX_LEN;
+}
+
 static bool cea_db_is_vcdb(const struct cea_db *db)
 {
 	return cea_db_is_extended_tag(db, CTA_EXT_DB_VIDEO_CAP) &&
@@ -6401,6 +6431,45 @@ static void drm_parse_microsoft_vsdb(struct drm_connector *connector,
 		    connector->base.id, connector->name, version, db[5]);
 }
 
+static void drm_parse_amd_vsdb(struct drm_connector *connector,
+							   const struct cea_db *db)
+{
+	struct drm_display_info *info = &connector->display_info;
+	const u8 *data = cea_db_data(db);
+	const struct amd_vsdb_v3_payload *p;
+
+	p = (const struct amd_vsdb_v3_payload *)data;
+
+	if (p->version != 0x03) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] Unsupported AMD VSDB version %u\n",
+			    connector->base.id, connector->name, p->version);
+		return;
+	}
+
+	info->amd_vsdb.version = p->version;
+	info->amd_vsdb.replay_mode = p->feature_caps & 0x40;
+	info->amd_vsdb.panel_type = (p->cs_eotf_support & 0xC0) >> 6;
+	info->amd_vsdb.luminance_range1.max_luminance = p->lum1_max;
+	info->amd_vsdb.luminance_range1.min_luminance = p->lum1_min;
+	info->amd_vsdb.luminance_range2.max_luminance = p->lum2_max;
+	info->amd_vsdb.luminance_range2.min_luminance = p->lum2_min;
+
+	/*
+	 * The AMD VSDB v3 payload length is variable (15..20 bytes).
+	 * All fields through p->rsvd1 (byte 14) are always present,
+	 * but p->extra[] (bytes 15+) may not be.  Any future access to
+	 * extra[] must be guarded with a runtime length check to avoid
+	 * out-of-bounds reads on shorter (but spec-valid) payloads.
+	 * For example:
+	 *
+	 *   int len = cea_db_payload_len(db);
+	 *
+	 *   if (len > AMD_VSDB_V3_PAYLOAD_MIN_LEN)
+	 *       info->amd_vsdb.foo = p->extra[0];
+	 */
+}
+
 static void drm_parse_cea_ext(struct drm_connector *connector,
 			      const struct drm_edid *drm_edid)
 {
@@ -6449,6 +6518,8 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 			drm_parse_hdmi_forum_scds(connector, data);
 		else if (cea_db_is_microsoft_vsdb(db))
 			drm_parse_microsoft_vsdb(connector, data);
+		else if (cea_db_is_amd_vsdb(db))
+			drm_parse_amd_vsdb(connector, db);
 		else if (cea_db_is_y420cmdb(db))
 			parse_cta_y420cmdb(connector, db, &y420cmdb_map);
 		else if (cea_db_is_y420vdb(db))
@@ -6641,6 +6712,7 @@ static void drm_reset_display_info(struct drm_connector *connector)
 	info->quirks = 0;
 
 	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
+	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
 }
 
 static void update_displayid_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c18be8c19de0..c398dbc68bbc 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -667,6 +667,39 @@ enum drm_bus_flags {
 	DRM_BUS_FLAG_SHARP_SIGNALS = BIT(8),
 };
 
+/**
+ * struct drm_amd_vsdb_info - AMD-specific VSDB information
+ *
+ * This structure holds information parsed from the AMD Vendor-Specific Data
+ * Block (VSDB) version 3.
+ */
+struct drm_amd_vsdb_info {
+	/**
+	 * @version: Version of the Vendor-Specific Data Block (VSDB)
+	 */
+	u8 version;
+
+	/**
+	 * @replay_mode: Panel Replay supported
+	 */
+	bool replay_mode;
+
+	/**
+	 * @panel_type: Panel technology type
+	 */
+	u8 panel_type;
+
+	/**
+	 * @luminance_range1: Luminance for max back light
+	 */
+	struct drm_luminance_range_info luminance_range1;
+
+	/**
+	 * @luminance_range2: Luminance for min back light
+	 */
+	struct drm_luminance_range_info luminance_range2;
+};
+
 /**
  * struct drm_display_info - runtime data about the connected sink
  *
@@ -861,6 +894,11 @@ struct drm_display_info {
 	 * Defaults to CEC_PHYS_ADDR_INVALID (0xffff).
 	 */
 	u16 source_physical_address;
+
+	/**
+	 * @amd_vsdb: AMD-specific VSDB information.
+	 */
+	struct drm_amd_vsdb_info amd_vsdb;
 };
 
 int drm_display_info_set_bus_formats(struct drm_display_info *info,
-- 
2.43.0

