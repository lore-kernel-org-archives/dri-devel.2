Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F3606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2OpLXmOP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56EB10E1D3;
	Thu, 19 Nov 2026 23:27:55 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB0910E071;
 Thu, 19 Nov 2026 23:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Guyp0+bruPo22YbJhHZ63WoX3bLEKlQGqb0GGAos9SpSb0F6Gg1bznxlY7gzTopMLPajQTRWeRj5/QiyAnO89g5J54NZ/MTDlxhwGtXFmPSZrhGhqHBRDo1lEYI+q8aUKauQUnBvlkTCtP4GYLx3/ghJjzXQBEpIxxSH9NwUQIUCR+1c6NLwN8CPoEx6x6HIeT5GHRuBlfRoyr//usm7AEIm3P14KPxqdRtRvtkbW9zP3l0Oj0hvttT5JdFPHjk+3+5yNMfMbAg+iHyIraguw0RBWi8hkTb+AMMQ0D+GGK/0fW4pMyP7NJ8QTVrr3yYeWRB4ZRkBiMtrYOv6z4UVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArffUVKdCNnit/0ATOUcQ/75wZdnGIURIb2hwnaTygo=;
 b=l8k8C9cjdUUVtlhfzQ5SE5rg/ZM+F3cgC3pQ7z2l51CoFYn6VgaMsqX2ZAyjLy7ELKbDXkkbjdBjql7egd4O8y4oP+h7V0dJUh24Uo1isYPwISpNwKg5/dxHgCqZPkOdkzP+jG4nwdEab8QGOG2gObZMwyq8IwMC8f0y39RBL49lvwtFTJK2hjp2iU9SeLHxQjsQ4XAeNI/s9XAZry1fxJV8RtJp9AnbPtj9MzSx3+GBoa43K7qKf75bDP0U6ERZQhSs6BoNlX5L34kH4FMSVOkIkcctPGBq1JfhCJT+MjLJ3z+IGppvvgQCCRwOfiAZ7NhTihrx01B2xzLmQWIPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArffUVKdCNnit/0ATOUcQ/75wZdnGIURIb2hwnaTygo=;
 b=2OpLXmOPtE2bApQaGkxExXheHu0op5ZZacKdT/5kwhnxc9y52kyy88awuFb7mGsgBUC79dyd3iGgEoA3dKlmtgebc3kw8/MsuDbm2x+lbpP2p/LgS0hLHoP14bW9V8HrqWurNDkNCNYRVOHMOfFoBflAlCHJI4fAo/qIt2nklZQ=
