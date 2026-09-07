Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA86DC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F10410E829;
	Mon,  7 Sep 2026 13:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BaNRqFfJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5290310E829
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788787759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9+PaZU+fWfMuQCargVFIJuIPQl6gm+66inSnDooE8I=;
 b=BaNRqFfJMHkCjdsWMltGBB7738kJmYB17o2ytpmChMJhLi2Betqylwj2ls3xCj9B063LSJ
 al5bxL+FkoBAPce14E6u/ZHBM7UcYxN3iluJGiLcfjb1YY7JP/wBJklx9D9adx9+7F2Y7A
 amfoXpK+VlWVoJHXLFiK6L+vOV/3Xqg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-DkWOcaqnOhOVY7f2qi6VQg-1; Mon,
 07 Sep 2026 09:29:15 -0400
X-MC-Unique: DkWOcaqnOhOVY7f2qi6VQg-1
X-Mimecast-MFC-AGG-ID: DkWOcaqnOhOVY7f2qi6VQg_1788787753
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7739D1834514; Mon,  7 Sep 2026 13:29:13 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BF0E30001A2; Mon,  7 Sep 2026 13:29:09 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 07 Sep 2026 15:28:57 +0200
Subject: [PATCH 2/3] drm/amd/display: replace EXPORT_IF_KUNIT with
 EXPORT_SYMBOL_IF_KUNIT
MIME-Version: 1.0
Message-Id: <20260907-visibility-unification-v1-2-6a962e5b3351@redhat.com>
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
In-Reply-To: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788787740; l=174744;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=B1m137OTaXZU5qU8FPfHVkiUHXOZvTh+C5yboibuhR8=;
 b=WcV0SUx7MK92uT+/xygNBThz25t79oI1ppSjrERqkWjjJrkuUNVkU0AJuo4LZuJvFWG9BbiZu
 9Mg1lBEKJgyDhspBZYwL/IoYIU3NLsPcuF24KnfnJaKp7XqlzuhQnvr
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: MYe8IhlMEaCgZNoPtPAD_cbTVC-nH-d_xQsYhc3RkCs_1788787753
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

Switch exports of KUnit-only helpers to EXPORT_SYMBOL_IF_KUNIT.

Unlike EXPORT_IF_KUNIT, which used EXPORT_SYMBOL(), the standard
macro places symbols in the EXPORTED_FOR_KUNIT_TESTING namespace.
Add MODULE_IMPORT_NS() to the AMD DC test files so loadable tests
can still resolve those helpers.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  40 ++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  20 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  50 +++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |  73 +++++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 114 ++++++++++-----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  24 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  36 +++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |   6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  26 ++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  56 +++++-----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 110 ++++++++++----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  90 ++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  26 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  36 +++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  54 +++++-----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |  66 ++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  18 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  10 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   1 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |   2 -
 50 files changed, 475 insertions(+), 457 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b3bebde0b08..f14cf0d951f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -185,7 +185,7 @@ VISIBLE_IF_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 
 	return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
 }
-EXPORT_IF_KUNIT(dm_vblank_get_counter);
+EXPORT_SYMBOL_IF_KUNIT(dm_vblank_get_counter);
 
 VISIBLE_IF_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 					    u32 *vbl, u32 *position)
@@ -223,28 +223,28 @@ VISIBLE_IF_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
 
 	return 0;
 }
-EXPORT_IF_KUNIT(dm_crtc_get_scanoutpos);
+EXPORT_SYMBOL_IF_KUNIT(dm_crtc_get_scanoutpos);
 
 VISIBLE_IF_KUNIT bool dm_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return true;
 }
-EXPORT_IF_KUNIT(dm_is_idle);
+EXPORT_SYMBOL_IF_KUNIT(dm_is_idle);
 
 VISIBLE_IF_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
 }
-EXPORT_IF_KUNIT(dm_wait_for_idle);
+EXPORT_SYMBOL_IF_KUNIT(dm_wait_for_idle);
 
 VISIBLE_IF_KUNIT int dm_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
 }
-EXPORT_IF_KUNIT(dm_soft_reset);
+EXPORT_SYMBOL_IF_KUNIT(dm_soft_reset);
 
 /*
  * DC will program planes with their z-order determined by their ordering
@@ -259,7 +259,7 @@ VISIBLE_IF_KUNIT int dm_plane_layer_index_cmp(const void *a, const void *b)
 	/* Sort by descending dc_plane layer_index (i.e. normalized_zpos) */
 	return sb->surface->layer_index - sa->surface->layer_index;
 }
-EXPORT_IF_KUNIT(dm_plane_layer_index_cmp);
+EXPORT_SYMBOL_IF_KUNIT(dm_plane_layer_index_cmp);
 
 /**
  * update_planes_and_stream_adapter() - Send planes to be updated in DC
@@ -305,14 +305,14 @@ VISIBLE_IF_KUNIT int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	return 0;
 }
-EXPORT_IF_KUNIT(dm_set_clockgating_state);
+EXPORT_SYMBOL_IF_KUNIT(dm_set_clockgating_state);
 
 VISIBLE_IF_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_powergating_state state)
 {
 	return 0;
 }
-EXPORT_IF_KUNIT(dm_set_powergating_state);
+EXPORT_SYMBOL_IF_KUNIT(dm_set_powergating_state);
 
 /* Prototypes of private functions */
 static int dm_early_init(struct amdgpu_ip_block *ip_block);
@@ -1774,7 +1774,7 @@ void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
 			       ppatch->wait_after_dpcd_poweroff_ms / 1000);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_apply_delay_after_dpcd_poweroff);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_apply_delay_after_dpcd_poweroff);
 
 /**
  * amdgpu_dm_dump_links_and_sinks - Debug dump of all DC links and their sinks
@@ -2163,7 +2163,7 @@ dm_atomic_get_new_state(struct drm_atomic_commit *state)
 
 	return NULL;
 }
-EXPORT_IF_KUNIT(dm_atomic_get_new_state);
+EXPORT_SYMBOL_IF_KUNIT(dm_atomic_get_new_state);
 
 static struct drm_private_state *
 dm_atomic_duplicate_state(struct drm_private_obj *obj)
@@ -2199,7 +2199,7 @@ VISIBLE_IF_KUNIT void dm_atomic_destroy_state(struct drm_private_obj *obj,
 
 	kfree(dm_state);
 }
-EXPORT_IF_KUNIT(dm_atomic_destroy_state);
+EXPORT_SYMBOL_IF_KUNIT(dm_atomic_destroy_state);
 
 static struct drm_private_state *
 dm_atomic_create_state(struct drm_private_obj *obj)
@@ -2676,7 +2676,7 @@ VISIBLE_IF_KUNIT void dm_bandwidth_update(struct amdgpu_device *adev)
 {
 	/* TODO: implement later */
 }
-EXPORT_IF_KUNIT(dm_bandwidth_update);
+EXPORT_SYMBOL_IF_KUNIT(dm_bandwidth_update);
 
 static const struct amdgpu_display_funcs dm_display_funcs = {
 	.bandwidth_update = dm_bandwidth_update, /* called unconditionally */
@@ -2881,7 +2881,7 @@ VISIBLE_IF_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
 {
 	return !crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
 }
-EXPORT_IF_KUNIT(modereset_required);
+EXPORT_SYMBOL_IF_KUNIT(modereset_required);
 
 VISIBLE_IF_KUNIT int
 fill_plane_color_attributes(const struct drm_plane_state *plane_state,
@@ -2930,7 +2930,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(fill_plane_color_attributes);
+EXPORT_SYMBOL_IF_KUNIT(fill_plane_color_attributes);
 
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
@@ -3460,7 +3460,7 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 		return true;
 	return false;
 }
-EXPORT_IF_KUNIT(is_scaling_state_different);
+EXPORT_SYMBOL_IF_KUNIT(is_scaling_state_different);
 
 VISIBLE_IF_KUNIT bool
 is_content_protection_different(struct drm_crtc_state *new_crtc_state,
@@ -3582,7 +3582,7 @@ is_content_protection_different(struct drm_crtc_state *new_crtc_state,
 	pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
 	return false;
 }
-EXPORT_IF_KUNIT(is_content_protection_different);
+EXPORT_SYMBOL_IF_KUNIT(is_content_protection_different);
 
 static void remove_stream(struct amdgpu_device *adev,
 			  struct amdgpu_crtc *acrtc,
@@ -4310,7 +4310,7 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
 
 	return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_complete_writeback);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_complete_writeback);
 
 static void dm_clear_writeback(struct amdgpu_display_manager *dm,
 			      struct amdgpu_crtc *acrtc,
@@ -4939,7 +4939,7 @@ VISIBLE_IF_KUNIT void set_multisync_trigger_params(
 		stream->triggered_crtc_reset.delay = TRIGGER_DELAY_NEXT_PIXEL;
 	}
 }
-EXPORT_IF_KUNIT(set_multisync_trigger_params);
+EXPORT_SYMBOL_IF_KUNIT(set_multisync_trigger_params);
 
 VISIBLE_IF_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
 					int stream_count)
@@ -4963,7 +4963,7 @@ VISIBLE_IF_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
 			stream_set[j]->triggered_crtc_reset.event_source = stream_set[master_stream];
 	}
 }
-EXPORT_IF_KUNIT(set_master_stream);
+EXPORT_SYMBOL_IF_KUNIT(set_master_stream);
 
 VISIBLE_IF_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 {
@@ -4993,7 +4993,7 @@ VISIBLE_IF_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *cont
 		set_multisync_trigger_params(stream);
 	}
 }
-EXPORT_IF_KUNIT(dm_enable_per_frame_crtc_master_sync);
+EXPORT_SYMBOL_IF_KUNIT(dm_enable_per_frame_crtc_master_sync);
 
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
index 1b331e783220..4ec4a51a0f67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -97,7 +97,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_audio_component_bind(struct device *kdev,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_audio_component_bind);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_audio_component_bind);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_audio_component_unbind(struct device *kdev,
 					  struct device *hda_kdev, void *data)
@@ -109,7 +109,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_audio_component_unbind(struct device *kdev,
 	acomp->dev = NULL;
 	adev->dm.audio_component = NULL;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_audio_component_unbind);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_audio_component_unbind);
 
 static const struct component_ops amdgpu_dm_audio_component_bind_ops = {
 	.bind	= amdgpu_dm_audio_component_bind,
@@ -135,7 +135,7 @@ void amdgpu_dm_audio_init_pins(struct amdgpu_device *adev, int audio_count,
 		adev->mode_info.audio.pin[i].offset = 0;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_audio_init_pins);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_audio_init_pins);
 
 int amdgpu_dm_audio_init(struct amdgpu_device *adev)
 {
@@ -161,7 +161,7 @@ int amdgpu_dm_audio_init(struct amdgpu_device *adev)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_audio_init);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_audio_init);
 
 void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
 {
@@ -180,7 +180,7 @@ void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
 
 	adev->mode_info.audio.enabled = false;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_audio_fini);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_audio_fini);
 
 void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 {
@@ -193,7 +193,7 @@ void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 						 pin, -1);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_audio_eld_notify);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_audio_eld_notify);
 
 void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
 		     const struct drm_connector *drm_connector,
@@ -239,7 +239,7 @@ void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
 	/* TODO: For DP, video and audio latency should be calculated from DPCD caps */
 
 }
-EXPORT_IF_KUNIT(amdgpu_dm_fill_audio_info);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_fill_audio_info);
 
 void amdgpu_dm_commit_audio(struct drm_device *dev,
 			    struct drm_atomic_commit *state)
@@ -321,18 +321,18 @@ void amdgpu_dm_commit_audio(struct drm_device *dev,
 		amdgpu_dm_audio_eld_notify(adev, inst);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_commit_audio);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_commit_audio);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 int amdgpu_dm_audio_get_param(void)
 {
 	return amdgpu_audio;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_audio_get_param);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_audio_get_param);
 
 void amdgpu_dm_audio_set_param(int val)
 {
 	amdgpu_audio = val;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_audio_set_param);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_audio_set_param);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 02aaaa19cb54..2e46dea09973 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -84,7 +84,7 @@ void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 		caps->caps_valid = true;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_update_backlight_caps);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_update_backlight_caps);
 
 VISIBLE_IF_KUNIT
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
@@ -104,7 +104,7 @@ int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	}
 	return 1;
 }
-EXPORT_IF_KUNIT(get_brightness_range);
+EXPORT_SYMBOL_IF_KUNIT(get_brightness_range);
 
 /* Rescale userspace [0..max] to the firmware curve's [0..255]. */
 static inline u32 scale_input_to_fw(int max, u64 input)
@@ -182,8 +182,7 @@ void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 	*user_brightness = scale_fw_to_input(min, max,
 					     DIV_ROUND_CLOSEST(lum * brightness, 101));
 }
-
-EXPORT_IF_KUNIT(convert_custom_brightness);
+EXPORT_SYMBOL_IF_KUNIT(convert_custom_brightness);
 
 VISIBLE_IF_KUNIT
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
@@ -199,8 +198,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 	/* Rescale 0..max to min..max */
 	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
 }
-
-EXPORT_IF_KUNIT(convert_brightness_from_user);
+EXPORT_SYMBOL_IF_KUNIT(convert_brightness_from_user);
 
 VISIBLE_IF_KUNIT
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
@@ -217,7 +215,7 @@ u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 	return DIV_ROUND_CLOSEST_ULL((u64)max * (brightness - min),
 				 max - min);
 }
-EXPORT_IF_KUNIT(convert_brightness_to_user);
+EXPORT_SYMBOL_IF_KUNIT(convert_brightness_to_user);
 
 VISIBLE_IF_KUNIT
 struct dc_stream_state *dm_find_stream_with_link(
@@ -236,7 +234,7 @@ struct dc_stream_state *dm_find_stream_with_link(
 
 	return NULL;
 }
-EXPORT_IF_KUNIT(dm_find_stream_with_link);
+EXPORT_SYMBOL_IF_KUNIT(dm_find_stream_with_link);
 
 VISIBLE_IF_KUNIT
 int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
@@ -251,7 +249,7 @@ int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_device_index);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_backlight_get_device_index);
 
 void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 				   int bl_idx,
@@ -348,7 +346,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	if (rc)
 		dm->actual_brightness[bl_idx] = user_brightness;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_backlight_set_level);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_backlight_set_level);
 
 VISIBLE_IF_KUNIT
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
@@ -360,7 +358,7 @@ int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
 VISIBLE_IF_KUNIT
 u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
@@ -387,7 +385,7 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 
 	return convert_brightness_to_user(&caps, ret);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_level);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_backlight_get_level);
 
 VISIBLE_IF_KUNIT
 int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
@@ -397,7 +395,7 @@ int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 
 	return amdgpu_dm_backlight_get_level(dm, i);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_brightness);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_backlight_get_brightness);
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
@@ -432,7 +430,7 @@ void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps *caps,
 		props->scale = BACKLIGHT_SCALE_LINEAR;
 	props->type = BACKLIGHT_RAW;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_backlight_fill_props);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_backlight_fill_props);
 
 void
 amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
@@ -494,7 +492,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_register_backlight_device);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_register_backlight_device);
 
 void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 {
@@ -566,7 +564,7 @@ void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		}
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_update_connector_ext_caps);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_update_connector_ext_caps);
 
 void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 			    struct amdgpu_dm_connector *aconnector)
