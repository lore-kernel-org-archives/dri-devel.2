Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7960A2619
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c4e1r2nL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A24112790;
	Thu, 19 Nov 2026 23:28:06 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E49910E071;
 Thu, 19 Nov 2026 23:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ekh8OVbXcU/cFl0RjJyOZir5WbfcU1vM/RfTJLwSYskXyFkidumacylC62D/R60zPXO+7acGOQ1WYExCCnMl5DbvRC+SwhaZdv8HQ4qW7Lxc1NyMu3uiCqikpQ2y6SG6/LuG+KcrdRF/nG7bPS9zZEhfukMtJm5773Gj1RPDMwgPddTOtCNUYCQWboasWdtV9/WKPm5ky16hwTQDf2SWgtzlfsqDqX7bWjm9TLUeBbcbecIIr0fyP7blXvu2EmqBH+2segh93qTpSCD+wpRZ3WjazriIJCpDbhGBDsLTn6tfTAWDHh5EV9U3Ntb1DABtoyqrQMfN32WX0NVeKz7g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQSumwdC5/C11y7PidBza4P8tCnGLNIZBftOXvs2jMk=;
 b=QibSbL31VZGIWshVxBZ+PebSWX4ZY7wEtoiPIeFXqkUd2z1qdRNvvRyia3v37b6GDvGRyXPuznmW+hut0gnUU+eZdA3qRXGcPwawIpnYgPK+65Xi04WFkPU/bLUelYWUI1TqFI5piIDaR1HlWHjQ5yGkple0egzvOwsStERRAwm22d7N7Ij+wRP40H5/nIyWBnyaRDEORmuK8afsVQWrl67FWkNnAR/41nQfuxlKlylxWFsB+VA+pvajBhNgOUGIyIOHy3dK38ApX/kD8ZCnmJEUCfcua6oQTDtcM1BymlJej+enAmOZcWBJaPlbzX+dUXB5nQggaa0Kg+7ReQdqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQSumwdC5/C11y7PidBza4P8tCnGLNIZBftOXvs2jMk=;
 b=c4e1r2nLs0RxjEHfbGdR5LmW/mODTSPuaJnK8RZknpgbjTnA1TAmrNXDLUNaZFmUGqUO+gTSZnJG3Y+nllk/pYDZEE+PumSWYPSqgxwRGEcIsXx9IxxsTlY6wYDeo0xoSjdSevvrJ1tLVub8n0321LAmIH7lwf+TQSqn4nOygeM=
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 23:27:49 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::67) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 19
 Nov 2026 23:27:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:48 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:46 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:31 -0600
