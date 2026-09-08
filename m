Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F060EC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 190AC10E98D;
	Tue,  8 Sep 2026 04:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tuZYUwjN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEAB210E043;
 Tue,  8 Sep 2026 04:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALka7cfqWq8kRGNmOcRizHBT8a40hJQis9pFMM84zeP4iZp0jHnvANKwvgEij60DppKyg2SA7GlnC/WTKB8jrFUPVogJPqEsrGPLLig/y3ARCXICkZ9gjt09W++EwKW1jYo1C1ohXzp6oqhKQDI9TyQ3HnHejrIhhTSusrC1bNTqu3fP4BeYq/AK1sHwDOi3no04iwEQXIvkg/KzHEJ/pVzicR6lnby1FTlHMA+Mz69ozgjXiCU8yUxzl5RYWuubwag1FERLWTuIq7vig6Q4eYlfxSuhLnPuyw4NUnd1kJikmmvJb5wV1Srcd01wUT5kwboIq1lbaMPpi3haCYW9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBIAa04ekrHJuFkpSD691d2SSFaQpxvZyeRPB+BYyAE=;
 b=cI7AkCxozpmwtKroHlGbkJK2pLIyznjpmAyP1LnHkyp4nMGt0G06w91Qhw9D6S5iybpmQJtrrAYDYerI2u4dT76wOmemVTgkmv0V3zjTXqoJQMrXJoS3xPbZEP8QlrleDHUM0COTu0tgixJS6n4tTsWJFXBNGhEn/ATOnjX3X94FrBfSXauk3bQ2XO0Wr1SjqXQ3uwoj3vVQ0cjvQp6h4Z69YhWMuhEjyHl7E5n4pN7DRRvDcFZBb7N1mvEw8wI+yIZTfPb9lA9tGHPZa2/lmlLaDltExOjHa0LbAvbh77bE6msfvcHMjpZRtLxC8JGQ3/n4Xuo2q/XO3taNH/CT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBIAa04ekrHJuFkpSD691d2SSFaQpxvZyeRPB+BYyAE=;
 b=tuZYUwjN4/Co+5iSCPqhcpf7Ni/Ya7jG9YsPQlC5MnXdVmeCWhaIFKKfzHwcAqXnNYX2RDChYXsjgo4Tg5NHWN68Uii4fnd99tof4jpcUTHwb9BcwSJ2nanOhoOII2kT3j2OQXGk5x1QW7TDy8oYhYHrXz36TBJamN60OZY5ON8=