@@ -600,7 +598,7 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 					   dm->adev->mode_info.abm_level_property,
 					   ABM_SYSFS_CONTROL);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_setup_backlight_device);
 
 /**
  * DOC: panel power savings
@@ -631,7 +629,7 @@ ssize_t panel_power_savings_show(struct device *device,
 
 	return sysfs_emit(buf, "%u\n", val);
 }
-EXPORT_IF_KUNIT(panel_power_savings_show);
+EXPORT_SYMBOL_IF_KUNIT(panel_power_savings_show);
 
 VISIBLE_IF_KUNIT
 ssize_t panel_power_savings_store(struct device *device,
@@ -666,7 +664,7 @@ ssize_t panel_power_savings_store(struct device *device,
 
 	return count;
 }
-EXPORT_IF_KUNIT(panel_power_savings_store);
+EXPORT_SYMBOL_IF_KUNIT(panel_power_savings_store);
 
 static DEVICE_ATTR_RW(panel_power_savings);
 
@@ -696,42 +694,42 @@ amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
 
 	return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_should_create_sysfs);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_should_create_sysfs);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 uint amdgpu_dm_get_dc_debug_mask(void)
 {
 	return amdgpu_dc_debug_mask;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_dc_debug_mask);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_dc_debug_mask);
 
 void amdgpu_dm_set_dc_debug_mask(uint val)
 {
 	amdgpu_dc_debug_mask = val;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_dc_debug_mask);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_dc_debug_mask);
 
 int amdgpu_dm_get_abm_level_param(void)
 {
 	return amdgpu_dm_abm_level;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_abm_level_param);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_abm_level_param);
 
 void amdgpu_dm_set_abm_level_param(int val)
 {
 	amdgpu_dm_abm_level = val;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_abm_level_param);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_abm_level_param);
 
 int amdgpu_dm_get_backlight_param(void)
 {
 	return amdgpu_backlight;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_backlight_param);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_backlight_param);
 
 void amdgpu_dm_set_backlight_param(int val)
 {
 	amdgpu_backlight = val;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_backlight_param);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_backlight_param);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 0273701bd174..e3f4ee6e8380 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -35,7 +35,6 @@
 #include "modules/color/color_gamma.h"
 #include "dm_helpers.h"
 
-
 /**
  * DOC: overview
  *
@@ -172,7 +171,7 @@ void amdgpu_dm_init_color_mod(void)
 {
 	setup_x_points_distribution();
 }
-EXPORT_IF_KUNIT(amdgpu_dm_init_color_mod);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_init_color_mod);
 
 VISIBLE_IF_KUNIT INLINE_IFN_KUNIT
 struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
@@ -186,7 +185,7 @@ struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
 	val.value = x;
 	return val;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_fixpt_from_s3132);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_fixpt_from_s3132);
 
 #ifdef AMD_PRIVATE_COLOR
 /* Pre-defined Transfer Functions (TF)
@@ -432,7 +431,7 @@ __extract_blob_lut(const struct drm_property_blob *blob, uint32_t *size)
 	*size = blob ? drm_color_lut_size(blob) : 0;
 	return blob ? (struct drm_color_lut *)blob->data : NULL;
 }
-EXPORT_IF_KUNIT(__extract_blob_lut);
+EXPORT_SYMBOL_IF_KUNIT(__extract_blob_lut);
 
 /**
  * __extract_blob_lut32 - Extracts the DRM lut and lut size from a blob.
@@ -449,7 +448,7 @@ __extract_blob_lut32(const struct drm_property_blob *blob, uint32_t *size)
 	*size = blob ? drm_color_lut32_size(blob) : 0;
 	return blob ? (struct drm_color_lut32 *)blob->data : NULL;
 }
-EXPORT_IF_KUNIT(__extract_blob_lut32);
+EXPORT_SYMBOL_IF_KUNIT(__extract_blob_lut32);
 
 /**
  * __is_lut_linear - check if the given lut is a linear mapping of values
@@ -491,7 +490,7 @@ bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
 	}
 	return true;
 }
-EXPORT_IF_KUNIT(__is_lut_linear);
+EXPORT_SYMBOL_IF_KUNIT(__is_lut_linear);
 
 /**
  * __drm_lut_to_dc_gamma - convert the drm_color_lut to dc_gamma.
@@ -532,7 +531,7 @@ void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
 		gamma->entries.blue[i] = dc_fixpt_from_fraction(b, MAX_DRM_LUT_VALUE);
 	}
 }
-EXPORT_IF_KUNIT(__drm_lut_to_dc_gamma);
+EXPORT_SYMBOL_IF_KUNIT(__drm_lut_to_dc_gamma);
 
 /**
  * __drm_lut32_to_dc_gamma - convert the drm_color_lut to dc_gamma.
@@ -552,7 +551,7 @@ void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut, struct dc_gamma
 		gamma->entries.blue[i] = dc_fixpt_from_fraction(lut[i].blue, MAX_DRM_LUT32_VALUE);
 	}
 }
-EXPORT_IF_KUNIT(__drm_lut32_to_dc_gamma);
+EXPORT_SYMBOL_IF_KUNIT(__drm_lut32_to_dc_gamma);
 
 /**
  * __drm_ctm_to_dc_matrix - converts a DRM CTM to a DC CSC float matrix
@@ -586,7 +585,7 @@ void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
 		matrix[i] = amdgpu_dm_fixpt_from_s3132(ctm->matrix[i - (i / 4)]);
 	}
 }
-EXPORT_IF_KUNIT(__drm_ctm_to_dc_matrix);
+EXPORT_SYMBOL_IF_KUNIT(__drm_ctm_to_dc_matrix);
 
 /**
  * __drm_ctm_3x4_to_dc_matrix - converts a DRM CTM 3x4 to a DC CSC float matrix
@@ -610,7 +609,7 @@ void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
 		matrix[i] = amdgpu_dm_fixpt_from_s3132(ctm->matrix[i]);
 	}
 }
-EXPORT_IF_KUNIT(__drm_ctm_3x4_to_dc_matrix);
+EXPORT_SYMBOL_IF_KUNIT(__drm_ctm_3x4_to_dc_matrix);
 
 /**
  * __set_legacy_tf - Calculates the legacy transfer function
@@ -652,7 +651,7 @@ __set_legacy_tf(struct dc_transfer_func *func,
 
 	return res ? 0 : -ENOMEM;
 }
-EXPORT_IF_KUNIT(__set_legacy_tf);
+EXPORT_SYMBOL_IF_KUNIT(__set_legacy_tf);
 
 /**
  * __set_output_tf - calculates the output transfer function based on expected input space.
@@ -712,7 +711,7 @@ __set_output_tf(struct dc_transfer_func *func,
 
 	return res ? 0 : -ENOMEM;
 }
-EXPORT_IF_KUNIT(__set_output_tf);
+EXPORT_SYMBOL_IF_KUNIT(__set_output_tf);
 
 /**
  * __set_output_tf_32 - calculates the output transfer function based on expected input space.
@@ -770,14 +769,14 @@ __set_output_tf_32(struct dc_transfer_func *func,
 
 	return res ? 0 : -ENOMEM;
 }
-EXPORT_IF_KUNIT(__set_output_tf_32);
+EXPORT_SYMBOL_IF_KUNIT(__set_output_tf_32);
 
 VISIBLE_IF_KUNIT void __set_tf_bypass(struct dc_transfer_func *tf)
 {
 	tf->type = TF_TYPE_BYPASS;
 	tf->tf = TRANSFER_FUNCTION_LINEAR;
 }
-EXPORT_IF_KUNIT(__set_tf_bypass);
+EXPORT_SYMBOL_IF_KUNIT(__set_tf_bypass);
 
 VISIBLE_IF_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
 					enum dc_transfer_func_predefined predefined_tf)
@@ -786,7 +785,7 @@ VISIBLE_IF_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
 	tf->tf = predefined_tf;
 	tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
 }
-EXPORT_IF_KUNIT(__set_tf_distributed_points);
+EXPORT_SYMBOL_IF_KUNIT(__set_tf_distributed_points);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
 					const struct drm_color_lut *regamma_lut,
@@ -819,7 +818,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_t
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_atomic_regamma);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_atomic_regamma);
 
 /**
  * __set_input_tf - calculates the input transfer function based on expected
@@ -857,7 +856,7 @@ VISIBLE_IF_KUNIT int __set_input_tf(struct dc_color_caps *caps,
 
 	return res ? 0 : -ENOMEM;
 }
-EXPORT_IF_KUNIT(__set_input_tf);
+EXPORT_SYMBOL_IF_KUNIT(__set_input_tf);
 
 /**
  * __set_input_tf_32 - calculates the input transfer function based on expected
@@ -895,7 +894,7 @@ VISIBLE_IF_KUNIT int __set_input_tf_32(struct dc_color_caps *caps,
 
 	return res ? 0 : -ENOMEM;
 }
-EXPORT_IF_KUNIT(__set_input_tf_32);
+EXPORT_SYMBOL_IF_KUNIT(__set_input_tf_32);
 
 VISIBLE_IF_KUNIT
 enum dc_transfer_func_predefined
@@ -926,7 +925,7 @@ amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf)
 		return TRANSFER_FUNCTION_GAMMA26;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_tf_to_dc_tf);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_tf_to_dc_tf);
 
 VISIBLE_IF_KUNIT
 enum dc_transfer_func_predefined
@@ -949,7 +948,7 @@ amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 		return TRANSFER_FUNCTION_LINEAR;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_colorop_tf_to_dc_tf);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_colorop_tf_to_dc_tf);
 
 VISIBLE_IF_KUNIT
 void __to_dc_lut3d_color(struct dc_rgb *rgb,
@@ -960,7 +959,7 @@ void __to_dc_lut3d_color(struct dc_rgb *rgb,
 	rgb->green = drm_color_lut_extract(lut.green, bit_precision);
 	rgb->blue  = drm_color_lut_extract(lut.blue, bit_precision);
 }
-EXPORT_IF_KUNIT(__to_dc_lut3d_color);
+EXPORT_SYMBOL_IF_KUNIT(__to_dc_lut3d_color);
 
 VISIBLE_IF_KUNIT
 void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
@@ -1006,7 +1005,7 @@ void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
 	/* lut0 has 1229 points (lut_size/4 + 1) */
 	__to_dc_lut3d_color(&lut0[lut_i], lut[i], bit_depth);
 }
-EXPORT_IF_KUNIT(__drm_3dlut_to_dc_3dlut);
+EXPORT_SYMBOL_IF_KUNIT(__drm_3dlut_to_dc_3dlut);
 
 VISIBLE_IF_KUNIT
 void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
@@ -1017,7 +1016,7 @@ void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
 	rgb->green = drm_color_lut32_extract(lut.green, bit_precision);
 	rgb->blue  = drm_color_lut32_extract(lut.blue, bit_precision);
 }
-EXPORT_IF_KUNIT(__to_dc_lut3d_32_color);
+EXPORT_SYMBOL_IF_KUNIT(__to_dc_lut3d_32_color);
 
 VISIBLE_IF_KUNIT
 void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
@@ -1063,7 +1062,7 @@ void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
 	/* lut0 has 1229 points (lut_size/4 + 1) */
 	__to_dc_lut3d_32_color(&lut0[lut_i], lut[i], bit_depth);
 }
-EXPORT_IF_KUNIT(__drm_3dlut32_to_dc_3dlut);
+EXPORT_SYMBOL_IF_KUNIT(__drm_3dlut32_to_dc_3dlut);
 
 /* amdgpu_dm_atomic_lut3d - set DRM 3D LUT to DC stream
  * @drm_lut3d: user 3D LUT
@@ -1093,7 +1092,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut
 					MAX_COLOR_3DLUT_BITDEPTH);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_atomic_lut3d);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_atomic_lut3d);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
 				       bool has_rom,
@@ -1119,7 +1118,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *sha
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_atomic_shaper_lut);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_atomic_shaper_lut);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
 				       bool has_rom,
@@ -1148,7 +1147,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blen
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_atomic_blend_lut);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_atomic_blend_lut);
 
 /**
  * amdgpu_dm_verify_lut3d_size - verifies if 3D LUT is supported and if user
@@ -1194,7 +1193,7 @@ int amdgpu_dm_verify_lut3d_size(struct amdgpu_device *adev,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_verify_lut3d_size);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_verify_lut3d_size);
 
 /**
  * amdgpu_dm_verify_lut_sizes - verifies if DRM luts match the hw supported sizes
@@ -1231,7 +1230,7 @@ int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_verify_lut_sizes);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_verify_lut_sizes);
 
 /**
  * amdgpu_dm_check_crtc_color_mgmt: Check if DRM color props are programmable by DC.
@@ -1339,7 +1338,7 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 
 	return r;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_check_crtc_color_mgmt);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_check_crtc_color_mgmt);
 
 /**
  * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
@@ -1398,7 +1397,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_update_crtc_color_mgmt);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_update_crtc_color_mgmt);
 
 static int
 map_crtc_degamma_to_dc_plane(struct dm_crtc_state *crtc,
@@ -1570,7 +1569,7 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
+EXPORT_SYMBOL_IF_KUNIT(__set_colorop_in_tf_1d_curve);
 
 VISIBLE_IF_KUNIT int
 __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
@@ -1598,7 +1597,7 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 
 	return __set_colorop_in_tf_1d_curve(dc_plane_state, colorop_state);
 }
-EXPORT_IF_KUNIT(__set_dm_plane_colorop_degamma);
+EXPORT_SYMBOL_IF_KUNIT(__set_dm_plane_colorop_degamma);
 
 VISIBLE_IF_KUNIT int
 __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
@@ -1640,7 +1639,7 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(__set_dm_plane_colorop_3x4_matrix);
+EXPORT_SYMBOL_IF_KUNIT(__set_dm_plane_colorop_3x4_matrix);
 
 VISIBLE_IF_KUNIT int
 __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
@@ -1670,7 +1669,7 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(__set_dm_plane_colorop_multiplier);
+EXPORT_SYMBOL_IF_KUNIT(__set_dm_plane_colorop_multiplier);
 
 static int
 __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
@@ -1783,7 +1782,7 @@ VISIBLE_IF_KUNIT int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d
 
 	return 0;
 }
-EXPORT_IF_KUNIT(__set_colorop_3dlut);
+EXPORT_SYMBOL_IF_KUNIT(__set_colorop_3dlut);
 
 static int
 __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
@@ -2155,4 +2154,4 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 
 	return amdgpu_dm_plane_set_color_properties(plane_state, dc_plane_state);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_update_plane_color_mgmt);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_update_plane_color_mgmt);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index ea326f5b0941..e60464259bb6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -39,21 +39,21 @@ const u64 amdgpu_dm_supported_degam_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
-EXPORT_IF_KUNIT(amdgpu_dm_supported_degam_tfs);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_supported_degam_tfs);
 
 const u64 amdgpu_dm_supported_shaper_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
-EXPORT_IF_KUNIT(amdgpu_dm_supported_shaper_tfs);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_supported_shaper_tfs);
 
 const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
 	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
-EXPORT_IF_KUNIT(amdgpu_dm_supported_blnd_tfs);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_supported_blnd_tfs);
 
 #define MAX_COLOR_PIPELINE_OPS 10
 
@@ -224,7 +224,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_build_default_pipeline);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_build_default_pipeline);
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list)
 {
@@ -235,4 +235,4 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 
 	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, list);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_initialize_default_pipeline);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_initialize_default_pipeline);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index fe310b6d9f60..f613e8ac02bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -93,7 +93,7 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 VISIBLE_IF_KUNIT void dm_encoder_helper_disable(struct drm_encoder *encoder)
 {
 }
-EXPORT_IF_KUNIT(dm_encoder_helper_disable);
+EXPORT_SYMBOL_IF_KUNIT(dm_encoder_helper_disable);
 
 VISIBLE_IF_KUNIT int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 					  struct drm_crtc_state *crtc_state,
@@ -165,7 +165,7 @@ VISIBLE_IF_KUNIT int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	}
 	return 0;
 }
-EXPORT_IF_KUNIT(dm_encoder_helper_atomic_check);
+EXPORT_SYMBOL_IF_KUNIT(dm_encoder_helper_atomic_check);
 
 const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs = {
 	.disable = dm_encoder_helper_disable,
@@ -190,7 +190,7 @@ int amdgpu_dm_get_encoder_crtc_mask(struct amdgpu_device *adev)
 		return 0x3f;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_encoder_crtc_mask);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_encoder_crtc_mask);
 
 int amdgpu_dm_encoder_init(struct drm_device *dev,
 			   struct amdgpu_encoder *aencoder,
@@ -234,7 +234,7 @@ VISIBLE_IF_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link
 		return DRM_MODE_SUBCONNECTOR_Unknown;
 	}
 }
-EXPORT_IF_KUNIT(get_subconnector_type);
+EXPORT_SYMBOL_IF_KUNIT(get_subconnector_type);
 
 VISIBLE_IF_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *aconnector)
 {
@@ -252,7 +252,7 @@ VISIBLE_IF_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *a
 			connector->dev->mode_config.dp_subconnector_property,
 			subconnector);
 }
-EXPORT_IF_KUNIT(update_subconnector_property);
+EXPORT_SYMBOL_IF_KUNIT(update_subconnector_property);
 
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 
@@ -294,7 +294,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 	}
 
 }
-EXPORT_IF_KUNIT(amdgpu_dm_fbc_init);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_fbc_init);
 
 
 int amdgpu_dm_detect_mst_link_for_all_connectors(struct drm_device *dev)
@@ -332,7 +332,7 @@ int amdgpu_dm_detect_mst_link_for_all_connectors(struct drm_device *dev)
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_detect_mst_link_for_all_connectors);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_detect_mst_link_for_all_connectors);
 
 VISIBLE_IF_KUNIT void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
 {
@@ -343,7 +343,7 @@ VISIBLE_IF_KUNIT void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector
 
 	cec_notifier_phys_addr_invalidate(n);
 }
-EXPORT_IF_KUNIT(hdmi_cec_unset_edid);
+EXPORT_SYMBOL_IF_KUNIT(hdmi_cec_unset_edid);
 
 void amdgpu_dm_hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
 {
@@ -356,7 +356,7 @@ void amdgpu_dm_hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
 	cec_notifier_set_phys_addr(n,
 				   connector->display_info.source_physical_address);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_hdmi_cec_set_edid);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_hdmi_cec_set_edid);
 
 void amdgpu_dm_s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
 {
@@ -377,7 +377,7 @@ void amdgpu_dm_s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_s3_handle_hdmi_cec);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_s3_handle_hdmi_cec);
 
 
 struct drm_connector *
@@ -398,7 +398,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_commit *state,
 
 	return NULL;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_find_first_crtc_matching_connector);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_find_first_crtc_matching_connector);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 {
@@ -467,7 +467,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconn
 
 	drm_dbg_kms(aconnector->base.dev, "Panel type: %d\n", link->panel_type);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_panel_type);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_panel_type);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
 {
@@ -494,7 +494,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aco
 	drm_dbg_kms(aconnector->base.dev, "cacp_supported: %d\n",
 		    link->panel_config.cacp.cacp_supported);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_update_cacp_caps);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_update_cacp_caps);
 
 DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))
 
@@ -659,7 +659,7 @@ void amdgpu_dm_update_connector_after_detect(
 	if (!drm_kms_helper_is_poll_worker())
 		mutex_unlock(&dev->mode_config.mutex);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_update_connector_after_detect);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_update_connector_after_detect);
 
 enum dc_color_depth
 amdgpu_dm_convert_color_depth_from_display_info(const struct drm_connector *connector,
@@ -722,7 +722,7 @@ amdgpu_dm_convert_color_depth_from_display_info(const struct drm_connector *conn
 		return COLOR_DEPTH_UNDEFINED;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_convert_color_depth_from_display_info);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_convert_color_depth_from_display_info);
 
 VISIBLE_IF_KUNIT enum dc_aspect_ratio
 get_aspect_ratio(const struct drm_display_mode *mode_in)
@@ -730,7 +730,7 @@ get_aspect_ratio(const struct drm_display_mode *mode_in)
 	/* 1-1 mapping, since both enums follow the HDMI spec. */
 	return (enum dc_aspect_ratio) mode_in->picture_aspect_ratio;
 }
-EXPORT_IF_KUNIT(get_aspect_ratio);
+EXPORT_SYMBOL_IF_KUNIT(get_aspect_ratio);
 
 enum dc_color_space
 amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
@@ -790,7 +790,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 
 	return color_space;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_output_color_space);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_output_color_space);
 
 VISIBLE_IF_KUNIT enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state)
@@ -809,7 +809,7 @@ get_output_content_type(const struct drm_connector_state *connector_state)
 		return DISPLAY_CONTENT_TYPE_GAME;
 	}
 }
