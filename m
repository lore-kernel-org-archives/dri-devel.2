Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C99C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66F410EB15;
	Mon, 31 Aug 2026 21:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hxcZOYqv";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E76210EB0C;
 Mon, 31 Aug 2026 21:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8BsT7OkJmBtB0rQxG7yEMO/wFPBBO1jOA9ZP43yWf8kqT/vu3pUGJXtfBBt94sK0rwg0s2mQDb54KTd8GmBOXKgatLRmvOUd0E+fhWnQlX26yjXcXh4BbxpO22bMuqs1olIA2Vk+h4rqCyQ+Av+TVynyy6hdcfcFOe0z3Zl2pRAHkF4w2vRseSuPU/NLmE/JRxIMrAX5aHMeKE0Xcl3dbJtEWjt+WEgdtA3oasotCGezsm/6BJ36hjwm1q8b9l3lLGOXVfibRG7tQkn2s/cIKQS7MEP+tU2FDy8KyM28hKFyuTQnp4VHKTj+Y/3XciNCTyL8Jk/FM/d5tpJdWpGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehF+3NOLyvf2MFxtt3ILCLDur/KNs7QpxQRMv+Zs90U=;
 b=AHMRfrBfwiqdeC46718QsHH7TKuOtYLIp+7I4kdoQSNFT5kJ7crTGjfPPotGFOpw1e2bqC6Oug0kGaRvCy2TiJsox1extgS1PKDnF3XhGkldiG4bSjTw8cNiY4UUSMIu9lwitt/XE6v8xbpqgh3H6l+0bbXdzp7wlqENgFFjIRb4mzsqFDSIW+5cSQU6yu9nZLWCUMvk2l/K2SK7T6BmxLH1YnHCYgJZMYZxVt/8B3NjzxI40NGczkj5MyPY5oxXDfYyhdwnXO+VAnZiZs3sL8gyz5wF555+r8HOvVtNwgRTp8jbHasTOHMQGGq3nai8BL5kQQ4HVUylJluieUQNkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehF+3NOLyvf2MFxtt3ILCLDur/KNs7QpxQRMv+Zs90U=;
 b=hxcZOYqvbBD8CtTBou7d12GjJCGY+V2I1X8PXp3JkhamCZOIJNWut9waprSNmmK7qFAUtcAf+nIfiJj3EKeXpdn1ob50/1pBVtusxv6FhPhhwU2XxNx6FwzPhY1T/uUQOfPbbqyrWGCy1cB50e+wgXypkJ2ElCr0GKT1kTp3lLI=
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:05:53 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::9) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:05:49 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:05:47 -0500
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
Subject: [PATCH v7 00/12] Add support for a DRM backlight capability
Date: Mon, 31 Aug 2026 16:05:19 -0500
Message-ID: <20260831210531.2334221-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: edfce8c0-7f3c-4d16-a655-08df07a3a253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|5023799004|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: euIoSwTrBaf4qLNpjsQjV1Z9VAGYeBFI6h5FomF73NZipZlpD45bdkYYvFdp4anRNtjikXUnwpY68YdpCDQT9ofE+EQHYXz24AxS+RZ1DsiiJXamKA01pS+UpvTVWSEPRH8akhF+sWly16WvaQlxnhGhBhcYbfQcda+lfXQP/IYU76p5dr8faMe4K0Dgxjb4PDTG4JLOPcBx8xukBvHQU/ncEZH1IP3PuRa6ZgajsU9oLWLsOs3nGcenWymiCCzo80UdUCM+3BL07N5q9lzsTK2LLmQo1bp3juHw36XR/S53n71Kn+2E+1F5MrTOakU6R2JFyZJGCksWrerN+Bpx9/LxEDERG9obBDvZoSSOoCvhPurcQTd/R+P8naTCSOM7/mXszeixXnHCqEsckUFaMoFXrawZJSrCSyAxHIMevbD0noTtIXcuEVw66b/VHUgkm6FsOvzlXO7s9bmAMkWVMnaPaPKs1K4qL8C9YKmAEEVu/mxX2juusgDka4qXgYWmSIf8s26M/rkQ06UMxMxuS7XD5J0454GwWt2HaFvaDZT9KHuVeEjyjBY4W5Rggfynf/wZYKpSUsr8H5Fk/MDdxtQZ3lkiWQT73VnznXOzG1V61ySbIwMvCGB6sjaJ8qMl/kvOzEp3mVK8mNRP5SY8mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(5023799004)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xUKgZZcJ1htomWaSAxd3S5e10a8+7W0htU0lE7wl9VyjSkoU2cVFoQ72pR8jd/KtU5En+B4Yimm+djSp0qVJePmXjJZ6srntzetpbVw5PTmPqcxfAwb1/Bu1Nynkq55rVPbNvQH1rYZe8HWtDIXqQEriQxP+QZx+KXkitAqQLPO3RSFLuzWuVHgG3I+i/h/cKMeSPoI65JxBllGBvDhmKK65Q6NaKCACSWpnPb8ExHVZvUU5UUV0O0Esp9VIoPjCSbm161KWbmbzO497KJYj9Oi7+m20YlielAuYwnJU6AZHmfMzQFDEY9+Uq80eN+kHNXZZDDyF2PwdkNcxfPUWPLZaxX2NyeK7q+OfBPqE+I0KMValw9yqcW3dB7B0CEPM8ABe1w067EbdJFiR6zD8jUIsPY18k/ONkI9w87WYUggRHyxukfRt6+4MSc9jHARu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:05:49.3922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfce8c0-7f3c-4d16-a655-08df07a3a253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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

