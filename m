Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525D606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EM3RaAks
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6181510FEE4;
	Thu, 12 Nov 2026 01:44:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0624C10FECB;
 Thu, 12 Nov 2026 01:43:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC9514018A;
 Thu, 12 Nov 2026 01:43:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794447839;
 b=SexiTVItjVsTF/MqMce1tiX5E579q43sP9BAvBqg36jDYBUE/zTsi+dKcrDEh4gLRp0c
 FcmoWypENjzOuvL24Jz4XEmN9xo0BfgVBG38C8WfZTO8WJPd2/sWVpVlo6YPcafu3uOwe
 XNdQYJY9kh9TC7XuCw5Jfjr2EM6TyjXJ9gHS/0t0SraXmnebe8b31M0VwVOZ1HcXSJ4Af
 OUTrGr0MtmnAe4OMNAPDSOQ9NwK1QT34mYMAaLoogRIX8ghp7rYQT/7PI3tkv200q1kef
 j3reSVUZbm5J89whxU/lOJhETCoxhd0GXPoilsb5uRGpSTZPRRYx0SXhoRn6shGRK9Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794447839;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=kc/vk82rTW5SCvjDrdlv/yc2t+ZnMTMu/r9M0iBkhDE=;
 b=wkEa06/0PJcal19+WKLx7GgJ8GagZbkiJ7K5aI7mopgohXs34aKIheT35m8SWbotR2AX
 VTaQo9e2LA1VDCFO+fiYZmBdSen7hMm9bttyVUP6SR1LMN0HBNBbVzXGCZOg5DCdDMGml
 Z4i8L2HnS8fWpw/x/QwHURQpiNDt1Koq6bNbOE5X9HIp344QwWfSDhXvEIFW/t8JB/zqF
 z/uCbSWyU5pmcL7EJZ9TrXhMXjYsMo8FU4h5c9UlG7o1p6J2cUPsasUABx2oRRK1Bvu5t
 xlkOr2qsJgt5ZZmQHjD8630ayvWi7XB6I82/oQ5ATUavnoTqrRpR1XKF7zvgwLMvNcA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8DD3C1F00ACC;
 Thu, 12 Nov 2026 01:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447839;
 bh=kc/vk82rTW5SCvjDrdlv/yc2t+ZnMTMu/r9M0iBkhDE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=EM3RaAks4E4kSKD/hGMnpNMbhQ2EMxiu75GnZzPCCrTZcya0m3YNHVDm7QfaERp5C
 34Hv5Vq9MC/sJtu9t8/F5IzPkLI56nHiCVtQHIb2Hq73A1XUwiRzggSiHgnr4k/2uD
 oysmSs+xBCsAR/SVWb/L23M6Lmp4XGUvSGL1RVbvth9d7G9pISyvJwBxIIZ95PYl3y
 5IrhaOzJVcjKhqXtugyq3422beHTuz1bdSqIbks+/QscLIkFnzArDA/6yYlLCjxHzR
 qkJ+3IHhFnCbguttL66i01/dH4D40cDW5bft4uLjPYfqiXtDuHrs3i8CV3PM7kZTWx
 cemJVqo06diHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 641134920A;
 Thu, 12 Nov 2026 01:43:50 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 12 Nov 2026 11:43:53 +1000