-EXPORT_IF_KUNIT(get_output_content_type);
+EXPORT_SYMBOL_IF_KUNIT(get_output_content_type);
 
 VISIBLE_IF_KUNIT bool adjust_colour_depth_from_display_info(
 	struct dc_crtc_timing *timing_out,
@@ -847,7 +847,7 @@ VISIBLE_IF_KUNIT bool adjust_colour_depth_from_display_info(
 	} while (--depth > COLOR_DEPTH_666);
 	return false;
 }
-EXPORT_IF_KUNIT(adjust_colour_depth_from_display_info);
+EXPORT_SYMBOL_IF_KUNIT(adjust_colour_depth_from_display_info);
 
 VISIBLE_IF_KUNIT void fill_stream_properties_from_drm_display_mode(
 	struct dc_stream_state *stream,
@@ -962,7 +962,7 @@ VISIBLE_IF_KUNIT void fill_stream_properties_from_drm_display_mode(
 	stream->output_color_space = amdgpu_dm_get_output_color_space(timing_out, connector_state);
 	stream->content_type = get_output_content_type(connector_state);
 }
-EXPORT_IF_KUNIT(fill_stream_properties_from_drm_display_mode);
+EXPORT_SYMBOL_IF_KUNIT(fill_stream_properties_from_drm_display_mode);
 
 VISIBLE_IF_KUNIT void
 copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
@@ -983,7 +983,7 @@ copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 	dst_mode->crtc_vsync_end = src_mode->crtc_vsync_end;
 	dst_mode->crtc_vtotal = src_mode->crtc_vtotal;
 }
-EXPORT_IF_KUNIT(copy_crtc_timing_for_drm_display_mode);
+EXPORT_SYMBOL_IF_KUNIT(copy_crtc_timing_for_drm_display_mode);
 
 VISIBLE_IF_KUNIT void
 decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
@@ -1000,7 +1000,7 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 		/* no scaling nor amdgpu inserted, no need to patch */
 	}
 }
-EXPORT_IF_KUNIT(decide_crtc_timing_for_drm_display_mode);
+EXPORT_SYMBOL_IF_KUNIT(decide_crtc_timing_for_drm_display_mode);
 
 static struct dc_sink *
 create_fake_sink(struct drm_device *dev, struct dc_link *link)
@@ -1106,7 +1106,7 @@ amdgpu_dm_get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 	drm_mode_copy(&aconnector->freesync_vid_base, m_pref);
 	return m_pref;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_highest_refresh_rate_mode);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_highest_refresh_rate_mode);
 
 bool amdgpu_dm_is_freesync_video_mode(const struct drm_display_mode *mode,
 		struct amdgpu_dm_connector *aconnector)
@@ -1134,7 +1134,7 @@ bool amdgpu_dm_is_freesync_video_mode(const struct drm_display_mode *mode,
 	else
 		return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_is_freesync_video_mode);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_is_freesync_video_mode);
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
 static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
@@ -1417,7 +1417,7 @@ void amdgpu_dm_update_stream_scaling_settings(struct drm_device *dev,
 		    dst.x, dst.y, dst.width, dst.height);
 
 }
-EXPORT_IF_KUNIT(amdgpu_dm_update_stream_scaling_settings);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_update_stream_scaling_settings);
 
 VISIBLE_IF_KUNIT struct dc_stream_state *
 create_stream_for_sink(struct drm_connector *connector,
@@ -1605,7 +1605,7 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	return stream;
 }
-EXPORT_IF_KUNIT(create_stream_for_sink);
+EXPORT_SYMBOL_IF_KUNIT(create_stream_for_sink);
 
 /**
  * amdgpu_dm_connector_poll - Poll a connector to see if it's connected to a display
@@ -1673,7 +1673,7 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 	mutex_unlock(&aconnector->hpd_lock);
 	return status;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_poll);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_poll);
 
 /*
  * Apple Studio Display exposes two SST DP links for a 2x1 tiled panel.
@@ -1757,7 +1757,7 @@ amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_detect);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_detect);
 
 int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 					    struct drm_connector_state *connector_state,
@@ -1824,7 +1824,7 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_set_property);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_atomic_set_property);
 
 int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 					    const struct drm_connector_state *state,
@@ -1874,7 +1874,7 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_get_property);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_atomic_get_property);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
@@ -1886,7 +1886,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *conne
 	cec_notifier_conn_unregister(amdgpu_dm_connector->notifier);
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_unregister);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_unregister);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 {
@@ -1929,7 +1929,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 
 	kfree(connector);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_destroy);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_destroy);
 
 void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 {
@@ -1963,7 +1963,7 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 			state->abm_level = amdgpu_dm_abm_level;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_reset);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_funcs_reset);
 
 struct drm_connector_state *
 amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
@@ -1989,7 +1989,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 	new_state->pbn = state->pbn;
 	return &new_state->base;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_duplicate_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_atomic_duplicate_state);
 
 VISIBLE_IF_KUNIT int
 amdgpu_dm_connector_late_register(struct drm_connector *connector)
@@ -2021,7 +2021,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_late_register);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_late_register);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 {
@@ -2059,7 +2059,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *conn
 			&dc_em_sink->edid_caps);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_force);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_funcs_force);
 
 static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
 	.reset = amdgpu_dm_connector_funcs_reset,
@@ -2125,7 +2125,7 @@ VISIBLE_IF_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 			dc_sink_retain(aconnector->dc_sink);
 	}
 }
-EXPORT_IF_KUNIT(create_eml_sink);
+EXPORT_SYMBOL_IF_KUNIT(create_eml_sink);
 
 VISIBLE_IF_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 {
@@ -2142,7 +2142,7 @@ VISIBLE_IF_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 
 	create_eml_sink(aconnector);
 }
-EXPORT_IF_KUNIT(handle_edid_mgmt);
+EXPORT_SYMBOL_IF_KUNIT(handle_edid_mgmt);
 
 VISIBLE_IF_KUNIT enum dc_status dm_validate_stream_and_context(struct dc *dc,
 						struct dc_stream_state *stream)
@@ -2206,7 +2206,7 @@ VISIBLE_IF_KUNIT enum dc_status dm_validate_stream_and_context(struct dc *dc,
 
 	return dc_result;
 }
-EXPORT_IF_KUNIT(dm_validate_stream_and_context);
+EXPORT_SYMBOL_IF_KUNIT(dm_validate_stream_and_context);
 
 static enum dc_status
 dm_validate_stream_color_format(const struct drm_connector_state *drm_state,
@@ -2455,7 +2455,7 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 	 */
 	return NULL;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_create_validate_stream_for_sink);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_create_validate_stream_for_sink);
 
 enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
 				   const struct drm_display_mode *mode)
@@ -2509,7 +2509,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 	/* TODO: error handling*/
 	return result;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_mode_valid);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_mode_valid);
 
 int amdgpu_dm_fill_hdr_info_packet(const struct drm_connector_state *state,
 				   struct dc_info_packet *out)
@@ -2569,7 +2569,7 @@ int amdgpu_dm_fill_hdr_info_packet(const struct drm_connector_state *state,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_fill_hdr_info_packet);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_fill_hdr_info_packet);
 
 static int
 amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
@@ -2686,7 +2686,7 @@ int amdgpu_dm_convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_
 	}
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_convert_dc_color_depth_into_bpc);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_convert_dc_color_depth_into_bpc);
 
 VISIBLE_IF_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connector_id)
 {
@@ -2722,7 +2722,7 @@ VISIBLE_IF_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connect
 		return DRM_MODE_CONNECTOR_Unknown;
 	}
 }
-EXPORT_IF_KUNIT(to_drm_connector_type);
+EXPORT_SYMBOL_IF_KUNIT(to_drm_connector_type);
 
 VISIBLE_IF_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *connector)
 {
@@ -2734,7 +2734,7 @@ VISIBLE_IF_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_c
 
 	return NULL;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_to_encoder);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_to_encoder);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 {
@@ -2764,7 +2764,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_native_mode);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_native_mode);
 
 VISIBLE_IF_KUNIT struct drm_display_mode *
 amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
@@ -2789,7 +2789,7 @@ amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
 	return mode;
 
 }
-EXPORT_IF_KUNIT(amdgpu_dm_create_common_mode);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_create_common_mode);
 
 static const struct amdgpu_dm_mode_size {
 	char name[DRM_DISPLAY_MODE_LEN];
@@ -2857,7 +2857,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_add_common_modes(struct drm_encoder *e
 		amdgpu_dm_connector->num_modes++;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_add_common_modes);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_add_common_modes);
 
 void amdgpu_set_panel_orientation(struct drm_connector *connector)
 {
@@ -2964,7 +2964,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *co
 		amdgpu_dm_connector->num_modes = 0;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_ddc_get_modes);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_ddc_get_modes);
 
 VISIBLE_IF_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 			      struct drm_display_mode *mode)
@@ -2978,7 +2978,7 @@ VISIBLE_IF_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 
 	return false;
 }
-EXPORT_IF_KUNIT(is_duplicate_mode);
+EXPORT_SYMBOL_IF_KUNIT(is_duplicate_mode);
 
 VISIBLE_IF_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 {
@@ -3055,7 +3055,7 @@ VISIBLE_IF_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
  out:
 	return new_modes_count;
 }
-EXPORT_IF_KUNIT(add_fs_modes);
+EXPORT_SYMBOL_IF_KUNIT(add_fs_modes);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
 						   const struct drm_edid *drm_edid)
@@ -3080,7 +3080,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connecto
 		amdgpu_dm_connector->num_modes +=
 			add_fs_modes(amdgpu_dm_connector);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_connector_add_freesync_modes);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_connector_add_freesync_modes);
 
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 {
@@ -3357,13 +3357,13 @@ VISIBLE_IF_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	kfree(cmd.payloads);
 	return result;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_i2c_xfer);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_i2c_xfer);
 
 VISIBLE_IF_KUNIT u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_i2c_func);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_i2c_func);
 
 static const struct i2c_algorithm amdgpu_dm_i2c_algo = {
 	.master_xfer = amdgpu_dm_i2c_xfer,
@@ -3766,7 +3766,7 @@ VISIBLE_IF_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
 		j++;
 	}
 }
-EXPORT_IF_KUNIT(parse_edid_displayid_vrr);
+EXPORT_SYMBOL_IF_KUNIT(parse_edid_displayid_vrr);
 
 VISIBLE_IF_KUNIT int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			struct amdgpu_hdmi_vsdb_info *vsdb_info)
@@ -3778,7 +3778,7 @@ VISIBLE_IF_KUNIT int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 
 	return connector->display_info.amd_vsdb.version != 0;
 }
-EXPORT_IF_KUNIT(get_amd_vsdb);
+EXPORT_SYMBOL_IF_KUNIT(get_amd_vsdb);
 
 VISIBLE_IF_KUNIT int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			       const struct edid *edid,
@@ -3811,7 +3811,7 @@ VISIBLE_IF_KUNIT int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 
 	return valid_vsdb_found ? i : -ENODEV;
 }
-EXPORT_IF_KUNIT(parse_hdmi_amd_vsdb);
+EXPORT_SYMBOL_IF_KUNIT(parse_hdmi_amd_vsdb);
 
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index c58cbf00543f..c36d2499d2d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -60,7 +60,7 @@ enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source)
 
 	return AMDGPU_DM_PIPE_CRC_SOURCE_INVALID;
 }
-EXPORT_IF_KUNIT(dm_parse_crc_source);
+EXPORT_SYMBOL_IF_KUNIT(dm_parse_crc_source);
 
 VISIBLE_IF_KUNIT
 bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src)
@@ -68,7 +68,7 @@ bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src)
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC) ||
 	       (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER);
 }
-EXPORT_IF_KUNIT(dm_is_crc_source_crtc);
+EXPORT_SYMBOL_IF_KUNIT(dm_is_crc_source_crtc);
 
 VISIBLE_IF_KUNIT
 bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src)
@@ -76,7 +76,7 @@ bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src)
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_DPRX) ||
 	       (src == AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER);
 }
-EXPORT_IF_KUNIT(dm_is_crc_source_dprx);
+EXPORT_SYMBOL_IF_KUNIT(dm_is_crc_source_dprx);
 
 VISIBLE_IF_KUNIT
 bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src)
@@ -85,7 +85,7 @@ bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src)
 	       (src == AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER) ||
 	       (src == AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
 }
