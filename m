Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3D4CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9595410EC59;
	Thu, 28 May 2026 05:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZDwOTLG+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2538910EC56
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:50:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D28A60126;
 Thu, 28 May 2026 05:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B523E1F000E9;
 Thu, 28 May 2026 05:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779947408;
 bh=VM1wVLklo1n6ouoG5IwYQhBPuZGvaEU+VXi1kz7PjQQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZDwOTLG+MxZ8iMzhVGE4STvSvsyRHRYrLrSnQZDFRZ9UKFufo1iKz+NOp5bmVTyuW
 PhQwZfewETigOk3Y25vcfW+qW+OzcvuvWfpHDBSKtOuZd8OxghQBQYjLaq3u9Ho/+/
 84N2RX73bTuu92GRCXYNAXsrHFKRvynqyTB1XBq2hWEIcaVcMOq0UF0g1WcnJRd6Mr
 oHBwTDn8tALPRnACII9VhnPLuuHI7HoE/YhtaMPrwpouIgaHuUc9vTk9b0w6NWK0D0
 DSMdEQhUOheHXcecX8kjSa3uSUzZ4sMIssHWXvyob2Z9jgfwmnyGefkBvigjtwKj1w
 c6G6qeIOcVkaA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v4 5/9] drm/amd/display: Pass up errors reading actual
 brightness
Date: Thu, 28 May 2026 00:49:07 -0500
Message-ID: <20260528054911.1513208-6-superm1@kernel.org>
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
If the DC API fails to return actual brightness when backlight control
API requests it, then the wrong value may be returned.

[How]
Change return type of amdgpu_dm_backlight_get_level() to an integer
and pass an error code up to the caller.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c6539e203b92..b6f9188a7b36 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5441,7 +5441,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
+static int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 					 int bl_idx)
 {
 	int ret;
@@ -5455,14 +5455,14 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 		u32 avg, peak;
 
 		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
-			return dm->brightness[bl_idx];
+			return -EINVAL;
 		return convert_brightness_to_user(&caps, avg);
 	}
 
 	ret = dc_link_get_backlight_level(link);
 
 	if (ret == DC_ERROR_UNEXPECTED)
-		return dm->brightness[bl_idx];
+		return -EINVAL;
 
 	return convert_brightness_to_user(&caps, ret);
 }
@@ -5470,7 +5470,7 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i;
+	int i, ret;
 
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if (bd == dm->backlight_dev[i])
@@ -5478,7 +5478,12 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 	}
 	if (i >= AMDGPU_DM_MAX_NUM_EDP)
 		i = 0;
-	return amdgpu_dm_backlight_get_level(dm, i);
+
+	ret = amdgpu_dm_backlight_get_level(dm, i);
+	if (ret < 0)
+		return dm->brightness[i];
+
+	return ret;
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
-- 
2.54.0

