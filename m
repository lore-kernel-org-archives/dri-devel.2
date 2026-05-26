Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3E1CD5BC9
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 03:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56A410E442;
	Tue, 26 May 2026 03:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJss0g8t";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C1B10E43F;
 Tue, 26 May 2026 03:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4pUeXA6/8L6h1zjiPEOxYcTU/AGvWxeSgokGsvqlrbSrkIjf/NUjywWdCHsItJY1ChntYmqk60VQvnC1FVk4VHxxsIpd+QyRRhxvjsl6lY0iKVm1JRhG1dEI/wtNxJ3NE8R+2htB5t2l8JHdjEI/yuCq2BVGKOx6/m6FFb4p5mpNIN0dpzLBEsfvkqPbofmJxSEvHIuIzglPOBHR5FFyoSMefyZpdIAUQSnW6gs6NyymNZxw7oE4buRbdkLFvIJmavo0ENpa0zzaQ1tcpIm1+BprIqfkqIODbGJqzsudG/7Iq2+lDyoWvu9GXEYyM0zp5srQGIrefzmvPwWSARn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUXdD82TkZP0IeUv/UNBn0vu2jGIK3ARFx46TRxAE2U=;
 b=QHJu2yAY0oFXACZr0KfYnSaU462SFnKMBIhYM7wlU5XB7IQeUKyp84pVifryWZXyl9QGwtHlgXR2h8CRfg16tU9mrOAsfPfFh2iH5+mZ1p2jh2heiuAZrKTvOYUZGnviLtyVAxiIkLVjnD21BFR8dyrvayFIZAfuLPleA7FdaD310Ygw6Aq/PF+i2fNt4MLw4hN5hzJCcTuXwSte4P9dC2BA24eaxBorraVlzI0khEQfq19DtXmruMC62p9UWjAYKpzcxALw1mChUtz2c1GajyBmAMosDq6jBMufM6RUUKzmn7689zihNzHdrEJtMdFZppsOSZPqlq8ehq6pxd2lRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUXdD82TkZP0IeUv/UNBn0vu2jGIK3ARFx46TRxAE2U=;
 b=AJss0g8tuRb2TUiFnVdSJ2FVjW35a8i4VUX7/Y8FrO63w2eUHG+UGr2RTzU8N9xf93szYxWa9dEEMPKLZXUcLAPWxgWRHZG1vKUhyaDLrZ2TBu/UwcXeX5oZAtAAoZN9kWVpA7wa4OEM7Q1bstFq4nWD//xpD88hxQ6MYm0y6Qs=
Received: from BN0PR04CA0136.namprd04.prod.outlook.com (2603:10b6:408:ed::21)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 03:03:10 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::9e) by BN0PR04CA0136.outlook.office365.com
 (2603:10b6:408:ed::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 03:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 26 May 2026 03:03:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 22:03:08 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 22:03:06 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH v3 1/3] drm/edid: extract base section header processing into
 helper
