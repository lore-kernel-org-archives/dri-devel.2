Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA82ECD6E45
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1CB10EC58;
	Thu, 28 May 2026 05:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QG/Wa/3N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5097E10EC56
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:50:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39E5040DBF;
 Thu, 28 May 2026 05:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A42C1F00A3C;
 Thu, 28 May 2026 05:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779947410;
 bh=fb8ByGM4LmV901cP/36s5mk74YBy+9mJmuHPxvNcozo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QG/Wa/3NK6v4d8CYjsRl6dpPdBhaEMsQpV5ni26+MEzAvB45eFWz1/rLTWUrJwLU8
 BDZnDK/FkNq0M7/CsecNKHKWxQaoA8EPOQdiXZrQwj0moSHXhiOZjbkXUMv5C4pSKB
 d8TytnJdzzsG2p+RwB1kK91RU+G5YGnHWb8/pXioVc/AEMpkrv0iNLfeSgatraFyvA
 ZZgK4Kwlydoj2tYHSxOWNyYnT4wtAje4bQVVINMI/LCeFuQaT/qPl9rVf1eQV5LYmM
 /4OoHi9H2ZVAPZ3Z7twjLEZWNHw5mNvoSLDatywUWU2tV/kHqHstKG8mAQaLrRCvIR
 fDdL23MdF65Ow==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v4 7/9] drm/amd/display: Allow backlight registration to fail
Date: Thu, 28 May 2026 00:49:09 -0500
Message-ID: <20260528054911.1513208-8-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528054911.1513208-1-superm1@kernel.org>
References: <20260528054911.1513208-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

[Why]
If backlight registration fails then it's ignored. This could hide
a fatal problem to a user.

[How]
Pass error codes up from backlight registration failures.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +++++++++++--------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b6f9188a7b36..97eec889b0aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5492,7 +5492,7 @@ static const struct backlight_ops amdgpu_dm_backlight_ops = {
 	.update_status	= amdgpu_dm_backlight_update_status,
 };
 
-static void
+static int
 amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_device *drm = aconnector->base.dev;
@@ -5503,15 +5503,16 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	int min, max;
 	int real_brightness;
 	int init_brightness;
+	int r;
 
 	if (aconnector->bl_idx == -1)
-		return;
+		return 0;
 
 	if (!acpi_video_backlight_use_native()) {
 		drm_info(drm, "Skipping amdgpu DM backlight registration\n");
 		/* Try registering an ACPI video backlight device instead. */
 		acpi_video_register_backlight();
-		return;
+		return 0;
 	}
 
 	caps = &dm->backlight_caps[aconnector->bl_idx];
@@ -5545,22 +5546,26 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	dm->brightness[aconnector->bl_idx] = props.brightness;
 
 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
-		drm_err(drm, "DM: Backlight registration failed!\n");
+		r = PTR_ERR(dm->backlight_dev[aconnector->bl_idx]);
+		drm_err(drm, "DM: Backlight registration failed: %d\n", r);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
-	} else {
-		/*
-		 * dm->brightness[x] can be inconsistent just after startup until
-		 * ops.get_brightness is called.
-		 */
-		real_brightness =
-			amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
+		return r;
+	}
 
-		if (real_brightness != init_brightness) {
-			dm->actual_brightness[aconnector->bl_idx] = real_brightness;
-			dm->brightness[aconnector->bl_idx] = real_brightness;
-		}
-		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
+	/*
+	 * dm->brightness[x] can be inconsistent just after startup until
+	 * ops.get_brightness is called.
+	 */
+	real_brightness =
+		amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
+
+	if (real_brightness != init_brightness) {
+		dm->actual_brightness[aconnector->bl_idx] = real_brightness;
+		dm->brightness[aconnector->bl_idx] = real_brightness;
 	}
+	drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
+
+	return 0;
 }
 
 static int initialize_plane(struct amdgpu_display_manager *dm,
@@ -8411,7 +8416,9 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 			return r;
 	}
 
-	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
+	r = amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
+	if (r)
+		return r;
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
-- 
2.54.0

