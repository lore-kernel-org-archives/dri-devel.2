Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DD5CD6E53
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 11:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B127B112AF4;
	Sun, 31 May 2026 11:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BQrf/V8b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D30112AE9;
 Sun, 31 May 2026 11:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35DA56012A;
 Sun, 31 May 2026 11:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E271F00898;
 Sun, 31 May 2026 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780228158;
 bh=errEbvgeXyBw0TvYlf2J0dLvisFcz0ashprEBAn44NM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BQrf/V8bG1c3mJodgwl+Znxso6+uUgvH57BPFs4cJbdxLVRJCoEZZoHrZCuinR3Gh
 lkahSoGTvtG/GKfXkfMury/5J+3iUBIC1O4Vpv8WVvKGlXl4P+tACpoF8MEC5Jyl6m
 A39KqhN0wi3BQNEsUeONujEdIb2tO9rGbeWA8SJ4awo8yWgCRlATkIUdSZsXh1yjgq
 iEUJ+7wS+i7zWg6nhsVZ8VR8REgRGhBFOgdi9C1pVWIgMtvbVOY/MQi6rY0zVGLy2c
 iDNhQzYFoAndBk36uiKd8NCdM2CVZ1SGqjHyYbkEGUikWUu8qQ+5efNa3RBduVLPZu
 IqGlbBQF4kprg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 05/11] drm/amd/display: Pass up errors reading actual
 brightness
Date: Sun, 31 May 2026 06:49:02 -0500
Message-ID: <20260531114908.1693426-6-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531114908.1693426-1-superm1@kernel.org>
References: <20260531114908.1693426-1-superm1@kernel.org>
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
index d99617c9bbb9..de9b29ad6cab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5427,7 +5427,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
+static int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 					 int bl_idx)
 {
 	int ret;
@@ -5441,14 +5441,14 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
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
@@ -5456,7 +5456,7 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i;
+	int i, ret;
 
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if (bd == dm->backlight_dev[i])
@@ -5464,7 +5464,12 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
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

