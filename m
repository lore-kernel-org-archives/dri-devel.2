Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1297CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 569D110E7DA;
	Tue, 13 Oct 2026 11:58:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B71C10F7B0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791892715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HThViOcBZu7IsYL2o0cf+kq8B7HB6zOY5KntJZBguDQ=;
 b=UM5oj5cGdR1QU6mLBd80u1NvCI06UlMkQBS4QC3IS+0kXUzubWOltrKHCLl0MeW9NX1jjJ
 /yKs/g58soqbKx4XeXS0ucjY3T/fXoMMH7EWYN9ptKfbrvknFQV2CHAtrOayDNG1Baak0O
 eac03wm9CgC8Lor8jq4RS8fLv3PvNLE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-80-bUs-COtqWLVCb3puYzg-1; Tue,
 13 Oct 2026 11:58:32 +0000
X-MC-Unique: 80-bUs-COtqWLVCb3puYzg-1
X-Mimecast-MFC-AGG-ID: 80-bUs-COtqWLVCb3puYzg_1791892710
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CB4D1954190; Tue, 13 Oct 2026 11:58:29 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1E73195608C; Tue, 13 Oct 2026 11:58:24 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 13 Oct 2026 13:58:13 +0200
Subject: [PATCH v2 1/3] drm/amd/display: replace STATIC_IFN_KUNIT with
 VISIBLE_IF_KUNIT
MIME-Version: 1.0
Message-Id: <20261013-visibility-unification-v2-1-3ce8d458bddf@redhat.com>
References: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
In-Reply-To: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892699; l=117595;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=1Z+VrSbeCj3eqwHFFx2Fx/FW0jD3DP/KB/tZiWc+yo0=;
 b=Iio9jQeDohk3+sY+KmtYKGUnv3e0Y3Qe2DtABxPG421MXtdKtLN58ZddH5cZL/2jVPC04QBgv
 lMxACJ79J/ND8EU6A0e0FxTGLVz3iexO78hiJ3VSX4lGLibMrQ8E0Lh
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ofirV7RdD5-ACNkjEMu_Hz3fX2NNeZgmDoSCnxoPcAg_1791892710
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Switch amdgpu_dm test helpers from the local STATIC_IFN_KUNIT
macro to VISIBLE_IF_KUNIT.

The two are not identical: STATIC_IFN_KUNIT was gated on
CONFIG_DRM_AMD_DC_KUNIT_TEST, while VISIBLE_IF_KUNIT is gated on
CONFIG_KUNIT. Helpers therefore become non-static whenever KUnit
is enabled, not only when the AMD DC tests are built.
However, given that DRM_AMD_DC_KUNIT_TEST depends on KUNIT,
tests remain behaviourally unchanged.

Update the #if guards in headers from CONFIG_DRM_AMD_DC_KUNIT_TEST
to CONFIG_KUNIT so that declarations remain visible whenever
VISIBLE_IF_KUNIT makes the functions non-static.

kernel-doc still needs to strip the qualifier. amdgpu_dm_color.c
is pulled into Documentation/gpu and several documented functions
use it.

Include <kunit/visibility.h> from dm_helpers.h, which is where the
local macros used to live.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 39 +++++------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h    |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 24 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 60 ++++++++---------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 76 +++++++++++-----------
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  | 14 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 16 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h   |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 49 +++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 30 ++++-----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h  |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 56 ++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  | 14 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 24 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 50 +++++++-------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 50 +++++++-------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h   |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  8 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |  2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  4 +-
 tools/lib/python/kdoc/xforms_lists.py              |  2 +-
 40 files changed, 294 insertions(+), 284 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 47a0ff2ed035..7169e03c9eeb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -143,7 +143,8 @@ static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
 static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state);
-STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
+VISIBLE_IF_KUNIT void dm_enable_per_frame_crtc_master_sync(
+	struct dc_state *context);
 
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_commit *state);
@@ -167,7 +168,7 @@ static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
  * @return
  * Counter for vertical blanks
  */
-STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
+VISIBLE_IF_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 {
 	struct amdgpu_crtc *acrtc = NULL;
 
@@ -186,7 +187,7 @@ STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 }
 EXPORT_IF_KUNIT(dm_vblank_get_counter);
 
-STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
+VISIBLE_IF_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 					    u32 *vbl, u32 *position)
 {
 	u32 v_blank_start = 0, v_blank_end = 0, h_position = 0, v_position = 0;
@@ -224,21 +225,21 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
 }
 EXPORT_IF_KUNIT(dm_crtc_get_scanoutpos);
 
-STATIC_IFN_KUNIT bool dm_is_idle(struct amdgpu_ip_block *ip_block)
+VISIBLE_IF_KUNIT bool dm_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return true;
 }
 EXPORT_IF_KUNIT(dm_is_idle);
 
-STATIC_IFN_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
+VISIBLE_IF_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
 }
 EXPORT_IF_KUNIT(dm_wait_for_idle);
 
-STATIC_IFN_KUNIT int dm_soft_reset(struct amdgpu_ip_block *ip_block)
+VISIBLE_IF_KUNIT int dm_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
@@ -250,7 +251,7 @@ EXPORT_IF_KUNIT(dm_soft_reset);
  * in the dc_surface_updates array. This comparator is used to sort them
  * by descending zpos.
  */
-STATIC_IFN_KUNIT int dm_plane_layer_index_cmp(const void *a, const void *b)
+VISIBLE_IF_KUNIT int dm_plane_layer_index_cmp(const void *a, const void *b)
 {
 	const struct dc_surface_update *sa = (struct dc_surface_update *)a;
 	const struct dc_surface_update *sb = (struct dc_surface_update *)b;
@@ -299,14 +300,14 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 					   stream_update);
 }
 
-STATIC_IFN_KUNIT int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+VISIBLE_IF_KUNIT int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_clockgating_state state)
 {
 	return 0;
 }
 EXPORT_IF_KUNIT(dm_set_clockgating_state);
 
-STATIC_IFN_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
+VISIBLE_IF_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_powergating_state state)
 {
 	return 0;
@@ -2156,7 +2157,7 @@ int dm_atomic_get_state(struct drm_atomic_commit *state,
 	return 0;
 }
 
-STATIC_IFN_KUNIT struct dm_atomic_state *
+VISIBLE_IF_KUNIT struct dm_atomic_state *
 dm_atomic_get_new_state(struct drm_atomic_commit *state)
 {
 	struct drm_device *dev = state->dev;
@@ -2199,7 +2200,7 @@ dm_atomic_duplicate_state(struct drm_private_obj *obj)
 	return &new_state->base;
 }
 
-STATIC_IFN_KUNIT void dm_atomic_destroy_state(struct drm_private_obj *obj,
+VISIBLE_IF_KUNIT void dm_atomic_destroy_state(struct drm_private_obj *obj,
 					      struct drm_private_state *state)
 {
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(state);
@@ -2682,7 +2683,7 @@ static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
  *
  * Calculate and program the display watermarks and line buffer allocation.
  */
-STATIC_IFN_KUNIT void dm_bandwidth_update(struct amdgpu_device *adev)
+VISIBLE_IF_KUNIT void dm_bandwidth_update(struct amdgpu_device *adev)
 {
 	/* TODO: implement later */
 }
@@ -2887,13 +2888,13 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 	return dm_init_microcode(adev);
 }
 
-STATIC_IFN_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
+VISIBLE_IF_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
 {
 	return !crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
 }
 EXPORT_IF_KUNIT(modereset_required);
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 			    const enum surface_pixel_format format,
 			    enum dc_color_space *color_space)
@@ -3453,7 +3454,7 @@ static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 	amdgpu_irq_update(adev, &adev->pageflip_irq, irq_type);
 }
 
-STATIC_IFN_KUNIT bool
+VISIBLE_IF_KUNIT bool
 is_scaling_state_different(const struct dm_connector_state *dm_state,
 			   const struct dm_connector_state *old_dm_state)
 {
@@ -3472,7 +3473,7 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 }
 EXPORT_IF_KUNIT(is_scaling_state_different);
 
-STATIC_IFN_KUNIT bool
+VISIBLE_IF_KUNIT bool
 is_content_protection_different(struct drm_crtc_state *new_crtc_state,
 				struct drm_crtc_state *old_crtc_state,
 				struct drm_connector_state *new_conn_state,
@@ -4955,7 +4956,7 @@ static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
 	return 0;
 }
 