Subject: [PATCH 18/19] drm/amd/display: Replace dc_get_config with
 per-option config reads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-amdgpu-dc-cleanup-v1-18-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Austin Zheng <austin.zheng@amd.com>, 
 Jun Lei <jun.lei@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14166;
 i=airlied@redhat.com; h=from:subject:message-id;
 bh=l7NWHTTrKCpkyKOkQ09znVp0bOXg3CfOabD73NtUkcw=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq9RnQNrra42rnTWAgog4fF/J/rRGxd446svW5O
 ZldU8TOwcyJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavUZ0AAKCRAMdPNZecSG
 viSND/9Km+F+RwdTOcJa19zxZKNqMPts/CsM/8Cm09KTaqx5L5YlKZmrUKWzun6Epa2d1wqFNtE
 Yne3Ldr4N9WhOzTp0NBw3O51wiZUpzcqmqo8/Q+YPbOri70yGeWdGiDBV2naX40i89iecfCzVWi
 Ac99MUyvv9NJ7sSgnurddCYaPv4f0FIhr+t5FK+5eseYgUnjfFsWLggXAR7cPZZLzv+Yvr2cOTg
 sAE6Dftr2WNLJLyCbzwmzcwtoCA8G2zKtOp8D5Ckfun03akphMZGth2buI6vUArkMeYHQ5opY6I
 udeg9Eld3p05ZHPk3TDAk+3MUdXnKTjWqqM2shL1HzCRsByTHjb/6OnS9IEvfkX/pyN3ughbw/M
 z3SmyA9zy9wvjJn9HkGcKp40fspu2WRxg/B8TG4Nfj29F1ugvC12SWsmKQl/Xl6TYcaujnV66k+
 Zc3re49KTOp6/gTqD0KtGYvMFxfbWOhk0hmy/3zZtjdShf+f3f5MIuyB0OwAsJQbFKh6yh/apaV
 PfbsH1QfT1LdrBrz05MI4J9qwugaVjy16e/aZYFt0rVtATomaaHc5PWdlYMdbquBChuREHstgPG
 1wmrKzqodZL2crlf2qFpslz2MvjFGHi7JhAMVydVzxhKPXr+LEf1Eudb2619fhFW6JC3uwbqHWu
 ZlpEK2Fm6TF8sAA==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

The only external reads of struct dc_config were five runtime-mutable
options. Give each a purpose-built getter (dc_get_disable_ips,
dc_get_enable_frl, dc_get_consolidated_dpia_dp_lt,
dc_get_usb4_bw_alloc_support, dc_get_allow_edp_hotplug_detection,
complementing the existing setter) and drop the dc_get_config view.
KUnit tests install the options through dc_test_set_* setters.

No code outside the dc directory references struct dc_config in
production anymore.

Part of making the struct dc sub-structures opaque outside DC.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  4 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c | 14 ++++++-----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  4 +--
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  4 +--
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  4 +--
 drivers/gpu/drm/amd/display/dc/core/dc_accessors.c | 25 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/core/dc_test.c      | 29 ++++++++++++++++++----
 drivers/gpu/drm/amd/display/dc/inc/dc.h            | 10 +++++---
 drivers/gpu/drm/amd/display/dc/inc/dc_test.h       |  6 ++++-
 11 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b601ec00ba05..6bfa3e9fe5ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -761,7 +761,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 
 	if (dc_get_caps(adev->dm.dc)->ips_support &&
-	    dc_get_config(adev->dm.dc)->disable_ips != DMUB_IPS_DISABLE_ALL)
+	    dc_get_disable_ips(adev->dm.dc) != DMUB_IPS_DISABLE_ALL)
 		adev->dm.idle_workqueue = idle_create_workqueue(adev);
 
 	if (dc_get_caps(adev->dm.dc)->max_links > 0 && adev->family >= AMDGPU_FAMILY_RV) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 9c607ecc4bd6..a10f374f16df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -309,7 +309,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 		 * update the vblank counter in DRM.
 		 */
 		if (dc_get_caps(dc)->ips_support &&
-			dc_get_config(dc)->disable_ips != DMUB_IPS_DISABLE_ALL &&
+			dc_get_disable_ips(dc) != DMUB_IPS_DISABLE_ALL &&
 			sr_supported && vblank->config.disable_immediate)
 			drm_crtc_vblank_restore(crtc);
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8bc737117db9..99400740cd66 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2701,7 +2701,7 @@ static int ips_status_show(struct seq_file *m, void *unused)
 	struct dc *dc = adev->dm.dc;
 	struct dc_dmub_srv *dc_dmub_srv;
 
