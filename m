Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FB9CD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 03:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0CB10E438;
	Tue, 26 May 2026 03:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HqehCd99";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C7B10E438;
 Tue, 26 May 2026 03:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzEBGbs1nMjCRb/HBQHV2kAd+pSfPtiwrb1qDTyNkSwBVqy8i/5EThFDwlMmrFVJrPOP1ejsJvOn4Wc4hHT/CcTyZbEDF2fxPQTJU3F/wKEN2QNlsiM3odjfICwJUOu7E8NnasPpht53lR0WfyZGOaayIOzIdhW6HMr2LGLVfu2OTMLBJTNo8h4lA6MvYpHZS6C5M0txyagYKsWrfqVu6p2muYDFG1cuIDyrs2DD02DJA9Nip34c1RY3a944CcGTyRUHz94/WFrlHHHUD66AG4mag0yz3OjLvw7vKZqahc76NhCmEVkVuZC2MEg9M78hfAOLq2is7F8kEEpEtlnNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfNotxkch8z+pi/9ncL6DdOFC9CNfRT4rornJjb7IxM=;
 b=gjVKSZt7oWG5K8j9qhxrIQmWw2d8CD4oZUPj7gsPm7RS32zIsWyXMwsi9gy/lJ1iFiUV1KSL6FgDoLDikX9diAdant3/S8u44SkbZKo3PdT63sHpDT10tr7ht3JP6qJJckMbbKw8Hwk7HhZGRV7f6FI7rKYxZw6VbIv1pIbP9awJpi2wteQnBTnn5kRod0VLpAWOvR7bxFBKX12DFU8jHD7xvtcmL2LOMpnj2X9WEd2piD/EkXfa0H4ok0I8q0J5txnRj3O2OGBh4/rRFAMtDDW81BkX/X8bwv87QYDYGrTfOjiryFUHBdUjyt/rWD9Q7ETM+9o0IV5NaxhDLPRlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfNotxkch8z+pi/9ncL6DdOFC9CNfRT4rornJjb7IxM=;
 b=HqehCd99xT58L+uz5plnO+5SXy7UXl1UQhVPf1DSd9Ek/pg9uCuZZIR3uEVywKAvqnYxlrcuYr8giPup1Xfczrp9eCWKpWcQ/nNY4RkMtyQObXg8BIi9TqfOP38HBPy4mcXQxbOOt2rNLg+lNluUGwYrquCitMm4buUsyx0Hw9Q=
Received: from BL1PR13CA0309.namprd13.prod.outlook.com (2603:10b6:208:2c1::14)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 03:03:07 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::4e) by BL1PR13CA0309.outlook.office365.com
 (2603:10b6:208:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 03:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 03:03:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 25 May
 2026 22:03:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 May
 2026 22:03:06 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 22:03:04 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH v3 0/3] drm: detect panel type from DisplayID 2.x