-STATIC_IFN_KUNIT void set_multisync_trigger_params(
+VISIBLE_IF_KUNIT void set_multisync_trigger_params(
 		struct dc_stream_state *stream)
 {
 	struct dc_stream_state *master = NULL;
@@ -4970,7 +4971,7 @@ STATIC_IFN_KUNIT void set_multisync_trigger_params(
 }
 EXPORT_IF_KUNIT(set_multisync_trigger_params);
 
-STATIC_IFN_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
+VISIBLE_IF_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
 					int stream_count)
 {
 	int j, highest_rfr = 0, master_stream = 0;
@@ -4994,7 +4995,7 @@ STATIC_IFN_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
 }
 EXPORT_IF_KUNIT(set_master_stream);
 
-STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
+VISIBLE_IF_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 {
 	int i = 0;
 	struct dc_stream_state *stream;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 881c8d1c3cc0..f566c958df48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1167,7 +1167,7 @@ struct __drm_planes_state *amdgpu_dm_get_next_zpos(struct drm_atomic_commit *sta
 			     (old_plane_state) = __i->old_state,		\
 			     (new_plane_state) = __i->new_state, 1))
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 struct amdgpu_ip_block;
 bool dm_is_idle(struct amdgpu_ip_block *ip_block);
 int dm_wait_for_idle(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
index 199f339839b2..1b331e783220 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -84,7 +84,7 @@ static const struct drm_audio_component_ops amdgpu_dm_audio_component_ops = {
 	.get_eld = amdgpu_dm_audio_component_get_eld,
 };
 
-STATIC_IFN_KUNIT int amdgpu_dm_audio_component_bind(struct device *kdev,
+VISIBLE_IF_KUNIT int amdgpu_dm_audio_component_bind(struct device *kdev,
 				       struct device *hda_kdev, void *data)
 {
 	struct drm_device *dev = dev_get_drvdata(kdev);
@@ -99,7 +99,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_audio_component_bind(struct device *kdev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_audio_component_bind);
 
-STATIC_IFN_KUNIT void amdgpu_dm_audio_component_unbind(struct device *kdev,
+VISIBLE_IF_KUNIT void amdgpu_dm_audio_component_unbind(struct device *kdev,
 					  struct device *hda_kdev, void *data)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev_get_drvdata(kdev));
@@ -116,7 +116,7 @@ static const struct component_ops amdgpu_dm_audio_component_bind_ops = {
 	.unbind	= amdgpu_dm_audio_component_unbind,
 };
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void amdgpu_dm_audio_init_pins(struct amdgpu_device *adev, int audio_count,
 			       const unsigned int *inst_array)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
index 7ccb026ece56..4bf74b7615a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
@@ -42,7 +42,7 @@ void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
 		     const struct dc_sink *dc_sink);
 void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 struct device;
 
 int amdgpu_dm_audio_component_bind(struct device *kdev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 703d0617df6d..979828a0a8f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -87,7 +87,7 @@ void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_backlight_caps);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *min, unsigned int *max)
 {
@@ -181,7 +181,7 @@ static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_c
 	return min_t(u32, luminance * 1000, 100000);
 }
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 			       unsigned int min, unsigned int max,
 			       uint32_t *user_brightness)
@@ -248,7 +248,7 @@ void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 
 EXPORT_IF_KUNIT(convert_custom_brightness);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 				uint32_t brightness)
 {
@@ -265,7 +265,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 
 EXPORT_IF_KUNIT(convert_brightness_from_user);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 			      uint32_t brightness)
 {
@@ -282,7 +282,7 @@ u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 }
 EXPORT_IF_KUNIT(convert_brightness_to_user);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 struct dc_stream_state *dm_find_stream_with_link(
 	struct amdgpu_display_manager *dm,
 	struct dc_link *link)
@@ -301,7 +301,7 @@ struct dc_stream_state *dm_find_stream_with_link(
 }
 EXPORT_IF_KUNIT(dm_find_stream_with_link);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
 					 struct backlight_device *bd)
 {
@@ -416,7 +416,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_set_level);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
@@ -428,7 +428,7 @@ int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 {
 	int ret;
@@ -455,7 +455,7 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_level);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
@@ -471,7 +471,7 @@ static const struct backlight_ops amdgpu_dm_backlight_ops = {
 	.update_status	= amdgpu_dm_backlight_update_status,
 };
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps *caps,
 				    bool is_system_supplied,
 				    bool custom_curve_enabled,
@@ -684,7 +684,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
  * carefully.
  */
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 ssize_t panel_power_savings_show(struct device *device,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -703,7 +703,7 @@ ssize_t panel_power_savings_show(struct device *device,
 }
 EXPORT_IF_KUNIT(panel_power_savings_show);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 ssize_t panel_power_savings_store(struct device *device,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 07b75064847c..ecf49f8966e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -52,7 +52,7 @@ bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
 
 extern const struct attribute_group amdgpu_group;
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 struct dc_stream_state *dm_find_stream_with_link(struct amdgpu_display_manager *dm,
 						 struct dc_link *link);
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index d55dc06167a8..0273701bd174 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -174,7 +174,7 @@ void amdgpu_dm_init_color_mod(void)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_init_color_mod);
 
-STATIC_IFN_KUNIT INLINE_IFN_KUNIT
+VISIBLE_IF_KUNIT INLINE_IFN_KUNIT
 struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
 {
 	struct fixed31_32 val;
@@ -425,7 +425,7 @@ amdgpu_dm_create_color_properties(struct amdgpu_device *adev)
  * Returns:
  * DRM LUT or NULL
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 const struct drm_color_lut *
 __extract_blob_lut(const struct drm_property_blob *blob, uint32_t *size)
 {
@@ -442,7 +442,7 @@ EXPORT_IF_KUNIT(__extract_blob_lut);
  * Returns:
  * DRM LUT or NULL
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 const struct drm_color_lut32 *
 __extract_blob_lut32(const struct drm_property_blob *blob, uint32_t *size)
 {
@@ -464,7 +464,7 @@ EXPORT_IF_KUNIT(__extract_blob_lut32);
  * True if the given lut is a linear mapping of values, i.e. it acts like a
  * bypass LUT. Otherwise, false.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
 {
 	int i;
@@ -501,7 +501,7 @@ EXPORT_IF_KUNIT(__is_lut_linear);
  *
  * The conversion depends on the size of the lut - whether or not it's legacy.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
 				  struct dc_gamma *gamma, bool is_legacy)
 {
@@ -541,7 +541,7 @@ EXPORT_IF_KUNIT(__drm_lut_to_dc_gamma);
  *
  * The conversion depends on the size of the lut - whether or not it's legacy.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut, struct dc_gamma *gamma)
 {
 	int i;
@@ -561,7 +561,7 @@ EXPORT_IF_KUNIT(__drm_lut32_to_dc_gamma);
  *
  * The matrix needs to be a 3x4 (12 entry) matrix.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
 			   struct fixed31_32 *matrix)
 {
@@ -595,7 +595,7 @@ EXPORT_IF_KUNIT(__drm_ctm_to_dc_matrix);
  *
  * The matrix needs to be a 3x4 (12 entry) matrix.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
 				struct fixed31_32 *matrix)
 {
@@ -624,7 +624,7 @@ EXPORT_IF_KUNIT(__drm_ctm_3x4_to_dc_matrix);
  * Returns:
  * 0 in case of success, -ENOMEM if fails
  */
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 __set_legacy_tf(struct dc_transfer_func *func,
 		const struct drm_color_lut *lut, uint32_t lut_size,
 		bool has_rom)
@@ -664,7 +664,7 @@ EXPORT_IF_KUNIT(__set_legacy_tf);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 __set_output_tf(struct dc_transfer_func *func,
 		const struct drm_color_lut *lut, uint32_t lut_size,
 		bool has_rom)
@@ -724,7 +724,7 @@ EXPORT_IF_KUNIT(__set_output_tf);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 __set_output_tf_32(struct dc_transfer_func *func,
 		   const struct drm_color_lut32 *lut, uint32_t lut_size,
 		   bool has_rom)
@@ -772,14 +772,14 @@ __set_output_tf_32(struct dc_transfer_func *func,
 }
 EXPORT_IF_KUNIT(__set_output_tf_32);
 
-STATIC_IFN_KUNIT void __set_tf_bypass(struct dc_transfer_func *tf)
+VISIBLE_IF_KUNIT void __set_tf_bypass(struct dc_transfer_func *tf)
 {
 	tf->type = TF_TYPE_BYPASS;
 	tf->tf = TRANSFER_FUNCTION_LINEAR;
 }
 EXPORT_IF_KUNIT(__set_tf_bypass);
 
-STATIC_IFN_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
+VISIBLE_IF_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
 					enum dc_transfer_func_predefined predefined_tf)
 {
 	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
@@ -788,7 +788,7 @@ STATIC_IFN_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
 }
 EXPORT_IF_KUNIT(__set_tf_distributed_points);
 
-STATIC_IFN_KUNIT int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
+VISIBLE_IF_KUNIT int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
 					const struct drm_color_lut *regamma_lut,
 					uint32_t regamma_size, bool has_rom,
 					enum dc_transfer_func_predefined tf)
@@ -832,7 +832,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_set_atomic_regamma);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-STATIC_IFN_KUNIT int __set_input_tf(struct dc_color_caps *caps,
+VISIBLE_IF_KUNIT int __set_input_tf(struct dc_color_caps *caps,
 				    struct dc_transfer_func *func,
 				    const struct drm_color_lut *lut, uint32_t lut_size)
 {
@@ -870,7 +870,7 @@ EXPORT_IF_KUNIT(__set_input_tf);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-STATIC_IFN_KUNIT int __set_input_tf_32(struct dc_color_caps *caps,
+VISIBLE_IF_KUNIT int __set_input_tf_32(struct dc_color_caps *caps,
 				       struct dc_transfer_func *func,
 				       const struct drm_color_lut32 *lut, uint32_t lut_size)
 {
@@ -897,7 +897,7 @@ STATIC_IFN_KUNIT int __set_input_tf_32(struct dc_color_caps *caps,
 }
 EXPORT_IF_KUNIT(__set_input_tf_32);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 enum dc_transfer_func_predefined
 amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf)
 {
@@ -928,7 +928,7 @@ amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf)
 }
 EXPORT_IF_KUNIT(amdgpu_tf_to_dc_tf);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 enum dc_transfer_func_predefined
 amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 {
@@ -951,7 +951,7 @@ amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 }
 EXPORT_IF_KUNIT(amdgpu_colorop_tf_to_dc_tf);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void __to_dc_lut3d_color(struct dc_rgb *rgb,
 				const struct drm_color_lut lut,
 				int bit_precision)
@@ -962,7 +962,7 @@ void __to_dc_lut3d_color(struct dc_rgb *rgb,
 }
 EXPORT_IF_KUNIT(__to_dc_lut3d_color);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
 				    uint32_t lut3d_size,
 				    struct tetrahedral_params *params,
@@ -1008,7 +1008,7 @@ void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
 }
 EXPORT_IF_KUNIT(__drm_3dlut_to_dc_3dlut);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
 				   const struct drm_color_lut32 lut,
 				   int bit_precision)
@@ -1019,7 +1019,7 @@ void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
 }
 EXPORT_IF_KUNIT(__to_dc_lut3d_32_color);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
 				       uint32_t lut3d_size,
 				       struct tetrahedral_params *params,
@@ -1073,7 +1073,7 @@ EXPORT_IF_KUNIT(__drm_3dlut32_to_dc_3dlut);
  * Map user 3D LUT data to DC 3D LUT and all necessary bits to program it
  * on DCN accordingly.
  */
-STATIC_IFN_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
+VISIBLE_IF_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
 				     uint32_t drm_lut3d_size,
 				     struct dc_plane_cm *cm)
 {
@@ -1095,7 +1095,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut
 }
 EXPORT_IF_KUNIT(amdgpu_dm_atomic_lut3d);
 
-STATIC_IFN_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
+VISIBLE_IF_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
 				       bool has_rom,
 				       enum dc_transfer_func_predefined tf,
 				       uint32_t shaper_size,
@@ -1121,7 +1121,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *sha
 }
 EXPORT_IF_KUNIT(amdgpu_dm_atomic_shaper_lut);
 
