Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CB1C624D2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8B810EB08;
	Mon, 31 Aug 2026 21:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bnX3wEim";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9EE10EA2E;
 Mon, 31 Aug 2026 21:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPtHes2GSTLVSIeABbxGg+AFqcC/dT7XZOp3VZ8AbnkDQiSbS2xRD+U3Hfpk5XGha/aHOAiIwYzfupsfoMzpJ94hQw52SZ4DL/Kl11U5W9QW09z+7OVGayCotKph+s7stjlS4UAIXy7baIN8GnY7iOg53glnBr/Y7POwqlSw53NDmXXIdjhQ+mxnWfLd7dzba7EFIX9Qhz8Z8ZWnZbiwDfp7awXT7cSN+IV2IBA5Of+iAcTOD6Af+DbfaDs98GYZlgEtXF1zuZ9pY0AKbjjX08pCP6/Ql1VR0KkpxOOhJXhBdY7GwiwHIB3XdtiVUnY0HHayyTQGiEul4xDfZyxjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShPkfy8D18BYtxc8bHL8/+MReIbeyoItIezO67knhPo=;
 b=LhARWRT6obqdaAocqSk+Hc3/6kh1USM0ie7Ux+sRZAKe79ZWurGhlppqWzkOQRqYOwdppEqvlCcXM3SgLBCvUhDGredr+6+fZuhxb5ZOgF/FqP62nnGnjLwkQw/9PTpDJ04jbomplQe5pr09XlKvLhZMsjCRRbhbHURswurZtx9/ceaYmo/DrogY1N14InLUpKXBwlV2wDwzFlPqtNTeFw8lYuzBNFzGTP9p/GZUfPpb8lPJ11wL2OrnKovDjRkARlYkYCw9UOhqMmimvP5hwdpsRgx3VsMHBQ/V7JeY2kc2ciJvwBuu6at0AlRpldaP9+1h9oCL6V+rXNZqLl1ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShPkfy8D18BYtxc8bHL8/+MReIbeyoItIezO67knhPo=;
 b=bnX3wEimUq2mFNgrnmvTm/MgbEWB7QJqIN9BVvKOBTLz50MW+6cyHSmXNoQ8GvWGzEvspD1u7Nx/6GLd6ITrHfp8r0ogYWiCxQOl1fExAuhG2w9vnzSKcHQW6rugGsHNoA06GKyt1EBTKKdQ8EFNM8QT48AE0bNGXGTmfvlU3sQ=
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:06:03 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::5b) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:06:03 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:06:01 -0500
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
Subject: [PATCH v7 08/12] drm/amd/display: use drm backlight
Date: Mon, 31 Aug 2026 16:05:27 -0500
Message-ID: <20260831210531.2334221-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc3044a-9c62-475e-9b1a-08df07a3aa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: QHDfoZsQsE7BEO4mX5RfnlXrWrmYMpORCqj+EEislumbyzONxNcb4+u6qdo+EwgEMHD3IiXjvLZyRehTKyobaSNMhWMJHNpL/bqt42k0j/JqVN/S620OXC0ScBNnUplkJwV4tP8X/ddk81OcQ8mmWmRhJs378BcyHmTEqvddCvKaBu/r860ACsg83RMcarFi0ysXFEK7SH5dZBU6H2RDxaRH/kgpT6RRsrMkjTPirN3NZKcvV7QXrWIg4GYdrAPAGfvtffql3k9bR+rysnkSxhSyFGjf9TUf3p5/3mKyAgbmgv6/D+4pDM1gd98vDrK95ToWL7PFZ+id3CdwnkQeaxJr/+fE6aR7RjWJ8SDrvNYMN9IGMOBLhyKNPrAEdljyM+I7lCF+Zmq4z5EvN8wml0gUd4o+4rVmHZ1GoXk+c4k30DEsyVRmVAJR3lBvRndoU3BSmIUH98C5lti+bJd+h+6y2E40eMY4O0rtgeo2jb5ncodV2bNhTA4AIr29dP8o0PvjcrX390VSrkunjNeyhicYkek6kACTBfAoUCK/mm4Uz8eGxi6QXf+jhExtu4s4+n303DUnRGrQIoNN7n6xOZoUZmYv38ZtynbJH8DuMZ1AfwgetP6zLCZaS0UdW6Ou9iDzWQMRmLckwMyQon2Bqe1cpxpW6KUL3LYyo8tfVNg0Y3JEptJ5G8sab2rvAfsbfcAlBFrhoAo/XZEN7qyM4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ik2LOHOpHgwy495fqMF0Vvtu+sUOcwY/Hx3mQSfQBwfcZJmH/PGXv8Cdxg1NBjwG/yRvSXD4CesgTOSo2Ae6Pc3FslhB3rNhvx0QH6r072bAwHWZYU2WYfOyYUhhSeJrwrGgF4PQzypFUGXtIJ6sv+HF2aKDdFK6GBr6fJYqaLtpInLJwbJv9k/n61CJg/CuJ0y/cuY0vUpHKFS9Tkxt1nX71ZZwjVpQ05yH6tuh1J9UxUB77Bp0HjdDbaC8N750+AO2tsKEc+2j6t5PVjz/X4GFwbUJqCRqqpxcWzMcjofwSqL8bivsDhu4C7u87tAlIFH454MGoWYnnNxZRhOsxenXcVAAq0U6Mk3msBf0besATIVtYO3qkyauSXorec90wqB3Mw6ky52I+ch1a5CdiYYkT2D+917HV4o+8svxDA6NA+QSXTIZShu1TwAh6vjQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:06:03.3068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc3044a-9c62-475e-9b1a-08df07a3aa9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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

Convert the AMD display driver to the DRM backlight infrastructure so
brightness can be controlled through the connector LUMINANCE property.
Link the registered backlight_device to the eDP connector and unlink it
on teardown; the DRM core owns the embedded backlight state and its
property, so no explicit allocation or failure handling is needed.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 5 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 4 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ec483276d7538..e87d1e5be58fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5054,6 +5054,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+		drm_connector_update_privacy_screen(new_con_state);
+		drm_atomic_helper_connector_apply_luminance(new_con_state);
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
@@ -5133,8 +5136,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 		kfree(dummy_updates);
-
-		drm_connector_update_privacy_screen(new_con_state);
 	}
 
 	/**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index fb2aaf0178c2b..a60d0b0480f57 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -40,6 +40,7 @@
 
 #include <linux/backlight.h>
 #include <linux/power_supply.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_utils.h>
 
@@ -496,6 +497,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 			dm->actual_brightness[aconnector->bl_idx] = real_brightness;
 			dm->brightness[aconnector->bl_idx] = real_brightness;
 		}
+		/* Link the registered backlight device to the DRM connector. */
+		drm_backlight_link(&aconnector->base, dm->backlight_dev[aconnector->bl_idx]);
+
 		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index c8a1ab8c3b169..fe4ab55f5130f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -58,6 +58,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
 #include <drm/drm_fixed.h>
@@ -1911,6 +1912,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 	}
 
 	if (aconnector->bl_idx != -1) {
+		drm_backlight_link(&aconnector->base, NULL);
 		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
 	}
-- 
2.43.0