At Display Next Hackfest 2026 we reviewed progress moving brightness
control into the DRM connector properties.

There is a range LUMINANCE property that will default to 0->0.
Once a driver attaches a backlight it will be updated to 1->max.
If the panel supports the minimum backlight turning off the display
the range can later be updated to 0->max instead of 1->max.

The legacy sysfs interface is synchronized with the DRM connector.
When a compositor using this feature is loaded, sysfs writes are disabled
to prevent legacy tools from going out of sync with the compositor.

This has an implementation initially for amdgpu, i915, and Xe with eDP
connectors.  It can be extended to other connectors like DP for displays
that can be controlled via DDC as well later.

The following compositors have implemented matching support:
 * Kwin: https://invent.kde.org/plasma/kwin/-/merge_requests/9298
 * Mutter: https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop
 * Wlroots: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5384

v6 -> v7:
    Core rework (feedback from Maxime Ripard):
     * Make the DRM backlight core backend-agnostic. Add a struct
       drm_backlight_funcs indirection so the backlight subsystem is just
       one backend; other backends (DDC/CI, MIPI-DCS, ...) can be added
       later without touching the core.
     * Stop dynamically allocating the DRM backlight. struct drm_backlight
       is now embedded in struct drm_connector and initialized by the
       core, so drivers no longer allocate it or handle allocation
       failure.
     * Drop the "drm/amd/display: Allow backlight registration to fail"
       patch; it is no longer needed now that nothing in the alloc path
       can fail.
     * Update the LUMINANCE property only through the atomic path. Remove
       the synchronous backlight writes from the property-set and legacy
       paths; the hardware is now touched solely from the atomic
       commit/enable path (via a workqueue, so slow backends never stall a
       commit).
     * Move the inlined luminance/DPMS logic into helpers and fix the
       comment style to match kernel conventions.

    Per-connector property (fixes a multi-panel bug):
     * Replace the single device-wide LUMINANCE property with a
       per-connector property created from the linked backend's range.
       Previously all connectors shared one property object, so linking a
       second panel corrupted the range reported for the others.
     * Never mutate the property min/max after creation (avoids racing
       GETPROPERTY). Add a kernel-internal drm_property.is_luminance flag
       to accept value 0 (DPMS off) without a device-wide pointer
       comparison.

    Kconfig (feedback from Thomas Zimmermann):
     * Drop "select BACKLIGHT_CLASS_DEVICE" from DRM. Add config
       DRM_BACKLIGHT which "depends on" BACKLIGHT_CLASS_DEVICE and
       provides no-op stubs when disabled, so DRM no longer forces the
       backlight subsystem into the kernel. Builds verified with the
       option both enabled and disabled.

    Documentation (feedback from Hans de Goede):
     * Document the LUMINANCE range table (1-N vs 0-N), that 1 is the
       minimum visible brightness, and that 0 means the display is turned
       off (with its vblank/pageflip implications).
     * Document BACKLIGHT_UPDATE_DRM.

    Misc:
     * backlight: fix a copy/paste kerneldoc on
       backlight_unregister_notifier and add a struct notifier_block
       forward declaration in backlight.h.
     * Split the old "drm: link connectors to backlight devices" patch
       into "drm/property: add a per-connector luminance flag" and "drm:
       add connector backlight (LUMINANCE) infrastructure", and rework the
       capability patch into "drm: add DRM_CLIENT_CAP_LUMINANCE".
     * Drop all Tested-by tags; the series has changed substantially and
       needs to be re-tested.

