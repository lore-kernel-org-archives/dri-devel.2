Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E66C53200
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E4D10E05E;
	Fri, 24 Jul 2026 16:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cAPuhvZ9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37DD10E059;
 Fri, 24 Jul 2026 16:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdVS0VjRhlSCzO6IzwdBle5rHkgknw73E3KcjNRO/HkmoYUoYr4oVvKceqtxpSmnc48V5oZC7Nj2UlW+cr72VsJ+Vg3YvQDaGOqgJJv1DiUDHTk2MHgOROeotVdWQih3awhA4jZqsiTOnmFVh60WvBjc9uObfWNZXUb0XrmwjgYO4bKCjdM5jOEX0irTi/2HXcdoA/n5KGczWQ8f0xnX03gT/re5+gpkLbb/c+HoNadiD1CJjpsE6fFeA1UC/s0+UnNtRmwSWF3D0ELD5/6z6zK2xi3bFdRRx9HWN9/nb98gTvCmHEuJSX83YKLNRJ2sz/0prWdll+qfYy7rbGVl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHu/J/2qm9eCemmAzvy/GI8yQp0cMupQkmhYrjmLGIM=;
 b=bAKtmLwnZMuCX7Mpwztyxwen7FpyQ7uVJEablml0sUO+dS30PcUitE3ddKXkZR63Ts2zSm1E5uqPxznmMeWU7jegFSlGnJs3qfWpIL+MwmIfTdsg+fVuhv/mMOgWFWORCB97lLsJpPazw6A+mgrFNmbEXJasr8cImK5+JeNQ55u3XhDeXNo5m8remUFy5DAqQYqjbDkL7OaB22DhkaUZI6uT+A2FtPell0TzR/+JZBkRZrAVXCtwr/p3hmvdnOqUVQ67hMocHeMz9grhi6RzQCVFPUnvKtVjix8tuALN/D6IkxTcxgxuXSOyhPRv+HjtjLonjviBnjBlpSc2FtpyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHu/J/2qm9eCemmAzvy/GI8yQp0cMupQkmhYrjmLGIM=;
 b=cAPuhvZ9XiIvFRiBW1/kEwoSL/AygEPlgrPJW/JdK94lAVvfUunGWprBaQWWfj2TXYdyXdjfWwRX3B/kYLApb8XAYu0DaE1lLmFE+QGXjwvhV/Rvf/Mk7zG1gQ/6lRpQutKy8yZYWryk3y7YapPDpP8jYFtdli2UGLfZ7+rDmto=