-STATIC_IFN_KUNIT int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
+VISIBLE_IF_KUNIT int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
 				       bool has_rom,
 				       enum dc_transfer_func_predefined tf,
 				       uint32_t blend_size,
@@ -1544,7 +1544,7 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 	return 0;
 }
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 			     struct drm_colorop_state *colorop_state)
 {
@@ -1572,7 +1572,7 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 }
 EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 			       struct dc_plane_state *dc_plane_state,
 			       struct drm_colorop *colorop)
@@ -1600,7 +1600,7 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 }
 EXPORT_IF_KUNIT(__set_dm_plane_colorop_degamma);
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 				  struct dc_plane_state *dc_plane_state,
 				  struct drm_colorop *colorop)
@@ -1642,7 +1642,7 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 }
 EXPORT_IF_KUNIT(__set_dm_plane_colorop_3x4_matrix);
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
 				  struct dc_plane_state *dc_plane_state,
 				  struct drm_colorop *colorop)
@@ -1764,7 +1764,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
  * Returns:
  * 0 on success. -EINVAL if drm_lut3d_size is zero.
  */
-STATIC_IFN_KUNIT int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
+VISIBLE_IF_KUNIT int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
 					 uint32_t drm_lut3d_size,
 					 struct dc_3dlut *lut)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
index 3e8a3d3fc855..2b9271521bce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -46,7 +46,7 @@ struct tetrahedral_params;
 struct dc_transfer_func;
 struct dc_3dlut;
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 /*
  * Prototypes for functions exposed to KUnit tests. The enum types
  * used below (dc_transfer_func_predefined, amdgpu_transfer_function,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index fae9007b9998..ea326f5b0941 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -63,7 +63,7 @@ static const struct drm_colorop_funcs dm_colorop_funcs = {
 	.destroy = drm_colorop_destroy,
 };
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
 				  bool hw_3d_lut, struct drm_prop_enum_list *list)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 77364d954d3b..44359db769da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -33,7 +33,7 @@ extern const u64 amdgpu_dm_supported_blnd_tfs;
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 int amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
 				      bool hw_3d_lut, struct drm_prop_enum_list *list);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 45a69bf43971..459568db159c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -90,12 +90,12 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 	.destroy = amdgpu_dm_encoder_destroy,
 };
 
-STATIC_IFN_KUNIT void dm_encoder_helper_disable(struct drm_encoder *encoder)
+VISIBLE_IF_KUNIT void dm_encoder_helper_disable(struct drm_encoder *encoder)
 {
 }
 EXPORT_IF_KUNIT(dm_encoder_helper_disable);
 
-STATIC_IFN_KUNIT int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
+VISIBLE_IF_KUNIT int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 					  struct drm_crtc_state *crtc_state,
 					  struct drm_connector_state *conn_state)
 {
@@ -216,7 +216,7 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 	return res;
 }
 
-STATIC_IFN_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
+VISIBLE_IF_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
 {
 	switch (link->dpcd_caps.dongle_type) {
 	case DISPLAY_DONGLE_NONE:
@@ -236,7 +236,7 @@ STATIC_IFN_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link
 }
 EXPORT_IF_KUNIT(get_subconnector_type);
 
-STATIC_IFN_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_link *link = aconnector->dc_link;
 	struct drm_connector *connector = &aconnector->base;
@@ -256,7 +256,7 @@ EXPORT_IF_KUNIT(update_subconnector_property);
 
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 
-STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
+VISIBLE_IF_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct dm_compressor_info *compressor = &adev->dm.compressor;
@@ -334,7 +334,7 @@ int amdgpu_dm_detect_mst_link_for_all_connectors(struct drm_device *dev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_detect_mst_link_for_all_connectors);
 
-STATIC_IFN_KUNIT void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
 {
 	struct cec_notifier *n = aconnector->notifier;
 
@@ -400,7 +400,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_find_first_crtc_matching_connector);
 
-STATIC_IFN_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_display_info *display_info = &connector->display_info;
@@ -469,7 +469,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconn
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_panel_type);
 
-STATIC_IFN_KUNIT void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
 {
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
 	struct dc_link *link = aconnector->dc_link;
@@ -724,7 +724,7 @@ amdgpu_dm_convert_color_depth_from_display_info(const struct drm_connector *conn
 }
 EXPORT_IF_KUNIT(amdgpu_dm_convert_color_depth_from_display_info);
 
-STATIC_IFN_KUNIT enum dc_aspect_ratio
+VISIBLE_IF_KUNIT enum dc_aspect_ratio
 get_aspect_ratio(const struct drm_display_mode *mode_in)
 {
 	/* 1-1 mapping, since both enums follow the HDMI spec. */
@@ -814,7 +814,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_get_output_color_space);
 
-STATIC_IFN_KUNIT enum display_content_type
+VISIBLE_IF_KUNIT enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state)
 {
 	switch (connector_state->content_type) {
@@ -833,7 +833,7 @@ get_output_content_type(const struct drm_connector_state *connector_state)
 }
 EXPORT_IF_KUNIT(get_output_content_type);
 
-STATIC_IFN_KUNIT bool adjust_colour_depth_from_display_info(
+VISIBLE_IF_KUNIT bool adjust_colour_depth_from_display_info(
 	struct dc_crtc_timing *timing_out,
 	const struct drm_display_info *info)
 {
@@ -871,7 +871,7 @@ STATIC_IFN_KUNIT bool adjust_colour_depth_from_display_info(
 }
 EXPORT_IF_KUNIT(adjust_colour_depth_from_display_info);
 
-STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
+VISIBLE_IF_KUNIT void fill_stream_properties_from_drm_display_mode(
 	struct dc_stream_state *stream,
 	const struct drm_display_mode *mode_in,
 	const struct drm_connector *connector,
@@ -986,7 +986,7 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 }
 EXPORT_IF_KUNIT(fill_stream_properties_from_drm_display_mode);
 
-STATIC_IFN_KUNIT void
+VISIBLE_IF_KUNIT void
 copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 				      struct drm_display_mode *dst_mode)
 {
@@ -1007,7 +1007,7 @@ copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 }
 EXPORT_IF_KUNIT(copy_crtc_timing_for_drm_display_mode);
 
-STATIC_IFN_KUNIT void
+VISIBLE_IF_KUNIT void
 decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
 					bool scale_enabled)
@@ -1446,7 +1446,7 @@ void amdgpu_dm_update_stream_scaling_settings(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_stream_scaling_settings);
 
-STATIC_IFN_KUNIT struct dc_stream_state *
+VISIBLE_IF_KUNIT struct dc_stream_state *
 create_stream_for_sink(struct drm_connector *connector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
@@ -1648,7 +1648,7 @@ EXPORT_IF_KUNIT(create_stream_for_sink);
  *
  * Return: The probed connector status (connected/disconnected/unknown).
  */
-STATIC_IFN_KUNIT enum drm_connector_status
+VISIBLE_IF_KUNIT enum drm_connector_status
 amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1757,7 +1757,7 @@ static bool amdgpu_dm_hide_secondary_tile_from_userspace(struct drm_connector *c
  * Return: The connector status (connected, disconnected, or unknown).
  *
  */
-STATIC_IFN_KUNIT enum drm_connector_status
+VISIBLE_IF_KUNIT enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -1903,7 +1903,7 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_get_property);
 
-STATIC_IFN_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *connector)
+VISIBLE_IF_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
@@ -1915,7 +1915,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *conne
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_unregister);
 
-STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connector)
+VISIBLE_IF_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
@@ -2018,7 +2018,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_duplicate_state);
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 amdgpu_dm_connector_late_register(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -2050,7 +2050,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_late_register);
 
-STATIC_IFN_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
+VISIBLE_IF_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dc_link *dc_link = aconnector->dc_link;
@@ -2107,7 +2107,7 @@ static int get_modes(struct drm_connector *connector)
 	return amdgpu_dm_connector_get_modes(connector);
 }
 
-STATIC_IFN_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct dc_link *dc_link = aconnector->dc_link;
@@ -2154,7 +2154,7 @@ STATIC_IFN_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(create_eml_sink);
 
-STATIC_IFN_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_link *link = (struct dc_link *)aconnector->dc_link;
 
@@ -2171,7 +2171,7 @@ STATIC_IFN_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(handle_edid_mgmt);
 
-STATIC_IFN_KUNIT enum dc_status dm_validate_stream_and_context(struct dc *dc,
+VISIBLE_IF_KUNIT enum dc_status dm_validate_stream_and_context(struct dc *dc,
 						struct dc_stream_state *stream)
 {
 	enum dc_status dc_result = DC_ERROR_UNEXPECTED;
@@ -2715,7 +2715,7 @@ int amdgpu_dm_convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_
 }
 EXPORT_IF_KUNIT(amdgpu_dm_convert_dc_color_depth_into_bpc);
 
-STATIC_IFN_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connector_id)
+VISIBLE_IF_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connector_id)
 {
 	switch (st) {
 	case SIGNAL_TYPE_HDMI_TYPE_A:
@@ -2751,7 +2751,7 @@ STATIC_IFN_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connect
 }
 EXPORT_IF_KUNIT(to_drm_connector_type);
 
-STATIC_IFN_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *connector)
+VISIBLE_IF_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *connector)
 {
 	struct drm_encoder *encoder;
 
@@ -2763,7 +2763,7 @@ STATIC_IFN_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_c
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_to_encoder);
 
-STATIC_IFN_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
+VISIBLE_IF_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 {
 	struct drm_encoder *encoder;
 	struct amdgpu_encoder *amdgpu_encoder;
@@ -2793,7 +2793,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_get_native_mode);
 
-STATIC_IFN_KUNIT struct drm_display_mode *
+VISIBLE_IF_KUNIT struct drm_display_mode *
 amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
 			     const char *name,
 			     int hdisplay, int vdisplay)
@@ -2836,7 +2836,7 @@ static const struct amdgpu_dm_mode_size {
 	{"1920x1200", 1920, 1200}
 };
 