Mario Limonciello (12):
  Revert "backlight: Remove notifier"
  backlight: add kernel-internal backlight API
  drm/property: add a per-connector luminance flag
  drm: add connector backlight (LUMINANCE) infrastructure
  drm: add DRM_CLIENT_CAP_LUMINANCE
  drm/amd/display: Pass up errors reading actual brightness
  drm/amd: Indicate driver supports luminance
  drm/amd/display: use drm backlight
  drm/bridge: auto-link panel backlight in bridge connector
  drm/xe: Indicate support for luminance on the connector
  drm/i915: Indicate support for luminance on the connector
  drm/i915/display: use drm backlight

 drivers/gpu/drm/Kconfig                       |  18 +
 drivers/gpu/drm/Makefile                      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  15 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   2 +
 .../tests/amdgpu_dm_backlight_test.c          |   4 +-
 drivers/gpu/drm/bridge/panel.c                |  15 +
 .../gpu/drm/display/drm_bridge_connector.c    |  11 +-
 drivers/gpu/drm/drm_atomic_helper.c           |  39 ++
 drivers/gpu/drm/drm_atomic_uapi.c             |  49 +-
 drivers/gpu/drm/drm_backlight.c               | 515 ++++++++++++++++++
 drivers/gpu/drm/drm_connector.c               |  56 ++
 drivers/gpu/drm/drm_drv.c                     |   8 +
 drivers/gpu/drm/drm_file.c                    |   5 +
 drivers/gpu/drm/drm_ioctl.c                   |  17 +
 drivers/gpu/drm/drm_mode_config.c             |   1 +
 drivers/gpu/drm/drm_property.c                |   6 +
 drivers/gpu/drm/drm_sysfs.c                   |  26 +-
 .../gpu/drm/i915/display/intel_backlight.c    |   4 +
 drivers/gpu/drm/i915/display/intel_display.c  |   7 +-
 drivers/gpu/drm/i915/display/intel_dp.c       |   1 +
 drivers/gpu/drm/i915/i915_driver.c            |   1 +
 drivers/gpu/drm/xe/xe_device.c                |   3 +-
 drivers/video/backlight/backlight.c           |  99 ++++
 include/drm/drm_atomic_helper.h               |   2 +
 include/drm/drm_backlight.h                   | 158 ++++++
 include/drm/drm_bridge.h                      |   1 +
 include/drm/drm_connector.h                   |  20 +
 include/drm/drm_drv.h                         |  14 +
 include/drm/drm_file.h                        |   8 +
 include/drm/drm_property.h                    |  10 +
 include/linux/backlight.h                     |  63 +++
 include/uapi/drm/drm.h                        |  22 +
 35 files changed, 1195 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_backlight.c
 create mode 100644 include/drm/drm_backlight.h

-- 
2.43.0

