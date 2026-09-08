Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA5AC79FAF
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E75F10E9BF;
	Tue,  8 Sep 2026 04:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hWwCjjaX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADBD10E9B2;
 Tue,  8 Sep 2026 04:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gtxt+xuafNZj2lgNhUdCoV/kp5ItLFt3lKM1jORdhrg7Cl//FxZfiqQKKwmJd3QxWQkT/MsgdaNyfLeMROzLI3xXFn+OYeMQ3EdWJ8JCvoBNSJHgnfAXDacHYgzeHI7jQL6da9XndWMaXE0eteoklKNdjXidFYPgWJwPWVJ77YEljOSjcIfEeeO3DKGmP7OdgfMJwEjBgQeQiocsbJCLOkVHla4QblJ8WDUWasvS3ZqJFKNPErGBrXdt3FzZ6pMPXW4Kq7acXlT+xIzEdbO4l8xVk/adpPPk737ZbpdL1GukcLyKDgtYUCJNhjMoCB48Qw5OlQugfo9+w83U7Q3pUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=882XYLXHDwAMKJe8Eq/FsUbZp7ztTQuf9+IVl6kWRNA=;
 b=xc1oHMiqjq9hIRFw5RMk4lzhEorErPjm4iXnWGvH556ZQlCrc6wmsK5C/kvEam2fB4Uwy/Gjb1HvGlUcszGxmG6YlfcDWg5psxCGnSuaL5yKXls2IgLvaNAmiSSX2iYWTCuClSv6NHrGNXomI4JOTl2IIg5zo9EAfiunAqE8hxdvMDcb58OooaHm5Bv8d3m2WfMYSJABBfbty5xBrLCJeLYHSxZbCTY9lIkwDxihwAz0x5SwCIFONyVDi0/dyfdB9A23PHol6UYZXpjPaf1Q0MZTiu6uxRC8SbCXS+XCjQ8pc+6aSL1iepFJvn5MBlaZBOoN8+3rm9Cl2QCILiRfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=882XYLXHDwAMKJe8Eq/FsUbZp7ztTQuf9+IVl6kWRNA=;
 b=hWwCjjaX1nqjh4yDGjCa1LnUqLUJkleWW5fnPxn5ie7QVDimXMzG6rhahU4XPLWQFstBQshDziUeatbItqlw8gzGzfUTdvOVLauj/T8wVt6rQr6zGNIJAvKzEqowEwZFhJe5t0HIKokH/AbSgSFTohKgk/CkP0YT9gHK9D3iaVA=
Received: from CYXPR03CA0039.namprd03.prod.outlook.com (2603:10b6:930:d2::24)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:41:09 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::93) by CYXPR03CA0039.outlook.office365.com
 (2603:10b6:930:d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:09 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:08 -0500
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
Subject: [PATCH v8 12/14] drm/xe: Indicate support for luminance on the
 connector
Date: Mon, 7 Sep 2026 23:40:33 -0500
Message-ID: <20260908044035.62093-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b2395a-4d35-4c8b-8ac7-08df0d636731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gX3waTdkfJeUSeax4zltK7L3X+8GJI/tH+HNmIlJBKvg3IM0VV1bXwPG97zDf0cZ7IUdaq0OoyRjPSiFt2PdrtWZBHIKJ+nyY5b7OmSQqbBAN85Dw1o6+o7kWcHdtZlo1hdosxbA+UzKWJrmDzjpXj1S9XyvzcPmmcby1m+d4fqENXHiYHdVOLbQfY6NflsWFnc0pVwuG/ecUtPT40cN/+pjOQ9k0BsKVX+K9B32gIlhV6aKw4wZO6zl2beQKONO2SzWfPjohEFeuv10woCu23L64IQn0psfiSwZ8nUAkpb+PQSRkpQ87pqfNvOm3PI2fs/iy6+wmQJlkjlzv6+egHRggBHb1TCFdFYsYk0fn+eTT2TGoh/TM9652yO2FyRHtl8jg2kQovfuNLYeKqUcoTsoe307cZKeb7LdKCDcdE0rNC85UvuLAoPl1G7BtbZwcsTWH700teLGZy99CU0wXdO2QSVxY/LiReoTfg2GTFifwonXyFnn+G5mQXH7U9IHTf6NsKcrJ7a2FczDOs83Xh2UotnofOM+o34B81JMJ6Z2C6HV0iwX9/zTdXtjGHRgGAE8VkriLp6Txn6NGBJza30z5PSidYcfV1c9NqsG3ZqvZ71thDX6PB50DxvpgFjRjeemhdbJcXTU6GIdPKEGWUrhsShLxSLBDUeeyWrsIqjwgXzb3+waeiaPcYhCEJA3kPv0Yi5iKiBTpuznWTlfMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gJQmQsgQQdgGwn1cupF95TCWh9Rkua9BPqfKYQv8wopMRqYDCxyL7eK7p6yorHc2zrQ+suwZ6+1QF5HNWlNbuDDBAYh2c7jrVrJgOEhoxFzPLSKJ5q93hYMgkxPsrRUb4fIqLpD6NzLPokj4h51gTJJlUkOcd8tsUIOfd+eJzdqbUbDU0Jav+kY2Ya88tnqBb7NV44b7171vriB6uaIetGLStbBDZRqQGeRTheXUBEEyVGMiGI/Hlf7uEm6naZkSOwZ1oHPiPP2Elohr9ECfqb2NPMu9kDsM5g7hHQuO9IzPS3Xv+W9bUq/L3W7TpjnOa/WDcZQTEkcHC7yoA1n6qtNCdpNu2MDGhDCwcCFK+QlEGu+FRo9lW3MxUY78iypSSVN0uwHFlvlFzz6F5IObCQZXWeCkNDw+XFGF1FQEvk6aQOXvMoLKPJMUEeF1Yhh7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:09.3505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b2395a-4d35-4c8b-8ac7-08df0d636731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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
 drivers/gpu/drm/xe/xe_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index ee732e5495f7d..b74afe1594842 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -397,6 +397,7 @@ static const struct drm_driver regular_driver = {
 	    XE_DISPLAY_DRIVER_FEATURES |
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_SYNCOBJ |
+	    DRIVER_CONNECTOR_LUMINANCE |
 	    DRIVER_SYNCOBJ_TIMELINE,
 	.open = xe_file_open,
 	.postclose = xe_file_close,
-- 
2.43.0