Received: from PH2PEPF0000385A.namprd17.prod.outlook.com (2603:10b6:518:1::7c)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 16:17:54 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2a01:111:f403:f90d::1) by PH2PEPF0000385A.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 16:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 16:17:53 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 11:17:52 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH v2 1/4] drm/edid: Parse AMD VSDB for FreeSync refresh range
Date: Fri, 24 Jul 2026 12:17:10 -0400
Message-ID: <20260724161713.119382-2-Alex.Huang2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724161713.119382-1-Alex.Huang2@amd.com>
References: <20260724161713.119382-1-Alex.Huang2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 9360d785-aa16-40fb-a49c-08dee99f1d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|7416014|22082099003|18002099003|10067099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: luCMbg0hPKmdskQFj2/yFoVKizSlacYU7nz60wwEQVhqSJ5MMVQx7z3weUtHcNsZuh3VNuFKtF3sE7xJ+zSK1Z9h8J0TK/zV+S00J1YZDfOisjYkHWjQ0QHnja7JdFWk3lnnqsJhSBDntDdcnvLBNdSUL2OCzFrotkc/iZ54toyW+BT6pOE+OqD0ISptQh+rDdi25QUR0QKi9oMrpY/8yuWKx1fnT83y51v7TVjVjraDwEYoqsXH65LLiDH9Fp05VVFuB09iITxIrvGepaQwtcdKINPF9PqTy8BEtjolknfMtawpyeadNbHOHcl88dsbis4w4TepITY8vtY/4Poj/FBqrGuWlvmzc/SH/LDiikFv6Y9+HWVqu6C9KD8vDDQHXeOMq2s2gFK6LHLBEhCnAq5v80wDJp9nt0luZ3DDtR64Bo0CHxkIAGavkclRmIo2+fA5xaPaoPh2EtacpaZ3rQD0ko7QLvSD3AY6anVmk+t89uWPfpVhYUkLvaWS6hKFBMP5BYFS+LYTF9SBRF3WR07Gtt7u+BEKa3TQr0z//ZpOFQPpAjyMCTu1z1dy/eWcCx/oaKr4v+XqXzs0XbKpkcZ5PRK44ZJbVun1LK5qVrADsihVYaFF5jAq1D/h5QFUGbdH7cSyHhuFjRlb7gm25ly8+nJrD3KtZc147tcd5Ua/6LlT3BajXQkL61/P4Rd0NbWYv/synzQ6OaLxMlT35KNOlj6F/PJyjPRnah1BnIoEi6Uj12iXlb8d0vuxxnYt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(7416014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AV6BhI79prS0m1ja80przKie1lZRVpO6wAcNRd89MkdOvazjFGU3D3w4p7MeB4JbQVsNYWM9RFvO5/RLG5M2iG7sOvQejDSO9teQ04IHdptY2semNoaNhAjiDHMhrBbViK53m5J0kCBkl8e9/1WPosZFON+Rc1aa9B4rbEhJWop8V5L8bFbt0KH8rkPKGAvWak6bEslGvwnKDs3MhhFPYFfLmjnm/Q6rJZdLUIiR1bGHsBTMGnvPIBufo91YcD7jQ2+iY6hmDGcGEeqMKO85s1+QEGu7AXhKk3W5s7uXnvTr27j+nS2kvI5UI7iaMZo6Ib6NputRAnYE+UrVf2qO1zyok0LFo01qHhzlHHplmMmjQVQPL5YVnSoerdigcXAaTuBjtPL0HjK5suOy5Tc6qXIjJnzPATTJEFwjMQCm1h1nTjNHIOOk+8dbFGkrYPkA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:17:53.4548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9360d785-aa16-40fb-a49c-08dee99f1d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965
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
 drivers/gpu/drm/drm_edid.c  | 141 ++++++++++++++++++++++++++++--------
 include/drm/drm_connector.h |  22 +++++-
 2 files changed, 133 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index df3c25bac761..2abe85b76d33 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -101,20 +101,42 @@ enum drm_edid_internal_quirk {
 #define MICROSOFT_IEEE_OUI	0xca125c
 #define AMD_IEEE_OUI        0x00001A
 
+#define AMD_VSDB_V1_PAYLOAD_LEN 8
+#define AMD_VSDB_V2_PAYLOAD_LEN 13
 #define AMD_VSDB_V3_PAYLOAD_MIN_LEN 15
-#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 20
+#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 21
 
-struct amd_vsdb_v3_payload {
+#define AMD_VSDB_V3_MAX_VFREQ_EXT2_LEN 21
+
+struct amd_vsdb_common_payload {
 	u8 oui[3];
 	u8 version;
+} __packed;
+
+struct amd_vsdb_v1_payload {
+	struct amd_vsdb_common_payload common;
 	u8 feature_caps;
-	u8 rsvd0[3];
+	u8 min_vfreq;
+	u8 max_vfreq;
+	u8 freesync_vcp_code;
+} __packed;
+
+struct amd_vsdb_v2_payload {
+	struct amd_vsdb_v1_payload v1;
 	u8 cs_eotf_support;
 	u8 lum1_max;
 	u8 lum1_min;
 	u8 lum2_max;
 	u8 lum2_min;
-	u8 rsvd1[2];
+} __packed;
+
+struct amd_vsdb_v3_payload {
+	struct amd_vsdb_v2_payload v2;
+	u8 max_vfreq_ext_low;
+	/*
+	 * byte 14: bits 0-1 extend MSB of max refresh rate
+	 */
+	u8 max_vfreq_ext_high;
 	/*
 	 * Bytes beyond AMD_VSDB_V3_PAYLOAD_MIN_LEN are optional; a
 	 * monitor may provide a payload as short as 15 bytes.  Always
@@ -123,6 +145,12 @@ struct amd_vsdb_v3_payload {
 	u8 extra[AMD_VSDB_V3_PAYLOAD_MAX_LEN - AMD_VSDB_V3_PAYLOAD_MIN_LEN];
 } __packed;
 
+static const u8 amd_vsdb_min_len[] = {
+	[1] = AMD_VSDB_V1_PAYLOAD_LEN,
+	[2] = AMD_VSDB_V2_PAYLOAD_LEN,
+	[3] = AMD_VSDB_V3_PAYLOAD_MIN_LEN,
+};
+
 struct detailed_mode_closure {
 	struct drm_connector *connector;
 	const struct drm_edid *drm_edid;
@@ -5231,7 +5259,7 @@ static bool cea_db_is_microsoft_vsdb(const struct cea_db *db)
 static bool cea_db_is_amd_vsdb(const struct cea_db *db)
 {
 	return cea_db_is_vendor(db, AMD_IEEE_OUI) &&
-		cea_db_payload_len(db) >= AMD_VSDB_V3_PAYLOAD_MIN_LEN &&
+		cea_db_payload_len(db) >= AMD_VSDB_V1_PAYLOAD_LEN &&
 		cea_db_payload_len(db) <= AMD_VSDB_V3_PAYLOAD_MAX_LEN;
 }
 
@@ -6431,43 +6459,98 @@ static void drm_parse_microsoft_vsdb(struct drm_connector *connector,
 		    connector->base.id, connector->name, version, db[5]);
 }
 
+static void drm_parse_amd_vsdb_common(struct drm_display_info *info,
+				  const struct amd_vsdb_common_payload *data)
+{
+	info->amd_vsdb.version = data->version;
+}
+
+static void drm_parse_amd_vsdb_v1(struct drm_display_info *info,
+				  const struct amd_vsdb_v1_payload *data)
+{
+	info->amd_vsdb.freesync_supported = data->feature_caps & 0x1;
+	info->amd_vsdb.min_frame_rate = data->min_vfreq;
+	info->amd_vsdb.max_frame_rate = data->max_vfreq;
+	info->amd_vsdb.freesync_vcp_code = data->freesync_vcp_code;
+
+	drm_parse_amd_vsdb_common(info, &data->common);
+}
+
+static void drm_parse_amd_vsdb_v2(struct drm_display_info *info,
+				  const struct amd_vsdb_v2_payload *data)
+{
+	info->amd_vsdb.luminance_range1.max_luminance = data->lum1_max;
+	info->amd_vsdb.luminance_range1.min_luminance = data->lum1_min;
+	info->amd_vsdb.luminance_range2.max_luminance = data->lum2_max;
+	info->amd_vsdb.luminance_range2.min_luminance = data->lum2_min;
+
+	drm_parse_amd_vsdb_v1(info, &data->v1);
+}
+
+static void drm_parse_amd_vsdb_v3(struct drm_display_info *info,
+				  const struct amd_vsdb_v3_payload *data,
+				  int payload_len)
+{
+	u16 max_frame_rate;
+
+	info->amd_vsdb.replay_mode = data->v2.v1.feature_caps & 0x40;
+	info->amd_vsdb.panel_type = (data->v2.cs_eotf_support & 0xC0) >> 6;
+
+	drm_parse_amd_vsdb_v2(info, &data->v2);
+
+	/* vfreq is provided in a different set of fields for v3. */
+	max_frame_rate = data->max_vfreq_ext_low |
+			 (data->max_vfreq_ext_high & 0x3) << 8;
+
+	/*
+	 * The AMD VSDB v3 payload length is variable (15..21 bytes).
+	 * All fields through max_vfreq_ext_high (byte 14) are always
+	 * present, but data->extra[] (bytes 15+) may not be, so any access
+	 * to extra[] must be guarded with a runtime length check to
+	 * avoid out-of-bounds reads on shorter (but spec-valid) payloads.
+	 */
+	if (payload_len >= AMD_VSDB_V3_MAX_VFREQ_EXT2_LEN)
+		max_frame_rate |= (data->extra[5] & 0x3) << 10;
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
+	int payload_len = cea_db_payload_len(db);
+	u8 version;
 
-	p = (const struct amd_vsdb_v3_payload *)data;
+	version = ((const struct amd_vsdb_common_payload *)data)->version;
 
-	if (p->version != 0x03) {
+	if (version < 1 || version > 3) {
 		drm_dbg_kms(connector->dev,
 			    "[CONNECTOR:%d:%s] Unsupported AMD VSDB version %u\n",
-			    connector->base.id, connector->name, p->version);
+			    connector->base.id, connector->name, version);
 		return;
 	}
 
-	info->amd_vsdb.version = p->version;
-	info->amd_vsdb.replay_mode = p->feature_caps & 0x40;
-	info->amd_vsdb.panel_type = (p->cs_eotf_support & 0xC0) >> 6;
-	info->amd_vsdb.luminance_range1.max_luminance = p->lum1_max;
-	info->amd_vsdb.luminance_range1.min_luminance = p->lum1_min;
-	info->amd_vsdb.luminance_range2.max_luminance = p->lum2_max;
-	info->amd_vsdb.luminance_range2.min_luminance = p->lum2_min;
+	if (payload_len < amd_vsdb_min_len[version]) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] AMD VSDB v%u payload too short (%d bytes)\n",
+			    connector->base.id, connector->name, version, payload_len);
+		return;
+	}
 
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
+	switch (version) {
+	case 3:
+		drm_parse_amd_vsdb_v3(info, (const struct amd_vsdb_v3_payload *)data,
+				      payload_len);
+		break;
+	case 2:
+		drm_parse_amd_vsdb_v2(info, (const struct amd_vsdb_v2_payload *)data);
+		break;
+	case 1:
+		drm_parse_amd_vsdb_v1(info, (const struct amd_vsdb_v1_payload *)data);
+		break;
+	}
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