-STATIC_IFN_KUNIT void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
+VISIBLE_IF_KUNIT void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 						 struct drm_connector *connector)
 {
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
@@ -2957,7 +2957,7 @@ static void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector)
 	}
 }
 
-STATIC_IFN_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
+VISIBLE_IF_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 					      const struct drm_edid *drm_edid)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -2993,7 +2993,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *co
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_ddc_get_modes);
 
-STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
+VISIBLE_IF_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 			      struct drm_display_mode *mode)
 {
 	struct drm_display_mode *m;
@@ -3007,7 +3007,7 @@ STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 }
 EXPORT_IF_KUNIT(is_duplicate_mode);
 
-STATIC_IFN_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 {
 	const struct drm_display_mode *m;
 	struct drm_display_mode *new_mode;
@@ -3084,7 +3084,7 @@ STATIC_IFN_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(add_fs_modes);
 
-STATIC_IFN_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
+VISIBLE_IF_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
 						   const struct drm_edid *drm_edid)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -3340,7 +3340,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	}
 }
 
-STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
+VISIBLE_IF_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
 {
 	struct amdgpu_i2c_adapter *i2c = i2c_get_adapdata(i2c_adap);
@@ -3386,7 +3386,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_i2c_xfer);
 
-STATIC_IFN_KUNIT u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap)
+VISIBLE_IF_KUNIT u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
@@ -3751,7 +3751,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	return ret;
 }
 
-STATIC_IFN_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
+VISIBLE_IF_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
 				     const struct edid *edid)
 {
 	u8 *edid_ext = NULL;
@@ -3795,7 +3795,7 @@ STATIC_IFN_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(parse_edid_displayid_vrr);
 
-STATIC_IFN_KUNIT int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+VISIBLE_IF_KUNIT int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -3807,7 +3807,7 @@ STATIC_IFN_KUNIT int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 }
 EXPORT_IF_KUNIT(get_amd_vsdb);
 
-STATIC_IFN_KUNIT int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+VISIBLE_IF_KUNIT int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			       const struct edid *edid,
 			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 4e9eb3ff2c90..f26b6d1d7a37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -145,7 +145,7 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 			   struct amdgpu_encoder *aencoder,
 			   uint32_t link_index);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 		       struct i2c_msg *msgs, int num);
 u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index db546dd44b91..c58cbf00543f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -44,7 +44,7 @@ static const char *const pipe_crc_sources[] = {
 	"auto",
 };
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source)
 {
 	if (!source || !strcmp(source, "none"))
@@ -62,7 +62,7 @@ enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source)
 }
 EXPORT_IF_KUNIT(dm_parse_crc_source);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC) ||
@@ -70,7 +70,7 @@ bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src)
 }
 EXPORT_IF_KUNIT(dm_is_crc_source_crtc);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_DPRX) ||
@@ -78,7 +78,7 @@ bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src)
 }
 EXPORT_IF_KUNIT(dm_is_crc_source_dprx);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER) ||
@@ -97,7 +97,7 @@ EXPORT_IF_KUNIT(dm_need_crc_dither);
  *
  * Return: true if the DP AUX handle is needed, false otherwise.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool dm_need_dp_aux(enum amdgpu_dm_pipe_crc_source source,
 		    enum amdgpu_dm_pipe_crc_source cur_crc_src)
 {
@@ -116,7 +116,7 @@ EXPORT_IF_KUNIT(dm_need_dp_aux);
  *
  * Return: true if drm_dp_start_crc() should be called, false otherwise.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool dm_crc_source_should_start_dprx(enum amdgpu_dm_pipe_crc_source source,
 				      enum amdgpu_dm_pipe_crc_source cur_crc_src)
 {
@@ -136,7 +136,7 @@ EXPORT_IF_KUNIT(dm_crc_source_should_start_dprx);
  *
  * Return: true if drm_dp_stop_crc() should be called, false otherwise.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool dm_crc_source_should_stop_dprx(enum amdgpu_dm_pipe_crc_source source,
 				     enum amdgpu_dm_pipe_crc_source cur_crc_src)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 8bb8a6f6c148..12a671858eb3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -151,7 +151,7 @@ void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev);
 #define amdgpu_dm_crtc_secure_display_create_contexts(x)
 #endif
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source);
 bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src);
 bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 1d941be73561..4a6ab4523132 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -170,7 +170,7 @@ bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_is_headless);
 
-STATIC_IFN_KUNIT void amdgpu_dm_idle_worker(struct work_struct *work)
+VISIBLE_IF_KUNIT void amdgpu_dm_idle_worker(struct work_struct *work)
 {
 	struct idle_workqueue *idle_work;
 
@@ -223,7 +223,7 @@ struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(idle_create_workqueue);
 
-STATIC_IFN_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
+VISIBLE_IF_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 {
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
@@ -410,7 +410,7 @@ void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_disable_vblank);
 
-STATIC_IFN_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
+VISIBLE_IF_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state)
 {
 	struct dm_crtc_state *cur = to_dm_crtc_state(state);
@@ -427,7 +427,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_destroy_state);
 
-STATIC_IFN_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc)
+VISIBLE_IF_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state, *cur;
 
@@ -476,7 +476,7 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 	kfree(crtc);
 }
 
-STATIC_IFN_KUNIT void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
+VISIBLE_IF_KUNIT void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
@@ -592,7 +592,7 @@ static void amdgpu_dm_crtc_helper_disable(struct drm_crtc *crtc)
 {
 }
 
-STATIC_IFN_KUNIT int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
+VISIBLE_IF_KUNIT int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
 {
 	struct drm_atomic_commit *state = new_crtc_state->state;
 	struct drm_plane *plane;
@@ -625,7 +625,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_sta
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_count_crtc_active_planes);
 
-STATIC_IFN_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
+VISIBLE_IF_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 						     struct drm_crtc_state *new_crtc_state)
 {
 	struct dm_crtc_state *dm_new_crtc_state =
@@ -641,7 +641,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_update_crtc_active_planes);
 
-STATIC_IFN_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
+VISIBLE_IF_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 					       const struct drm_display_mode *mode,
 					       struct drm_display_mode *adjusted_mode)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index 93c6d0d8d7fd..a8b2471b3438 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -42,7 +42,7 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable);
 
 bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 				      const struct drm_display_mode *mode,
 				      struct drm_display_mode *adjusted_mode);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index d565433ea06d..d6c33c107e11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -173,7 +173,7 @@ bool amdgpu_dm_should_update_native_cursor(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_should_update_native_cursor);
 
-STATIC_IFN_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
+VISIBLE_IF_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 					 int *src_w, int *src_h)
 {
 	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
@@ -192,7 +192,7 @@ STATIC_IFN_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_s
 }
 EXPORT_IF_KUNIT(dm_get_oriented_plane_size);
 
-STATIC_IFN_KUNIT void
+VISIBLE_IF_KUNIT void
 dm_get_plane_scale(struct drm_plane_state *plane_state,
 		   int *out_plane_scale_w, int *out_plane_scale_h)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
index 5f619e4474aa..2f3cf3266aff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
@@ -42,11 +42,11 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 				   struct dm_crtc_state *dm_crtc_state,
 				   enum amdgpu_dm_cursor_mode *cursor_mode);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 				int *src_w, int *src_h);
 void dm_get_plane_scale(struct drm_plane_state *plane_state,
 			int *out_plane_scale_w, int *out_plane_scale_h);
-#endif /* CONFIG_DRM_AMD_DC_KUNIT_TEST */
+#endif /* CONFIG_KUNIT */
 
 #endif /* __AMDGPU_DM_CURSOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 9ff25bc8ee5a..ecf1faca4d4b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -386,7 +386,7 @@ dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
 	return DMUB_STATUS_TIMEOUT;
 }
 
-STATIC_IFN_KUNIT void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
+VISIBLE_IF_KUNIT void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
 {
 	void *bb;
 	long long addr;
@@ -842,7 +842,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_process_dmub_aux_transfer_sync);
 
-STATIC_IFN_KUNIT void abort_fused_io(
+VISIBLE_IF_KUNIT void abort_fused_io(
 		struct dc_context *ctx,
 		const struct dmub_cmd_fused_request *request
 )
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
index 31d5f8c265c0..f7f9ebbbb262 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
@@ -66,7 +66,7 @@ int dm_init_microcode(struct amdgpu_device *adev);
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 #define FIRMWARE_NAVI12_DMCU		"amdgpu/navi12_dmcu.bin"
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 struct dc_context;
 struct dmub_cmd_fused_request;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 47cbc826ed45..20c1ce8cda44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -38,7 +38,8 @@
  */
 #define PSP_SRM_VERSION_MAX 0xFFFF
 
-STATIC_IFN_KUNIT bool lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
+VISIBLE_IF_KUNIT
+bool lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 	struct i2c_payload i2c_payloads[] = {{true, address, size, (void *)data} };
@@ -49,7 +50,8 @@ STATIC_IFN_KUNIT bool lp_write_i2c(void *handle, uint32_t address, const uint8_t
 }
 EXPORT_IF_KUNIT(lp_write_i2c);
 
-STATIC_IFN_KUNIT bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint32_t size)
+VISIBLE_IF_KUNIT
+bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
@@ -62,7 +64,8 @@ STATIC_IFN_KUNIT bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset
 }
 EXPORT_IF_KUNIT(lp_read_i2c);
 
-STATIC_IFN_KUNIT bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
+VISIBLE_IF_KUNIT
+bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
@@ -70,7 +73,7 @@ STATIC_IFN_KUNIT bool lp_write_dpcd(void *handle, uint32_t address, const uint8_
 }
 EXPORT_IF_KUNIT(lp_write_dpcd);
 
-STATIC_IFN_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
+VISIBLE_IF_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
@@ -78,7 +81,7 @@ STATIC_IFN_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data
 }
 EXPORT_IF_KUNIT(lp_read_dpcd);
 
