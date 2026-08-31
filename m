Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD420C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8801310EB05;
	Mon, 31 Aug 2026 21:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YxjXhEtZ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01FF10EB18;
 Mon, 31 Aug 2026 21:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0yp0WkXSUBB6vXqIzYw8mbUJilW2PcUVPToFR4SCjQLy62DPmHIsxHluPCG7BaFw5mAgbqZ1VXhkwqhcgZbWd3t4X4cHwJXNQ/AeFQilE9U9+N21oQAhnxmqTyXlHq5VIzHpmZQ6ThZgNe7yUJsGNzWN/++mgZHvjzTL+wd6dz/iDTN4lOkB9JOtblU/iQD3qvtWeVwycO1o2WmXnb7EU5mfcgEopPLUjLQ8esMDhwikg1GzT3c/rKju97aRY1C+pePiDgugLo497dEVMuM7Tk+h3xrVceH2I1b9bgojOXBB65GoAka6dFFpUvrea2xgSbRtH7iejn7CFobS7Mndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu/nXTo9q2QZ2ODp8UmF4AiFqfUF/BM329OmpAdnr/E=;
 b=MAuoRzEgFi/za5nM9mROjIsWlEHLa6nfLWVhwF16IxGSbflZfuwDQlg5ayOeja1g9qFYFpXhUCiM08XQxh484GsF+a5SELHibTAb27zQHDYZRzVGlBVs47Zj97TPnU4cohVVomfAQ91cU9xvZNRZxUxuG9q37Lq1ZMQsLxPfEASfaXdKJm4UuFwLHKTg59BmPCMhXCq8ZmlHwiKoKlmQ8jmnOzzxuUKoKQ4QGHg2Sfm/uhw1lGYtl8uMYunB7yoTHhR7q7eXEbc8O4+19jSXQD/Hj/1eIJ23J91EpUkEWT8MZZEFXSJhfKmnqUvuvr+Qomvr03qWIvUGh+Y+qFFydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu/nXTo9q2QZ2ODp8UmF4AiFqfUF/BM329OmpAdnr/E=;
 b=YxjXhEtZF9s5NUrLklc6ARzmxudLTussqnu8L2ZsplYwZLTP4cGjfXTXP4318UTvaCfRX769zn3iVYLqwmhLJGHLLL7x7wfRPjRSQUzQW/6KDOZSW1dkcwx+2XITc3JN3sO+ERnjfiF3PNhky0mwlRGBa6CuTi9lKFQdx1ND+fM=
Received: from BN9PR03CA0207.namprd03.prod.outlook.com (2603:10b6:408:f9::32)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.8; Mon, 31 Aug 2026 21:06:07 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::93) by BN9PR03CA0207.outlook.office365.com
 (2603:10b6:408:f9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:06:06 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:06:04 -0500
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
Subject: [PATCH v7 10/12] drm/xe: Indicate support for luminance on the
 connector
Date: Mon, 31 Aug 2026 16:05:29 -0500
Message-ID: <20260831210531.2334221-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831210531.2334221-1-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: e9794bcf-6fda-4d7a-7e4a-08df07a3ac73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: je4uOztt5HvIuujSBN8spELadH3mImPfd7kXH2K+XMZNCdMZUi2h/eVTbMrj6D7d6K4GpgEjixxqBKkxAUN3EH4hAj6m8IjDO5wa+ked69awJwTndBq3xEPUYw3a+w8LsItqJzin/fNB92acVm3lHGs1KHS3hLFI/vcU4rC9RnnidjBu3xLnO73tr35Bp6iVP9xistkwASkFhO8LRdNb4RRu+TdGgBlOQY4GJMFa5C19UZ0T7WL4vkdAh0RVFiKZBe+FoyBqP+8TdMf2eygjBn7tjrb5W7H2Wgx5NNgjTlFQxESnLX3Bu4cwmktB+ZqewzEgNzcban2pxiVJj5vaSlf6Z5vakPY/xx/u4ppv18pXRUd5rDTu1QsW/XD4aXdVwA0HSpjmdbCJTETHzhOOoBij9dTMm5FkizTFvWZ3mnGzL2rMIdXbkeyryMbOW3/CMBilkTuGM4Kpb102XQdZlKfuR8LUsmH1l5l/zvlGP7mMVvOXGOy/PKStCBLV6SxvJLAtMGmWim+bk6VRcZfx6cpbQUd3lKBRKYOPFyJMJxBpqZ0+KSK5D1JNItmd7AgPItNO1ANNcIXnRs0yNW/ELLx+SHsX8nhz20WAHG5VXK//dg3vFXeJ6uilRkmpPEf576TRhtHAmfeq+ea40KDFEE0rU6+8qDCwBB4blS0Vh7nxSYoTzkw4WiAdmoq5h7yBa79fbYb5mJcXUe6cz5IucA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wVuOx0uaAwDaAwh6RalWvImX1HwiLFvLKkPdjVjdw5Sh48xOKxrWmOHc6rzv3iD2v74kZCQOr3Jmc8DbXkyFJPjRKjO8YH+F4Yam4i8kJyBobYTtZLLiuUi10+p1R/gbzW0DidGDpj366yg1fs4h30ehCl8Oad62yUeJktVhQmRNmT4xW9JHqm8g2f12vfQ3fXTCZdq6cDxfsXaUrYI2eijL8jTibl4X0OLOjrCsRXFTgM3mmcfLOXeF2J6o0zgzGrZGGkE66kxu49yhyW2bTQbIErVaxEg+g+mSrDHGHD9L5+Hzy/I2rF3bD0ySKDknFic54cTcglo3qs2ddg7fAmA+IyRtTmZUo3//e3w/q8eONfFL8hCMy74KQFKD2SFUk6hW7AQQ3sHd+t18qV3GpB/hF5fs12fw1l1pbJmAWbkEHmVUIQE74wzdpfLbj6zi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:06:06.1430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9794bcf-6fda-4d7a-7e4a-08df07a3ac73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
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
 drivers/gpu/drm/xe/xe_device.c | 3 ++-
 include/drm/drm_drv.h          | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index ee732e5495f7d..661f76fac3f35 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -397,7 +397,8 @@ static const struct drm_driver regular_driver = {
 	    XE_DISPLAY_DRIVER_FEATURES |
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_SYNCOBJ |
-	    DRIVER_SYNCOBJ_TIMELINE,
+	    DRIVER_CONNECTOR_LUMINANCE |
+	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_GEM_GPUVA,
 	.open = xe_file_open,
 	.postclose = xe_file_close,
 
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 449160b9863f6..bda0f0bd7b16b 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -125,6 +125,13 @@ enum drm_driver_feature {
 	 */
 	DRIVER_CONNECTOR_LUMINANCE           = BIT(10),
 
+	/**
+	 * @DRIVER_GEM_GPUVA:
+	 *
+	 * Driver supports GEM GPU virtual addressing.
+	 */
+	DRIVER_GEM_GPUVA               = BIT(11),
+
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
 	/**
-- 
2.43.0

