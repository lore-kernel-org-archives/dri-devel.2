Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9932C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B9D10E699;
	Tue, 15 Sep 2026 20:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gYE9Qded";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A309410E699;
 Tue, 15 Sep 2026 20:10:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5609C40F00;
 Tue, 15 Sep 2026 20:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E541F000FF;
 Tue, 15 Sep 2026 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789503014;
 bh=zTdmCvT/LodVy49e6H1NylhI2+YP6sAK6mN2yIy2bnY=;
 h=From:To:Cc:Subject:Date;
 b=gYE9QdedSLB3Gr1CMO30FyGSRgJCZz7pMbXaOaUkg1Uj93eU51/otdoK/E8FTa04K
 2+h+7GYI4XIeOTO6oKPh+27q8XhFjDAzAhz1vWoF3lOSR3YpKb0777JEFDoUWGhxXw
 8sOjNu3TXtR+gczhzWqIuxV/YGueYRpQG0mcXRPRctgq1GWMxvTdNMpYx7Ul9uFfDc
 EIcLoO5sI8d9haNGSyPeyceR5GXAqG3BHDeSpjli2E352ASrhUPMW8ea8mqoTFX4DC
 PJUdsv59pYFrLofmCLbWCFMg/grhqX6ssgYK8rEfDQYuB4bO3gCaVxYYVMesFLvav6
 sbgjlshqXNQpw==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Alex Huang <Alex.Huang2@amd.com>, Alex Hung <alex.hung@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu <ray.wu@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rodrigo Siqueira <siqueira@igalia.com>,
 George Zhang <george.zhang@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove parse_edid_cea function, harder
Date: Tue, 15 Sep 2026 22:09:02 +0200
Message-ID: <20260915201006.3526945-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
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

From: Arnd Bergmann <arnd@arndb.de>

These functions were removed already in the past, but came back
in a mismerge against a branch that added pointless unit tests
for the unused functions.