-STATIC_IFN_KUNIT bool lp_atomic_write_poll_read_i2c(
+VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_i2c(
 						void *handle,
 						const struct mod_hdcp_atomic_op_i2c *write,
 						const struct mod_hdcp_atomic_op_i2c *poll,
@@ -93,7 +96,7 @@ STATIC_IFN_KUNIT bool lp_atomic_write_poll_read_i2c(
 }
 EXPORT_IF_KUNIT(lp_atomic_write_poll_read_i2c);
 
-STATIC_IFN_KUNIT bool lp_atomic_write_poll_read_aux(
+VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_aux(
 						void *handle,
 						const struct mod_hdcp_atomic_op_aux *write,
 						const struct mod_hdcp_atomic_op_aux *poll,
@@ -108,7 +111,7 @@ STATIC_IFN_KUNIT bool lp_atomic_write_poll_read_aux(
 }
 EXPORT_IF_KUNIT(lp_atomic_write_poll_read_aux);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
 {
 	struct ta_hdcp_shared_memory *hdcp_cmd;
@@ -134,7 +137,7 @@ uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *s
 }
 EXPORT_IF_KUNIT(psp_get_srm);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 int psp_set_srm(struct psp_context *psp,
 		       u8 *srm, uint32_t srm_size, uint32_t *srm_version)
 {
@@ -164,7 +167,7 @@ int psp_set_srm(struct psp_context *psp,
 }
 EXPORT_IF_KUNIT(psp_set_srm);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void process_output(struct hdcp_workqueue *hdcp_work)
 {
 	struct mod_hdcp_output output = hdcp_work->output;
@@ -187,7 +190,7 @@ void process_output(struct hdcp_workqueue *hdcp_work)
 }
 EXPORT_IF_KUNIT(process_output);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool hdcp_get_content_protection_from_status(
 	unsigned int hdcp_content_type,
 	enum mod_hdcp_encryption_status encryption_status,
@@ -214,7 +217,7 @@ bool hdcp_get_content_protection_from_status(
 }
 EXPORT_IF_KUNIT(hdcp_get_content_protection_from_status);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void hdcp_get_link_display_adjustments(
 	bool enable_encryption,
 	u8 content_type,
@@ -251,7 +254,7 @@ void hdcp_get_link_display_adjustments(
 }
 EXPORT_IF_KUNIT(hdcp_get_link_display_adjustments);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void link_lock(struct hdcp_workqueue *work, bool lock)
 {
 	int i = 0;
@@ -265,7 +268,7 @@ void link_lock(struct hdcp_workqueue *work, bool lock)
 }
 EXPORT_IF_KUNIT(link_lock);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
 					    struct hdcp_workqueue *hdcp_w,
 					    unsigned int conn_index,
@@ -321,7 +324,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 }
 EXPORT_IF_KUNIT(hdcp_update_display);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 				unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector)
@@ -386,7 +389,7 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index
 }
 EXPORT_IF_KUNIT(hdcp_handle_cpirq);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void event_callback(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
@@ -405,7 +408,7 @@ void event_callback(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_callback);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void event_property_update(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work = container_of(work, struct hdcp_workqueue,
@@ -467,7 +470,7 @@ void event_property_update(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_property_update);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void event_property_validate(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work =
@@ -519,7 +522,7 @@ void event_property_validate(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_property_validate);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void event_watchdog_timer(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
@@ -540,7 +543,7 @@ void event_watchdog_timer(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_watchdog_timer);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void event_cpirq(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
@@ -572,7 +575,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 }
 EXPORT_IF_KUNIT(hdcp_destroy);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool enable_assr(void *handle, struct dc_link *link)
 {
 	struct hdcp_workqueue *hdcp_work = handle;
@@ -608,7 +611,7 @@ bool enable_assr(void *handle, struct dc_link *link)
 }
 EXPORT_IF_KUNIT(enable_assr);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void update_config(void *handle, struct cp_psp_stream_config *config)
 {
 	struct hdcp_workqueue *hdcp_work = handle;
@@ -745,7 +748,7 @@ EXPORT_IF_KUNIT(update_config);
  *	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
  *	incorrect/corrupted and we should correct our SRM by getting it from PSP
  */
-STATIC_IFN_KUNIT ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
+VISIBLE_IF_KUNIT ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 			      const struct bin_attribute *bin_attr, char *buffer,
 			      loff_t pos, size_t count)
 {
@@ -770,7 +773,7 @@ STATIC_IFN_KUNIT ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 }
 EXPORT_IF_KUNIT(srm_data_write);
 
-STATIC_IFN_KUNIT ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
+VISIBLE_IF_KUNIT ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
 			     const struct bin_attribute *bin_attr, char *buffer,
 			     loff_t pos, size_t count)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 01c61e4d1176..c11670fc57f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -100,7 +100,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *work);
 
 struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 void process_output(struct hdcp_workqueue *hdcp_work);
 bool hdcp_get_content_protection_from_status(
 	unsigned int hdcp_content_type,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ced8b3d2d762..54089591797d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -89,7 +89,7 @@ union vcp_reply {
 	unsigned char raw[11];
 };
 
-STATIC_IFN_KUNIT u32 edid_extract_panel_id(struct edid *edid)
+VISIBLE_IF_KUNIT u32 edid_extract_panel_id(struct edid *edid)
 {
 	return (u32)edid->mfg_id[0] << 24   |
 	       (u32)edid->mfg_id[1] << 16   |
@@ -97,7 +97,7 @@ STATIC_IFN_KUNIT u32 edid_extract_panel_id(struct edid *edid)
 }
 EXPORT_IF_KUNIT(edid_extract_panel_id);
 
-STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
+VISIBLE_IF_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 			      struct dc_edid_caps *edid_caps)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
@@ -251,7 +251,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 }
 EXPORT_IF_KUNIT(dm_helpers_parse_edid_caps);
 
-STATIC_IFN_KUNIT void
+VISIBLE_IF_KUNIT void
 fill_dc_mst_payload_table_from_drm(struct dc_link *link,
 				   bool enable,
 				   struct drm_dp_mst_atomic_payload *target_payload,
@@ -309,7 +309,7 @@ void dm_helpers_dp_update_branch_info(
 {}
 EXPORT_IF_KUNIT(dm_helpers_dp_update_branch_info);
 
-STATIC_IFN_KUNIT void dm_helpers_construct_old_payload(
+VISIBLE_IF_KUNIT void dm_helpers_construct_old_payload(
 			struct drm_dp_mst_topology_mgr *mgr,
 			struct drm_dp_mst_topology_state *mst_state,
 			struct drm_dp_mst_atomic_payload *new_payload,
@@ -742,7 +742,7 @@ bool dm_helpers_execute_fused_io(
 }
 EXPORT_IF_KUNIT(dm_helpers_execute_fused_io);
 
-STATIC_IFN_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
+VISIBLE_IF_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		bool is_write_cmd,
 		unsigned char cmd,
 		unsigned int length,
@@ -816,7 +816,7 @@ STATIC_IFN_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 }
 EXPORT_IF_KUNIT(execute_synaptics_rc_command);
 
-STATIC_IFN_KUNIT void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
+VISIBLE_IF_KUNIT void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 {
 	unsigned char data[16] = {0};
 
@@ -885,7 +885,7 @@ EXPORT_IF_KUNIT(apply_synaptics_fifo_reset_wa);
 /* MST Dock */
 static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
 
-STATIC_IFN_KUNIT uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
+VISIBLE_IF_KUNIT uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 		struct drm_dp_aux *aux,
 		const struct dc_stream_state *stream,
 		bool enable)
@@ -1045,7 +1045,7 @@ bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 }
 EXPORT_IF_KUNIT(dm_helpers_is_dp_sink_present);
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
 {
 	struct drm_connector *connector = data;
@@ -1085,7 +1085,7 @@ dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
 }
 EXPORT_IF_KUNIT(dm_helpers_probe_acpi_edid);
 
-STATIC_IFN_KUNIT const struct drm_edid *
+VISIBLE_IF_KUNIT const struct drm_edid *
 dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1108,7 +1108,7 @@ dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(dm_helpers_read_acpi_edid);
 
-STATIC_IFN_KUNIT const struct drm_edid *
+VISIBLE_IF_KUNIT const struct drm_edid *
 dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_bios *bios = link->ctx->dc_bios;
@@ -1148,7 +1148,7 @@ dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_conn
 }
 EXPORT_IF_KUNIT(dm_helpers_read_vbios_hardcoded_edid);
 
-STATIC_IFN_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
+VISIBLE_IF_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
 {
 	uint8_t max_frl_rate;
 
@@ -1171,7 +1171,7 @@ STATIC_IFN_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_pe
 }
 EXPORT_IF_KUNIT(get_max_frl_rate);
 
-STATIC_IFN_KUNIT uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
+VISIBLE_IF_KUNIT uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
 {
 	uint8_t dsc_max_slices;
 
@@ -1644,7 +1644,7 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 }
 EXPORT_IF_KUNIT(dm_helpers_dp_mst_update_branch_bandwidth);
 
-STATIC_IFN_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
+VISIBLE_IF_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
 	DP_BRANCH_DEVICE_ID_0060AD,
 	DP_BRANCH_DEVICE_ID_00E04C,
 	DP_BRANCH_DEVICE_ID_90CC24,
@@ -1653,13 +1653,13 @@ STATIC_IFN_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
 };
 EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist);
 
-STATIC_IFN_KUNIT uint32_t dm_freesync_pcon_whitelist_count(void)
+VISIBLE_IF_KUNIT uint32_t dm_freesync_pcon_whitelist_count(void)
 {
 	return ARRAY_SIZE(dm_freesync_pcon_whitelist);
 }
 EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist_count);
 
-STATIC_IFN_KUNIT bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
+VISIBLE_IF_KUNIT bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
 {
 	u32 i;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
index 0eab820757c1..7e668b7ba1bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
@@ -6,7 +6,7 @@
 #ifndef __AMDGPU_DM_HELPERS_H__
 #define __AMDGPU_DM_HELPERS_H__
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 #include <drm/drm_edid.h>
 
 struct amdgpu_dm_connector;
@@ -56,6 +56,6 @@ void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux);
 uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(struct drm_dp_aux *aux,
 							const struct dc_stream_state *stream,
 							bool enable);
-#endif /* CONFIG_DRM_AMD_DC_KUNIT_TEST */
+#endif /* CONFIG_KUNIT */
 
 #endif /* __AMDGPU_DM_HELPERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 74a8735168aa..1331c59ca204 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -609,7 +609,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_resume_late);
  * amdgpu_dm_irq_schedule_work - schedule all work items registered for the
  * "irq_source".
  */
-STATIC_IFN_KUNIT void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 					enum dc_irq_source irq_source)
 {
 	struct  list_head *handler_list = &adev->dm.irq_handler_list_low_tab[irq_source];
@@ -670,7 +670,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_schedule_work);
  * amdgpu_dm_irq_immediate_work
  * Callback high irq work immediately, don't send to work queue
  */
-STATIC_IFN_KUNIT void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 					 enum dc_irq_source irq_source)
 {
 	struct amdgpu_dm_irq_handler_data *handler_data;
@@ -717,7 +717,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_ack);
  * Calls all registered high irq work immediately, and schedules work for low
  * irq. The DM IRQ table is used to find the corresponding handlers.
  */
-STATIC_IFN_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
@@ -739,7 +739,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_irq_handler);
 
-STATIC_IFN_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
+VISIBLE_IF_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
 {
 	switch (type) {
 	case AMDGPU_HPD_1:
@@ -760,7 +760,7 @@ STATIC_IFN_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hpd_to_dal_irq_source);
 
-STATIC_IFN_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       unsigned int type,
 				       enum amdgpu_interrupt_state state)
@@ -807,7 +807,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-STATIC_IFN_KUNIT int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 unsigned int crtc_id,
 					 enum amdgpu_interrupt_state state)
