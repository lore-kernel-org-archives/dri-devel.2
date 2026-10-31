Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEE606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=QlMBxbyW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A94E10E9ED;
	Sun,  1 Nov 2026 12:00:44 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7669710E029;
 Sat, 31 Oct 2026 14:33:56 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jH0p96d3jzKns0;
 Sat, 31 Oct 2026 15:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793457233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJxlWD63aBsqJYxjsMpskuAarA2LuQHZe+BxsUgGNdk=;
 b=QlMBxbyWN/sCO7MqyUVkdEO72SoGJSRzibe78vkhI7vch95b0USADPTeX71/5pZu9dzvQm
 u8ZN7hC2xAw15sXAhqbbPpwtfxvgta/c8lPhV5zEMQpZ//bapB9gW7QsSc1y0qhYec0Vbi
 l0anjli0zixULwuZeu0sjESQx4i4CRcNWs5bXYGHrsjIvAA2ag2uCvdHyIh2m195gjnUYS
 iDXIO5hbjUAnRL/g9c/zkOLWNV0KLYvcKJ0ei6riZoMyIZPWk/mcNcyDrGVa5ZtkyldQWx
 eKSJW/gT9mCReLoDhBPBIrGCF0XJg6jVQ1gNeg6ybqSJ5+p8N4k3FqDim48w/w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: alex.hung@amd.com, mario.kleiner.de@gmail.com, nicholas.kazlauskas@amd.com,
 ray.wu@amd.com, bhawanpreet.lakha@amd.com, ivan.lipski@amd.com,
 chiahsuan.chung@amd.com, jerry.zuo@amd.com, Aric.Cyr@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Hold the VRR vblank reference only on active
 CRTCs
Date: Sat, 31 Oct 2026 14:33:51 +0000
Message-ID: <20261031143351.3222033-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jH0p96d3jzKns0
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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

amdgpu_dm_handle_vrr_transition() takes a vblank reference when a CRTC
state turns VRR on and drops it when a later state turns it off. It only
looks at freesync_config.state, and disabling a CRTC keeps that state,
so a suspend or DPMS off with VRR active keeps the reference

On resume, drm_atomic_helper_resume() first calls drm_mode_config_reset(),
which swaps the CRTC state for a zeroed one. The restored state then goes
from VRR_STATE_UNSUPPORTED to active and takes a second reference, and
the first is never dropped. The vblank irq stays on for good, so the CRTC
never idles and PSR is never entered

A VRR change on a disabled CRTC can't take the reference at all, since
vblank is off there and drm_crtc_vblank_get() fails with a WARN

On a Cezanne laptop with VRR always on, each suspend added one to the
eDP CRTC's vblank refcount, and it stayed at 1 rather than 0 after VRR
was turned off again

Treat VRR as active for the reference only while the CRTC is active too.
Disabling the CRTC then drops it and enabling it takes it again, which
balances suspend, resume and DPMS, and the get only happens once
manage_dm_interrupts() has turned vblank on

Fixes: 66b0c973d7f7 ("drm/amd/display: Prevent vblank irq disable while VRR is active. (v3)")
Signed-off-by: Hugo Sales <hugo@hsal.es>
---

Tested on an ASUS ROG Flow X13 (GV301QH, Cezanne, DCN 2.1) with VRR
set to always on in Hyprland. bpftrace on drm_handle_vblank showed the eDP
CRTC's vblank refcount go up by one on every suspend before this patch.
With it, the refcount reads the same before and after a systemctl
suspend, and drops to 0 once VRR is turned off

dm_test_handle_vrr_transition_round_trip now sets base.active on both
states, since an inactive CRTC no longer takes the reference. The
three new cases cover the CRTC turning off and on with VRR left on

amdgpu_dm KUnit on amd-staging-drm-next (ba496bb83788) passes apart
from dm_mst_test_dsc_link_bpp_between_limits and the two
dm_test_crtc_enable_vblank_ips_restore cases, which fail or panic in
drm_vblank_restore() without this patch as well

 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 12 ++-
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 98 +++++++++++++++++++
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 386ba88c57c6a..ee8a11f62a0d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -414,8 +414,16 @@ void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 				     struct dm_crtc_state *new_state)
 {
 	struct amdgpu_device *adev = dm->adev;
-	bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
-	bool new_vrr_active = amdgpu_dm_crtc_vrr_active(new_state);
+	/*
+	 * A disabled CRTC keeps its freesync state, but drm_crtc_vblank_get()
+	 * fails there because vblank is off. Hold the reference only while
+	 * the CRTC is active as well, which also covers resume, where the
+	 * reset state lost track of the reference taken before suspend
+	 */
+	bool old_vrr_active = old_state->base.active &&
+			      amdgpu_dm_crtc_vrr_active(old_state);
+	bool new_vrr_active = new_state->base.active &&
+			      amdgpu_dm_crtc_vrr_active(new_state);
 
 	/* Only DCE gates vupdate on VRR, keep it enabled for DCN */
 	bool vrr_gates_vupdate = amdgpu_ip_version(adev, DCE_HWIP, 0) == 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 710cdc7f40bf8..3268bdb1043ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -855,8 +855,10 @@ static void dm_test_handle_vrr_transition_round_trip(struct kunit *test)
 	mutex_init(&adev->dm.dc_lock);
 
 	old_state.base.crtc = &acrtc->base;
+	old_state.base.active = true;
 	old_state.stream = stream;
 	new_state.base.crtc = &acrtc->base;
+	new_state.base.active = true;
 	new_state.stream = stream;
 	new_state.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
 
@@ -867,6 +869,99 @@ static void dm_test_handle_vrr_transition_round_trip(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 0);
 }
 
