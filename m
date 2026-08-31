Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F0CC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58D510EB16;
	Mon, 31 Aug 2026 21:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LH5srN0B";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A8210EB09;
 Mon, 31 Aug 2026 21:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXrdOf+wbj8xzY/UF5aoOVbvkswZMLQofYOZ7s/Nde77jz3/pqX++ev4B55ALv0UA91I8foGU3zG/HsyxMH0IvU7F0sWIPskH89eNnAL+YJ8A+uYFzwRMJgyLmwzpx4skQwDYwJRilQz5/UkvyNh6z4F9aO8v0l3DMIfGUBM5XC/pv/FMR3pVJftEHzau3Z2BobV5i1fCeUioYODziMVX57KcAkM0I2RIpcNXOR48pbmsYM1+n8xLmdXSrZ+nqLg+n3mip3cx+ETlx1nAld+7bwAM4CILAdrBv6jrpNglIBDsl9o6L/0HvzePDPv/FH8YKrp3B9MQfycTq8lXryGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJRL45/d0hHGFJlb8X2s9ZLyAuaYIJLJSoBIPuhrn9Q=;
 b=FcTFjNDmXYHXkRc9vAGcDEZm+mZddU05GgZARLm3v7QTk7LhXqEJx1sI2hs+y8Z3Lc8pmTVpNOt2Tu+jGeSpsbjGGjiD6ge+YjjaNF2cKIGtZDRKRGJSxYFjHEB0ZVQ8UJBfGu/DNC6g6vo0xf+dwzyqytVgk4OqKoWbKLU18docqws89A9RTmlvqW4E6LTGAYb8+CpCIR7R/Zc/Fv7eeTcLXwjaBt8xrzUufMHIXsD73mokb6KDFhmmlQdkB4aTs31gP60ZNYywQe8PA+XmmkEoCMdmwG7HKcFCHVaKbgJCQqxraKzuiVwp4YKd7M54acfue8tgpgOFSSiCkCueEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJRL45/d0hHGFJlb8X2s9ZLyAuaYIJLJSoBIPuhrn9Q=;
 b=LH5srN0B0v99yMug/lOoZJurjb+wbba3wjpD3Ai/PAcpJKv1jLsax58Ozo9CQlegfa1vD/ooufA+l8m9A+GbmvIy4rlSEoGuXsYoiaKsMTrzoLwahMUTzuhWoILf507yi8pu2gxIKomjSI63QXI4cNW2z1pt8UEwcc+HQ5odLu8=
Received: from BN9P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::8)
 by EA3PR12MB828978.namprd12.prod.outlook.com (2603:10b6:303:308::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:05:56 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::49) by BN9P222CA0003.outlook.office365.com
 (2603:10b6:408:10c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:05:54 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:05:52 -0500
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
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v7 03/12] drm/property: add a per-connector luminance flag
Date: Mon, 31 Aug 2026 16:05:22 -0500
Message-ID: <20260831210531.2334221-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|EA3PR12MB828978:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bee657b-5a37-4cde-a40e-08df07a3a576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: wpl5A+fNLCiGeye3vMqqgY7BBv4xkJH+ukDRf1z46JGIufEaxvXudYKgkQKwo+HC8lYkUpuLJAlBM8H076sAOqKovrcUFEhOcl9HHIZTUGEl8HV6VltnmoZEwGHUrBwTIc1SGQA5ZRdmtj9UdKHigmqZerh2YJYzs/qfqQIBRGt7myZDYbSYkDFjk2e4j/4/1EpM7qbD2a5ZJFxveWgI+klFwtkOgph0e3wqfoPD9ra2qQTMbWPtIsMVGysuai9wCylmPTk/WPKdJHAdNgutDyIitGRQyzyR3SJSA9m/lSIMTAFDLrhwd/PcYGWOvdz+IlbBY0uTDXRA7wa+tZiHCPl6qk7zNzSIhmfDvzWERvy0yqYPjuV4nO1i4Mj2tDkw+gyA/dBFBEC/VwHWba3PVSKHk8qIrmmIG7ymJkDZrNr2r6VU90ozXiFS4+slJSshbRCVSErkIrF79wodseX7eTUHY9dNtuEJoIkDgkASpDfs2fGZMYmpEjiroXL1Y2MxMEULprZfCb4Q3W/1JpK+Ld27RfU/QsJR4vFcVwNSxe4KDNVI7PIv/AwrDYhLKT7/1eWE4+fVdET/CEOoFFWUa31Mguo16UgF65xaFpCyVLeRmhmp5reMMGIpFcKwVqIy5VsJXe1G7VzVqzRlMjZv7poMC6opqR1MmudEyb/0CQc6Cae9+mfnnWLu/42XC8JbELYuS07RNt2JyWY+fQEVtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b4zSLS1AWlV3IqcsNuABsNqIin5VN3C+MDaibgkGJ2E1tYLLArAg4cMVVLhYNGYb3RFsIW0EOD1zaRjt7ioAVgUy6itdrfqUSupmbnQMZiQ1PKAV6lQWoUFz7coxBC9tu9RocJ4+B8X9W1ozsPO6R6/yGY7MlgwWqUTx05ryBR12+1al4L+VPQKaLkU3g80rWI3ZvTniotKffqyPPFmzLCMIDf4t141eJH5/6OSfAAxALimmRbm9ff3xWhL9LUIrRJAUFOwXb43BWznY51/U3uJuicWYr6MIZCE11ZfwjEgECuzrMIskC/U/DDILgWzdpY/Zf+SKE/oecSILGbGPf9d4IAdZ7dtdFFKVftZNdNawHRbdB3KTEOvpB73PCwrpnNidhf/4ro9yoFRrktf+ZaZNAuyYbx6rSwKGxQFoQ+wQxosrN1fOgOmI+eTx3avY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:05:54.6560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bee657b-5a37-4cde-a40e-08df07a3a576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB828978
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

The upcoming per-connector LUMINANCE range property needs to accept the
value 0 (to turn the display off on DPMS-off) even when its advertised
minimum is 1. The existing check special-cased a single device-wide
property object, which does not work once every connector owns its own
LUMINANCE property.

Add a kernel-internal is_luminance flag on struct drm_property and key
the value-0 exception off it instead of a pointer comparison. The flag
is not exposed to userspace.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/drm_property.c |  6 ++++++
 include/drm/drm_property.h     | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index f38f2c5437e68..adccee10cfde4 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -952,6 +952,12 @@ bool drm_property_change_valid_get(struct drm_property *property,
 	*ref = NULL;
 
 	if (drm_property_type_is(property, DRM_MODE_PROP_RANGE)) {
+		/*
+		 * Special case for the luminance property: allow 0 to turn the
+		 * display off even when the normal range starts at 1.
+		 */
+		if (property->is_luminance && value == 0 && property->values[1] > 0)
+			return true;
 		if (value < property->values[0] || value > property->values[1])
 			return false;
 		return true;
diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index aa49b5a42bb56..8bb568a4cd485 100644
--- a/include/drm/drm_property.h
+++ b/include/drm/drm_property.h
@@ -188,6 +188,16 @@ struct drm_property {
 	 */
 	struct drm_device *dev;
 
+	/**
+	 * @is_luminance:
+	 *
+	 * True for the per-connector LUMINANCE range property. Such a property
+	 * additionally accepts the value 0 (to turn the display off) even when
+	 * its minimum is 1. This is a kernel-internal flag and is not exposed
+	 * to userspace.
+	 */
+	bool is_luminance;
+
 	/**
 	 * @enum_list:
 	 *
-- 
2.43.0

