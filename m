Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4776CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C609710E679;
	Fri,  2 Oct 2026 19:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iQDTzuWA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C92110E5FB;
 Fri,  2 Oct 2026 19:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McY3L2Ldj+drip+ZArNtBhqHodFosBqSvcXnAyGPoEVPsJXDqeXURsnoHfF50LzwlU1tNRP2fWnUr9+Xz3fqHYasOXFDPoAdos83qnP4YOUArNjrKKffdIbfhSJNgzn8nWKRNsxXLf8ZkOdrWnUuj+6HYE3vdUnDHYCpjsLsO2cajsFoZt/Pg8TN6e7EfG/n3cPwWke20KZkXjGuYe00tiYWqyjAoqGQ0b98N2kwzYumar8pK7g+DveXM3tuJUoC9TLDxWWPIZEPYqFzDKkcZ6oDHFNNmSW9xkkxG0gBJrd37CrFC0yO1Eh18HlOYa2KtBwAqd+uppSlkSzfUiaxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9pQKSuSyIZZnfsGO40JGWeVQq12a0GfvupwMxQ6qq0=;
 b=trcLuZv2WxaoB0MK4u6TJNYa/Sl9SK9qMxVACktbnTSCX8CfyMRLdp21xknjc6qZazzE860iTsXEis2v6A66RxUK4zixfvvugbqi8YCXRlwZkZGZr8YEfoUWYOyMqXS7hf7+N0q5t//XU7dVid3ObNVnFiRPmb+FftmqS+Qk0vMYCdr9e6LddJl/AfkAP0fvVPqHUFyqFOhPpO1CVXTIfujrGHQJHWtvndgtSMMkTk23D2vCn6bbRTpNrob3rb61ahLQn0xatF8WObcH218VDV26prUkzs8r3eIpVuiShZvX5pz4TSl3rDoPJun8Xc9JKzD0hB+YfOqjqOHqkbhIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9pQKSuSyIZZnfsGO40JGWeVQq12a0GfvupwMxQ6qq0=;
 b=iQDTzuWAaDvGDl9vMeq6JT+f+hVJ+hJ8I215jzYzXB+h182WsIHTmAJwnadxPUwlg1g2b99ixHdIPWMiEnz479RJK89XHI2Hdm8kR3Rrord7kuadfBIwmtPpTg1Y+fbwrnbF/uNuLaM/e+KujQDlQXGlsr8JrBpKjqt9OSiIgP8=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by PH8PR12MB999274.namprd12.prod.outlook.com (2603:10b6:510:40d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 19:01:05 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::82) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:04 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:02 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v9 00/21] Add support for a DRM backlight capability
Date: Fri, 2 Oct 2026 14:00:09 -0500
Message-ID: <20261002190030.211356-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|PH8PR12MB999274:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4c76ac-3815-47eb-0326-08df20b7824a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|82310400026|36860700016|6133799003|10067099003|5023799004|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: VXUGY+WGy8OQ9bYWEQYEdbb2XvcHX1ig3gTdUAcldX8P/VbWmR7iu3OMVoxxp9iU+GV8JTZqptkL97m3mB+ScQUOvMA+8Uak3Vg0AGZN1SvEb1K0++KKJgdlSZzClUOkDVDBW2ApCO4HSW/G40i3D7OwM2W1Zb5orNkHEI5gf2yNBYYBrzcRy9PWJCSNVGPsP6Tu0+pvWpTbG7vPPZUh7xbh7qGABv2M2Hr+4GIJ545kX5VPxBCwHdg1yZfNjVteWPMDlxS2NUw4VG9NHJ7HmsLIhpxmAAo7zppZs5PfyXkt8rxoanfDJM1xUF+4jnms48AdSZjOyBQrHAzGsnPtYkGQoXHPqc9y2wgbVrSQPghfnuxMp1qL1XE/kkDfzRXvnLukCaPVhB4veCmRogz14wbWaHXshvnboGinUPySw7TC6VMPqSE68F1M7VLm0eNYhRbIMtvzYTiBTSj7jtFwqs4KiQSiWwDLBMT3aRdUlV7AcOfpQcjGobiV7/Bv13yvkxDyLM8w8kXQT3MCb/+wi75ei73RkRlRGA332pr3suyjTgEMcKrClx6VajXLXT2CNRD5NL1Qd6YarRcc+zczn6MIUTOs/FoSLK7QvhtsSMGr5WolJTZd9iMVLYF2Lx/8OKKwSl1LVN7dfYmGNSaf3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0f+sNxfnZvCf7OCzP2eUbpjD0O3pFUO3tS7WrZk6yN0QtDlJAIPjAE7DX0wV1RocC2a3w2bUPhn4lSsskmYwibbB83UldaGg3J56KDXmtVVtyuueg9g4D8lPD0RtATjg3w7QHDKI3wo1zCGyuoNu1TBxs8HNYQ4ayNSHGsP9E9p7vUTyuosMWiktoVOn0gCxmrGl+1rxTAYNYXJzn8Ti+kW/l8qhRk4/oZPeNQ0EbtQxVz1UdD1Y00Y0OTneBy6Xw3/fgs3BVm+bEtf0k+2Hb97Szh+7hyvxAWyDX2uDonKcThqmS4shoM88reQQ1ZJcu8jHWImjp4XBk2noZ2/p8kuJfLC+E+t51z2E1rWkjBjgN0DXoCDjsrdmSckiJiNCRLE2knCOwCzxsM0RBEUIbJy+dH9QWbGiPEKDCwH8P9QyHwozmox3fLlEdy5EL1S0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:04.5798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4c76ac-3815-47eb-0326-08df20b7824a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999274
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

