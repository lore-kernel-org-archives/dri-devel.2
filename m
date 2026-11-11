Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A510606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=X5Ekwrqx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A09910FD5D;
	Wed, 11 Nov 2026 16:09:01 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DFFB10FD2E;
 Wed, 11 Nov 2026 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=ahgdmGX1NnxGKma3T6uHxi+lbLDI5gQToqr2EieprXo=;
 t=1794413332; x=2109773332; b=X5EkwrqxPz7uo0kZEANDt94P6vvIope3v3UxwA6ntnk/cYq
 o636/Jh53U8GJo3kVw8p7crbFmyxv975dOZ0ZtXwb8FQ5aZxyrhSvWyw11fOcLzlZteFbZl7KVcm1
 jFkP1VQ3EheyLFqE8GKYGNc0DFr39ssj0EaCgQL3eHB+hbQQ9JMtHHdVdXmUA9eAYHPERQSJp3PIx
 jrIejDEEqc5bOPtDLITe7vXNS+nMgqavHMEZM3U11KbC5rGsqEcdNRviX1FKxXQHt+QXrUyQrz9Lm
 vrdzK7ky3Ah1OpWrEaTdyRimQtGRAkqlcjzV3kilIm0G2WAVMhmTbfAQyqA3Werw==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsA-008u8Y-5A; Wed, 11 Nov 2026 17:08:30 +0100
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
 John Harrison <John.Harrison@igalia.com>,
 John Harrison <John.Harrison@Igalia.com>
Subject: [PATCH v5 01/15] drm/amd/display: Update colorop pipeline tests for
 new fixed matrix op
Date: Wed, 11 Nov 2026 17:05:14 +0100
Message-ID: <20261111160814.21326-2-mwen@igalia.com>
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

From: John Harrison <John.Harrison@Igalia.com>

A bunch of tests verify that the pipeline created by the driver
matches an expected pipeline hard coded into the test. The below patch
added a new op into the driver's pipeline but did not update the tests
to match. So add it in.

Fixes: 6d103ad11583 ("drm/amd/display: Add fixed matrix colorop to color pipeline")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
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
2.53.0