-EXPORT_IF_KUNIT(dm_need_crc_dither);
+EXPORT_SYMBOL_IF_KUNIT(dm_need_crc_dither);
 
 /**
  * dm_need_dp_aux() - Does this source transition require the DP AUX handle?
@@ -104,7 +104,7 @@ bool dm_need_dp_aux(enum amdgpu_dm_pipe_crc_source source,
 	return dm_is_crc_source_dprx(source) ||
 	       (source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE && dm_is_crc_source_dprx(cur_crc_src));
 }
-EXPORT_IF_KUNIT(dm_need_dp_aux);
+EXPORT_SYMBOL_IF_KUNIT(dm_need_dp_aux);
 
 /**
  * dm_crc_source_should_start_dprx() - Should drm_dp_start_crc() be called?
@@ -124,7 +124,7 @@ bool dm_crc_source_should_start_dprx(enum amdgpu_dm_pipe_crc_source source,
 	       amdgpu_dm_is_valid_crc_source(source) &&
 	       dm_is_crc_source_dprx(source);
 }
-EXPORT_IF_KUNIT(dm_crc_source_should_start_dprx);
+EXPORT_SYMBOL_IF_KUNIT(dm_crc_source_should_start_dprx);
 
 /**
  * dm_crc_source_should_stop_dprx() - Should drm_dp_stop_crc() be called?
@@ -144,7 +144,7 @@ bool dm_crc_source_should_stop_dprx(enum amdgpu_dm_pipe_crc_source source,
 	       !amdgpu_dm_is_valid_crc_source(source) &&
 	       dm_is_crc_source_dprx(cur_crc_src);
 }
-EXPORT_IF_KUNIT(dm_crc_source_should_stop_dprx);
+EXPORT_SYMBOL_IF_KUNIT(dm_crc_source_should_stop_dprx);
 
 const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 						  size_t *count)
@@ -152,7 +152,7 @@ const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 	*count = ARRAY_SIZE(pipe_crc_sources);
 	return pipe_crc_sources;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_get_crc_sources);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_get_crc_sources);
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 static void update_phy_id_mapping(struct amdgpu_device *adev)
@@ -565,7 +565,7 @@ amdgpu_dm_crtc_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 	*values_cnt = 3;
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_verify_crc_source);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_verify_crc_source);
 
 int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 					struct dm_crtc_state *dm_crtc_state,
@@ -643,7 +643,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_configure_crc_source);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_configure_crc_source);
 
 int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 {
@@ -821,7 +821,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_set_crc_source);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_set_crc_source);
 
 /**
  * amdgpu_dm_crtc_handle_crc_irq: Report to DRM the CRC on given CRTC.
@@ -879,7 +879,7 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc)
 				       drm_crtc_accurate_vblank_count(crtc), crcs);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_handle_crc_irq);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_handle_crc_irq);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 790296cec5d6..76353167655c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -59,7 +59,7 @@ void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
 
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_handle_vblank);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_handle_vblank);
 
 bool amdgpu_dm_crtc_modeset_required(struct drm_crtc_state *crtc_state,
 			     struct dc_stream_state *new_stream,
@@ -67,7 +67,7 @@ bool amdgpu_dm_crtc_modeset_required(struct drm_crtc_state *crtc_state,
 {
 	return crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_modeset_required);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_modeset_required);
 
 bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc)
 
@@ -77,7 +77,7 @@ bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc)
 	       acrtc->dm_irq_params.freesync_config.state ==
 		       VRR_STATE_ACTIVE_FIXED;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_vrr_active_irq);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_vrr_active_irq);
 
 int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 {
@@ -97,14 +97,14 @@ int amdgpu_dm_crtc_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 		      acrtc->crtc_id, enable ? "en" : "dis", rc);
 	return rc;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_set_vupdate_irq);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_set_vupdate_irq);
 
 bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
 {
 	return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
 	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_vrr_active);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_vrr_active);
 
 /**
  * amdgpu_dm_crtc_set_static_screen_optimze() - Toggle static screen optimizations.
@@ -139,7 +139,7 @@ void amdgpu_dm_crtc_set_static_screen_optimze(
 		amdgpu_dm_psr_set_event(dm, stream,
 			set_vsync_event, psr_event_vsync, set_vsync_event);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_set_static_screen_optimze);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_set_static_screen_optimze);
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
 {
@@ -167,7 +167,7 @@ bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
 	drm_connector_list_iter_end(&iter);
 	return is_headless;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_is_headless);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_is_headless);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_idle_worker(struct work_struct *work)
 {
@@ -203,7 +203,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_idle_worker(struct work_struct *work)
 	}
 	idle_work->dm->idle_workqueue->running = false;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_idle_worker);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_idle_worker);
 
 struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
 {
@@ -220,7 +220,7 @@ struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
 
 	return idle_work;
 }
-EXPORT_IF_KUNIT(idle_create_workqueue);
+EXPORT_SYMBOL_IF_KUNIT(idle_create_workqueue);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 {
@@ -247,7 +247,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *w
 
 	kfree(vblank_work);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_vblank_control_worker);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_vblank_control_worker);
 
 static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 {
@@ -401,13 +401,13 @@ int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	return amdgpu_dm_crtc_set_vblank(crtc, true);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_enable_vblank);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_enable_vblank);
 
 void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	amdgpu_dm_crtc_set_vblank(crtc, false);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_disable_vblank);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_disable_vblank);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state)
@@ -424,7 +424,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 
 	kfree(state);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_destroy_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_destroy_state);
 
 VISIBLE_IF_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc)
 {
@@ -461,7 +461,7 @@ VISIBLE_IF_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct dr
 
 	return &state->base;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_duplicate_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_duplicate_state);
 
 static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 {
@@ -488,7 +488,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 
 	__drm_atomic_helper_crtc_reset(crtc, &state->base);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_reset_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_reset_state);
 
 #ifdef CONFIG_DEBUG_FS
 static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
@@ -622,7 +622,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_sta
 
 	return num_active;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_count_crtc_active_planes);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_count_crtc_active_planes);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 						     struct drm_crtc_state *new_crtc_state)
@@ -638,7 +638,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *
 	dm_new_crtc_state->active_planes =
 		amdgpu_dm_crtc_count_crtc_active_planes(new_crtc_state);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_update_crtc_active_planes);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_update_crtc_active_planes);
 
 VISIBLE_IF_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 					       const struct drm_display_mode *mode,
@@ -646,7 +646,7 @@ VISIBLE_IF_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 {
 	return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_crtc_helper_mode_fixup);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_crtc_helper_mode_fixup);
 
 static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 					      struct drm_atomic_commit *state)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index d6c33c107e11..c017778a4700 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -171,7 +171,7 @@ bool amdgpu_dm_should_update_native_cursor(struct drm_atomic_commit *state,
 
 	return dm_new_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_should_update_native_cursor);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_should_update_native_cursor);
 
 VISIBLE_IF_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 					 int *src_w, int *src_h)
@@ -190,7 +190,7 @@ VISIBLE_IF_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_s
 		break;
 	}
 }
-EXPORT_IF_KUNIT(dm_get_oriented_plane_size);
+EXPORT_SYMBOL_IF_KUNIT(dm_get_oriented_plane_size);
 
 VISIBLE_IF_KUNIT void
 dm_get_plane_scale(struct drm_plane_state *plane_state,
@@ -202,7 +202,7 @@ dm_get_plane_scale(struct drm_plane_state *plane_state,
 	*out_plane_scale_w = plane_src_w ? plane_state->crtc_w * 1000 / plane_src_w : 0;
 	*out_plane_scale_h = plane_src_h ? plane_state->crtc_h * 1000 / plane_src_h : 0;
 }
-EXPORT_IF_KUNIT(dm_get_plane_scale);
+EXPORT_SYMBOL_IF_KUNIT(dm_get_plane_scale);
 
 /**
  * DOC: Cursor Modes - Native vs Overlay
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index ecf1faca4d4b..387cf811327a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -82,7 +82,7 @@ void dm_dmub_aux_setconfig_callback(struct amdgpu_device *adev,
 	if (notify->type == DMUB_NOTIFICATION_AUX_REPLY)
 		complete(&adev->dm.dmub_aux_transfer_done);
 }
-EXPORT_IF_KUNIT(dm_dmub_aux_setconfig_callback);
+EXPORT_SYMBOL_IF_KUNIT(dm_dmub_aux_setconfig_callback);
 
 void dm_dmub_aux_fused_io_callback(struct amdgpu_device *adev,
 				   struct dmub_notification *notify)
@@ -106,7 +106,7 @@ void dm_dmub_aux_fused_io_callback(struct amdgpu_device *adev,
 	memcpy(sync->reply_data, req, sizeof(*req));
 	complete(&sync->replied);
 }
-EXPORT_IF_KUNIT(dm_dmub_aux_fused_io_callback);
+EXPORT_SYMBOL_IF_KUNIT(dm_dmub_aux_fused_io_callback);
 
 /**
  * dm_register_dmub_notify_callback - Sets callback for DMUB notify
@@ -133,7 +133,7 @@ bool dm_register_dmub_notify_callback(struct amdgpu_device *adev,
 
 	return true;
 }
-EXPORT_IF_KUNIT(dm_register_dmub_notify_callback);
+EXPORT_SYMBOL_IF_KUNIT(dm_register_dmub_notify_callback);
 
 int dm_dmub_hw_init(struct amdgpu_device *adev)
 {
@@ -322,7 +322,7 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(dm_dmub_hw_init);
+EXPORT_SYMBOL_IF_KUNIT(dm_dmub_hw_init);
 
 void dm_dmub_hw_resume(struct amdgpu_device *adev)
 {
@@ -352,7 +352,7 @@ void dm_dmub_hw_resume(struct amdgpu_device *adev)
 			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
 	}
 }
-EXPORT_IF_KUNIT(dm_dmub_hw_resume);
+EXPORT_SYMBOL_IF_KUNIT(dm_dmub_hw_resume);
 
 static enum dmub_status
 dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
@@ -444,7 +444,7 @@ VISIBLE_IF_KUNIT void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev
 	return NULL;
 
 }
-EXPORT_IF_KUNIT(dm_dmub_get_vbios_bounding_box);
+EXPORT_SYMBOL_IF_KUNIT(dm_dmub_get_vbios_bounding_box);
 
 enum dmub_ips_disable_type dm_get_default_ips_mode(
 	struct amdgpu_device *adev)
@@ -466,7 +466,7 @@ enum dmub_ips_disable_type dm_get_default_ips_mode(
 
 	return ret;
 }
-EXPORT_IF_KUNIT(dm_get_default_ips_mode);
+EXPORT_SYMBOL_IF_KUNIT(dm_get_default_ips_mode);
 
 static uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address)
 {
@@ -694,7 +694,7 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(dm_dmub_sw_init);
+EXPORT_SYMBOL_IF_KUNIT(dm_dmub_sw_init);
 
 int dm_init_microcode(struct amdgpu_device *adev)
 {
@@ -770,7 +770,7 @@ int dm_init_microcode(struct amdgpu_device *adev)
 				 "%s", fw_name_dmub);
 	return r;
 }
-EXPORT_IF_KUNIT(dm_init_microcode);
+EXPORT_SYMBOL_IF_KUNIT(dm_init_microcode);
 
 int amdgpu_dm_process_dmub_aux_transfer_sync(
 		struct dc_context *ctx,
@@ -840,7 +840,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 	mutex_unlock(&adev->dm.dpia_aux_lock);
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_process_dmub_aux_transfer_sync);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_process_dmub_aux_transfer_sync);
 
 VISIBLE_IF_KUNIT void abort_fused_io(
 		struct dc_context *ctx,
@@ -856,7 +856,7 @@ VISIBLE_IF_KUNIT void abort_fused_io(
 	io->request = *request;
 	dm_execute_dmub_cmd(ctx, &command, DM_DMUB_WAIT_TYPE_NO_WAIT);
 }
-EXPORT_IF_KUNIT(abort_fused_io);
+EXPORT_SYMBOL_IF_KUNIT(abort_fused_io);
 
 static bool execute_fused_io(
 		struct amdgpu_device *dev,
@@ -944,7 +944,7 @@ int amdgpu_dm_process_dmub_set_config_sync(
 	mutex_unlock(&adev->dm.dpia_aux_lock);
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_process_dmub_set_config_sync);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_process_dmub_set_config_sync);
 
 bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
 {
@@ -953,7 +953,7 @@ bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd, e
 	guard(spinlock_irqsave)(&adev->dm.dmub_lock);
 	return dc_dmub_srv_cmd_run(ctx->dmub_srv, cmd, wait_type);
 }
-EXPORT_IF_KUNIT(dm_execute_dmub_cmd);
+EXPORT_SYMBOL_IF_KUNIT(dm_execute_dmub_cmd);
 
 bool dm_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned int count, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 7e484adb4120..3a76510856d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -50,7 +50,7 @@ bool amdgpu_dm_is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 	else
 		return false;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_is_dc_timing_adjust_needed);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_is_dc_timing_adjust_needed);
 
 bool
 amdgpu_dm_is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
@@ -81,7 +81,7 @@ amdgpu_dm_is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state
 
 	return false;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_is_timing_unchanged_for_freesync);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_is_timing_unchanged_for_freesync);
 
 void amdgpu_dm_set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
 {
@@ -97,7 +97,7 @@ void amdgpu_dm_set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state
 	res = div_u64(num, den);
 	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_freesync_fixed_config);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_freesync_fixed_config);
 
 void amdgpu_dm_reset_freesync_config_for_crtc(
 	struct dm_crtc_state *new_crtc_state)
@@ -107,7 +107,7 @@ void amdgpu_dm_reset_freesync_config_for_crtc(
 	memset(&new_crtc_state->vrr_infopacket, 0,
 	       sizeof(new_crtc_state->vrr_infopacket));
 }
-EXPORT_IF_KUNIT(amdgpu_dm_reset_freesync_config_for_crtc);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_reset_freesync_config_for_crtc);
 
 void amdgpu_dm_get_freesync_config_for_crtc(
 	struct dm_crtc_state *new_crtc_state,
@@ -152,7 +152,7 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 out:
 	new_crtc_state->freesync_config = config;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_freesync_config_for_crtc);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_freesync_config_for_crtc);
 
 void amdgpu_dm_update_freesync_state_on_stream(
 	struct amdgpu_display_manager *dm,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 20c1ce8cda44..9b77d403671e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -48,7 +48,7 @@ bool lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t
 
 	return dm_helpers_submit_i2c(link->ctx, link, &cmd);
 }
-EXPORT_IF_KUNIT(lp_write_i2c);
+EXPORT_SYMBOL_IF_KUNIT(lp_write_i2c);
 
 VISIBLE_IF_KUNIT
 bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint32_t size)
@@ -62,7 +62,7 @@ bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data,
 
 	return dm_helpers_submit_i2c(link->ctx, link, &cmd);
 }
-EXPORT_IF_KUNIT(lp_read_i2c);
+EXPORT_SYMBOL_IF_KUNIT(lp_read_i2c);
 
 VISIBLE_IF_KUNIT
 bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
@@ -71,7 +71,7 @@ bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t
 
 	return dm_helpers_dp_write_dpcd(link->ctx, link, address, data, size);
 }
-EXPORT_IF_KUNIT(lp_write_dpcd);
+EXPORT_SYMBOL_IF_KUNIT(lp_write_dpcd);
 
 VISIBLE_IF_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
 {
@@ -79,7 +79,7 @@ VISIBLE_IF_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data
 
 	return dm_helpers_dp_read_dpcd(link->ctx, link, address, data, size);
 }
-EXPORT_IF_KUNIT(lp_read_dpcd);
+EXPORT_SYMBOL_IF_KUNIT(lp_read_dpcd);
 
 VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_i2c(
 						void *handle,
@@ -94,7 +94,7 @@ VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_i2c(
 
 	return dm_atomic_write_poll_read_i2c(link, write, poll, read, poll_timeout_us, poll_mask_msb);
 }
-EXPORT_IF_KUNIT(lp_atomic_write_poll_read_i2c);
+EXPORT_SYMBOL_IF_KUNIT(lp_atomic_write_poll_read_i2c);
 
 VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_aux(
 						void *handle,
@@ -109,7 +109,7 @@ VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_aux(
 
 	return dm_atomic_write_poll_read_aux(link, write, poll, read, poll_timeout_us, poll_mask_msb);
 }
-EXPORT_IF_KUNIT(lp_atomic_write_poll_read_aux);
+EXPORT_SYMBOL_IF_KUNIT(lp_atomic_write_poll_read_aux);
 
 VISIBLE_IF_KUNIT
 uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
@@ -135,7 +135,7 @@ uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *s
 
 	return hdcp_cmd->out_msg.hdcp_get_srm.srm_buf;
 }
-EXPORT_IF_KUNIT(psp_get_srm);
+EXPORT_SYMBOL_IF_KUNIT(psp_get_srm);
 
 VISIBLE_IF_KUNIT
 int psp_set_srm(struct psp_context *psp,
@@ -165,7 +165,7 @@ int psp_set_srm(struct psp_context *psp,
 	*srm_version = hdcp_cmd->out_msg.hdcp_set_srm.srm_version;
 	return 0;
 }
-EXPORT_IF_KUNIT(psp_set_srm);
+EXPORT_SYMBOL_IF_KUNIT(psp_set_srm);
 
 VISIBLE_IF_KUNIT
 void process_output(struct hdcp_workqueue *hdcp_work)
@@ -188,7 +188,7 @@ void process_output(struct hdcp_workqueue *hdcp_work)
 
 	schedule_delayed_work(&hdcp_work->property_validate_dwork, msecs_to_jiffies(0));
 }
-EXPORT_IF_KUNIT(process_output);
+EXPORT_SYMBOL_IF_KUNIT(process_output);
 
 VISIBLE_IF_KUNIT
 bool hdcp_get_content_protection_from_status(
@@ -215,7 +215,7 @@ bool hdcp_get_content_protection_from_status(
 
 	return false;
 }
-EXPORT_IF_KUNIT(hdcp_get_content_protection_from_status);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_get_content_protection_from_status);
 
 VISIBLE_IF_KUNIT
 void hdcp_get_link_display_adjustments(
@@ -252,7 +252,7 @@ void hdcp_get_link_display_adjustments(
 	link_adjust->hdcp2.use_sw_locality_fallback =
 		hdcp_lc_enable_sw_fallback;
 }
-EXPORT_IF_KUNIT(hdcp_get_link_display_adjustments);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_get_link_display_adjustments);
 
 VISIBLE_IF_KUNIT
 void link_lock(struct hdcp_workqueue *work, bool lock)
@@ -266,7 +266,7 @@ void link_lock(struct hdcp_workqueue *work, bool lock)
 			mutex_unlock(&work[i].mutex);
 	}
 }
-EXPORT_IF_KUNIT(link_lock);
+EXPORT_SYMBOL_IF_KUNIT(link_lock);
 
 VISIBLE_IF_KUNIT
 void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
@@ -290,7 +290,7 @@ void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
 		cancel_delayed_work(&hdcp_w->property_validate_dwork);
 	}
 }
-EXPORT_IF_KUNIT(hdcp_update_display_encryption_control);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_update_display_encryption_control);
 
 void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			 unsigned int link_index,
@@ -322,7 +322,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 
 	process_output(hdcp_w);
 }
-EXPORT_IF_KUNIT(hdcp_update_display);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_update_display);
 
 VISIBLE_IF_KUNIT
 void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
@@ -355,7 +355,7 @@ void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 	}
 	process_output(hdcp_w);
 }
-EXPORT_IF_KUNIT(hdcp_remove_display);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_remove_display);
 
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
 {
@@ -379,7 +379,7 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
 
 	process_output(hdcp_w);
 }
-EXPORT_IF_KUNIT(hdcp_reset_display);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_reset_display);
 
 void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
 {
@@ -387,7 +387,7 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index
 
 	schedule_work(&hdcp_w->cpirq_work);
 }
-EXPORT_IF_KUNIT(hdcp_handle_cpirq);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_handle_cpirq);
 
 VISIBLE_IF_KUNIT
 void event_callback(struct work_struct *work)
@@ -406,7 +406,7 @@ void event_callback(struct work_struct *work)
 
 	process_output(hdcp_work);
 }
-EXPORT_IF_KUNIT(event_callback);
+EXPORT_SYMBOL_IF_KUNIT(event_callback);
 
 VISIBLE_IF_KUNIT
 void event_property_update(struct work_struct *work)
@@ -468,7 +468,7 @@ void event_property_update(struct work_struct *work)
 		drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	}
 }
-EXPORT_IF_KUNIT(event_property_update);
+EXPORT_SYMBOL_IF_KUNIT(event_property_update);
 
 VISIBLE_IF_KUNIT
 void event_property_validate(struct work_struct *work)
@@ -520,7 +520,7 @@ void event_property_validate(struct work_struct *work)
 		}
 	}
 }
-EXPORT_IF_KUNIT(event_property_validate);
+EXPORT_SYMBOL_IF_KUNIT(event_property_validate);
 
 VISIBLE_IF_KUNIT
 void event_watchdog_timer(struct work_struct *work)
@@ -541,7 +541,7 @@ void event_watchdog_timer(struct work_struct *work)
 
 	process_output(hdcp_work);
 }
-EXPORT_IF_KUNIT(event_watchdog_timer);
+EXPORT_SYMBOL_IF_KUNIT(event_watchdog_timer);
 
 VISIBLE_IF_KUNIT
 void event_cpirq(struct work_struct *work)
@@ -556,7 +556,7 @@ void event_cpirq(struct work_struct *work)
 
 	process_output(hdcp_work);
 }
-EXPORT_IF_KUNIT(event_cpirq);
+EXPORT_SYMBOL_IF_KUNIT(event_cpirq);
 
 void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 {
@@ -573,7 +573,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 	kfree(hdcp_work->srm_temp);
 	kfree(hdcp_work);
 }
-EXPORT_IF_KUNIT(hdcp_destroy);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_destroy);
 
 VISIBLE_IF_KUNIT
 bool enable_assr(void *handle, struct dc_link *link)
@@ -609,7 +609,7 @@ bool enable_assr(void *handle, struct dc_link *link)
 
 	return true;
 }
-EXPORT_IF_KUNIT(enable_assr);
+EXPORT_SYMBOL_IF_KUNIT(enable_assr);
 
 VISIBLE_IF_KUNIT
 void update_config(void *handle, struct cp_psp_stream_config *config)
@@ -698,7 +698,7 @@ void update_config(void *handle, struct cp_psp_stream_config *config)
 	hdcp_w->aconnector[conn_index] = aconnector;
 	process_output(hdcp_w);
 }
-EXPORT_IF_KUNIT(update_config);
+EXPORT_SYMBOL_IF_KUNIT(update_config);
 
 /**
  * DOC: Add sysfs interface for set/get srm
@@ -771,7 +771,7 @@ VISIBLE_IF_KUNIT ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-EXPORT_IF_KUNIT(srm_data_write);
+EXPORT_SYMBOL_IF_KUNIT(srm_data_write);
 
 VISIBLE_IF_KUNIT ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
 			     const struct bin_attribute *bin_attr, char *buffer,
@@ -809,7 +809,7 @@ VISIBLE_IF_KUNIT ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
 	link_lock(work, false);
 	return ret;
 }
-EXPORT_IF_KUNIT(srm_data_read);
+EXPORT_SYMBOL_IF_KUNIT(srm_data_read);
 
 /* From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
  *
@@ -926,5 +926,5 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 
 	return NULL;
 }
-EXPORT_IF_KUNIT(hdcp_create_workqueue);
+EXPORT_SYMBOL_IF_KUNIT(hdcp_create_workqueue);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ca5d7ca99f8f..e734374a484c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -95,7 +95,7 @@ VISIBLE_IF_KUNIT u32 edid_extract_panel_id(struct edid *edid)
 	       (u32)edid->mfg_id[1] << 16   |
 	       (u32)EDID_PRODUCT_ID(edid);
 }
-EXPORT_IF_KUNIT(edid_extract_panel_id);
+EXPORT_SYMBOL_IF_KUNIT(edid_extract_panel_id);
 
 VISIBLE_IF_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 			      struct dc_edid_caps *edid_caps)
@@ -151,7 +151,7 @@ VISIBLE_IF_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		return;
 	}
 }
-EXPORT_IF_KUNIT(apply_edid_quirks);
+EXPORT_SYMBOL_IF_KUNIT(apply_edid_quirks);
 
 /**
  * dm_helpers_parse_edid_caps() - Parse edid caps
@@ -248,7 +248,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	return result;
 }
-EXPORT_IF_KUNIT(dm_helpers_parse_edid_caps);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_parse_edid_caps);
 
 VISIBLE_IF_KUNIT void
 fill_dc_mst_payload_table_from_drm(struct dc_link *link,
@@ -300,13 +300,13 @@ fill_dc_mst_payload_table_from_drm(struct dc_link *link,
 	/* Overwrite the old table */
 	*table = new_table;
 }