Version 8 had a lot of review feedback, and the biggest change is that
this no longer has the legacy sysfs interface for brightness control.

There is a Kconfig knob introduced that turns on the new API, and when
the new API is available all drivers will conflict with the old backlight
control API.

This will allow us to land the new brightness control API and the transition
to the new API separately.  *This series only tracks the new API itself.*

Here's the main review items that I tried to cover in v8->v9.

- [x] Javier Martinez Canillas: separate generic DRM luminance infrastructure
      from the backlight-subsystem adapter; let drivers own the hardware path;
      avoid a leaky `drm_backlight_link()` mid-layer.
- [x] Thomas Zimmermann: invoke a connector helper callback from atomic helper
      sequencing; keep backlight-specific state in driver-owned structures and
      helper code rather than embedding it in DRM core objects.
- [x] Thomas Zimmermann, Leo Li, Harry Wentland: make luminance and display
      power/DPMS independent. Preserve requested luminance while a display is
      disabled and apply it when the display is enabled.
- [x] Jani Nikula: remove `IS_REACHABLE()` linkage workarounds and express any
      remaining dependencies through Kconfig.
- [x] Thomas Zimmermann: remove the driver capability flag if userspace can
      discover support by the connector property itself.
- [x] Thomas Zimmermann: remove redundant brightness-change notification and
      DRM readback loops when the committed property already contains the
      authoritative requested value.
- [x] Maxime Ripard: split the new DRM UAPI from legacy sysfs compatibility so
      the property can be reviewed and merged independently.
- [x] Javier Martinez Canillas / Maxime Ripard / Thomas Zimmermann / Xaver Hugl:
      preserve legacy sysfs behavior for legacy userspace; avoid silently
      breaking the de-facto backlight UAPI while DRM-master ownership is
      introduced.
- [x] Harry Wentland / Jani Nikula / Xaver Hugl: terminology reviewed. Retain
      `LUMINANCE` as an explicit author decision, while documenting that the
      property contains relative, driver-defined levels rather than physical
      cd/m^2 values.

As the series changed significantly from all this feedback I did not see value
in a per-patch changelog.  Instead here is the changelog from the whole series:

- Reworked the interface around driver-owned connector helper callbacks.
  Removed the generic DRM backlight adapter, backend-linking layer, and
  backlight state embedded in DRM core objects.
- Made LUMINANCE an atomic connector property whose requested value is
  independent of display power. Disable panel emission before shutting down
  the pipeline, preserve the requested value while inactive, and apply it
  after the pipeline is enabled.
- Removed DRM_CLIENT_CAP_LUMINANCE and the associated per-client takeover,
  legacy sysfs inhibition, property visibility, notification, and hardware
  readback machinery.
- Removed the kernel-internal backlight API and the backlight notifier
  restoration from the series.
- Added the default-off CONFIG_DRM_LUMINANCE option. When disabled, drivers
  retain their existing backlight class devices and userspace ABI. When
  enabled, all DRM-owned brightness implementations migrate to the connector
  property together.
- Migrated AMDGPU, legacy AMD display, i915/Xe, Nouveau, Radeon, GMA500, GUD,
  PS8622, SSD130x, panel and bridge connectors, and the DRM MIPI DBI drivers.
- Added common panel, bridge, and MIPI DBI luminance forwarding helpers.
- Retained the LUMINANCE name, while documenting that values are relative,
  driver-defined levels rather than physical luminance in cd/m^2.
- Added connector property lifecycle coverage and updated the AMD display
  KUnit fixtures for both CONFIG_DRM_LUMINANCE configurations.
- Fixed error propagation when AMD Display Core reads the current brightness
  and guarded legacy AMDGPU backlight scratch-register access.
- Restructured the series from 14 to 21 patches splitting the core
  infrastructure, shared helpers, and individual driver migrations.

The following compositors have implemented matching support:
 * Kwin: https://invent.kde.org/plasma/kwin/-/merge_requests/9298
 * Mutter: https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop
 * Wlroots: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5384

I've tested this series using Kwin on amdgpu. I've compile tested other
drivers.

The series is also available on this branch for easy testing.

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v9

And lastly; I've used an LLM to assist with implementing this version, particularly
on all the drivers I wasn't familiar with.

Assisted-by: LLM

