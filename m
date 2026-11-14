Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05681606A89B
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XL4q1Dri
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63B910E2AD;
	Sat, 14 Nov 2026 23:09:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBCF10E094;
 Sat, 14 Nov 2026 23:09:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2EFB61CE2;
 Sat, 14 Nov 2026 23:09:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794697755;
 b=x8gnMIw2EWGCWTIBUBm3V+bDKcYRoCWUChvegY92w3fHrBtW3QaIry3mVZol9GegNpgR
 9mUaLADnIL2MIlLoh9zWKou5Q0BEi0h6PYxIcMJZhs0APBgYv8Y4cyuARLgSSxud3Uw9G
 POWnfoxRse0YjURzE16btKtuUTQmgqCYXDL30xirxt+9ueRcPtU8FBkLcsoECIGF9LcTK
 ITbrrTcP+oS8CXbpwc4+t6Evpu8XWxj2gNto3wFeEd/ipm6HQISv0LtseRpUXgUvK3/O7
 NOM6toQarLnZgKjRJTTtKh67S/VUtDB2t+rok433MV2C0w+4Mzcdk+h+BIG4UOSTYwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794697755;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=5nRX9BV8mjVmto8Gsx3EfTDHCBTdBSYk1raaxm4LEB4=;
 b=dNvweEgrEpFPzeCucWnINuZ4Mz0Wf+x5VAOTheHfQcgnrSAP04nTM9c4923Qj2AaMp8Q
 9fseWu20ZGIiYYj+HVn1fOxtEjcQdhLEMjcjdKqf5LB7FKsG1hz35rPA476H9oEN00SKp
 0tUShg3sbSliO7RX5M8T0ZmENNZwG0yg3TzYC32fr8YLkI7SJMw/Iz0n4L9bejae5zT7U
 yVNj7OdsrExRpmIdr0D8geVJ5AU4Z6+/UC1tzTtFloL4gp173UZAvVJX2tPUNQJbyDw5X
 4KyhUXVLVGASTcB6Uxq7o6EMRiBVzZ4+HePhraqA6jEX3Civo3wKc8TBipHxcgoVERA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 78BD91F000C6;
 Sat, 14 Nov 2026 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794697755;
 bh=5nRX9BV8mjVmto8Gsx3EfTDHCBTdBSYk1raaxm4LEB4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XL4q1DridIVtEc+NF5IaqRJXHuGlxTAgyTE8/Eao7MPKjEXWCFiEmi07CfOA7UOpR
 OkNeADGim6BTADD8BaA81ME5YRhyaHnVr5CUi+s0iLNlHskVaQ5RPXIviUEm0y+emD
 k39jdrNE+4+INNsX0PcQ2FJgFYotTInHU1PXc6hM9xeiPBXcDoUeiibwuo4wGFUUy6
 qGiHd9RflvaEXY3g+Yh3yzOvodCc0g+Ttdc/WrIw8NJ0ZElSUvrzGnfsRMihycPkhC
 4szpPyYXkklY5cgfK8MswZ/27K0NuHoEgxurkA9RY1lHaMARhhW+DUnNdYzdjoWuv2
 8h+bNsVVMad6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 081F849EBF;
 Sat, 14 Nov 2026 23:09:14 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Sat, 14 Nov 2026 23:09:13 +0000
Subject: [PATCH 2/8] drm/amd/display: Don't match FreeSync video modes
 against the last probe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-amdgpu-modes-four-v1-2-f11e2a6cd407@hsal.es>
References: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
In-Reply-To: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ray Wu <ray.wu@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5805; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=yWWy7i9YetkE5GAq3UFyqpx2cMMLNJIdP9f/Q6iE3xM=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn68kmh5vitWNXVa0wYXy+sLipbJLD3wY1/Ka+GtB
 hoa4TMuldzqKGVhEONikBVTZNG94cnAMnHyzJyi50tg5rAygQxh4OIUgImsmcDI8GfD9LYvPRcq
 jF1PM73ber72xwUPlpLF3cpRIX+/liU1MzD8L5K4ImfN0HD0/LmPK89MsTRSElZ1W5ClxhHWWsx
 0b/E5DgChSkyL
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
Content-Transfer-Encoding: 7bit
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
Reply-To: hugo@hsal.es
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hugo Sales <hugo@hsal.es>

add_fs_modes() runs in ->get_modes() and skips a FreeSync video mode
that is_duplicate_mode() finds. Since commit 828cfa384e23
("drm/amd/display: Fix unadvertised mode detection"),
is_duplicate_mode() also searches connector->modes, which during a
re-probe still lists the previous probe's modes. add_fs_modes() then
takes every FreeSync video mode for a duplicate and adds none, and the
probe helper prunes the old ones as stale. With amdgpu.freesync_video=1,
the FreeSync video modes disappear on every second probe

