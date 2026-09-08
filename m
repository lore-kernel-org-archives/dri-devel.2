Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5043BC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F6D10E98E;
	Tue,  8 Sep 2026 04:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q1l/48rW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD7B10E9A7;
 Tue,  8 Sep 2026 04:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovFJHABeIOIuYGTK7Z6D8dGnGYLCqDR7BrNFXAPFngYQcySPwiwfiRlAuGWiDuXfOLKP+AfT6gLP1bHDgaklOe+ZW1rzZkyRsK4TwlgI5kjG/VQr7eLVvK9V55YEbrEAKMmB4gutD/M2JpoTrsLK4xi71IrkZw4iGmhYDRFG2yywQxD9g2z0MgxI5YAk/P3Mu27wsncIB1hxXezuxpDaYh7UmWLzPhC7VhsfVp6TojBd3RVRCxX2y/1T3Oyk9trAkY7UHhEH7SFBD/MgojZyxLA//zeED4tIX+rgDeOhkChNTgDftXKQMtX6AocP+7S0+xux98DojkQm0eaCITnOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRZeFnQoo4lxD2I6BaCQ0/YiZ49qpRC+A6495fta1fE=;
 b=y+4R8LFi5TA5wNRVzbLn2qn3fifhmcNmFRnPDIv8IiRzkYcuzkrs4CW656Mmx4s8cU+KA2eNKGNS/9ukjAFmhLoGc+7EccxGXzRqmN5vFvvpM+4iBTr8Im+XalVsdRd1RCq0w9YT/BLyXEIHm0tK0Szdww0fcHFabtBVb34txiWO7Y76eV0HSHYOso701y0xW2g2CHCmRCaKOmoaWe4f2QY2rAz6zIomsUnniX8CLT6rBmzjpn0WZE8UBnFaRMnQDFRTL2gPUDW2dBmMV+Jo0uIxiA48UGsA50S2OsiaeX4xETf8qW6b8J95r8B2so/6jlvJoXQZQW4ysOr8ha1yvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRZeFnQoo4lxD2I6BaCQ0/YiZ49qpRC+A6495fta1fE=;
 b=q1l/48rWmqvIYmqcxUWHO9TBWr10GlKOoBEWCnZeJSTA+qrVRhK3p0UanY4cG+55b2yrvN8mFfE3E6NElq1oCMGISbAygrCb5GsFYikKRmCY2htthICceqCmKRdA1WPsHCiyQZLXzRu8U/RKCAkcn6La+K2qmJBgcyYr9vOYA9U=
Received: from CYXPR03CA0048.namprd03.prod.outlook.com (2603:10b6:930:d2::6)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:41:10 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::ab) by CYXPR03CA0048.outlook.office365.com
 (2603:10b6:930:d2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:10 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v8 13/14] drm/i915: Indicate support for luminance on the
 connector
Date: Mon, 7 Sep 2026 23:40:34 -0500
Message-ID: <20260908044035.62093-14-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908044035.62093-1-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: f04c5aaa-685a-420f-e9ac-08df0d6367e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Jql/LnrNd13ESatO1EMnxZAGaJDPEaLgt6Ve8UTi3vrDmtgxWH9AyrPAMgYkeNF33EdbA74HgUWlZZPT4mHyrqobVhHjM5y2jpFwF6haLshIm/r6zggAK1g2tx14crmhOZ8owh07GW74Yz75NWGovugAgYMKzVClTvDfulmj9wTovIHQ2ZfpqnNp2LWPibJGV1yZ379TvHpWRJL+93Ow4DP7YCFMI6dPgw9UB8BYUEA203M2bsovC7o4C7qT1Ml0IwtZjjQvoE8HLTOryvoq+SBhyDUyGhj10ywZXdgvJ80L86pc0Z/Aoi57a47y4CcXuXCOZRMgcp8lZfmWY0O0UeoYBWSQ1RjhcFayZCqJz6BkKqeChGWd5TLzqZrKOYQRfLukBVr+GGBUaTIlLPSrWmw0ICVOeqiDQZ5P+u1GSAYY+aQ95WXHo2EWtPYZXS85b7oa3Jp8D5BZ3oiV9QDpBhIKqqMzmjs6gZKzGhunDiAcJYexCm6m9JLOqaRDpng8wxVQq0tC5+EbRNoJZQXTH6xjb90yCrdiQgn4j/DiDBDcHZAK3YU8z8Apkqi44tuD2myvDgQiUIEWE+D7idVXyHdv6tf0aUvdQ72sMEGXnpjofoY5p/RrnSKUJXL0DBLXdF3s2uqlHSrb5EgfIm/B/kZa5wZZHDTzII7QUkbX0wlaJL9oZTM3PFSPE8IX2qFdpqgQrR+Fx9bFvF4jP5upxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z4NcRQ5W6cqY2nMi/DHjqyWlW/9dwckO7svTbgAQsjM3//VMTd09m6Aq6J8NfTUm7kjHtscl9/QT87lnLyaS93A+W+NSFg8DKjY9JVG/gX702sZ7ZLYbDEIZZjeGiFe/Bkjn/BDvwgihB9zpCKT4biK6A+kaZ/u8smCr2733EIfctii2tikA0W/EXzOjT3lSdgKcdg6mRwIV3MzuKCsv/47BTPVFpnFSIpd4XGJPeAY3MGAeWwBCSewA2dJ17mf3vK0xdxaPigGYnYqwqz3tfBD/PNtSKazWEiiWN9b7bJIF9K7TgxAGOR01FoFQuc5TeKghH9CZssFt2axYIfyvJ16nbna+Id5nt+P05V9R87O4Wy3uybIMi9ZEl0QOUYcwVvzRvEJPbaTRyNZ3R+cLfVIXhSewYdCXRaraRKQIhPOjis4nt3HPY25vWKULf/s5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:10.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04c5aaa-685a-420f-e9ac-08df0d6367e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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

This will allow the connector to show luminance information for
eDP panels.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index ce6d20958320c..83cff711d28df 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1768,6 +1768,7 @@ static const struct drm_driver i915_drm_driver = {
 	.driver_features =
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ |
+	    DRIVER_CONNECTOR_LUMINANCE |
 	    DRIVER_SYNCOBJ_TIMELINE,
 	.release = i915_driver_release,
 	.open = i915_driver_open,
-- 
2.43.0