-	seq_printf(m, "IPS config: %d\n", dc_get_config(dc)->disable_ips);
+	seq_printf(m, "IPS config: %d\n", dc_get_disable_ips(dc));
 	seq_printf(m, "Idle optimization: %d\n", dc_is_idle_optimizations_allowed(dc));
 
 	if (adev->dm.idle_workqueue) {
@@ -3379,7 +3379,7 @@ static int allow_edp_hotplug_detection_get(void *data, u64 *val)
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	*val = dc_get_config(adev->dm.dc)->allow_edp_hotplug_detection;
+	*val = dc_get_allow_edp_hotplug_detection(adev->dm.dc);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 3ed6a9318931..9aee6fe047ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -340,11 +340,11 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 		dc_get_usb4_dpia_count(dc) != 0 &&
 		!dc_get_debug_options(dc)->dpia_debug.bits.disable_dpia) {
 		hw_params.dpia_supported = true;
-		hw_params.disable_dpia = dc_get_debug_options(dc)->dpia_debug.bits.disable_dpia;
+		hw_params.disable_dpia =
+			dc_get_debug_options(dc)->dpia_debug.bits.disable_dpia;
 		hw_params.dpia_hpd_int_enable_supported = false;
-		hw_params.enable_non_transparent_setconfig =
-			dc_get_config(dc)->consolidated_dpia_dp_lt;
-		hw_params.disable_dpia_bw_allocation = !dc_get_config(dc)->usb4_bw_alloc_support;
+		hw_params.enable_non_transparent_setconfig = dc_get_consolidated_dpia_dp_lt(dc);
+		hw_params.disable_dpia_bw_allocation = !dc_get_usb4_bw_alloc_support(dc);
 	}
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
@@ -399,14 +399,16 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 1, 3):
 		if (adev->dm.dmcub_fw_version &&
 		    adev->dm.dmcub_fw_version >= DMUB_FW_VERSION(4, 0, 0) &&
-		    adev->dm.dmcub_fw_version < DMUB_FW_VERSION(4, 0, 59))
+		    adev->dm.dmcub_fw_version < DMUB_FW_VERSION(4, 0, 59)) {
 			dc_get_debug_options_mutable(adev->dm.dc)->sanity_checks = true;
+		}
 		break;
 	case IP_VERSION(3, 1, 4):
 		if (adev->dm.dmcub_fw_version &&
 		    adev->dm.dmcub_fw_version >= DMUB_FW_VERSION(4, 0, 0) &&
-		    adev->dm.dmcub_fw_version < DMUB_FW_VERSION(8, 0, 16))
+		    adev->dm.dmcub_fw_version < DMUB_FW_VERSION(8, 0, 16)) {
 			dc_get_debug_options_mutable(adev->dm.dc)->sanity_checks = true;
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 542f9c4cb7e4..5a92e0a2b086 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -229,8 +229,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	if (edid_caps->edid_hdmi) {
 		edid_caps->qs_bit = connector->display_info.rgb_quant_range_selectable;
 		populate_hdmi_info_from_connector(
-			dc_get_config(link->dc)->enable_frl,
-			&connector->display_info.hdmi, edid_caps);
+				dc_get_enable_frl(link->dc),
+				&connector->display_info.hdmi, edid_caps);
 		drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] max_frl_rate %d\n", __func__, connector->name, edid_caps->max_frl_rate);
 		if (edid_caps->frl_dsc_support)
 			drm_dbg_driver(connector->dev, "%s: HDMI_FRL_DSC [%s] frl_dsc_10bpc %d, frl_dsc_12bpc %d, frl_dsc_all_bpp %d, frl_dsc_native_420 %d, frl_dsc_max_slices %d, frl_dsc_max_frl_rate %d, frl_dsc_total_chunk_kbytes %d\n",
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 4543b0b0f993..1ebe9bef2c96 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1194,7 +1194,7 @@ static void dm_test_crtc_enable_vblank_ips_restore(struct kunit *test)
 
 	/* IPS enabled and not fully disabled -> first restore condition holds. */
 	dc_test_caps(adev->dm.dc)->ips_support = true;
-	dc_test_config(adev->dm.dc)->disable_ips = DMUB_IPS_ENABLE;
+	dc_test_set_disable_ips(adev->dm.dc, DMUB_IPS_ENABLE);
 
 	/* Supported PSR version makes self-refresh supported. */
 	link = acrtc_state->stream->link;
@@ -1241,7 +1241,7 @@ static void dm_test_crtc_enable_vblank_ips_restore_replay(struct kunit *test)
 
 	/* IPS enabled and not fully disabled -> first restore condition holds. */
 	dc_test_caps(adev->dm.dc)->ips_support = true;
-	dc_test_config(adev->dm.dc)->disable_ips = DMUB_IPS_ENABLE;
+	dc_test_set_disable_ips(adev->dm.dc, DMUB_IPS_ENABLE);
 
 	/*
 	 * PSR unsupported but replay supported -> sr_supported is driven by the
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 65bffc57ea40..e5145902d7d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -435,7 +435,7 @@ static void dm_test_parse_edid_caps_hdmi_frl(struct kunit *test)
 	dc = dm_kunit_alloc_dc(test);
 
 	link->dc = dc;
-	dc_test_config(dc)->enable_frl = true;
+	dc_test_set_enable_frl(dc, true);
 
 	dm_test_fill_base_edid(dc_edid, true);
 
@@ -477,7 +477,7 @@ static void dm_test_parse_edid_caps_hdmi_frl_dsc(struct kunit *test)
 	dc = dm_kunit_alloc_dc(test);
 
 	link->dc = dc;
-	dc_test_config(dc)->enable_frl = true;
+	dc_test_set_enable_frl(dc, true);
 
 	dm_test_fill_base_edid(dc_edid, true);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c b/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
index 163884db0294..eb34a76262b1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
@@ -57,9 +57,25 @@ const struct dc_caps *dc_get_caps(const struct dc *dc)
 	return &dc->caps;
 }
 
-const struct dc_config *dc_get_config(const struct dc *dc)
+unsigned int dc_get_disable_ips(const struct dc *dc)
 {
-	return &dc->config;
+	return dc->config.disable_ips;
+}
+EXPORT_IF_KUNIT(dc_get_disable_ips);
+
+bool dc_get_enable_frl(const struct dc *dc)
+{
+	return dc->config.enable_frl;
+}
+
+bool dc_get_consolidated_dpia_dp_lt(const struct dc *dc)
+{
+	return dc->config.consolidated_dpia_dp_lt;
+}
+
+bool dc_get_usb4_bw_alloc_support(const struct dc *dc)
+{
+	return dc->config.usb4_bw_alloc_support;
 }
 
 void dc_set_allow_edp_hotplug_detection(struct dc *dc,
@@ -68,6 +84,11 @@ void dc_set_allow_edp_hotplug_detection(struct dc *dc,
 	dc->config.allow_edp_hotplug_detection = hpd_select;
 }
 
+unsigned int dc_get_allow_edp_hotplug_detection(const struct dc *dc)
+{
+	return dc->config.allow_edp_hotplug_detection;
+}
+
 const struct dc_debug_options *dc_get_debug_options(const struct dc *dc)
 {
 	return &dc->debug;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_test.c b/drivers/gpu/drm/amd/display/dc/core/dc_test.c
index 04c799ae33d3..6431afb2b5b1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_test.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_test.c
@@ -105,17 +105,36 @@ void dc_test_set_idle_optimizations_allowed(struct dc *dc, bool allowed)
 }
 EXPORT_SYMBOL(dc_test_set_idle_optimizations_allowed);
 
+void dc_test_set_disable_ips(struct dc *dc, unsigned int disable_ips)
+{
+	dc->config.disable_ips = disable_ips;
+}
+EXPORT_SYMBOL(dc_test_set_disable_ips);
+
+void dc_test_set_enable_frl(struct dc *dc, bool enable)
+{
+	dc->config.enable_frl = enable;
+}
+EXPORT_SYMBOL(dc_test_set_enable_frl);
+
+void dc_test_set_consolidated_dpia_dp_lt(struct dc *dc, bool enable)
+{
+	dc->config.consolidated_dpia_dp_lt = enable;
+}
+EXPORT_SYMBOL(dc_test_set_consolidated_dpia_dp_lt);
+
+void dc_test_set_usb4_bw_alloc_support(struct dc *dc, bool enable)
+{
+	dc->config.usb4_bw_alloc_support = enable;
+}
+EXPORT_SYMBOL(dc_test_set_usb4_bw_alloc_support);
+
 struct dc_caps *dc_test_caps(struct dc *dc)
 {
 	return &dc->caps;
 }
 EXPORT_SYMBOL(dc_test_caps);
 
-struct dc_config *dc_test_config(struct dc *dc)
-{
-	return &dc->config;
-}
-EXPORT_SYMBOL(dc_test_config);
 
 struct dc_debug_options *dc_test_debug_options(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc.h b/drivers/gpu/drm/amd/display/dc/inc/dc.h
index 65705f4941c1..31baba820f6c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc.h
@@ -2354,9 +2354,6 @@ enum dce_version dc_get_dce_version(const struct dc *dc);
 /* Capabilities detected at dc_create() time. Read-only. */
 const struct dc_caps *dc_get_caps(const struct dc *dc);
 
-/* Configuration captured at dc_create() time. Read-only. */
-const struct dc_config *dc_get_config(const struct dc *dc);
-
 /*
  * Select which eDP connectors get hotplug detection enabled; see
  * enum dc_hpd_enable_select. Runtime configurable (debugfs).
@@ -2364,6 +2361,13 @@ const struct dc_config *dc_get_config(const struct dc *dc);
 void dc_set_allow_edp_hotplug_detection(struct dc *dc,
 		enum dc_hpd_enable_select hpd_select);
 
+/* Configuration reads for the runtime-mutable options. */
+unsigned int dc_get_disable_ips(const struct dc *dc);
+bool dc_get_enable_frl(const struct dc *dc);
+bool dc_get_consolidated_dpia_dp_lt(const struct dc *dc);
+bool dc_get_usb4_bw_alloc_support(const struct dc *dc);
+unsigned int dc_get_allow_edp_hotplug_detection(const struct dc *dc);
+
 /* Debug overrides (module parameters, debugfs). Read-only view. */
 const struct dc_debug_options *dc_get_debug_options(const struct dc *dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_test.h b/drivers/gpu/drm/amd/display/dc/inc/dc_test.h
index 61911de9da05..80f97e29246f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_test.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_test.h
@@ -69,9 +69,13 @@ void dc_test_set_link(struct dc *dc, unsigned int index, struct dc_link *link);
 void dc_test_set_link_count(struct dc *dc, unsigned int count);
 void dc_test_set_idle_optimizations_allowed(struct dc *dc, bool allowed);
 
+void dc_test_set_disable_ips(struct dc *dc, unsigned int disable_ips);
+void dc_test_set_enable_frl(struct dc *dc, bool enable);
+void dc_test_set_consolidated_dpia_dp_lt(struct dc *dc, bool enable);
+void dc_test_set_usb4_bw_alloc_support(struct dc *dc, bool enable);
+
 /* Mutable views of embedded sub-structures, for test faking only. */
 struct dc_caps *dc_test_caps(struct dc *dc);
-struct dc_config *dc_test_config(struct dc *dc);
 struct dc_debug_options *dc_test_debug_options(struct dc *dc);
 struct dc_cap_funcs *dc_test_cap_funcs(struct dc *dc);
 struct hw_sequencer_funcs *dc_test_hwss(struct dc *dc);

-- 
2.56.0