-EXPORT_IF_KUNIT(fill_dc_mst_payload_table_from_drm);
+EXPORT_SYMBOL_IF_KUNIT(fill_dc_mst_payload_table_from_drm);
 
 void dm_helpers_dp_update_branch_info(
 	struct dc_context *ctx,
 	const struct dc_link *link)
 {}
-EXPORT_IF_KUNIT(dm_helpers_dp_update_branch_info);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_update_branch_info);
 
 VISIBLE_IF_KUNIT void dm_helpers_construct_old_payload(
 			struct drm_dp_mst_topology_mgr *mgr,
@@ -339,7 +339,7 @@ VISIBLE_IF_KUNIT void dm_helpers_construct_old_payload(
 	old_payload->time_slots = allocated_time_slots;
 	old_payload->pbn = allocated_time_slots * pbn_per_slot;
 }
-EXPORT_IF_KUNIT(dm_helpers_construct_old_payload);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_construct_old_payload);
 
 /*
  * Writes payload allocation table in immediate downstream device.
@@ -392,7 +392,7 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 
 	return true;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_write_payload_allocation_table);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_write_payload_allocation_table);
 
 /*
  * poll pending down reply
@@ -401,7 +401,7 @@ void dm_helpers_dp_mst_poll_pending_down_reply(
 	struct dc_context *ctx,
 	const struct dc_link *link)
 {}
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_poll_pending_down_reply);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_poll_pending_down_reply);
 
 /*
  * Clear payload allocation table before enable MST DP link.
@@ -410,7 +410,7 @@ void dm_helpers_dp_mst_clear_payload_allocation_table(
 	struct dc_context *ctx,
 	const struct dc_link *link)
 {}
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_clear_payload_allocation_table);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_clear_payload_allocation_table);
 
 /*
  * Polls for ACT (allocation change trigger) handled and sends
@@ -441,7 +441,7 @@ enum act_return_status dm_helpers_dp_mst_poll_for_allocation_change_trigger(
 
 	return ACT_SUCCESS;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_poll_for_allocation_change_trigger);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_poll_for_allocation_change_trigger);
 
 void dm_helpers_dp_mst_send_payload_allocation(
 		struct dc_context *ctx,
@@ -476,7 +476,7 @@ void dm_helpers_dp_mst_send_payload_allocation(
 			clr_flag, false);
 	}
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_send_payload_allocation);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_send_payload_allocation);
 
 void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
 		struct dc_context *ctx,
@@ -505,7 +505,7 @@ void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
 	amdgpu_dm_set_mst_status(&aconnector->mst_status, set_flag, true);
 	amdgpu_dm_set_mst_status(&aconnector->mst_status, clr_flag, false);
  }
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_update_mst_mgr_for_deallocation);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_update_mst_mgr_for_deallocation);
 
 void dm_dtn_log_begin(struct dc_context *ctx,
 	struct dc_log_buffer_ctx *log_ctx)
@@ -519,7 +519,7 @@ void dm_dtn_log_begin(struct dc_context *ctx,
 
 	dm_dtn_log_append_v(ctx, log_ctx, "%s", msg);
 }
-EXPORT_IF_KUNIT(dm_dtn_log_begin);
+EXPORT_SYMBOL_IF_KUNIT(dm_dtn_log_begin);
 
 __printf(3, 4)
 void dm_dtn_log_append_v(struct dc_context *ctx,
@@ -582,7 +582,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 	if (n > 0)
 		log_ctx->pos += n;
 }
-EXPORT_IF_KUNIT(dm_dtn_log_append_v);
+EXPORT_SYMBOL_IF_KUNIT(dm_dtn_log_append_v);
 
 void dm_dtn_log_end(struct dc_context *ctx,
 	struct dc_log_buffer_ctx *log_ctx)
@@ -596,7 +596,7 @@ void dm_dtn_log_end(struct dc_context *ctx,
 
 	dm_dtn_log_append_v(ctx, log_ctx, "%s", msg);
 }
-EXPORT_IF_KUNIT(dm_dtn_log_end);
+EXPORT_SYMBOL_IF_KUNIT(dm_dtn_log_end);
 
 bool dm_helpers_dp_mst_start_top_mgr(
 		struct dc_context *ctx,
@@ -631,7 +631,7 @@ bool dm_helpers_dp_mst_start_top_mgr(
 
 	return true;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_start_top_mgr);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_start_top_mgr);
 
 bool dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_context *ctx,
@@ -654,7 +654,7 @@ bool dm_helpers_dp_mst_stop_top_mgr(
 
 	return false;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_stop_top_mgr);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_stop_top_mgr);
 
 bool dm_helpers_dp_read_dpcd(
 		struct dc_context *ctx,
@@ -672,7 +672,7 @@ bool dm_helpers_dp_read_dpcd(
 	return drm_dp_dpcd_read(&aconnector->dm_dp_aux.aux, address, data,
 				size) == size;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_read_dpcd);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_read_dpcd);
 
 bool dm_helpers_dp_write_dpcd(
 		struct dc_context *ctx,
@@ -689,7 +689,7 @@ bool dm_helpers_dp_write_dpcd(
 	return drm_dp_dpcd_write(&aconnector->dm_dp_aux.aux,
 			address, (uint8_t *)data, size) > 0;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_write_dpcd);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_write_dpcd);
 
 bool dm_helpers_submit_i2c(
 		struct dc_context *ctx,
@@ -725,7 +725,7 @@ bool dm_helpers_submit_i2c(
 
 	return result;
 }
-EXPORT_IF_KUNIT(dm_helpers_submit_i2c);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_submit_i2c);
 
 bool dm_helpers_execute_fused_io(
 		struct dc_context *ctx,
@@ -739,7 +739,7 @@ bool dm_helpers_execute_fused_io(
 
 	return amdgpu_dm_execute_fused_io(dev, link, commands, count, timeout_us);
 }
-EXPORT_IF_KUNIT(dm_helpers_execute_fused_io);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_execute_fused_io);
 
 VISIBLE_IF_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		bool is_write_cmd,
@@ -813,7 +813,7 @@ VISIBLE_IF_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 	DRM_ERROR("%s: write cmd ..., err = %d\n",  __func__, ret);
 	return false;
 }
-EXPORT_IF_KUNIT(execute_synaptics_rc_command);
+EXPORT_SYMBOL_IF_KUNIT(execute_synaptics_rc_command);
 
 VISIBLE_IF_KUNIT void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 {
@@ -879,7 +879,7 @@ VISIBLE_IF_KUNIT void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 
 	drm_dbg_dp(aux->drm_dev, "Done\n");
 }
-EXPORT_IF_KUNIT(apply_synaptics_fifo_reset_wa);
+EXPORT_SYMBOL_IF_KUNIT(apply_synaptics_fifo_reset_wa);
 
 /* MST Dock */
 static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
@@ -920,7 +920,7 @@ VISIBLE_IF_KUNIT uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 
 	return ret;
 }
-EXPORT_IF_KUNIT(write_dsc_enable_synaptics_non_virtual_dpcd_mst);
+EXPORT_SYMBOL_IF_KUNIT(write_dsc_enable_synaptics_non_virtual_dpcd_mst);
 
 bool dm_helpers_dp_write_dsc_enable(
 		struct dc_context *ctx,
@@ -1004,20 +1004,20 @@ bool dm_helpers_dp_write_dsc_enable(
 
 	return ret;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_write_dsc_enable);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_write_dsc_enable);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 uint dm_helpers_get_dc_debug_mask(void)
 {
 	return amdgpu_dc_debug_mask;
 }
-EXPORT_IF_KUNIT(dm_helpers_get_dc_debug_mask);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_get_dc_debug_mask);
 
 void dm_helpers_set_dc_debug_mask(uint debug_mask)
 {
 	amdgpu_dc_debug_mask = debug_mask;
 }
-EXPORT_IF_KUNIT(dm_helpers_set_dc_debug_mask);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_set_dc_debug_mask);
 #endif
 
 bool dm_helpers_dp_write_hblank_reduction(struct dc_context *ctx, const struct dc_stream_state *stream)
@@ -1025,7 +1025,7 @@ bool dm_helpers_dp_write_hblank_reduction(struct dc_context *ctx, const struct d
 	// TODO
 	return false;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_write_hblank_reduction);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_write_hblank_reduction);
 
 bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 {
@@ -1042,7 +1042,7 @@ bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 	mutex_unlock(&aconnector->dm_dp_aux.aux.hw_mutex);
 	return dp_sink_present;
 }
-EXPORT_IF_KUNIT(dm_helpers_is_dp_sink_present);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_is_dp_sink_present);
 
 VISIBLE_IF_KUNIT int
 dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
@@ -1082,7 +1082,7 @@ dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
 
 	return r;
 }
-EXPORT_IF_KUNIT(dm_helpers_probe_acpi_edid);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_probe_acpi_edid);
 
 VISIBLE_IF_KUNIT const struct drm_edid *
 dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
@@ -1105,7 +1105,7 @@ dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 
 	return drm_edid_read_custom(connector, dm_helpers_probe_acpi_edid, connector);
 }
-EXPORT_IF_KUNIT(dm_helpers_read_acpi_edid);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_read_acpi_edid);
 
 VISIBLE_IF_KUNIT const struct drm_edid *
 dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
@@ -1145,7 +1145,7 @@ dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_conn
 
 	return edid;
 }
-EXPORT_IF_KUNIT(dm_helpers_read_vbios_hardcoded_edid);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_read_vbios_hardcoded_edid);
 
 VISIBLE_IF_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
 {
@@ -1168,7 +1168,7 @@ VISIBLE_IF_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_pe
 
 	return max_frl_rate;
 }
-EXPORT_IF_KUNIT(get_max_frl_rate);
+EXPORT_SYMBOL_IF_KUNIT(get_max_frl_rate);
 
 VISIBLE_IF_KUNIT uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
 {
@@ -1193,7 +1193,7 @@ VISIBLE_IF_KUNIT uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slic
 
 	return dsc_max_slices;
 }
-EXPORT_IF_KUNIT(get_dsc_max_slices);
+EXPORT_SYMBOL_IF_KUNIT(get_dsc_max_slices);
 
 void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
 {
@@ -1214,7 +1214,7 @@ void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *hd
 		}
 	}
 }
-EXPORT_IF_KUNIT(populate_hdmi_info_from_connector);
+EXPORT_SYMBOL_IF_KUNIT(populate_hdmi_info_from_connector);
 
 enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_context *ctx,
@@ -1346,7 +1346,7 @@ int dm_helper_dmub_aux_transfer_sync(
 	return amdgpu_dm_process_dmub_aux_transfer_sync(ctx, link->link_index, payload,
 			operation_result);
 }
-EXPORT_IF_KUNIT(dm_helper_dmub_aux_transfer_sync);
+EXPORT_SYMBOL_IF_KUNIT(dm_helper_dmub_aux_transfer_sync);
 
 int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 		const struct dc_link *link,
@@ -1361,21 +1361,21 @@ void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
 {
 	/* TODO: something */
 }
-EXPORT_IF_KUNIT(dm_set_dcn_clocks);
+EXPORT_SYMBOL_IF_KUNIT(dm_set_dcn_clocks);
 
 void dm_helpers_dmu_timeout(struct dc_context *ctx)
 {
 	// TODO:
 	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
 }
-EXPORT_IF_KUNIT(dm_helpers_dmu_timeout);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dmu_timeout);
 
 void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us)
 {
 	// TODO:
 	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
 }
-EXPORT_IF_KUNIT(dm_helpers_smu_timeout);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_smu_timeout);
 
 void dm_helpers_init_panel_settings(
 	struct dc_context *ctx,
@@ -1394,7 +1394,7 @@ void dm_helpers_init_panel_settings(
 	panel_config->dsc.disable_dsc_edp = false;
 	panel_config->dsc.force_dsc_edp_policy = 0;
 }
-EXPORT_IF_KUNIT(dm_helpers_init_panel_settings);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_init_panel_settings);
 
 void dm_helpers_override_panel_settings(
 	struct dc_context *ctx,
@@ -1412,7 +1412,7 @@ void dm_helpers_override_panel_settings(
 		link->panel_config.psr.disallow_replay = true;
 	}
 }
-EXPORT_IF_KUNIT(dm_helpers_override_panel_settings);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_override_panel_settings);
 
 void *dm_helpers_allocate_gpu_mem(
 		struct dc_context *ctx,
@@ -1448,7 +1448,7 @@ bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enabl
 			 enable ? "en" : "dis", ret);
 	return ret;
 }
-EXPORT_IF_KUNIT(dm_helpers_dmub_outbox_interrupt_control);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dmub_outbox_interrupt_control);
 
 void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream)
 {
@@ -1474,7 +1474,7 @@ void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream)
 					 &new_downspread.raw,
 					 sizeof(new_downspread));
 }
-EXPORT_IF_KUNIT(dm_helpers_mst_enable_stream_features);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_mst_enable_stream_features);
 
 bool dm_helpers_dp_handle_test_pattern_request(
 		struct dc_context *ctx,
@@ -1613,13 +1613,13 @@ bool dm_helpers_dp_handle_test_pattern_request(
 
 	return false;
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_handle_test_pattern_request);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_handle_test_pattern_request);
 
 void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
 {
        // TODO
 }
-EXPORT_IF_KUNIT(dm_set_phyd32clk);
+EXPORT_SYMBOL_IF_KUNIT(dm_set_phyd32clk);
 
 void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
@@ -1631,7 +1631,7 @@ void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 			schedule_work(&adev->dm.idle_workqueue->work);
 	}
 }
-EXPORT_IF_KUNIT(dm_helpers_enable_periodic_detection);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_enable_periodic_detection);
 
 void dm_helpers_dp_mst_update_branch_bandwidth(
 		struct dc_context *ctx,
@@ -1639,7 +1639,7 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 {
 	// TODO
 }
-EXPORT_IF_KUNIT(dm_helpers_dp_mst_update_branch_bandwidth);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_dp_mst_update_branch_bandwidth);
 
 VISIBLE_IF_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
 	DP_BRANCH_DEVICE_ID_0060AD,
@@ -1648,13 +1648,13 @@ VISIBLE_IF_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
 	DP_BRANCH_DEVICE_ID_001CF8,
 	DP_BRANCH_DEVICE_ID_001FF2,
 };
-EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist);
+EXPORT_SYMBOL_IF_KUNIT(dm_freesync_pcon_whitelist);
 
 VISIBLE_IF_KUNIT uint32_t dm_freesync_pcon_whitelist_count(void)
 {
 	return ARRAY_SIZE(dm_freesync_pcon_whitelist);
 }
-EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist_count);
+EXPORT_SYMBOL_IF_KUNIT(dm_freesync_pcon_whitelist_count);
 
 VISIBLE_IF_KUNIT bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
 {
@@ -1666,7 +1666,7 @@ VISIBLE_IF_KUNIT bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id
 
 	return false;
 }
-EXPORT_IF_KUNIT(dm_is_freesync_pcon_whitelist);
+EXPORT_SYMBOL_IF_KUNIT(dm_is_freesync_pcon_whitelist);
 
 enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link)
 {
@@ -1686,21 +1686,21 @@ enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link)
 
 	return as_type;
 }
-EXPORT_IF_KUNIT(dm_get_adaptive_sync_support_type);
+EXPORT_SYMBOL_IF_KUNIT(dm_get_adaptive_sync_support_type);
 
 bool dm_helpers_is_fullscreen(struct dc_context *ctx, struct dc_stream_state *stream)
 {
 	// TODO
 	return false;
 }
-EXPORT_IF_KUNIT(dm_helpers_is_fullscreen);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_is_fullscreen);
 
 bool dm_helpers_is_hdr_on(struct dc_context *ctx, struct dc_stream_state *stream)
 {
 	// TODO
 	return false;
 }
-EXPORT_IF_KUNIT(dm_helpers_is_hdr_on);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_is_hdr_on);
 
 static int mccs_operation_vcp_request(unsigned int vcp_code, struct dc_link *link,
 				union vcp_reply *reply)
@@ -1826,7 +1826,7 @@ void dm_helpers_read_mccs_caps(struct dc_context *ctx, struct dc_link *link,
 		}
 	}
 }