Remove both the unused functions and the unit tests.

Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from common EDID parser")
Fixes: 0412b1064a3b ("drm/amd/display: Cover EDID CEA parsing helpers")
Fixes: 1bb4c385d6f7 ("Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux.git")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
As far as I can tell, the mismerge is currently only in linux-next,
but the fix may need to be in the amdgpu tree
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 101 -------
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  10 -
 .../tests/amdgpu_dm_connector_test.c          | 264 ------------------
 3 files changed, 375 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index d76ebf145dfc..37d1508d656b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3603,107 +3603,6 @@ void dm_restore_drm_connector_state(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(dm_restore_drm_connector_state);
 
-STATIC_IFN_KUNIT bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
-		unsigned int offset,
-		unsigned int total_length,
-		u8 *data,
-		unsigned int length,
-		struct amdgpu_hdmi_vsdb_info *vsdb)
-{
-	bool res;
-	union dmub_rb_cmd cmd;
-	struct dmub_cmd_send_edid_cea *input;
-	struct dmub_cmd_edid_cea_output *output;
-
-	if (length > DMUB_EDID_CEA_DATA_CHUNK_BYTES)
-		return false;
-
-	memset(&cmd, 0, sizeof(cmd));
-
-	input = &cmd.edid_cea.data.input;
-
-	cmd.edid_cea.header.type = DMUB_CMD__EDID_CEA;
-	cmd.edid_cea.header.sub_type = 0;
-	cmd.edid_cea.header.payload_bytes =
-		sizeof(cmd.edid_cea) - sizeof(cmd.edid_cea.header);
-	input->offset = offset;
-	input->length = length;
-	input->cea_total_length = total_length;
-	memcpy(input->payload, data, length);
-
-	res = dc_wake_and_execute_dmub_cmd(dm->dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
-	if (!res) {
-		drm_err(adev_to_drm(dm->adev), "EDID CEA parser failed\n");
-		return false;
-	}
-
-	output = &cmd.edid_cea.data.output;
-
-	if (output->type == DMUB_CMD__EDID_CEA_ACK) {
-		if (!output->ack.success) {
-			drm_err(adev_to_drm(dm->adev), "EDID CEA ack failed at offset %d\n",
-					output->ack.offset);
-		}
-	} else if (output->type == DMUB_CMD__EDID_CEA_AMD_VSDB) {
-		if (!output->amd_vsdb.vsdb_found)
-			return false;
-
-		vsdb->freesync_supported = output->amd_vsdb.freesync_supported;
-		vsdb->amd_vsdb_version = output->amd_vsdb.amd_vsdb_version;
-		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
-		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
-		vsdb->freesync_mccs_vcp_code = output->amd_vsdb.freesync_mccs_vcp_code;
-	} else {
-		drm_warn(adev_to_drm(dm->adev), "Unknown EDID CEA parser results\n");
-		return false;
-	}
-
-	return true;
-}
-EXPORT_IF_KUNIT(dm_edid_parser_send_cea);
-
-STATIC_IFN_KUNIT bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
-		u8 *edid_ext, int len,
-		struct amdgpu_hdmi_vsdb_info *vsdb_info)
-{
-	return false;
-}
-EXPORT_IF_KUNIT(parse_edid_cea_dmcu);
-
-STATIC_IFN_KUNIT bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
-		u8 *edid_ext, int len,
-		struct amdgpu_hdmi_vsdb_info *vsdb_info)
-{
-	int i;
-
-	/* send extension block to DMCU for parsing */
-	for (i = 0; i < len; i += 8) {
-		/* send 8 bytes a time */
-		if (!dm_edid_parser_send_cea(dm, i, len, &edid_ext[i], 8, vsdb_info))
-			return false;
-	}
-
-	return vsdb_info->freesync_supported;
-}
-EXPORT_IF_KUNIT(parse_edid_cea_dmub);
-
-STATIC_IFN_KUNIT bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
-		u8 *edid_ext, int len,
-		struct amdgpu_hdmi_vsdb_info *vsdb_info)
-{
-	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
-	bool ret;
-
-	mutex_lock(&adev->dm.dc_lock);
-	if (adev->dm.dmub_srv)
-		ret = parse_edid_cea_dmub(&adev->dm, edid_ext, len, vsdb_info);
-	else
-		ret = parse_edid_cea_dmcu(&adev->dm, edid_ext, len, vsdb_info);
-	mutex_unlock(&adev->dm.dc_lock);
-	return ret;
-}
-EXPORT_IF_KUNIT(parse_edid_cea);
-
 STATIC_IFN_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
 				     const struct edid *edid)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index e42a0d53b549..6732e5e644cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -158,16 +158,6 @@ int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			const struct edid *edid,
 			struct amdgpu_hdmi_vsdb_info *vsdb_info);
-bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
-			     unsigned int offset, unsigned int total_length,
-			     u8 *data, unsigned int length,
-			     struct amdgpu_hdmi_vsdb_info *vsdb);
-bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm, u8 *edid_ext,
-			 int len, struct amdgpu_hdmi_vsdb_info *vsdb_info);
-bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm, u8 *edid_ext,
-			 int len, struct amdgpu_hdmi_vsdb_info *vsdb_info);
-bool parse_edid_cea(struct amdgpu_dm_connector *aconnector, u8 *edid_ext,
-		    int len, struct amdgpu_hdmi_vsdb_info *vsdb_info);
 void amdgpu_dm_connector_funcs_force(struct drm_connector *connector);
 enum dc_status dm_validate_stream_and_context(struct dc *dc,
 					      struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 19ead11b5e73..7b6400ec8107 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -6134,259 +6134,6 @@ static void dm_test_restore_state_same_sink(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, stream->sink, aconnector->dc_sink);
 }
 