Mario Limonciello (19):
  drm: add connector LUMINANCE property
  drm/amd/display: Pass up errors reading actual brightness
  drm/amd: add luminance property support
  drm/i915/display: add luminance property support
  drm: add panel and bridge connector luminance forwarding
  drm/mipi-dbi: add connector luminance helpers
  drm/tiny: migrate panel-mipi-dbi to connector luminance
  drm/tiny: migrate HX8357D to connector luminance
  drm/tiny: migrate ILI9163 to connector luminance
  drm/tiny: migrate ILI9341 to connector luminance
  drm/tiny: migrate ILI9486 to connector luminance
  drm/tiny: migrate MI0283QT to connector luminance
  drm/sitronix: migrate ST7735R to connector luminance
  drm/nouveau: add connector luminance support
  drm/gud: add connector luminance support
  drm/radeon: add connector luminance support
  drm/gma500: add connector luminance support
  drm/bridge: add PS8622 connector luminance support
  drm/solomon: add SSD130x connector luminance support

Mario Limonciello (AMD) (2):
  drm/amdgpu: Check bios_scratch_reg_offset in backlight level helper
  drm/amd/display: update KUnit luminance fixtures

 drivers/gpu/drm/Kconfig                       |  14 +++
 drivers/gpu/drm/amd/amdgpu/Kconfig            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |   7 +-
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  20 ++++
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  17 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  22 ++--
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  55 +++++++--
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   4 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   7 +-
 .../tests/amdgpu_dm_backlight_test.c          |  47 ++++++--
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |   7 +-
 drivers/gpu/drm/bridge/Kconfig                |   2 +-
 drivers/gpu/drm/bridge/panel.c                |  39 +++++++
 drivers/gpu/drm/bridge/parade-ps8622.c        |  45 +++++--
 .../gpu/drm/display/drm_bridge_connector.c    |  65 +++++++++++
 drivers/gpu/drm/drm_atomic_helper.c           |  73 +++++++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c     |   7 ++
 drivers/gpu/drm/drm_atomic_uapi.c             |   5 +
 drivers/gpu/drm/drm_connector.c               |  57 +++++++++
 drivers/gpu/drm/drm_mipi_dbi.c                |  36 ++++++
 drivers/gpu/drm/drm_panel.c                   |  55 +++++++++
 drivers/gpu/drm/gma500/Kconfig                |   2 +-
 drivers/gpu/drm/gma500/backlight.c            |  45 ++++---
 drivers/gpu/drm/gma500/cdv_intel_lvds.c       |   2 +
 drivers/gpu/drm/gma500/psb_drv.c              |   2 +-
 drivers/gpu/drm/gma500/psb_drv.h              |   4 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c       |   3 +-
 drivers/gpu/drm/gud/Kconfig                   |   2 +-
 drivers/gpu/drm/gud/gud_connector.c           |  48 +++++++-
 drivers/gpu/drm/i915/Kconfig                  |   2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c        |   1 +
 .../gpu/drm/i915/display/intel_backlight.c    |  20 ++++
 .../gpu/drm/i915/display/intel_backlight.h    |   1 +
 drivers/gpu/drm/i915/display/intel_display.c  |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c       |   1 +
 drivers/gpu/drm/i915/display/intel_lvds.c     |   1 +
 drivers/gpu/drm/i915/display/intel_panel.c    |   8 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c        |   1 +
 drivers/gpu/drm/nouveau/Kconfig               |   4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |   2 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c   | 110 ++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.c   |   2 +
 drivers/gpu/drm/nouveau/nouveau_connector.h   |  14 +++
 drivers/gpu/drm/radeon/Kconfig                |   2 +-
 drivers/gpu/drm/radeon/atombios_encoders.c    |  32 ++++-
 drivers/gpu/drm/radeon/radeon_connectors.c    |  34 ++++++
 .../gpu/drm/radeon/radeon_legacy_encoders.c   |  49 ++++++--
 drivers/gpu/drm/radeon/radeon_mode.h          |   2 +
 drivers/gpu/drm/sitronix/Kconfig              |   2 +-
 drivers/gpu/drm/sitronix/st7735r.c            |   3 +
 drivers/gpu/drm/solomon/Kconfig               |   2 +-
 drivers/gpu/drm/solomon/ssd130x.c             |  79 ++++++++++---
 drivers/gpu/drm/tests/drm_connector_test.c    |  28 +++++
 drivers/gpu/drm/tiny/Kconfig                  |  12 +-
 drivers/gpu/drm/tiny/hx8357d.c                |   3 +
 drivers/gpu/drm/tiny/ili9163.c                |   3 +
 drivers/gpu/drm/tiny/ili9341.c                |   3 +
 drivers/gpu/drm/tiny/ili9486.c                |   3 +
 drivers/gpu/drm/tiny/mi0283qt.c               |   3 +
 drivers/gpu/drm/tiny/panel-mipi-dbi.c         |   3 +
 drivers/gpu/drm/xe/Kconfig                    |   2 +-
 include/drm/drm_atomic_helper.h               |   3 +
 include/drm/drm_bridge.h                      |  26 +++++
 include/drm/drm_connector.h                   |  16 +++
 include/drm/drm_mipi_dbi.h                    |   7 +-
 include/drm/drm_modeset_helper_vtables.h      |  25 ++++
 include/drm/drm_panel.h                       |   5 +
 67 files changed, 1070 insertions(+), 140 deletions(-)

-- 
2.43.0