-EXPORT_IF_KUNIT(dm_helpers_read_mccs_caps);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_read_mccs_caps);
 
 static int mccs_operation_vcp_set(unsigned int vcp_code, struct dc_link *link, uint16_t value)
 {
@@ -1901,7 +1901,7 @@ void dm_helpers_mccs_vcp_set(struct dc_context *ctx, struct dc_link *link,
 		drm_dbg_driver(dev, "%s: Failed to set VCP code %d", __func__,
 				sink->edid_caps.freesync_vcp_code);
 }
-EXPORT_IF_KUNIT(dm_helpers_mccs_vcp_set);
+EXPORT_SYMBOL_IF_KUNIT(dm_helpers_mccs_vcp_set);
 
 bool dm_helpers_submit_i2c_over_aux(struct ddc_service *ddc, uint32_t address, uint8_t offset,
 				    uint8_t *cmdBuffer, uint32_t len, bool read)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 2a551ccf79fa..01379bce00ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -327,7 +327,7 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 
 	return handler_data;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_register_interrupt);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_register_interrupt);
 
 /**
  * amdgpu_dm_irq_unregister_interrupt() - Remove a handler from the DM IRQ table
@@ -372,7 +372,7 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
 			ih, irq_source);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_unregister_interrupt);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_unregister_interrupt);
 
 /**
  * amdgpu_dm_irq_init() - Initialize DM IRQ management
@@ -422,7 +422,7 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_init);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_init);
 
 /**
  * amdgpu_dm_irq_fini() - Tear down DM IRQ management
@@ -504,7 +504,7 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 		adev->dm.irq_wq = NULL;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_fini);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_fini);
 
 void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 {
@@ -551,7 +551,7 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	if (dev->mode_config.poll_enabled)
 		drm_kms_helper_poll_disable(dev);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_suspend);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_suspend);
 
 void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 {
@@ -573,7 +573,7 @@ void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_resume_early);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_resume_early);
 
 void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 {
@@ -602,7 +602,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 	if (dev->mode_config.poll_enabled)
 		drm_kms_helper_poll_enable(dev);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_resume_late);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_resume_late);
 
 /*
  * amdgpu_dm_irq_schedule_work - schedule all work items registered for the
@@ -663,7 +663,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 out_unlock:
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_schedule_work);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_schedule_work);
 
 /*
  * amdgpu_dm_irq_immediate_work
@@ -688,7 +688,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_immediate_work);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_immediate_work);
 
 /**
  * amdgpu_dm_irq_handler - Generic DM IRQ handler
@@ -719,7 +719,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_irq_handler);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_irq_handler);
 
 VISIBLE_IF_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
 {
@@ -740,7 +740,7 @@ VISIBLE_IF_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int
 		return DC_IRQ_SOURCE_INVALID;
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_hpd_to_dal_irq_source);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_hpd_to_dal_irq_source);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
@@ -753,7 +753,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 	dc_interrupt_set(adev->dm.dc, src, st);
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_hpd_irq_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_hpd_irq_state);
 
 static inline int dm_irq_state(struct amdgpu_device *adev,
 			       struct amdgpu_irq_src *source,
@@ -802,7 +802,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 		IRQ_TYPE_PFLIP,
 		__func__);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_pflip_irq_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_pflip_irq_state);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
@@ -817,7 +817,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 		IRQ_TYPE_VBLANK,
 		__func__);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_crtc_irq_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_crtc_irq_state);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
@@ -832,7 +832,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 		IRQ_TYPE_VLINE0,
 		__func__);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_vline0_irq_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_vline0_irq_state);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
@@ -845,7 +845,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *a
 	dc_interrupt_set(adev->dm.dc, irq_source, st);
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_outbox_irq_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_dmub_outbox_irq_state);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
@@ -860,7 +860,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 		IRQ_TYPE_VUPDATE,
 		__func__);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_vupdate_irq_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_vupdate_irq_state);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
@@ -873,7 +873,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *ad
 	dc_interrupt_set(adev->dm.dc, irq_source, st);
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_trace_irq_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_dmub_trace_irq_state);
 
 static const struct amdgpu_irq_src_funcs dm_crtc_irq_funcs = {
 	.set = amdgpu_dm_set_crtc_irq_state,
@@ -933,7 +933,7 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
 	adev->hpd_irq.num_types = adev->mode_info.num_hpd;
 	adev->hpd_irq.funcs = &dm_hpd_irq_funcs;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_irq_funcs);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_irq_funcs);
 
 void amdgpu_dm_outbox_init(struct amdgpu_device *adev)
 {
@@ -941,7 +941,7 @@ void amdgpu_dm_outbox_init(struct amdgpu_device *adev)
 		DC_IRQ_SOURCE_DMCUB_OUTBOX,
 		true);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_outbox_init);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_outbox_init);
 
 /**
  * amdgpu_dm_hpd_init - hpd setup callback.
@@ -1024,7 +1024,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	if (use_polling)
 		drm_kms_helper_poll_init(dev);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_hpd_init);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_hpd_init);
 
 /**
  * amdgpu_dm_hpd_fini - hpd tear down callback.
@@ -1078,7 +1078,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	if (dev->mode_config.poll_enabled)
 		drm_kms_helper_poll_fini(dev);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_hpd_fini);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_hpd_fini);
 
 /* ========== HPD handling ========== */
 static void force_connector_state(
@@ -1189,7 +1189,7 @@ VISIBLE_IF_KUNIT void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	kfree(offload_work);
 
 }
-EXPORT_IF_KUNIT(dm_handle_hpd_rx_offload_work);
+EXPORT_SYMBOL_IF_KUNIT(dm_handle_hpd_rx_offload_work);
 
 struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(struct amdgpu_device *adev)
 {
@@ -1226,7 +1226,7 @@ struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(stru
 	kfree(hpd_rx_offload_wq);
 	return NULL;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_hpd_rx_irq_create_workqueue);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_hpd_rx_irq_create_workqueue);
 
 void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 {
@@ -1237,7 +1237,7 @@ void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 			flush_workqueue(dm->hpd_rx_offload_wq[i].wq);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_hpd_rx_irq_work_suspend);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_hpd_rx_irq_work_suspend);
 
 VISIBLE_IF_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
 {
@@ -1254,7 +1254,7 @@ VISIBLE_IF_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct
 		return false;
 	return true;
 }
-EXPORT_IF_KUNIT(are_sinks_equal);
+EXPORT_SYMBOL_IF_KUNIT(are_sinks_equal);
 
 
 /**
@@ -1331,7 +1331,7 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 			dc_allow_idle_optimizations(dc, true);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_hdmi_hpd_debounce_work);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_hdmi_hpd_debounce_work);
 
 VISIBLE_IF_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 				  enum dc_detect_reason reason)
@@ -1431,7 +1431,7 @@ VISIBLE_IF_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnect
 		}
 	}
 }
-EXPORT_IF_KUNIT(handle_hpd_irq_helper);
+EXPORT_SYMBOL_IF_KUNIT(handle_hpd_irq_helper);
 
 VISIBLE_IF_KUNIT void handle_hpd_irq(void *param)
 {
@@ -1440,7 +1440,7 @@ VISIBLE_IF_KUNIT void handle_hpd_irq(void *param)
 	handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);
 
 }
-EXPORT_IF_KUNIT(handle_hpd_irq);
+EXPORT_SYMBOL_IF_KUNIT(handle_hpd_irq);
 
 VISIBLE_IF_KUNIT void
 schedule_hpd_rx_offload_work(struct amdgpu_device *adev,
@@ -1462,7 +1462,7 @@ schedule_hpd_rx_offload_work(struct amdgpu_device *adev,
 	queue_work(offload_wq->wq, &offload_work->work);
 	drm_dbg_kms(adev_to_drm(adev), "queue work to handle hpd_rx offload work");
 }
-EXPORT_IF_KUNIT(schedule_hpd_rx_offload_work);
+EXPORT_SYMBOL_IF_KUNIT(schedule_hpd_rx_offload_work);
 
 VISIBLE_IF_KUNIT void handle_hpd_rx_irq(void *param)
 {
@@ -1597,7 +1597,7 @@ VISIBLE_IF_KUNIT void handle_hpd_rx_irq(void *param)
 
 	mutex_unlock(&aconnector->hpd_lock);
 }
-EXPORT_IF_KUNIT(handle_hpd_rx_irq);
+EXPORT_SYMBOL_IF_KUNIT(handle_hpd_rx_irq);
 
 /**
  * dmub_hpd_callback - DMUB HPD interrupt processing callback.
@@ -1673,7 +1673,7 @@ VISIBLE_IF_KUNIT void dmub_hpd_callback(struct amdgpu_device *adev,
 		}
 	}
 }
-EXPORT_IF_KUNIT(dmub_hpd_callback);
+EXPORT_SYMBOL_IF_KUNIT(dmub_hpd_callback);
 
 /**
  * dmub_hpd_sense_callback - DMUB HPD sense processing callback.
@@ -1688,7 +1688,7 @@ VISIBLE_IF_KUNIT void dmub_hpd_sense_callback(struct amdgpu_device *adev,
 {
 	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
 }
-EXPORT_IF_KUNIT(dmub_hpd_sense_callback);
+EXPORT_SYMBOL_IF_KUNIT(dmub_hpd_sense_callback);
 
 int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
 {
@@ -1770,7 +1770,7 @@ int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
 	}
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_register_hpd_handlers);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_register_hpd_handlers);
 
 /* ========== IRQ handlers ========== */
 struct amdgpu_crtc *
@@ -1793,7 +1793,7 @@ amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
 
 	return NULL;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_get_crtc_by_otg_inst);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_get_crtc_by_otg_inst);
 
 /**
  * dm_pflip_high_irq() - Handle pageflip interrupt
@@ -1898,7 +1898,7 @@ VISIBLE_IF_KUNIT void dm_pflip_high_irq(void *interrupt_params)
 		      "crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
 		      amdgpu_crtc->crtc_id, amdgpu_crtc, vrr_active, (int)!e);
 }
-EXPORT_IF_KUNIT(dm_pflip_high_irq);
+EXPORT_SYMBOL_IF_KUNIT(dm_pflip_high_irq);
 
 VISIBLE_IF_KUNIT void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
 {
@@ -1915,7 +1915,7 @@ VISIBLE_IF_KUNIT void dm_handle_vmin_vmax_update(struct work_struct *offload_wor
 	kfree(work->adjust);
 	kfree(work);
 }
-EXPORT_IF_KUNIT(dm_handle_vmin_vmax_update);
+EXPORT_SYMBOL_IF_KUNIT(dm_handle_vmin_vmax_update);
 
 static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	struct dc_stream_state *stream,
@@ -2151,7 +2151,7 @@ VISIBLE_IF_KUNIT void dm_vupdate_high_irq(void *interrupt_params)
 		}
 	}
 }
-EXPORT_IF_KUNIT(dm_vupdate_high_irq);
+EXPORT_SYMBOL_IF_KUNIT(dm_vupdate_high_irq);
 
 /**
  * dm_crtc_high_irq() - Handles CRTC interrupt
@@ -2174,7 +2174,7 @@ VISIBLE_IF_KUNIT void dm_crtc_high_irq(void *interrupt_params)
 
 	dm_crtc_high_irq_handler(adev, acrtc);
 }
-EXPORT_IF_KUNIT(dm_crtc_high_irq);
+EXPORT_SYMBOL_IF_KUNIT(dm_crtc_high_irq);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 /**
@@ -2219,7 +2219,7 @@ VISIBLE_IF_KUNIT void dm_handle_hpd_work(struct work_struct *work)
 	kfree(dmub_hpd_wrk);
 
 }
-EXPORT_IF_KUNIT(dm_handle_hpd_work);
+EXPORT_SYMBOL_IF_KUNIT(dm_handle_hpd_work);
 
 VISIBLE_IF_KUNIT const char *dmub_notification_type_str(enum dmub_notification_type e)
 {
@@ -2244,7 +2244,7 @@ VISIBLE_IF_KUNIT const char *dmub_notification_type_str(enum dmub_notification_t
 		return "<unknown>";
 	}
 }
-EXPORT_IF_KUNIT(dmub_notification_type_str);
+EXPORT_SYMBOL_IF_KUNIT(dmub_notification_type_str);
 
 #define DMUB_TRACE_MAX_READ 64
 /**
@@ -2318,7 +2318,7 @@ VISIBLE_IF_KUNIT void dm_dmub_outbox1_low_irq(void *interrupt_params)
 		} while (notify.pending_notification);
 	}
 }
-EXPORT_IF_KUNIT(dm_dmub_outbox1_low_irq);
+EXPORT_SYMBOL_IF_KUNIT(dm_dmub_outbox1_low_irq);
 
 /* Register IRQ sources and initialize IRQ callbacks */
 int amdgpu_dm_dce110_register_irq_handlers(struct amdgpu_device *adev)
@@ -2457,7 +2457,7 @@ int amdgpu_dm_dce110_register_irq_handlers(struct amdgpu_device *adev)
 
 	return r;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_dce110_register_irq_handlers);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_dce110_register_irq_handlers);
 
 /* Register IRQ sources and initialize IRQ callbacks */
 int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)
@@ -2576,7 +2576,7 @@ int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)
 
 	return r;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_dcn10_register_irq_handlers);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_dcn10_register_irq_handlers);
 
 /* Register Outbox IRQ sources and initialize IRQ callbacks */
 int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev)
@@ -2614,4 +2614,4 @@ int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_register_outbox_irq_handlers);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_register_outbox_irq_handlers);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index b4cedf760f6b..6d2ecc2ae6ff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -128,7 +128,7 @@ bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
 	}
 	return true;
 }
-EXPORT_IF_KUNIT(dm_ism_next_state);
+EXPORT_SYMBOL_IF_KUNIT(dm_ism_next_state);
 
 VISIBLE_IF_KUNIT
 uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
@@ -153,7 +153,7 @@ uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
 
 	return sso_delay_ns;
 }