-/* Mock DMCU plumbing for parse_edid_cea_dmcu() tests. */
-static bool dm_test_dmcu_is_init(struct dmcu *dmcu)
-{
-	return true;
-}
-
-static const struct dmcu_funcs dm_test_dmcu_funcs_vsdb = {
-	.is_dmcu_initialized = dm_test_dmcu_is_init,
-};
-
-static const struct dmcu_funcs dm_test_dmcu_funcs_novsdb = {
-	.is_dmcu_initialized = dm_test_dmcu_is_init,
-};
-
-static const struct dmcu_funcs dm_test_dmcu_funcs_ackfail = {
-	.is_dmcu_initialized = dm_test_dmcu_is_init,
-};
-
-/*
- * Build a bare display manager carrying a dc with a resource pool whose DMCU
- * uses the supplied funcs table (or no DMCU at all when @funcs is NULL). The
- * DMCU CEA parser path only touches dm->dc->res_pool->dmcu, so no adev/ctx is
- * required.
- */
-static struct amdgpu_display_manager *
-dm_test_alloc_dm_dmcu(struct kunit *test, const struct dmcu_funcs *funcs)
-{
-	struct amdgpu_display_manager *dm;
-	struct resource_pool *pool;
-	struct dmcu *dmcu = NULL;
-	struct dc *dc;
-
-	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm);
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, pool);
-
-	if (funcs) {
-		dmcu = kunit_kzalloc(test, sizeof(*dmcu), GFP_KERNEL);
-		KUNIT_ASSERT_NOT_NULL(test, dmcu);
-		dmcu->funcs = funcs;
-	}
-
-	pool->dmcu = dmcu;
-	dc->res_pool = pool;
-	dm->dc = dc;
-	return dm;
-}
-
-/*
- * Build a display manager backed by an amdgpu_device and a dc with a ctx (but
- * no DMUB), so the DMUB CEA send path can build a command, fail the execute,
- * and log via drm_err() safely.
- */
-static struct amdgpu_display_manager *dm_test_alloc_dm_adev(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
-
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	adev->dm.adev = adev;
-	adev->dm.dc = dc;
-	return &adev->dm;
-}
-
-/**
- * dm_test_send_cea_length_too_long - Test an oversized chunk is rejected
- * @test: KUnit test context
- */
-static void dm_test_send_cea_length_too_long(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm = dm_test_alloc_dm_adev(test);
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 data[16] = {0};
-	bool ret;
-
-	ret = dm_edid_parser_send_cea(dm, 0, 128, data,
-				      DMUB_EDID_CEA_DATA_CHUNK_BYTES + 1, &vsdb);
-	KUNIT_EXPECT_FALSE(test, ret);
-}
-
-/**
- * dm_test_send_cea_dmub_unavailable - Test a failed DMUB command reports false
- * @test: KUnit test context
- */
-static void dm_test_send_cea_dmub_unavailable(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm = dm_test_alloc_dm_adev(test);
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 data[DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
-	bool ret;
-
-	/* ctx->dmub_srv is NULL, so the DMUB command execute fails. */
-	ret = dm_edid_parser_send_cea(dm, 0, 8, data,
-				      DMUB_EDID_CEA_DATA_CHUNK_BYTES, &vsdb);
-	KUNIT_EXPECT_FALSE(test, ret);
-}
-
-/**
- * dm_test_parse_cea_dmcu_empty - Test an empty extension parses to no VSDB
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_dmcu_empty(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm = dm_test_alloc_dm_dmcu(test, NULL);
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 ext[1] = {0};
-
-	KUNIT_EXPECT_FALSE(test, parse_edid_cea_dmcu(dm, ext, 0, &vsdb));
-}
-
-/**
- * dm_test_parse_cea_dmcu_no_dmcu - Test a missing DMCU fails the first send
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_dmcu_no_dmcu(struct kunit *test)
-{
-}
-
-/**
- * dm_test_parse_cea_dmcu_vsdb_none - Test the DMCU finds no AMD VSDB
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_dmcu_vsdb_none(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm =
-		dm_test_alloc_dm_dmcu(test, &dm_test_dmcu_funcs_novsdb);
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 ext[DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
-	bool ret;
-
-	ret = parse_edid_cea_dmcu(dm, ext, DMUB_EDID_CEA_DATA_CHUNK_BYTES,
-				  &vsdb);
-	KUNIT_EXPECT_FALSE(test, ret);
-}
-
-/**
- * dm_test_parse_cea_dmcu_multi_chunk - Test intermediate chunks are acked
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_dmcu_multi_chunk(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm =
-		dm_test_alloc_dm_dmcu(test, &dm_test_dmcu_funcs_vsdb);
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 ext[2 * DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
-	bool ret;
-
-	ret = parse_edid_cea_dmcu(dm, ext, 2 * DMUB_EDID_CEA_DATA_CHUNK_BYTES,
-				  &vsdb);
-	KUNIT_EXPECT_TRUE(test, ret);
-}
-
-/**
- * dm_test_parse_cea_dmcu_ack_fail - Test a failed chunk ack aborts the parse
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_dmcu_ack_fail(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm =
-		dm_test_alloc_dm_dmcu(test, &dm_test_dmcu_funcs_ackfail);
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 ext[2 * DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
-	bool ret;
-
-	ret = parse_edid_cea_dmcu(dm, ext, 2 * DMUB_EDID_CEA_DATA_CHUNK_BYTES,
-				  &vsdb);
-	KUNIT_EXPECT_FALSE(test, ret);
-}
-
-/**
- * dm_test_parse_cea_dmub_empty - Test an empty extension returns the flag
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_dmub_empty(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm = dm_test_alloc_dm_adev(test);
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 ext[1] = {0};
-
-	/* No chunks are sent, so the freesync flag is returned as-is. */
-	vsdb.freesync_supported = true;
-	KUNIT_EXPECT_TRUE(test, parse_edid_cea_dmub(dm, ext, 0, &vsdb));
-}
-
-/**
- * dm_test_parse_cea_dmub_send_fail - Test a chunk send failure aborts the parse
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_dmub_send_fail(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm = dm_test_alloc_dm_adev(test);
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 ext[DMUB_EDID_CEA_DATA_CHUNK_BYTES] = {0};
-	bool ret;
-
-	/* The first chunk send fails (no DMUB), so the parse bails out. */
-	ret = parse_edid_cea_dmub(dm, ext, DMUB_EDID_CEA_DATA_CHUNK_BYTES,
-				  &vsdb);
-	KUNIT_EXPECT_FALSE(test, ret);
-}
-
-/**
- * dm_test_parse_cea_routes_dmub - Test a present dmub_srv routes to DMUB
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_routes_dmub(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct amdgpu_dm_connector *aconnector;
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 ext[1] = {0};
-
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	mutex_init(&adev->dm.dc_lock);
-	adev->dm.dmub_srv = kunit_kzalloc(test, 1, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dmub_srv);
-
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-	aconnector->base.dev = &adev->ddev;
-
-	/* len 0 routes to the DMUB parser, which returns the freesync flag. */
-	vsdb.freesync_supported = true;
-	KUNIT_EXPECT_TRUE(test, parse_edid_cea(aconnector, ext, 0, &vsdb));
-}
-
-/**
- * dm_test_parse_cea_routes_dmcu - Test a missing dmub_srv routes to DMCU
- * @test: KUnit test context
- */
-static void dm_test_parse_cea_routes_dmcu(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct amdgpu_dm_connector *aconnector;
-	struct amdgpu_hdmi_vsdb_info vsdb = {0};
-	u8 ext[1] = {0};
-
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	mutex_init(&adev->dm.dc_lock);
-	adev->dm.dmub_srv = NULL;
-
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-	aconnector->base.dev = &adev->ddev;
-
-	/* len 0 routes to the DMCU parser, which returns false. */
-	KUNIT_EXPECT_FALSE(test, parse_edid_cea(aconnector, ext, 0, &vsdb));
-}
-
 /**
  * dm_test_get_amd_vsdb_unsupported - Test a zero VSDB version reports no support
  * @test: The KUnit test context
@@ -9083,17 +8830,6 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_restore_state_no_encoder),
 	KUNIT_CASE(dm_test_restore_state_no_stream),
 	KUNIT_CASE(dm_test_restore_state_same_sink),
-	KUNIT_CASE(dm_test_send_cea_length_too_long),
-	KUNIT_CASE(dm_test_send_cea_dmub_unavailable),
-	KUNIT_CASE(dm_test_parse_cea_dmcu_empty),
-	KUNIT_CASE(dm_test_parse_cea_dmcu_no_dmcu),
-	KUNIT_CASE(dm_test_parse_cea_dmcu_vsdb_none),
-	KUNIT_CASE(dm_test_parse_cea_dmcu_multi_chunk),
-	KUNIT_CASE(dm_test_parse_cea_dmcu_ack_fail),
-	KUNIT_CASE(dm_test_parse_cea_dmub_empty),
-	KUNIT_CASE(dm_test_parse_cea_dmub_send_fail),
-	KUNIT_CASE(dm_test_parse_cea_routes_dmub),
-	KUNIT_CASE(dm_test_parse_cea_routes_dmcu),
 	/* get_amd_vsdb */
 	KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
 	KUNIT_CASE(dm_test_get_amd_vsdb_supported),
-- 
2.53.0