Subject: [PATCH v12 04/12] drm/amd: add luminance property support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-4-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
In-Reply-To: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 2240d54a-31e3-40ce-4a96-08df4694b916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|6133799003|22082099003|18002099003|261009223027099003|18092099006|921020|56012099006|11063799006|261102130727099003|261026121527099003|261102123227099003|10067099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: FQ10Zw1MWjaIIKK+x+uC8ehepkek2WznUmgArzGx1P7x0znfsjMFhq+wYSC3IkENbaqd+OgbvndPiiEg5m1yJCFSpQJtExvutZ3j0ZPnz9bBepHltGzxwkN0B6tJWUMX9pxmni67e8haptQmUvxhQDLFPViC4BMoU64cwnmUqJvXs/grsKyn2R9dyB+33teWbj+BMcNV6KY1hLNj1oA3GDlP5mHFoSHaWI9f0cqj8JvX+CB7MVkocrbk+Dm1aqit78D/d6T/t6AJ9w5BumrV7Cd4rnJBLhPp9B8xlNXwyFY0OVp0PlnPGJhzbM4+7f36rdDaJWcvEO2HgmJRQo60jhar4vThLY440d1Hu2ouD4hpI5KoxYv3PQ1hY7ceOqoBArZ2oaR/qA+Liu8dvb67f045StPYv6HhC/48gmC+QvAdYiqc1Q6bwOEJxTGDGrNKAyUCEOfzz3VfOtqDSqAlb0AgnXcaqCBEDNhaBtigXINxN43q/vrjf/iGukhhz0JO5Fd2bc+HsbYPm1ukLWitNGCLbPSQdxQPBjHZZkKvTINxKMSFI4n0Y+TYYYPH1SVWv6xSIlsYnVuGgQM0jPUnQjf6/KeGCOXcKYdohMw7PecZs6nCS9+Zc3Iku4sIRzgopTp2gxdm+dnA3+1hxHXMGj4TEJGk2woNeysO6gXoUyERLsrk2+Nj4XYqA21CMSTKUanuBM/6mjuIe+YHcz71A4xRz0fRh8GnS2IgRg4ZdXmDpAsww5hPuCFnb4cAYA9R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(6133799003)(22082099003)(18002099003)(261009223027099003)(18092099006)(921020)(56012099006)(11063799006)(261102130727099003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pHA0WL6jetd4QLoERg/csUL6qDeGRfw/xcrUmWgpackB4Cvkub1LMToQ+rHnhi+HnFLNnL8H48HkL0bS38YV2+gdn1oXB7pqZ/+lq4GYavtQK0bwQVpj/qNQSy1SmeXUJIvnVsi6vjfHFeVVadTzxQD+cDTzdmbc7hS73gMTE3D8LZvg3ojlbahhU7ygAXFxucoZeHm5faea/rlbqufO03iDbANzw41CmtUebwsJIqxFcrPwMjKTdNP2cZC0H/Wt6ReC2S4szd/8ucKpUoSxNrXcG7BpCwxoTjB8qI5UvY/v3yL0KIUQF00hO24F17iqlEU8eyUEVASm2uiBNiJXV2oCk2aG/GWTYqvIkwi8plk+8Fit2O34h91T1m0/U+AVbLykalvn5NtrxoeVtgtGEU0CLQ0YhvqzRKdLOHJX4Dn7B2BqlFlNcKQDVPC3CYFi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:48.3052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2240d54a-31e3-40ce-4a96-08df4694b916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the DRM LUMINANCE connector property for internal panels when
CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing backlight
class device otherwise, preserving its userspace ABI.

Use the existing brightness scaling and programming paths from Display
Core connector helper callbacks. Apply atomic luminance after the display
pipeline is enabled so changes made while a connector is inactive take
effect on the next enable.

The legacy non-DC display path is not atomic, so it keeps registering the
backlight class device. Only attach LUMINANCE when ACPI video selects
native backlight control, otherwise keep the existing acpi_video fallback.
Reapply the cached level after modesets and GPU resets for both
interfaces.

With LUMINANCE, ATIF panel brightness change requests from firmware are
not forwarded, since there is no backlight device to update.

Update the backlight KUnit fixtures to initialise DRM mode configuration,
connector state and link service mocks needed by the LUMINANCE path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12:
 * Let drm_atomic_helper_commit_luminance_enables() reprogram LUMINANCE
   panels after a modeset instead of amdgpu_dm_commit_streams(), which
   restored a stale cached level, raced with concurrent luminance commits
   and exited PSR/Replay/IPS on unaffected panels (Sashiko)
 * Call the helper right after the streams are committed
 * Always program the level from .set_luminance, the skip check collided
   with luminance 0 and the atomic helpers already skip unchanged values
   (Sashiko)
 * Retry unapplied levels in the commit tail for LUMINANCE panels too
   (Sashiko)
v11:
 * Drop the legacy (non-DC) changes; that path is not atomic and keeps the
   backlight class device (Sashiko)
 * Only attach LUMINANCE when acpi_video_backlight_use_native() allows it,
   otherwise register the class device or acpi_video fallback (Sashiko)
 * Restore brightness after GPU reset and modesets for LUMINANCE panels
   too, seeding dm->brightness[] with the initial value (Leo Li, Sashiko)
 * Skip programming an unchanged luminance to avoid PSR/Replay/IPS exits
   (Leo Li, Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE (Sashiko)
 * Seed the property from the hardware level rather than the default
 * Leave the privacy screen update in commit_tail unchanged
 * Squash in "drm/amd/display: update KUnit luminance fixtures" so every
   commit passes KUnit, rebased on drm-tip fixture changes (Intel CI)
 * Initialise the KUnit test connector with the type matching the link
   signal to avoid freeing the ID into the wrong IDA (Sashiko)
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 20 ++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  7 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 77 +++++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |  3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  5 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 68 ++++++++++++++++---
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |  7 +-
 7 files changed, 167 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 56fca4e22df8d..8b5dde608266a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1976,10 +1976,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		mutex_unlock(&dm->dc_lock);
 
 		/* set the backlight after a reset */
-		for (i = 0; i < dm->num_of_edps; i++) {
-			if (dm->backlight_dev[i])
-				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
-		}
+		amdgpu_dm_backlight_restore(dm);
 
 		return 0;
 	}
@@ -4801,6 +4798,10 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 	 * It will cause the dm->actual_brightness is not the current panel brightness
 	 * level. (the dm->brightness is the correct panel level)
 	 * So we set the backlight level with dm->brightness value after set mode
+	 *
+	 * Panels controlled through the LUMINANCE property are reprogrammed by
+	 * drm_atomic_helper_commit_luminance_enables() in the commit tail from
+	 * the committed connector state, so only restore backlight class devices.
 	 */
 	if (set_backlight_level) {
 		for (i = 0; i < dm->num_of_edps; i++) {
@@ -5188,6 +5189,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		amdgpu_dm_commit_streams(state, dc_state);
 	}
 
+	/*
+	 * Apply connector luminance now that the streams are committed. Display
+	 * Core resets the panel brightness when it enables a stream, and the
+	 * helper reprograms LUMINANCE panels after a modeset.
+	 */
+	drm_atomic_helper_commit_luminance_enables(state);
+
 	amdgpu_dm_update_hdcp(state);
 
 	/* Handle connector state changes */
@@ -5415,8 +5423,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 	/* restore the backlight level */
 	for (i = 0; i < dm->num_of_edps; i++) {
-		if (dm->backlight_dev[i] &&
-		    (dm->actual_brightness[i] != dm->brightness[i]))
+		if ((dm->backlight_dev[i] || dm->luminance[i]) &&
+		    dm->actual_brightness[i] != dm->brightness[i])
 			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index e4fed8c855abe..2e700cae52b67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -682,6 +682,13 @@ struct amdgpu_display_manager {
 	 * last successfully applied backlight values.
 	 */
 	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
+	/**
+	 * @luminance:
+	 *
+	 * backlight is controlled through the connector LUMINANCE property
+	 * instead of a backlight class device.
+	 */
+	bool luminance[AMDGPU_DM_MAX_NUM_EDP];
 
 	/**
 	 * @aux_hpd_discon_quirk:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 0f664c658a127..ba8bdf0db0494 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -41,6 +41,7 @@
 #include <linux/backlight.h>
 #include <linux/minmax.h>
 #include <linux/power_supply.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_panel_quirks.h>
 
@@ -296,13 +297,17 @@ struct dc_stream_state *dm_find_stream_with_link(
 	struct amdgpu_display_manager *dm,
 	struct dc_link *link)
 {
-	struct dc_state *cur_dc_state = dm->dc->current_state;
+	struct dc_state *cur_dc_state;
 	struct dc_stream_state *stream = NULL;
 	int i;
 
+	if (!dm || !dm->dc || !dm->dc->current_state || !link)
+		return NULL;
+
+	cur_dc_state = dm->dc->current_state;
 	for (i = 0; i < cur_dc_state->stream_count; i++) {
 		stream = cur_dc_state->streams[i];
-		if (stream->link == link)
+		if (stream && stream->link == link)
 			return stream;
 	}
 
@@ -356,7 +361,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 
 	dm->brightness[bl_idx] = user_brightness;
 	/* update scratch register */
-	if (bl_idx == 0)
+	if (bl_idx == 0 && dm->adev && dm->adev->rmmio && dm->adev->bios_scratch_reg_offset)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
 
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
@@ -657,6 +662,10 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 {
 	struct dc_link *link = aconnector->dc_link;
 	int bl_idx = dm->num_of_edps;
+	struct backlight_properties props = { 0 };
+	struct amdgpu_dm_backlight_caps *caps;
+	struct drm_connector *connector = &aconnector->base;
+	int ret;
 
 	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
 	    link->type == dc_connection_none)
@@ -675,6 +684,30 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 
 	amdgpu_dm_update_connector_ext_caps(aconnector);
 
+	/*
+	 * The property must exist before the device is registered. If ACPI
+	 * video should handle the backlight, leave it to
+	 * amdgpu_dm_register_backlight_device() to register the fallback.
+	 */
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) && acpi_video_backlight_use_native()) {
+		caps = &dm->backlight_caps[bl_idx];
+		amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() > 0,
+					       !(amdgpu_dc_debug_mask &
+						 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
+					       &props);
+		/* Start from the level the hardware is actually at */
+		ret = amdgpu_dm_backlight_get_level(dm, bl_idx);
+		if (ret >= 0 && ret <= props.max_brightness)
+			props.brightness = ret;
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      props.max_brightness,
+							      props.brightness);
+		if (!drm_WARN_ON(adev_to_drm(dm->adev), ret)) {
+			dm->brightness[bl_idx] = props.brightness;
+			dm->luminance[bl_idx] = true;
+		}
+	}
+
 	/* Offer ABM property when user didn't turn off by module parameter.
 	 * OLED panels are included to support CACP (Content Adaptive
 	 * Contrast and Power) feature via set_abm_level.
@@ -686,6 +719,44 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
 
+void amdgpu_dm_set_luminance(const struct drm_connector_state *state)
+{
+	struct amdgpu_dm_connector *aconnector =
+		to_amdgpu_dm_connector(state->connector);
+	struct amdgpu_display_manager *dm =
+		&drm_to_adev(state->connector->dev)->dm;
+	int bl_idx = aconnector->bl_idx;
+
+	if (bl_idx < 0)
+		return;
+
+	/*
+	 * The atomic helpers only call this when the luminance changed or a
+	 * modeset enabled the pipeline, where Display Core may have reset the
+	 * panel brightness, so always program the level.
+	 */
+	amdgpu_dm_backlight_set_level(dm, bl_idx, state->luminance);
+}
+
+/**
+ * amdgpu_dm_backlight_restore - reprogram the cached backlight levels
+ * @dm: display manager
+ *
+ * Display Core resets the panel brightness when it recovers from a GPU
+ * reset, so reapply the cached level of every panel whose backlight is
+ * controlled by the driver, either through a backlight class device or
+ * through the connector LUMINANCE property.
+ */
+void amdgpu_dm_backlight_restore(struct amdgpu_display_manager *dm)
+{
+	int i;
+
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (dm->backlight_dev[i] || dm->luminance[i])
+			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+	}
+}
+
 /**
  * DOC: panel power savings
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 891749322191c..69704e0ff5b25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -33,6 +33,7 @@ struct dc_stream_state;
 struct device;
 struct device_attribute;
 struct drm_connector;
+struct drm_connector_state;
 struct attribute_group;
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
@@ -47,6 +48,8 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 void amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 			    struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_set_luminance(const struct drm_connector_state *state);
+void amdgpu_dm_backlight_restore(struct amdgpu_display_manager *dm);
 void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector);
 bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 8db7956c01d32..71f7111dfb268 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1969,6 +1969,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 	if (aconnector->bl_idx != -1) {
 		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
+		dm->luminance[aconnector->bl_idx] = false;
 	}
 
 	if (aconnector->dc_em_sink)
@@ -2061,7 +2062,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 			return r;
 	}
 
-	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
+	if (!connector->luminance_property)
+		amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
@@ -2724,6 +2726,7 @@ amdgpu_dm_connector_helper_funcs = {
 	.get_modes = get_modes,
 	.mode_valid = amdgpu_dm_connector_mode_valid,
 	.atomic_check = amdgpu_dm_connector_atomic_check,
+	.set_luminance = amdgpu_dm_set_luminance,
 };
 
 int amdgpu_dm_convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 8fc1c2f997688..c33c121a19b25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -37,16 +37,39 @@ static const struct drm_connector_funcs dm_backlight_test_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static int dm_test_signal_to_connector_type(enum signal_type signal)
+{
+	switch (signal) {
+	case SIGNAL_TYPE_EDP:
+		return DRM_MODE_CONNECTOR_eDP;
+	case SIGNAL_TYPE_LVDS:
+		return DRM_MODE_CONNECTOR_LVDS;
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		return DRM_MODE_CONNECTOR_HDMIA;
+	default:
+		return DRM_MODE_CONNECTOR_Unknown;
+	}
+}
+
 static void setup_test_connector(struct kunit *test,
 				 struct dm_backlight_connector_fixture *fixture,
 				 int bl_idx, enum signal_type signal)
 {
-	fixture->adev = kunit_kzalloc(test, sizeof(*fixture->adev), GFP_KERNEL);
-	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector), GFP_KERNEL);
+	int ret;
+
+	fixture->adev = dm_kunit_alloc_adev(test);
+	ret = drmm_mode_config_init(&fixture->adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fixture->aconnector = dm_kunit_alloc_connector(test, fixture->adev, NULL);
 	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, fixture->adev);
-	KUNIT_ASSERT_NOT_NULL(test, fixture->aconnector);
 	KUNIT_ASSERT_NOT_NULL(test, fixture->link);
+	ret = drmm_connector_init(&fixture->adev->ddev,
+				  &fixture->aconnector->base,
+				  &dm_backlight_test_connector_funcs,
+				  dm_test_signal_to_connector_type(signal), NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&fixture->aconnector->base);
 
 	fixture->aconnector->bl_idx = bl_idx;
 	fixture->aconnector->dc_link = fixture->link;
@@ -483,12 +506,17 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
 	struct dc_link *link = dm_kunit_alloc_link(test);
 	struct drm_minor *primary;
 	unsigned int max;
+	int ret;
+
+	ret = drmm_mode_config_init(&adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
 	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, primary);
 	adev->ddev.primary = primary;
+	adev->dm.ddev = &adev->ddev;
 	adev->dm.backlight_link[0] = link;
 
 	aconnector = dm_kunit_alloc_connector(test, adev, link);
@@ -1667,7 +1695,6 @@ static void dm_test_should_create_sysfs_non_edp(struct kunit *test)
 
 	amdgpu_dm_set_abm_level_param(-1);
 	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_HDMI_TYPE_A);
-	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
 
 	KUNIT_EXPECT_FALSE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
 
@@ -1843,6 +1870,9 @@ static void dm_test_setup_backlight_device_oled_success(struct kunit *test)
 	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_EDP);
 	fixture.link->type = dc_connection_single;
 	fixture.link->dpcd_sink_ext_caps.bits.oled = 1;
+	setup_test_link_service(test, fixture.link);
+	fixture.link->dc->link_srv->edp_get_backlight_level_nits =
+		dm_test_get_backlight_level_nits;
 	dm = &fixture.adev->dm;
 	dm->adev = fixture.adev;
 	dm->num_of_edps = 0;
@@ -1872,6 +1902,7 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 	struct dc_link *link;
 	int saved_abm_level = amdgpu_dm_get_abm_level_param();
 	int saved_backlight = amdgpu_dm_get_backlight_param();
+	int abm_index;
 	int old_count;
 	int ret;
 
@@ -1890,25 +1921,44 @@ static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *t
 				   &dm_backlight_test_connector_funcs,
 				   DRM_MODE_CONNECTOR_eDP, NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&aconnector->base);
 
 	link = dm_kunit_alloc_link(test);
 	link->connector_signal = SIGNAL_TYPE_EDP;
 	link->type = dc_connection_single;
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_mid;
 	aconnector->dc_link = link;
 	aconnector->bl_idx = -1;
 	dm = &adev->dm;
 	dm->adev = adev;
 	dm->ddev = &adev->ddev;
 	old_count = aconnector->base.base.properties->count;
+	abm_index = old_count + IS_ENABLED(CONFIG_DRM_LUMINANCE);
 
 	amdgpu_dm_setup_backlight_device(dm, aconnector);
 
 	KUNIT_EXPECT_EQ(test, dm->num_of_edps, 1);
 	KUNIT_EXPECT_EQ(test, aconnector->bl_idx, 0);
-	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count, old_count + 1);
-	KUNIT_EXPECT_PTR_EQ(test, aconnector->base.base.properties->properties[old_count], prop);
-	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[old_count],
-			 (uint64_t)ABM_SYSFS_CONTROL);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count,
+			old_count + 1 + IS_ENABLED(CONFIG_DRM_LUMINANCE));
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		KUNIT_EXPECT_NOT_NULL(test,
+				      aconnector->base.luminance_property);
+		KUNIT_EXPECT_LE(test,
+				aconnector->base.state->luminance,
+				(uint64_t)MAX_BACKLIGHT_LEVEL);
+		/* Restores after reset/modeset must use the initial value */
+		KUNIT_EXPECT_EQ(test, dm->brightness[0],
+				aconnector->base.state->luminance);
+	}
+	KUNIT_EXPECT_EQ(test, dm->luminance[0],
+			IS_ENABLED(CONFIG_DRM_LUMINANCE));
+	KUNIT_EXPECT_PTR_EQ(test,
+			    aconnector->base.base.properties->properties[abm_index],
+			    prop);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[abm_index],
+			(uint64_t)ABM_SYSFS_CONTROL);
 
 	amdgpu_dm_set_backlight_param(saved_backlight);
 	amdgpu_dm_set_abm_level_param(saved_abm_level);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index f844b644bb776..7e9e8b1d0b10d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -20,6 +20,7 @@
 
 struct amdgpu_device *dm_kunit_alloc_adev(struct kunit *test)
 {
+	struct amdgpu_device *adev;
 	struct drm_device *drm;
 	struct device *dev;
 
@@ -32,7 +33,11 @@ struct amdgpu_device *dm_kunit_alloc_adev(struct kunit *test)
 						   DRIVER_MODESET | DRIVER_ATOMIC);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	return drm_to_adev(drm);
+	adev = drm_to_adev(drm);
+
+	mutex_init(&adev->dm.dc_lock);
+
+	return adev;
 }
 EXPORT_SYMBOL(dm_kunit_alloc_adev);
 

-- 
2.43.0