Received: from PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::12)
 by DSVPR12MB066941.namprd12.prod.outlook.com (2603:10b6:8:4fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 23:27:42 +0000
Received: from PH7PEPF00000007.namprd04.prod.outlook.com
 (2603:10b6:510:348:cafe::24) by PH8P220CA0026.outlook.office365.com
 (2603:10b6:510:348::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 23:27:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000007.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:41 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v12 00/12] Add support for a DRM backlight capability
Date: Thu, 19 Nov 2026 17:27:27 -0600
Message-ID: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+F/2oC/yXMwQ6CMAyA4VchPduELsQEXsV42EaFgsLSDqMhv
 LtTj/9/+HYwVmGDrtpB+Skm61KC3KmCOPplYJS+DHC1OxPVhLYl1gdh8HG+yzBmTLqWld9IzG0
 g3wTX9FCApHyT10+/XP9tW5g45q8Ix/EBctij3n8AAAA=
X-Change-ID: 20261101-superm1-backlight-property-1ee9b1a4b24d
To: Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>
CC: Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000007:EE_|DSVPR12MB066941:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3c2754-06c0-4d61-1e85-08df4694b543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|18002099003|13003099007|11063799006|921020|261022075727099003|261026140227099003|261022105027099003|261028144727099003|56012099006|10067099003|261009220027099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261009221727099003|261102123227099003|261009223327099003;
X-Microsoft-Antispam-Message-Info: Lx2O7uKerhAker2MAZtkN3viM71mvfdT2bWSoLj0tmAqH3p6vKgJMh6lM+XNH6fQAxNi1Aawj0pRjG2/U8uC18PBUCe+dpYSOYTNbaVrY6sHdUCkyLilX51HzsCo3Od/H2CtugC+fJ5NIihEkmWAx7ecYP2RjjFnSugJbnJViExDHoG7OYFKXSGGl1d/541ZCimdA7erIucgjFe/u4K5zpuI2MhjZQIAWIclDjrLCahkXv5atMTurcX3jB4EvhJfj5DdNF3/lcN/wxITHrCT4N3s66Jh9T05t7Pc1O3g5r9wXbfnPyXrIabzfaD7KmMo/JY01ioljdGXd4rNGFW505rL71ky/Q9kpED140ggxhbuncTWCils77iH+77VUDUbMn3GCXHshNBwiYdSvZ7Dohh9RUM38P9Gh460KjRwrS7xbaV2rrvEz47GJ7JQdghDatPtjRQ9FRSuFvGiOPGbd9jawDXTlSgqjWSrb8JHag81PdlV1ruOB43LMvRHgXTwzaUGSrtJWncVc+p9CmG1XheFUAvIPKlAC/Sh1wXBKqGLhg6fkISTWgSkNWKZDM4NRLjgzp+w42uGj5DouIYKSteId4o5D2HZtfxmJ/nEaOXiXbkoRylI3vmwvx7amL9/ctBA5pmU16iXkpCU0pA0qAUg2UHUo2J9QUVs001Fd3h4TogljvPnR9blGzSoqdiylgqCfG6vmfu6Pk/z7x+HDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(18002099003)(13003099007)(11063799006)(921020)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(261009220027099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261009221727099003)(261102123227099003)(261009223327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uIjTVxuZMX1hCmM6B2Bqhetq3p+O/rk3FS4MylJ7sQBEm55DfCeP89NQwJfYPG6d3XHiGGUnRcBvXRuWReccpvRjD2xmkh4185sJ1tP7RXGW0PEvEA5bfrCvMeYmQYIrNkrcl3m4iALWSqMDMKBbF+0Jlls6BOXFH21dU67JJmUs8NFlaDlY8UKChv2qKfNr/D4cP4sDSlGnVqL+ySUCWcJ8GF2bpsqVlJzuOh4s7nXiCIu1hy3kJp+Hx5pcpm5D6gaqSbZ0AZ25OTvEiQX4WD8qUVelqoaMirgwFSb6bgKaO+A3T0fSxlqF6g5mkXGSOsbVrwW2ho8eTa3KNPRQCkr6p2awX5BnE4xKY+ZbpqGCWqXTc/JzcwADNpqwUUEnHsHoXKPgUO/fdPUKUfQBeKhmOY16VaZjV7lzfUMVUpNMDgxtseH7XqVwyVSDzeJm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:41.8894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3c2754-06c0-4d61-1e85-08df4694b543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB066941
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

The following compositors have implemented matching support, although they
need to be changed again for items modified in v10 (the dropped cap):
 * Kwin: https://invent.kde.org/plasma/kwin/-/merge_requests/9298
 * Mutter: https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop
 * Wlroots: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5384

I've tested this series using modetest on amdgpu.

The series is also available on this branch for easy testing.

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v12

Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Changes in v12:
 * Collected Acked-by and Reviewed-by tags from Javier on the bridge,
   panel, bridge_connector, PS8622 and SSD130x patches
 * amdgpu: let drm_atomic_helper_commit_luminance_enables() reprogram
   LUMINANCE panels after a modeset instead of amdgpu_dm_commit_streams(),
   which restored a stale cached level, raced with concurrent luminance
   commits and exited PSR/Replay/IPS on unaffected panels; always program
   the level from .set_luminance and retry unapplied levels in the commit
   tail (Sashiko)
 * panel: only store the brightness while the panel is disabled, leaving
   the hardware update to drm_panel_enable(), and skip unchanged updates
   (Sashiko)
 * nouveau: clamp the initial brightness before attaching the property, an
   out of range hardware level failed the device probe (Sashiko)
 * gud: resend the display state with the new luminance from
   .set_luminance and apply it, instead of mirroring LUMINANCE into
   tv.brightness which forced a modeset and rejected commits without
   DRM_MODE_ATOMIC_ALLOW_MODESET (Sashiko)
 * ps8622: keep restoring the backlight class device brightness from its
   properties, a blanked backlight clobbered the cached level while the
   bridge was disabled (Sashiko)
 * ssd130x: drop the enabled flag, the atomic helpers only call the
   luminance callbacks while the pipeline is active (Javier)
 * Link to v11: https://lore.kernel.org/dri-devel/20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org/

Changes in v11:
 * Rebased on drm-tip (fixes Intel CI failing to apply the KUnit patch)
 * Squashed the amdgpu KUnit fixture update into the amdgpu luminance
   patch and moved the bios_scratch_reg_offset fix before it, so every
   commit builds and passes KUnit
 * Dropped drm/radeon and drm/gma500 patches: both are non-atomic drivers,
   so userspace can't use an atomic connector property there (Sashiko)
 * Restored the unconditional select of BACKLIGHT_CLASS_DEVICE in all
   migrated drivers, fixing ACPI_VIDEO unmet dependencies and link
   failures (Sashiko)
 * Core: don't call .disable_luminance when entering self refresh, and
   only call .set_luminance when the luminance changes or on a modeset
   that isn't a self refresh exit (Leo Li, Sashiko)
 * Drivers on ACPI systems (amdgpu, i915/xe) only attach LUMINANCE when
   acpi_video_backlight_use_native() allows it, keeping the acpi_video
   fallback otherwise (Sashiko)
 * Non-atomic paths (legacy non-DC amdgpu, nouveau NV04 and
   nouveau.atomic=0) keep the backlight class device (Sashiko)
 * bridge/panel: removed rebase artifacts from drm_bridge.h/drm_panel.h,
   fixed an invalid container_of() in the panel bridge, cleaned up the
   connector on error, and left backlight power to drm_panel_enable()/
   drm_panel_disable() (Sashiko)
 * bridge_connector: dropped .disable_luminance, which clobbered the
   bridge's saved level
 * amdgpu: restore brightness after GPU reset and modesets for LUMINANCE
   panels, and skip programming unchanged values (Leo Li, Sashiko)
 * amdgpu KUnit: fixed connector_type IDA mismatch (Sashiko)
 * amdgpu: seed LUMINANCE from the hardware level; left the unrelated
   privacy screen code in commit_tail unchanged
 * i915: fall back to the backlight class device if attaching LUMINANCE
   fails
 * panel: don't attach LUMINANCE for panel bridges attached after device
   registration, and update brightness under the backlight ops_lock
 * ps8622: program the committed luminance in pre_enable
 * i915: enable the backlight at the committed level, and fix the build
   with BACKLIGHT_CLASS_DEVICE=n (Sashiko)
 * nouveau: call the luminance helpers from the NV50 commit tail, attach
   the property before drm_dev_register(), and fix a stale eDP brightness
   on the class device path (Sashiko)
 * gud: apply LUMINANCE within the atomic commit instead of a worker,
   fixing an endless commit loop, a use-after-free on disconnect and
   brightness clobbering; attach the property at init (Sashiko)
 * ps8622: track internal PWM mode explicitly and don't touch I2C while
   powered down (Sashiko)
 * ssd130x: register the backlight device only without DRM_LUMINANCE,
   use the committed contrast on enable, don't clobber it on disable,
   skip writes while unpowered, and unify contrast dispatch (Sashiko)
 * Known limitation: with DRM_LUMINANCE, amdgpu ATIF firmware brightness
   requests are not forwarded (i915 OpRegion ASLE requests are already
   ignored when native backlight control is in use)
 * Link to v10: https://lore.kernel.org/dri-devel/20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org/

Changes in v10:

* Split patch 7 (panel/bridge connector luminance forwarding) into three
   separate patches:
  - drm/bridge: add connector luminance operations
  - drm/panel: add connector luminance forwarding
  - drm/bridge_connector: add luminance support
 * Dropped MIPI-DBI tiny driver migrations and the new mipi_dbi connector
   luminance helpers (Javier): backlight is always NULL when
   CONFIG_BACKLIGHT_CLASS_DEVICE is disabled, so these drivers can't
   support LUMINANCE without DT binding changes or a new
   CONFIG_BACKLIGHT_SYSFS option. Will revisit later.
 * Added IS_ENABLED(CONFIG_DRM_LUMINANCE) conditional guards to all
   individual DRM driver patches that call drm_connector_attach_luminance_property()
 * Moved the LUMINANCE property patch after the new "Add support for a
   DRM backlight capability" patch to better separate backlight vs
   luminance functionality
 * Link to v9: https://lore.kernel.org/dri-devel/20261002190030.211356-1-mario.limonciello@amd.com/

To: Maxime Ripard <mripard@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Harry Wentland <harry.wentland@amd.com>
To: Leo Li <sunpeng.li@amd.com>
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org

---
Mario Limonciello (11):
      drm: add connector LUMINANCE property
      drm/amd/display: Pass up errors reading actual brightness
      drm/amd: add luminance property support
      drm/i915/display: add luminance property support
      drm/bridge: add connector luminance operations
      drm/panel: add connector luminance forwarding
      drm/bridge_connector: add luminance support
      drm/nouveau: add connector luminance support
      drm/gud: add connector luminance support
      drm/bridge: add PS8622 connector luminance support
      drm/solomon: add SSD130x connector luminance support

Mario Limonciello (AMD) (1):
      drm/amdgpu: Check bios_scratch_reg_offset in backlight level helper

 drivers/gpu/drm/Kconfig                            |  14 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   7 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  20 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  90 +++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   5 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  72 ++++++++--
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   7 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |  66 +++++++--
 drivers/gpu/drm/display/drm_bridge_connector.c     |  39 ++++++
 drivers/gpu/drm/drm_atomic_helper.c                |  98 ++++++++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c          |   7 +
 drivers/gpu/drm/drm_atomic_uapi.c                  |   5 +
 drivers/gpu/drm/drm_connector.c                    |  57 ++++++++
 drivers/gpu/drm/drm_panel.c                        |  98 +++++++++++++
 drivers/gpu/drm/gud/gud_connector.c                |  61 +++++++-
 drivers/gpu/drm/gud/gud_internal.h                 |   5 +-
 drivers/gpu/drm/gud/gud_pipe.c                     | 136 ++++++++++--------
 drivers/gpu/drm/i915/display/icl_dsi.c             |   1 +
 drivers/gpu/drm/i915/display/intel_backlight.c     |  74 ++++++++--
 drivers/gpu/drm/i915/display/intel_backlight.h     |   1 +
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   1 +
 drivers/gpu/drm/i915/display/intel_lvds.c          |   1 +
 drivers/gpu/drm/i915/display/intel_panel.c         |   8 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |   1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  13 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        | 154 ++++++++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   3 +
 drivers/gpu/drm/nouveau/nouveau_connector.h        |  23 +++
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   6 +
 drivers/gpu/drm/solomon/ssd130x.c                  | 138 +++++++++++-------
 drivers/gpu/drm/tests/drm_connector_test.c         |  28 ++++
 include/drm/drm_atomic_helper.h                    |   3 +
 include/drm/drm_bridge.h                           |  20 +++
 include/drm/drm_connector.h                        |  16 +++
 include/drm/drm_modeset_helper_vtables.h           |  28 ++++
 include/drm/drm_panel.h                            |   4 +
 39 files changed, 1125 insertions(+), 199 deletions(-)
---
base-commit: 9f54e1a5b50dc017d371c435b12ddb5300c7d5b2
change-id: 20261101-superm1-backlight-property-1ee9b1a4b24d

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