Received: from CY8PR12CA0047.namprd12.prod.outlook.com (2603:10b6:930:49::20)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:40:55 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::ad) by CY8PR12CA0047.outlook.office365.com
 (2603:10b6:930:49::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:40:54 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:40:52 -0500
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
Subject: [PATCH v8 00/14] Add support for a DRM backlight capability
Date: Mon, 7 Sep 2026 23:40:21 -0500
Message-ID: <20260908044035.62093-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 739ceaac-e35c-4762-7100-08df0d635e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: bcB5w57LShDejq/i57sFMNtS18zaLmwDE2+niyZFvSaNlJiHdY6Tq970FvMBHVMlIy7MoisMo2GTAI4jP0o9ZC49xhUOkNjnO/YAZCagftc9I6YMyJLl/ny26mZTg7gVHqC+aWJCRjBQDJP0zr8xLMXCPfQJ4V73HGAka1x7AaedY3GM77xMViLsCWyK2kSQpfrL14FVqpEIZhIEIMsDzQ4wFoxAQ7p2DttCnuMe8aIf3M84id18jydU2vDGYViEqFvAaL9CMieLZaaI25LA3K7iIonE2hAfGYMiRj0w4UmuFQegrXly2F/SvdLKI+2/Kpp6H1NxfVjQ7NH7yBjVen1Q377eDsHbF1tc9ZNSX+pY17OPtzCz2panGQHXbdh/sTWZq5hDEDOYnDJSYTFa1BzSqL1zzTZofdwHvPfwlEMH8EHuLibMVRZOq2JaLtCMTE+sgdbRPayMdj+nVY9oS81aAcePNYmrDpvti/Ycl+sq9UCYQK/ssusD66Vnl+PmAwL1zYMA+34pJXxvh1VyLDaH7s0CTF8MLno+krwCDkDx9qCgdYei5WLGi5ZHjtwYs40B2H7ELqQs2Ni3FQTWOfZw4NWnaTtkx4qxRYakZCzod17A8JC1ON6Kl68dgnKQVd9TU1eHFiVTgZPcxNeVyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0QJgO6TqmFqnRBkSQ8rSP97thG1vm24cEnsl/1gjrB2O+DzSOYSQqWHdT7wfg+0mhG8F4KZv55wpBhdpS1OuuYMqlGigEwgQmqlhHq95SzanyugzFodSXDIYTjt3vRPxLcioYZ6+SK1OiOUhMPW/D7T/RNO/P7ZIEufRVzKwGqEZl0vzdH3Z6/dCmjKjiituME5hId0tNhDT6sPVbnNR4TUbF2oV2wtvgZWSTcXzrNmpf6jQOyMywFolov1mXLzLoYBvqDCcy5M5UIWzovQmZn/VrgWvbeLO1WKjqaK+hHvSdrpn9APDr7YDDSaDs3nM1ZyCGUXkveAxvIDoKeQtktWCHDcI0JKw+84Iy3GlLMcqkVVgi8YXOUjrW7xHl0mCJoNCIO9aNaD/7yxi1/1eho5cq2bZTcfILx0K5y/hlslHIXTq0cJWDAvHP6n2pWqp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:40:54.2022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 739ceaac-e35c-4762-7100-08df0d635e2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
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

v7->v8:
  - Rebase on v7.3-rc2
  - backlight: add kernel-internal backlight API: 
    - Inhibit legacy "bl_power" sysfs writes during a DRM takeover, not 
      just "brightness", so the takeover is fully exclusive. 
    - backlight_set_brightness() now returns -ENXIO (and skips the uevent) 
      instead of reporting a false success when the device has no ops. 
    - Release ops_lock before emitting the change uevent. 
  - drm: add connector backlight (LUMINANCE) infrastructure: 
    - Take a reference in drm_backlight_get_device() and drop it in the 
      sysfs-link callers to close a use-after-free. 
    - Unlink any still-linked backend in drm_backlight_connector_cleanup() 
      instead of only WARN()ing, so a connector torn down on a probe-error 
      path no longer leaks a global-list entry / pending work item (also 
      removes an unconditional lockdep assertion). 
    - Guard the backend pointer against a concurrent re-link while 
      unlinking. 
    - Drop the redundant luminance restore in the bridge-enable path that 
      dereferenced the live connector state; the commit tail already 
      applies it from the new state. 
  - drm: add DRM_CLIENT_CAP_LUMINANCE: 
    - Serialize the capability change so concurrent ioctls on a shared fd 
      cannot unbalance the inhibit count. 
    - Track the legacy-inhibit device-wide so connectors hotplugged (e.g. 
      DP MST) while the capability is active inherit it, and no longer 
      trigger warnings when the client exits. 
  - drm/amd/display: Pass up errors reading actual brightness: 
    - Also return -EINVAL from the legacy PWM read error path (previously 
      returned the cached value), matching the KUnit test. 
  - drm/amd/display: use drm backlight: 
    - Apply the LUMINANCE property on modeset commits too, and avoid a NULL 
      CRTC-state dereference on brightness-only commits. 
  - drm/xe: Indicate support for luminance on the connector: 
    - Drop an unrelated DRIVER_GEM_GPUVA change squashed in by mistake. 
  - drm/i915/display: use drm backlight: 
    - Remove an unused <drm/drm_backlight.h> include from intel_dp.c. 

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

Mario Limonciello (AMD) (2):
  drm/amdgpu: Check bios_scratch_reg_offset in backlight level helper
  drm/amd/display: Update KUnit backlight tests for luminance property
    and fixtures

 drivers/gpu/drm/Kconfig                       |  18 +
 drivers/gpu/drm/Makefile                      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  15 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  36 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   2 +
 .../tests/amdgpu_dm_backlight_test.c          |  18 +-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |   8 +-
 drivers/gpu/drm/bridge/panel.c                |  15 +
 .../gpu/drm/display/drm_bridge_connector.c    |  11 +-
 drivers/gpu/drm/drm_atomic_helper.c           |  35 ++
 drivers/gpu/drm/drm_atomic_uapi.c             |  49 +-
 drivers/gpu/drm/drm_backlight.c               | 550 ++++++++++++++++++
 drivers/gpu/drm/drm_connector.c               |  56 ++
 drivers/gpu/drm/drm_drv.c                     |   8 +
 drivers/gpu/drm/drm_file.c                    |   5 +
 drivers/gpu/drm/drm_ioctl.c                   |  24 +
 drivers/gpu/drm/drm_mode_config.c             |   1 +
 drivers/gpu/drm/drm_property.c                |   6 +
 drivers/gpu/drm/drm_sysfs.c                   |  32 +-
 .../gpu/drm/i915/display/intel_backlight.c    |   6 +
 drivers/gpu/drm/i915/display/intel_display.c  |   7 +-
 drivers/gpu/drm/i915/i915_driver.c            |   1 +
 drivers/gpu/drm/xe/xe_device.c                |   1 +
 drivers/video/backlight/backlight.c           | 108 ++++
 include/drm/drm_atomic_helper.h               |   2 +
 include/drm/drm_backlight.h                   | 166 ++++++
 include/drm/drm_bridge.h                      |   1 +
 include/drm/drm_connector.h                   |  20 +
 include/drm/drm_drv.h                         |   7 +
 include/drm/drm_file.h                        |   8 +
 include/drm/drm_mode_config.h                 |  11 +
 include/drm/drm_property.h                    |  10 +
 include/linux/backlight.h                     |  67 +++
 include/uapi/drm/drm.h                        |  22 +
 37 files changed, 1313 insertions(+), 25 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_backlight.c
 create mode 100644 include/drm/drm_backlight.h

-- 
2.43.0

