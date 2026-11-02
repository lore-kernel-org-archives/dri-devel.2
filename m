Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210B6076716
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhOtx3Fm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CBA10E676;
	Mon,  2 Nov 2026 16:49:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D2210E676;
 Mon,  2 Nov 2026 16:49:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F07760C08;
 Mon,  2 Nov 2026 16:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604F71F00A1A;
 Mon,  2 Nov 2026 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638173;
 bh=cvbBm4Tp3/ViJKgby3dRF7WjDg9OW1cC4hM7fJo8a3M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WhOtx3Fm6Hv32lNSjNjq810YCZ3Pa4vOYTu30yq1tvSCDlN4J7gqTXEMjGbMbFUxz
 HE9BEt5A+QDNKrUMcgyqDKdRXjBetosn6IgcIwrj9yjvkshs7wS0grdP8eRjB4LtbI
 DU6is3Jd87W4dI8F/MeDlZKZE8LAPJiHvcEh6d20sf0ogzNsAHk8vGNkB2qDDKGDyx
 GhqUBenu5GT/YsEdkI3gysDLEFDeyafwgMmLnHCu9xoIeue1yWwS55RgScIuSbL8SH
 KpRWsZRa3l9b6QHmh8q9H9ajIl2UI35Wfo2VtA4Sp+d2kHj0pJ7lk5CGSE6t06mHPm
 sdAACQ6j/hn9Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 10:49:18 -0600
Subject: [PATCH v10 02/15] drm/amd/display: Pass up errors reading actual
 brightness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-superm1-backlight-property-v10-2-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
In-Reply-To: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
If the DC API fails to return actual brightness when backlight control
API requests it, then the wrong value may be returned.

[How]
Change return type of amdgpu_dm_backlight_get_level() to an integer
and pass an error code up to the caller.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 13 +++++++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h |  2 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c  |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index cb74b00723fda..0f664c658a127 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -438,7 +438,7 @@ int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
 STATIC_IFN_KUNIT
-u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
+int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 {
 	int ret;
 	struct amdgpu_dm_backlight_caps caps;
@@ -451,14 +451,14 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
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
@@ -469,8 +469,13 @@ int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
 	int i = amdgpu_dm_backlight_get_device_index(dm, bd);
+	int ret;
+
+	ret = amdgpu_dm_backlight_get_level(dm, i);
+	if (ret < 0)
+		return dm->brightness[i];
 
-	return amdgpu_dm_backlight_get_level(dm, i);
+	return ret;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_brightness);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 9ad888d3ae7b2..891749322191c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -57,7 +57,7 @@ void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl
 struct dc_stream_state *dm_find_stream_with_link(struct amdgpu_display_manager *dm,
 						 struct dc_link *link);
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd);
-u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx);
+int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx);
 int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd);
 ssize_t panel_power_savings_show(struct device *device,
 				 struct device_attribute *attr,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 5221050dec2f1..b21850788f36f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -382,7 +382,7 @@ static void dm_test_backlight_get_level_pwm_error(struct kunit *test)
 	dm->brightness[0] = 4321;
 	dm->backlight_link[0] = link;
 
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 4321U);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), -EINVAL);
 }
 
 /**
@@ -424,7 +424,7 @@ static void dm_test_backlight_get_level_aux_error(struct kunit *test)
 	caps->caps_valid = true;
 	caps->aux_support = true;
 
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 6789U);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), -EINVAL);
 }
 
 /**

-- 
2.53.0