Date: Tue, 26 May 2026 10:59:49 +0800
Message-ID: <20260526030254.1460480-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526030254.1460480-1-chen-yu.chen@amd.com>
References: <20260526030254.1460480-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a10ced-8ae6-4f7b-ea92-08debad350db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: tXpI8lGu/RXRtIHhJphysRQzB6+Qu/QT751XXP1p5X+wBYik+PGAM7WEzeEz15zwEVLOvwyuMK8mJZJl3qGgBzIkpc0VAbZm47LVWSZOA+/5hnMWHl4lncM137iZx8o09h9Xnq8qOiwZsNyTIjp6YfdKDxYgRvloRb54xdw/48RNJ6Y5rLgh+GDhBKJ1mlRIe2UAUdZfwC83UUFP7WR4rHfD8EEDaTFco2dNbzhV8+900xJ89WNiBZFqOO2LScPaGEE6zy/TTtnGZEV4i85GqRsf4cvWKd1wrDH1l0g/qKTFW/Gm6EwvTB6I6WF01MXjc6A1mzZFPMimZ3J2cioI/z/k4WzQBKn5FOHRVFSsBHNZ9gzK0++LNkRDRQBLkBbJF1BO+eYQWWr2tFoTD20hqvRy0gnWGSEdDfu7C2h8XrgNdBrVlzgi5wR1egJxZXa1mWQ4u4vFYH5+tBio1h16K7TuUh3Vs7Mg+KN5XgiKdqwK/IxqXNtr5NqFyyFd7OKl4EW+T+wAg3bep2ozJYD3rGzA9m2WKv7RXpWzrzSBBFZAMBDh5dbGMpPp9xHs3nx05LStOESErXCNJisifXWUbA8j2uiwaAab7rmeVCmQxwlua/9UGO2ioqGa7RrSxwBq3w6r0ygaALlLK3/rcClxGRy+fuw6eP9lD8u8P95s5msHwouQm289aruYc0jh7+RpyZpWTd4N2uGTTkHQ3yjONuJ7n+ej1m+dKk9harypQF0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5eH9sUY6Ijb6QrX4hcNnwN/tYDsU+G1hAM3nUO7hcEydBUSLqKlsNqCV/6RQFJfqs9b8BUjaESWuSpVN1mVbaJeDDYruZNmol5FXLWRLgsBuzuYowXr2Xj2Dqq96pX60JMDJ0/HoJC79WA249jLD68BRK/GHyion5Cs6K1J2k0M6yqKgKKzuC72rp9tnl0FVAhTIcuT1aPA45D+/ZQ4WadBcEUkwfROB0fgI8raSSYjJLqxErP+6gVW5j3NBohJZxhwXi5d/bHLL61V2p3NaMybd0IFkh5BfQVaicCdVPxMPu9XrYIZ7wI0J63+ZPGKWBvY3ZFo+7R3AdRpwDaN5cZwL1R7CeC0ASR2FXGhSb17urUdiNGXQZ16793H7mhCyO4a3zBt6cKrIJ7SVPh4T9vCaHpPGPG8rAyj7F4rHNG887L2GY/JczQuEm1LyfAsu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 03:03:09.0256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a10ced-8ae6-4f7b-ea92-08debad350db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

Extract the DisplayID base section header logging and non_desktop
detection from update_displayid_info() into a dedicated helper,
drm_displayid_process_base_section_header(). Remove the break so the
iterator walks through all data blocks, preparing for future patches
that will parse additional block types within the loop.

The helper is called only once for the base section via a
base_section_header_processed flag. Since version and primary_use are
only captured from the base section, and extension sections carry a
primary use of zero per spec, the non_desktop logic is unaffected.

No functional change.

Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/drm_edid.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 8031f021d4d0..7ad3f939dbe6 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6715,30 +6715,35 @@ static void drm_reset_display_info(struct drm_connector *connector)
 	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
 }
 
+static void drm_displayid_process_base_section_header(struct drm_connector *connector,
+						      const struct displayid_iter *iter)
+{
+	struct drm_display_info *info = &connector->display_info;
+
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
+		    connector->base.id, connector->name,
+		    displayid_version(iter),
+		    displayid_primary_use(iter));
+	if (displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
+	    (displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
+	     displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
+		info->non_desktop = true;
+}
+
 static void update_displayid_info(struct drm_connector *connector,
 				  const struct drm_edid *drm_edid)
 {
-	struct drm_display_info *info = &connector->display_info;
 	const struct displayid_block *block;
 	struct displayid_iter iter;
+	bool base_section_header_processed = false;
 
 	displayid_iter_edid_begin(drm_edid, &iter);
 	displayid_iter_for_each(block, &iter) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
-			    connector->base.id, connector->name,
-			    displayid_version(&iter),
-			    displayid_primary_use(&iter));
-		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
-		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
-		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
-			info->non_desktop = true;
-
-		/*
-		 * We're only interested in the base section here, no need to
-		 * iterate further.
-		 */
-		break;
+		if (!base_section_header_processed) {
+			drm_displayid_process_base_section_header(connector, &iter);
+			base_section_header_processed = true;
+		}
 	}
 	displayid_iter_end(&iter);
 }
-- 
2.43.0

