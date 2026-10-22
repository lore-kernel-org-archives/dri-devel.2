Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF6606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VSkIJ4pV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8E7112854;
	Thu, 22 Oct 2026 17:37:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6DC10E452;
 Thu, 22 Oct 2026 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=VuOF9IF+st0KOU68En0/qYK7S5CSIkMh9BXiGMzbD10=; b=
 VSkIJ4pVp7wz2/DlkHtTd74J3ZFx8+t9Buf9Krs+UGRQ553XdrNpYwUQHcK6x7LscM8/feoNadmSo
 nN92aIcvgKIMnJaoXwwevuXqoslY7nqGq/jXxVCQ/k6LAvMcWj5gXBEgmVVw0CX/691+Zeg6DP31X
 Xs5tuSZ4V+zeAzz9jXEoz7ehj8/bbJjOJ9SQVQA1A6m6U0b7kcaqaAVwaDN6Qojl4Vi90RRThFxNI
 wxvi4zGZoHv2g0GArJAkHQ8RTU3tfL55n4/+UmEeywGZUgRNiepgbYqXxRBZcRS8Xw931W+NjVZWn
 mIYN5J7/rUnZaVHC+lO+7XsJ5+3rwX7LJw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJwj1-0071Z2-9P; Thu, 22 Oct 2026 19:37:11 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 3/3] drm/amd/display: Update colorop pipeline tests for new
 fixed matrix op
Date: Thu, 22 Oct 2026 10:36:55 -0700
Message-ID: <20261022173655.2318987-4-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022173655.2318987-1-John.Harrison@Igalia.com>
References: <20261022173655.2318987-1-John.Harrison@Igalia.com>
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

A bunch of tests verify that the pipeline created by the driver
matches an expected pipeline hard coded into the test. The below patch
added a new op into the driver's pipeline but did not update the tests
to match. So add it in.

Fixes: 6d103ad11583 ("drm/amd/display: Add fixed matrix colorop to color pipeline")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 90cc5592ef5d..00f1d5b33b1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -192,6 +192,7 @@ static void dm_expect_colorop_pipeline(struct kunit *test, struct drm_device *dr
 static void dm_test_initialize_default_pipeline(struct kunit *test)
 {
 	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_FIXED_MATRIX,
 		DRM_COLOROP_1D_CURVE,	/* degam TF */
 		DRM_COLOROP_MULTIPLIER,
 		DRM_COLOROP_CTM_3X4,
@@ -257,6 +258,7 @@ static void dm_test_initialize_default_pipeline_caps(struct kunit *test,
 static void dm_test_initialize_default_pipeline_dpp_3d_lut(struct kunit *test)
 {
 	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_FIXED_MATRIX,
 		DRM_COLOROP_1D_CURVE,
 		DRM_COLOROP_MULTIPLIER,
 		DRM_COLOROP_CTM_3X4,
@@ -278,6 +280,7 @@ static void dm_test_initialize_default_pipeline_dpp_3d_lut(struct kunit *test)
 static void dm_test_initialize_default_pipeline_mpc_preblend(struct kunit *test)
 {
 	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_FIXED_MATRIX,
 		DRM_COLOROP_1D_CURVE,
 		DRM_COLOROP_MULTIPLIER,
 		DRM_COLOROP_CTM_3X4,
@@ -299,6 +302,7 @@ static void dm_test_initialize_default_pipeline_mpc_preblend(struct kunit *test)
 static void dm_test_initialize_default_pipeline_no_3d_lut(struct kunit *test)
 {
 	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_FIXED_MATRIX,
 		DRM_COLOROP_1D_CURVE,
 		DRM_COLOROP_MULTIPLIER,
 		DRM_COLOROP_CTM_3X4,
-- 
2.43.0

