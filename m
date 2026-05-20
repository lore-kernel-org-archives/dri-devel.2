Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAB3CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 02:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBBA10EEC2;
	Wed, 20 May 2026 02:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ucwSWx6y";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567A710E60F;
 Wed, 20 May 2026 02:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWY1IcZLf1umGGlksKSE9F0ppnndd8MvzRHV4tIDYp1Ysdz+iSEUjCgjogg5rLmu4JUAqr5t8V7dbu/rR2vRQEV5rELdZXvyEtDpREgruEASFPoDZP9h4uUsJOJm9IThtH0w+QFX3uj9CN0iiJbL3NZI1gmt5DK6NgnLMoL1RQD62UkWKrHyX2NLFdJWBETEDzbquCIJSf1KxGseAXN7BsyGWQk6dhzQ7EpcXWygp58I9SoJiBn0ytYuUYFfAT0By8kB1vqOvVU5EAowp0RGjEXe2VPMPRKMBcZEg8QaAG79DuPhXvxf6fFNRPyVcCFT/8kNoZ5/NZFF3EXgkLJkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY4HVfwrsMKAw1aWhz/bns3o1/sZN2nzy/+Zz35KnW4=;
 b=B2ha3w/Hzy4nlISjzD7mVBuRndZk++KNhGQaKVqByo9MWxblqqR++xOWJVSQ4yPgjJ5EsGfyBiPKpr66OMT4MSrEw4IIGr7jgDs3LO0Q8DtOAnlnF5K2m6CyyMQVYv7cgbEZCgDn59WCMO6duZ0wqIzk/YfCaCu+BRxo7xeeYBX+svD1AY2CCm5oZ2veI4fEf2cjy6k9zldZ2p9au/rojaFnoshl0UmlVAje2k7Z4GRsJy4WAeSovfelLERa72V6u9P7dDU2Tpbvg1aMPEcryzIY0dbO/6gTC0AD01oZ9eCUZR8ifr25+JeDL69W2aCB7YAYNUodS9l0+w9meowfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY4HVfwrsMKAw1aWhz/bns3o1/sZN2nzy/+Zz35KnW4=;
 b=ucwSWx6ySKNWV7QORvhzNlGRk4Nz9U+XbUJ0XD1DUUM0jxHrquAhcyfck11iukc3z51hF22mbY5e5p9rmjs/VhdKendibseyHPJSFZNW4o2oQ5QkCHswB/ma8KelJbHfX0Nyw6Id3yRZD/axXMgUAejA7lb2HHT7W7r/cZg21NE=
Received: from DM6PR08CA0065.namprd08.prod.outlook.com (2603:10b6:5:1e0::39)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:14:41 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::54) by DM6PR08CA0065.outlook.office365.com
 (2603:10b6:5:1e0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 02:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 02:14:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 21:14:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 21:14:39 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 21:14:37 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v2 1/3] drm/edid: extract section header processing into helper
Date: Wed, 20 May 2026 10:13:51 +0800
Message-ID: <20260520021432.1301326-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520021432.1301326-1-chen-yu.chen@amd.com>
References: <20260520021432.1301326-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 825ca1f1-cc0f-4da4-77e2-08deb6158ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: rVvVuhNiCeE99DhHB4yr9UYP3LdSVPyZtw3PerVEWpzk27NSE135LsHnErlnEKh50zd/kWr6HFq9VvEi1el13f3vFeQgC8b1IZbeAXSU1tHMEnSmtIsw0cQ4evP9vIcn12LMjxLvI1RIcLlfZhNojpVYxKX7qp1xBTNUYylBDtpy0te/LT5Hu1Zpkevd48BVhYU7rVQHxZDPQbaHkCqNctoxw/ukciB5L7MifDg81hxqZRGK1L6fJVoJCduLw+z9X0ZIhmUtgBjHBhtT4D+Tg5n3qCbVfSHlCpeHozqZxIJGPwXHQ7NVb7+tY499UlbCDa1SuPaqGS8ERG17meDYh31zjRfygdBjyfhbxWOga9+i50ImnPGfQZa7WcgKq7+SP11R7qfZ3etc0XqeV179gn6XsMdNwrrj2UHpOT4K+f9CX1Up/wkK24BwwcAv/4erTHYBxhvheUxb8N+EQhS6L4fk8reB/fh5g+nbQJQvYqPe5OEs/z1x444mFtr9b5XmqcQuCm4//7VkObsUOUHPJZkuIZ1/GzaROgp+o8dLn34LgZxICwsoW8S673GwbHTl9sFaA+/qzkkorRcz4Urucg27HIOK5SvH+xYmpIj2A5wWAcpkxfet4zpwPFIzdWlopMyPu5HIGkptVHkRaA6rsV0u2tzdnq+M1owOJpR7DDWZCvOapQd1fY4BWYJQXt2cIZEsQ+Y4D+uEIAZ4YfYqgVS/ltQRNNYZXtKgAAwQeRs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GrQVhFdG4cadW0yolplVTrNyjscB2IUjYeJkWUyulSulAOcpyleWabU8XMM1c7Ned8XJRjJjLHTJOaWWB+boorQRtK2gk1vZoyWIW/DPWaks/feacNiZk66ySccVzjUDAXLhqcuXa7wzl0CU26D+Zse646LvoOS8u+m+3UAEJHj6iSMg0slUkqnO3myjnSUlwbCYsSO2D38Km9C9CtUHxDKChW87AKof9Fw9UtpuHXSibIWvych3Rvbwrf7wE8B+jFB0bLlQfxXkb/NSaxgMmkPG4i25x3OA9rfQNFdA5ph5mgdLIZ9sBVTIRo7GyQr2aQc/0wGAjxwNZ3JURwMM68KZoXg2W2lcUdxaY4NMRkupIwlFRjkWdO7xp4ZG7ngA/WIJu5Hn/kSxSpoJCQhhl+jxSmnXBTpwtZpX1zf7vSxH/BBMoj2fjJGvwn+nYr1M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:14:40.7078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825ca1f1-cc0f-4da4-77e2-08deb6158ce9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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

Extract the DisplayID section header logging and non_desktop
detection from update_displayid_info() into a dedicated helper,
drm_displayid_process_section_header(). Remove the break so the
iterator walks through all data blocks, preparing for future
patches that will parse additional block types within the loop.

The helper is called only once for the base section via a
header_processed flag. Since version and primary_use are only
captured from the base section, and extension sections carry a
primary use of zero per spec, the non_desktop logic is unaffected.

No functional change.

Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 8031f021d4d0..04878478ab78 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6715,30 +6715,35 @@ static void drm_reset_display_info(struct drm_connector *connector)
 	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
 }
 
+static void drm_displayid_process_section_header(struct drm_connector *connector,
+				  const struct displayid_iter *iter)
+{
+	struct drm_display_info *info = &connector->display_info;
+
+	drm_dbg_kms(connector->dev,
+			"[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
+			connector->base.id, connector->name,
+			displayid_version(iter),
+			displayid_primary_use(iter));
+	if (displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
+		(displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
+			displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
+		info->non_desktop = true;
+}
+
 static void update_displayid_info(struct drm_connector *connector,
 				  const struct drm_edid *drm_edid)
 {
-	struct drm_display_info *info = &connector->display_info;
 	const struct displayid_block *block;
 	struct displayid_iter iter;
+	bool header_processed = false;
 
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
+		if (!header_processed) {
+			drm_displayid_process_section_header(connector, &iter);
+			header_processed = true;
+		}
 	}
 	displayid_iter_end(&iter);
 }
-- 
2.43.0