@@ -822,7 +822,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_pflip_irq_state);
 
-STATIC_IFN_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -837,7 +837,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_crtc_irq_state);
 
-STATIC_IFN_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -852,7 +852,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_vline0_irq_state);
 
-STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -865,7 +865,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *a
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_outbox_irq_state);
 
-STATIC_IFN_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
 					   unsigned int crtc_id,
 					   enum amdgpu_interrupt_state state)
@@ -880,7 +880,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_vupdate_irq_state);
 
-STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
 					   unsigned int type,
 					   enum amdgpu_interrupt_state state)
@@ -1108,7 +1108,7 @@ static void force_connector_state(
 	mutex_unlock(&aconnector->hpd_lock);
 }
 
-STATIC_IFN_KUNIT void dm_handle_hpd_rx_offload_work(struct work_struct *work)
+VISIBLE_IF_KUNIT void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 {
 	struct hpd_rx_irq_offload_work *offload_work;
 	struct amdgpu_dm_connector *aconnector;
@@ -1251,7 +1251,7 @@ void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hpd_rx_irq_work_suspend);
 
-STATIC_IFN_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
+VISIBLE_IF_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
 {
 	if (!sink1 || !sink2)
 		return false;
@@ -1345,7 +1345,7 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hdmi_hpd_debounce_work);
 
-STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+VISIBLE_IF_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 				  enum dc_detect_reason reason)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1445,7 +1445,7 @@ STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnect
 }
 EXPORT_IF_KUNIT(handle_hpd_irq_helper);
 
-STATIC_IFN_KUNIT void handle_hpd_irq(void *param)
+VISIBLE_IF_KUNIT void handle_hpd_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 
@@ -1454,8 +1454,10 @@ STATIC_IFN_KUNIT void handle_hpd_irq(void *param)
 }
 EXPORT_IF_KUNIT(handle_hpd_irq);
 
-STATIC_IFN_KUNIT void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_rx_irq_offload_work_queue *offload_wq,
-							union hpd_irq_data hpd_irq_data)
+VISIBLE_IF_KUNIT void
+schedule_hpd_rx_offload_work(struct amdgpu_device *adev,
+			     struct hpd_rx_irq_offload_work_queue *offload_wq,
+			     union hpd_irq_data hpd_irq_data)
 {
 	struct hpd_rx_irq_offload_work *offload_work = kzalloc_obj(*offload_work);
 
@@ -1474,7 +1476,7 @@ STATIC_IFN_KUNIT void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, s
 }
 EXPORT_IF_KUNIT(schedule_hpd_rx_offload_work);
 
-STATIC_IFN_KUNIT void handle_hpd_rx_irq(void *param)
+VISIBLE_IF_KUNIT void handle_hpd_rx_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 	struct drm_connector *connector = &aconnector->base;
@@ -1617,7 +1619,7 @@ EXPORT_IF_KUNIT(handle_hpd_rx_irq);
  * Dmub Hpd interrupt processing callback. Gets displayindex through the
  * ink index and calls helper to do the processing.
  */