-EXPORT_IF_KUNIT(dm_ism_get_sso_delay);
+EXPORT_SYMBOL_IF_KUNIT(dm_ism_get_sso_delay);
 
 /**
  * dm_ism_get_idle_allow_delay - Calculate hysteresis-based idle allow delay
@@ -224,7 +224,7 @@ uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
 
 	return ret_ns;
 }
-EXPORT_IF_KUNIT(dm_ism_get_idle_allow_delay);
+EXPORT_SYMBOL_IF_KUNIT(dm_ism_get_idle_allow_delay);
 
 /**
  * dm_ism_insert_record - Insert a record into the circular history buffer
@@ -246,7 +246,7 @@ void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
 	record->duration_ns =
 		record->timestamp_ns - ism->last_idle_timestamp_ns;
 }
-EXPORT_IF_KUNIT(dm_ism_insert_record);
+EXPORT_SYMBOL_IF_KUNIT(dm_ism_insert_record);
 
 
 VISIBLE_IF_KUNIT
@@ -254,7 +254,7 @@ void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism)
 {
 	ism->last_idle_timestamp_ns = ktime_get_ns();
 }
-EXPORT_IF_KUNIT(dm_ism_set_last_idle_ts);
+EXPORT_SYMBOL_IF_KUNIT(dm_ism_set_last_idle_ts);
 
 
 VISIBLE_IF_KUNIT
@@ -273,7 +273,7 @@ bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
 
 	return gotNextState;
 }
-EXPORT_IF_KUNIT(dm_ism_trigger_event);
+EXPORT_SYMBOL_IF_KUNIT(dm_ism_trigger_event);
 
 
 static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
@@ -354,7 +354,7 @@ enum amdgpu_dm_ism_event dm_ism_dispatch_next_event(
 	}
 	return DM_ISM_NUM_EVENTS;
 }
-EXPORT_IF_KUNIT(dm_ism_dispatch_next_event);
+EXPORT_SYMBOL_IF_KUNIT(dm_ism_dispatch_next_event);
 
 static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
 	struct amdgpu_dm_ism *ism,
@@ -502,7 +502,7 @@ void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
 
 	} while (next_event < DM_ISM_NUM_EVENTS);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_ism_commit_event);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_ism_commit_event);
 
 
 static void dm_ism_delayed_work_func(struct work_struct *work)
@@ -569,7 +569,7 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
 		disable_delayed_work_sync(&ism->sso_delayed_work);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_ism_disable);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_ism_disable);
 
 /**
  * amdgpu_dm_ism_force_full_power - Force every CRTC's ISM FSM to FULL_POWER
@@ -605,7 +605,7 @@ void amdgpu_dm_ism_force_full_power(struct amdgpu_display_manager *dm)
 					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_ism_force_full_power);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_ism_force_full_power);
 
 /**
  * amdgpu_dm_ism_enable - enable the ISM
@@ -629,7 +629,7 @@ void amdgpu_dm_ism_enable(struct amdgpu_display_manager *dm)
 		enable_delayed_work(&ism->sso_delayed_work);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_ism_enable);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_ism_enable);
 
 void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
 			struct amdgpu_dm_ism_config *config)
@@ -644,7 +644,7 @@ void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
 	INIT_DELAYED_WORK(&ism->delayed_work, dm_ism_delayed_work_func);
 	INIT_DELAYED_WORK(&ism->sso_delayed_work, dm_ism_sso_delayed_work_func);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_ism_init);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_ism_init);
 
 
 void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism)
@@ -652,4 +652,4 @@ void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism)
 	cancel_delayed_work_sync(&ism->sso_delayed_work);
 	cancel_delayed_work_sync(&ism->delayed_work);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_ism_fini);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_ism_fini);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8c996d5aa7b8..e09ed1b2fac5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -79,7 +79,7 @@ VISIBLE_IF_KUNIT ssize_t dm_dp_aux_transfer_result(ssize_t result,
 
 	return result;
 }
-EXPORT_IF_KUNIT(dm_dp_aux_transfer_result);
+EXPORT_SYMBOL_IF_KUNIT(dm_dp_aux_transfer_result);
 
 /*
  * Derive the AUX payload transaction flags from a DP AUX request field.
@@ -93,7 +93,7 @@ VISIBLE_IF_KUNIT void dm_dp_aux_fill_payload_flags(u8 request,
 	payload->write_status_update =
 			(request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
 }
-EXPORT_IF_KUNIT(dm_dp_aux_fill_payload_flags);
+EXPORT_SYMBOL_IF_KUNIT(dm_dp_aux_fill_payload_flags);
 
 /*
  * This function handles both native AUX and I2C-Over-AUX transactions.
@@ -166,7 +166,7 @@ VISIBLE_IF_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 
 	return result;
 }
-EXPORT_IF_KUNIT(dm_dp_aux_transfer);
+EXPORT_SYMBOL_IF_KUNIT(dm_dp_aux_transfer);
 
 static void
 dm_dp_mst_connector_destroy(struct drm_connector *connector)
@@ -216,7 +216,7 @@ amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector
 	aconnector->mst_local_bw = 0;
 	aconnector->vc_full_pbn = 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_mst_reset_mst_connector_setting);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_mst_reset_mst_connector_setting);
 
 static void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
@@ -273,7 +273,7 @@ bool needs_dsc_aux_workaround(struct dc_link *link)
 
 	return false;
 }
-EXPORT_IF_KUNIT(needs_dsc_aux_workaround);
+EXPORT_SYMBOL_IF_KUNIT(needs_dsc_aux_workaround);
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
 static bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port)
@@ -355,7 +355,7 @@ VISIBLE_IF_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector
 
 	return true;
 }
-EXPORT_IF_KUNIT(retrieve_downstream_port_device);
+EXPORT_SYMBOL_IF_KUNIT(retrieve_downstream_port_device);
 
 VISIBLE_IF_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector)
 {
@@ -384,7 +384,7 @@ VISIBLE_IF_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *
 
 	return true;
 }
-EXPORT_IF_KUNIT(retrieve_branch_specific_data);
+EXPORT_SYMBOL_IF_KUNIT(retrieve_branch_specific_data);
 
 static int dm_dp_mst_get_modes(struct drm_connector *connector)
 {
@@ -530,7 +530,7 @@ dm_mst_atomic_best_encoder(struct drm_connector *connector,
 
 	return &adev->dm.mst_encoders[acrtc->crtc_id].base;
 }
-EXPORT_IF_KUNIT(dm_mst_atomic_best_encoder);
+EXPORT_SYMBOL_IF_KUNIT(dm_mst_atomic_best_encoder);
 
 VISIBLE_IF_KUNIT int
 dm_dp_mst_detect(struct drm_connector *connector,
@@ -602,7 +602,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
 
 	return connection_status;
 }
-EXPORT_IF_KUNIT(dm_dp_mst_detect);
+EXPORT_SYMBOL_IF_KUNIT(dm_dp_mst_detect);
 
 VISIBLE_IF_KUNIT int dm_dp_mst_atomic_check(struct drm_connector *connector,
 					    struct drm_atomic_commit *state)
@@ -613,7 +613,7 @@ VISIBLE_IF_KUNIT int dm_dp_mst_atomic_check(struct drm_connector *connector,
 
 	return drm_dp_atomic_release_time_slots(state, mst_mgr, mst_port);
 }
-EXPORT_IF_KUNIT(dm_dp_mst_atomic_check);
+EXPORT_SYMBOL_IF_KUNIT(dm_dp_mst_atomic_check);
 
 static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
 	.get_modes = dm_dp_mst_get_modes,
@@ -654,7 +654,7 @@ dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev)
 		drm_encoder_helper_add(encoder, &amdgpu_dm_encoder_helper_funcs);
 	}
 }
-EXPORT_IF_KUNIT(dm_dp_create_fake_mst_encoders);
+EXPORT_SYMBOL_IF_KUNIT(dm_dp_create_fake_mst_encoders);
 
 static struct drm_connector *
 dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
@@ -757,7 +757,7 @@ VISIBLE_IF_KUNIT u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type)
 		return DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY;
 	}
 }
-EXPORT_IF_KUNIT(dm_mst_msg_ready_mask);
+EXPORT_SYMBOL_IF_KUNIT(dm_mst_msg_ready_mask);
 
 /*
  * Select the DPCD ESI address and read length based on the DPCD revision.
@@ -775,7 +775,7 @@ VISIBLE_IF_KUNIT void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr,
 		*dpcd_addr = DP_SINK_COUNT_ESI;
 	}
 }
-EXPORT_IF_KUNIT(dm_mst_select_esi_dpcd);
+EXPORT_SYMBOL_IF_KUNIT(dm_mst_select_esi_dpcd);
 
 void dm_handle_mst_sideband_msg_ready_event(
 	struct drm_dp_mst_topology_mgr *mgr,
@@ -860,13 +860,13 @@ void dm_handle_mst_sideband_msg_ready_event(
 	if (process_count == max_process_count)
 		DRM_DEBUG_DRIVER("Loop exceeded max iterations\n");
 }
-EXPORT_IF_KUNIT(dm_handle_mst_sideband_msg_ready_event);
+EXPORT_SYMBOL_IF_KUNIT(dm_handle_mst_sideband_msg_ready_event);
 
 VISIBLE_IF_KUNIT void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
 {
 	dm_handle_mst_sideband_msg_ready_event(mgr, DOWN_REP_MSG_RDY_EVENT);
 }
-EXPORT_IF_KUNIT(dm_handle_mst_down_rep_msg_ready);
+EXPORT_SYMBOL_IF_KUNIT(dm_handle_mst_down_rep_msg_ready);
 
 static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
 	.add_connector = dm_dp_add_mst_connector,
@@ -901,7 +901,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 
 	drm_connector_attach_dp_subconnector_property(&aconnector->base);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_initialize_dp_connector);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_initialize_dp_connector);
 
 uint32_t dm_mst_get_pbn_divider(struct dc_link *link)
 {
@@ -918,7 +918,7 @@ uint32_t dm_mst_get_pbn_divider(struct dc_link *link)
 
 	return dfixed_const(pbn_div_x100) / 100;
 }
-EXPORT_IF_KUNIT(dm_mst_get_pbn_divider);
+EXPORT_SYMBOL_IF_KUNIT(dm_mst_get_pbn_divider);
 
 struct dsc_mst_fairness_params {
 	struct dc_crtc_timing *timing;
@@ -2116,4 +2116,4 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 #endif
 	return DC_OK;
 }
-EXPORT_IF_KUNIT(dm_dp_mst_is_port_support_mode);
+EXPORT_SYMBOL_IF_KUNIT(dm_dp_mst_is_port_support_mode);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 08153ffb38cb..aceab4f13254 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -98,7 +98,7 @@ const struct drm_format_info *amdgpu_dm_plane_get_format_info(u32 pixel_format,
 {
 	return amdgpu_lookup_format_info(pixel_format, modifier);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_get_format_info);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_get_format_info);
 
 void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
 			       bool *per_pixel_alpha, bool *pre_multiplied_alpha,
@@ -152,7 +152,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_blending_from_plane_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_fill_blending_from_plane_state);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
 						   uint64_t *cap, uint64_t mod)
@@ -179,7 +179,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *si
 	(*mods)[*size] = mod;
 	*size += 1;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_add_modifier);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
 							 uint64_t *cap, uint64_t mod)
@@ -195,13 +195,13 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64
 
 	amdgpu_dm_plane_add_modifier(mods, size, cap, mod);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier_dedup);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_add_modifier_dedup);
 
 VISIBLE_IF_KUNIT bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
 {
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_has_dcc);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_modifier_has_dcc);
 
 VISIBLE_IF_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier)
 {
@@ -210,7 +210,7 @@ VISIBLE_IF_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_
 
 	return AMD_FMT_MOD_GET(TILE, modifier);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_gfx9_swizzle_mode);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_modifier_gfx9_swizzle_mode);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
 						struct dc_tiling_info *tiling_info,
@@ -245,7 +245,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier);
 
 VISIBLE_IF_KUNIT
 void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
@@ -268,7 +268,7 @@ void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_devic
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0))
 		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_device);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_device);
 
 VISIBLE_IF_KUNIT
 void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
@@ -298,7 +298,7 @@ void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_dev
 		/* for DCC we know it isn't rb aligned, so rb_per_se doesn't matter. */
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 						  const enum surface_pixel_format format,
@@ -348,7 +348,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
 									       const struct amdgpu_framebuffer *afb,
@@ -400,7 +400,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgp
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
 										const struct amdgpu_framebuffer *afb,
@@ -441,7 +441,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdg
 
 	return ret;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers);
 
 static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *adev,
 						  uint64_t **mods,
@@ -1069,7 +1069,7 @@ int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_get_plane_modifiers);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_get_plane_modifiers);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
 						       const struct dc_plane_cap *plane_cap,
@@ -1129,7 +1129,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *p
 
 	return num_formats;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_get_plane_formats);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_get_plane_formats);
 
 int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     const struct amdgpu_framebuffer *afb,
@@ -1219,7 +1219,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_plane_buffer_attributes);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_fill_plane_buffer_attributes);
 
 static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 					     struct drm_plane_state *new_state)
@@ -1387,7 +1387,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_de
 	if (*min_downscale == 1)
 		*min_downscale = 1000;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_get_min_max_dc_plane_scaling);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_get_min_max_dc_plane_scaling);
 
 int amdgpu_dm_plane_helper_check_state(struct drm_plane_state *state,
 				       struct drm_crtc_state *new_crtc_state)
@@ -1442,7 +1442,7 @@ int amdgpu_dm_plane_helper_check_state(struct drm_plane_state *state,
 	return drm_atomic_helper_check_plane_state(
 		state, new_crtc_state, min_scale, max_scale, true, true);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_helper_check_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_helper_check_state);
 
 int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 				const struct drm_plane_state *state,
@@ -1526,7 +1526,7 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_dc_scaling_info);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_fill_dc_scaling_info);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 						  struct drm_atomic_commit *state)
@@ -1574,7 +1574,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 
 	return -EINVAL;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_check);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_atomic_check);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 							struct drm_atomic_commit *state, bool flip)
@@ -1599,7 +1599,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_async_check);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_atomic_async_check);
 
 int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 					struct dc_cursor_position *position)
@@ -1647,7 +1647,7 @@ int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_get_cursor_position);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_get_cursor_position);
 
 void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 				 struct drm_plane_state *old_plane_state)
@@ -1772,7 +1772,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 
 	dc_plane_force_dcc_and_tiling_disable(dc_plane_state, fb->modifier ? true : false);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_panic_flush);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_panic_flush);
 
 static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
@@ -1809,7 +1809,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 	amdgpu_state->shaper_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	amdgpu_state->blend_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_reset);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_drm_plane_reset);
 
 VISIBLE_IF_KUNIT struct drm_plane_state *
 amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
@@ -1851,7 +1851,7 @@ amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 
 	return &dm_plane_state->base;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_duplicate_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_drm_plane_duplicate_state);
 
 VISIBLE_IF_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 							   uint32_t format,
@@ -1922,7 +1922,7 @@ VISIBLE_IF_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *pla
 
 	return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_format_mod_supported);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_format_mod_supported);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 							      struct drm_plane_state *state)
@@ -1945,7 +1945,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *
 
 	drm_atomic_helper_plane_destroy_state(plane, state);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_destroy_state);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_drm_plane_destroy_state);
 
 #ifdef AMD_PRIVATE_COLOR
 static void
@@ -2299,5 +2299,5 @@ bool amdgpu_dm_plane_is_video_format(uint32_t format)
 
 	return false;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_is_video_format);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_plane_is_video_format);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 13901a1e6907..a2b2c9cee7ea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -83,7 +83,7 @@ VISIBLE_IF_KUNIT void build_pm_display_cfg(
 		pm_display_cfg->displays[i].pixel_clock = dc_cfg->pixel_clock;
 	}
 }
-EXPORT_IF_KUNIT(build_pm_display_cfg);
+EXPORT_SYMBOL_IF_KUNIT(build_pm_display_cfg);
 
 bool dm_pp_apply_display_requirements(
 		const struct dc_context *ctx,
@@ -102,7 +102,7 @@ bool dm_pp_apply_display_requirements(
 
 	return true;
 }
-EXPORT_IF_KUNIT(dm_pp_apply_display_requirements);
+EXPORT_SYMBOL_IF_KUNIT(dm_pp_apply_display_requirements);
 
 VISIBLE_IF_KUNIT void get_default_clock_levels(
 		enum dm_pp_clock_type clk_type,
@@ -135,7 +135,7 @@ VISIBLE_IF_KUNIT void get_default_clock_levels(
 		break;
 	}
 }
-EXPORT_IF_KUNIT(get_default_clock_levels);
+EXPORT_SYMBOL_IF_KUNIT(get_default_clock_levels);
 
 VISIBLE_IF_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
 		enum dm_pp_clock_type dm_pp_clk_type)
@@ -178,7 +178,7 @@ VISIBLE_IF_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
 
 	return amd_pp_clk_type;
 }
-EXPORT_IF_KUNIT(dc_to_pp_clock_type);
+EXPORT_SYMBOL_IF_KUNIT(dc_to_pp_clock_type);
 
 VISIBLE_IF_KUNIT void pp_to_dc_clock_levels(
 		const struct amd_pp_clocks *pp_clks,
@@ -205,7 +205,7 @@ VISIBLE_IF_KUNIT void pp_to_dc_clock_levels(
 		dc_clks->clocks_in_khz[i] = pp_clks->clock[i];
 	}
 }
-EXPORT_IF_KUNIT(pp_to_dc_clock_levels);
+EXPORT_SYMBOL_IF_KUNIT(pp_to_dc_clock_levels);
 
 VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_latency(
 		const struct pp_clock_levels_with_latency *pp_clks,
@@ -233,7 +233,7 @@ VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_latency(
 		clk_level_info->data[i].latency_in_us = pp_clks->data[i].latency_in_us;
 	}
 }
-EXPORT_IF_KUNIT(pp_to_dc_clock_levels_with_latency);
+EXPORT_SYMBOL_IF_KUNIT(pp_to_dc_clock_levels_with_latency);
 
 VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_voltage(
 		const struct pp_clock_levels_with_voltage *pp_clks,
@@ -262,7 +262,7 @@ VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_voltage(
 		clk_level_info->data[i].voltage_in_mv = pp_clks->data[i].voltage_in_mv;
 	}
 }
-EXPORT_IF_KUNIT(pp_to_dc_clock_levels_with_voltage);
+EXPORT_SYMBOL_IF_KUNIT(pp_to_dc_clock_levels_with_voltage);
 
 VISIBLE_IF_KUNIT void cap_clock_levels_to_validation(
 		struct dm_pp_clock_levels *dc_clks,
@@ -296,7 +296,7 @@ VISIBLE_IF_KUNIT void cap_clock_levels_to_validation(
 		}
 	}
 }
-EXPORT_IF_KUNIT(cap_clock_levels_to_validation);
+EXPORT_SYMBOL_IF_KUNIT(cap_clock_levels_to_validation);
 
 bool dm_pp_get_clock_levels_by_type(
 		const struct dc_context *ctx,
@@ -337,7 +337,7 @@ bool dm_pp_get_clock_levels_by_type(
 
 	return true;
 }
-EXPORT_IF_KUNIT(dm_pp_get_clock_levels_by_type);
+EXPORT_SYMBOL_IF_KUNIT(dm_pp_get_clock_levels_by_type);
 
 bool dm_pp_get_clock_levels_by_type_with_latency(
 	const struct dc_context *ctx,
@@ -358,7 +358,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
 
 	return true;
 }
-EXPORT_IF_KUNIT(dm_pp_get_clock_levels_by_type_with_latency);
+EXPORT_SYMBOL_IF_KUNIT(dm_pp_get_clock_levels_by_type_with_latency);
 
 bool dm_pp_get_clock_levels_by_type_with_voltage(
 	const struct dc_context *ctx,
@@ -379,7 +379,7 @@ bool dm_pp_get_clock_levels_by_type_with_voltage(
 
 	return true;
 }
-EXPORT_IF_KUNIT(dm_pp_get_clock_levels_by_type_with_voltage);
+EXPORT_SYMBOL_IF_KUNIT(dm_pp_get_clock_levels_by_type_with_voltage);
 
 bool dm_pp_notify_wm_clock_changes(
 	const struct dc_context *ctx,
@@ -399,7 +399,7 @@ bool dm_pp_notify_wm_clock_changes(
 
 	return false;
 }
-EXPORT_IF_KUNIT(dm_pp_notify_wm_clock_changes);
+EXPORT_SYMBOL_IF_KUNIT(dm_pp_notify_wm_clock_changes);
 
 bool dm_pp_apply_clock_for_voltage_request(
 	const struct dc_context *ctx,
@@ -421,7 +421,7 @@ bool dm_pp_apply_clock_for_voltage_request(
 
 	return true;
 }
-EXPORT_IF_KUNIT(dm_pp_apply_clock_for_voltage_request);
+EXPORT_SYMBOL_IF_KUNIT(dm_pp_apply_clock_for_voltage_request);
 
 VISIBLE_IF_KUNIT void build_wm_clock_ranges_soc15(
 		const struct pp_smu_wm_range_sets *ranges,
@@ -466,7 +466,7 @@ VISIBLE_IF_KUNIT void build_wm_clock_ranges_soc15(
 				ranges->writer_wm_sets[i].min_drain_clk_mhz * 1000;
 	}
 }
-EXPORT_IF_KUNIT(build_wm_clock_ranges_soc15);
+EXPORT_SYMBOL_IF_KUNIT(build_wm_clock_ranges_soc15);
 
 VISIBLE_IF_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
@@ -480,7 +480,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
 	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev,
 						    &wm_with_clock_ranges);
 }
-EXPORT_IF_KUNIT(pp_rv_set_wm_ranges);
+EXPORT_SYMBOL_IF_KUNIT(pp_rv_set_wm_ranges);
 
 VISIBLE_IF_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 {
@@ -489,7 +489,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 
 	amdgpu_dpm_notify_smu_enable_pwe(adev);
 }
-EXPORT_IF_KUNIT(pp_rv_set_pme_wa_enable);
+EXPORT_SYMBOL_IF_KUNIT(pp_rv_set_pme_wa_enable);
 
 VISIBLE_IF_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
 {
@@ -498,7 +498,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int coun
 
 	amdgpu_dpm_set_active_display_count(adev, count);
 }
-EXPORT_IF_KUNIT(pp_rv_set_active_display_count);
+EXPORT_SYMBOL_IF_KUNIT(pp_rv_set_active_display_count);
 
 VISIBLE_IF_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
 {
@@ -507,7 +507,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clo
 
 	amdgpu_dpm_set_min_deep_sleep_dcefclk(adev, clock);
 }
-EXPORT_IF_KUNIT(pp_rv_set_min_deep_sleep_dcfclk);
+EXPORT_SYMBOL_IF_KUNIT(pp_rv_set_min_deep_sleep_dcfclk);
 
 VISIBLE_IF_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
 {
@@ -516,7 +516,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int
 
 	amdgpu_dpm_set_hard_min_dcefclk_by_freq(adev, clock);
 }
-EXPORT_IF_KUNIT(pp_rv_set_hard_min_dcefclk_by_freq);
+EXPORT_SYMBOL_IF_KUNIT(pp_rv_set_hard_min_dcefclk_by_freq);
 
 VISIBLE_IF_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
 {
@@ -525,7 +525,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz
 
 	amdgpu_dpm_set_hard_min_fclk_by_freq(adev, mhz);
 }
-EXPORT_IF_KUNIT(pp_rv_set_hard_min_fclk_by_freq);
+EXPORT_SYMBOL_IF_KUNIT(pp_rv_set_hard_min_fclk_by_freq);
 
 VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
@@ -537,7 +537,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_set_wm_ranges);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_set_wm_ranges);
 
 VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 {
@@ -554,7 +554,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, i
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_set_display_count);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_set_display_count);
 
 VISIBLE_IF_KUNIT enum pp_smu_status
 pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