Date: Tue, 26 May 2026 10:59:48 +0800
Message-ID: <20260526030254.1460480-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d1abb4-bf3b-4c4c-97c7-08debad34f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|30052699003|36860700016|56012099003|5023799004|11063799006|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: AVEl1BIrWMR8qUmjH+/jeUw/eE3mzbP5VvKgoQg6h/oQZl1zykqmny3gGMVi0Kf6vC4wqQeGPUsVs6N4vPDW/+Z/R4TR0HzoY90nB2NUj/iDb9GOcMrkVdewg1dsMPLp9pguqVL78mqWlKwvZ7r6qOoJgzycwt38d5A2/nPRW/Z7v2T7Gxbt//K9m44fGP40QTrXqaCEoqGOvm3XH0eTZSzNYBUnhhkXD8mTvSNcSfoFWMS/yrY/JqL5kyP/Q9OaWQf1CiJWP67euoK8yLbKoJocHaNlh+gVTX7hApMcXYoP9sICAn9O1VFQpsvGtNBFG0fANvk1NlIz8hhmAyTQdr9wyCjGI56sJY1PWyTTUnXIGvS6njDv+nh1VszsRTtr3ScpaM0d+msaxhwoTKAnsgGuYO4aGkTAF+KT52n+Xeu4Py1v5FgqeWPTSY9okhj/1K0gwOjjh/wbbtAfTDw3swvPBJaW/lAGn36adjyLESl/EPcKtNyYeGl6T0kZC99psuC89zya7c6efk8uvqNbOjNq+MPfMaqewvGxeV2zo8ZDor9qnm5iJwMoHZ/1W7pn5WG4ZqqVdBQkDBU7TgIMS37lunuYkEYq04rgiNk6oPb/lVPo8lSYEfJN+9MDlrz3bKwEo6y4QyZelzpOPuSd3MtwKrikYoUmroYaW6IzlpXh028YAIntr8yjAWrP/jWHcOc3koctpJPRz52+VVldsuziSQqVhrvOPOGQ6csp35E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(30052699003)(36860700016)(56012099003)(5023799004)(11063799006)(3023799007)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tPU37nozBSLnp/2fa2eWZ1h+wpVYZnbyHVsaDf5I9VFUmD7nTlSTeJ666pVauw+mflXyakl8hWBf5HMZ3agT+vwtdzoe70XvCRaXKUeB32hba0WBTCWi/IuTrj08xFQiVn/23aMgtyitxDGu5gQzDmSjBVrWTFLwTsJwr4+Hmtaal/vqWSBak/4itJaCOsHuclRb2/Hv+2FW0RmvakmNK/r3CbSBQbiQRfckniZYATKrtOPBYGKlRv0ltCAajzGd+MFakCn2exqJWNgbQ1Je5uGwjB5L3qoABUQF/XrAMRtdgXxtHUSVbXKfuHcAsvDCW5yX2PO5qVwnzpoUzf3vyGQ4BnCgO82NZAXG/83dunmvH1+YqcDqJhp6zVqSo0AxuNKRHLED0NkCNSxomqDvDoG2JXq+ppw+OUJ4IXlbH7kFNirexoDH5FcZvPLaDwK8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 03:03:06.8580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d1abb4-bf3b-4c4c-97c7-08debad34f90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
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

This series adds parsing of the Display Device Technology field from
the DisplayID v2.x Display Parameters Data Block (tag 0x21), enabling
panel type detection (LCD/OLED) through a standards-based source.

Previously, amdgpu_dm determined panel type only from AMD VSDB, DPCD
sink extended caps, and a Samsung luminance heuristic. A TODO comment
in dm_set_panel_type() acknowledged the need to also use DisplayID as
a source. This series resolves that by parsing the Display Parameters
block in DRM core and wiring it into amdgpu_dm's detection priority
chain as: VSDB > DPCD > DisplayID > Samsung heuristic.

Patch 1 extracts the base section header processing into a helper and
removes the break so the iterator can walk through all data blocks.
The helper is invoked only once via a base_section_header_processed
flag because displayid_version() and displayid_primary_use() always
return values captured from the base section — they are fixed
regardless of which extension section the iterator is currently in,
so processing the header more than once would be redundant.

Changes in v3:
- Renamed helper to drm_displayid_process_base_section_header() to
  reflect it handles the base section (Jani)
- Fixed argument alignment to match opening parenthesis (Jani)
- Renamed header_processed to base_section_header_processed (Jani)
- Fully expanded displayid_display_params_block struct with all named
  fields per spec Table 4-7, replacing u8 payload[27] (Jani)
- Added DISPLAYID_DEVICE_TECH_{UNSPECIFIED,LCD,OLED} named defines (Jani)
- Removed DISPLAYID_DISPLAY_PARAMS_MIN_LEN macro, use inline sizeof (Jani)
- Removed superfluous blank line and useless inline comments (Jani)
- Debug print now shows "LCD"/"OLED" string instead of number (Jani)
- Renamed did_panel_type to panel_type (Jani)
- Added LCD to drm_panel_type_enum_list[] and property documentation (Jani)
- Added PANEL_TYPE_LCD branch in dm_set_panel_type() property setting

Chenyu Chen (3):
  drm/edid: extract base section header processing into helper
  drm/edid: parse panel type from DisplayID 2.x Display Parameters
  drm/amd/display: use DisplayID panel type in dm_set_panel_type

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 16 ++--
 drivers/gpu/drm/drm_connector.c               |  3 +-
 drivers/gpu/drm/drm_displayid_internal.h      | 24 ++++++
 drivers/gpu/drm/drm_edid.c                    | 80 +++++++++++++++----
 include/drm/drm_connector.h                   |  6 ++
 include/uapi/drm/drm_mode.h                   |  1 +
 6 files changed, 109 insertions(+), 21 deletions(-)

-- 
2.43.0