-STATIC_IFN_KUNIT void dmub_hpd_callback(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT void dmub_hpd_callback(struct amdgpu_device *adev,
 			      struct dmub_notification *notify)
 {
 	struct amdgpu_dm_connector *aconnector;
@@ -1693,7 +1695,7 @@ EXPORT_IF_KUNIT(dmub_hpd_callback);
  * HPD sense changes can occur during low power states and need to be
  * notified from firmware to driver.
  */
-STATIC_IFN_KUNIT void dmub_hpd_sense_callback(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT void dmub_hpd_sense_callback(struct amdgpu_device *adev,
 			      struct dmub_notification *notify)
 {
 	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
@@ -1812,7 +1814,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_get_crtc_by_otg_inst);
  * Handles the pageflip interrupt by notifying all interested parties
  * that the pageflip has been completed.
  */
-STATIC_IFN_KUNIT void dm_pflip_high_irq(void *interrupt_params)
+VISIBLE_IF_KUNIT void dm_pflip_high_irq(void *interrupt_params)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
 	struct common_irq_params *irq_params = interrupt_params;
@@ -1910,7 +1912,7 @@ STATIC_IFN_KUNIT void dm_pflip_high_irq(void *interrupt_params)
 }
 EXPORT_IF_KUNIT(dm_pflip_high_irq);
 
-STATIC_IFN_KUNIT void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
+VISIBLE_IF_KUNIT void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
 {
 	struct vupdate_offload_work *work = container_of(offload_work, struct vupdate_offload_work, work);
 	struct amdgpu_device *adev = work->adev;
@@ -2086,7 +2088,7 @@ static void dm_crtc_high_irq_handler(struct amdgpu_device *adev,
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
 
-STATIC_IFN_KUNIT void dm_vupdate_high_irq(void *interrupt_params)
+VISIBLE_IF_KUNIT void dm_vupdate_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
@@ -2172,7 +2174,7 @@ EXPORT_IF_KUNIT(dm_vupdate_high_irq);
  * Used on DCE (VLINE0, set to vblank start). On DCN the equivalent handling is
  * driven by VUPDATE_NO_LOCK in dm_vupdate_high_irq().
  */
-STATIC_IFN_KUNIT void dm_crtc_high_irq(void *interrupt_params)
+VISIBLE_IF_KUNIT void dm_crtc_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
@@ -2209,7 +2211,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 }
 #endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
 
-STATIC_IFN_KUNIT void dm_handle_hpd_work(struct work_struct *work)
+VISIBLE_IF_KUNIT void dm_handle_hpd_work(struct work_struct *work)
 {
 	struct dmub_hpd_work *dmub_hpd_wrk;
 
@@ -2231,7 +2233,7 @@ STATIC_IFN_KUNIT void dm_handle_hpd_work(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(dm_handle_hpd_work);
 
-STATIC_IFN_KUNIT const char *dmub_notification_type_str(enum dmub_notification_type e)
+VISIBLE_IF_KUNIT const char *dmub_notification_type_str(enum dmub_notification_type e)
 {
 	switch (e) {
 	case DMUB_NOTIFICATION_NO_DATA:
@@ -2264,7 +2266,7 @@ EXPORT_IF_KUNIT(dmub_notification_type_str);
  * Handles the Outbox Interrupt
  * event handler.
  */
-STATIC_IFN_KUNIT void dm_dmub_outbox1_low_irq(void *interrupt_params)
+VISIBLE_IF_KUNIT void dm_dmub_outbox1_low_irq(void *interrupt_params)
 {
 	struct dmub_notification notify = {0};
 	struct common_irq_params *irq_params = interrupt_params;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index bc16ecc67329..b0192e7dd312 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -150,7 +150,7 @@ int amdgpu_dm_dce110_register_irq_handlers(struct amdgpu_device *adev);
 int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev);
 int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 struct amdgpu_irq_src;
 struct amdgpu_iv_entry;
 enum amdgpu_interrupt_state;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 4e57572e12b6..b4cedf760f6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -44,7 +44,7 @@
  * This function defines the idle state management FSM. Invalid transitions
  * are ignored and will not progress the FSM.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
 		       enum amdgpu_dm_ism_event event,
 		       enum amdgpu_dm_ism_state *next_state)
@@ -130,7 +130,7 @@ bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
 }
 EXPORT_IF_KUNIT(dm_ism_next_state);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
 				     const struct dc_stream_state *stream)
 {
@@ -163,7 +163,7 @@ EXPORT_IF_KUNIT(dm_ism_get_sso_delay);
  * Calculates the delay before allowing idle optimizations based on recent
  * idle history and the current stream timing.
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
 				     const struct dc_stream_state *stream)
 {
@@ -230,7 +230,7 @@ EXPORT_IF_KUNIT(dm_ism_get_idle_allow_delay);
  * dm_ism_insert_record - Insert a record into the circular history buffer
  * @ism: ISM instance
  */
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
 {
 	struct amdgpu_dm_ism_record *record;
@@ -249,7 +249,7 @@ void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
 EXPORT_IF_KUNIT(dm_ism_insert_record);
 
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism)
 {
 	ism->last_idle_timestamp_ns = ktime_get_ns();
@@ -257,7 +257,7 @@ void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism)
 EXPORT_IF_KUNIT(dm_ism_set_last_idle_ts);
 
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
 				 enum amdgpu_dm_ism_event event)
 {
@@ -332,7 +332,7 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	}
 }
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 enum amdgpu_dm_ism_event dm_ism_dispatch_next_event(
 	enum amdgpu_dm_ism_state current_state,
 	uint64_t delay_ns,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
index afce16f7085a..e2a1caa57107 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
@@ -149,7 +149,7 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm);
 void amdgpu_dm_ism_force_full_power(struct amdgpu_display_manager *dm);
 void amdgpu_dm_ism_enable(struct amdgpu_display_manager *dm);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
 		       enum amdgpu_dm_ism_event event,
 		       enum amdgpu_dm_ism_state *next_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7261317d4c0f..2d539faa23e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -56,7 +56,7 @@
  * Translate a failed AUX transaction's operation result into an errno-style
  * return value. @result is returned unchanged for AUX_RET_SUCCESS.
  */
-STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer_result(ssize_t result,
+VISIBLE_IF_KUNIT ssize_t dm_dp_aux_transfer_result(ssize_t result,
 						   enum aux_return_code_type operation_result)
 {
 	switch (operation_result) {
@@ -84,7 +84,7 @@ EXPORT_IF_KUNIT(dm_dp_aux_transfer_result);
 /*
  * Derive the AUX payload transaction flags from a DP AUX request field.
  */
-STATIC_IFN_KUNIT void dm_dp_aux_fill_payload_flags(u8 request,
+VISIBLE_IF_KUNIT void dm_dp_aux_fill_payload_flags(u8 request,
 						   struct aux_payload *payload)
 {
 	payload->i2c_over_aux = (request & DP_AUX_NATIVE_WRITE) == 0;
@@ -98,7 +98,7 @@ EXPORT_IF_KUNIT(dm_dp_aux_fill_payload_flags);
 /*
  * This function handles both native AUX and I2C-Over-AUX transactions.
  */
-STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
+VISIBLE_IF_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 					    struct drm_dp_aux_msg *msg)
 {
 	ssize_t result = 0;
@@ -207,7 +207,7 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 }
 
 
-STATIC_IFN_KUNIT void
+VISIBLE_IF_KUNIT void
 amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector)
 {
 	aconnector->drm_edid = NULL;
@@ -337,7 +337,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 }
 #endif
 
-STATIC_IFN_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
 {
 	union dp_downstream_port_present ds_port_present;
 
@@ -357,7 +357,7 @@ STATIC_IFN_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector
 }
 EXPORT_IF_KUNIT(retrieve_downstream_port_device);
 
-STATIC_IFN_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector)
+VISIBLE_IF_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_dp_mst_port *port = aconnector->mst_output_port;
@@ -519,7 +519,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-STATIC_IFN_KUNIT struct drm_encoder *
+VISIBLE_IF_KUNIT struct drm_encoder *
 dm_mst_atomic_best_encoder(struct drm_connector *connector,
 			   struct drm_atomic_commit *state)
 {
@@ -532,7 +532,7 @@ dm_mst_atomic_best_encoder(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(dm_mst_atomic_best_encoder);
 
-STATIC_IFN_KUNIT int
+VISIBLE_IF_KUNIT int
 dm_dp_mst_detect(struct drm_connector *connector,
 		 struct drm_modeset_acquire_ctx *ctx, bool force)
 {
@@ -604,7 +604,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(dm_dp_mst_detect);
 
-STATIC_IFN_KUNIT int dm_dp_mst_atomic_check(struct drm_connector *connector,
+VISIBLE_IF_KUNIT int dm_dp_mst_atomic_check(struct drm_connector *connector,
 					    struct drm_atomic_commit *state)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -743,7 +743,7 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
  * Select the ESI[1] mask used to filter the MST sideband ready bits for a
  * given message-ready event type.
  */
-STATIC_IFN_KUNIT u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type)
+VISIBLE_IF_KUNIT u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type)
 {
 	switch (msg_rdy_type) {
 	case DOWN_REP_MSG_RDY_EVENT:
@@ -762,7 +762,7 @@ EXPORT_IF_KUNIT(dm_mst_msg_ready_mask);
 /*
  * Select the DPCD ESI address and read length based on the DPCD revision.
  */
-STATIC_IFN_KUNIT void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr,
+VISIBLE_IF_KUNIT void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr,
 					     u8 *dpcd_bytes_to_read)
 {
 	if (dpcd_rev < 0x12) {
@@ -862,7 +862,7 @@ void dm_handle_mst_sideband_msg_ready_event(
 }
 EXPORT_IF_KUNIT(dm_handle_mst_sideband_msg_ready_event);
 
-STATIC_IFN_KUNIT void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
+VISIBLE_IF_KUNIT void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
 {
 	dm_handle_mst_sideband_msg_ready_event(mgr, DOWN_REP_MSG_RDY_EVENT);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 2ae9d4b88888..c999f57a823f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -101,7 +101,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	struct amdgpu_dm_connector *aconnector,
 	struct dc_stream_state *stream);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 void amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector);
 bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
 bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index a2b8f7033616..226650cb446c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -136,7 +136,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_blending_from_plane_state);
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
+VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
 						   uint64_t *cap, uint64_t mod)
 {
 	if (!*mods)
@@ -163,7 +163,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *si
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier);
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
+VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
 							 uint64_t *cap, uint64_t mod)
 {
 	uint64_t i;
@@ -179,13 +179,13 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier_dedup);
 
-STATIC_IFN_KUNIT bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
+VISIBLE_IF_KUNIT bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
 {
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_has_dcc);
 
-STATIC_IFN_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier)
+VISIBLE_IF_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier)
 {
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return 0;
@@ -194,7 +194,7 @@ STATIC_IFN_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_gfx9_swizzle_mode);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
+VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
 						struct dc_tiling_info *tiling_info,
 						uint64_t modifier)
 {
@@ -229,8 +229,9 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier);
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
-									struct dc_tiling_info *tiling_info)
+VISIBLE_IF_KUNIT
+void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
+						       struct dc_tiling_info *tiling_info)
 {
 	/* Fill GFX9 params */
 	tiling_info->gfx9.num_pipes =
@@ -251,9 +252,10 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const st
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_device);
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
-									  struct dc_tiling_info *tiling_info,
-									  uint64_t modifier)
+VISIBLE_IF_KUNIT
+void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
+							 struct dc_tiling_info *tiling_info,
+							 uint64_t modifier)
 {
 	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
 	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
@@ -280,7 +282,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 						  const enum surface_pixel_format format,
 						  const enum dc_rotation_angle rotation,
 						  const struct dc_tiling_info *tiling_info,
@@ -330,7 +332,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
 									       const struct amdgpu_framebuffer *afb,
 									       const enum surface_pixel_format format,
 									       const enum dc_rotation_angle rotation,
@@ -382,7 +384,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgp
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
+VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
 										const struct amdgpu_framebuffer *afb,
 										const enum surface_pixel_format format,
 										const enum dc_rotation_angle rotation,
@@ -991,7 +993,9 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 
 }
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
+VISIBLE_IF_KUNIT
+int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type,
+										uint64_t **mods)
 {
 	uint64_t size = 0, capacity = 128;
 	*mods = kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
@@ -1049,7 +1053,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *a
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_get_plane_modifiers);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
+VISIBLE_IF_KUNIT int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
 						       const struct dc_plane_cap *plane_cap,
 						       uint32_t *formats, int max_formats)
 {
@@ -1319,7 +1323,7 @@ static void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 	amdgpu_bo_unref(&rbo);
 }
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
+VISIBLE_IF_KUNIT void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 								   struct drm_framebuffer *fb,
 								   int *min_downscale, int *max_upscale)
 {
@@ -1506,7 +1510,7 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_dc_scaling_info);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
+VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 						  struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
@@ -1554,7 +1558,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_check);
 
-STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
+VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 							struct drm_atomic_commit *state, bool flip)
 {
 	struct drm_crtc_state *new_crtc_state;
@@ -1737,7 +1741,7 @@ static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
 	amdgpu_dm_plane_handle_cursor_update(plane, old_state);
 }
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
+VISIBLE_IF_KUNIT void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane->state);
 	struct drm_framebuffer *fb = plane->state->fb;
@@ -1770,7 +1774,7 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
 	.panic_flush = amdgpu_dm_plane_panic_flush,
 };
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
+VISIBLE_IF_KUNIT void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 {
 	struct dm_plane_state *amdgpu_state;
 
@@ -1789,7 +1793,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_reset);
 
-STATIC_IFN_KUNIT struct drm_plane_state *
+VISIBLE_IF_KUNIT struct drm_plane_state *
 amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
@@ -1831,7 +1835,7 @@ amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_duplicate_state);
 
-STATIC_IFN_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
+VISIBLE_IF_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 							   uint32_t format,
 							   uint64_t modifier)
 {
@@ -1902,7 +1906,7 @@ STATIC_IFN_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *pla
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_format_mod_supported);
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
+VISIBLE_IF_KUNIT void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 							      struct drm_plane_state *state)
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 092ade738ce9..e45a747b6ce6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -67,7 +67,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 
 bool amdgpu_dm_plane_is_video_format(uint32_t format);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
 				  uint64_t *cap, uint64_t mod);
 void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 3280bfadc6a8..13901a1e6907 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -36,7 +36,7 @@
 #include "dm_helpers.h"
 #include "amdgpu_dm_pp_smu.h"
 