+/*
+ * Runs a transition on a CRTC whose vblank is on with two references held,
+ * so a get or put never has to enable or disable it, and returns the
+ * refcount afterwards
+ */
+static int dm_test_vrr_transition_refcount(struct kunit *test,
+					   bool old_active, enum mod_vrr_state old_vrr,
+					   bool new_active, enum mod_vrr_state new_vrr)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dm_crtc_state *old_state, *new_state;
+	struct drm_crtc *crtc;
+	int refcount;
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(2, 1, 0);
+	dm->adev = adev;
+	mutex_init(&dm->dc_lock);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_state);
+	old_state->base.crtc = crtc;
+	old_state->base.active = old_active;
+	old_state->freesync_config.state = old_vrr;
+	new_state->base.crtc = crtc;
+	new_state->base.active = new_active;
+	new_state->freesync_config.state = new_vrr;
+
+	adev->ddev.vblank[0].enabled = true;
+	atomic_set(&adev->ddev.vblank[0].refcount, 2);
+
+	amdgpu_dm_handle_vrr_transition(dm, old_state, new_state);
+	refcount = atomic_read(&adev->ddev.vblank[0].refcount);
+
+	/* drm_vblank_init_release() warns if vblank is still enabled */
+	adev->ddev.vblank[0].enabled = false;
+	atomic_set(&adev->ddev.vblank[0].refcount, 0);
+
+	return refcount;
+}
+
+/**
+ * dm_test_vrr_transition_crtc_off_drops_ref - Test disabling the CRTC drops the ref
+ * @test: The KUnit test context
+ *
+ * Disabling the CRTC keeps the freesync state, as on suspend or DPMS off.
+ * The reference must still be dropped, since resume restores the state from
+ * a reset one and takes a new reference
+ */
+static void dm_test_vrr_transition_crtc_off_drops_ref(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test,
+			dm_test_vrr_transition_refcount(test, true, VRR_STATE_ACTIVE_VARIABLE,
+							false, VRR_STATE_ACTIVE_VARIABLE),
+			1);
+}
+
+/**
+ * dm_test_vrr_transition_crtc_on_takes_ref - Test enabling the CRTC takes the ref
+ * @test: The KUnit test context
+ *
+ * Covers resume, where the old state is a reset one, and DPMS on
+ */
+static void dm_test_vrr_transition_crtc_on_takes_ref(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test,
+			dm_test_vrr_transition_refcount(test, false, VRR_STATE_UNSUPPORTED,
+							true, VRR_STATE_ACTIVE_VARIABLE),
+			3);
+}
+
+/**
+ * dm_test_vrr_transition_crtc_off_keeps_ref - Test no ref change while off
+ * @test: The KUnit test context
+ *
+ * A disabled CRTC has vblank off, so a VRR change there must neither take
+ * nor drop a reference
+ */
+static void dm_test_vrr_transition_crtc_off_keeps_ref(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test,
+			dm_test_vrr_transition_refcount(test, false, VRR_STATE_UNSUPPORTED,
+							false, VRR_STATE_ACTIVE_VARIABLE),
+			2);
+}
+
 static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	/* amdgpu_dm_is_timing_unchanged_for_freesync */
 	KUNIT_CASE(dm_test_timing_unchanged_null_args),
@@ -910,6 +1005,9 @@ static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	/* amdgpu_dm_handle_vrr_transition */
 	KUNIT_CASE(dm_test_handle_vrr_transition_inactive),
 	KUNIT_CASE(dm_test_handle_vrr_transition_round_trip),
+	KUNIT_CASE(dm_test_vrr_transition_crtc_off_drops_ref),
+	KUNIT_CASE(dm_test_vrr_transition_crtc_on_takes_ref),
+	KUNIT_CASE(dm_test_vrr_transition_crtc_off_keeps_ref),
 	{}
 };
 
-- 
2.56.0