@@ -572,7 +572,7 @@ pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_set_min_deep_sleep_dcfclk);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_set_min_deep_sleep_dcfclk);
 
 VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 		struct pp_smu *pp, int mhz)
@@ -596,7 +596,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_set_hard_min_dcefclk_by_freq);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_set_hard_min_dcefclk_by_freq);
 
 VISIBLE_IF_KUNIT enum pp_smu_status
 pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
@@ -620,7 +620,7 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_set_hard_min_uclk_by_freq);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_set_hard_min_uclk_by_freq);
 
 VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
 	struct pp_smu *pp, bool pstate_handshake_supported)
@@ -634,7 +634,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_set_pstate_handshake_support);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_set_pstate_handshake_support);
 
 VISIBLE_IF_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 		enum amd_pp_clock_type *clock_type)
@@ -655,7 +655,7 @@ VISIBLE_IF_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 
 	return true;
 }
-EXPORT_IF_KUNIT(pp_smu_nv_clock_id_to_pp);
+EXPORT_SYMBOL_IF_KUNIT(pp_smu_nv_clock_id_to_pp);
 
 VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 		enum pp_smu_nv_clock_id clock_id, int mhz)
@@ -681,7 +681,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_set_voltage_by_freq);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_set_voltage_by_freq);
 
 VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 		struct pp_smu *pp, struct pp_smu_nv_clock_table *max_clocks)
@@ -699,7 +699,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_get_maximum_sustainable_clocks);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_get_maximum_sustainable_clocks);
 
 VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 		unsigned int *clock_values_in_khz, unsigned int *num_states)
@@ -718,7 +718,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_nv_get_uclk_dpm_states);
+EXPORT_SYMBOL_IF_KUNIT(pp_nv_get_uclk_dpm_states);
 
 VISIBLE_IF_KUNIT enum pp_smu_status pp_rn_get_dpm_clock_table(
 		struct pp_smu *pp, struct dpm_clocks *clock_table)
@@ -735,7 +735,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_rn_get_dpm_clock_table(
 
 	return PP_SMU_RESULT_OK;
 }
-EXPORT_IF_KUNIT(pp_rn_get_dpm_clock_table);
+EXPORT_SYMBOL_IF_KUNIT(pp_rn_get_dpm_clock_table);
 
 void dm_pp_get_funcs(
 		struct dc_context *ctx,
@@ -791,7 +791,7 @@ void dm_pp_get_funcs(
 		break;
 	}
 }
-EXPORT_IF_KUNIT(dm_pp_get_funcs);
+EXPORT_SYMBOL_IF_KUNIT(dm_pp_get_funcs);
 
 int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 {
@@ -843,4 +843,4 @@ int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_smu_write_watermarks_table);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_smu_write_watermarks_table);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 522fc81d09b5..af3c5066d267 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -60,7 +60,7 @@ bool link_supports_psrsu(struct dc_link *link)
 	/* Temporarily disable PSR-SU to avoid glitches */
 	return false;
 }
-EXPORT_IF_KUNIT(link_supports_psrsu);
+EXPORT_SYMBOL_IF_KUNIT(link_supports_psrsu);
 
 VISIBLE_IF_KUNIT
 void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
@@ -91,7 +91,7 @@ void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
 	caps->rate_control_caps = 0; /* TODO: read in rc caps from aux */
 	caps->psr_power_opt_flag = power_opts;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_psr_fill_caps);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_psr_fill_caps);
 
 /*
  * amdgpu_dm_set_psr_caps() - set link psr capabilities
@@ -135,7 +135,7 @@ bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *ac
 	amdgpu_dm_psr_fill_caps(link, &aconnector->psr_caps);
 	return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_psr_caps);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_psr_caps);
 
 /*
  * amdgpu_dm_psr_is_active_allowed() - check if psr is allowed on any stream
@@ -159,7 +159,7 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
 	}
 	return false;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_psr_is_active_allowed);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_psr_is_active_allowed);
 
 /*
  * amdgpu_dm_psr_set_event() - set or clear PSR event for stream
@@ -192,7 +192,7 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm, struct dc_stream
 	return mod_power_set_psr_event(dm->power_module, stream,
 				       set_event, event, wait_for_disable);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_psr_set_event);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_psr_set_event);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 /**
@@ -204,7 +204,7 @@ unsigned int amdgpu_dm_psr_get_dc_feature_mask(void)
 {
 	return amdgpu_dc_feature_mask;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_psr_get_dc_feature_mask);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_psr_get_dc_feature_mask);
 
 /**
  * amdgpu_dm_psr_set_dc_feature_mask() - Set DC feature mask for KUnit tests.
@@ -214,7 +214,7 @@ void amdgpu_dm_psr_set_dc_feature_mask(unsigned int feature_mask)
 {
 	amdgpu_dc_feature_mask = feature_mask;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_psr_set_dc_feature_mask);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_psr_set_dc_feature_mask);
 
 /**
  * amdgpu_dm_psr_get_dc_debug_mask() - Get DC debug mask for KUnit tests.
@@ -225,7 +225,7 @@ unsigned int amdgpu_dm_psr_get_dc_debug_mask(void)
 {
 	return amdgpu_dc_debug_mask;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_psr_get_dc_debug_mask);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_psr_get_dc_debug_mask);
 
 /**
  * amdgpu_dm_psr_set_dc_debug_mask() - Set DC debug mask for KUnit tests.
@@ -235,5 +235,5 @@ void amdgpu_dm_psr_set_dc_debug_mask(unsigned int debug_mask)
 {
 	amdgpu_dc_debug_mask = debug_mask;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_psr_set_dc_debug_mask);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_psr_set_dc_debug_mask);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
index 259966703cef..dad996e1a31c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
@@ -177,7 +177,7 @@ void retrieve_dmi_info(struct amdgpu_display_manager *dm)
 		drm_info(dev, "support_edp0_on_dp1 attached\n");
 	}
 }
-EXPORT_IF_KUNIT(retrieve_dmi_info);
+EXPORT_SYMBOL_IF_KUNIT(retrieve_dmi_info);
 
 struct amdgpu_stutter_quirk {
 	u16 chip_vendor;
@@ -209,4 +209,4 @@ bool dm_should_disable_stutter(struct pci_dev *pdev)
 	}
 	return false;
 }
-EXPORT_IF_KUNIT(dm_should_disable_stutter);
+EXPORT_SYMBOL_IF_KUNIT(dm_should_disable_stutter);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index ee2e4754b089..975261f7297b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -33,7 +33,6 @@
 #include "dc/inc/link_service.h"
 #include "dm_helpers.h"
 
-
 /*
  * amdgpu_dm_link_supports_replay() - check if the link supports replay
  * @link: link
@@ -70,7 +69,7 @@ bool amdgpu_dm_link_supports_replay(struct dc_link *link, struct amdgpu_dm_conne
 
 	return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_link_supports_replay);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_link_supports_replay);
 
 /*
  * amdgpu_dm_set_replay_caps() - setup Replay capabilities
@@ -128,7 +127,7 @@ bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector
 
 	return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_set_replay_caps);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_set_replay_caps);
 
 /*
  * amdgpu_dm_link_setup_replay() - config replay settings
@@ -167,7 +166,7 @@ bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
 			static_coasting_vtotal);
 	return true;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_link_setup_replay);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_link_setup_replay);
 
 /*
  * amdgpu_dm_replay_set_event() - set or clear replay event for a stream
@@ -207,4 +206,4 @@ bool amdgpu_dm_replay_set_event(struct amdgpu_display_manager *dm,
 	return mod_power_set_replay_event(dm->power_module, stream,
 					 set_event, event, wait_for_disable);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_replay_set_event);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_replay_set_event);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 6dbc8d1b4ecd..e284b1d17dba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -45,7 +45,7 @@
 {
 	return current_time_stamp - last_time_stamp;
 }
-EXPORT_IF_KUNIT(dm_get_elapse_time_in_ns);
+EXPORT_SYMBOL_IF_KUNIT(dm_get_elapse_time_in_ns);
 
 void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc_context *ctx)
 {
@@ -55,17 +55,17 @@ void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc
 				    &ctx->perf_trace->last_entry_write,
 				    func_name, line);
 }
-EXPORT_IF_KUNIT(dm_perf_trace_timestamp);
+EXPORT_SYMBOL_IF_KUNIT(dm_perf_trace_timestamp);
 
 void dm_trace_smu_enter(uint32_t msg_id, uint32_t param_in, unsigned int delay, struct dc_context *ctx)
 {
 }
-EXPORT_IF_KUNIT(dm_trace_smu_enter);
+EXPORT_SYMBOL_IF_KUNIT(dm_trace_smu_enter);
 
 void dm_trace_smu_exit(bool success, uint32_t response, struct dc_context *ctx)
 {
 }
-EXPORT_IF_KUNIT(dm_trace_smu_exit);
+EXPORT_SYMBOL_IF_KUNIT(dm_trace_smu_exit);
 
 /**** power component interfaces ****/
 
@@ -95,7 +95,7 @@ bool dm_query_extended_brightness_caps(struct dc_context *ctx,
 			sizeof(struct dm_bl_data_point) * pCaps->num_data_points);
 	return true;
 }
-EXPORT_IF_KUNIT(dm_query_extended_brightness_caps);
+EXPORT_SYMBOL_IF_KUNIT(dm_query_extended_brightness_caps);
 
 void*
 dm_allocate_gpu_mem(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 76eb3b0a0721..cbaa9ad57572 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -75,7 +75,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encod
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_wb_encoder_atomic_check);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_wb_encoder_atomic_check);
 
 
 VISIBLE_IF_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
@@ -83,7 +83,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *conn
 	/* Maximum resolution supported by DWB */
 	return drm_add_modes_noedid(connector, 3840, 2160);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_get_modes);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_wb_connector_get_modes);
 
 VISIBLE_IF_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
 			       struct drm_writeback_job *job)
@@ -148,7 +148,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb
 	amdgpu_bo_unreserve(rbo);
 	return r;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_wb_prepare_job);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_wb_prepare_job);
 
 VISIBLE_IF_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
 				struct drm_writeback_job *job)
@@ -170,7 +170,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *c
 	amdgpu_bo_unreserve(rbo);
 	amdgpu_bo_unref(&rbo);
 }
-EXPORT_IF_KUNIT(amdgpu_dm_wb_cleanup_job);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_wb_cleanup_job);
 
 static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs = {
 	.atomic_check = amdgpu_dm_wb_encoder_atomic_check,
@@ -220,4 +220,4 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 
 	return 0;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_init);
+EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_wb_connector_init);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
index 040a7a9c0335..61ad1c3cc452 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
@@ -1255,5 +1255,6 @@ static struct kunit_suite dm_audio_test_suite = {
 kunit_test_suite(dm_audio_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_audio");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 7ca17f803f9d..dee8e744c16f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1991,5 +1991,6 @@ static struct kunit_suite dm_backlight_test_suite = {
 kunit_test_suite(dm_backlight_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_backlight");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 8c2f7ab5f8d3..74d7496b9128 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -3036,5 +3036,6 @@ static struct kunit_suite dm_color_test_suite = {
 kunit_test_suite(dm_color_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_color");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 2e557ff66818..af1f5bfa1203 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -345,5 +345,6 @@ static struct kunit_suite dm_colorop_test_suite = {
 kunit_test_suite(dm_colorop_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_colorop");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index a54fd9529dc9..6811bbd32834 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -5689,3 +5689,4 @@ kunit_test_suite(amdgpu_dm_connector_test_suite);
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_connector");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index 29a513dab9cd..57b3f696b6d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -967,5 +967,6 @@ static struct kunit_suite dm_crc_test_suite = {
 kunit_test_suite(dm_crc_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_crc");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 4dacddd23878..eb9d5b9c835d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1937,3 +1937,4 @@ kunit_test_suite(amdgpu_dm_crtc_test_suite);
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_crtc");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index 3da76794ece9..f33f528159f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -266,3 +266,4 @@ kunit_test_suite(amdgpu_dm_cursor_test_suite);
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_cursor");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index ead43eeb38c7..f5b1db23618b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -1417,3 +1417,4 @@ kunit_test_suite(amdgpu_dm_dmub_test_suite);
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_dmub");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 0ae636dcbbe4..967a8001c653 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -451,3 +451,4 @@ kunit_test_suite(amdgpu_dm_freesync_test_suite);
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_freesync");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index cfdcc44581b1..6f1a7c0c6024 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -2617,5 +2617,6 @@ static struct kunit_suite dm_hdcp_test_suite = {
 kunit_test_suite(dm_hdcp_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_hdcp");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 058e1ad15dfe..df4e2741a263 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -3905,3 +3905,4 @@ kunit_test_suite(amdgpu_dm_helpers_test_suite);
 
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_helpers");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 28c36217f6a2..fab625427fd0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -4091,3 +4091,4 @@ kunit_test_suite(amdgpu_dm_irq_test_suite);
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_irq");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index 6394b967ac3a..176518ea2f65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -1274,5 +1274,6 @@ static struct kunit_suite dm_ism_test_suite = {
 kunit_test_suite(dm_ism_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_ism");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index aad122c7229f..6c1472fcaf16 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -192,4 +192,5 @@ struct drm_device *dm_kunit_alloc_drm_with_connector_list(struct kunit *test)
 EXPORT_SYMBOL(dm_kunit_alloc_drm_with_connector_list);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit test helpers for amdgpu_dm tests");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index caedad4197bd..3f556d1f62fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -1426,4 +1426,5 @@ static struct kunit_suite dm_mst_types_test_suite = {
 kunit_test_suite(dm_mst_types_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_mst_types");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index ba97092c7bb8..8fb8c6525ee1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3135,3 +3135,4 @@ kunit_test_suite(amdgpu_dm_plane_test_suite);
 
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_plane");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
index fbd07af60230..2a67ba9d79a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
@@ -2471,4 +2471,5 @@ static struct kunit_suite dm_pp_smu_test_suite = {
 kunit_test_suite(dm_pp_smu_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_pp_smu");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
index 0a484ea7c0e8..6d1cc3a09648 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
@@ -754,5 +754,6 @@ static struct kunit_suite dm_psr_test_suite = {
 kunit_test_suite(dm_psr_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_psr");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
index 150c53a68bed..a44b49f6cc1c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
@@ -166,3 +166,4 @@ kunit_test_suite(amdgpu_dm_quirks_test_suite);
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_quirks");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
index 6f633b1bbaca..766018e65d53 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
@@ -622,5 +622,6 @@ static struct kunit_suite dm_replay_test_suite = {
 kunit_test_suite(dm_replay_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_replay");
 MODULE_AUTHOR("AMD");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
index e48bac7fb024..7344adadcd08 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
@@ -311,3 +311,4 @@ kunit_test_suite(amdgpu_dm_services_test_suite);
 
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_services");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 3c10eec9b1e0..7414c2bfd5dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1230,3 +1230,4 @@ kunit_test_suite(amdgpu_dm_test_suite);
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm");
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index 3454cf371414..8fbd71804789 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -434,4 +434,5 @@ static struct kunit_suite dm_wb_test_suite = {
 kunit_test_suite(dm_wb_test_suite);
 
 MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_wb");
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
index 38ef295e43d6..cb53afc18cb7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
@@ -61,7 +61,7 @@ void dc_sink_retain(struct dc_sink *sink)
 {
 	kref_get(&sink->refcount);
 }
-EXPORT_IF_KUNIT(dc_sink_retain);
+EXPORT_SYMBOL_IF_KUNIT(dc_sink_retain);
 
 static void dc_sink_free(struct kref *kref)
 {
@@ -74,7 +74,7 @@ void dc_sink_release(struct dc_sink *sink)
 {
 	kref_put(&sink->refcount, dc_sink_free);
 }
-EXPORT_IF_KUNIT(dc_sink_release);
+EXPORT_SYMBOL_IF_KUNIT(dc_sink_release);
 
 struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params)
 {
@@ -96,7 +96,7 @@ struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params)
 alloc_fail:
 	return NULL;
 }
-EXPORT_IF_KUNIT(dc_sink_create);
+EXPORT_SYMBOL_IF_KUNIT(dc_sink_create);
 
 /*******************************************************************************
  * Protected functions - visible only inside of DC (not visible in DM)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9f3068e899e1..9b2893be09b1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -205,7 +205,7 @@ void dc_stream_release(struct dc_stream_state *stream)
 		kref_put(&stream->refcount, dc_stream_free);
 	}
 }
-EXPORT_IF_KUNIT(dc_stream_release);
+EXPORT_SYMBOL_IF_KUNIT(dc_stream_release);
 
 struct dc_stream_state *dc_create_stream_for_sink(
 		struct dc_sink *sink)
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index ac1522fc2e70..6d7cdab1006f 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -196,11 +196,9 @@ void dm_helpers_mccs_vcp_set(
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 #define INLINE_IFN_KUNIT inline
-#define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
 
 #else
 #define INLINE_IFN_KUNIT
-#define EXPORT_IF_KUNIT(symbol)
 #endif
 
 bool dm_helpers_submit_i2c_over_aux(

-- 
2.55.0

