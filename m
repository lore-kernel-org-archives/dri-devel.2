Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C4606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=N5BC+80M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54FF10FDE1;
	Wed, 11 Nov 2026 16:09:29 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943CD10FD69;
 Wed, 11 Nov 2026 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=OaihiIEMF7+13xBp4Kj+CfcOOd15OQoUSx5DNDHnv8A=;
 t=1794413346; x=2109773346; b=N5BC+80MK2H9oVKW9FT8YG3S8lTaOSAYrUlnJEYBOJyC7gj
 bqJxSlbouQTivHCcNxOy+FKE2IKfzxyVY995HQjvEoekSkaTdSvua2yC7dwd93D/HSW67IeW8K3s2
 k5dIDgoSRiaywNSdP44ReN9aOUpggWhjCkXFE7O4PCZjBRhvcsdop9Fh13ox6/iz4m36L3ZAOt+6A
 PdkT19eh54c8i8I4suntubLi8N+GtY4abUkDYPjIhkhBIZRSBWM091UGtSwzvmAwW0mLXxkg8aOjN
 cUCMnykCJTZGodmMrZ3kEJpKw+xZKuIpN1+ptgoYfm/NK0ya579iMtzpaG5I85KA==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsP-008u8Y-To; Wed, 11 Nov 2026 17:08:45 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 John Harrison <John.Harrison@igalia.com>
Subject: [PATCH v5 15/15] drm/amd/display: distinguish colorop setup error
 from no colorop support
Date: Wed, 11 Nov 2026 17:05:28 +0100
Message-ID: <20261111160814.21326-16-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160814.21326-1-mwen@igalia.com>
References: <20261111160814.21326-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_dm_plane_set_colorop_properties() returns -EINVAL both when the
plane has no color pipeline selected, where falling back to the legacy
color properties is correct, and when programming an active pipeline
fails, so the caller treats every failure as the former and silently
programs the plane from the legacy properties, leaving it in a mixed
state and userspace with no error. Check if plane_state->color_pipeline
is set instead, so the legacy path is only taken when no pipeline is set
and any other failure is propagated out of the atomic check. Update
AMD KUnit color tests accordingly.

Fixes: 9ba25915efba ("drm/amd/display: Add support for sRGB EOTF in DEGAM block")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c |  8 ++++----
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c      | 17 +++++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 7332c8874397..3bc4cbe820c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -2009,10 +2009,10 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	int ret;
 
-	/* Fixed Matrix (YUV to RGB) */
-	if (!colorop)
+	if (drm_WARN_ON(dev, !colorop))
 		return -EINVAL;
 
+	/* Fixed Matrix (YUV to RGB) */
 	ret = __set_dm_plane_colorop_fixed_matrix(plane_state, dc_plane_state, colorop);
 	if (ret)
 		return ret;
@@ -2194,8 +2194,8 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
 	}
 
-	if (!amdgpu_dm_plane_set_colorop_properties(plane_state, dc_plane_state))
-		return 0;
+	if (plane_state->color_pipeline)
+		return amdgpu_dm_plane_set_colorop_properties(plane_state, dc_plane_state);
 
 	return amdgpu_dm_plane_set_color_properties(plane_state, dc_plane_state);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 8e00da61a04b..61543a3026e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -2539,7 +2539,7 @@ static void dm_test_update_plane_color_mgmt_colorop_bypass_pipeline(struct kunit
 }
 
 /**
- * dm_test_update_plane_color_mgmt_colorop_missing_multiplier - missing multiplier op falls back
+ * dm_test_update_plane_color_mgmt_colorop_missing_multiplier - missing multiplier op is rejected
  * @test: KUnit test context
  */
 static void dm_test_update_plane_color_mgmt_colorop_missing_multiplier(struct kunit *test)
@@ -2560,13 +2560,13 @@ static void dm_test_update_plane_color_mgmt_colorop_missing_multiplier(struct ku
 
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
-			0);
+			-EINVAL);
 	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
 	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
 }
 
 /**
- * dm_test_update_plane_color_mgmt_colorop_missing_3x4 - missing 3x4 op falls back
+ * dm_test_update_plane_color_mgmt_colorop_missing_3x4 - missing 3x4 op is rejected
  * @test: KUnit test context
  */
 static void dm_test_update_plane_color_mgmt_colorop_missing_3x4(struct kunit *test)
@@ -2589,13 +2589,13 @@ static void dm_test_update_plane_color_mgmt_colorop_missing_3x4(struct kunit *te
 
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_update_plane_color_mgmt(f.crtc_state, &f.dm_plane_state->base, f.dc_plane_state),
-			0);
+			-EINVAL);
 	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
 	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
 }
 
 /**
- * dm_test_update_plane_color_mgmt_colorop_truncated - truncated pipelines fall back
+ * dm_test_update_plane_color_mgmt_colorop_truncated - truncated pipelines are rejected
  * @test: KUnit test context
  *
  * Covers each pipeline exit after the 3x4 matrix while all present colorops
@@ -2640,7 +2640,8 @@ static void dm_test_update_plane_color_mgmt_colorop_truncated(struct kunit *test
 		memset(f.dc_plane_state, 0, sizeof(*f.dc_plane_state));
 
 		ret = amdgpu_dm_update_plane_color_mgmt(crtc_state, plane_state, dc_plane_state);
-		KUNIT_EXPECT_EQ_MSG(test, ret, 0, "pipeline length %d should fall back", count);
+		KUNIT_EXPECT_EQ_MSG(test, ret, -EINVAL,
+				    "pipeline length %d should be rejected", count);
 		KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.shaper_enable);
 		KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
 		KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.blend_enable);
@@ -2810,7 +2811,7 @@ static void dm_test_update_plane_color_mgmt_colorop_3dlut(struct kunit *test)
 }
 
 /**
- * dm_test_update_plane_color_mgmt_colorop_3dlut_no_data - empty 3D LUT falls back
+ * dm_test_update_plane_color_mgmt_colorop_3dlut_no_data - active 3D LUT without data is rejected
  * @test: KUnit test context
  */
 static void dm_test_update_plane_color_mgmt_colorop_3dlut_no_data(struct kunit *test)
@@ -2851,7 +2852,7 @@ static void dm_test_update_plane_color_mgmt_colorop_3dlut_no_data(struct kunit *
 
 	ret = amdgpu_dm_update_plane_color_mgmt(f.crtc_state, plane_state,
 						f.dc_plane_state);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
 	KUNIT_EXPECT_FALSE(test, f.dc_plane_state->cm.flags.bits.lut3d_enable);
 }
 
-- 
2.53.0