-STATIC_IFN_KUNIT void build_pm_display_cfg(
+VISIBLE_IF_KUNIT void build_pm_display_cfg(
 		struct amd_pp_display_configuration *pm_display_cfg,
 		const struct dm_pp_display_configuration *pp_display_cfg)
 {
@@ -104,7 +104,7 @@ bool dm_pp_apply_display_requirements(
 }
 EXPORT_IF_KUNIT(dm_pp_apply_display_requirements);
 
-STATIC_IFN_KUNIT void get_default_clock_levels(
+VISIBLE_IF_KUNIT void get_default_clock_levels(
 		enum dm_pp_clock_type clk_type,
 		struct dm_pp_clock_levels *clks)
 {
@@ -137,7 +137,7 @@ STATIC_IFN_KUNIT void get_default_clock_levels(
 }
 EXPORT_IF_KUNIT(get_default_clock_levels);
 
-STATIC_IFN_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
+VISIBLE_IF_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
 		enum dm_pp_clock_type dm_pp_clk_type)
 {
 	enum amd_pp_clock_type amd_pp_clk_type = 0;
@@ -180,7 +180,7 @@ STATIC_IFN_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
 }
 EXPORT_IF_KUNIT(dc_to_pp_clock_type);
 
-STATIC_IFN_KUNIT void pp_to_dc_clock_levels(
+VISIBLE_IF_KUNIT void pp_to_dc_clock_levels(
 		const struct amd_pp_clocks *pp_clks,
 		struct dm_pp_clock_levels *dc_clks,
 		enum dm_pp_clock_type dc_clk_type)
@@ -207,7 +207,7 @@ STATIC_IFN_KUNIT void pp_to_dc_clock_levels(
 }
 EXPORT_IF_KUNIT(pp_to_dc_clock_levels);
 
-STATIC_IFN_KUNIT void pp_to_dc_clock_levels_with_latency(
+VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_latency(
 		const struct pp_clock_levels_with_latency *pp_clks,
 		struct dm_pp_clock_levels_with_latency *clk_level_info,
 		enum dm_pp_clock_type dc_clk_type)
@@ -235,7 +235,7 @@ STATIC_IFN_KUNIT void pp_to_dc_clock_levels_with_latency(
 }
 EXPORT_IF_KUNIT(pp_to_dc_clock_levels_with_latency);
 
-STATIC_IFN_KUNIT void pp_to_dc_clock_levels_with_voltage(
+VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_voltage(
 		const struct pp_clock_levels_with_voltage *pp_clks,
 		struct dm_pp_clock_levels_with_voltage *clk_level_info,
 		enum dm_pp_clock_type dc_clk_type)
@@ -264,7 +264,7 @@ STATIC_IFN_KUNIT void pp_to_dc_clock_levels_with_voltage(
 }
 EXPORT_IF_KUNIT(pp_to_dc_clock_levels_with_voltage);
 
-STATIC_IFN_KUNIT void cap_clock_levels_to_validation(
+VISIBLE_IF_KUNIT void cap_clock_levels_to_validation(
 		struct dm_pp_clock_levels *dc_clks,
 		enum dm_pp_clock_type clk_type,
 		const struct amd_pp_simple_clock_info *validation_clks)
@@ -423,7 +423,7 @@ bool dm_pp_apply_clock_for_voltage_request(
 }
 EXPORT_IF_KUNIT(dm_pp_apply_clock_for_voltage_request);
 
-STATIC_IFN_KUNIT void build_wm_clock_ranges_soc15(
+VISIBLE_IF_KUNIT void build_wm_clock_ranges_soc15(
 		const struct pp_smu_wm_range_sets *ranges,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *wm_with_clock_ranges)
 {
@@ -468,7 +468,7 @@ STATIC_IFN_KUNIT void build_wm_clock_ranges_soc15(
 }
 EXPORT_IF_KUNIT(build_wm_clock_ranges_soc15);
 
-STATIC_IFN_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
+VISIBLE_IF_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -482,7 +482,7 @@ STATIC_IFN_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
 }
 EXPORT_IF_KUNIT(pp_rv_set_wm_ranges);
 
-STATIC_IFN_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
+VISIBLE_IF_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -491,7 +491,7 @@ STATIC_IFN_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 }
 EXPORT_IF_KUNIT(pp_rv_set_pme_wa_enable);
 
-STATIC_IFN_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
+VISIBLE_IF_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -500,7 +500,7 @@ STATIC_IFN_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int coun
 }
 EXPORT_IF_KUNIT(pp_rv_set_active_display_count);
 
-STATIC_IFN_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
+VISIBLE_IF_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -509,7 +509,7 @@ STATIC_IFN_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clo
 }
 EXPORT_IF_KUNIT(pp_rv_set_min_deep_sleep_dcfclk);
 
-STATIC_IFN_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
+VISIBLE_IF_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -518,7 +518,7 @@ STATIC_IFN_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int
 }
 EXPORT_IF_KUNIT(pp_rv_set_hard_min_dcefclk_by_freq);
 
-STATIC_IFN_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
+VISIBLE_IF_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -527,7 +527,7 @@ STATIC_IFN_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz
 }
 EXPORT_IF_KUNIT(pp_rv_set_hard_min_fclk_by_freq);
 
-STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
+VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -539,7 +539,7 @@ STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 }
 EXPORT_IF_KUNIT(pp_nv_set_wm_ranges);
 
-STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
+VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -556,7 +556,7 @@ STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, i
 }
 EXPORT_IF_KUNIT(pp_nv_set_display_count);
 
-STATIC_IFN_KUNIT enum pp_smu_status
+VISIBLE_IF_KUNIT enum pp_smu_status
 pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -574,7 +574,7 @@ pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 }
 EXPORT_IF_KUNIT(pp_nv_set_min_deep_sleep_dcfclk);
 
-STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
+VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 		struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -598,7 +598,7 @@ STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 }
 EXPORT_IF_KUNIT(pp_nv_set_hard_min_dcefclk_by_freq);
 
-STATIC_IFN_KUNIT enum pp_smu_status
+VISIBLE_IF_KUNIT enum pp_smu_status
 pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -622,7 +622,7 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 }
 EXPORT_IF_KUNIT(pp_nv_set_hard_min_uclk_by_freq);
 
-STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
+VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
 	struct pp_smu *pp, bool pstate_handshake_supported)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -636,7 +636,7 @@ STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
 }
 EXPORT_IF_KUNIT(pp_nv_set_pstate_handshake_support);
 
-STATIC_IFN_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
+VISIBLE_IF_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 		enum amd_pp_clock_type *clock_type)
 {
 	switch (clock_id) {
@@ -657,7 +657,7 @@ STATIC_IFN_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 }
 EXPORT_IF_KUNIT(pp_smu_nv_clock_id_to_pp);
 
-STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
+VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 		enum pp_smu_nv_clock_id clock_id, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -683,7 +683,7 @@ STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 }
 EXPORT_IF_KUNIT(pp_nv_set_voltage_by_freq);
 
-STATIC_IFN_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
+VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 		struct pp_smu *pp, struct pp_smu_nv_clock_table *max_clocks)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -701,7 +701,7 @@ STATIC_IFN_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 }
 EXPORT_IF_KUNIT(pp_nv_get_maximum_sustainable_clocks);
 
-STATIC_IFN_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
+VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 		unsigned int *clock_values_in_khz, unsigned int *num_states)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -720,7 +720,7 @@ STATIC_IFN_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 }
 EXPORT_IF_KUNIT(pp_nv_get_uclk_dpm_states);
 
-STATIC_IFN_KUNIT enum pp_smu_status pp_rn_get_dpm_clock_table(
+VISIBLE_IF_KUNIT enum pp_smu_status pp_rn_get_dpm_clock_table(
 		struct pp_smu *pp, struct dpm_clocks *clock_table)
 {
 	const struct dc_context *ctx = pp->dm;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
index 1d153d0e2f03..aa6223447b29 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
@@ -15,7 +15,7 @@ struct amdgpu_device;
 
 int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 void build_pm_display_cfg(struct amd_pp_display_configuration *pm_display_cfg,
 			  const struct dm_pp_display_configuration *pp_display_cfg);
 void build_wm_clock_ranges_soc15(const struct pp_smu_wm_range_sets *ranges,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index dbad0a6d3a2b..522fc81d09b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -32,7 +32,7 @@
 #include "modules/power/power_helpers.h"
 #include "dm_helpers.h"
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 bool link_supports_psrsu(struct dc_link *link)
 {
 	struct dc *dc = link->ctx->dc;
@@ -62,7 +62,7 @@ bool link_supports_psrsu(struct dc_link *link)
 }
 EXPORT_IF_KUNIT(link_supports_psrsu);
 
-STATIC_IFN_KUNIT
+VISIBLE_IF_KUNIT
 void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
 {
 	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index e442e7ed82ec..227fe1d90340 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -42,7 +42,7 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm,
 		struct dc_stream_state *stream, bool set_event,	enum psr_event event,
 		bool wait_for_disable);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 bool link_supports_psrsu(struct dc_link *link);
 void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps);
 unsigned int amdgpu_dm_psr_get_dc_feature_mask(void);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index a7594012a0b2..76eb3b0a0721 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -41,7 +41,7 @@ static const u32 amdgpu_dm_wb_formats[] = {
 	DRM_FORMAT_XRGB2101010,
 };
 
-STATIC_IFN_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
+VISIBLE_IF_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
 {
@@ -78,14 +78,14 @@ STATIC_IFN_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encod
 EXPORT_IF_KUNIT(amdgpu_dm_wb_encoder_atomic_check);
 
 
-STATIC_IFN_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
+VISIBLE_IF_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
 {
 	/* Maximum resolution supported by DWB */
 	return drm_add_modes_noedid(connector, 3840, 2160);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_get_modes);
 
-STATIC_IFN_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+VISIBLE_IF_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
 			       struct drm_writeback_job *job)
 {
 	struct amdgpu_framebuffer *afb;
@@ -150,7 +150,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_prepare_job);
 
-STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
+VISIBLE_IF_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
 				struct drm_writeback_job *job)
 {
 	struct amdgpu_bo *rbo;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
index 5fd616bc43b5..067f7ac876f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
@@ -36,7 +36,7 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 				struct amdgpu_dm_wb_connector *dm_wbcon,
 				uint32_t link_index);
 
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index c887fdcba049..ac1522fc2e70 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -30,6 +30,8 @@
 #ifndef __DM_HELPERS__
 #define __DM_HELPERS__
 
+#include <kunit/visibility.h>
+
 #include "modules/inc/mod_info_packet_types.h"
 #include "dc_types.h"
 #include "dc.h"
@@ -193,12 +195,10 @@ void dm_helpers_mccs_vcp_set(
 		struct dc_sink *sink);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-#define STATIC_IFN_KUNIT
 #define INLINE_IFN_KUNIT inline
 #define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
 
 #else
-#define STATIC_IFN_KUNIT static
 #define INLINE_IFN_KUNIT
 #define EXPORT_IF_KUNIT(symbol)
 #endif
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e3dda2fe8a53..b49b81da74d9 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -104,7 +104,7 @@ class CTransforms:
         (CMatch("__no_context_analysis"), ""),
         (CMatch("__attribute_const__"), ""),
         (CMatch("__attribute__"), ""),
-        (CMatch("STATIC_IFN_KUNIT"), ""),
+        (CMatch("VISIBLE_IF_KUNIT"), ""),
         (CMatch("INLINE_IFN_KUNIT"), ""),
 
         #

-- 
2.55.0