The connector->modes search was for the unadvertised mode check, which
is gone, so search only probed_modes again

Fixes: 828cfa384e23 ("drm/amd/display: Fix unadvertised mode detection")
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  5 -----
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 26 +++++++++++-----------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 89f8427433af0..da2ee6179cb67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1409,11 +1409,6 @@ STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 			return true;
 	}
 
-	list_for_each_entry(m, &aconnector->base.modes, head) {
-		if (drm_mode_equal(m, mode))
-			return true;
-	}
-
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index addc407841a2a..5af111698e355 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -1136,7 +1136,6 @@ static void dm_test_is_duplicate_mode_empty_list(struct kunit *test)
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
-	INIT_LIST_HEAD(&aconnector->base.modes);
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	mode.hdisplay = 1920;
 	mode.vdisplay = 1080;
@@ -1157,12 +1156,11 @@ static void dm_test_is_duplicate_mode_match(struct kunit *test)
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
-	INIT_LIST_HEAD(&aconnector->base.modes);
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	existing.hdisplay = 1920;
 	existing.vdisplay = 1080;
 	existing.clock = 148500;
-	list_add_tail(&existing.head, &aconnector->base.modes);
+	list_add_tail(&existing.head, &aconnector->base.probed_modes);
 
 	candidate.hdisplay = 1920;
 	candidate.vdisplay = 1080;
@@ -1172,10 +1170,14 @@ static void dm_test_is_duplicate_mode_match(struct kunit *test)
 }
 
 /**
- * dm_test_is_duplicate_mode_probed_match - Test probed mode duplicate match
+ * dm_test_is_duplicate_mode_previous_probe - Test modes of the previous probe don't count
  * @test: The KUnit test context
+ *
+ * During a re-probe, base.modes still holds the previous probe's modes. A
+ * mode listed only there is not a duplicate, so add_fs_modes() builds the
+ * FreeSync video modes again on every probe
  */
-static void dm_test_is_duplicate_mode_probed_match(struct kunit *test)
+static void dm_test_is_duplicate_mode_previous_probe(struct kunit *test)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_display_mode existing = {};
@@ -1189,13 +1191,13 @@ static void dm_test_is_duplicate_mode_probed_match(struct kunit *test)
 	existing.hdisplay = 1920;
 	existing.vdisplay = 1080;
 	existing.clock = 148500;
-	list_add_tail(&existing.head, &aconnector->base.probed_modes);
+	list_add_tail(&existing.head, &aconnector->base.modes);
 
 	candidate.hdisplay = 1920;
 	candidate.vdisplay = 1080;
 	candidate.clock = 148500;
 
-	KUNIT_EXPECT_TRUE(test, is_duplicate_mode(aconnector, &candidate));
+	KUNIT_EXPECT_FALSE(test, is_duplicate_mode(aconnector, &candidate));
 }
 
 /**
@@ -1212,11 +1214,10 @@ static void dm_test_is_duplicate_mode_no_match(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
-	INIT_LIST_HEAD(&aconnector->base.modes);
 	existing.hdisplay = 1920;
 	existing.vdisplay = 1080;
 	existing.clock = 148500;
-	list_add_tail(&existing.head, &aconnector->base.modes);
+	list_add_tail(&existing.head, &aconnector->base.probed_modes);
 
 	candidate.hdisplay = 2560;
 	candidate.vdisplay = 1440;
@@ -1238,13 +1239,12 @@ static void dm_test_is_duplicate_mode_same_size_different_clock(struct kunit *te
 
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 
-	INIT_LIST_HEAD(&aconnector->base.modes);
+	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	existing.hdisplay = 1920;
 	existing.vdisplay = 1080;
 	existing.clock = 148500;
-	list_add_tail(&existing.head, &aconnector->base.modes);
+	list_add_tail(&existing.head, &aconnector->base.probed_modes);
 
 	candidate.hdisplay = 1920;
 	candidate.vdisplay = 1080;
@@ -10402,7 +10402,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* is_duplicate_mode */
 	KUNIT_CASE(dm_test_is_duplicate_mode_empty_list),
 	KUNIT_CASE(dm_test_is_duplicate_mode_match),
-	KUNIT_CASE(dm_test_is_duplicate_mode_probed_match),
+	KUNIT_CASE(dm_test_is_duplicate_mode_previous_probe),
 	KUNIT_CASE(dm_test_is_duplicate_mode_no_match),
 	KUNIT_CASE(dm_test_is_duplicate_mode_same_size_different_clock),
 	/* amdgpu_dm_get_encoder_crtc_mask */

-- 
2.56.0


