Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65324C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F08A10E69B;
	Mon, 10 Aug 2026 06:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oPRN0eUU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3BF10F50C
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:37:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1019E60051;
 Fri,  7 Aug 2026 14:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883AF1F000E9;
 Fri,  7 Aug 2026 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786113464;
 bh=OjyMGNee5Ltb4a5v98/mYhpXA9VlJvaCkqWUzs9ZBEI=;
 h=Date:From:To:Cc:Subject;
 b=oPRN0eUUFUk4YKQkUytdXoixpdR9l9ZTD+/DubYJds+2B/nVpqHf8vhhdYk/m6WXv
 fEEnQrcABD7JgbvUvXG7eVMa9M2HfW4FtDwk2kXexErcstJz+4k4FNWtuU4kPcsm7e
 1kuJ8MoWPtcCqKZzoJMiwUy1dwTAz7iUqDvtIbgvUDzloHpMojw/I6QPXznCwzk/am
 6+N7BT0gVErqjI+oUQelXOTIrub50v5AiiMpL08VrzaWAy391G+7NLIWvU7CMxU4ux
 1mAi80j3iDf17OHeIfFFJZgBmI/9vPgztRjiDquAhj/iwtyhm9BMiHgNX2JdA0XYFO
 ayrp5zMseNiUQ==
Date: Fri, 7 Aug 2026 15:37:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alessandro Rinaldi <ale@alerinaldi.it>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>,
 George Zhang <george.zhang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 "Travis K. Bangs" <tbangs89@gmail.com>, WenTao Liang <vulab@iscas.ac.cn>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <anXtsSs6hjsF6P42@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8x9LDaT+QhA6DkDX"
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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


--8x9LDaT+QhA6DkDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

between commits:

  ff209cd04845d ("drm/amd: Disable DP audio spread spectrum for Cyan Skillf=
ish")
  8419331e64d92 ("drm/amd/display: Exit idle optimizations before programmi=
ng")
  fbbaca9e20873 ("drm/amd/display: Fix missing DCE check in dm_gpureset_tog=
gle_interrupts()")
  f39283eab44fb ("Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x=
+ DGPUs"")
  48ab86360af11 ("drm/amd/display: check GRPH_FLIP status before sending ev=
ent")
  8382cd234981a ("drm/amd/display: consolidate DCN vblank/flip handling ont=
o vupdate_no_lock")
  9fa26b9eed619 ("drm/amd/display: set new_stream to NULL after release")
  bad177fa75e60 ("drm/amd/display: Force PWM backlight on Lenovo Legion 5 1=
5ARH05")
  cea54c52d82dd ("drm/amd/display: Set native cursor mode for disabled CRTC=
s")
  f1b5d8f9cc54a ("drm/amd/display: Fix backlight max_brightness to match ex=
ported range")

=66rom the origin tree and commits:

  05984e29520a2 ("drm/amd/display: Exit idle optimizations before programmi=
ng")
  1a16dfe5359f1 ("drm/amd/display: Don't use tiling flags anymore")
  87a6dab12fc06 ("drm/amd/display: add cursor module")
  09dd9fbc0b2dc ("drm/amd/display: add FreeSync/VRR module")
  66517ca0cd8bb ("drm/amd/display: move GPU mem helpers to services")
  0b9bd593f0a2c ("drm/amd/display: move watermarks table to pp_smu")
  e278e0bf3ed30 ("drm/amd/display: move stutter quirk to quirks file")
  a648ed2bfafab ("drm/amd/display: move scaling helper to connector")
  c1199393ec559 ("drm/amd/display: Refactor surface_update_flags to flat st=
ruct with helpers")
  0e967e086e751 ("drm/amd/display: Extract connector and encoder code to am=
dgpu_dm_connector")
  0618dec494157 ("drm/amd/display: Move HPD and IRQ handler code to amdgpu_=
dm_irq")
  4734e045f49d9 ("drm/amd/display: Extract DMUB code to amdgpu_dm_dmub")
  ee55bf7d6a63f ("drm/amd/display: Extract audio code to amdgpu_dm_audio")
  f5165625b8b27 ("drm/amd/display: Extract backlight code to amdgpu_dm_back=
light")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 941c1a3128249,e421c3c81778d..0000000000000
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@@ -66,6 -66,13 +66,13 @@@
  #endif
  #include "amdgpu_dm_psr.h"
  #include "amdgpu_dm_replay.h"
+ #include "amdgpu_dm_backlight.h"
+ #include "amdgpu_dm_audio.h"
+ #include "amdgpu_dm_dmub.h"
+ #include "amdgpu_dm_connector.h"
+ #include "amdgpu_dm_pp_smu.h"
+ #include "amdgpu_dm_freesync.h"
+ #include "amdgpu_dm_cursor.h"
 =20
  #include "ivsrcid/ivsrcid_vislands30.h"
 =20
@@@ -94,7 -101,6 +101,6 @@@
  #include <drm/drm_mode.h>
  #include <drm/drm_utils.h>
  #include <drm/drm_vblank.h>
- #include <drm/drm_audio_component.h>
  #include <drm/drm_colorop.h>
  #include <drm/drm_gem_atomic_helper.h>
 =20
@@@ -107,60 -113,9 +113,9 @@@
  #include "modules/inc/mod_power.h"
  #include "modules/power/power_helpers.h"
 =20
- static_assert(AMDGPU_DMUB_NOTIFICATION_MAX =3D=3D DMUB_NOTIFICATION_MAX, =
"AMDGPU_DMUB_NOTIFICATION_MAX mismatch");
-=20
- #define FIRMWARE_RENOIR_DMUB "amdgpu/renoir_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_RENOIR_DMUB);
- #define FIRMWARE_SIENNA_CICHLID_DMUB "amdgpu/sienna_cichlid_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
- #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
- #define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
- #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
- #define FIRMWARE_DIMGREY_CAVEFISH_DMUB "amdgpu/dimgrey_cavefish_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH_DMUB);
- #define FIRMWARE_BEIGE_GOBY_DMUB "amdgpu/beige_goby_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY_DMUB);
- #define FIRMWARE_YELLOW_CARP_DMUB "amdgpu/yellow_carp_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP_DMUB);
- #define FIRMWARE_DCN_314_DMUB "amdgpu/dcn_3_1_4_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_314_DMUB);
- #define FIRMWARE_DCN_315_DMUB "amdgpu/dcn_3_1_5_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_315_DMUB);
- #define FIRMWARE_DCN316_DMUB "amdgpu/dcn_3_1_6_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN316_DMUB);
-=20
- #define FIRMWARE_DCN_V3_2_0_DMCUB "amdgpu/dcn_3_2_0_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_V3_2_0_DMCUB);
- #define FIRMWARE_DCN_V3_2_1_DMCUB "amdgpu/dcn_3_2_1_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_V3_2_1_DMCUB);
-=20
- #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
  MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
-=20
- #define FIRMWARE_NAVI12_DMCU            "amdgpu/navi12_dmcu.bin"
  MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 =20
- #define FIRMWARE_DCN_35_DMUB "amdgpu/dcn_3_5_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_35_DMUB);
-=20
- #define FIRMWARE_DCN_351_DMUB "amdgpu/dcn_3_5_1_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
-=20
- #define FIRMWARE_DCN_36_DMUB "amdgpu/dcn_3_6_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
-=20
- #define FIRMWARE_DCN_401_DMUB "amdgpu/dcn_4_0_1_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
-=20
- #define FIRMWARE_DCN_42_DMUB "amdgpu/dcn_4_2_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
-=20
- #define FIRMWARE_DCN_42B_DMUB "amdgpu/dcn_4_2_1_dmcub.bin"
- MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
-=20
  /**
   * DOC: overview
   *
@@@ -174,46 -129,6 +129,6 @@@
  /* basic init/fini API */
  static int amdgpu_dm_init(struct amdgpu_device *adev);
  static void amdgpu_dm_fini(struct amdgpu_device *adev);
- static bool is_freesync_video_mode(const struct drm_display_mode *mode, s=
truct amdgpu_dm_connector *aconnector);
- static void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc=
_state);
- static struct amdgpu_i2c_adapter *
- create_i2c(struct ddc_service *ddc_service, bool oem);
-=20
- static enum drm_mode_subconnector get_subconnector_type(struct dc_link *l=
ink)
- {
- 	switch (link->dpcd_caps.dongle_type) {
- 	case DISPLAY_DONGLE_NONE:
- 		return DRM_MODE_SUBCONNECTOR_Native;
- 	case DISPLAY_DONGLE_DP_VGA_CONVERTER:
- 		return DRM_MODE_SUBCONNECTOR_VGA;
- 	case DISPLAY_DONGLE_DP_DVI_CONVERTER:
- 	case DISPLAY_DONGLE_DP_DVI_DONGLE:
- 		return DRM_MODE_SUBCONNECTOR_DVID;
- 	case DISPLAY_DONGLE_DP_HDMI_CONVERTER:
- 	case DISPLAY_DONGLE_DP_HDMI_DONGLE:
- 		return DRM_MODE_SUBCONNECTOR_HDMIA;
- 	case DISPLAY_DONGLE_DP_HDMI_MISMATCHED_DONGLE:
- 	default:
- 		return DRM_MODE_SUBCONNECTOR_Unknown;
- 	}
- }
-=20
- static void update_subconnector_property(struct amdgpu_dm_connector *acon=
nector)
- {
- 	struct dc_link *link =3D aconnector->dc_link;
- 	struct drm_connector *connector =3D &aconnector->base;
- 	enum drm_mode_subconnector subconnector =3D DRM_MODE_SUBCONNECTOR_Unknow=
n;
-=20
- 	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_DisplayPort)
- 		return;
-=20
- 	if (aconnector->dc_sink)
- 		subconnector =3D get_subconnector_type(link);
-=20
- 	drm_object_property_set_value(&connector->base,
- 			connector->dev->mode_config.dp_subconnector_property,
- 			subconnector);
- }
 =20
  /*
   * initializes drm_device display related structures, based on the inform=
ation
@@@ -226,32 -141,19 +141,19 @@@ static int amdgpu_dm_initialize_drm_dev
  /* removes and deallocates the drm structures, created by the above funct=
ion */
  static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *d=
m);
 =20
- static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
- 				    struct amdgpu_dm_connector *amdgpu_dm_connector,
- 				    u32 link_index,
- 				    struct amdgpu_encoder *amdgpu_encoder);
- static int amdgpu_dm_encoder_init(struct drm_device *dev,
- 				  struct amdgpu_encoder *aencoder,
- 				  uint32_t link_index);
-=20
- static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
-=20
  static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
  static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state);
+ STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_stat=
e *context);
 =20
  static int amdgpu_dm_atomic_check(struct drm_device *dev,
  				  struct drm_atomic_commit *state);
 =20
- static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
- static void handle_hpd_rx_irq(void *param);
+ static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
+ {
+ 	if (dc->ctx->dmub_srv && !dc->ctx->dmub_srv->idle_exit_counter)
+ 		dc_exit_ips_for_hw_access(dc);
+ }
 =20
- static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *=
dm,
- 					 int bl_idx,
- 					 u32 user_brightness);
-=20
- static bool
- is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
- 				 struct drm_crtc_state *new_crtc_state);
  /*
   * dm_vblank_get_counter
   *
@@@ -265,7 -167,7 +167,7 @@@
   * @return
   * Counter for vertical blanks
   */
- static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
+ STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, in=
t crtc)
  {
  	struct amdgpu_crtc *acrtc =3D NULL;
 =20
@@@ -282,9 -184,10 +184,10 @@@
 =20
  	return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
  }
+ EXPORT_IF_KUNIT(dm_vblank_get_counter);
 =20
- static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
- 				  u32 *vbl, u32 *position)
+ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, i=
nt crtc,
+ 					    u32 *vbl, u32 *position)
  {
  	u32 v_blank_start =3D 0, v_blank_end =3D 0, h_position =3D 0, v_position=
 =3D 0;
  	struct amdgpu_crtc *acrtc =3D NULL;
@@@ -319,70 -222,35 +222,35 @@@
 =20
  	return 0;
  }
+ EXPORT_IF_KUNIT(dm_crtc_get_scanoutpos);
 =20
- static bool dm_is_idle(struct amdgpu_ip_block *ip_block)
+ STATIC_IFN_KUNIT bool dm_is_idle(struct amdgpu_ip_block *ip_block)
  {
  	/* XXX todo */
  	return true;
  }
+ EXPORT_IF_KUNIT(dm_is_idle);
 =20
- static int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
+ STATIC_IFN_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
  {
  	/* XXX todo */
  	return 0;
  }
+ EXPORT_IF_KUNIT(dm_wait_for_idle);
 =20
- static bool dm_check_soft_reset(struct amdgpu_ip_block *ip_block)
- {
- 	return false;
- }
-=20
- static int dm_soft_reset(struct amdgpu_ip_block *ip_block)
+ STATIC_IFN_KUNIT int dm_soft_reset(struct amdgpu_ip_block *ip_block)
  {
  	/* XXX todo */
  	return 0;
  }
-=20
- static struct amdgpu_crtc *
- get_crtc_by_otg_inst(struct amdgpu_device *adev,
- 		     int otg_inst)
- {
- 	struct drm_device *dev =3D adev_to_drm(adev);
- 	struct drm_crtc *crtc;
- 	struct amdgpu_crtc *amdgpu_crtc;
-=20
- 	if (WARN_ON(otg_inst =3D=3D -1))
- 		return adev->mode_info.crtcs[0];
-=20
- 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
- 		amdgpu_crtc =3D to_amdgpu_crtc(crtc);
-=20
- 		if (amdgpu_crtc->otg_inst =3D=3D otg_inst)
- 			return amdgpu_crtc;
- 	}
-=20
- 	return NULL;
- }
-=20
- static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_s=
tate,
- 					      struct dm_crtc_state *new_state)
- {
- 	if (new_state->stream->adjust.timing_adjust_pending)
- 		return true;
- 	if (new_state->freesync_config.state =3D=3D  VRR_STATE_ACTIVE_FIXED)
- 		return true;
- 	else if (amdgpu_dm_crtc_vrr_active(old_state) !=3D amdgpu_dm_crtc_vrr_ac=
tive(new_state))
- 		return true;
- 	else
- 		return false;
- }
+ EXPORT_IF_KUNIT(dm_soft_reset);
 =20
  /*
   * DC will program planes with their z-order determined by their ordering
   * in the dc_surface_updates array. This comparator is used to sort them
   * by descending zpos.
   */
- static int dm_plane_layer_index_cmp(const void *a, const void *b)
+ STATIC_IFN_KUNIT int dm_plane_layer_index_cmp(const void *a, const void *=
b)
  {
  	const struct dc_surface_update *sa =3D (struct dc_surface_update *)a;
  	const struct dc_surface_update *sb =3D (struct dc_surface_update *)b;
@@@ -390,6 -258,7 +258,7 @@@
  	/* Sort by descending dc_plane layer_index (i.e. normalized_zpos) */
  	return sb->surface->layer_index - sa->surface->layer_index;
  }
+ EXPORT_IF_KUNIT(dm_plane_layer_index_cmp);
 =20
  /**
   * update_planes_and_stream_adapter() - Send planes to be updated in DC
@@@ -430,1098 -299,24 +299,24 @@@ static inline bool update_planes_and_st
  					   stream_update);
  }
 =20
- /**
-  * dm_pflip_high_irq() - Handle pageflip interrupt
-  * @interrupt_params: ignored
-  *
-  * Handles the pageflip interrupt by notifying all interested parties
-  * that the pageflip has been completed.
-  */
- static void dm_pflip_high_irq(void *interrupt_params)
- {
- 	struct amdgpu_crtc *amdgpu_crtc;
- 	struct common_irq_params *irq_params =3D interrupt_params;
- 	struct amdgpu_device *adev =3D irq_params->adev;
- 	struct drm_device *dev =3D adev_to_drm(adev);
- 	unsigned long flags;
- 	struct drm_pending_vblank_event *e;
- 	u32 vpos, hpos, v_blank_start, v_blank_end;
- 	bool vrr_active;
-=20
- 	amdgpu_crtc =3D get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYP=
E_PFLIP);
-=20
- 	/* IRQ could occur when in initial stage */
- 	/* TODO work and BO cleanup */
- 	if (amdgpu_crtc =3D=3D NULL) {
- 		drm_dbg_state(dev, "CRTC is null, returning.\n");
- 		return;
- 	}
-=20
- 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-=20
- 	if (amdgpu_crtc->pflip_status !=3D AMDGPU_FLIP_SUBMITTED) {
- 		drm_dbg_state(dev,
- 			      "amdgpu_crtc->pflip_status =3D %d !=3D AMDGPU_FLIP_SUBMITTED(%d)=
 on crtc:%d[%p]\n",
- 			      amdgpu_crtc->pflip_status, AMDGPU_FLIP_SUBMITTED,
- 			      amdgpu_crtc->crtc_id, amdgpu_crtc);
- 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
- 		return;
- 	}
-=20
- 	/* page flip completed. */
- 	e =3D amdgpu_crtc->event;
- 	amdgpu_crtc->event =3D NULL;
-=20
- 	WARN_ON(!e);
-=20
- 	vrr_active =3D amdgpu_dm_crtc_vrr_active_irq(amdgpu_crtc);
-=20
- 	/* Fixed refresh rate, or VRR scanout position outside front-porch? */
- 	if (!vrr_active ||
- 	    !dc_stream_get_scanoutpos(amdgpu_crtc->dm_irq_params.stream, &v_blan=
k_start,
- 				      &v_blank_end, &hpos, &vpos) ||
- 	    (vpos < v_blank_start)) {
- 		/* Update to correct count and vblank timestamp if racing with
- 		 * vblank irq. This also updates to the correct vblank timestamp
- 		 * even in VRR mode, as scanout is past the front-porch atm.
- 		 */
- 		drm_crtc_accurate_vblank_count(&amdgpu_crtc->base);
-=20
- 		/* Wake up userspace by sending the pageflip event with proper
- 		 * count and timestamp of vblank of flip completion.
- 		 */
- 		if (e) {
- 			drm_crtc_send_vblank_event(&amdgpu_crtc->base, e);
-=20
- 			/* Event sent, so done with vblank for this flip */
- 			drm_crtc_vblank_put(&amdgpu_crtc->base);
- 		}
- 	} else if (e) {
- 		/* VRR active and inside front-porch: vblank count and
- 		 * timestamp for pageflip event will only be up to date after
- 		 * drm_crtc_handle_vblank() has been executed from late vblank
- 		 * irq handler after start of back-porch (vline 0). We queue the
- 		 * pageflip event for send-out by drm_crtc_handle_vblank() with
- 		 * updated timestamp and count, once it runs after us.
- 		 *
- 		 * We need to open-code this instead of using the helper
- 		 * drm_crtc_arm_vblank_event(), as that helper would
- 		 * call drm_crtc_accurate_vblank_count(), which we must
- 		 * not call in VRR mode while we are in front-porch!
- 		 */
-=20
- 		/* sequence will be replaced by real count during send-out. */
- 		e->sequence =3D drm_crtc_vblank_count(&amdgpu_crtc->base);
- 		e->pipe =3D amdgpu_crtc->crtc_id;
-=20
- 		list_add_tail(&e->base.link, &adev_to_drm(adev)->vblank_event_list);
- 		e =3D NULL;
- 	}
-=20
- 	/* Keep track of vblank of this flip for flip throttling. We use the
- 	 * cooked hw counter, as that one incremented at start of this vblank
- 	 * of pageflip completion, so last_flip_vblank is the forbidden count
- 	 * for queueing new pageflips if vsync + VRR is enabled.
- 	 */
- 	amdgpu_crtc->dm_irq_params.last_flip_vblank =3D
- 		amdgpu_get_vblank_counter_kms(&amdgpu_crtc->base);
-=20
- 	amdgpu_crtc->pflip_status =3D AMDGPU_FLIP_NONE;
- 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-=20
- 	drm_dbg_state(dev,
- 		      "crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
- 		      amdgpu_crtc->crtc_id, amdgpu_crtc, vrr_active, (int)!e);
- }
-=20
- static void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
- {
- 	struct vupdate_offload_work *work =3D container_of(offload_work, struct =
vupdate_offload_work, work);
- 	struct amdgpu_device *adev =3D work->adev;
- 	struct dc_stream_state *stream =3D work->stream;
- 	struct dc_crtc_timing_adjust *adjust =3D work->adjust;
-=20
- 	mutex_lock(&adev->dm.dc_lock);
- 	dc_stream_adjust_vmin_vmax(adev->dm.dc, stream, adjust);
- 	mutex_unlock(&adev->dm.dc_lock);
-=20
- 	dc_stream_release(stream);
- 	kfree(work->adjust);
- 	kfree(work);
- }
-=20
- static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
- 	struct dc_stream_state *stream,
- 	struct dc_crtc_timing_adjust *adjust)
- {
- 	struct vupdate_offload_work *offload_work =3D kzalloc_obj(*offload_work,
- 								GFP_NOWAIT);
- 	if (!offload_work) {
- 		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_w=
ork\n");
- 		return;
- 	}
-=20
- 	struct dc_crtc_timing_adjust *adjust_copy =3D kzalloc_obj(*adjust_copy,
- 								GFP_NOWAIT);
- 	if (!adjust_copy) {
- 		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
- 		kfree(offload_work);
- 		return;
- 	}
-=20
- 	dc_stream_retain(stream);
- 	memcpy(adjust_copy, adjust, sizeof(*adjust_copy));
-=20
- 	INIT_WORK(&offload_work->work, dm_handle_vmin_vmax_update);
- 	offload_work->adev =3D adev;
- 	offload_work->stream =3D stream;
- 	offload_work->adjust =3D adjust_copy;
-=20
- 	queue_work(system_percpu_wq, &offload_work->work);
- }
-=20
- /**
-  * dm_crtc_high_irq_handler() - Common OTG vblank/flip event handling
-  * @adev: amdgpu device
-  * @acrtc: the CRTC to service
-  *
-  * Performs writeback completion, vblank event handling, CRC processing, =
VRR BTR
-  * updates and pageflip completion delivery.
-  *
-  * On DCN this is driven by VUPDATE_NO_LOCK (the register latch point) fr=
om
-  * dm_vupdate_high_irq(); on DCE it is driven by VLINE0 at the start of v=
blank
-  * from dm_crtc_high_irq().
-  */
- static void dm_crtc_high_irq_handler(struct amdgpu_device *adev,
- 				     struct amdgpu_crtc *acrtc)
- {
- 	struct drm_writeback_job *job;
- 	unsigned long flags;
- 	int vrr_active;
- 	bool is_dcn =3D amdgpu_ip_version(adev, DCE_HWIP, 0) !=3D 0;
-=20
- 	if (acrtc->wb_conn) {
- 		spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
-=20
- 		if (acrtc->wb_pending) {
- 			job =3D list_first_entry_or_null(&acrtc->wb_conn->job_queue,
- 						       struct drm_writeback_job,
- 						       list_entry);
- 			acrtc->wb_pending =3D false;
- 			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
-=20
- 			if (job) {
- 				unsigned int v_total, refresh_hz;
- 				struct dc_stream_state *stream =3D acrtc->dm_irq_params.stream;
-=20
- 				v_total =3D stream->adjust.v_total_max ?
- 					  stream->adjust.v_total_max : stream->timing.v_total;
- 				refresh_hz =3D div_u64((uint64_t) stream->timing.pix_clk_100hz *
- 					     100LL, (v_total * stream->timing.h_total));
- 				mdelay(1000 / refresh_hz);
-=20
- 				drm_writeback_signal_completion(acrtc->wb_conn, 0);
- 				dc_stream_fc_disable_writeback(adev->dm.dc,
- 							       acrtc->dm_irq_params.stream, 0);
- 			}
- 		} else
- 			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
- 	}
-=20
- 	vrr_active =3D amdgpu_dm_crtc_vrr_active_irq(acrtc);
-=20
- 	drm_dbg_vbl(adev_to_drm(adev),
- 		    "crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
- 		    vrr_active, acrtc->dm_irq_params.active_planes);
-=20
- 	/**
- 	 * Core vblank handling.
- 	 *
- 	 * On DCN this handler runs at VUPDATE_NO_LOCK, the register latch
- 	 * point, which is the correct place to timestamp both VRR and non-VRR
- 	 * vblanks.
- 	 *
- 	 * On DCE this handler runs at the start of front-porch, where only
- 	 * non-VRR timestamping is valid; VRR vblank is deferred to
- 	 * dm_vupdate_high_irq() after end of front-porch.
- 	 */
- 	if (is_dcn || !vrr_active)
- 		amdgpu_dm_crtc_handle_vblank(acrtc);
-=20
- 	/**
- 	 * Following stuff must happen at start of vblank, for crc
- 	 * computation and below-the-range btr support in vrr mode.
- 	 */
- 	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
-=20
- 	/* BTR updates need to happen before VUPDATE on Vega and above. */
- 	if (adev->family < AMDGPU_FAMILY_AI)
- 		return;
-=20
- 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-=20
- 	if (acrtc->dm_irq_params.stream &&
- 		acrtc->dm_irq_params.vrr_params.supported) {
- 		bool replay_en =3D acrtc->dm_irq_params.stream->link->replay_settings.r=
eplay_feature_enabled;
- 		bool psr_en =3D acrtc->dm_irq_params.stream->link->psr_settings.psr_fea=
ture_enabled;
- 		bool fs_active_var_en =3D acrtc->dm_irq_params.freesync_config.state =
=3D=3D VRR_STATE_ACTIVE_VARIABLE;
-=20
- 		mod_freesync_handle_v_update(adev->dm.freesync_module,
- 					     acrtc->dm_irq_params.stream,
- 					     &acrtc->dm_irq_params.vrr_params);
-=20
- 		/* update vmin_vmax only if freesync is enabled, or only if PSR and REP=
LAY are disabled */
- 		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
- 			schedule_dc_vmin_vmax(adev, acrtc->dm_irq_params.stream,
- 					&acrtc->dm_irq_params.vrr_params.adjust);
- 		}
- 	}
-=20
- 	/*
- 	 * Deliver pageflip completion events (DCN only).
- 	 *
- 	 * Since GRPH_PFLIP is not used, VUPDATE_NO_LOCK is the flip latch
- 	 * point. Deliver any pending pageflip completion event from here,
- 	 * once HW has consumed the new address (the OTG no longer reports a
- 	 * pending flip).
- 	 *
- 	 * Also handle the case here where there aren't any active planes and
- 	 * DCN HUBP may be clock-gated, so the flip-pending status may be
- 	 * undefined.
- 	 */
- 	if (is_dcn && acrtc->pflip_status =3D=3D AMDGPU_FLIP_SUBMITTED &&
- 	    acrtc->event) {
-=20
- 		if (!dc_get_flip_pending_on_otg(adev->dm.dc, acrtc->otg_inst)) {
- 			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
- 			acrtc->event =3D NULL;
- 			drm_crtc_vblank_put(&acrtc->base);
- 			acrtc->pflip_status =3D AMDGPU_FLIP_NONE;
- 		}
- 		/*
- 		 * If the flip is still pending, leave it armed and
- 		 * retry on the next vupdate.
- 		 */
- 	} else if (is_dcn && acrtc->pflip_status =3D=3D AMDGPU_FLIP_SUBMITTED &&
- 		   acrtc->dm_irq_params.active_planes =3D=3D 0) {
-=20
- 		if (acrtc->event) {
- 			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
- 			acrtc->event =3D NULL;
- 			drm_crtc_vblank_put(&acrtc->base);
- 		}
- 		acrtc->pflip_status =3D AMDGPU_FLIP_NONE;
- 	}
-=20
- 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
- }
-=20
- static void dm_vupdate_high_irq(void *interrupt_params)
- {
- 	struct common_irq_params *irq_params =3D interrupt_params;
- 	struct amdgpu_device *adev =3D irq_params->adev;
- 	struct amdgpu_crtc *acrtc;
- 	struct drm_device *drm_dev;
- 	struct drm_vblank_crtc *vblank;
- 	ktime_t frame_duration_ns, previous_timestamp;
- 	unsigned long flags;
- 	int vrr_active;
-=20
- 	acrtc =3D get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPD=
ATE);
- 	if (!acrtc)
- 		return;
-=20
- 	vrr_active =3D amdgpu_dm_crtc_vrr_active_irq(acrtc);
- 	drm_dev =3D acrtc->base.dev;
- 	vblank =3D drm_crtc_vblank_crtc(&acrtc->base);
- 	previous_timestamp =3D atomic64_read(&irq_params->previous_timestamp);
- 	frame_duration_ns =3D vblank->time - previous_timestamp;
-=20
- 	if (frame_duration_ns > 0) {
- 		trace_amdgpu_refresh_rate_track(acrtc->base.index,
- 					frame_duration_ns,
- 					ktime_divns(NSEC_PER_SEC, frame_duration_ns));
- 		atomic64_set(&irq_params->previous_timestamp, vblank->time);
- 	}
-=20
- 	drm_dbg_vbl(drm_dev,
- 		    "crtc:%d, vupdate-vrr:%d\n", acrtc->crtc_id,
- 		    vrr_active);
-=20
- 	/*
- 	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to deliver
- 	 * vblank and pageflip completion events; VSTARTUP and GRPH_PFLIP are
- 	 * not used. Run the full handler here.
- 	 */
- 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) !=3D 0) {
- 		dm_crtc_high_irq_handler(adev, acrtc);
- 		return;
- 	}
-=20
- 	/* DCE only below. */
-=20
- 	/* Core vblank handling is done here after end of front-porch in
- 	 * vrr mode, as vblank timestamping will give valid results
- 	 * while now done after front-porch. This will also deliver
- 	 * page-flip completion events that have been queued to us
- 	 * if a pageflip happened inside front-porch.
- 	 */
- 	if (vrr_active && acrtc->dm_irq_params.stream) {
- 		bool replay_en =3D acrtc->dm_irq_params.stream->link->replay_settings.r=
eplay_feature_enabled;
- 		bool psr_en =3D acrtc->dm_irq_params.stream->link->psr_settings.psr_fea=
ture_enabled;
- 		bool fs_active_var_en =3D acrtc->dm_irq_params.freesync_config.state
- 			=3D=3D VRR_STATE_ACTIVE_VARIABLE;
-=20
- 		amdgpu_dm_crtc_handle_vblank(acrtc);
-=20
- 		/* BTR processing for pre-DCE12 ASICs */
- 		if (adev->family < AMDGPU_FAMILY_AI) {
- 			spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
- 			mod_freesync_handle_v_update(
- 				adev->dm.freesync_module,
- 				acrtc->dm_irq_params.stream,
- 				&acrtc->dm_irq_params.vrr_params);
-=20
- 			if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
- 				schedule_dc_vmin_vmax(adev,
- 					acrtc->dm_irq_params.stream,
- 					&acrtc->dm_irq_params.vrr_params.adjust);
- 			}
- 			spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
- 		}
- 	}
- }
-=20
- /**
-  * dm_crtc_high_irq() - Handles CRTC interrupt
-  * @interrupt_params: used for determining the CRTC instance
-  *
-  * Handles the CRTC/VSYNC interrupt by notifying DRM's VBLANK event handl=
er.
-  *
-  * Used on DCE (VLINE0, set to vblank start). On DCN the equivalent handl=
ing is
-  * driven by VUPDATE_NO_LOCK in dm_vupdate_high_irq().
-  */
- static void dm_crtc_high_irq(void *interrupt_params)
- {
- 	struct common_irq_params *irq_params =3D interrupt_params;
- 	struct amdgpu_device *adev =3D irq_params->adev;
- 	struct amdgpu_crtc *acrtc;
-=20
- 	acrtc =3D get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLA=
NK);
- 	if (!acrtc)
- 		return;
-=20
- 	dm_crtc_high_irq_handler(adev, acrtc);
- }
-=20
- #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
- /**
-  * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrupt=
0 for
-  * DCN generation ASICs
-  * @interrupt_params: interrupt parameters
-  *
-  * Used to set crc window/read out crc value at vertical line 0 position
-  */
- static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
- {
- 	struct common_irq_params *irq_params =3D interrupt_params;
- 	struct amdgpu_device *adev =3D irq_params->adev;
- 	struct amdgpu_crtc *acrtc;
-=20
- 	acrtc =3D get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VLIN=
E0);
-=20
- 	if (!acrtc)
- 		return;
-=20
- 	amdgpu_dm_crtc_handle_crc_window_irq(&acrtc->base);
- }
- #endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
-=20
- /**
-  * dmub_aux_setconfig_callback - Callback for AUX or SET_CONFIG command.
-  * @adev: amdgpu_device pointer
-  * @notify: dmub notification structure
-  *
-  * Dmub AUX or SET_CONFIG command completion processing callback
-  * Copies dmub notification to DM which is to be read by AUX command.
-  * issuing thread and also signals the event to wake up the thread.
-  */
- static void dmub_aux_setconfig_callback(struct amdgpu_device *adev,
- 					struct dmub_notification *notify)
- {
- 	if (adev->dm.dmub_notify)
- 		memcpy(adev->dm.dmub_notify, notify, sizeof(struct dmub_notification));
- 	if (notify->type =3D=3D DMUB_NOTIFICATION_AUX_REPLY)
- 		complete(&adev->dm.dmub_aux_transfer_done);
- }
-=20
- static void dmub_aux_fused_io_callback(struct amdgpu_device *adev,
- 					struct dmub_notification *notify)
- {
- 	if (!adev || !notify) {
- 		ASSERT(false);
- 		return;
- 	}
-=20
- 	const struct dmub_cmd_fused_request *req =3D &notify->fused_request;
- 	const uint8_t ddc_line =3D req->u.aux.ddc_line;
-=20
- 	if (ddc_line >=3D ARRAY_SIZE(adev->dm.fused_io)) {
- 		ASSERT(false);
- 		return;
- 	}
-=20
- 	struct fused_io_sync *sync =3D &adev->dm.fused_io[ddc_line];
-=20
- 	static_assert(sizeof(*req) <=3D sizeof(sync->reply_data), "Size mismatch=
");
- 	memcpy(sync->reply_data, req, sizeof(*req));
- 	complete(&sync->replied);
- }
-=20
- /**
-  * dmub_hpd_callback - DMUB HPD interrupt processing callback.
-  * @adev: amdgpu_device pointer
-  * @notify: dmub notification structure
-  *
-  * Dmub Hpd interrupt processing callback. Gets displayindex through the
-  * ink index and calls helper to do the processing.
-  */
- static void dmub_hpd_callback(struct amdgpu_device *adev,
- 			      struct dmub_notification *notify)
- {
- 	struct amdgpu_dm_connector *aconnector;
- 	struct amdgpu_dm_connector *hpd_aconnector =3D NULL;
- 	struct drm_connector *connector;
- 	struct drm_connector_list_iter iter;
- 	struct dc_link *link;
- 	u8 link_index =3D 0;
- 	struct drm_device *dev;
-=20
- 	if (adev =3D=3D NULL)
- 		return;
-=20
- 	if (notify =3D=3D NULL) {
- 		drm_err(adev_to_drm(adev), "DMUB HPD callback notification was NULL");
- 		return;
- 	}
-=20
- 	if (notify->link_index > adev->dm.dc->link_count) {
- 		drm_err(adev_to_drm(adev), "DMUB HPD index (%u)is abnormal", notify->li=
nk_index);
- 		return;
- 	}
-=20
- 	/* Skip DMUB HPD IRQ in suspend/resume. We will probe them later. */
- 	if (notify->type =3D=3D DMUB_NOTIFICATION_HPD && adev->in_suspend) {
- 		drm_info(adev_to_drm(adev), "Skip DMUB HPD IRQ callback in suspend/resu=
me\n");
- 		return;
- 	}
-=20
- 	link_index =3D notify->link_index;
- 	link =3D adev->dm.dc->links[link_index];
- 	dev =3D adev->dm.ddev;
-=20
- 	drm_connector_list_iter_begin(dev, &iter);
- 	drm_for_each_connector_iter(connector, &iter) {
-=20
- 		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 			continue;
-=20
- 		aconnector =3D to_amdgpu_dm_connector(connector);
- 		if (link && aconnector->dc_link =3D=3D link) {
- 			if (notify->type =3D=3D DMUB_NOTIFICATION_HPD)
- 				drm_info(adev_to_drm(adev), "DMUB HPD IRQ callback: link_index=3D%u\n=
", link_index);
- 			else if (notify->type =3D=3D DMUB_NOTIFICATION_HPD_IRQ)
- 				drm_info(adev_to_drm(adev), "DMUB HPD RX IRQ callback: link_index=3D%=
u\n", link_index);
- 			else
- 				drm_warn(adev_to_drm(adev), "DMUB Unknown HPD callback type %d, link_=
index=3D%u\n",
- 						notify->type, link_index);
-=20
- 			hpd_aconnector =3D aconnector;
- 			break;
- 		}
- 	}
- 	drm_connector_list_iter_end(&iter);
-=20
- 	if (hpd_aconnector) {
- 		if (notify->type =3D=3D DMUB_NOTIFICATION_HPD) {
- 			if (hpd_aconnector->dc_link->hpd_status =3D=3D (notify->hpd_status =3D=
=3D DP_HPD_PLUG))
- 				drm_warn(adev_to_drm(adev), "DMUB reported hpd status unchanged. link=
_index=3D%u\n", link_index);
- 			handle_hpd_irq_helper(hpd_aconnector);
- 		} else if (notify->type =3D=3D DMUB_NOTIFICATION_HPD_IRQ) {
- 			handle_hpd_rx_irq(hpd_aconnector);
- 		}
- 	}
- }
-=20
- /**
-  * dmub_hpd_sense_callback - DMUB HPD sense processing callback.
-  * @adev: amdgpu_device pointer
-  * @notify: dmub notification structure
-  *
-  * HPD sense changes can occur during low power states and need to be
-  * notified from firmware to driver.
-  */
- static void dmub_hpd_sense_callback(struct amdgpu_device *adev,
- 			      struct dmub_notification *notify)
- {
- 	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
- }
-=20
- /**
-  * register_dmub_notify_callback - Sets callback for DMUB notify
-  * @adev: amdgpu_device pointer
-  * @type: Type of dmub notification
-  * @callback: Dmub interrupt callback function
-  * @dmub_int_thread_offload: offload indicator
-  *
-  * API to register a dmub callback handler for a dmub notification
-  * Also sets indicator whether callback processing to be offloaded.
-  * to dmub interrupt handling thread
-  * Return: true if successfully registered, false if there is existing re=
gistration
-  */
- static bool register_dmub_notify_callback(struct amdgpu_device *adev,
- 					  enum dmub_notification_type type,
- 					  dmub_notify_interrupt_callback_t callback,
- 					  bool dmub_int_thread_offload)
- {
- 	if (callback !=3D NULL && type < ARRAY_SIZE(adev->dm.dmub_thread_offload=
)) {
- 		adev->dm.dmub_callback[type] =3D callback;
- 		adev->dm.dmub_thread_offload[type] =3D dmub_int_thread_offload;
- 	} else
- 		return false;
-=20
- 	return true;
- }
-=20
- static void dm_handle_hpd_work(struct work_struct *work)
- {
- 	struct dmub_hpd_work *dmub_hpd_wrk;
-=20
- 	dmub_hpd_wrk =3D container_of(work, struct dmub_hpd_work, handle_hpd_wor=
k);
-=20
- 	if (!dmub_hpd_wrk->dmub_notify) {
- 		drm_err(adev_to_drm(dmub_hpd_wrk->adev), "dmub_hpd_wrk dmub_notify is N=
ULL");
- 		return;
- 	}
-=20
- 	if (dmub_hpd_wrk->dmub_notify->type < ARRAY_SIZE(dmub_hpd_wrk->adev->dm.=
dmub_callback)) {
- 		dmub_hpd_wrk->adev->dm.dmub_callback[dmub_hpd_wrk->dmub_notify->type](d=
mub_hpd_wrk->adev,
- 		dmub_hpd_wrk->dmub_notify);
- 	}
-=20
- 	kfree(dmub_hpd_wrk->dmub_notify);
- 	kfree(dmub_hpd_wrk);
-=20
- }
-=20
- static const char *dmub_notification_type_str(enum dmub_notification_type=
 e)
- {
- 	switch (e) {
- 	case DMUB_NOTIFICATION_NO_DATA:
- 		return "NO_DATA";
- 	case DMUB_NOTIFICATION_AUX_REPLY:
- 		return "AUX_REPLY";
- 	case DMUB_NOTIFICATION_HPD:
- 		return "HPD";
- 	case DMUB_NOTIFICATION_HPD_IRQ:
- 		return "HPD_IRQ";
- 	case DMUB_NOTIFICATION_SET_CONFIG_REPLY:
- 		return "SET_CONFIG_REPLY";
- 	case DMUB_NOTIFICATION_DPIA_NOTIFICATION:
- 		return "DPIA_NOTIFICATION";
- 	case DMUB_NOTIFICATION_HPD_SENSE_NOTIFY:
- 		return "HPD_SENSE_NOTIFY";
- 	case DMUB_NOTIFICATION_FUSED_IO:
- 		return "FUSED_IO";
- 	default:
- 		return "<unknown>";
- 	}
- }
-=20
- #define DMUB_TRACE_MAX_READ 64
- /**
-  * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
-  * @interrupt_params: used for determining the Outbox instance
-  *
-  * Handles the Outbox Interrupt
-  * event handler.
-  */
- static void dm_dmub_outbox1_low_irq(void *interrupt_params)
- {
- 	struct dmub_notification notify =3D {0};
- 	struct common_irq_params *irq_params =3D interrupt_params;
- 	struct amdgpu_device *adev =3D irq_params->adev;
- 	struct amdgpu_display_manager *dm =3D &adev->dm;
- 	struct dmcub_trace_buf_entry entry =3D { 0 };
- 	u32 count =3D 0;
- 	struct dmub_hpd_work *dmub_hpd_wrk;
-=20
- 	do {
- 		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
- 			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
- 							entry.param0, entry.param1);
-=20
- 			drm_dbg_driver(adev_to_drm(adev), "trace_code:%u, tick_count:%u, param=
0:%u, param1:%u\n",
- 				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
- 		} else
- 			break;
-=20
- 		count++;
-=20
- 	} while (count <=3D DMUB_TRACE_MAX_READ);
-=20
- 	if (count > DMUB_TRACE_MAX_READ)
- 		drm_dbg_driver(adev_to_drm(adev), "Warning : count > DMUB_TRACE_MAX_REA=
D");
-=20
- 	if (dc_enable_dmub_notifications(adev->dm.dc) &&
- 		irq_params->irq_src =3D=3D DC_IRQ_SOURCE_DMCUB_OUTBOX) {
-=20
- 		do {
- 			dc_stat_get_dmub_notification(adev->dm.dc, &notify);
- 			if (notify.type >=3D ARRAY_SIZE(dm->dmub_thread_offload)) {
- 				drm_err(adev_to_drm(adev), "DM: notify type %d invalid!", notify.type=
);
- 				continue;
- 			}
- 			if (!dm->dmub_callback[notify.type]) {
- 				drm_warn(adev_to_drm(adev), "DMUB notification skipped due to no hand=
ler: type=3D%s\n",
- 					dmub_notification_type_str(notify.type));
- 				continue;
- 			}
- 			if (dm->dmub_thread_offload[notify.type] =3D=3D true) {
- 				dmub_hpd_wrk =3D kzalloc_obj(*dmub_hpd_wrk,
- 							   GFP_ATOMIC);
- 				if (!dmub_hpd_wrk) {
- 					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk");
- 					return;
- 				}
- 				dmub_hpd_wrk->dmub_notify =3D kmemdup(&notify, sizeof(struct dmub_not=
ification),
- 								    GFP_ATOMIC);
- 				if (!dmub_hpd_wrk->dmub_notify) {
- 					kfree(dmub_hpd_wrk);
- 					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk->dmub_no=
tify");
- 					return;
- 				}
- 				INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
- 				dmub_hpd_wrk->adev =3D adev;
- 				queue_work(adev->dm.delayed_hpd_wq, &dmub_hpd_wrk->handle_hpd_work);
- 			} else {
- 				dm->dmub_callback[notify.type](adev, &notify);
- 			}
- 		} while (notify.pending_notification);
- 	}
- }
-=20
- static int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
- 		  enum amd_clockgating_state state)
+ STATIC_IFN_KUNIT int dm_set_clockgating_state(struct amdgpu_ip_block *ip_=
block,
+ 					      enum amd_clockgating_state state)
  {
  	return 0;
  }
+ EXPORT_IF_KUNIT(dm_set_clockgating_state);
 =20
- static int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
- 		  enum amd_powergating_state state)
+ STATIC_IFN_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_=
block,
+ 					      enum amd_powergating_state state)
  {
  	return 0;
  }
+ EXPORT_IF_KUNIT(dm_set_powergating_state);
 =20
  /* Prototypes of private functions */
  static int dm_early_init(struct amdgpu_ip_block *ip_block);
 =20
  /* Allocate memory for FBC compressed data  */
- static void amdgpu_dm_fbc_init(struct drm_connector *connector)
- {
- 	struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
- 	struct dm_compressor_info *compressor =3D &adev->dm.compressor;
- 	struct amdgpu_dm_connector *aconn =3D to_amdgpu_dm_connector(connector);
- 	struct drm_display_mode *mode;
- 	unsigned long max_size =3D 0;
-=20
- 	if (adev->dm.dc->fbc_compressor =3D=3D NULL)
- 		return;
-=20
- 	if (aconn->dc_link->connector_signal !=3D SIGNAL_TYPE_EDP)
- 		return;
-=20
- 	if (compressor->bo_ptr)
- 		return;
-=20
-=20
- 	list_for_each_entry(mode, &connector->modes, head) {
- 		if (max_size < (unsigned long) mode->htotal * mode->vtotal)
- 			max_size =3D (unsigned long) mode->htotal * mode->vtotal;
- 	}
-=20
- 	if (max_size) {
- 		int r =3D amdgpu_bo_create_kernel(adev, max_size * 4, PAGE_SIZE,
- 			    AMDGPU_GEM_DOMAIN_GTT, &compressor->bo_ptr,
- 			    &compressor->gpu_addr, &compressor->cpu_addr);
-=20
- 		if (r)
- 			drm_err(adev_to_drm(adev), "DM: Failed to initialize FBC\n");
- 		else {
- 			adev->dm.dc->ctx->fbc_gpu_addr =3D compressor->gpu_addr;
- 			drm_info(adev_to_drm(adev), "DM: FBC alloc %lu\n", max_size*4);
- 		}
-=20
- 	}
-=20
- }
-=20
- static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int por=
t,
- 					  int pipe, bool *enabled,
- 					  unsigned char *buf, int max_bytes)
- {
- 	struct drm_device *dev =3D dev_get_drvdata(kdev);
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	struct drm_connector *connector;
- 	struct drm_connector_list_iter conn_iter;
- 	struct amdgpu_dm_connector *aconnector;
- 	int ret =3D 0;
-=20
- 	*enabled =3D false;
-=20
- 	mutex_lock(&adev->dm.audio_lock);
-=20
- 	drm_connector_list_iter_begin(dev, &conn_iter);
- 	drm_for_each_connector_iter(connector, &conn_iter) {
-=20
- 		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 			continue;
-=20
- 		aconnector =3D to_amdgpu_dm_connector(connector);
- 		if (aconnector->audio_inst !=3D port)
- 			continue;
-=20
- 		*enabled =3D true;
- 		mutex_lock(&connector->eld_mutex);
- 		ret =3D drm_eld_size(connector->eld);
- 		memcpy(buf, connector->eld, min(max_bytes, ret));
- 		mutex_unlock(&connector->eld_mutex);
-=20
- 		break;
- 	}
- 	drm_connector_list_iter_end(&conn_iter);
-=20
- 	mutex_unlock(&adev->dm.audio_lock);
-=20
- 	drm_dbg_kms(adev_to_drm(adev), "Get ELD : idx=3D%d ret=3D%d en=3D%d\n", =
port, ret, *enabled);
-=20
- 	return ret;
- }
-=20
- static const struct drm_audio_component_ops amdgpu_dm_audio_component_ops=
 =3D {
- 	.get_eld =3D amdgpu_dm_audio_component_get_eld,
- };
-=20
- static int amdgpu_dm_audio_component_bind(struct device *kdev,
- 				       struct device *hda_kdev, void *data)
- {
- 	struct drm_device *dev =3D dev_get_drvdata(kdev);
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	struct drm_audio_component *acomp =3D data;
-=20
- 	acomp->ops =3D &amdgpu_dm_audio_component_ops;
- 	acomp->dev =3D kdev;
- 	adev->dm.audio_component =3D acomp;
-=20
- 	return 0;
- }
-=20
- static void amdgpu_dm_audio_component_unbind(struct device *kdev,
- 					  struct device *hda_kdev, void *data)
- {
- 	struct amdgpu_device *adev =3D drm_to_adev(dev_get_drvdata(kdev));
- 	struct drm_audio_component *acomp =3D data;
-=20
- 	acomp->ops =3D NULL;
- 	acomp->dev =3D NULL;
- 	adev->dm.audio_component =3D NULL;
- }
-=20
- static const struct component_ops amdgpu_dm_audio_component_bind_ops =3D {
- 	.bind	=3D amdgpu_dm_audio_component_bind,
- 	.unbind	=3D amdgpu_dm_audio_component_unbind,
- };
-=20
- static int amdgpu_dm_audio_init(struct amdgpu_device *adev)
- {
- 	int i, ret;
-=20
- 	if (!amdgpu_audio)
- 		return 0;
-=20
- 	adev->mode_info.audio.enabled =3D true;
-=20
- 	adev->mode_info.audio.num_pins =3D adev->dm.dc->res_pool->audio_count;
-=20
- 	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++) {
- 		adev->mode_info.audio.pin[i].channels =3D -1;
- 		adev->mode_info.audio.pin[i].rate =3D -1;
- 		adev->mode_info.audio.pin[i].bits_per_sample =3D -1;
- 		adev->mode_info.audio.pin[i].status_bits =3D 0;
- 		adev->mode_info.audio.pin[i].category_code =3D 0;
- 		adev->mode_info.audio.pin[i].connected =3D false;
- 		adev->mode_info.audio.pin[i].id =3D
- 			adev->dm.dc->res_pool->audios[i]->inst;
- 		adev->mode_info.audio.pin[i].offset =3D 0;
- 	}
-=20
- 	ret =3D component_add(adev->dev, &amdgpu_dm_audio_component_bind_ops);
- 	if (ret < 0)
- 		return ret;
-=20
- 	adev->dm.audio_registered =3D true;
-=20
- 	return 0;
- }
-=20
- static void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
- {
- 	if (!amdgpu_audio)
- 		return;
-=20
- 	if (!adev->mode_info.audio.enabled)
- 		return;
-=20
- 	if (adev->dm.audio_registered) {
- 		component_del(adev->dev, &amdgpu_dm_audio_component_bind_ops);
- 		adev->dm.audio_registered =3D false;
- 	}
-=20
- 	/* TODO: Disable audio? */
-=20
- 	adev->mode_info.audio.enabled =3D false;
- }
-=20
- static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int p=
in)
- {
- 	struct drm_audio_component *acomp =3D adev->dm.audio_component;
-=20
- 	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify) {
- 		drm_dbg_kms(adev_to_drm(adev), "Notify ELD: %d\n", pin);
-=20
- 		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
- 						 pin, -1);
- 	}
- }
-=20
- static int dm_dmub_hw_init(struct amdgpu_device *adev)
- {
- 	const struct dmcub_firmware_header_v1_0 *hdr;
- 	struct dmub_srv *dmub_srv =3D adev->dm.dmub_srv;
- 	struct dmub_srv_fb_info *fb_info =3D adev->dm.dmub_fb_info;
- 	const struct firmware *dmub_fw =3D adev->dm.dmub_fw;
- 	struct dc *dc =3D adev->dm.dc;
- 	struct dmcu *dmcu =3D adev->dm.dc->res_pool->dmcu;
- 	struct abm *abm =3D adev->dm.dc->res_pool->abm;
- 	struct dc_context *ctx =3D adev->dm.dc->ctx;
- 	struct dmub_srv_hw_params hw_params;
- 	enum dmub_status status;
- 	const unsigned char *fw_inst_const, *fw_bss_data;
- 	u32 i, fw_inst_const_size, fw_bss_data_size;
- 	bool has_hw_support;
-=20
- 	if (!dmub_srv)
- 		/* DMUB isn't supported on the ASIC. */
- 		return 0;
-=20
- 	if (!fb_info) {
- 		drm_err(adev_to_drm(adev), "No framebuffer info for DMUB service.\n");
- 		return -EINVAL;
- 	}
-=20
- 	if (!dmub_fw) {
- 		/* Firmware required for DMUB support. */
- 		drm_err(adev_to_drm(adev), "No firmware provided for DMUB.\n");
- 		return -EINVAL;
- 	}
-=20
- 	/* initialize register offsets for ASICs with runtime initialization ava=
ilable */
- 	if (dmub_srv->hw_funcs.init_reg_offsets)
- 		dmub_srv->hw_funcs.init_reg_offsets(dmub_srv, ctx);
-=20
- 	status =3D dmub_srv_has_hw_support(dmub_srv, &has_hw_support);
- 	if (status !=3D DMUB_STATUS_OK) {
- 		drm_err(adev_to_drm(adev), "Error checking HW support for DMUB: %d\n", =
status);
- 		return -EINVAL;
- 	}
-=20
- 	if (!has_hw_support) {
- 		drm_info(adev_to_drm(adev), "DMUB unsupported on ASIC\n");
- 		return 0;
- 	}
-=20
- 	/* Reset DMCUB if it was previously running - before we overwrite its me=
mory. */
- 	status =3D dmub_srv_hw_reset(dmub_srv);
- 	if (status !=3D DMUB_STATUS_OK)
- 		drm_warn(adev_to_drm(adev), "Error resetting DMUB HW: %d\n", status);
-=20
- 	hdr =3D (const struct dmcub_firmware_header_v1_0 *)dmub_fw->data;
-=20
- 	fw_inst_const =3D dmub_fw->data +
- 			le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
- 			PSP_HEADER_BYTES_256;
-=20
- 	fw_bss_data =3D dmub_fw->data +
- 		      le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
- 		      le32_to_cpu(hdr->inst_const_bytes);
-=20
- 	/* Copy firmware and bios info into FB memory. */
- 	fw_inst_const_size =3D adev->dm.fw_inst_size;
-=20
- 	fw_bss_data_size =3D le32_to_cpu(hdr->bss_data_bytes);
-=20
- 	/* if adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP,
- 	 * amdgpu_ucode_init_single_fw will load dmub firmware
- 	 * fw_inst_const part to cw0; otherwise, the firmware back door load
- 	 * will be done by dm_dmub_hw_init
- 	 */
- 	if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
- 		memcpy(fb_info->fb[DMUB_WINDOW_0_INST_CONST].cpu_addr, fw_inst_const,
- 				fw_inst_const_size);
- 	}
-=20
- 	if (fw_bss_data_size)
- 		memcpy(fb_info->fb[DMUB_WINDOW_2_BSS_DATA].cpu_addr,
- 		       fw_bss_data, fw_bss_data_size);
-=20
- 	/* Copy firmware bios info into FB memory. */
- 	memcpy(fb_info->fb[DMUB_WINDOW_3_VBIOS].cpu_addr, adev->bios,
- 	       adev->bios_size);
-=20
- 	/* Reset regions that need to be reset. */
- 	memset(fb_info->fb[DMUB_WINDOW_4_MAILBOX].cpu_addr, 0,
- 	fb_info->fb[DMUB_WINDOW_4_MAILBOX].size);
-=20
- 	memset(fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].cpu_addr, 0,
- 	       fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].size);
-=20
- 	memset(fb_info->fb[DMUB_WINDOW_6_FW_STATE].cpu_addr, 0,
- 	       fb_info->fb[DMUB_WINDOW_6_FW_STATE].size);
-=20
- 	memset(fb_info->fb[DMUB_WINDOW_SHARED_STATE].cpu_addr, 0,
- 	       fb_info->fb[DMUB_WINDOW_SHARED_STATE].size);
-=20
- 	/* Initialize hardware. */
- 	memset(&hw_params, 0, sizeof(hw_params));
- 	hw_params.soc_fb_info.fb_base =3D adev->gmc.fb_start;
- 	hw_params.soc_fb_info.fb_offset =3D adev->vm_manager.vram_base_offset;
-=20
- 	/* backdoor load firmware and trigger dmub running */
- 	if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
- 		hw_params.load_inst_const =3D true;
-=20
- 	if (dmcu)
- 		hw_params.psp_version =3D dmcu->psp_version;
-=20
- 	for (i =3D 0; i < fb_info->num_fb; ++i)
- 		hw_params.fb[i] =3D &fb_info->fb[i];
-=20
- 	/* Enable usb4 dpia in the FW APU */
- 	if (dc->caps.is_apu &&
- 		dc->res_pool->usb4_dpia_count !=3D 0 &&
- 		!dc->debug.dpia_debug.bits.disable_dpia) {
- 		hw_params.dpia_supported =3D true;
- 		hw_params.disable_dpia =3D dc->debug.dpia_debug.bits.disable_dpia;
- 		hw_params.dpia_hpd_int_enable_supported =3D false;
- 		hw_params.enable_non_transparent_setconfig =3D dc->config.consolidated_=
dpia_dp_lt;
- 		hw_params.disable_dpia_bw_allocation =3D !dc->config.usb4_bw_alloc_supp=
ort;
- 	}
-=20
- 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
- 	case IP_VERSION(3, 5, 0):
- 	case IP_VERSION(3, 5, 1):
- 	case IP_VERSION(3, 6, 0):
- 	case IP_VERSION(4, 2, 0):
- 	case IP_VERSION(4, 2, 1):
- 		hw_params.ips_sequential_ono =3D adev->external_rev_id > 0x10;
- 		hw_params.lower_hbr3_phy_ssc =3D true;
- 		break;
- 	default:
- 		break;
- 	}
-=20
- 	status =3D dmub_srv_hw_init(dmub_srv, &hw_params);
- 	if (status !=3D DMUB_STATUS_OK) {
- 		drm_err(adev_to_drm(adev), "Error initializing DMUB HW: %d\n", status);
- 		return -EINVAL;
- 	}
-=20
- 	/* Wait for firmware load to finish. */
- 	status =3D dmub_srv_wait_for_auto_load(dmub_srv, 100000);
- 	if (status !=3D DMUB_STATUS_OK)
- 		drm_warn(adev_to_drm(adev), "Wait for DMUB auto-load failed: %d\n", sta=
tus);
-=20
- 	/* Init DMCU and ABM if available. */
- 	if (dmcu && abm) {
- 		dmcu->funcs->dmcu_init(dmcu);
- 		abm->dmcu_is_running =3D dmcu->funcs->is_dmcu_initialized(dmcu);
- 	}
-=20
- 	if (!adev->dm.dc->ctx->dmub_srv)
- 		adev->dm.dc->ctx->dmub_srv =3D dc_dmub_srv_create(adev->dm.dc, dmub_srv=
);
- 	if (!adev->dm.dc->ctx->dmub_srv) {
- 		drm_err(adev_to_drm(adev), "Couldn't allocate DC DMUB server!\n");
- 		return -ENOMEM;
- 	}
-=20
- 	drm_info(adev_to_drm(adev), "DMUB hardware initialized: version=3D0x%08X=
\n",
- 		 adev->dm.dmcub_fw_version);
-=20
- 	/* Keeping sanity checks off if
- 	 * DCN31 >=3D 4.0.59.0
- 	 * DCN314 >=3D 8.0.16.0
- 	 * Otherwise, turn on sanity checks
- 	 */
- 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
- 	case IP_VERSION(3, 1, 2):
- 	case IP_VERSION(3, 1, 3):
- 		if (adev->dm.dmcub_fw_version &&
- 			adev->dm.dmcub_fw_version >=3D DMUB_FW_VERSION(4, 0, 0) &&
- 			adev->dm.dmcub_fw_version < DMUB_FW_VERSION(4, 0, 59))
- 				adev->dm.dc->debug.sanity_checks =3D true;
- 		break;
- 	case IP_VERSION(3, 1, 4):
- 		if (adev->dm.dmcub_fw_version &&
- 			adev->dm.dmcub_fw_version >=3D DMUB_FW_VERSION(4, 0, 0) &&
- 			adev->dm.dmcub_fw_version < DMUB_FW_VERSION(8, 0, 16))
- 				adev->dm.dc->debug.sanity_checks =3D true;
- 		break;
- 	default:
- 		break;
- 	}
-=20
- 	return 0;
- }
-=20
- static void dm_dmub_hw_resume(struct amdgpu_device *adev)
- {
- 	struct dmub_srv *dmub_srv =3D adev->dm.dmub_srv;
- 	enum dmub_status status;
- 	bool init;
- 	int r;
-=20
- 	if (!dmub_srv) {
- 		/* DMUB isn't supported on the ASIC. */
- 		return;
- 	}
-=20
- 	status =3D dmub_srv_is_hw_init(dmub_srv, &init);
- 	if (status !=3D DMUB_STATUS_OK)
- 		drm_warn(adev_to_drm(adev), "DMUB hardware init check failed: %d\n", st=
atus);
-=20
- 	if (status =3D=3D DMUB_STATUS_OK && init) {
- 		/* Wait for firmware load to finish. */
- 		status =3D dmub_srv_wait_for_auto_load(dmub_srv, 100000);
- 		if (status !=3D DMUB_STATUS_OK)
- 			drm_warn(adev_to_drm(adev), "Wait for DMUB auto-load failed: %d\n", st=
atus);
- 	} else {
- 		/* Perform the full hardware initialization. */
- 		r =3D dm_dmub_hw_init(adev);
- 		if (r)
- 			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: statu=
s=3D%d\n", r);
- 	}
- }
-=20
  static void mmhub_read_system_context(struct amdgpu_device *adev, struct =
dc_phy_addr_space_config *pa_config)
  {
  	u64 pt_base;
@@@ -1599,349 -394,6 +394,6 @@@
 =20
  }
 =20
- static void force_connector_state(
- 	struct amdgpu_dm_connector *aconnector,
- 	enum drm_connector_force force_state)
- {
- 	struct drm_connector *connector =3D &aconnector->base;
-=20
- 	mutex_lock(&connector->dev->mode_config.mutex);
- 	aconnector->base.force =3D force_state;
- 	mutex_unlock(&connector->dev->mode_config.mutex);
-=20
- 	mutex_lock(&aconnector->hpd_lock);
- 	drm_kms_helper_connector_hotplug_event(connector);
- 	mutex_unlock(&aconnector->hpd_lock);
- }
-=20
- static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
- {
- 	struct hpd_rx_irq_offload_work *offload_work;
- 	struct amdgpu_dm_connector *aconnector;
- 	struct dc_link *dc_link;
- 	struct amdgpu_device *adev;
- 	enum dc_connection_type new_connection_type =3D dc_connection_none;
- 	unsigned long flags;
- 	union test_response test_response;
-=20
- 	memset(&test_response, 0, sizeof(test_response));
-=20
- 	offload_work =3D container_of(work, struct hpd_rx_irq_offload_work, work=
);
- 	aconnector =3D offload_work->offload_wq->aconnector;
- 	adev =3D offload_work->adev;
-=20
- 	if (!aconnector) {
- 		drm_err(adev_to_drm(adev), "Can't retrieve aconnector in hpd_rx_irq_off=
load_work");
- 		goto skip;
- 	}
-=20
- 	dc_link =3D aconnector->dc_link;
-=20
- 	mutex_lock(&aconnector->hpd_lock);
- 	if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
- 		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
- 	mutex_unlock(&aconnector->hpd_lock);
-=20
- 	if (new_connection_type =3D=3D dc_connection_none)
- 		goto skip;
-=20
- 	if (amdgpu_in_reset(adev))
- 		goto skip;
-=20
- 	if (offload_work->data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
- 		offload_work->data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
- 		dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr, DOWN_OR_UP=
_MSG_RDY_EVENT);
- 		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
- 		offload_work->offload_wq->is_handling_mst_msg_rdy_event =3D false;
- 		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
- 		goto skip;
- 	}
-=20
- 	mutex_lock(&adev->dm.dc_lock);
- 	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
- 		dc_link_dp_handle_automated_test(dc_link);
-=20
- 		if (aconnector->timing_changed) {
- 			/* force connector disconnect and reconnect */
- 			force_connector_state(aconnector, DRM_FORCE_OFF);
- 			msleep(100);
- 			force_connector_state(aconnector, DRM_FORCE_UNSPECIFIED);
- 		}
-=20
- 		test_response.bits.ACK =3D 1;
-=20
- 		core_link_write_dpcd(
- 		dc_link,
- 		DP_TEST_RESPONSE,
- 		&test_response.raw,
- 		sizeof(test_response));
- 	} else if ((dc_link->connector_signal !=3D SIGNAL_TYPE_EDP) &&
- 			dc_link_check_link_loss_status(dc_link, &offload_work->data) &&
- 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
- 		/* offload_work->data is from handle_hpd_rx_irq->
- 		 * schedule_hpd_rx_offload_work.this is defer handle
- 		 * for hpd short pulse. upon here, link status may be
- 		 * changed, need get latest link status from dpcd
- 		 * registers. if link status is good, skip run link
- 		 * training again.
- 		 */
- 		union hpd_irq_data irq_data;
-=20
- 		memset(&irq_data, 0, sizeof(irq_data));
-=20
- 		/* before dc_link_dp_handle_link_loss, allow new link lost handle
- 		 * request be added to work queue if link lost at end of dc_link_
- 		 * dp_handle_link_loss
- 		 */
- 		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
- 		offload_work->offload_wq->is_handling_link_loss =3D false;
- 		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
-=20
- 		if ((dc_link_dp_read_hpd_rx_irq_data(dc_link, &irq_data) =3D=3D DC_OK) =
&&
- 			dc_link_check_link_loss_status(dc_link, &irq_data))
- 			dc_link_dp_handle_link_loss(dc_link);
- 	}
- 	mutex_unlock(&adev->dm.dc_lock);
-=20
- skip:
- 	kfree(offload_work);
-=20
- }
-=20
- static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(=
struct amdgpu_device *adev)
- {
- 	struct dc *dc =3D adev->dm.dc;
- 	int max_caps =3D dc->caps.max_links;
- 	int i =3D 0;
- 	struct hpd_rx_irq_offload_work_queue *hpd_rx_offload_wq =3D NULL;
-=20
- 	hpd_rx_offload_wq =3D kzalloc_objs(*hpd_rx_offload_wq, max_caps);
-=20
- 	if (!hpd_rx_offload_wq)
- 		return NULL;
-=20
-=20
- 	for (i =3D 0; i < max_caps; i++) {
- 		hpd_rx_offload_wq[i].wq =3D
- 				    create_singlethread_workqueue("amdgpu_dm_hpd_rx_offload_wq");
-=20
- 		if (hpd_rx_offload_wq[i].wq =3D=3D NULL) {
- 			drm_err(adev_to_drm(adev), "create amdgpu_dm_hpd_rx_offload_wq fail!");
- 			goto out_err;
- 		}
-=20
- 		spin_lock_init(&hpd_rx_offload_wq[i].offload_lock);
- 	}
-=20
- 	return hpd_rx_offload_wq;
-=20
- out_err:
- 	for (i =3D 0; i < max_caps; i++) {
- 		if (hpd_rx_offload_wq[i].wq)
- 			destroy_workqueue(hpd_rx_offload_wq[i].wq);
- 	}
- 	kfree(hpd_rx_offload_wq);
- 	return NULL;
- }
-=20
- struct amdgpu_stutter_quirk {
- 	u16 chip_vendor;
- 	u16 chip_device;
- 	u16 subsys_vendor;
- 	u16 subsys_device;
- 	u8 revision;
- };
-=20
- static const struct amdgpu_stutter_quirk amdgpu_stutter_quirk_list[] =3D {
- 	/* https://bugzilla.kernel.org/show_bug.cgi?id=3D214417 */
- 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
- 	{ 0, 0, 0, 0, 0 },
- };
-=20
- static bool dm_should_disable_stutter(struct pci_dev *pdev)
- {
- 	const struct amdgpu_stutter_quirk *p =3D amdgpu_stutter_quirk_list;
-=20
- 	while (p && p->chip_device !=3D 0) {
- 		if (pdev->vendor =3D=3D p->chip_vendor &&
- 		    pdev->device =3D=3D p->chip_device &&
- 		    pdev->subsystem_vendor =3D=3D p->subsys_vendor &&
- 		    pdev->subsystem_device =3D=3D p->subsys_device &&
- 		    pdev->revision =3D=3D p->revision) {
- 			return true;
- 		}
- 		++p;
- 	}
- 	return false;
- }
-=20
-=20
- void*
- dm_allocate_gpu_mem(
- 		struct amdgpu_device *adev,
- 		enum dc_gpu_mem_alloc_type type,
- 		size_t size,
- 		long long *addr)
- {
- 	struct dal_allocation *da;
- 	u32 domain =3D (type =3D=3D DC_MEM_ALLOC_TYPE_GART) ?
- 		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
- 	int ret;
-=20
- 	da =3D kzalloc_obj(struct dal_allocation);
- 	if (!da)
- 		return NULL;
-=20
- 	ret =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
- 				      domain, &da->bo,
- 				      &da->gpu_addr, &da->cpu_ptr);
-=20
- 	*addr =3D da->gpu_addr;
-=20
- 	if (ret) {
- 		kfree(da);
- 		return NULL;
- 	}
-=20
- 	/* add da to list in dm */
- 	list_add(&da->list, &adev->dm.da_list);
-=20
- 	return da->cpu_ptr;
- }
-=20
- void
- dm_free_gpu_mem(
- 		struct amdgpu_device *adev,
- 		enum dc_gpu_mem_alloc_type type,
- 		void *pvMem)
- {
- 	struct dal_allocation *da;
-=20
- 	/* walk the da list in DM */
- 	list_for_each_entry(da, &adev->dm.da_list, list) {
- 		if (pvMem =3D=3D da->cpu_ptr) {
- 			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
- 			list_del(&da->list);
- 			kfree(da);
- 			break;
- 		}
- 	}
-=20
- }
-=20
- static enum dmub_status
- dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
- 				 enum dmub_gpint_command command_code,
- 				 uint16_t param,
- 				 uint32_t timeout_us)
- {
- 	union dmub_gpint_data_register reg, test;
- 	uint32_t i;
-=20
- 	/* Assume that VBIOS DMUB is ready to take commands */
-=20
- 	reg.bits.status =3D 1;
- 	reg.bits.command_code =3D command_code;
- 	reg.bits.param =3D param;
-=20
- 	cgs_write_register(adev->dm.cgs_device, 0x34c0 + 0x01f8, reg.all);
-=20
- 	for (i =3D 0; i < timeout_us; ++i) {
- 		udelay(1);
-=20
- 		/* Check if our GPINT got acked */
- 		reg.bits.status =3D 0;
- 		test =3D (union dmub_gpint_data_register)
- 			cgs_read_register(adev->dm.cgs_device, 0x34c0 + 0x01f8);
-=20
- 		if (test.all =3D=3D reg.all)
- 			return DMUB_STATUS_OK;
- 	}
-=20
- 	return DMUB_STATUS_TIMEOUT;
- }
-=20
- static void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
- {
- 	void *bb;
- 	long long addr;
- 	unsigned int bb_size;
- 	int i =3D 0;
- 	uint16_t chunk;
- 	enum dmub_gpint_command send_addrs[] =3D {
- 		DMUB_GPINT__SET_BB_ADDR_WORD0,
- 		DMUB_GPINT__SET_BB_ADDR_WORD1,
- 		DMUB_GPINT__SET_BB_ADDR_WORD2,
- 		DMUB_GPINT__SET_BB_ADDR_WORD3,
- 	};
- 	enum dmub_status ret;
-=20
- 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
- 	case IP_VERSION(4, 0, 1):
- 		bb_size =3D sizeof(struct dml2_soc_bb);
- 		break;
- 	case IP_VERSION(4, 2, 0):
- 	case IP_VERSION(4, 2, 1):
- 		bb_size =3D sizeof(struct dml2_soc_bb);
- 		break;
- 	default:
- 		return NULL;
- 	}
-=20
- 	bb =3D  dm_allocate_gpu_mem(adev,
- 				  DC_MEM_ALLOC_TYPE_GART,
- 				  bb_size,
- 				  &addr);
- 	if (!bb)
- 		return NULL;
-=20
- 	for (i =3D 0; i < 4; i++) {
- 		/* Extract 16-bit chunk */
- 		chunk =3D ((uint64_t) addr >> (i * 16)) & 0xFFFF;
- 		/* Send the chunk */
- 		ret =3D dm_dmub_send_vbios_gpint_command(adev, send_addrs[i], chunk, 30=
000);
- 		if (ret !=3D DMUB_STATUS_OK)
- 			goto free_bb;
- 	}
-=20
- 	/* Now ask DMUB to copy the bb */
- 	ret =3D dm_dmub_send_vbios_gpint_command(adev, DMUB_GPINT__BB_COPY, 1, 2=
00000);
- 	if (ret !=3D DMUB_STATUS_OK)
- 		goto free_bb;
-=20
- 	return bb;
-=20
- free_bb:
- 	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, (void *) bb);
- 	return NULL;
-=20
- }
-=20
- static enum dmub_ips_disable_type dm_get_default_ips_mode(
- 	struct amdgpu_device *adev)
- {
- 	enum dmub_ips_disable_type ret =3D DMUB_IPS_ENABLE;
-=20
- 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
- 	case IP_VERSION(3, 5, 0):
- 	case IP_VERSION(3, 6, 0):
- 	case IP_VERSION(3, 5, 1):
- 		ret =3D  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
- 		break;
- 	case IP_VERSION(4, 2, 0):
- 	case IP_VERSION(4, 2, 1):
- 		ret =3D  DMUB_IPS_ENABLE;
- 		break;
- 	default:
- 		/* ASICs older than DCN35 do not have IPSs */
- 		if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 5, 0))
- 			ret =3D DMUB_IPS_DISABLE_ALL;
- 		break;
- 	}
-=20
- 	return ret;
- }
-=20
  static int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
  {
  	struct mod_power_init_params init_data[MAX_NUM_EDP];
@@@ -2006,40 -458,6 +458,6 @@@
  	return 0;
  }
 =20
- static void hdmi_frl_status_polling_work(struct work_struct *work)
- {
- 	struct amdgpu_display_manager *dm =3D
- 		container_of(to_delayed_work(work), struct amdgpu_display_manager,
- 				hdmi_frl_status_polling_work);
- 	struct dc *dc =3D dm->dc;
- 	struct dc_link *dc_link;
- 	bool link_update =3D false;
-=20
- 	for (int i =3D 0; i < MAX_LINKS; i++) {
- 		dc_link =3D dc->links[i];
-=20
- 		if (!dc_link || !dc_link->local_sink)
- 			continue;
-=20
- 		if (!dc_is_hdmi_signal(dc_link->connector_signal))
- 			continue;
-=20
- 		if (dc_link->connector_signal !=3D SIGNAL_TYPE_HDMI_FRL)
- 			continue;
-=20
- 		link_update =3D dc_link_frl_poll_status_flag(dc_link);
- 		if (link_update) {
- 			mutex_lock(&dm->dc_lock);
- 			dc_link_detect(dc_link, DETECT_REASON_RETRAIN);
- 			mutex_unlock(&dm->dc_lock);
- 		}
- 	}
-=20
- 	queue_delayed_work(dm->hdmi_frl_status_polling_wq,
- 			   &dm->hdmi_frl_status_polling_work,
- 			   msecs_to_jiffies(dm->hdmi_frl_status_polling_delay_ms));
- }
-=20
  static int amdgpu_dm_init(struct amdgpu_device *adev)
  {
  	struct dc_init_data init_data;
@@@ -2189,11 -607,6 +607,11 @@@
  		init_data.flags.unify_link_enc_assignment =3D true;
  		init_data.flags.usb4_bw_alloc_support =3D true;
  	}
 +
 +	/* DCN201 audio desyncs using DP SS */
 +	if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
 +		init_data.flags.ignore_dpref_ss =3D true;
 +
  	retrieve_dmi_info(&adev->dm);
  	if (adev->dm.edp0_on_dp1_quirk)
  		init_data.flags.support_edp0_on_dp1 =3D true;
@@@ -2271,7 -684,15 +689,15 @@@
 =20
  	dc_hardware_init(adev->dm.dc);
 =20
- 	adev->dm.hpd_rx_offload_wq =3D hpd_rx_irq_create_workqueue(adev);
+ 	/* GOP/vBIOS may leave an OPTC enabled for a display present at power-on
+ 	 * but no longer driven (e.g. an external DP unplugged at boot). Such a
+ 	 * dangling pipe keeps DCN out of idle and blocks s0i3. Power it down
+ 	 * here when nothing needs to be preserved.
+ 	 */
+ 	if (adev->flags & AMD_IS_APU)
+ 		dc_disable_dangling_timing_generators(adev->dm.dc);
+=20
+ 	adev->dm.hpd_rx_offload_wq =3D amdgpu_dm_hpd_rx_irq_create_workqueue(ade=
v);
  	if (!adev->dm.hpd_rx_offload_wq) {
  		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\=
n");
  		goto error;
@@@ -2324,8 -745,6 +750,6 @@@
  			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
  		if (!adev->dm.hdmi_frl_status_polling_wq)
  			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polli=
ng_workqueue\n");
- 		adev->dm.hdmi_frl_status_polling_delay_ms =3D 200;
- 		INIT_DELAYED_WORK(&adev->dm.hdmi_frl_status_polling_work, hdmi_frl_stat=
us_polling_work);
  	}
  	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
  		init_completion(&adev->dm.dmub_aux_transfer_done);
@@@ -2342,8 -761,8 +766,8 @@@
  		}
 =20
  		amdgpu_dm_outbox_init(adev);
- 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
- 			dmub_aux_setconfig_callback, false)) {
+ 		if (!dm_register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
+ 			dm_dmub_aux_setconfig_callback, false)) {
  			drm_err(adev_to_drm(adev), "fail to register dmub aux callback");
  			goto error;
  		}
@@@ -2351,16 -770,17 +775,17 @@@
  		for (size_t i =3D 0; i < ARRAY_SIZE(adev->dm.fused_io); i++)
  			init_completion(&adev->dm.fused_io[i].replied);
 =20
- 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_FUSED_IO,
- 			dmub_aux_fused_io_callback, false)) {
+ 		if (!dm_register_dmub_notify_callback(adev, DMUB_NOTIFICATION_FUSED_IO,
+ 			dm_dmub_aux_fused_io_callback, false)) {
  			drm_err(adev_to_drm(adev), "fail to register dmub fused io callback");
  			goto error;
  		}
  		/* Enable outbox notification only after IRQ handlers are registered an=
d DMUB is alive.
  		 * It is expected that DMUB will resend any pending notifications at th=
is point. Note
- 		 * that hpd and hpd_irq handler registration are deferred to register_h=
pd_handlers() to
- 		 * align legacy interface initialization sequence. Connection status wi=
ll be proactivly
- 		 * detected once in the amdgpu_dm_initialize_drm_device.
+ 		 * that hpd and hpd_irq handler registration are deferred to
+ 		 * amdgpu_dm_register_hpd_handlers() to align legacy interface initiali=
zation
+ 		 * sequence. Connection status will be proactivly detected once in the
+ 		 * amdgpu_dm_initialize_drm_device.
  		 */
  		dc_enable_dmub_outbox(adev->dm.dc);
 =20
@@@ -2503,14 -923,11 +928,11 @@@ static void amdgpu_dm_fini(struct amdgp
  		adev->dm.hpd_rx_offload_wq =3D NULL;
  	}
 =20
+ 	amdgpu_dm_irq_fini(adev);
+=20
  	/* DC Destroy TODO: Replace destroy DAL */
  	if (adev->dm.dc)
  		dc_destroy(&adev->dm.dc);
- 	/*
- 	 * TODO: pageflip, vlank interrupt
- 	 *
- 	 * amdgpu_dm_irq_fini(adev);
- 	 */
 =20
  	if (adev->dm.cgs_device) {
  		amdgpu_cgs_destroy_device(adev->dm.cgs_device);
@@@ -2640,224 -1057,6 +1062,6 @@@ static int load_dmcu_fw(struct amdgpu_d
  	return 0;
  }
 =20
- static uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address)
- {
- 	struct amdgpu_device *adev =3D ctx;
-=20
- 	return dm_read_reg(adev->dm.dc->ctx, address);
- }
-=20
- static void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address,
- 				     uint32_t value)
- {
- 	struct amdgpu_device *adev =3D ctx;
-=20
- 	return dm_write_reg(adev->dm.dc->ctx, address, value);
- }
-=20
- static int dm_dmub_sw_init(struct amdgpu_device *adev)
- {
- 	struct dmub_srv_create_params create_params;
- 	struct dmub_srv_fw_meta_info_params fw_meta_info_params;
- 	struct dmub_srv_region_params region_params;
- 	struct dmub_srv_region_info region_info;
- 	struct dmub_srv_memory_params memory_params;
- 	struct dmub_fw_meta_info fw_info;
- 	struct dmub_srv_fb_info *fb_info;
- 	struct dmub_srv *dmub_srv;
- 	const struct dmcub_firmware_header_v1_0 *hdr;
- 	enum dmub_asic dmub_asic;
- 	enum dmub_status status;
- 	static enum dmub_window_memory_type window_memory_type[DMUB_WINDOW_TOTAL=
] =3D {
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_0_INST_CONST
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_1_STACK
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_2_BSS_DATA
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_3_VBIOS
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_4_MAILBOX
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_5_TRACEBUFF
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_6_FW_STATE
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_7_SCRATCH_MEM
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_IB_MEM
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_SHARED_STATE
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_LSDMA_BUFFER
- 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_CURSOR_OFFLOAD
- 	};
- 	int r;
-=20
- 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
- 	case IP_VERSION(2, 1, 0):
- 		dmub_asic =3D DMUB_ASIC_DCN21;
- 		break;
- 	case IP_VERSION(3, 0, 0):
- 		dmub_asic =3D DMUB_ASIC_DCN30;
- 		break;
- 	case IP_VERSION(3, 0, 1):
- 		dmub_asic =3D DMUB_ASIC_DCN301;
- 		break;
- 	case IP_VERSION(3, 0, 2):
- 		dmub_asic =3D DMUB_ASIC_DCN302;
- 		break;
- 	case IP_VERSION(3, 0, 3):
- 		dmub_asic =3D DMUB_ASIC_DCN303;
- 		break;
- 	case IP_VERSION(3, 1, 2):
- 	case IP_VERSION(3, 1, 3):
- 		dmub_asic =3D (adev->external_rev_id =3D=3D YELLOW_CARP_B0) ? DMUB_ASIC=
_DCN31B : DMUB_ASIC_DCN31;
- 		break;
- 	case IP_VERSION(3, 1, 4):
- 		dmub_asic =3D DMUB_ASIC_DCN314;
- 		break;
- 	case IP_VERSION(3, 1, 5):
- 		dmub_asic =3D DMUB_ASIC_DCN315;
- 		break;
- 	case IP_VERSION(3, 1, 6):
- 		dmub_asic =3D DMUB_ASIC_DCN316;
- 		break;
- 	case IP_VERSION(3, 2, 0):
- 		dmub_asic =3D DMUB_ASIC_DCN32;
- 		break;
- 	case IP_VERSION(3, 2, 1):
- 		dmub_asic =3D DMUB_ASIC_DCN321;
- 		break;
- 	case IP_VERSION(3, 5, 0):
- 	case IP_VERSION(3, 5, 1):
- 		dmub_asic =3D DMUB_ASIC_DCN35;
- 		break;
- 	case IP_VERSION(3, 6, 0):
- 		dmub_asic =3D DMUB_ASIC_DCN36;
- 		break;
- 	case IP_VERSION(4, 0, 1):
- 		dmub_asic =3D DMUB_ASIC_DCN401;
- 		break;
- 	case IP_VERSION(4, 2, 0):
- 		dmub_asic =3D DMUB_ASIC_DCN42;
- 		break;
- 	case IP_VERSION(4, 2, 1):
- 		dmub_asic =3D DMUB_ASIC_DCN42B;
- 		break;
- 	default:
- 		/* ASIC doesn't support DMUB. */
- 		return 0;
- 	}
-=20
- 	hdr =3D (const struct dmcub_firmware_header_v1_0 *)adev->dm.dmub_fw->dat=
a;
- 	adev->dm.dmcub_fw_version =3D le32_to_cpu(hdr->header.ucode_version);
-=20
- 	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
- 		adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].ucode_id =3D
- 			AMDGPU_UCODE_ID_DMCUB;
- 		adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].fw =3D
- 			adev->dm.dmub_fw;
- 		adev->firmware.fw_size +=3D
- 			ALIGN(le32_to_cpu(hdr->inst_const_bytes), PAGE_SIZE);
-=20
- 		drm_info(adev_to_drm(adev), "Loading DMUB firmware via PSP: version=3D0=
x%08X\n",
- 			 adev->dm.dmcub_fw_version);
- 	}
-=20
-=20
- 	adev->dm.dmub_srv =3D kzalloc_obj(*adev->dm.dmub_srv);
- 	dmub_srv =3D adev->dm.dmub_srv;
-=20
- 	if (!dmub_srv) {
- 		drm_err(adev_to_drm(adev), "Failed to allocate DMUB service!\n");
- 		return -ENOMEM;
- 	}
-=20
- 	memset(&create_params, 0, sizeof(create_params));
- 	create_params.user_ctx =3D adev;
- 	create_params.funcs.reg_read =3D amdgpu_dm_dmub_reg_read;
- 	create_params.funcs.reg_write =3D amdgpu_dm_dmub_reg_write;
- 	create_params.asic =3D dmub_asic;
-=20
- 	/* Create the DMUB service. */
- 	status =3D dmub_srv_create(dmub_srv, &create_params);
- 	if (status !=3D DMUB_STATUS_OK) {
- 		drm_err(adev_to_drm(adev), "Error creating DMUB service: %d\n", status);
- 		return -EINVAL;
- 	}
-=20
- 	/* Extract the FW meta info. */
- 	memset(&fw_meta_info_params, 0, sizeof(fw_meta_info_params));
-=20
- 	fw_meta_info_params.inst_const_size =3D le32_to_cpu(hdr->inst_const_byte=
s) -
- 					      PSP_HEADER_BYTES_256;
- 	fw_meta_info_params.bss_data_size =3D le32_to_cpu(hdr->bss_data_bytes);
- 	fw_meta_info_params.fw_inst_const =3D adev->dm.dmub_fw->data +
- 					    le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
- 					    PSP_HEADER_BYTES_256;
- 	fw_meta_info_params.fw_bss_data =3D fw_meta_info_params.bss_data_size ? =
adev->dm.dmub_fw->data +
- 					  le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
- 					  le32_to_cpu(hdr->inst_const_bytes) : NULL;
- 	fw_meta_info_params.custom_psp_footer_size =3D 0;
-=20
- 	status =3D dmub_srv_get_fw_meta_info_from_raw_fw(&fw_meta_info_params, &=
fw_info);
- 	if (status !=3D DMUB_STATUS_OK) {
- 		/* Skip returning early, just log the error. */
- 		drm_err(adev_to_drm(adev), "Error getting DMUB FW meta info: %d\n", sta=
tus);
- 		// return -EINVAL;
- 	}
-=20
- 	/* Calculate the size of all the regions for the DMUB service. */
- 	memset(&region_params, 0, sizeof(region_params));
-=20
- 	region_params.inst_const_size =3D fw_meta_info_params.inst_const_size;
- 	region_params.bss_data_size =3D fw_meta_info_params.bss_data_size;
- 	region_params.vbios_size =3D adev->bios_size;
- 	region_params.fw_bss_data =3D fw_meta_info_params.fw_bss_data;
- 	region_params.fw_inst_const =3D fw_meta_info_params.fw_inst_const;
- 	region_params.window_memory_type =3D window_memory_type;
- 	region_params.fw_info =3D (status =3D=3D DMUB_STATUS_OK) ? &fw_info : NU=
LL;
-=20
- 	status =3D dmub_srv_calc_region_info(dmub_srv, &region_params,
- 					   &region_info);
-=20
- 	if (status !=3D DMUB_STATUS_OK) {
- 		drm_err(adev_to_drm(adev), "Error calculating DMUB region info: %d\n", =
status);
- 		return -EINVAL;
- 	}
-=20
- 	/*
- 	 * Allocate a framebuffer based on the total size of all the regions.
- 	 * TODO: Move this into GART.
- 	 */
- 	r =3D amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
- 				    AMDGPU_GEM_DOMAIN_VRAM |
- 				    AMDGPU_GEM_DOMAIN_GTT,
- 				    &adev->dm.dmub_bo,
- 				    &adev->dm.dmub_bo_gpu_addr,
- 				    &adev->dm.dmub_bo_cpu_addr);
- 	if (r)
- 		return r;
-=20
- 	/* Rebase the regions on the framebuffer address. */
- 	memset(&memory_params, 0, sizeof(memory_params));
- 	memory_params.cpu_fb_addr =3D adev->dm.dmub_bo_cpu_addr;
- 	memory_params.gpu_fb_addr =3D adev->dm.dmub_bo_gpu_addr;
- 	memory_params.region_info =3D &region_info;
- 	memory_params.window_memory_type =3D window_memory_type;
-=20
- 	adev->dm.dmub_fb_info =3D kzalloc_obj(*adev->dm.dmub_fb_info);
- 	fb_info =3D adev->dm.dmub_fb_info;
-=20
- 	if (!fb_info) {
- 		drm_err(adev_to_drm(adev),
- 			"Failed to allocate framebuffer info for DMUB service!\n");
- 		return -ENOMEM;
- 	}
-=20
- 	status =3D dmub_srv_calc_mem_info(dmub_srv, &memory_params, fb_info);
- 	if (status !=3D DMUB_STATUS_OK) {
- 		drm_err(adev_to_drm(adev), "Error calculating DMUB FB info: %d\n", stat=
us);
- 		return -EINVAL;
- 	}
-=20
- 	adev->dm.bb_from_dmub =3D dm_dmub_get_vbios_bounding_box(adev);
- 	adev->dm.fw_inst_size =3D fw_meta_info_params.inst_const_size;
-=20
- 	return 0;
- }
-=20
  static int dm_sw_init(struct amdgpu_ip_block *ip_block)
  {
  	struct amdgpu_device *adev =3D ip_block->adev;
@@@ -2911,41 -1110,6 +1115,6 @@@ static int dm_sw_fini(struct amdgpu_ip_
  	return 0;
  }
 =20
- static int detect_mst_link_for_all_connectors(struct drm_device *dev)
- {
- 	struct amdgpu_dm_connector *aconnector;
- 	struct drm_connector *connector;
- 	struct drm_connector_list_iter iter;
- 	int ret =3D 0;
-=20
- 	drm_connector_list_iter_begin(dev, &iter);
- 	drm_for_each_connector_iter(connector, &iter) {
-=20
- 		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 			continue;
-=20
- 		aconnector =3D to_amdgpu_dm_connector(connector);
- 		if (aconnector->dc_link->type =3D=3D dc_connection_mst_branch &&
- 		    aconnector->mst_mgr.aux) {
- 			drm_dbg_kms(dev, "DM_MST: starting TM on aconnector: %p [id: %d]\n",
- 					 aconnector,
- 					 aconnector->base.base.id);
-=20
- 			ret =3D drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
- 			if (ret < 0) {
- 				drm_err(dev, "DM_MST: Failed to start MST\n");
- 				aconnector->dc_link->type =3D
- 					dc_connection_single;
- 				ret =3D dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
- 								     aconnector->dc_link);
- 				break;
- 			}
- 		}
- 	}
- 	drm_connector_list_iter_end(&iter);
-=20
- 	return ret;
- }
 =20
  static void amdgpu_dm_boot_time_crc_init(struct amdgpu_device *adev)
  {
@@@ -3043,7 -1207,7 +1212,7 @@@ static int dm_late_init(struct amdgpu_i
  		}
  	}
 =20
- 	return detect_mst_link_for_all_connectors(adev_to_drm(adev));
+ 	return amdgpu_dm_detect_mst_link_for_all_connectors(adev_to_drm(adev));
  }
 =20
  static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
@@@ -3097,48 -1261,6 +1266,6 @@@ out_fail
  	mutex_unlock(&mgr->lock);
  }
 =20
- void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
- {
- 	struct cec_notifier *n =3D aconnector->notifier;
-=20
- 	if (!n)
- 		return;
-=20
- 	cec_notifier_phys_addr_invalidate(n);
- }
-=20
- void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
- {
- 	struct drm_connector *connector =3D &aconnector->base;
- 	struct cec_notifier *n =3D aconnector->notifier;
-=20
- 	if (!n)
- 		return;
-=20
- 	cec_notifier_set_phys_addr(n,
- 				   connector->display_info.source_physical_address);
- }
-=20
- static void s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
- {
- 	struct amdgpu_dm_connector *aconnector;
- 	struct drm_connector *connector;
- 	struct drm_connector_list_iter conn_iter;
-=20
- 	drm_connector_list_iter_begin(ddev, &conn_iter);
- 	drm_for_each_connector_iter(connector, &conn_iter) {
- 		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 			continue;
-=20
- 		aconnector =3D to_amdgpu_dm_connector(connector);
- 		if (suspend)
- 			hdmi_cec_unset_edid(aconnector);
- 		else
- 			hdmi_cec_set_edid(aconnector);
- 	}
- 	drm_connector_list_iter_end(&conn_iter);
- }
-=20
  static void s3_handle_mst(struct drm_device *dev, bool suspend)
  {
  	struct amdgpu_dm_connector *aconnector;
@@@ -3181,57 -1303,6 +1308,6 @@@
  	drm_connector_list_iter_end(&iter);
  }
 =20
- static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *ade=
v)
- {
- 	int ret =3D 0;
-=20
- 	/* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
- 	 * on window driver dc implementation.
- 	 * For Navi1x, clock settings of dcn watermarks are fixed. the settings
- 	 * should be passed to smu during boot up and resume from s3.
- 	 * boot up: dc calculate dcn watermark clock settings within dc_create,
- 	 * dcn20_resource_construct
- 	 * then call pplib functions below to pass the settings to smu:
- 	 * smu_set_watermarks_for_clock_ranges
- 	 * smu_set_watermarks_table
- 	 * navi10_set_watermarks_table
- 	 * smu_write_watermarks_table
- 	 *
- 	 * For Renoir, clock settings of dcn watermark are also fixed values.
- 	 * dc has implemented different flow for window driver:
- 	 * dc_hardware_init / dc_set_power_state
- 	 * dcn10_init_hw
- 	 * notify_wm_ranges
- 	 * set_wm_ranges
- 	 * -- Linux
- 	 * smu_set_watermarks_for_clock_ranges
- 	 * renoir_set_watermarks_table
- 	 * smu_write_watermarks_table
- 	 *
- 	 * For Linux,
- 	 * dc_hardware_init -> amdgpu_dm_init
- 	 * dc_set_power_state --> dm_resume
- 	 *
- 	 * therefore, this function apply to navi10/12/14 but not Renoir
- 	 * *
- 	 */
- 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
- 	case IP_VERSION(2, 0, 2):
- 	case IP_VERSION(2, 0, 0):
- 		break;
- 	default:
- 		return 0;
- 	}
-=20
- 	ret =3D amdgpu_dpm_write_watermarks_table(adev);
- 	if (ret) {
- 		drm_err(adev_to_drm(adev), "Failed to update WMTABLE!\n");
- 		return ret;
- 	}
-=20
- 	return 0;
- }
-=20
  static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
  {
  	struct amdgpu_display_manager *dm =3D &adev->dm;
@@@ -3241,7 -1312,7 +1317,7 @@@
 =20
  	oem_ddc_service =3D dc_get_oem_i2c_device(adev->dm.dc);
  	if (oem_ddc_service) {
- 		oem_i2c =3D create_i2c(oem_ddc_service, true);
+ 		oem_i2c =3D amdgpu_dm_create_i2c(oem_ddc_service, true);
  		if (!oem_i2c) {
  			drm_info(adev_to_drm(adev), "Failed to create oem i2c adapter data\n");
  			return -ENOMEM;
@@@ -3284,17 -1355,26 +1360,26 @@@ static int dm_hw_init(struct amdgpu_ip_
  	struct amdgpu_device *adev =3D ip_block->adev;
  	int r;
 =20
+ 	adev->dm.i2c_devres_group =3D devres_open_group(adev->dev, NULL, GFP_KER=
NEL);
+ 	if (!adev->dm.i2c_devres_group)
+ 		return -ENOMEM;
+=20
  	/* Create DAL display manager */
  	r =3D amdgpu_dm_init(adev);
  	if (r)
- 		return r;
+ 		goto err_release_i2c;
  	amdgpu_dm_hpd_init(adev);
 =20
  	r =3D dm_oem_i2c_hw_init(adev);
  	if (r)
  		drm_info(adev_to_drm(adev), "Failed to add OEM i2c bus\n");
 =20
+ 	devres_close_group(adev->dev, adev->dm.i2c_devres_group);
  	return 0;
+=20
+ err_release_i2c:
+ 	devres_release_group(adev->dev, adev->dm.i2c_devres_group);
+ 	return r;
  }
 =20
  /**
@@@ -3309,9 -1389,11 +1394,11 @@@ static int dm_hw_fini(struct amdgpu_ip_
  {
  	struct amdgpu_device *adev =3D ip_block->adev;
 =20
+ 	if (adev->dm.i2c_devres_group)
+ 		devres_release_group(adev->dev, adev->dm.i2c_devres_group);
+=20
  	amdgpu_dm_hpd_fini(adev);
 =20
- 	amdgpu_dm_irq_fini(adev);
  	amdgpu_dm_fini(adev);
  	return 0;
  }
@@@ -3326,7 -1408,7 +1413,7 @@@ static void dm_gpureset_toggle_interrup
  	int i =3D 0;
 =20
  	for (i =3D 0; i < state->stream_count; i++) {
- 		acrtc =3D get_crtc_by_otg_inst(
+ 		acrtc =3D amdgpu_dm_get_crtc_by_otg_inst(
  				adev, state->stream_status[i].primary_otg_inst);
 =20
  		if (acrtc && state->stream_status[i].plane_count !=3D 0 &&
@@@ -3411,16 -1493,6 +1498,6 @@@ static enum dc_status amdgpu_dm_commit_
  	return dc_commit_streams(dc, &params);
  }
 =20
- static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
- {
- 	int i;
-=20
- 	if (dm->hpd_rx_offload_wq) {
- 		for (i =3D 0; i < dm->dc->caps.max_links; i++)
- 			flush_workqueue(dm->hpd_rx_offload_wq[i].wq);
- 	}
- }
-=20
  static int dm_cache_state(struct amdgpu_device *adev)
  {
  	int r;
@@@ -3453,7 -1525,7 +1530,7 @@@ static void dm_destroy_cached_state(str
  	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
  		new_crtc_state->active_changed =3D true;
  		dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
- 		reset_freesync_config_for_crtc(dm_new_crtc_state);
+ 		amdgpu_dm_reset_freesync_config_for_crtc(dm_new_crtc_state);
  	}
 =20
  	/*
@@@ -3516,7 -1588,7 +1593,7 @@@ static int dm_suspend(struct amdgpu_ip_
 =20
  		amdgpu_dm_irq_suspend(adev);
 =20
- 		hpd_rx_irq_work_suspend(dm);
+ 		amdgpu_dm_hpd_rx_irq_work_suspend(dm);
 =20
  		return 0;
  	}
@@@ -3528,7 -1600,7 +1605,7 @@@
  			return r;
  	}
 =20
- 	s3_handle_hdmi_cec(adev_to_drm(adev), true);
+ 	amdgpu_dm_s3_handle_hdmi_cec(adev_to_drm(adev), true);
 =20
  	s3_handle_mst(adev_to_drm(adev), true);
 =20
@@@ -3542,7 -1614,7 +1619,7 @@@
  	scoped_guard(mutex, &dm->dc_lock)
  		amdgpu_dm_ism_force_full_power(dm);
 =20
- 	hpd_rx_irq_work_suspend(dm);
+ 	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
 =20
  	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 =20
@@@ -3554,26 -1626,7 +1631,7 @@@
  	return 0;
  }
 =20
- struct drm_connector *
- amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_commit *st=
ate,
- 					     struct drm_crtc *crtc)
- {
- 	u32 i;
- 	struct drm_connector_state *new_con_state;
- 	struct drm_connector *connector;
- 	struct drm_crtc *crtc_from_state;
-=20
- 	for_each_new_connector_in_state(state, connector, new_con_state, i) {
- 		crtc_from_state =3D new_con_state->crtc;
-=20
- 		if (crtc_from_state =3D=3D crtc)
- 			return connector;
- 	}
-=20
- 	return NULL;
- }
-=20
- static void emulated_link_detect(struct dc_link *link)
+ void amdgpu_dm_emulated_link_detect(struct dc_link *link)
  {
  	struct dc_sink_init_data sink_init_data =3D { 0 };
  	struct display_sink_capability sink_caps =3D { 0 };
@@@ -3694,8 -1747,8 +1752,8 @@@ static void dm_gpureset_commit_state(st
  	}
  }
 =20
- static void apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
- 					    struct dc_sink *sink)
+ void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
+ 											   struct dc_sink *sink)
  {
  	struct dc_panel_patch *ppatch =3D NULL;
 =20
@@@ -3711,6 -1764,7 +1769,7 @@@
  			       ppatch->wait_after_dpcd_poweroff_ms / 1000);
  	}
  }
+ EXPORT_IF_KUNIT(amdgpu_dm_apply_delay_after_dpcd_poweroff);
 =20
  /**
   * amdgpu_dm_dump_links_and_sinks - Debug dump of all DC links and their =
sinks
@@@ -3838,8 -1892,7 +1897,7 @@@ static int dm_resume(struct amdgpu_ip_b
  		for (i =3D 0; i < dc_state->stream_count; i++) {
  			dc_state->streams[i]->mode_changed =3D true;
  			for (j =3D 0; j < dc_state->stream_status[i].plane_count; j++) {
- 				dc_state->stream_status[i].plane_states[j]->update_flags.raw
- 					=3D 0xffffffff;
+ 				dc_pipe_update_bits_set_full(&dc_state->stream_status[i].plane_states=
[j]->update_bits);
  			}
  		}
 =20
@@@ -3902,7 -1955,7 +1960,7 @@@
  	 */
  	amdgpu_dm_irq_resume_early(adev);
 =20
- 	s3_handle_hdmi_cec(ddev, false);
+ 	amdgpu_dm_s3_handle_hdmi_cec(ddev, false);
 =20
  	/* On resume we need to rewrite the MSTM control bits to enable MST*/
  	s3_handle_mst(ddev, false);
@@@ -3937,14 -1990,14 +1995,14 @@@
  			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 =20
  		if (aconnector->base.force && new_connection_type =3D=3D dc_connection_=
none) {
- 			emulated_link_detect(aconnector->dc_link);
+ 			amdgpu_dm_emulated_link_detect(aconnector->dc_link);
  		} else {
  			guard(mutex)(&dm->dc_lock);
  			dc_exit_ips_for_hw_access(dm->dc);
  			ret =3D dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3=
S4);
  			if (ret) {
  				/* w/a delay for certain panels */
- 				apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+ 				amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
  			}
  		}
 =20
@@@ -4022,7 -2075,6 +2080,6 @@@ static const struct amd_ip_funcs amdgpu
  	.resume =3D dm_resume,
  	.is_idle =3D dm_is_idle,
  	.wait_for_idle =3D dm_wait_for_idle,
- 	.check_soft_reset =3D dm_check_soft_reset,
  	.soft_reset =3D dm_soft_reset,
  	.set_clockgating_state =3D dm_set_clockgating_state,
  	.set_powergating_state =3D dm_set_powergating_state,
@@@ -4055,1004 -2107,6 +2112,6 @@@ static struct drm_mode_config_helper_fu
  	.atomic_commit_setup =3D amdgpu_dm_atomic_setup_commit,
  };
 =20
- #define DDC_MANUFACTURERNAME_SAMSUNG 0x2D4C
-=20
- static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
- {
- 	struct drm_connector *connector =3D &aconnector->base;
- 	struct drm_display_info *display_info =3D &connector->display_info;
- 	struct dc_link *link =3D aconnector->dc_link;
- 	struct amdgpu_device *adev;
-=20
- 	adev =3D drm_to_adev(connector->dev);
-=20
- 	link->panel_type =3D PANEL_TYPE_NONE;
-=20
- 	switch (display_info->amd_vsdb.panel_type) {
- 	case AMD_VSDB_PANEL_TYPE_OLED:
- 		link->panel_type =3D PANEL_TYPE_OLED;
- 		break;
- 	case AMD_VSDB_PANEL_TYPE_MINILED:
- 		link->panel_type =3D PANEL_TYPE_MINILED;
- 		break;
- 	}
-=20
- 	/* If VSDB didn't determine panel type, check DPCD ext caps */
- 	if (link->panel_type =3D=3D PANEL_TYPE_NONE) {
- 		if (link->dpcd_sink_ext_caps.bits.miniled =3D=3D 1)
- 			link->panel_type =3D PANEL_TYPE_MINILED;
- 		if (link->dpcd_sink_ext_caps.bits.oled =3D=3D 1)
- 			link->panel_type =3D PANEL_TYPE_OLED;
- 	}
-=20
- 	/*
- 	 * TODO: get panel type from DID2 that has device technology field
- 	 * to specify if it's OLED or not. But we need to wait for DID2
- 	 * support in DC and EDID parser to be able to use it here.
- 	 */
-=20
- 	if (link->panel_type =3D=3D PANEL_TYPE_NONE) {
- 		struct drm_amd_vsdb_info *vsdb =3D &display_info->amd_vsdb;
- 		u32 lum1_max =3D vsdb->luminance_range1.max_luminance;
- 		u32 lum2_max =3D vsdb->luminance_range2.max_luminance;
-=20
- 		if (vsdb->version && link->local_sink &&
- 		    link->local_sink->edid_caps.manufacturer_id =3D=3D
- 		    DDC_MANUFACTURERNAME_SAMSUNG &&
- 		    lum1_max >=3D ((lum2_max * 3) / 2))
- 			link->panel_type =3D PANEL_TYPE_MINILED;
- 	}
-=20
- 	if (link->panel_type =3D=3D PANEL_TYPE_OLED)
- 		drm_object_property_set_value(&connector->base,
- 		    adev_to_drm(adev)->mode_config.panel_type_property,
- 		    DRM_MODE_PANEL_TYPE_OLED);
- 	else
- 		drm_object_property_set_value(&connector->base,
- 		    adev_to_drm(adev)->mode_config.panel_type_property,
- 		    DRM_MODE_PANEL_TYPE_UNKNOWN);
-=20
- 	drm_dbg_kms(aconnector->base.dev, "Panel type: %d\n", link->panel_type);
- }
-=20
- static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnec=
tor)
- {
- 	const struct drm_panel_backlight_quirk *panel_backlight_quirk;
- 	struct amdgpu_dm_backlight_caps *caps;
- 	struct drm_connector *conn_base;
- 	struct amdgpu_device *adev;
- 	struct drm_luminance_range_info *luminance_range;
- 	struct drm_device *drm;
-=20
- 	if (aconnector->bl_idx =3D=3D -1 ||
- 	    aconnector->dc_link->connector_signal !=3D SIGNAL_TYPE_EDP)
- 		return;
-=20
- 	conn_base =3D &aconnector->base;
- 	drm =3D conn_base->dev;
- 	adev =3D drm_to_adev(drm);
-=20
- 	caps =3D &adev->dm.backlight_caps[aconnector->bl_idx];
- 	caps->ext_caps =3D &aconnector->dc_link->dpcd_sink_ext_caps;
- 	caps->aux_support =3D false;
-=20
- 	panel_backlight_quirk =3D drm_get_panel_backlight_quirk(aconnector->drm_=
edid);
-=20
- 	if (caps->ext_caps->bits.oled =3D=3D 1
- 	    /*
- 	     * ||
- 	     * caps->ext_caps->bits.sdr_aux_backlight_control =3D=3D 1 ||
- 	     * caps->ext_caps->bits.hdr_aux_backlight_control =3D=3D 1
- 	     */)
- 		caps->aux_support =3D true;
-=20
- 	if (amdgpu_backlight =3D=3D 0)
- 		caps->aux_support =3D false;
- 	else if (amdgpu_backlight =3D=3D 1)
- 		caps->aux_support =3D true;
- 	else if (!IS_ERR_OR_NULL(panel_backlight_quirk) &&
- 		 panel_backlight_quirk->force_pwm)
- 		caps->aux_support =3D false;
- 	if (caps->aux_support)
- 		aconnector->dc_link->backlight_control_type =3D BACKLIGHT_CONTROL_AMD_A=
UX;
-=20
- 	luminance_range =3D &conn_base->display_info.luminance_range;
-=20
- 	if (luminance_range->max_luminance)
- 		caps->aux_max_input_signal =3D luminance_range->max_luminance;
- 	else
- 		caps->aux_max_input_signal =3D 512;
-=20
- 	if (luminance_range->min_luminance)
- 		caps->aux_min_input_signal =3D luminance_range->min_luminance;
- 	else
- 		caps->aux_min_input_signal =3D 1;
-=20
- 	if (!IS_ERR_OR_NULL(panel_backlight_quirk)) {
- 		if (panel_backlight_quirk->min_brightness) {
- 			caps->min_input_signal =3D
- 				panel_backlight_quirk->min_brightness - 1;
- 			drm_info(drm,
- 				 "Applying panel backlight quirk, min_brightness: %d\n",
- 				 caps->min_input_signal);
- 		}
- 		if (panel_backlight_quirk->brightness_mask) {
- 			drm_info(drm,
- 				 "Applying panel backlight quirk, brightness_mask: 0x%X\n",
- 				 panel_backlight_quirk->brightness_mask);
- 			caps->brightness_mask =3D
- 				panel_backlight_quirk->brightness_mask;
- 		}
- 	}
- }
-=20
- DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))
-=20
- void amdgpu_dm_update_connector_after_detect(
- 		struct amdgpu_dm_connector *aconnector)
- {
- 	struct drm_connector *connector =3D &aconnector->base;
- 	struct dc_sink *sink __free(sink_release) =3D NULL;
- 	struct drm_device *dev =3D connector->dev;
-=20
- 	/* MST handled by drm_mst framework */
- 	if (aconnector->mst_mgr.mst_state =3D=3D true)
- 		return;
-=20
- 	sink =3D aconnector->dc_link->local_sink;
- 	if (sink)
- 		dc_sink_retain(sink);
-=20
- 	/*
- 	 * Edid mgmt connector gets first update only in mode_valid hook and then
- 	 * the connector sink is set to either fake or physical sink depends on =
link status.
- 	 * Skip if already done during boot.
- 	 */
- 	if (aconnector->base.force !=3D DRM_FORCE_UNSPECIFIED
- 			&& aconnector->dc_em_sink) {
-=20
- 		/*
- 		 * For S3 resume with headless use eml_sink to fake stream
- 		 * because on resume connector->sink is set to NULL
- 		 */
- 		guard(mutex)(&dev->mode_config.mutex);
-=20
- 		if (sink) {
- 			if (aconnector->dc_sink) {
- 				amdgpu_dm_update_freesync_caps(connector, NULL, true);
- 				/*
- 				 * retain and release below are used to
- 				 * bump up refcount for sink because the link doesn't point
- 				 * to it anymore after disconnect, so on next crtc to connector
- 				 * reshuffle by UMD we will get into unwanted dc_sink release
- 				 */
- 				dc_sink_release(aconnector->dc_sink);
- 			}
- 			aconnector->dc_sink =3D sink;
- 			dc_sink_retain(aconnector->dc_sink);
- 			amdgpu_dm_update_freesync_caps(connector,
- 					aconnector->drm_edid, true);
- 		} else {
- 			amdgpu_dm_update_freesync_caps(connector, NULL, true);
- 			if (!aconnector->dc_sink) {
- 				aconnector->dc_sink =3D aconnector->dc_em_sink;
- 				dc_sink_retain(aconnector->dc_sink);
- 			}
- 		}
-=20
- 		return;
- 	}
-=20
- 	/*
- 	 * TODO: temporary guard to look for proper fix
- 	 * if this sink is MST sink, we should not do anything
- 	 */
- 	if (sink && sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST)
- 		return;
-=20
- 	if (aconnector->dc_sink =3D=3D sink) {
- 		/*
- 		 * We got a DP short pulse (Link Loss, DP CTS, etc...).
- 		 * Do nothing!!
- 		 */
- 		drm_dbg_kms(dev, "DCHPD: connector_id=3D%d: dc_sink didn't change.\n",
- 				 aconnector->connector_id);
- 		return;
- 	}
-=20
- 	drm_dbg_kms(dev, "DCHPD: connector_id=3D%d: Old sink=3D%p New sink=3D%p\=
n",
- 		    aconnector->connector_id, aconnector->dc_sink, sink);
-=20
- 	/* When polling, DRM has already locked the mutex for us. */
- 	if (!drm_kms_helper_is_poll_worker())
- 		mutex_lock(&dev->mode_config.mutex);
-=20
- 	/*
- 	 * 1. Update status of the drm connector
- 	 * 2. Send an event and let userspace tell us what to do
- 	 */
- 	if (sink) {
- 		/*
- 		 * TODO: check if we still need the S3 mode update workaround.
- 		 * If yes, put it here.
- 		 */
- 		if (aconnector->dc_sink) {
- 			amdgpu_dm_update_freesync_caps(connector, NULL, true);
- 			dc_sink_release(aconnector->dc_sink);
- 		}
-=20
- 		aconnector->dc_sink =3D sink;
- 		dc_sink_retain(aconnector->dc_sink);
- 		drm_edid_free(aconnector->drm_edid);
- 		aconnector->drm_edid =3D NULL;
- 		if (sink->dc_edid.length =3D=3D 0) {
- 			hdmi_cec_unset_edid(aconnector);
- 			if (aconnector->dc_link->aux_mode) {
- 				drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
- 			}
- 		} else {
- 			const struct edid *edid =3D (const struct edid *)sink->dc_edid.raw_edi=
d;
-=20
- 			aconnector->drm_edid =3D drm_edid_alloc(edid, sink->dc_edid.length);
- 			drm_edid_connector_update(connector, aconnector->drm_edid);
-=20
- 			hdmi_cec_set_edid(aconnector);
- 			if (aconnector->dc_link->aux_mode)
- 				drm_dp_cec_attach(&aconnector->dm_dp_aux.aux,
- 						  connector->display_info.source_physical_address);
- 		}
-=20
- 		if (!aconnector->timing_requested) {
- 			aconnector->timing_requested =3D
- 				kzalloc_obj(struct dc_crtc_timing);
- 			if (!aconnector->timing_requested)
- 				drm_err(dev,
- 					"failed to create aconnector->requested_timing\n");
- 		}
-=20
- 		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid, true);
- 		update_connector_ext_caps(aconnector);
- 		dm_set_panel_type(aconnector);
- 	} else {
- 		hdmi_cec_unset_edid(aconnector);
- 		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
- 		amdgpu_dm_update_freesync_caps(connector, NULL, true);
- 		aconnector->num_modes =3D 0;
- 		dc_sink_release(aconnector->dc_sink);
- 		aconnector->dc_sink =3D NULL;
- 		drm_edid_free(aconnector->drm_edid);
- 		aconnector->drm_edid =3D NULL;
- 		kfree(aconnector->timing_requested);
- 		aconnector->timing_requested =3D NULL;
- 		/* Set CP to DESIRED if it was ENABLED, so we can re-enable it again on=
 hotplug */
- 		if (connector->state->content_protection =3D=3D DRM_MODE_CONTENT_PROTEC=
TION_ENABLED)
- 			connector->state->content_protection =3D DRM_MODE_CONTENT_PROTECTION_D=
ESIRED;
- 	}
-=20
- 	update_subconnector_property(aconnector);
-=20
- 	/* When polling, the mutex will be unlocked for us by DRM. */
- 	if (!drm_kms_helper_is_poll_worker())
- 		mutex_unlock(&dev->mode_config.mutex);
- }
-=20
- static bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_=
sink *sink2)
- {
- 	if (!sink1 || !sink2)
- 		return false;
- 	if (sink1->sink_signal !=3D sink2->sink_signal)
- 		return false;
-=20
- 	if (sink1->dc_edid.length !=3D sink2->dc_edid.length)
- 		return false;
-=20
- 	if (memcmp(sink1->dc_edid.raw_edid, sink2->dc_edid.raw_edid,
- 		   sink1->dc_edid.length) !=3D 0)
- 		return false;
- 	return true;
- }
-=20
-=20
- /**
-  * DOC: hdmi_hpd_debounce_work
-  *
-  * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles =
HPD
-  * (such as during power save transitions), this delay determines how lon=
g to
-  * wait before processing the HPD event. This allows distinguishing betwe=
en a
-  * physical unplug (>hdmi_hpd_debounce_delay)
-  * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
-  *
-  * If the toggle is less than this delay, the driver compares sink capabi=
lities
-  * and permits a hotplug event if they changed.
-  *
-  * The default value of 1500ms was chosen based on experimental testing w=
ith
-  * various monitors that exhibit spontaneous HPD toggling behavior.
-  */
- static void hdmi_hpd_debounce_work(struct work_struct *work)
- {
- 	struct amdgpu_dm_connector *aconnector =3D
- 		container_of(to_delayed_work(work), struct amdgpu_dm_connector,
- 			     hdmi_hpd_debounce_work);
- 	struct drm_connector *connector =3D &aconnector->base;
- 	struct drm_device *dev =3D connector->dev;
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	struct dc *dc =3D aconnector->dc_link->ctx->dc;
- 	bool fake_reconnect =3D false;
- 	bool reallow_idle =3D false;
- 	bool ret =3D false;
- 	guard(mutex)(&aconnector->hpd_lock);
-=20
- 	/* Re-detect the display */
- 	scoped_guard(mutex, &adev->dm.dc_lock) {
- 		if (dc->caps.ips_support && dc->ctx->dmub_srv->idle_allowed) {
- 			dc_allow_idle_optimizations(dc, false);
- 			reallow_idle =3D true;
- 		}
- 		ret =3D dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
- 	}
-=20
- 	if (ret) {
- 		/* Apply workaround delay for certain panels */
- 		apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
- 		/* Compare sinks to determine if this was a spontaneous HPD toggle */
- 		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hdmi_p=
rev_sink)) {
- 			/*
- 			* Sinks match - this was a spontaneous HDMI HPD toggle.
- 			*/
- 			drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after debounce, internal re=
-enable\n");
- 			fake_reconnect =3D true;
- 		}
-=20
- 		/* Update connector state */
- 		amdgpu_dm_update_connector_after_detect(aconnector);
-=20
- 		drm_modeset_lock_all(dev);
- 		dm_restore_drm_connector_state(dev, connector);
- 		drm_modeset_unlock_all(dev);
-=20
- 		/* Only notify OS if sink actually changed */
- 		if (!fake_reconnect && aconnector->base.force =3D=3D DRM_FORCE_UNSPECIF=
IED)
- 			drm_kms_helper_hotplug_event(dev);
- 	}
-=20
- 	/* Release the cached sink reference */
- 	if (aconnector->hdmi_prev_sink) {
- 		dc_sink_release(aconnector->hdmi_prev_sink);
- 		aconnector->hdmi_prev_sink =3D NULL;
- 	}
-=20
- 	scoped_guard(mutex, &adev->dm.dc_lock) {
- 		if (reallow_idle && dc->caps.ips_support)
- 			dc_allow_idle_optimizations(dc, true);
- 	}
- }
-=20
- static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
- {
- 	struct drm_connector *connector =3D &aconnector->base;
- 	struct drm_device *dev =3D connector->dev;
- 	enum dc_connection_type new_connection_type =3D dc_connection_none;
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	struct dm_connector_state *dm_con_state =3D to_dm_connector_state(connec=
tor->state);
- 	struct dc *dc =3D aconnector->dc_link->ctx->dc;
- 	bool ret =3D false;
- 	bool debounce_required =3D false;
-=20
- 	if (adev->dm.disable_hpd_irq)
- 		return;
-=20
- 	/*
- 	 * In case of failure or MST no need to update connector status or notif=
y the OS
- 	 * since (for MST case) MST does this in its own context.
- 	 */
- 	guard(mutex)(&aconnector->hpd_lock);
-=20
- 	if (adev->dm.hdcp_workqueue) {
- 		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_i=
ndex);
- 		dm_con_state->update_hdcp =3D true;
- 	}
- 	if (aconnector->fake_enable)
- 		aconnector->fake_enable =3D false;
-=20
- 	aconnector->timing_changed =3D false;
-=20
- 	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection=
_type))
- 		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
-=20
- 	/*
- 	 * Check for HDMI disconnect with debounce enabled.
- 	 */
- 	debounce_required =3D (aconnector->hdmi_hpd_debounce_delay_ms > 0 &&
- 			      dc_is_hdmi_signal(aconnector->dc_link->connector_signal) &&
- 			      new_connection_type =3D=3D dc_connection_none &&
- 			      aconnector->dc_link->local_sink !=3D NULL);
-=20
- 	if (aconnector->base.force && new_connection_type =3D=3D dc_connection_n=
one) {
- 		emulated_link_detect(aconnector->dc_link);
-=20
- 		drm_modeset_lock_all(dev);
- 		dm_restore_drm_connector_state(dev, connector);
- 		drm_modeset_unlock_all(dev);
-=20
- 		if (aconnector->base.force =3D=3D DRM_FORCE_UNSPECIFIED)
- 			drm_kms_helper_connector_hotplug_event(connector);
- 	} else if (debounce_required) {
- 		/*
- 		 * HDMI disconnect detected - schedule delayed work instead of
- 		 * processing immediately. This allows us to coalesce spurious
- 		 * HDMI signals from physical unplugs.
- 		 */
- 		drm_dbg_kms(dev, "HDMI HPD: Disconnect detected, scheduling debounce wo=
rk (%u ms)\n",
- 			    aconnector->hdmi_hpd_debounce_delay_ms);
-=20
- 		/* Cache the current sink for later comparison */
- 		if (aconnector->hdmi_prev_sink)
- 			dc_sink_release(aconnector->hdmi_prev_sink);
- 		aconnector->hdmi_prev_sink =3D aconnector->dc_link->local_sink;
- 		if (aconnector->hdmi_prev_sink)
- 			dc_sink_retain(aconnector->hdmi_prev_sink);
-=20
- 		/* Schedule delayed detection. */
- 		if (mod_delayed_work(system_percpu_wq,
- 				 &aconnector->hdmi_hpd_debounce_work,
- 				 msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
- 			drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
-=20
- 	} else {
-=20
- 		/* If the aconnector->hdmi_hpd_debounce_work is scheduled, exit early */
- 		if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
- 			return;
-=20
- 		scoped_guard(mutex, &adev->dm.dc_lock) {
- 			dc_exit_ips_for_hw_access(dc);
- 			ret =3D dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
- 		}
- 		if (ret) {
- 			/* w/a delay for certain panels */
- 			apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
- 			amdgpu_dm_update_connector_after_detect(aconnector);
-=20
- 			drm_modeset_lock_all(dev);
- 			dm_restore_drm_connector_state(dev, connector);
- 			drm_modeset_unlock_all(dev);
-=20
- 			if (aconnector->base.force =3D=3D DRM_FORCE_UNSPECIFIED)
- 				drm_kms_helper_connector_hotplug_event(connector);
- 		}
- 	}
- }
-=20
- static void handle_hpd_irq(void *param)
- {
- 	struct amdgpu_dm_connector *aconnector =3D (struct amdgpu_dm_connector *=
)param;
-=20
- 	handle_hpd_irq_helper(aconnector);
-=20
- }
-=20
- static void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, stru=
ct hpd_rx_irq_offload_work_queue *offload_wq,
- 							union hpd_irq_data hpd_irq_data)
- {
- 	struct hpd_rx_irq_offload_work *offload_work =3D kzalloc_obj(*offload_wo=
rk);
-=20
- 	if (!offload_work) {
- 		drm_err(adev_to_drm(adev), "Failed to allocate hpd_rx_irq_offload_work.=
\n");
- 		return;
- 	}
-=20
- 	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
- 	offload_work->data =3D hpd_irq_data;
- 	offload_work->offload_wq =3D offload_wq;
- 	offload_work->adev =3D adev;
-=20
- 	queue_work(offload_wq->wq, &offload_work->work);
- 	drm_dbg_kms(adev_to_drm(adev), "queue work to handle hpd_rx offload work=
");
- }
-=20
- static void handle_hpd_rx_irq(void *param)
- {
- 	struct amdgpu_dm_connector *aconnector =3D (struct amdgpu_dm_connector *=
)param;
- 	struct drm_connector *connector =3D &aconnector->base;
- 	struct drm_device *dev =3D connector->dev;
- 	struct dc_link *dc_link =3D aconnector->dc_link;
- 	bool is_mst_root_connector =3D aconnector->mst_mgr.mst_state;
- 	bool result =3D false;
- 	enum dc_connection_type new_connection_type =3D dc_connection_none;
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	union hpd_irq_data hpd_irq_data;
- 	bool link_loss =3D false;
- 	bool has_left_work =3D false;
- 	int idx =3D dc_link->link_index;
- 	struct hpd_rx_irq_offload_work_queue *offload_wq =3D &adev->dm.hpd_rx_of=
fload_wq[idx];
- 	struct dc *dc =3D aconnector->dc_link->ctx->dc;
-=20
- 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
-=20
- 	if (adev->dm.disable_hpd_irq)
- 		return;
-=20
- 	/*
- 	 * TODO:Temporary add mutex to protect hpd interrupt not have a gpio
- 	 * conflict, after implement i2c helper, this mutex should be
- 	 * retired.
- 	 */
- 	mutex_lock(&aconnector->hpd_lock);
-=20
- 	result =3D dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data,
- 						&link_loss, true, &has_left_work);
-=20
- 	if (!has_left_work)
- 		goto out;
-=20
- 	if (hpd_irq_data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
- 		schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
- 		goto out;
- 	}
-=20
- 	if (dc_link_dp_allow_hpd_rx_irq(dc_link)) {
- 		if (hpd_irq_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
- 			hpd_irq_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
- 			bool skip =3D false;
-=20
- 			/*
- 			 * DOWN_REP_MSG_RDY is also handled by polling method
- 			 * mgr->cbs->poll_hpd_irq()
- 			 */
- 			spin_lock(&offload_wq->offload_lock);
- 			skip =3D offload_wq->is_handling_mst_msg_rdy_event;
-=20
- 			if (!skip)
- 				offload_wq->is_handling_mst_msg_rdy_event =3D true;
-=20
- 			spin_unlock(&offload_wq->offload_lock);
-=20
- 			if (!skip)
- 				schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
-=20
- 			goto out;
- 		}
-=20
- 		if (link_loss) {
- 			bool skip =3D false;
-=20
- 			spin_lock(&offload_wq->offload_lock);
- 			skip =3D offload_wq->is_handling_link_loss;
-=20
- 			if (!skip)
- 				offload_wq->is_handling_link_loss =3D true;
-=20
- 			spin_unlock(&offload_wq->offload_lock);
-=20
- 			if (!skip)
- 				schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
-=20
- 			goto out;
- 		}
- 	}
-=20
- out:
- 	if (result && !is_mst_root_connector) {
- 		/* Downstream Port status changed. */
- 		if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
- 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
-=20
- 		if (aconnector->base.force && new_connection_type =3D=3D dc_connection_=
none) {
- 			emulated_link_detect(dc_link);
-=20
- 			if (aconnector->fake_enable)
- 				aconnector->fake_enable =3D false;
-=20
- 			amdgpu_dm_update_connector_after_detect(aconnector);
-=20
-=20
- 			drm_modeset_lock_all(dev);
- 			dm_restore_drm_connector_state(dev, connector);
- 			drm_modeset_unlock_all(dev);
-=20
- 			drm_kms_helper_connector_hotplug_event(connector);
- 		} else {
- 			bool ret =3D false;
-=20
- 			mutex_lock(&adev->dm.dc_lock);
- 			dc_exit_ips_for_hw_access(dc);
- 			ret =3D dc_link_detect(dc_link, DETECT_REASON_HPDRX);
- 			mutex_unlock(&adev->dm.dc_lock);
-=20
- 			if (ret) {
- 				if (aconnector->fake_enable)
- 					aconnector->fake_enable =3D false;
-=20
- 				amdgpu_dm_update_connector_after_detect(aconnector);
-=20
- 				drm_modeset_lock_all(dev);
- 				dm_restore_drm_connector_state(dev, connector);
- 				drm_modeset_unlock_all(dev);
-=20
- 				drm_kms_helper_connector_hotplug_event(connector);
- 			}
- 		}
- 	}
- 	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
- 		if (adev->dm.hdcp_workqueue)
- 			hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
- 	}
-=20
- 	if (dc_link->type !=3D dc_connection_mst_branch)
- 		drm_dp_cec_irq(&aconnector->dm_dp_aux.aux);
-=20
- 	mutex_unlock(&aconnector->hpd_lock);
- }
-=20
- static int register_hpd_handlers(struct amdgpu_device *adev)
- {
- 	struct drm_device *dev =3D adev_to_drm(adev);
- 	struct drm_connector *connector;
- 	struct amdgpu_dm_connector *aconnector;
- 	const struct dc_link *dc_link;
- 	struct dc_interrupt_params int_params =3D {0};
-=20
- 	int_params.requested_polarity =3D INTERRUPT_POLARITY_DEFAULT;
- 	int_params.current_polarity =3D INTERRUPT_POLARITY_DEFAULT;
-=20
- 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
- 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD,
- 			dmub_hpd_callback, true)) {
- 			drm_err(adev_to_drm(adev), "fail to register dmub hpd callback");
- 			return -EINVAL;
- 		}
-=20
- 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ,
- 			dmub_hpd_callback, true)) {
- 			drm_err(adev_to_drm(adev), "fail to register dmub hpd callback");
- 			return -EINVAL;
- 		}
-=20
- 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_SENSE_NO=
TIFY,
- 			dmub_hpd_sense_callback, true)) {
- 			drm_err(adev_to_drm(adev), "fail to register dmub hpd sense callback");
- 			return -EINVAL;
- 		}
- 	}
-=20
- 	list_for_each_entry(connector,
- 			&dev->mode_config.connector_list, head)	{
-=20
- 		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 			continue;
-=20
- 		aconnector =3D to_amdgpu_dm_connector(connector);
- 		dc_link =3D aconnector->dc_link;
-=20
- 		if (dc_link->irq_source_hpd !=3D DC_IRQ_SOURCE_INVALID) {
- 			int_params.int_context =3D INTERRUPT_LOW_IRQ_CONTEXT;
- 			int_params.irq_source =3D dc_link->irq_source_hpd;
-=20
- 			if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
- 				int_params.irq_source  < DC_IRQ_SOURCE_HPD1 ||
- 				int_params.irq_source  > DC_IRQ_SOURCE_HPD6) {
- 				drm_err(adev_to_drm(adev), "Failed to register hpd irq!\n");
- 				return -EINVAL;
- 			}
-=20
- 			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
- 				handle_hpd_irq, (void *) aconnector))
- 				return -ENOMEM;
- 		}
-=20
- 		if (dc_link->irq_source_hpd_rx !=3D DC_IRQ_SOURCE_INVALID) {
-=20
- 			/* Also register for DP short pulse (hpd_rx). */
- 			int_params.int_context =3D INTERRUPT_LOW_IRQ_CONTEXT;
- 			int_params.irq_source =3D	dc_link->irq_source_hpd_rx;
-=20
- 			if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
- 				int_params.irq_source  < DC_IRQ_SOURCE_HPD1RX ||
- 				int_params.irq_source  > DC_IRQ_SOURCE_HPD6RX) {
- 				drm_err(adev_to_drm(adev), "Failed to register hpd rx irq!\n");
- 				return -EINVAL;
- 			}
-=20
- 			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
- 				handle_hpd_rx_irq, (void *) aconnector))
- 				return -ENOMEM;
- 		}
- 	}
- 	return 0;
- }
-=20
- /* Register IRQ sources and initialize IRQ callbacks */
- static int dce110_register_irq_handlers(struct amdgpu_device *adev)
- {
- 	struct dc *dc =3D adev->dm.dc;
- 	struct common_irq_params *c_irq_params;
- 	struct dc_interrupt_params int_params =3D {0};
- 	int r;
- 	int i;
- 	unsigned int src_id;
- 	unsigned int client_id =3D AMDGPU_IRQ_CLIENTID_LEGACY;
- 	/* Use different interrupts for VBLANK on DCE 6 vs. newer. */
- 	const unsigned int vblank_d1 =3D
- 		adev->dm.dc->ctx->dce_version >=3D DCE_VERSION_8_0
- 		? VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0 : 1;
-=20
- 	if (adev->family >=3D AMDGPU_FAMILY_AI)
- 		client_id =3D SOC15_IH_CLIENTID_DCE;
-=20
- 	int_params.requested_polarity =3D INTERRUPT_POLARITY_DEFAULT;
- 	int_params.current_polarity =3D INTERRUPT_POLARITY_DEFAULT;
-=20
- 	/*
- 	 * Actions of amdgpu_irq_add_id():
- 	 * 1. Register a set() function with base driver.
- 	 *    Base driver will call set() function to enable/disable an
- 	 *    interrupt in DC hardware.
- 	 * 2. Register amdgpu_dm_irq_handler().
- 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
- 	 *    coming from DC hardware.
- 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
- 	 *    for acknowledging and handling.
- 	 */
-=20
- 	/* Use VBLANK interrupt */
- 	for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
- 		src_id =3D vblank_d1 + i;
- 		r =3D amdgpu_irq_add_id(adev, client_id, src_id, &adev->crtc_irq);
- 		if (r) {
- 			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
- 			return r;
- 		}
-=20
- 		int_params.int_context =3D INTERRUPT_HIGH_IRQ_CONTEXT;
- 		int_params.irq_source =3D
- 			dc_interrupt_to_irq_source(dc, src_id, 0);
-=20
- 		if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
- 			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
- 			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
- 			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
- 			return -EINVAL;
- 		}
-=20
- 		c_irq_params =3D &adev->dm.vblank_params[int_params.irq_source - DC_IRQ=
_SOURCE_VBLANK1];
-=20
- 		c_irq_params->adev =3D adev;
- 		c_irq_params->irq_src =3D int_params.irq_source;
-=20
- 		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
- 			dm_crtc_high_irq, c_irq_params))
- 			return -ENOMEM;
- 	}
-=20
- 	if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
- 		/* Use VUPDATE interrupt */
- 		for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
- 			src_id =3D VISLANDS30_IV_SRCID_D1_V_UPDATE_INT + i * 2;
- 			r =3D amdgpu_irq_add_id(adev, client_id, src_id, &adev->vupdate_irq);
- 			if (r) {
- 				drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
- 				return r;
- 			}
-=20
- 			int_params.int_context =3D INTERRUPT_HIGH_IRQ_CONTEXT;
- 			int_params.irq_source =3D
- 				dc_interrupt_to_irq_source(dc, src_id, 0);
-=20
- 			if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
- 				int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
- 				int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
- 				drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
- 				return -EINVAL;
- 			}
-=20
- 			c_irq_params =3D &adev->dm.vupdate_params[
- 				int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
- 			c_irq_params->adev =3D adev;
- 			c_irq_params->irq_src =3D int_params.irq_source;
-=20
- 			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
- 				dm_vupdate_high_irq, c_irq_params))
- 				return -ENOMEM;
- 		}
- 	}
-=20
- 	/* Use GRPH_PFLIP interrupt */
- 	for (i =3D VISLANDS30_IV_SRCID_D1_GRPH_PFLIP;
- 			i <=3D VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i +=3D 2) {
- 		r =3D amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
- 		if (r) {
- 			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
- 			return r;
- 		}
-=20
- 		int_params.int_context =3D INTERRUPT_HIGH_IRQ_CONTEXT;
- 		int_params.irq_source =3D
- 			dc_interrupt_to_irq_source(dc, i, 0);
-=20
- 		if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
- 			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
- 			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
- 			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
- 			return -EINVAL;
- 		}
-=20
- 		c_irq_params =3D &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_=
SOURCE_PFLIP_FIRST];
-=20
- 		c_irq_params->adev =3D adev;
- 		c_irq_params->irq_src =3D int_params.irq_source;
-=20
- 		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
- 			dm_pflip_high_irq, c_irq_params))
- 			return -ENOMEM;
- 	}
-=20
- 	/* HPD */
- 	r =3D amdgpu_irq_add_id(adev, client_id,
- 			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
- 	if (r) {
- 		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
- 		return r;
- 	}
-=20
- 	r =3D register_hpd_handlers(adev);
-=20
- 	return r;
- }
-=20
- /* Register IRQ sources and initialize IRQ callbacks */
- static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
- {
- 	struct dc *dc =3D adev->dm.dc;
- 	struct common_irq_params *c_irq_params;
- 	struct dc_interrupt_params int_params =3D {0};
- 	int r;
- 	int i;
- #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
- 	static const unsigned int vrtl_int_srcid[] =3D {
- 		DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL,
- 		DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL,
- 		DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL,
- 		DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL,
- 		DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL,
- 		DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL
- 	};
- #endif
-=20
- 	int_params.requested_polarity =3D INTERRUPT_POLARITY_DEFAULT;
- 	int_params.current_polarity =3D INTERRUPT_POLARITY_DEFAULT;
-=20
- 	/*
- 	 * Actions of amdgpu_irq_add_id():
- 	 * 1. Register a set() function with base driver.
- 	 *    Base driver will call set() function to enable/disable an
- 	 *    interrupt in DC hardware.
- 	 * 2. Register amdgpu_dm_irq_handler().
- 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
- 	 *    coming from DC hardware.
- 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
- 	 *    for acknowledging and handling.
- 	 */
-=20
- 	/* Use otg vertical line interrupt */
- #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
- 	for (i =3D 0; i <=3D adev->mode_info.num_crtc - 1; i++) {
- 		r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE,
- 				vrtl_int_srcid[i], &adev->vline0_irq);
-=20
- 		if (r) {
- 			drm_err(adev_to_drm(adev), "Failed to add vline0 irq id!\n");
- 			return r;
- 		}
-=20
- 		int_params.int_context =3D INTERRUPT_HIGH_IRQ_CONTEXT;
- 		int_params.irq_source =3D
- 			dc_interrupt_to_irq_source(dc, vrtl_int_srcid[i], 0);
-=20
- 		if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
- 			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE0 ||
- 			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE0) {
- 			drm_err(adev_to_drm(adev), "Failed to register vline0 irq!\n");
- 			return -EINVAL;
- 		}
-=20
- 		c_irq_params =3D &adev->dm.vline0_params[int_params.irq_source
- 					- DC_IRQ_SOURCE_DC1_VLINE0];
-=20
- 		c_irq_params->adev =3D adev;
- 		c_irq_params->irq_src =3D int_params.irq_source;
-=20
- 		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
- 			dm_dcn_vertical_interrupt0_high_irq,
- 			c_irq_params))
- 			return -ENOMEM;
- 	}
- #endif
-=20
- 	/* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond to
- 	 * the regular VUPDATE interrupt on DCE. We want DC_IRQ_SOURCE_VUPDATEx
- 	 * to trigger at end of each vblank, regardless of state of the lock,
- 	 * matching DCE behaviour.
- 	 */
- 	for (i =3D DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;
- 	     i <=3D DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT + adev->=
mode_info.num_crtc - 1;
- 	     i++) {
- 		r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->vupdate_=
irq);
-=20
- 		if (r) {
- 			drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
- 			return r;
- 		}
-=20
- 		int_params.int_context =3D INTERRUPT_HIGH_IRQ_CONTEXT;
- 		int_params.irq_source =3D
- 			dc_interrupt_to_irq_source(dc, i, 0);
-=20
- 		if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
- 			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
- 			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
- 			drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
- 			return -EINVAL;
- 		}
-=20
- 		c_irq_params =3D &adev->dm.vupdate_params[int_params.irq_source - DC_IR=
Q_SOURCE_VUPDATE1];
-=20
- 		c_irq_params->adev =3D adev;
- 		c_irq_params->irq_src =3D int_params.irq_source;
-=20
- 		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
- 			dm_vupdate_high_irq, c_irq_params))
- 			return -ENOMEM;
- 	}
-=20
- 	/* HPD */
- 	r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_=
HPD1_INT,
- 			&adev->hpd_irq);
- 	if (r) {
- 		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
- 		return r;
- 	}
-=20
- 	r =3D register_hpd_handlers(adev);
-=20
- 	return r;
- }
- /* Register Outbox IRQ sources and initialize IRQ callbacks */
- static int register_outbox_irq_handlers(struct amdgpu_device *adev)
- {
- 	struct dc *dc =3D adev->dm.dc;
- 	struct common_irq_params *c_irq_params;
- 	struct dc_interrupt_params int_params =3D {0};
- 	int r, i;
-=20
- 	int_params.requested_polarity =3D INTERRUPT_POLARITY_DEFAULT;
- 	int_params.current_polarity =3D INTERRUPT_POLARITY_DEFAULT;
-=20
- 	r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DMC=
UB_OUTBOX_LOW_PRIORITY_READY_INT,
- 			&adev->dmub_outbox_irq);
- 	if (r) {
- 		drm_err(adev_to_drm(adev), "Failed to add outbox irq id!\n");
- 		return r;
- 	}
-=20
- 	if (dc->ctx->dmub_srv) {
- 		i =3D DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT;
- 		int_params.int_context =3D INTERRUPT_LOW_IRQ_CONTEXT;
- 		int_params.irq_source =3D
- 		dc_interrupt_to_irq_source(dc, i, 0);
-=20
- 		c_irq_params =3D &adev->dm.dmub_outbox_params[0];
-=20
- 		c_irq_params->adev =3D adev;
- 		c_irq_params->irq_src =3D int_params.irq_source;
-=20
- 		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
- 			dm_dmub_outbox1_low_irq, c_irq_params))
- 			return -ENOMEM;
- 	}
-=20
- 	return 0;
- }
-=20
  /*
   * Acquires the lock for the atomic state object and returns
   * the new atomic state.
@@@ -5079,7 -2133,7 +2138,7 @@@ int dm_atomic_get_state(struct drm_atom
  	return 0;
  }
 =20
- static struct dm_atomic_state *
+ STATIC_IFN_KUNIT struct dm_atomic_state *
  dm_atomic_get_new_state(struct drm_atomic_commit *state)
  {
  	struct drm_device *dev =3D state->dev;
@@@ -5096,6 -2150,7 +2155,7 @@@
 =20
  	return NULL;
  }
+ EXPORT_IF_KUNIT(dm_atomic_get_new_state);
 =20
  static struct drm_private_state *
  dm_atomic_duplicate_state(struct drm_private_obj *obj)
@@@ -5121,8 -2176,8 +2181,8 @@@
  	return &new_state->base;
  }
 =20
- static void dm_atomic_destroy_state(struct drm_private_obj *obj,
- 				    struct drm_private_state *state)
+ STATIC_IFN_KUNIT void dm_atomic_destroy_state(struct drm_private_obj *obj,
+ 					      struct drm_private_state *state)
  {
  	struct dm_atomic_state *dm_state =3D to_dm_atomic_state(state);
 =20
@@@ -5131,6 -2186,7 +2191,7 @@@
 =20
  	kfree(dm_state);
  }
+ EXPORT_IF_KUNIT(dm_atomic_destroy_state);
 =20
  static struct drm_private_state *
  dm_atomic_create_state(struct drm_private_obj *obj)
@@@ -5202,420 -2258,6 +2263,6 @@@ static int amdgpu_dm_mode_config_init(s
  	return 0;
  }
 =20
- #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
- #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
- #define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_D=
M_DEFAULT_MIN_BACKLIGHT) / 2)
- #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
-=20
- void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
- 				     int bl_idx)
- {
- 	struct amdgpu_dm_backlight_caps *caps =3D &dm->backlight_caps[bl_idx];
-=20
- 	if (caps->caps_valid)
- 		return;
-=20
- #if defined(CONFIG_ACPI)
- 	amdgpu_acpi_get_backlight_caps(caps);
-=20
- 	/* validate the firmware value is sane */
- 	if (caps->caps_valid) {
- 		int spread =3D caps->max_input_signal - caps->min_input_signal;
-=20
- 		if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
- 		    caps->min_input_signal < 0 ||
- 		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
- 		    spread < AMDGPU_DM_MIN_SPREAD) {
- 			drm_dbg_kms(adev_to_drm(dm->adev), "DM: Invalid backlight caps: min=3D=
%d, max=3D%d\n",
- 				      caps->min_input_signal, caps->max_input_signal);
- 			caps->caps_valid =3D false;
- 		}
- 	}
-=20
- 	if (!caps->caps_valid) {
- 		caps->min_input_signal =3D AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
- 		caps->max_input_signal =3D AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
- 		caps->caps_valid =3D true;
- 	}
- #else
- 	if (caps->aux_support)
- 		return;
-=20
- 	caps->min_input_signal =3D AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
- 	caps->max_input_signal =3D AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
- 	caps->caps_valid =3D true;
- #endif
- }
-=20
- static int get_brightness_range(const struct amdgpu_dm_backlight_caps *ca=
ps,
- 				unsigned int *min, unsigned int *max)
- {
- 	if (!caps)
- 		return 0;
-=20
- 	if (caps->aux_support) {
- 		// Firmware limits are in nits, DC API wants millinits.
- 		*max =3D 1000 * caps->aux_max_input_signal;
- 		*min =3D 1000 * caps->aux_min_input_signal;
- 	} else {
- 		// Firmware limits are 8-bit, PWM control is 16-bit.
- 		*max =3D 0x101 * caps->max_input_signal;
- 		*min =3D 0x101 * caps->min_input_signal;
- 	}
- 	return 1;
- }
-=20
- /* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
- static inline u32 scale_input_to_fw(int min, int max, u64 input)
- {
- 	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
- }
-=20
- /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
- static inline u32 scale_fw_to_input(int min, int max, u64 input)
- {
- 	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LE=
VEL);
- }
-=20
- static void convert_custom_brightness(const struct amdgpu_dm_backlight_ca=
ps *caps,
- 				      unsigned int min, unsigned int max,
- 				      uint32_t *user_brightness)
- {
- 	u32 brightness =3D scale_input_to_fw(min, max, *user_brightness);
- 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
- 	int left, right;
-=20
- 	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
- 		return;
-=20
- 	if (!caps->data_points)
- 		return;
-=20
- 	/*
- 	 * Handle the case where brightness is below the first data point
- 	 * Interpolate between (0,0) and (first_signal, first_lum)
- 	 */
- 	if (brightness < caps->luminance_data[0].input_signal) {
- 		lum =3D DIV_ROUND_CLOSEST(caps->luminance_data[0].luminance * brightnes=
s,
- 					caps->luminance_data[0].input_signal);
- 		goto scale;
- 	}
-=20
- 	left =3D 0;
- 	right =3D caps->data_points - 1;
- 	while (left <=3D right) {
- 		int mid =3D left + (right - left) / 2;
- 		u8 signal =3D caps->luminance_data[mid].input_signal;
-=20
- 		/* Exact match found */
- 		if (signal =3D=3D brightness) {
- 			lum =3D caps->luminance_data[mid].luminance;
- 			goto scale;
- 		}
-=20
- 		if (signal < brightness)
- 			left =3D mid + 1;
- 		else
- 			right =3D mid - 1;
- 	}
-=20
- 	/* verify bound */
- 	if (left >=3D caps->data_points)
- 		left =3D caps->data_points - 1;
-=20
- 	/* At this point, left > right */
- 	lower_signal =3D caps->luminance_data[right].input_signal;
- 	upper_signal =3D caps->luminance_data[left].input_signal;
- 	lower_lum =3D caps->luminance_data[right].luminance;
- 	upper_lum =3D caps->luminance_data[left].luminance;
-=20
- 	/* interpolate */
- 	if (right =3D=3D left || !lower_lum)
- 		lum =3D upper_lum;
- 	else
- 		lum =3D lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
- 						    (brightness - lower_signal),
- 						    upper_signal - lower_signal);
- scale:
- 	*user_brightness =3D scale_fw_to_input(min, max,
- 					     DIV_ROUND_CLOSEST(lum * brightness, 101));
- }
-=20
- static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_=
caps *caps,
- 					uint32_t brightness)
- {
- 	unsigned int min, max;
-=20
- 	if (!get_brightness_range(caps, &min, &max))
- 		return brightness;
-=20
- 	convert_custom_brightness(caps, min, max, &brightness);
-=20
- 	// Rescale 0..max to min..max
- 	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
- }
-=20
- static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_ca=
ps *caps,
- 				      uint32_t brightness)
- {
- 	unsigned int min, max;
-=20
- 	if (!get_brightness_range(caps, &min, &max))
- 		return brightness;
-=20
- 	if (brightness < min)
- 		return 0;
- 	// Rescale min..max to 0..max
- 	return DIV_ROUND_CLOSEST_ULL((u64)max * (brightness - min),
- 				 max - min);
- }
-=20
- static struct dc_stream_state *dm_find_stream_with_link(
- 	struct amdgpu_display_manager *dm,
- 	struct dc_link *link)
- {
- 	struct dc_state *cur_dc_state =3D dm->dc->current_state;
- 	struct dc_stream_state *stream =3D NULL;
- 	int i;
-=20
- 	for (i =3D 0; i < cur_dc_state->stream_count; i++) {
- 		stream =3D cur_dc_state->streams[i];
- 		if (stream->link =3D=3D link)
- 			return stream;
- 	}
-=20
- 	return NULL;
- }
-=20
- static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *=
dm,
- 					 int bl_idx,
- 					 u32 user_brightness)
- {
- 	struct amdgpu_dm_backlight_caps *caps;
- 	struct dc_link *link;
- 	u32 brightness =3D 0;
- 	bool rc =3D false, reallow_idle =3D false;
- 	struct drm_connector *connector;
- 	struct dc_stream_state *stream;
- 	unsigned int min, max;
-=20
- 	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, he=
ad) {
- 		struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(conne=
ctor);
-=20
- 		if (aconnector->bl_idx !=3D bl_idx)
- 			continue;
-=20
- 		/* if connector is off, save the brightness for next time it's on */
- 		if (!aconnector->base.encoder) {
- 			dm->brightness[bl_idx] =3D user_brightness;
- 			dm->actual_brightness[bl_idx] =3D 0;
- 			return;
- 		}
- 	}
-=20
- 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
- 	caps =3D &dm->backlight_caps[bl_idx];
-=20
- 	dm->brightness[bl_idx] =3D user_brightness;
- 	/* update scratch register */
- 	if (bl_idx =3D=3D 0)
- 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightne=
ss[bl_idx]);
- 	brightness =3D convert_brightness_from_user(caps, dm->brightness[bl_idx]=
);
- 	link =3D (struct dc_link *)dm->backlight_link[bl_idx];
-=20
- 	/* Apply brightness quirk */
- 	if (caps->brightness_mask)
- 		brightness |=3D caps->brightness_mask;
-=20
- 	if (trace_amdgpu_dm_brightness_enabled()) {
- 		trace_amdgpu_dm_brightness(__builtin_return_address(0),
- 					   user_brightness,
- 					   brightness,
- 					   caps->aux_support,
- 					   power_supply_is_system_supplied() > 0);
- 	}
-=20
- 	stream =3D dm_find_stream_with_link(dm, link);
- 	if (!stream)
- 		return;
-=20
- 	mutex_lock(&dm->dc_lock);
- 	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
- 		dc_allow_idle_optimizations(dm->dc, false);
- 		reallow_idle =3D true;
- 	}
-=20
- 	if (caps->aux_support) {
- 		rc =3D mod_power_set_backlight_nits(dm->power_module, stream, brightnes=
s,
- 			AUX_BL_DEFAULT_TRANSITION_TIME_MS, false, true);
- 	} else {
- 		/* power module uses millipercent */
- 		get_brightness_range(caps, &min, &max);
- 		brightness =3D DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;
- 		rc =3D mod_power_set_backlight_percent(dm->power_module, stream,
- 						     brightness, 0, false);
- 	}
-=20
- 	/*
- 	 * Some kms clients create a ramped backlight transition effect
- 	 * by rapidly changing the backlight. Yet we must wait on dmcub
- 	 * fw to exit psr/replay before programming backlight. To
- 	 * prevent lag, keep disable psr/replay and let the next atomic
- 	 * flip clear the event.
- 	 *
- 	 * ToDo: use ISM to handle rapidly backlight change
- 	 *
- 	 * Rapidly backlight change is similar to rapidly cursor events,
- 	 * which is now handled by ISM. ISM can delay the event until system
- 	 * is really idle, so we may use ISM to handle backlight change as well.
- 	 */
- 	amdgpu_dm_psr_set_event(dm, stream, true,
- 		psr_event_hw_programming, true);
- 	amdgpu_dm_replay_set_event(dm, stream, true,
- 		replay_event_hw_programming, true);
-=20
- 	if (dm->dc->caps.ips_support && reallow_idle)
- 		dc_allow_idle_optimizations(dm->dc, true);
-=20
- 	mutex_unlock(&dm->dc_lock);
-=20
- 	if (rc)
- 		dm->actual_brightness[bl_idx] =3D user_brightness;
- }
-=20
- static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
- {
- 	struct amdgpu_display_manager *dm =3D bl_get_data(bd);
- 	int i;
-=20
- 	for (i =3D 0; i < dm->num_of_edps; i++) {
- 		if (bd =3D=3D dm->backlight_dev[i])
- 			break;
- 	}
- 	if (i >=3D AMDGPU_DM_MAX_NUM_EDP)
- 		i =3D 0;
- 	amdgpu_dm_backlight_set_level(dm, i, bd->props.brightness);
-=20
- 	return 0;
- }
-=20
- static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *d=
m,
- 					 int bl_idx)
- {
- 	int ret;
- 	struct amdgpu_dm_backlight_caps caps;
- 	struct dc_link *link =3D (struct dc_link *)dm->backlight_link[bl_idx];
-=20
- 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
- 	caps =3D dm->backlight_caps[bl_idx];
-=20
- 	if (caps.aux_support) {
- 		u32 avg, peak;
-=20
- 		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
- 			return dm->brightness[bl_idx];
- 		return convert_brightness_to_user(&caps, avg);
- 	}
-=20
- 	ret =3D dc_link_get_backlight_level(link);
-=20
- 	if (ret =3D=3D DC_ERROR_UNEXPECTED)
- 		return dm->brightness[bl_idx];
-=20
- 	return convert_brightness_to_user(&caps, ret);
- }
-=20
- static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
- {
- 	struct amdgpu_display_manager *dm =3D bl_get_data(bd);
- 	int i;
-=20
- 	for (i =3D 0; i < dm->num_of_edps; i++) {
- 		if (bd =3D=3D dm->backlight_dev[i])
- 			break;
- 	}
- 	if (i >=3D AMDGPU_DM_MAX_NUM_EDP)
- 		i =3D 0;
- 	return amdgpu_dm_backlight_get_level(dm, i);
- }
-=20
- static const struct backlight_ops amdgpu_dm_backlight_ops =3D {
- 	.options =3D BL_CORE_SUSPENDRESUME,
- 	.get_brightness =3D amdgpu_dm_backlight_get_brightness,
- 	.update_status	=3D amdgpu_dm_backlight_update_status,
- };
-=20
- static void
- amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnecto=
r)
- {
- 	struct drm_device *drm =3D aconnector->base.dev;
- 	struct amdgpu_display_manager *dm =3D &drm_to_adev(drm)->dm;
- 	struct backlight_properties props =3D { 0 };
- 	struct amdgpu_dm_backlight_caps *caps;
- 	char bl_name[16];
- 	int min, max;
- 	int real_brightness;
- 	int init_brightness;
-=20
- 	if (aconnector->bl_idx =3D=3D -1)
- 		return;
-=20
- 	if (!acpi_video_backlight_use_native()) {
- 		drm_info(drm, "Skipping amdgpu DM backlight registration\n");
- 		/* Try registering an ACPI video backlight device instead. */
- 		acpi_video_register_backlight();
- 		return;
- 	}
-=20
- 	caps =3D &dm->backlight_caps[aconnector->bl_idx];
- 	if (get_brightness_range(caps, &min, &max)) {
- 		if (power_supply_is_system_supplied() > 0)
- 			props.brightness =3D DIV_ROUND_CLOSEST(max * caps->ac_level, 100);
- 		else
- 			props.brightness =3D DIV_ROUND_CLOSEST(max * caps->dc_level, 100);
- 		/* min is zero, so max needs to be adjusted */
- 		props.max_brightness =3D max;
- 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, m=
ax,
- 			caps->ac_level, caps->dc_level);
- 	} else
- 		props.brightness =3D props.max_brightness =3D MAX_BACKLIGHT_LEVEL;
-=20
- 	init_brightness =3D props.brightness;
-=20
- 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIG=
HTNESS_CURVE)) {
- 		drm_info(drm, "Using custom brightness curve\n");
- 		props.scale =3D BACKLIGHT_SCALE_NON_LINEAR;
- 	} else
- 		props.scale =3D BACKLIGHT_SCALE_LINEAR;
- 	props.type =3D BACKLIGHT_RAW;
-=20
- 	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
- 		 drm->primary->index + aconnector->bl_idx);
-=20
- 	dm->backlight_dev[aconnector->bl_idx] =3D
- 		backlight_device_register(bl_name, aconnector->base.kdev, dm,
- 					  &amdgpu_dm_backlight_ops, &props);
- 	dm->brightness[aconnector->bl_idx] =3D props.brightness;
-=20
- 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
- 		drm_err(drm, "DM: Backlight registration failed!\n");
- 		dm->backlight_dev[aconnector->bl_idx] =3D NULL;
- 	} else {
- 		/*
- 		 * dm->brightness[x] can be inconsistent just after startup until
- 		 * ops.get_brightness is called.
- 		 */
- 		real_brightness =3D
- 			amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->b=
l_idx]);
-=20
- 		if (real_brightness !=3D init_brightness) {
- 			dm->actual_brightness[aconnector->bl_idx] =3D real_brightness;
- 			dm->brightness[aconnector->bl_idx] =3D real_brightness;
- 		}
- 		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
- 	}
- }
-=20
  static int initialize_plane(struct amdgpu_display_manager *dm,
  			    struct amdgpu_mode_info *mode_info, int plane_id,
  			    enum drm_plane_type plane_type,
@@@ -5657,42 -2299,6 +2304,6 @@@
  }
 =20
 =20
- static void setup_backlight_device(struct amdgpu_display_manager *dm,
- 				   struct amdgpu_dm_connector *aconnector)
- {
- 	struct amdgpu_dm_backlight_caps *caps;
- 	struct dc_link *link =3D aconnector->dc_link;
- 	int bl_idx =3D dm->num_of_edps;
-=20
- 	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
- 	    link->type =3D=3D dc_connection_none)
- 		return;
-=20
- 	if (dm->num_of_edps >=3D AMDGPU_DM_MAX_NUM_EDP) {
- 		drm_warn(adev_to_drm(dm->adev), "Too much eDP connections, skipping bac=
klight setup for additional eDPs\n");
- 		return;
- 	}
-=20
- 	aconnector->bl_idx =3D bl_idx;
-=20
- 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
- 	dm->backlight_link[bl_idx] =3D link;
- 	dm->num_of_edps++;
-=20
- 	update_connector_ext_caps(aconnector);
- 	caps =3D &dm->backlight_caps[aconnector->bl_idx];
-=20
- 	/* Only offer ABM property when non-OLED and user didn't turn off by mod=
ule parameter */
- 	if (caps->ext_caps && !caps->ext_caps->bits.oled && amdgpu_dm_abm_level =
< 0)
- 		drm_object_attach_property(&aconnector->base.base,
- 					   dm->adev->mode_info.abm_level_property,
- 					   ABM_SYSFS_CONTROL);
- }
-=20
- static void amdgpu_set_panel_orientation(struct drm_connector *connector);
-=20
-=20
-=20
  /*
   * In this architecture, the association
   * connector -> encoder -> crtc
@@@ -5804,7 -2410,7 +2415,7 @@@ static int amdgpu_dm_initialize_drm_dev
  	case IP_VERSION(4, 0, 1):
  	case IP_VERSION(4, 2, 0):
  	case IP_VERSION(4, 2, 1):
- 		if (register_outbox_irq_handlers(dm->adev)) {
+ 		if (amdgpu_dm_register_outbox_irq_handlers(dm->adev)) {
  			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
  			goto fail;
  		}
@@@ -5917,7 -2523,7 +2528,7 @@@
  			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 =20
  		if (aconnector->base.force && new_connection_type =3D=3D dc_connection_=
none) {
- 			emulated_link_detect(link);
+ 			amdgpu_dm_emulated_link_detect(link);
  			amdgpu_dm_update_connector_after_detect(aconnector);
  		} else {
  			bool ret =3D false;
@@@ -5929,7 -2535,7 +2540,7 @@@
 =20
  			if (ret) {
  				amdgpu_dm_update_connector_after_detect(aconnector);
- 				setup_backlight_device(dm, aconnector);
+ 				amdgpu_dm_setup_backlight_device(dm, aconnector);
 =20
  				/* Disable PSR if Replay can be enabled */
  				if (replay_feature_enabled)
@@@ -5981,7 -2587,7 +2592,7 @@@
  	case CHIP_VEGA10:
  	case CHIP_VEGA12:
  	case CHIP_VEGA20:
- 		if (dce110_register_irq_handlers(dm->adev)) {
+ 		if (amdgpu_dm_dce110_register_irq_handlers(dm->adev)) {
  			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
  			goto fail;
  		}
@@@ -6011,7 -2617,7 +2622,7 @@@
  		case IP_VERSION(4, 0, 1):
  		case IP_VERSION(4, 2, 0):
  		case IP_VERSION(4, 2, 1):
- 			if (dcn10_register_irq_handlers(dm->adev)) {
+ 			if (amdgpu_dm_dcn10_register_irq_handlers(dm->adev)) {
  				drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
  				goto fail;
  			}
@@@ -6049,10 -2655,11 +2660,11 @@@ static void amdgpu_dm_destroy_drm_devic
   *
   * Calculate and program the display watermarks and line buffer allocatio=
n.
   */
- static void dm_bandwidth_update(struct amdgpu_device *adev)
+ STATIC_IFN_KUNIT void dm_bandwidth_update(struct amdgpu_device *adev)
  {
  	/* TODO: implement later */
  }
+ EXPORT_IF_KUNIT(dm_bandwidth_update);
 =20
  static const struct amdgpu_display_funcs dm_display_funcs =3D {
  	.bandwidth_update =3D dm_bandwidth_update, /* called unconditionally */
@@@ -6102,78 -2709,6 +2714,6 @@@ DEVICE_ATTR_WO(s3_debug)
 =20
  #endif
 =20
- static int dm_init_microcode(struct amdgpu_device *adev)
- {
- 	char *fw_name_dmub;
- 	int r;
-=20
- 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
- 	case IP_VERSION(2, 1, 0):
- 		fw_name_dmub =3D FIRMWARE_RENOIR_DMUB;
- 		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
- 			fw_name_dmub =3D FIRMWARE_GREEN_SARDINE_DMUB;
- 		break;
- 	case IP_VERSION(3, 0, 0):
- 		if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, 0))
- 			fw_name_dmub =3D FIRMWARE_SIENNA_CICHLID_DMUB;
- 		else
- 			fw_name_dmub =3D FIRMWARE_NAVY_FLOUNDER_DMUB;
- 		break;
- 	case IP_VERSION(3, 0, 1):
- 		fw_name_dmub =3D FIRMWARE_VANGOGH_DMUB;
- 		break;
- 	case IP_VERSION(3, 0, 2):
- 		fw_name_dmub =3D FIRMWARE_DIMGREY_CAVEFISH_DMUB;
- 		break;
- 	case IP_VERSION(3, 0, 3):
- 		fw_name_dmub =3D FIRMWARE_BEIGE_GOBY_DMUB;
- 		break;
- 	case IP_VERSION(3, 1, 2):
- 	case IP_VERSION(3, 1, 3):
- 		fw_name_dmub =3D FIRMWARE_YELLOW_CARP_DMUB;
- 		break;
- 	case IP_VERSION(3, 1, 4):
- 		fw_name_dmub =3D FIRMWARE_DCN_314_DMUB;
- 		break;
- 	case IP_VERSION(3, 1, 5):
- 		fw_name_dmub =3D FIRMWARE_DCN_315_DMUB;
- 		break;
- 	case IP_VERSION(3, 1, 6):
- 		fw_name_dmub =3D FIRMWARE_DCN316_DMUB;
- 		break;
- 	case IP_VERSION(3, 2, 0):
- 		fw_name_dmub =3D FIRMWARE_DCN_V3_2_0_DMCUB;
- 		break;
- 	case IP_VERSION(3, 2, 1):
- 		fw_name_dmub =3D FIRMWARE_DCN_V3_2_1_DMCUB;
- 		break;
- 	case IP_VERSION(3, 5, 0):
- 		fw_name_dmub =3D FIRMWARE_DCN_35_DMUB;
- 		break;
- 	case IP_VERSION(3, 5, 1):
- 		fw_name_dmub =3D FIRMWARE_DCN_351_DMUB;
- 		break;
- 	case IP_VERSION(3, 6, 0):
- 		fw_name_dmub =3D FIRMWARE_DCN_36_DMUB;
- 		break;
- 	case IP_VERSION(4, 0, 1):
- 		fw_name_dmub =3D FIRMWARE_DCN_401_DMUB;
- 		break;
- 	case IP_VERSION(4, 2, 0):
- 		fw_name_dmub =3D FIRMWARE_DCN_42_DMUB;
- 		break;
- 	case IP_VERSION(4, 2, 1):
- 		fw_name_dmub =3D FIRMWARE_DCN_42B_DMUB;
- 		break;
- 	default:
- 		/* ASIC doesn't support DMUB. */
- 		return 0;
- 	}
- 	r =3D amdgpu_ucode_request(adev, &adev->dm.dmub_fw, AMDGPU_UCODE_REQUIRE=
D,
- 				 "%s", fw_name_dmub);
- 	return r;
- }
-=20
  static int dm_early_init(struct amdgpu_ip_block *ip_block)
  {
  	struct amdgpu_device *adev =3D ip_block->adev;
@@@ -6324,22 -2859,13 +2864,13 @@@
  	return dm_init_microcode(adev);
  }
 =20
- static bool modereset_required(struct drm_crtc_state *crtc_state)
+ STATIC_IFN_KUNIT bool modereset_required(struct drm_crtc_state *crtc_stat=
e)
  {
  	return !crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
  }
+ EXPORT_IF_KUNIT(modereset_required);
 =20
- static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
- {
- 	drm_encoder_cleanup(encoder);
- 	kfree(encoder);
- }
-=20
- static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs =3D {
- 	.destroy =3D amdgpu_dm_encoder_destroy,
- };
-=20
- static int
+ STATIC_IFN_KUNIT int
  fill_plane_color_attributes(const struct drm_plane_state *plane_state,
  			    const enum surface_pixel_format format,
  			    enum dc_color_space *color_space)
@@@ -6386,11 -2912,11 +2917,11 @@@
 =20
  	return 0;
  }
+ EXPORT_IF_KUNIT(fill_plane_color_attributes);
 =20
  static int
  fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
  			    const struct drm_plane_state *plane_state,
- 			    const u64 tiling_flags,
  			    struct dc_plane_info *plane_info,
  			    struct dc_plane_address *address,
  			    bool tmz_surface)
@@@ -6488,7 -3014,7 +3019,7 @@@
  		return ret;
 =20
  	ret =3D amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb, plane_in=
fo->format,
- 					   plane_info->rotation, tiling_flags,
+ 					   plane_info->rotation,
  					   &plane_info->tiling_info,
  					   &plane_info->plane_size,
  					   &plane_info->dcc, address,
@@@ -6524,7 -3050,6 +3055,6 @@@ static int fill_dc_plane_attributes(str
  	dc_plane_state->scaling_quality =3D scaling_info.scaling_quality;
 =20
  	ret =3D fill_dc_plane_info_and_addr(adev, plane_state,
- 					  afb->tiling_flags,
  					  &plane_info,
  					  &dc_plane_state->address,
  					  afb->tmz_surface);
@@@ -6724,2119 -3249,6 +3254,6 @@@ ffu
  			   &flip_addrs->dirty_rect_count, true);
  }
 =20
- static void update_stream_scaling_settings(struct drm_device *dev,
- 					   const struct drm_display_mode *mode,
- 					   const struct dm_connector_state *dm_state,
- 					   struct dc_stream_state *stream)
- {
- 	enum amdgpu_rmx_type rmx_type;
-=20
- 	struct rect src =3D { 0 }; /* viewport in composition space*/
- 	struct rect dst =3D { 0 }; /* stream addressable area */
-=20
- 	/* no mode. nothing to be done */
- 	if (!mode)
- 		return;
-=20
- 	/* Full screen scaling by default */
- 	src.width =3D mode->hdisplay;
- 	src.height =3D mode->vdisplay;
- 	dst.width =3D stream->timing.h_addressable;
- 	dst.height =3D stream->timing.v_addressable;
-=20
- 	if (dm_state) {
- 		rmx_type =3D dm_state->scaling;
- 		if (rmx_type =3D=3D RMX_ASPECT || rmx_type =3D=3D RMX_OFF) {
- 			if (src.width * dst.height <
- 					src.height * dst.width) {
- 				/* height needs less upscaling/more downscaling */
- 				dst.width =3D src.width *
- 						dst.height / src.height;
- 			} else {
- 				/* width needs less upscaling/more downscaling */
- 				dst.height =3D src.height *
- 						dst.width / src.width;
- 			}
- 		} else if (rmx_type =3D=3D RMX_CENTER) {
- 			dst =3D src;
- 		}
-=20
- 		dst.x =3D (stream->timing.h_addressable - dst.width) / 2;
- 		dst.y =3D (stream->timing.v_addressable - dst.height) / 2;
-=20
- 		if (dm_state->underscan_enable) {
- 			dst.x +=3D dm_state->underscan_hborder / 2;
- 			dst.y +=3D dm_state->underscan_vborder / 2;
- 			dst.width -=3D dm_state->underscan_hborder;
- 			dst.height -=3D dm_state->underscan_vborder;
- 		}
- 	}
-=20
- 	stream->src =3D src;
- 	stream->dst =3D dst;
-=20
- 	drm_dbg_kms(dev, "Destination Rectangle x:%d  y:%d  width:%d  height:%d\=
n",
- 		    dst.x, dst.y, dst.width, dst.height);
-=20
- }
-=20
- static enum dc_color_depth
- convert_color_depth_from_display_info(const struct drm_connector *connect=
or,
- 				      bool is_y420, int requested_bpc)
- {
- 	u8 bpc;
-=20
- 	if (is_y420) {
- 		bpc =3D 8;
-=20
- 		/* Cap display bpc based on HDMI 2.0 HF-VSDB */
- 		if (connector->display_info.hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_4=
8)
- 			bpc =3D 16;
- 		else if (connector->display_info.hdmi.y420_dc_modes & DRM_EDID_YCBCR420=
_DC_36)
- 			bpc =3D 12;
- 		else if (connector->display_info.hdmi.y420_dc_modes & DRM_EDID_YCBCR420=
_DC_30)
- 			bpc =3D 10;
- 	} else {
- 		bpc =3D (uint8_t)connector->display_info.bpc;
- 		/* Assume 8 bpc by default if no bpc is specified. */
- 		bpc =3D bpc ? bpc : 8;
- 	}
-=20
- 	if (requested_bpc > 0) {
- 		/*
- 		 * Cap display bpc based on the user requested value.
- 		 *
- 		 * The value for state->max_bpc may not correctly updated
- 		 * depending on when the connector gets added to the state
- 		 * or if this was called outside of atomic check, so it
- 		 * can't be used directly.
- 		 */
- 		bpc =3D min_t(u8, bpc, requested_bpc);
-=20
- 		/* Round down to the nearest even number. */
- 		bpc =3D bpc - (bpc & 1);
- 	}
-=20
- 	switch (bpc) {
- 	case 0:
- 		/*
- 		 * Temporary Work around, DRM doesn't parse color depth for
- 		 * EDID revision before 1.4
- 		 * TODO: Fix edid parsing
- 		 */
- 		return COLOR_DEPTH_888;
- 	case 6:
- 		return COLOR_DEPTH_666;
- 	case 8:
- 		return COLOR_DEPTH_888;
- 	case 10:
- 		return COLOR_DEPTH_101010;
- 	case 12:
- 		return COLOR_DEPTH_121212;
- 	case 14:
- 		return COLOR_DEPTH_141414;
- 	case 16:
- 		return COLOR_DEPTH_161616;
- 	default:
- 		return COLOR_DEPTH_UNDEFINED;
- 	}
- }
-=20
- static enum dc_aspect_ratio
- get_aspect_ratio(const struct drm_display_mode *mode_in)
- {
- 	/* 1-1 mapping, since both enums follow the HDMI spec. */
- 	return (enum dc_aspect_ratio) mode_in->picture_aspect_ratio;
- }
-=20
- static enum dc_color_space
- get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
- 		       const struct drm_connector_state *connector_state)
- {
- 	enum dc_color_space color_space =3D COLOR_SPACE_SRGB;
-=20
- 	switch (connector_state->colorspace) {
- 	case DRM_MODE_COLORIMETRY_BT601_YCC:
- 		if (dc_crtc_timing->flags.Y_ONLY)
- 			color_space =3D COLOR_SPACE_YCBCR601_LIMITED;
- 		else
- 			color_space =3D COLOR_SPACE_YCBCR601;
- 		break;
- 	case DRM_MODE_COLORIMETRY_BT709_YCC:
- 		if (dc_crtc_timing->flags.Y_ONLY)
- 			color_space =3D COLOR_SPACE_YCBCR709_LIMITED;
- 		else
- 			color_space =3D COLOR_SPACE_YCBCR709;
- 		break;
- 	case DRM_MODE_COLORIMETRY_OPRGB:
- 		color_space =3D COLOR_SPACE_ADOBERGB;
- 		break;
- 	case DRM_MODE_COLORIMETRY_BT2020_RGB:
- 	case DRM_MODE_COLORIMETRY_BT2020_YCC:
- 		if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB)
- 			color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
- 		else
- 			color_space =3D COLOR_SPACE_2020_YCBCR_LIMITED;
- 		break;
- 	case DRM_MODE_COLORIMETRY_DEFAULT: // ITU601
- 	default:
- 		if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB) {
- 			color_space =3D COLOR_SPACE_SRGB;
- 			if (connector_state->hdmi.broadcast_rgb =3D=3D DRM_HDMI_BROADCAST_RGB_=
LIMITED)
- 				color_space =3D COLOR_SPACE_SRGB_LIMITED;
- 		/*
- 		 * 27030khz is the separation point between HDTV and SDTV
- 		 * according to HDMI spec, we use YCbCr709 and YCbCr601
- 		 * respectively
- 		 */
- 		} else if (dc_crtc_timing->pix_clk_100hz > 270300) {
- 			if (dc_crtc_timing->flags.Y_ONLY)
- 				color_space =3D
- 					COLOR_SPACE_YCBCR709_LIMITED;
- 			else
- 				color_space =3D COLOR_SPACE_YCBCR709;
- 		} else {
- 			if (dc_crtc_timing->flags.Y_ONLY)
- 				color_space =3D
- 					COLOR_SPACE_YCBCR601_LIMITED;
- 			else
- 				color_space =3D COLOR_SPACE_YCBCR601;
- 		}
- 		break;
- 	}
-=20
- 	return color_space;
- }
-=20
- static enum display_content_type
- get_output_content_type(const struct drm_connector_state *connector_state)
- {
- 	switch (connector_state->content_type) {
- 	default:
- 	case DRM_MODE_CONTENT_TYPE_NO_DATA:
- 		return DISPLAY_CONTENT_TYPE_NO_DATA;
- 	case DRM_MODE_CONTENT_TYPE_GRAPHICS:
- 		return DISPLAY_CONTENT_TYPE_GRAPHICS;
- 	case DRM_MODE_CONTENT_TYPE_PHOTO:
- 		return DISPLAY_CONTENT_TYPE_PHOTO;
- 	case DRM_MODE_CONTENT_TYPE_CINEMA:
- 		return DISPLAY_CONTENT_TYPE_CINEMA;
- 	case DRM_MODE_CONTENT_TYPE_GAME:
- 		return DISPLAY_CONTENT_TYPE_GAME;
- 	}
- }
-=20
- static bool adjust_colour_depth_from_display_info(
- 	struct dc_crtc_timing *timing_out,
- 	const struct drm_display_info *info)
- {
- 	enum dc_color_depth depth =3D timing_out->display_color_depth;
- 	int normalized_clk;
-=20
- 	do {
- 		normalized_clk =3D timing_out->pix_clk_100hz / 10;
- 		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
- 		if (timing_out->pixel_encoding =3D=3D PIXEL_ENCODING_YCBCR420)
- 			normalized_clk /=3D 2;
- 		/* Adjusting pix clock following on HDMI spec based on colour depth */
- 		switch (depth) {
- 		case COLOR_DEPTH_888:
- 			break;
- 		case COLOR_DEPTH_101010:
- 			normalized_clk =3D (normalized_clk * 30) / 24;
- 			break;
- 		case COLOR_DEPTH_121212:
- 			normalized_clk =3D (normalized_clk * 36) / 24;
- 			break;
- 		case COLOR_DEPTH_161616:
- 			normalized_clk =3D (normalized_clk * 48) / 24;
- 			break;
- 		default:
- 			/* The above depths are the only ones valid for HDMI. */
- 			return false;
- 		}
- 		if (normalized_clk <=3D info->max_tmds_clock) {
- 			timing_out->display_color_depth =3D depth;
- 			return true;
- 		}
- 	} while (--depth > COLOR_DEPTH_666);
- 	return false;
- }
-=20
- static void fill_stream_properties_from_drm_display_mode(
- 	struct dc_stream_state *stream,
- 	const struct drm_display_mode *mode_in,
- 	const struct drm_connector *connector,
- 	const struct drm_connector_state *connector_state,
- 	const struct dc_stream_state *old_stream,
- 	int requested_bpc)
- {
- 	struct dc_crtc_timing *timing_out =3D &stream->timing;
- 	const struct drm_display_info *info =3D &connector->display_info;
- 	struct amdgpu_dm_connector *aconnector =3D NULL;
- 	struct hdmi_vendor_infoframe hv_frame;
- 	struct hdmi_avi_infoframe avi_frame;
- 	ssize_t err;
-=20
- 	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 		aconnector =3D to_amdgpu_dm_connector(connector);
-=20
- 	memset(&hv_frame, 0, sizeof(hv_frame));
- 	memset(&avi_frame, 0, sizeof(avi_frame));
-=20
- 	timing_out->h_border_left =3D 0;
- 	timing_out->h_border_right =3D 0;
- 	timing_out->v_border_top =3D 0;
- 	timing_out->v_border_bottom =3D 0;
- 	/* TODO: un-hardcode */
- 	if (drm_mode_is_420_only(info, mode_in)
- 			&& (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
- 			    stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL)
- 			&& aconnector
- 			&& aconnector->force_yuv_pixel_format =3D=3D PIXEL_ENCODING_YCBCR420)
- 		timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
- 	else if (drm_mode_is_420_also(info, mode_in)
- 			&& aconnector
- 			&& (aconnector->force_yuv_pixel_format =3D=3D PIXEL_ENCODING_YCBCR420
- 			|| aconnector->force_yuv420_output))
- 		timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
- 	else if ((connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_F=
ORMAT_YCBCR422))
- 			&& aconnector
- 			&& (aconnector->force_yuv_pixel_format =3D=3D PIXEL_ENCODING_YCBCR422
- 			|| aconnector->force_yuv422_output))
- 		timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR422;
- 	else if ((connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_F=
ORMAT_YCBCR444))
- 			&& (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
- 			    stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL)
- 			&& aconnector
- 			&& aconnector->force_yuv_pixel_format =3D=3D PIXEL_ENCODING_YCBCR444)
- 		timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
- 	else
- 		timing_out->pixel_encoding =3D PIXEL_ENCODING_RGB;
-=20
- 	timing_out->timing_3d_format =3D TIMING_3D_FORMAT_NONE;
- 	timing_out->display_color_depth =3D convert_color_depth_from_display_inf=
o(
- 		connector,
- 		(timing_out->pixel_encoding =3D=3D PIXEL_ENCODING_YCBCR420),
- 		requested_bpc);
- 	timing_out->scan_type =3D SCANNING_TYPE_NODATA;
- 	timing_out->hdmi_vic =3D 0;
-=20
- 	if (old_stream) {
- 		timing_out->vic =3D old_stream->timing.vic;
- 		timing_out->flags.HSYNC_POSITIVE_POLARITY =3D old_stream->timing.flags.=
HSYNC_POSITIVE_POLARITY;
- 		timing_out->flags.VSYNC_POSITIVE_POLARITY =3D old_stream->timing.flags.=
VSYNC_POSITIVE_POLARITY;
- 	} else {
- 		timing_out->vic =3D drm_match_cea_mode(mode_in);
- 		if (mode_in->flags & DRM_MODE_FLAG_PHSYNC)
- 			timing_out->flags.HSYNC_POSITIVE_POLARITY =3D 1;
- 		if (mode_in->flags & DRM_MODE_FLAG_PVSYNC)
- 			timing_out->flags.VSYNC_POSITIVE_POLARITY =3D 1;
- 	}
-=20
- 	if (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
- 		stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL) {
- 		err =3D drm_hdmi_avi_infoframe_from_display_mode(&avi_frame,
- 							       (struct drm_connector *)connector,
- 							       mode_in);
- 		if (err < 0)
- 			drm_warn_once(connector->dev, "Failed to setup avi infoframe on connec=
tor %s: %zd\n",
- 				      connector->name, err);
- 		timing_out->vic =3D avi_frame.video_code;
- 		err =3D drm_hdmi_vendor_infoframe_from_display_mode(&hv_frame,
- 								  (struct drm_connector *)connector,
- 								  mode_in);
- 		if (err < 0)
- 			drm_warn_once(connector->dev, "Failed to setup vendor infoframe on con=
nector %s: %zd\n",
- 				      connector->name, err);
- 		timing_out->hdmi_vic =3D hv_frame.vic;
- 	}
-=20
- 	if (aconnector && is_freesync_video_mode(mode_in, aconnector)) {
- 		timing_out->h_addressable =3D mode_in->hdisplay;
- 		timing_out->h_total =3D mode_in->htotal;
- 		timing_out->h_sync_width =3D mode_in->hsync_end - mode_in->hsync_start;
- 		timing_out->h_front_porch =3D mode_in->hsync_start - mode_in->hdisplay;
- 		timing_out->v_total =3D mode_in->vtotal;
- 		timing_out->v_addressable =3D mode_in->vdisplay;
- 		timing_out->v_front_porch =3D mode_in->vsync_start - mode_in->vdisplay;
- 		timing_out->v_sync_width =3D mode_in->vsync_end - mode_in->vsync_start;
- 		timing_out->pix_clk_100hz =3D mode_in->clock * 10;
- 	} else {
- 		timing_out->h_addressable =3D mode_in->crtc_hdisplay;
- 		timing_out->h_total =3D mode_in->crtc_htotal;
- 		timing_out->h_sync_width =3D mode_in->crtc_hsync_end - mode_in->crtc_hs=
ync_start;
- 		timing_out->h_front_porch =3D mode_in->crtc_hsync_start - mode_in->crtc=
_hdisplay;
- 		timing_out->v_total =3D mode_in->crtc_vtotal;
- 		timing_out->v_addressable =3D mode_in->crtc_vdisplay;
- 		timing_out->v_front_porch =3D mode_in->crtc_vsync_start - mode_in->crtc=
_vdisplay;
- 		timing_out->v_sync_width =3D mode_in->crtc_vsync_end - mode_in->crtc_vs=
ync_start;
- 		timing_out->pix_clk_100hz =3D mode_in->crtc_clock * 10;
- 	}
-=20
- 	timing_out->aspect_ratio =3D get_aspect_ratio(mode_in);
-=20
- 	stream->out_transfer_func.type =3D TF_TYPE_PREDEFINED;
- 	stream->out_transfer_func.tf =3D TRANSFER_FUNCTION_SRGB;
- 	if (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A) {
- 		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
- 		    drm_mode_is_420_also(info, mode_in) &&
- 		    timing_out->pixel_encoding !=3D PIXEL_ENCODING_YCBCR420) {
- 			timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR420;
- 			adjust_colour_depth_from_display_info(timing_out, info);
- 		}
- 	}
-=20
- 	stream->output_color_space =3D get_output_color_space(timing_out, connec=
tor_state);
- 	stream->content_type =3D get_output_content_type(connector_state);
- }
-=20
- static void fill_audio_info(struct audio_info *audio_info,
- 			    const struct drm_connector *drm_connector,
- 			    const struct dc_sink *dc_sink)
- {
- 	int i =3D 0;
- 	int cea_revision =3D 0;
- 	const struct dc_edid_caps *edid_caps =3D &dc_sink->edid_caps;
-=20
- 	audio_info->manufacture_id =3D edid_caps->manufacturer_id;
- 	audio_info->product_id =3D edid_caps->product_id;
-=20
- 	cea_revision =3D drm_connector->display_info.cea_rev;
-=20
- 	strscpy(audio_info->display_name,
- 		edid_caps->display_name,
- 		AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
-=20
- 	if (cea_revision >=3D 3) {
- 		audio_info->mode_count =3D edid_caps->audio_mode_count;
-=20
- 		for (i =3D 0; i < audio_info->mode_count; ++i) {
- 			audio_info->modes[i].format_code =3D
- 					(enum audio_format_code)
- 					(edid_caps->audio_modes[i].format_code);
- 			audio_info->modes[i].channel_count =3D
- 					edid_caps->audio_modes[i].channel_count;
- 			audio_info->modes[i].sample_rates.all =3D
- 					edid_caps->audio_modes[i].sample_rate;
- 			audio_info->modes[i].sample_size =3D
- 					edid_caps->audio_modes[i].sample_size;
- 		}
- 	}
-=20
- 	audio_info->flags.all =3D edid_caps->speaker_flags;
-=20
- 	/* TODO: We only check for the progressive mode, check for interlace mod=
e too */
- 	if (drm_connector->latency_present[0]) {
- 		audio_info->video_latency =3D drm_connector->video_latency[0];
- 		audio_info->audio_latency =3D drm_connector->audio_latency[0];
- 	}
-=20
- 	/* TODO: For DP, video and audio latency should be calculated from DPCD =
caps */
-=20
- }
-=20
- static void
- copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_=
mode,
- 				      struct drm_display_mode *dst_mode)
- {
- 	dst_mode->crtc_hdisplay =3D src_mode->crtc_hdisplay;
- 	dst_mode->crtc_vdisplay =3D src_mode->crtc_vdisplay;
- 	dst_mode->crtc_clock =3D src_mode->crtc_clock;
- 	dst_mode->crtc_hblank_start =3D src_mode->crtc_hblank_start;
- 	dst_mode->crtc_hblank_end =3D src_mode->crtc_hblank_end;
- 	dst_mode->crtc_hsync_start =3D  src_mode->crtc_hsync_start;
- 	dst_mode->crtc_hsync_end =3D src_mode->crtc_hsync_end;
- 	dst_mode->crtc_htotal =3D src_mode->crtc_htotal;
- 	dst_mode->crtc_hskew =3D src_mode->crtc_hskew;
- 	dst_mode->crtc_vblank_start =3D src_mode->crtc_vblank_start;
- 	dst_mode->crtc_vblank_end =3D src_mode->crtc_vblank_end;
- 	dst_mode->crtc_vsync_start =3D src_mode->crtc_vsync_start;
- 	dst_mode->crtc_vsync_end =3D src_mode->crtc_vsync_end;
- 	dst_mode->crtc_vtotal =3D src_mode->crtc_vtotal;
- }
-=20
- static void
- decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
- 					const struct drm_display_mode *native_mode,
- 					bool scale_enabled)
- {
- 	if (scale_enabled || (
- 	    native_mode->clock =3D=3D drm_mode->clock &&
- 	    native_mode->htotal =3D=3D drm_mode->htotal &&
- 	    native_mode->vtotal =3D=3D drm_mode->vtotal)) {
- 		if (native_mode->crtc_clock)
- 			copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
- 	} else {
- 		/* no scaling nor amdgpu inserted, no need to patch */
- 	}
- }
-=20
- static struct dc_sink *
- create_fake_sink(struct drm_device *dev, struct dc_link *link)
- {
- 	struct dc_sink_init_data sink_init_data =3D { 0 };
- 	struct dc_sink *sink =3D NULL;
-=20
- 	sink_init_data.link =3D link;
- 	sink_init_data.sink_signal =3D link->connector_signal;
-=20
- 	sink =3D dc_sink_create(&sink_init_data);
- 	if (!sink) {
- 		drm_err(dev, "Failed to create sink!\n");
- 		return NULL;
- 	}
- 	sink->sink_signal =3D SIGNAL_TYPE_VIRTUAL;
-=20
- 	return sink;
- }
-=20
- static void set_multisync_trigger_params(
- 		struct dc_stream_state *stream)
- {
- 	struct dc_stream_state *master =3D NULL;
-=20
- 	if (stream->triggered_crtc_reset.enabled) {
- 		master =3D stream->triggered_crtc_reset.event_source;
- 		stream->triggered_crtc_reset.event =3D
- 			master->timing.flags.VSYNC_POSITIVE_POLARITY ?
- 			CRTC_EVENT_VSYNC_RISING : CRTC_EVENT_VSYNC_FALLING;
- 		stream->triggered_crtc_reset.delay =3D TRIGGER_DELAY_NEXT_PIXEL;
- 	}
- }
-=20
- static void set_master_stream(struct dc_stream_state *stream_set[],
- 			      int stream_count)
- {
- 	int j, highest_rfr =3D 0, master_stream =3D 0;
-=20
- 	for (j =3D 0;  j < stream_count; j++) {
- 		if (stream_set[j] && stream_set[j]->triggered_crtc_reset.enabled) {
- 			int refresh_rate =3D 0;
-=20
- 			refresh_rate =3D (stream_set[j]->timing.pix_clk_100hz*100)/
- 				(stream_set[j]->timing.h_total*stream_set[j]->timing.v_total);
- 			if (refresh_rate > highest_rfr) {
- 				highest_rfr =3D refresh_rate;
- 				master_stream =3D j;
- 			}
- 		}
- 	}
- 	for (j =3D 0;  j < stream_count; j++) {
- 		if (stream_set[j])
- 			stream_set[j]->triggered_crtc_reset.event_source =3D stream_set[master=
_stream];
- 	}
- }
-=20
- static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
- {
- 	int i =3D 0;
- 	struct dc_stream_state *stream;
-=20
- 	if (context->stream_count < 2)
- 		return;
- 	for (i =3D 0; i < context->stream_count ; i++) {
- 		if (!context->streams[i])
- 			continue;
- 		/*
- 		 * TODO: add a function to read AMD VSDB bits and set
- 		 * crtc_sync_master.multi_sync_enabled flag
- 		 * For now it's set to false
- 		 */
- 	}
-=20
- 	set_master_stream(context->streams, context->stream_count);
-=20
- 	for (i =3D 0; i < context->stream_count ; i++) {
- 		stream =3D context->streams[i];
-=20
- 		if (!stream)
- 			continue;
-=20
- 		set_multisync_trigger_params(stream);
- 	}
- }
-=20
- /**
-  * DOC: FreeSync Video
-  *
-  * When a userspace application wants to play a video, the content follow=
s a
-  * standard format definition that usually specifies the FPS for that for=
mat.
-  * The below list illustrates some video format and the expected FPS,
-  * respectively:
-  *
-  * - TV/NTSC (23.976 FPS)
-  * - Cinema (24 FPS)
-  * - TV/PAL (25 FPS)
-  * - TV/NTSC (29.97 FPS)
-  * - TV/NTSC (30 FPS)
-  * - Cinema HFR (48 FPS)
-  * - TV/PAL (50 FPS)
-  * - Commonly used (60 FPS)
-  * - Multiples of 24 (48,72,96 FPS)
-  *
-  * The list of standards video format is not huge and can be added to the
-  * connector modeset list beforehand. With that, userspace can leverage
-  * FreeSync to extends the front porch in order to attain the target refr=
esh
-  * rate. Such a switch will happen seamlessly, without screen blanking or
-  * reprogramming of the output in any other way. If the userspace request=
s a
-  * modesetting change compatible with FreeSync modes that only differ in =
the
-  * refresh rate, DC will skip the full update and avoid blink during the
-  * transition. For example, the video player can change the modesetting f=
rom
-  * 60Hz to 30Hz for playing TV/NTSC content when it goes full screen with=
out
-  * causing any display blink. This same concept can be applied to a mode
-  * setting change.
-  */
- static struct drm_display_mode *
- get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
- 		bool use_probed_modes)
- {
- 	struct drm_display_mode *m, *m_pref =3D NULL;
- 	u16 current_refresh, highest_refresh;
- 	struct list_head *list_head =3D use_probed_modes ?
- 		&aconnector->base.probed_modes :
- 		&aconnector->base.modes;
-=20
- 	if (aconnector->base.connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 		return NULL;
-=20
- 	if (aconnector->freesync_vid_base.clock !=3D 0)
- 		return &aconnector->freesync_vid_base;
-=20
- 	/* Find the preferred mode */
- 	list_for_each_entry(m, list_head, head) {
- 		if (m->type & DRM_MODE_TYPE_PREFERRED) {
- 			m_pref =3D m;
- 			break;
- 		}
- 	}
-=20
- 	if (!m_pref) {
- 		/* Probably an EDID with no preferred mode. Fallback to first entry */
- 		m_pref =3D list_first_entry_or_null(
- 				&aconnector->base.modes, struct drm_display_mode, head);
- 		if (!m_pref) {
- 			drm_dbg_driver(aconnector->base.dev, "No preferred mode found in EDID\=
n");
- 			return NULL;
- 		}
- 	}
-=20
- 	highest_refresh =3D drm_mode_vrefresh(m_pref);
-=20
- 	/*
- 	 * Find the mode with highest refresh rate with same resolution.
- 	 * For some monitors, preferred mode is not the mode with highest
- 	 * supported refresh rate.
- 	 */
- 	list_for_each_entry(m, list_head, head) {
- 		current_refresh  =3D drm_mode_vrefresh(m);
-=20
- 		if (m->hdisplay =3D=3D m_pref->hdisplay &&
- 		    m->vdisplay =3D=3D m_pref->vdisplay &&
- 		    highest_refresh < current_refresh) {
- 			highest_refresh =3D current_refresh;
- 			m_pref =3D m;
- 		}
- 	}
-=20
- 	drm_mode_copy(&aconnector->freesync_vid_base, m_pref);
- 	return m_pref;
- }
-=20
- static bool is_freesync_video_mode(const struct drm_display_mode *mode,
- 		struct amdgpu_dm_connector *aconnector)
- {
- 	struct drm_display_mode *high_mode;
- 	int timing_diff;
-=20
- 	high_mode =3D get_highest_refresh_rate_mode(aconnector, false);
- 	if (!high_mode || !mode)
- 		return false;
-=20
- 	timing_diff =3D high_mode->vtotal - mode->vtotal;
-=20
- 	if (high_mode->clock =3D=3D 0 || high_mode->clock !=3D mode->clock ||
- 	    high_mode->hdisplay !=3D mode->hdisplay ||
- 	    high_mode->vdisplay !=3D mode->vdisplay ||
- 	    high_mode->hsync_start !=3D mode->hsync_start ||
- 	    high_mode->hsync_end !=3D mode->hsync_end ||
- 	    high_mode->htotal !=3D mode->htotal ||
- 	    high_mode->hskew !=3D mode->hskew ||
- 	    high_mode->vscan !=3D mode->vscan ||
- 	    high_mode->vsync_start - mode->vsync_start !=3D timing_diff ||
- 	    high_mode->vsync_end - mode->vsync_end !=3D timing_diff)
- 		return false;
- 	else
- 		return true;
- }
-=20
- #if defined(CONFIG_DRM_AMD_DC_FP)
- static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
- 			    struct dc_sink *sink, struct dc_stream_state *stream,
- 			    struct dsc_dec_dpcd_caps *dsc_caps)
- {
- 	stream->timing.flags.DSC =3D 0;
- 	dsc_caps->is_dsc_supported =3D false;
-=20
- 	if (aconnector->dc_link && (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY=
_PORT ||
- 	    sink->sink_signal =3D=3D SIGNAL_TYPE_EDP)) {
- 		if (sink->link->dpcd_caps.dongle_type =3D=3D DISPLAY_DONGLE_NONE)
- 			dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
- 				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
- 				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
- 				dsc_caps);
- 		else if (sink->link->dpcd_caps.dongle_type =3D=3D DISPLAY_DONGLE_DP_HDM=
I_CONVERTER) {
- 			if (aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_=
support.DSC_PASSTHROUGH_SUPPORT &&
- 					!aconnector->dsc_settings.dsc_force_disable_passthrough &&
- 					aconnector->dc_link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_i=
n_kbps > 0 &&
- 					sink->edid_caps.frl_dsc_support &&
- 					sink->edid_caps.max_frl_rate > 0 &&
- 					sink->edid_caps.frl_dsc_max_frl_rate > 0)
- 				dc_dsc_parse_dsc_edid(aconnector->dc_link->ctx->dc, &sink->edid_caps,=
 dsc_caps);
- 			else
- 				dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
- 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
- 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps=
=2Eraw,
- 				      dsc_caps);
- 		}
- 	} else if (aconnector->dc_link && sink->sink_signal =3D=3D SIGNAL_TYPE_H=
DMI_FRL) {
- 		if (sink->edid_caps.frl_dsc_support &&
- 				sink->edid_caps.max_frl_rate > 0 &&
- 				sink->edid_caps.frl_dsc_max_frl_rate > 0)
- 			dc_dsc_parse_dsc_edid(aconnector->dc_link->ctx->dc, &sink->edid_caps, =
dsc_caps);
- 	}
- }
-=20
- static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnect=
or,
- 				    struct dc_sink *sink, struct dc_stream_state *stream,
- 				    struct dsc_dec_dpcd_caps *dsc_caps,
- 				    uint32_t max_dsc_target_bpp_limit_override)
- {
- 	const struct dc_link_settings *verified_link_cap =3D NULL;
- 	u32 link_bw_in_kbps;
- 	u32 edp_min_bpp_x16, edp_max_bpp_x16;
- 	struct dc *dc =3D sink->ctx->dc;
- 	struct dc_dsc_bw_range bw_range =3D {0};
- 	struct dc_dsc_config dsc_cfg =3D {0};
- 	struct dc_dsc_config_options dsc_options =3D {0};
-=20
- 	dc_dsc_get_default_config_option(dc, &dsc_options);
- 	dsc_options.max_target_bpp_limit_override_x16 =3D max_dsc_target_bpp_lim=
it_override * 16;
-=20
- 	verified_link_cap =3D dc_link_get_link_cap(stream->link);
- 	link_bw_in_kbps =3D dc_link_bandwidth_kbps(stream->link, verified_link_c=
ap);
- 	edp_min_bpp_x16 =3D 8 * 16;
- 	edp_max_bpp_x16 =3D 8 * 16;
-=20
- 	if (edp_max_bpp_x16 > dsc_caps->edp_max_bits_per_pixel)
- 		edp_max_bpp_x16 =3D dsc_caps->edp_max_bits_per_pixel;
-=20
- 	if (edp_max_bpp_x16 < edp_min_bpp_x16)
- 		edp_min_bpp_x16 =3D edp_max_bpp_x16;
-=20
- 	if (dc_dsc_compute_bandwidth_range(dc->res_pool->dscs[0],
- 				dc->debug.dsc_min_slice_height_override,
- 				edp_min_bpp_x16, edp_max_bpp_x16,
- 				dsc_caps,
- 				&stream->timing,
- 				dc_link_get_highest_encoding_format(aconnector->dc_link),
- 				&bw_range)) {
-=20
- 		if (bw_range.max_kbps < link_bw_in_kbps) {
- 			if (dc_dsc_compute_config(dc->res_pool->dscs[0],
- 					dsc_caps,
- 					&dsc_options,
- 					0,
- 					&stream->timing,
- 					dc_link_get_highest_encoding_format(aconnector->dc_link),
- 					&dsc_cfg)) {
- 				stream->timing.dsc_cfg =3D dsc_cfg;
- 				stream->timing.flags.DSC =3D 1;
- 				stream->timing.dsc_cfg.bits_per_pixel =3D edp_max_bpp_x16;
- 			}
- 			return;
- 		}
- 	}
-=20
- 	if (dc_dsc_compute_config(dc->res_pool->dscs[0],
- 				dsc_caps,
- 				&dsc_options,
- 				link_bw_in_kbps,
- 				&stream->timing,
- 				dc_link_get_highest_encoding_format(aconnector->dc_link),
- 				&dsc_cfg)) {
- 		stream->timing.dsc_cfg =3D dsc_cfg;
- 		stream->timing.flags.DSC =3D 1;
- 	}
- }
-=20
- static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconn=
ector,
- 					struct dc_sink *sink, struct dc_stream_state *stream,
- 					struct dsc_dec_dpcd_caps *dsc_caps)
- {
- 	struct drm_connector *drm_connector =3D &aconnector->base;
- 	u32 link_bandwidth_kbps;
- 	struct dc *dc =3D sink->ctx->dc;
- 	const struct dc_hdmi_frl_link_settings *frl_verified_link_cap =3D NULL;
- 	u32 converter_bw_in_kbps;
- 	u32 sink_bw_in_kbps;
- 	u32 dsc_sink_bw_in_kbps;
- 	u32 max_supported_bw_in_kbps, timing_bw_in_kbps;
- 	u32 dsc_max_supported_bw_in_kbps;
- 	u32 max_dsc_target_bpp_limit_override =3D
- 		drm_connector->display_info.max_dsc_bpp;
- 	struct dc_dsc_config_options dsc_options =3D {0};
-=20
- 	dc_dsc_get_default_config_option(dc, &dsc_options);
- 	dsc_options.max_target_bpp_limit_override_x16 =3D max_dsc_target_bpp_lim=
it_override * 16;
-=20
- 	link_bandwidth_kbps =3D dc_link_bandwidth_kbps(aconnector->dc_link,
- 							dc_link_get_link_cap(aconnector->dc_link));
-=20
- 	/* Set DSC policy according to dsc_clock_en */
- 	dc_dsc_policy_set_enable_dsc_when_not_needed(
- 		aconnector->dsc_settings.dsc_force_enable =3D=3D DSC_CLK_FORCE_ENABLE);
-=20
- 	if (sink->sink_signal =3D=3D SIGNAL_TYPE_EDP &&
- 	    !aconnector->dc_link->panel_config.dsc.disable_dsc_edp &&
- 	    dc->caps.edp_dsc_support && aconnector->dsc_settings.dsc_force_enabl=
e !=3D DSC_CLK_FORCE_DISABLE) {
-=20
- 		apply_dsc_policy_for_edp(aconnector, sink, stream, dsc_caps, max_dsc_ta=
rget_bpp_limit_override);
-=20
- 	} else if (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT) {
- 		if (sink->link->dpcd_caps.dongle_type =3D=3D DISPLAY_DONGLE_NONE) {
- 			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs=
[0],
- 						dsc_caps,
- 						&dsc_options,
- 						link_bandwidth_kbps,
- 						&stream->timing,
- 						dc_link_get_highest_encoding_format(aconnector->dc_link),
- 						&stream->timing.dsc_cfg)) {
- 				stream->timing.flags.DSC =3D 1;
- 				drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected =
=66rom SST RX\n",
- 							__func__, drm_connector->name);
- 			}
- 		} else if (sink->link->dpcd_caps.dongle_type =3D=3D DISPLAY_DONGLE_DP_H=
DMI_CONVERTER) {
- 			timing_bw_in_kbps =3D dc_bandwidth_in_kbps_from_timing(&stream->timing,
- 					dc_link_get_highest_encoding_format(aconnector->dc_link));
- 			converter_bw_in_kbps =3D aconnector->dc_link->dpcd_caps.dongle_caps.dp=
_hdmi_frl_max_link_bw_in_kbps;
- 			sink_bw_in_kbps =3D dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, si=
nk->edid_caps.max_frl_rate);
- 			dsc_sink_bw_in_kbps =3D dc_link_bw_kbps_from_raw_frl_link_rate_data(dc=
, sink->edid_caps.frl_dsc_max_frl_rate);
-=20
- 			if (dsc_caps->is_frl) {
- 				max_supported_bw_in_kbps =3D min(link_bandwidth_kbps, converter_bw_in=
_kbps);
- 				max_supported_bw_in_kbps =3D min(max_supported_bw_in_kbps, sink_bw_in=
_kbps);
- 				dsc_max_supported_bw_in_kbps =3D min(max_supported_bw_in_kbps, dsc_si=
nk_bw_in_kbps);
- 			} else {
- 				max_supported_bw_in_kbps =3D link_bandwidth_kbps;
- 				dsc_max_supported_bw_in_kbps =3D link_bandwidth_kbps;
- 			}
-=20
- 			if (timing_bw_in_kbps > max_supported_bw_in_kbps &&
- 					max_supported_bw_in_kbps > 0 &&
- 					dsc_max_supported_bw_in_kbps > 0)
- 				if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dsc=
s[0],
- 						dsc_caps,
- 						&dsc_options,
- 						dsc_max_supported_bw_in_kbps,
- 						&stream->timing,
- 						dc_link_get_highest_encoding_format(aconnector->dc_link),
- 						&stream->timing.dsc_cfg)) {
- 					stream->timing.flags.DSC =3D 1;
- 					drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected=
 from %s\n",
- 							__func__, drm_connector->name,
- 							(dsc_caps->is_frl =3D=3D 1) ? "HDMI FRL RX" : "DP-HDMI PCON");
- 				}
- 		}
- 	}
- 	else if (aconnector->dc_link && sink->sink_signal =3D=3D SIGNAL_TYPE_HDM=
I_FRL) {
- 		struct dc_dsc_policy dsc_policy =3D {0};
-=20
- 		frl_verified_link_cap =3D dc_link_get_frl_link_cap(stream->link);
- 		if (frl_verified_link_cap->frl_link_rate !=3D HDMI_FRL_LINK_RATE_DISABL=
E &&
- 			aconnector->dc_link->frl_flags.force_frl_dsc) {
- 			dc_dsc_policy_set_enable_dsc_when_not_needed(true);
- 			dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy, dc_link_=
get_highest_encoding_format(stream->link));
- 		}
-=20
- 		timing_bw_in_kbps =3D dc_bandwidth_in_kbps_from_timing(&stream->timing,=
 DC_LINK_ENCODING_HDMI_FRL);
- 		link_bandwidth_kbps =3D dc_link_frl_bandwidth_kbps(stream->link, frl_ve=
rified_link_cap->frl_link_rate);
- 		dsc_sink_bw_in_kbps =3D dc_link_bw_kbps_from_raw_frl_link_rate_data(dc,=
 sink->edid_caps.frl_dsc_max_frl_rate);
-=20
- 		if ((timing_bw_in_kbps > link_bandwidth_kbps && dsc_sink_bw_in_kbps > 0=
) ||
- 		    (dsc_policy.enable_dsc_when_not_needed || dsc_options.force_dsc_whe=
n_not_needed)) {
- 			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs=
[0],
- 					dsc_caps,
- 					&dsc_options,
- 					dsc_sink_bw_in_kbps,
- 					&stream->timing,
- 					dc_link_get_highest_encoding_format(aconnector->dc_link),
- 					&stream->timing.dsc_cfg)) {
- 				stream->timing.flags.DSC =3D 1;
- 				drm_dbg_driver(drm_connector->dev, "%s: HDMI_FRL_DSC [%s] DSC is sele=
cted from HDMI FRL RX\n",
- 						__func__, drm_connector->name);
- 			}
- 		}
- 	}
-=20
- 	/* Overwrite the stream flag if DSC is enabled through debugfs */
- 	if (aconnector->dsc_settings.dsc_force_enable =3D=3D DSC_CLK_FORCE_ENABL=
E)
- 		stream->timing.flags.DSC =3D 1;
-=20
- 	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_num_slices_=
h)
- 		stream->timing.dsc_cfg.num_slices_h =3D aconnector->dsc_settings.dsc_nu=
m_slices_h;
-=20
- 	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_num_slices_=
v)
- 		stream->timing.dsc_cfg.num_slices_v =3D aconnector->dsc_settings.dsc_nu=
m_slices_v;
-=20
- 	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_bits_per_pi=
xel)
- 		stream->timing.dsc_cfg.bits_per_pixel =3D aconnector->dsc_settings.dsc_=
bits_per_pixel;
- }
- #endif
-=20
- static struct dc_stream_state *
- create_stream_for_sink(struct drm_connector *connector,
- 		       const struct drm_display_mode *drm_mode,
- 		       const struct dm_connector_state *dm_state,
- 		       const struct dc_stream_state *old_stream,
- 		       int requested_bpc)
- {
- 	struct drm_device *dev =3D connector->dev;
- 	struct amdgpu_dm_connector *aconnector =3D NULL;
- 	struct drm_display_mode *preferred_mode =3D NULL;
- 	const struct drm_connector_state *con_state =3D &dm_state->base;
- 	struct dc_stream_state *stream =3D NULL;
- 	struct drm_display_mode mode;
- 	struct drm_display_mode saved_mode;
- 	struct drm_display_mode *freesync_mode =3D NULL;
- 	bool native_mode_found =3D false;
- 	bool recalculate_timing =3D false;
- 	bool scale =3D dm_state->scaling !=3D RMX_OFF;
- 	int mode_refresh;
- 	int preferred_refresh =3D 0;
- 	enum color_transfer_func tf =3D TRANSFER_FUNC_UNKNOWN;
- #if defined(CONFIG_DRM_AMD_DC_FP)
- 	struct dsc_dec_dpcd_caps dsc_caps =3D {0};
- #endif
- 	struct dc_link *link =3D NULL;
- 	struct dc_sink *sink =3D NULL;
-=20
- 	drm_mode_init(&mode, drm_mode);
- 	memset(&saved_mode, 0, sizeof(saved_mode));
-=20
- 	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_WRITEBACK) {
- 		aconnector =3D NULL;
- 		aconnector =3D to_amdgpu_dm_connector(connector);
- 		link =3D aconnector->dc_link;
- 	} else {
- 		struct drm_writeback_connector *wbcon =3D NULL;
- 		struct amdgpu_dm_wb_connector *dm_wbcon =3D NULL;
-=20
- 		wbcon =3D drm_connector_to_writeback(connector);
- 		dm_wbcon =3D to_amdgpu_dm_wb_connector(wbcon);
- 		link =3D dm_wbcon->link;
- 	}
-=20
- 	if (!aconnector || !aconnector->dc_sink) {
- 		sink =3D create_fake_sink(dev, link);
- 		if (!sink)
- 			return stream;
-=20
- 	} else {
- 		sink =3D aconnector->dc_sink;
- 		dc_sink_retain(sink);
- 	}
-=20
- 	stream =3D dc_create_stream_for_sink(sink);
-=20
- 	if (stream =3D=3D NULL) {
- 		drm_err(dev, "Failed to create stream for sink!\n");
- 		goto finish;
- 	}
-=20
- 	/* We leave this NULL for writeback connectors */
- 	stream->dm_stream_context =3D aconnector;
-=20
- 	stream->timing.flags.LTE_340MCSC_SCRAMBLE =3D
- 		connector->display_info.hdmi.scdc.scrambling.low_rates;
-=20
- 	list_for_each_entry(preferred_mode, &connector->modes, head) {
- 		/* Search for preferred mode */
- 		if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
- 			native_mode_found =3D true;
- 			break;
- 		}
- 	}
- 	if (!native_mode_found)
- 		preferred_mode =3D list_first_entry_or_null(
- 				&connector->modes,
- 				struct drm_display_mode,
- 				head);
-=20
- 	mode_refresh =3D drm_mode_vrefresh(&mode);
-=20
- 	if (preferred_mode =3D=3D NULL) {
- 		/*
- 		 * This may not be an error, the use case is when we have no
- 		 * usermode calls to reset and set mode upon hotplug. In this
- 		 * case, we call set mode ourselves to restore the previous mode
- 		 * and the modelist may not be filled in time.
- 		 */
- 		drm_dbg_driver(dev, "No preferred mode found\n");
- 	} else if (aconnector) {
- 		recalculate_timing =3D amdgpu_freesync_vid_mode &&
- 				 is_freesync_video_mode(&mode, aconnector);
- 		if (recalculate_timing) {
- 			freesync_mode =3D get_highest_refresh_rate_mode(aconnector, false);
- 			drm_mode_copy(&saved_mode, &mode);
- 			saved_mode.picture_aspect_ratio =3D mode.picture_aspect_ratio;
- 			drm_mode_copy(&mode, freesync_mode);
- 			mode.picture_aspect_ratio =3D saved_mode.picture_aspect_ratio;
- 		} else {
- 			decide_crtc_timing_for_drm_display_mode(
- 					&mode, preferred_mode, scale);
-=20
- 			preferred_refresh =3D drm_mode_vrefresh(preferred_mode);
- 		}
- 	}
-=20
- 	if (recalculate_timing)
- 		drm_mode_set_crtcinfo(&saved_mode, 0);
-=20
- 	/*
- 	 * If scaling is enabled and refresh rate didn't change
- 	 * we copy the vic and polarities of the old timings
- 	 */
- 	if (!scale || mode_refresh !=3D preferred_refresh)
- 		fill_stream_properties_from_drm_display_mode(
- 			stream, &mode, connector, con_state, NULL,
- 			requested_bpc);
- 	else
- 		fill_stream_properties_from_drm_display_mode(
- 			stream, &mode, connector, con_state, old_stream,
- 			requested_bpc);
-=20
- 	/* The rest isn't needed for writeback connectors */
- 	if (!aconnector)
- 		goto finish;
-=20
- 	if (aconnector->timing_changed) {
- 		drm_dbg(aconnector->base.dev,
- 			"overriding timing for automated test, bpc %d, changing to %d\n",
- 			stream->timing.display_color_depth,
- 			aconnector->timing_requested->display_color_depth);
- 		stream->timing =3D *aconnector->timing_requested;
- 	}
-=20
- #if defined(CONFIG_DRM_AMD_DC_FP)
- 	/* SST DSC determination policy */
- 	update_dsc_caps(aconnector, sink, stream, &dsc_caps);
- 	if (aconnector->dsc_settings.dsc_force_enable !=3D DSC_CLK_FORCE_DISABLE=
 && dsc_caps.is_dsc_supported)
- 		apply_dsc_policy_for_stream(aconnector, sink, stream, &dsc_caps);
- #endif
-=20
- 	update_stream_scaling_settings(dev, &mode, dm_state, stream);
-=20
- 	fill_audio_info(
- 		&stream->audio_info,
- 		connector,
- 		sink);
-=20
- 	update_stream_signal(stream, sink);
-=20
- 	if (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
- 	    stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL)
- 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, fa=
lse);
-=20
- 	if (stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
- 	    stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST ||
- 	    stream->signal =3D=3D SIGNAL_TYPE_EDP) {
- 		const struct dc_edid_caps *edid_caps;
- 		unsigned int disable_colorimetry =3D 0;
-=20
- 		if (aconnector->dc_sink) {
- 			edid_caps =3D &aconnector->dc_sink->edid_caps;
- 			disable_colorimetry =3D edid_caps->panel_patch.disable_colorimetry;
- 		}
-=20
- 		//
- 		// should decide stream support vsc sdp colorimetry capability
- 		// before building vsc info packet
- 		//
- 		stream->use_vsc_sdp_for_colorimetry =3D stream->link->dpcd_caps.dpcd_re=
v.raw >=3D 0x14 &&
- 						      stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY=
_SUPPORTED &&
- 						      !disable_colorimetry;
-=20
- 		if (stream->out_transfer_func.tf =3D=3D TRANSFER_FUNCTION_GAMMA22)
- 			tf =3D TRANSFER_FUNC_GAMMA_22;
- 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->outpu=
t_color_space, tf);
- 		aconnector->sr_skip_count =3D AMDGPU_DM_PSR_ENTRY_DELAY;
-=20
- 	}
- finish:
- 	dc_sink_release(sink);
-=20
- 	return stream;
- }
-=20
- /**
-  * amdgpu_dm_connector_poll - Poll a connector to see if it's connected t=
o a display
-  * @aconnector: DM connector to poll (owns @base drm_connector and @dc_li=
nk)
-  * @force: if true, force polling even when DAC load detection was used
-  *
-  * Used for connectors that don't support HPD (hotplug detection) to
-  * periodically check whether the connector is connected to a display.
-  *
-  * When connection was determined via DAC load detection, we avoid
-  * re-running it on normal polls to prevent visible glitches, unless
-  * @force is set.
-  *
-  * Return: The probed connector status (connected/disconnected/unknown).
-  */
- static enum drm_connector_status
- amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool for=
ce)
- {
- 	struct drm_connector *connector =3D &aconnector->base;
- 	struct drm_device *dev =3D connector->dev;
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	struct dc_link *link =3D aconnector->dc_link;
- 	enum dc_connection_type conn_type =3D dc_connection_none;
- 	enum drm_connector_status status =3D connector_status_disconnected;
-=20
- 	/* When we determined the connection using DAC load detection,
- 	 * do NOT poll the connector do detect disconnect because
- 	 * that would run DAC load detection again which can cause
- 	 * visible visual glitches.
- 	 *
- 	 * Only allow to poll such a connector again when forcing.
- 	 */
- 	if (!force && link->local_sink && link->type =3D=3D dc_connection_analog=
_load)
- 		return connector->status;
-=20
- 	mutex_lock(&aconnector->hpd_lock);
-=20
- 	if (dc_link_detect_connection_type(aconnector->dc_link, &conn_type) &&
- 	    conn_type !=3D dc_connection_none) {
- 		mutex_lock(&adev->dm.dc_lock);
-=20
- 		/* Only call full link detection when a sink isn't created yet,
- 		 * ie. just when the display is plugged in, otherwise we risk flickerin=
g.
- 		 */
- 		if (link->local_sink ||
- 			dc_link_detect(link, DETECT_REASON_HPD))
- 			status =3D connector_status_connected;
-=20
- 		mutex_unlock(&adev->dm.dc_lock);
- 	}
-=20
- 	if (connector->status !=3D status) {
- 		if (status =3D=3D connector_status_disconnected) {
- 			if (link->local_sink)
- 				dc_sink_release(link->local_sink);
-=20
- 			link->local_sink =3D NULL;
- 			link->dpcd_sink_count =3D 0;
- 			link->type =3D dc_connection_none;
- 		}
-=20
- 		amdgpu_dm_update_connector_after_detect(aconnector);
- 	}
-=20
- 	mutex_unlock(&aconnector->hpd_lock);
- 	return status;
- }
-=20
- /**
-  * amdgpu_dm_connector_detect() - Detect whether a DRM connector is conne=
cted to a display
-  *
-  * A connector is considered connected when it has a sink that is not NUL=
L.
-  * For connectors that support HPD (hotplug detection), the connection is
-  * handled in the HPD interrupt.
-  * For connectors that may not support HPD, such as analog connectors,
-  * DRM will call this function repeatedly to poll them.
-  *
-  * Notes:
-  * 1. This interface is NOT called in context of HPD irq.
-  * 2. This interface *is called* in context of user-mode ioctl. Which
-  *    makes it a bad place for *any* MST-related activity.
-  *
-  * @connector: The DRM connector we are checking. We convert it to
-  *             amdgpu_dm_connector so we can read the DC link and state.
-  * @force:     If true, do a full detect again. This is used even when
-  *             a lighter check would normally be used to avoid flicker.
-  *
-  * Return: The connector status (connected, disconnected, or unknown).
-  *
-  */
- static enum drm_connector_status
- amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
- {
- 	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(connec=
tor);
-=20
- 	update_subconnector_property(aconnector);
-=20
- 	if (aconnector->base.force =3D=3D DRM_FORCE_ON ||
- 		aconnector->base.force =3D=3D DRM_FORCE_ON_DIGITAL)
- 		return connector_status_connected;
- 	else if (aconnector->base.force =3D=3D DRM_FORCE_OFF)
- 		return connector_status_disconnected;
-=20
- 	/* Poll analog connectors and only when either
- 	 * disconnected or connected to an analog display.
- 	 */
- 	if (drm_kms_helper_is_poll_worker() &&
- 		dc_connector_supports_analog(aconnector->dc_link->link_id.id) &&
- 		(!aconnector->dc_sink || aconnector->dc_sink->edid_caps.analog))
- 		return amdgpu_dm_connector_poll(aconnector, force);
-=20
- 	return (aconnector->dc_sink ? connector_status_connected :
- 			connector_status_disconnected);
- }
-=20
- int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connect=
or,
- 					    struct drm_connector_state *connector_state,
- 					    struct drm_property *property,
- 					    uint64_t val)
- {
- 	struct drm_device *dev =3D connector->dev;
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	struct dm_connector_state *dm_old_state =3D
- 		to_dm_connector_state(connector->state);
- 	struct dm_connector_state *dm_new_state =3D
- 		to_dm_connector_state(connector_state);
-=20
- 	int ret =3D -EINVAL;
-=20
- 	if (property =3D=3D dev->mode_config.scaling_mode_property) {
- 		enum amdgpu_rmx_type rmx_type;
-=20
- 		switch (val) {
- 		case DRM_MODE_SCALE_CENTER:
- 			rmx_type =3D RMX_CENTER;
- 			break;
- 		case DRM_MODE_SCALE_ASPECT:
- 			rmx_type =3D RMX_ASPECT;
- 			break;
- 		case DRM_MODE_SCALE_FULLSCREEN:
- 			rmx_type =3D RMX_FULL;
- 			break;
- 		case DRM_MODE_SCALE_NONE:
- 		default:
- 			rmx_type =3D RMX_OFF;
- 			break;
- 		}
-=20
- 		if (dm_old_state->scaling =3D=3D rmx_type)
- 			return 0;
-=20
- 		dm_new_state->scaling =3D rmx_type;
- 		ret =3D 0;
- 	} else if (property =3D=3D adev->mode_info.underscan_hborder_property) {
- 		dm_new_state->underscan_hborder =3D val;
- 		ret =3D 0;
- 	} else if (property =3D=3D adev->mode_info.underscan_vborder_property) {
- 		dm_new_state->underscan_vborder =3D val;
- 		ret =3D 0;
- 	} else if (property =3D=3D adev->mode_info.underscan_property) {
- 		dm_new_state->underscan_enable =3D val;
- 		ret =3D 0;
- 	} else if (property =3D=3D adev->mode_info.abm_level_property) {
- 		switch (val) {
- 		case ABM_SYSFS_CONTROL:
- 			dm_new_state->abm_sysfs_forbidden =3D false;
- 			break;
- 		case ABM_LEVEL_OFF:
- 			dm_new_state->abm_sysfs_forbidden =3D true;
- 			dm_new_state->abm_level =3D ABM_LEVEL_IMMEDIATE_DISABLE;
- 			break;
- 		default:
- 			dm_new_state->abm_sysfs_forbidden =3D true;
- 			dm_new_state->abm_level =3D val;
- 		}
- 		ret =3D 0;
- 	}
-=20
- 	return ret;
- }
-=20
- int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connect=
or,
- 					    const struct drm_connector_state *state,
- 					    struct drm_property *property,
- 					    uint64_t *val)
- {
- 	struct drm_device *dev =3D connector->dev;
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	struct dm_connector_state *dm_state =3D
- 		to_dm_connector_state(state);
- 	int ret =3D -EINVAL;
-=20
- 	if (property =3D=3D dev->mode_config.scaling_mode_property) {
- 		switch (dm_state->scaling) {
- 		case RMX_CENTER:
- 			*val =3D DRM_MODE_SCALE_CENTER;
- 			break;
- 		case RMX_ASPECT:
- 			*val =3D DRM_MODE_SCALE_ASPECT;
- 			break;
- 		case RMX_FULL:
- 			*val =3D DRM_MODE_SCALE_FULLSCREEN;
- 			break;
- 		case RMX_OFF:
- 		default:
- 			*val =3D DRM_MODE_SCALE_NONE;
- 			break;
- 		}
- 		ret =3D 0;
- 	} else if (property =3D=3D adev->mode_info.underscan_hborder_property) {
- 		*val =3D dm_state->underscan_hborder;
- 		ret =3D 0;
- 	} else if (property =3D=3D adev->mode_info.underscan_vborder_property) {
- 		*val =3D dm_state->underscan_vborder;
- 		ret =3D 0;
- 	} else if (property =3D=3D adev->mode_info.underscan_property) {
- 		*val =3D dm_state->underscan_enable;
- 		ret =3D 0;
- 	} else if (property =3D=3D adev->mode_info.abm_level_property) {
- 		if (!dm_state->abm_sysfs_forbidden)
- 			*val =3D ABM_SYSFS_CONTROL;
- 		else
- 			*val =3D (dm_state->abm_level !=3D ABM_LEVEL_IMMEDIATE_DISABLE) ?
- 				dm_state->abm_level : 0;
- 		ret =3D 0;
- 	}
-=20
- 	return ret;
- }
-=20
- /**
-  * DOC: panel power savings
-  *
-  * The display manager allows you to set your desired **panel power savin=
gs**
-  * level (between 0-4, with 0 representing off), e.g. using the following=
::
-  *
-  *   # echo 3 > /sys/class/drm/card0-eDP-1/amdgpu/panel_power_savings
-  *
-  * Modifying this value can have implications on color accuracy, so tread
-  * carefully.
-  */
-=20
- static ssize_t panel_power_savings_show(struct device *device,
- 					struct device_attribute *attr,
- 					char *buf)
- {
- 	struct drm_connector *connector =3D dev_get_drvdata(device);
- 	struct drm_device *dev =3D connector->dev;
- 	u8 val;
-=20
- 	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
- 	val =3D to_dm_connector_state(connector->state)->abm_level =3D=3D
- 		ABM_LEVEL_IMMEDIATE_DISABLE ? 0 :
- 		to_dm_connector_state(connector->state)->abm_level;
- 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-=20
- 	return sysfs_emit(buf, "%u\n", val);
- }
-=20
- static ssize_t panel_power_savings_store(struct device *device,
- 					 struct device_attribute *attr,
- 					 const char *buf, size_t count)
- {
- 	struct drm_connector *connector =3D dev_get_drvdata(device);
- 	struct drm_device *dev =3D connector->dev;
- 	long val;
- 	int ret;
-=20
- 	ret =3D kstrtol(buf, 0, &val);
-=20
- 	if (ret)
- 		return ret;
-=20
- 	if (val < 0 || val > 4)
- 		return -EINVAL;
-=20
- 	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
- 	if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
- 		ret =3D -EBUSY;
- 	else
- 		to_dm_connector_state(connector->state)->abm_level =3D val ?:
- 			ABM_LEVEL_IMMEDIATE_DISABLE;
- 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-=20
- 	if (ret)
- 		return ret;
-=20
- 	drm_kms_helper_hotplug_event(dev);
-=20
- 	return count;
- }
-=20
- static DEVICE_ATTR_RW(panel_power_savings);
-=20
- static struct attribute *amdgpu_attrs[] =3D {
- 	&dev_attr_panel_power_savings.attr,
- 	NULL
- };
-=20
- static const struct attribute_group amdgpu_group =3D {
- 	.name =3D "amdgpu",
- 	.attrs =3D amdgpu_attrs
- };
-=20
- static bool
- amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_conne=
ctor)
- {
- 	if (amdgpu_dm_abm_level >=3D 0)
- 		return false;
-=20
- 	if (amdgpu_dm_connector->base.connector_type !=3D DRM_MODE_CONNECTOR_eDP)
- 		return false;
-=20
- 	/* check for OLED panels */
- 	if (amdgpu_dm_connector->bl_idx >=3D 0) {
- 		struct drm_device *drm =3D amdgpu_dm_connector->base.dev;
- 		struct amdgpu_display_manager *dm =3D &drm_to_adev(drm)->dm;
- 		struct amdgpu_dm_backlight_caps *caps;
-=20
- 		caps =3D &dm->backlight_caps[amdgpu_dm_connector->bl_idx];
- 		if (caps->aux_support)
- 			return false;
- 	}
-=20
- 	return true;
- }
-=20
- static void amdgpu_dm_connector_unregister(struct drm_connector *connecto=
r)
- {
- 	struct amdgpu_dm_connector *amdgpu_dm_connector =3D to_amdgpu_dm_connect=
or(connector);
-=20
- 	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
- 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
-=20
- 	cec_notifier_conn_unregister(amdgpu_dm_connector->notifier);
- 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
- }
-=20
- static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
- {
- 	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(connec=
tor);
- 	struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
- 	struct amdgpu_display_manager *dm =3D &adev->dm;
-=20
- 	/*
- 	 * Call only if mst_mgr was initialized before since it's not done
- 	 * for all connector types.
- 	 */
- 	if (aconnector->mst_mgr.dev)
- 		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
-=20
- 	/* Cancel and flush any pending HDMI HPD debounce work */
- 	if (aconnector->hdmi_hpd_debounce_delay_ms) {
- 		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
- 		if (aconnector->hdmi_prev_sink) {
- 			dc_sink_release(aconnector->hdmi_prev_sink);
- 			aconnector->hdmi_prev_sink =3D NULL;
- 		}
- 	}
-=20
- 	if (aconnector->bl_idx !=3D -1) {
- 		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
- 		dm->backlight_dev[aconnector->bl_idx] =3D NULL;
- 	}
-=20
- 	if (aconnector->dc_em_sink)
- 		dc_sink_release(aconnector->dc_em_sink);
- 	aconnector->dc_em_sink =3D NULL;
- 	if (aconnector->dc_sink)
- 		dc_sink_release(aconnector->dc_sink);
- 	aconnector->dc_sink =3D NULL;
-=20
- 	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
- 	drm_connector_unregister(connector);
- 	drm_connector_cleanup(connector);
- 	kfree(aconnector->dm_dp_aux.aux.name);
-=20
- 	kfree(connector);
- }
-=20
- void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
- {
- 	struct dm_connector_state *state =3D
- 		to_dm_connector_state(connector->state);
-=20
- 	if (connector->state)
- 		__drm_atomic_helper_connector_destroy_state(connector->state);
-=20
- 	kfree(state);
-=20
- 	state =3D kzalloc_obj(*state);
-=20
- 	if (state) {
- 		state->scaling =3D RMX_OFF;
- 		state->underscan_enable =3D false;
- 		state->underscan_hborder =3D 0;
- 		state->underscan_vborder =3D 0;
- 		state->base.max_requested_bpc =3D 8;
- 		state->vcpi_slots =3D 0;
- 		state->pbn =3D 0;
-=20
- 		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
- 			if (amdgpu_dm_abm_level <=3D 0)
- 				state->abm_level =3D ABM_LEVEL_IMMEDIATE_DISABLE;
- 			else
- 				state->abm_level =3D amdgpu_dm_abm_level;
- 		}
-=20
- 		__drm_atomic_helper_connector_reset(connector, &state->base);
- 	}
- }
-=20
- struct drm_connector_state *
- amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connecto=
r)
- {
- 	struct dm_connector_state *state =3D
- 		to_dm_connector_state(connector->state);
-=20
- 	struct dm_connector_state *new_state =3D
- 			kmemdup(state, sizeof(*state), GFP_KERNEL);
-=20
- 	if (!new_state)
- 		return NULL;
-=20
- 	__drm_atomic_helper_connector_duplicate_state(connector, &new_state->bas=
e);
-=20
- 	new_state->freesync_capable =3D state->freesync_capable;
- 	new_state->abm_level =3D state->abm_level;
- 	new_state->scaling =3D state->scaling;
- 	new_state->underscan_enable =3D state->underscan_enable;
- 	new_state->underscan_hborder =3D state->underscan_hborder;
- 	new_state->underscan_vborder =3D state->underscan_vborder;
- 	new_state->vcpi_slots =3D state->vcpi_slots;
- 	new_state->pbn =3D state->pbn;
- 	return &new_state->base;
- }
-=20
- static int
- amdgpu_dm_connector_late_register(struct drm_connector *connector)
- {
- 	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
- 		to_amdgpu_dm_connector(connector);
- 	int r;
-=20
- 	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector)) {
- 		r =3D sysfs_create_group(&connector->kdev->kobj,
- 				       &amdgpu_group);
- 		if (r)
- 			return r;
- 	}
-=20
- 	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
-=20
- 	if ((connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort) ||
- 	    (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)) {
- 		amdgpu_dm_connector->dm_dp_aux.aux.dev =3D connector->kdev;
- 		r =3D drm_dp_aux_register(&amdgpu_dm_connector->dm_dp_aux.aux);
- 		if (r)
- 			return r;
- 	}
-=20
- #if defined(CONFIG_DEBUG_FS)
- 	connector_debugfs_init(amdgpu_dm_connector);
- #endif
-=20
- 	return 0;
- }
-=20
- static void amdgpu_dm_connector_funcs_force(struct drm_connector *connect=
or)
- {
- 	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(connec=
tor);
- 	struct dc_link *dc_link =3D aconnector->dc_link;
- 	struct dc_sink *dc_em_sink =3D aconnector->dc_em_sink;
- 	const struct drm_edid *drm_edid;
- 	struct i2c_adapter *ddc;
- 	struct drm_device *dev =3D connector->dev;
-=20
- 	if (dc_link && dc_link->aux_mode)
- 		ddc =3D &aconnector->dm_dp_aux.aux.ddc;
- 	else
- 		ddc =3D &aconnector->i2c->base;
-=20
- 	drm_edid =3D drm_edid_read_ddc(connector, ddc);
- 	drm_edid_connector_update(connector, drm_edid);
- 	if (!drm_edid) {
- 		drm_err(dev, "No EDID found on connector: %s.\n", connector->name);
- 		return;
- 	}
-=20
- 	aconnector->drm_edid =3D drm_edid;
- 	/* Update emulated (virtual) sink's EDID */
- 	if (dc_em_sink && dc_link) {
- 		// FIXME: Get rid of drm_edid_raw()
- 		const struct edid *edid =3D drm_edid_raw(drm_edid);
-=20
- 		memset(&dc_em_sink->edid_caps, 0, sizeof(struct dc_edid_caps));
- 		memmove(dc_em_sink->dc_edid.raw_edid, edid,
- 			(edid->extensions + 1) * EDID_LENGTH);
- 		dm_helpers_parse_edid_caps(
- 			dc_link,
- 			&dc_em_sink->dc_edid,
- 			&dc_em_sink->edid_caps);
- 	}
- }
-=20
- static const struct drm_connector_funcs amdgpu_dm_connector_funcs =3D {
- 	.reset =3D amdgpu_dm_connector_funcs_reset,
- 	.detect =3D amdgpu_dm_connector_detect,
- 	.fill_modes =3D drm_helper_probe_single_connector_modes,
- 	.destroy =3D amdgpu_dm_connector_destroy,
- 	.atomic_duplicate_state =3D amdgpu_dm_connector_atomic_duplicate_state,
- 	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
- 	.atomic_set_property =3D amdgpu_dm_connector_atomic_set_property,
- 	.atomic_get_property =3D amdgpu_dm_connector_atomic_get_property,
- 	.late_register =3D amdgpu_dm_connector_late_register,
- 	.early_unregister =3D amdgpu_dm_connector_unregister,
- 	.force =3D amdgpu_dm_connector_funcs_force
- };
-=20
- static int get_modes(struct drm_connector *connector)
- {
- 	return amdgpu_dm_connector_get_modes(connector);
- }
-=20
- static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
- {
- 	struct drm_connector *connector =3D &aconnector->base;
- 	struct dc_link *dc_link =3D aconnector->dc_link;
- 	struct dc_sink_init_data init_params =3D {
- 			.link =3D aconnector->dc_link,
- 			.sink_signal =3D SIGNAL_TYPE_VIRTUAL
- 	};
- 	const struct drm_edid *drm_edid;
- 	const struct edid *edid;
- 	struct i2c_adapter *ddc;
-=20
- 	if (dc_link && dc_link->aux_mode)
- 		ddc =3D &aconnector->dm_dp_aux.aux.ddc;
- 	else
- 		ddc =3D &aconnector->i2c->base;
-=20
- 	drm_edid =3D drm_edid_read_ddc(connector, ddc);
- 	drm_edid_connector_update(connector, drm_edid);
- 	if (!drm_edid) {
- 		drm_err(connector->dev, "No EDID found on connector: %s.\n", connector-=
>name);
- 		return;
- 	}
-=20
- 	if (connector->display_info.is_hdmi)
- 		init_params.sink_signal =3D SIGNAL_TYPE_HDMI_TYPE_A;
-=20
- 	aconnector->drm_edid =3D drm_edid;
-=20
- 	edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
- 	aconnector->dc_em_sink =3D dc_link_add_remote_sink(
- 		aconnector->dc_link,
- 		(uint8_t *)edid,
- 		(edid->extensions + 1) * EDID_LENGTH,
- 		&init_params);
-=20
- 	if (aconnector->base.force =3D=3D DRM_FORCE_ON) {
- 		aconnector->dc_sink =3D aconnector->dc_link->local_sink ?
- 		aconnector->dc_link->local_sink :
- 		aconnector->dc_em_sink;
- 		if (aconnector->dc_sink)
- 			dc_sink_retain(aconnector->dc_sink);
- 	}
- }
-=20
- static void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
- {
- 	struct dc_link *link =3D (struct dc_link *)aconnector->dc_link;
-=20
- 	/*
- 	 * In case of headless boot with force on for DP managed connector
- 	 * Those settings have to be !=3D 0 to get initial modeset
- 	 */
- 	if (link->connector_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT) {
- 		link->verified_link_cap.lane_count =3D LANE_COUNT_FOUR;
- 		link->verified_link_cap.link_rate =3D LINK_RATE_HIGH2;
- 	}
-=20
- 	create_eml_sink(aconnector);
- }
-=20
- static enum dc_status dm_validate_stream_and_context(struct dc *dc,
- 						struct dc_stream_state *stream)
- {
- 	enum dc_status dc_result =3D DC_ERROR_UNEXPECTED;
- 	struct dc_plane_state *dc_plane_state =3D NULL;
- 	struct dc_state *dc_state =3D NULL;
-=20
- 	if (!stream)
- 		goto cleanup;
-=20
- 	dc_plane_state =3D dc_create_plane_state(dc);
- 	if (!dc_plane_state)
- 		goto cleanup;
-=20
- 	dc_state =3D dc_state_create(dc, NULL);
- 	if (!dc_state)
- 		goto cleanup;
-=20
- 	/* populate stream to plane */
- 	dc_plane_state->src_rect.height  =3D stream->src.height;
- 	dc_plane_state->src_rect.width   =3D stream->src.width;
- 	dc_plane_state->dst_rect.height  =3D stream->src.height;
- 	dc_plane_state->dst_rect.width   =3D stream->src.width;
- 	dc_plane_state->clip_rect.height =3D stream->src.height;
- 	dc_plane_state->clip_rect.width  =3D stream->src.width;
- 	dc_plane_state->plane_size.surface_pitch =3D ((stream->src.width + 255) =
/ 256) * 256;
- 	dc_plane_state->plane_size.surface_size.height =3D stream->src.height;
- 	dc_plane_state->plane_size.surface_size.width  =3D stream->src.width;
- 	dc_plane_state->plane_size.chroma_size.height  =3D stream->src.height;
- 	dc_plane_state->plane_size.chroma_size.width   =3D stream->src.width;
- 	dc_plane_state->format =3D SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
- 	dc_plane_state->tiling_info.gfx9.swizzle =3D DC_SW_UNKNOWN;
- 	dc_plane_state->rotation =3D ROTATION_ANGLE_0;
- 	dc_plane_state->is_tiling_rotated =3D false;
- 	dc_plane_state->tiling_info.gfx8.array_mode =3D DC_ARRAY_LINEAR_GENERAL;
-=20
- 	dc_result =3D dc_validate_stream(dc, stream);
- 	if (dc_result =3D=3D DC_OK)
- 		dc_result =3D dc_validate_plane(dc, dc_plane_state);
-=20
- 	if (dc_result =3D=3D DC_OK)
- 		dc_result =3D dc_state_add_stream(dc, dc_state, stream);
-=20
- 	if (dc_result =3D=3D DC_OK && !dc_state_add_plane(
- 						dc,
- 						stream,
- 						dc_plane_state,
- 						dc_state))
- 		dc_result =3D DC_FAIL_ATTACH_SURFACES;
-=20
- 	if (dc_result =3D=3D DC_OK)
- 		dc_result =3D dc_validate_global_state(dc, dc_state, DC_VALIDATE_MODE_O=
NLY);
-=20
- cleanup:
- 	if (dc_state)
- 		dc_state_release(dc_state);
-=20
- 	if (dc_plane_state)
- 		dc_plane_state_release(dc_plane_state);
-=20
- 	return dc_result;
- }
-=20
- struct dc_stream_state *
- create_validate_stream_for_sink(struct drm_connector *connector,
- 				const struct drm_display_mode *drm_mode,
- 				const struct dm_connector_state *dm_state,
- 				const struct dc_stream_state *old_stream)
- {
- 	struct amdgpu_dm_connector *aconnector =3D NULL;
- 	struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
- 	struct dc_stream_state *stream;
- 	const struct drm_connector_state *drm_state =3D dm_state ? &dm_state->ba=
se : NULL;
- 	int requested_bpc =3D drm_state ? drm_state->max_requested_bpc : 8;
- 	enum dc_status dc_result =3D DC_OK;
- 	uint8_t bpc_limit =3D 6;
-=20
- 	if (!dm_state)
- 		return NULL;
-=20
- 	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 		aconnector =3D to_amdgpu_dm_connector(connector);
-=20
- 	if (aconnector &&
- 	    (aconnector->dc_link->connector_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_=
A ||
- 	     aconnector->dc_link->connector_signal =3D=3D SIGNAL_TYPE_HDMI_FRL ||
- 	     aconnector->dc_link->dpcd_caps.dongle_type =3D=3D DISPLAY_DONGLE_DP=
_HDMI_CONVERTER))
- 		bpc_limit =3D 8;
-=20
- 	do {
- 		drm_dbg_kms(connector->dev, "Trying with %d bpc\n", requested_bpc);
- 		stream =3D create_stream_for_sink(connector, drm_mode,
- 						dm_state, old_stream,
- 						requested_bpc);
- 		if (stream =3D=3D NULL) {
- 			drm_err(adev_to_drm(adev), "Failed to create stream for sink!\n");
- 			break;
- 		}
-=20
- 		dc_result =3D dc_validate_stream(adev->dm.dc, stream);
-=20
- 		if (!aconnector) /* writeback connector */
- 			return stream;
-=20
- 		if (dc_result =3D=3D DC_OK && stream->signal =3D=3D SIGNAL_TYPE_DISPLAY=
_PORT_MST)
- 			dc_result =3D dm_dp_mst_is_port_support_mode(aconnector, stream);
-=20
- 		if (dc_result =3D=3D DC_OK)
- 			dc_result =3D dm_validate_stream_and_context(adev->dm.dc, stream);
-=20
- 		if (dc_result !=3D DC_OK) {
- 			drm_dbg_kms(connector->dev, "Pruned mode %d x %d (clk %d) %s %s -- %s\=
n",
- 				      drm_mode->hdisplay,
- 				      drm_mode->vdisplay,
- 				      drm_mode->clock,
- 				      dc_pixel_encoding_to_str(stream->timing.pixel_encoding),
- 				      dc_color_depth_to_str(stream->timing.display_color_depth),
- 				      dc_status_to_str(dc_result));
-=20
- 			dc_stream_release(stream);
- 			stream =3D NULL;
- 			requested_bpc -=3D 2; /* lower bpc to retry validation */
- 		}
-=20
- 	} while (stream =3D=3D NULL && requested_bpc >=3D bpc_limit);
-=20
- 	switch (dc_result) {
- 	/*
- 	 * If we failed to validate DP bandwidth stream with the requested RGB c=
olor depth,
- 	 * we try to fallback and configure in order:
- 	 * YUV422 (8bpc, 6bpc)
- 	 * YUV420 (8bpc, 6bpc)
- 	 */
- 	case DC_FAIL_ENC_VALIDATE:
- 	case DC_EXCEED_DONGLE_CAP:
- 	case DC_NO_DP_LINK_BANDWIDTH:
- 		/* recursively entered twice and already tried both YUV422 and YUV420 */
- 		if (aconnector->force_yuv422_output && aconnector->force_yuv420_output)
- 			break;
- 		/* first failure; try YUV422 */
- 		if (!aconnector->force_yuv422_output) {
- 			drm_dbg_kms(connector->dev, "%s:%d Validation failed with %d, retrying=
 w/ YUV422\n",
- 				    __func__, __LINE__, dc_result);
- 			aconnector->force_yuv422_output =3D true;
- 		/* recursively entered and YUV422 failed, try YUV420 */
- 		} else if (!aconnector->force_yuv420_output) {
- 			drm_dbg_kms(connector->dev, "%s:%d Validation failed with %d, retrying=
 w/ YUV420\n",
- 				    __func__, __LINE__, dc_result);
- 			aconnector->force_yuv420_output =3D true;
- 		}
- 		stream =3D create_validate_stream_for_sink(connector, drm_mode,
- 							 dm_state, old_stream);
- 		aconnector->force_yuv422_output =3D false;
- 		aconnector->force_yuv420_output =3D false;
- 		break;
- 	case DC_OK:
- 		break;
- 	default:
- 		drm_dbg_kms(connector->dev, "%s:%d Unhandled validation failure %d\n",
- 			    __func__, __LINE__, dc_result);
- 		break;
- 	}
-=20
- 	return stream;
- }
-=20
- enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector =
*connector,
- 				   const struct drm_display_mode *mode)
- {
- 	int result =3D MODE_ERROR;
- 	struct dc_sink *dc_sink;
- 	struct drm_display_mode *test_mode;
- 	/* TODO: Unhardcode stream count */
- 	struct dc_stream_state *stream;
- 	/* we always have an amdgpu_dm_connector here since we got
- 	 * here via the amdgpu_dm_connector_helper_funcs
- 	 */
- 	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(connec=
tor);
-=20
- 	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) ||
- 			(mode->flags & DRM_MODE_FLAG_DBLSCAN))
- 		return result;
-=20
- 	/*
- 	 * Only run this the first time mode_valid is called to initilialize
- 	 * EDID mgmt
- 	 */
- 	if (aconnector->base.force !=3D DRM_FORCE_UNSPECIFIED &&
- 		!aconnector->dc_em_sink)
- 		handle_edid_mgmt(aconnector);
-=20
- 	dc_sink =3D to_amdgpu_dm_connector(connector)->dc_sink;
-=20
- 	if (dc_sink =3D=3D NULL && aconnector->base.force !=3D DRM_FORCE_ON_DIGI=
TAL &&
- 				aconnector->base.force !=3D DRM_FORCE_ON) {
- 		drm_err(connector->dev, "dc_sink is NULL!\n");
- 		goto fail;
- 	}
-=20
- 	test_mode =3D drm_mode_duplicate(connector->dev, mode);
- 	if (!test_mode)
- 		goto fail;
-=20
- 	drm_mode_set_crtcinfo(test_mode, 0);
-=20
- 	stream =3D create_validate_stream_for_sink(connector, test_mode,
- 						 to_dm_connector_state(connector->state),
- 						 NULL);
- 	drm_mode_destroy(connector->dev, test_mode);
- 	if (stream) {
- 		dc_stream_release(stream);
- 		result =3D MODE_OK;
- 	}
-=20
- fail:
- 	/* TODO: error handling*/
- 	return result;
- }
-=20
- static int fill_hdr_info_packet(const struct drm_connector_state *state,
- 				struct dc_info_packet *out)
- {
- 	struct hdmi_drm_infoframe frame;
- 	unsigned char buf[30]; /* 26 + 4 */
- 	ssize_t len;
- 	int ret, i;
-=20
- 	memset(out, 0, sizeof(*out));
-=20
- 	if (!state->hdr_output_metadata)
- 		return 0;
-=20
- 	ret =3D drm_hdmi_infoframe_set_hdr_metadata(&frame, state);
- 	if (ret)
- 		return ret;
-=20
- 	len =3D hdmi_drm_infoframe_pack_only(&frame, buf, sizeof(buf));
- 	if (len < 0)
- 		return (int)len;
-=20
- 	/* Static metadata is a fixed 26 bytes + 4 byte header. */
- 	if (len !=3D 30)
- 		return -EINVAL;
-=20
- 	/* Prepare the infopacket for DC. */
- 	switch (state->connector->connector_type) {
- 	case DRM_MODE_CONNECTOR_HDMIA:
- 		out->hb0 =3D 0x87; /* type */
- 		out->hb1 =3D 0x01; /* version */
- 		out->hb2 =3D 0x1A; /* length */
- 		out->sb[0] =3D buf[3]; /* checksum */
- 		i =3D 1;
- 		break;
-=20
- 	case DRM_MODE_CONNECTOR_DisplayPort:
- 	case DRM_MODE_CONNECTOR_eDP:
- 		out->hb0 =3D 0x00; /* sdp id, zero */
- 		out->hb1 =3D 0x87; /* type */
- 		out->hb2 =3D 0x1D; /* payload len - 1 */
- 		out->hb3 =3D (0x13 << 2); /* sdp version */
- 		out->sb[0] =3D 0x01; /* version */
- 		out->sb[1] =3D 0x1A; /* length */
- 		i =3D 2;
- 		break;
-=20
- 	default:
- 		return -EINVAL;
- 	}
-=20
- 	memcpy(&out->sb[i], &buf[4], 26);
- 	out->valid =3D true;
-=20
- 	print_hex_dump(KERN_DEBUG, "HDR SB:", DUMP_PREFIX_NONE, 16, 1, out->sb,
- 		       sizeof(out->sb), false);
-=20
- 	return 0;
- }
-=20
- static int
- amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
- 				 struct drm_atomic_commit *state)
- {
- 	struct drm_connector_state *new_con_state =3D
- 		drm_atomic_get_new_connector_state(state, conn);
- 	struct drm_connector_state *old_con_state =3D
- 		drm_atomic_get_old_connector_state(state, conn);
- 	struct drm_crtc *crtc =3D new_con_state->crtc;
- 	struct drm_crtc_state *new_crtc_state;
- 	struct amdgpu_dm_connector *aconn =3D to_amdgpu_dm_connector(conn);
- 	int ret;
-=20
- 	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
- 		return -EINVAL;
-=20
- 	trace_amdgpu_dm_connector_atomic_check(new_con_state);
-=20
- 	if (conn->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort) {
- 		ret =3D drm_dp_mst_root_conn_atomic_check(new_con_state, &aconn->mst_mg=
r);
- 		if (ret < 0)
- 			return ret;
- 	}
-=20
- 	if (!crtc)
- 		return 0;
-=20
- 	if (new_con_state->privacy_screen_sw_state !=3D old_con_state->privacy_s=
creen_sw_state) {
- 		new_crtc_state =3D drm_atomic_get_crtc_state(state, crtc);
- 		if (IS_ERR(new_crtc_state))
- 			return PTR_ERR(new_crtc_state);
-=20
- 		new_crtc_state->mode_changed =3D true;
- 	}
-=20
- 	if (new_con_state->colorspace !=3D old_con_state->colorspace) {
- 		new_crtc_state =3D drm_atomic_get_crtc_state(state, crtc);
- 		if (IS_ERR(new_crtc_state))
- 			return PTR_ERR(new_crtc_state);
-=20
- 		new_crtc_state->mode_changed =3D true;
- 	}
-=20
- 	if (new_con_state->content_type !=3D old_con_state->content_type) {
- 		new_crtc_state =3D drm_atomic_get_crtc_state(state, crtc);
- 		if (IS_ERR(new_crtc_state))
- 			return PTR_ERR(new_crtc_state);
-=20
- 		new_crtc_state->mode_changed =3D true;
- 	}
-=20
- 	if (!drm_connector_atomic_hdr_metadata_equal(old_con_state, new_con_stat=
e)) {
- 		struct dc_info_packet hdr_infopacket;
-=20
- 		ret =3D fill_hdr_info_packet(new_con_state, &hdr_infopacket);
- 		if (ret)
- 			return ret;
-=20
- 		new_crtc_state =3D drm_atomic_get_crtc_state(state, crtc);
- 		if (IS_ERR(new_crtc_state))
- 			return PTR_ERR(new_crtc_state);
-=20
- 		/*
- 		 * DC considers the stream backends changed if the
- 		 * static metadata changes. Forcing the modeset also
- 		 * gives a simple way for userspace to switch from
- 		 * 8bpc to 10bpc when setting the metadata to enter
- 		 * or exit HDR.
- 		 *
- 		 * Changing the static metadata after it's been
- 		 * set is permissible, however. So only force a
- 		 * modeset if we're entering or exiting HDR.
- 		 */
- 		new_crtc_state->mode_changed =3D new_crtc_state->mode_changed ||
- 			!old_con_state->hdr_output_metadata ||
- 			!new_con_state->hdr_output_metadata;
- 	}
-=20
- 	return 0;
- }
-=20
- static const struct drm_connector_helper_funcs
- amdgpu_dm_connector_helper_funcs =3D {
- 	/*
- 	 * If hotplugging a second bigger display in FB Con mode, bigger resolut=
ion
- 	 * modes will be filtered by drm_mode_validate_size(), and those modes
- 	 * are missing after user start lightdm. So we need to renew modes list.
- 	 * in get_modes call back, not just return the modes count
- 	 */
- 	.get_modes =3D get_modes,
- 	.mode_valid =3D amdgpu_dm_connector_mode_valid,
- 	.atomic_check =3D amdgpu_dm_connector_atomic_check,
- };
-=20
- static void dm_encoder_helper_disable(struct drm_encoder *encoder)
- {
-=20
- }
-=20
- int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_dep=
th)
- {
- 	switch (display_color_depth) {
- 	case COLOR_DEPTH_666:
- 		return 6;
- 	case COLOR_DEPTH_888:
- 		return 8;
- 	case COLOR_DEPTH_101010:
- 		return 10;
- 	case COLOR_DEPTH_121212:
- 		return 12;
- 	case COLOR_DEPTH_141414:
- 		return 14;
- 	case COLOR_DEPTH_161616:
- 		return 16;
- 	default:
- 		break;
- 	}
- 	return 0;
- }
-=20
- static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
- 					  struct drm_crtc_state *crtc_state,
- 					  struct drm_connector_state *conn_state)
- {
- 	struct drm_atomic_commit *state =3D crtc_state->state;
- 	struct drm_connector *connector =3D conn_state->connector;
- 	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(connec=
tor);
- 	struct dm_connector_state *dm_new_connector_state =3D to_dm_connector_st=
ate(conn_state);
- 	const struct drm_display_mode *adjusted_mode =3D &crtc_state->adjusted_m=
ode;
- 	struct drm_dp_mst_topology_mgr *mst_mgr;
- 	struct drm_dp_mst_port *mst_port;
- 	struct drm_dp_mst_topology_state *mst_state;
- 	enum dc_color_depth color_depth;
- 	int clock, bpp =3D 0;
- 	bool is_y420 =3D false;
-=20
- 	if ((connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) ||
- 	    (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS)) {
- 		struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
- 		struct drm_display_mode *native_mode =3D &amdgpu_encoder->native_mode;
- 		enum drm_mode_status result;
-=20
- 		result =3D drm_crtc_helper_mode_valid_fixed(encoder->crtc, adjusted_mod=
e, native_mode);
- 		if (result !=3D MODE_OK && dm_new_connector_state->scaling =3D=3D RMX_O=
FF) {
- 			drm_dbg_driver(encoder->dev,
- 				       "mode %dx%d@%dHz is not native, enabling scaling\n",
- 				       adjusted_mode->hdisplay, adjusted_mode->vdisplay,
- 				       drm_mode_vrefresh(adjusted_mode));
- 			dm_new_connector_state->scaling =3D RMX_ASPECT;
- 		}
- 		return 0;
- 	}
-=20
- 	if (!aconnector->mst_output_port)
- 		return 0;
-=20
- 	mst_port =3D aconnector->mst_output_port;
- 	mst_mgr =3D &aconnector->mst_root->mst_mgr;
-=20
- 	if (!crtc_state->connectors_changed && !crtc_state->mode_changed)
- 		return 0;
-=20
- 	mst_state =3D drm_atomic_get_mst_topology_state(state, mst_mgr);
- 	if (IS_ERR(mst_state))
- 		return PTR_ERR(mst_state);
-=20
- 	mst_state->pbn_div.full =3D dm_mst_get_pbn_divider(aconnector->mst_root-=
>dc_link);
-=20
- 	if (!state->duplicated) {
- 		int max_bpc =3D conn_state->max_requested_bpc;
-=20
- 		is_y420 =3D drm_mode_is_420_also(&connector->display_info, adjusted_mod=
e) &&
- 			  aconnector->force_yuv420_output;
- 		color_depth =3D convert_color_depth_from_display_info(connector,
- 								    is_y420,
- 								    max_bpc);
- 		bpp =3D convert_dc_color_depth_into_bpc(color_depth) * 3;
- 		clock =3D adjusted_mode->clock;
- 		dm_new_connector_state->pbn =3D drm_dp_calc_pbn_mode(clock, bpp << 4);
- 	}
-=20
- 	dm_new_connector_state->vcpi_slots =3D
- 		drm_dp_atomic_find_time_slots(state, mst_mgr, mst_port,
- 					      dm_new_connector_state->pbn);
- 	if (dm_new_connector_state->vcpi_slots < 0) {
- 		drm_dbg_atomic(connector->dev, "failed finding vcpi slots: %d\n", (int)=
dm_new_connector_state->vcpi_slots);
- 		return dm_new_connector_state->vcpi_slots;
- 	}
- 	return 0;
- }
-=20
- const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs =3D {
- 	.disable =3D dm_encoder_helper_disable,
- 	.atomic_check =3D dm_encoder_helper_atomic_check
- };
-=20
  static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *sta=
te,
  					    struct dc_state *dc_state,
  					    struct dsc_mst_fairness_vars *vars)
@@@ -8914,753 -3326,6 +3331,6 @@@
  	return 0;
  }
 =20
- static int to_drm_connector_type(enum signal_type st, uint32_t connector_=
id)
- {
- 	switch (st) {
- 	case SIGNAL_TYPE_HDMI_TYPE_A:
- 		return DRM_MODE_CONNECTOR_HDMIA;
- 	case SIGNAL_TYPE_EDP:
- 		return DRM_MODE_CONNECTOR_eDP;
- 	case SIGNAL_TYPE_LVDS:
- 		return DRM_MODE_CONNECTOR_LVDS;
- 	case SIGNAL_TYPE_RGB:
- 		return DRM_MODE_CONNECTOR_VGA;
- 	case SIGNAL_TYPE_DISPLAY_PORT:
- 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
- 		/* External DP bridges have a different connector type. */
- 		if (connector_id =3D=3D CONNECTOR_ID_VGA)
- 			return DRM_MODE_CONNECTOR_VGA;
- 		else if (connector_id =3D=3D CONNECTOR_ID_LVDS)
- 			return DRM_MODE_CONNECTOR_LVDS;
-=20
- 		return DRM_MODE_CONNECTOR_DisplayPort;
- 	case SIGNAL_TYPE_DVI_DUAL_LINK:
- 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
- 		if (connector_id =3D=3D CONNECTOR_ID_SINGLE_LINK_DVII ||
- 			connector_id =3D=3D CONNECTOR_ID_DUAL_LINK_DVII)
- 			return DRM_MODE_CONNECTOR_DVII;
-=20
- 		return DRM_MODE_CONNECTOR_DVID;
- 	case SIGNAL_TYPE_VIRTUAL:
- 		return DRM_MODE_CONNECTOR_VIRTUAL;
-=20
- 	default:
- 		return DRM_MODE_CONNECTOR_Unknown;
- 	}
- }
-=20
- static struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_conn=
ector *connector)
- {
- 	struct drm_encoder *encoder;
-=20
- 	/* There is only one encoder per connector */
- 	drm_connector_for_each_possible_encoder(connector, encoder)
- 		return encoder;
-=20
- 	return NULL;
- }
-=20
- static void amdgpu_dm_get_native_mode(struct drm_connector *connector)
- {
- 	struct drm_encoder *encoder;
- 	struct amdgpu_encoder *amdgpu_encoder;
-=20
- 	encoder =3D amdgpu_dm_connector_to_encoder(connector);
-=20
- 	if (encoder =3D=3D NULL)
- 		return;
-=20
- 	amdgpu_encoder =3D to_amdgpu_encoder(encoder);
-=20
- 	amdgpu_encoder->native_mode.clock =3D 0;
-=20
- 	if (!list_empty(&connector->probed_modes)) {
- 		struct drm_display_mode *preferred_mode =3D NULL;
-=20
- 		list_for_each_entry(preferred_mode,
- 				    &connector->probed_modes,
- 				    head) {
- 			if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED)
- 				amdgpu_encoder->native_mode =3D *preferred_mode;
-=20
- 			break;
- 		}
-=20
- 	}
- }
-=20
- static struct drm_display_mode *
- amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
- 			     const char *name,
- 			     int hdisplay, int vdisplay)
- {
- 	struct drm_device *dev =3D encoder->dev;
- 	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
- 	struct drm_display_mode *mode =3D NULL;
- 	struct drm_display_mode *native_mode =3D &amdgpu_encoder->native_mode;
-=20
- 	mode =3D drm_mode_duplicate(dev, native_mode);
-=20
- 	if (mode =3D=3D NULL)
- 		return NULL;
-=20
- 	mode->hdisplay =3D hdisplay;
- 	mode->vdisplay =3D vdisplay;
- 	mode->type &=3D ~DRM_MODE_TYPE_PREFERRED;
- 	strscpy(mode->name, name, DRM_DISPLAY_MODE_LEN);
-=20
- 	return mode;
-=20
- }
-=20
- static const struct amdgpu_dm_mode_size {
- 	char name[DRM_DISPLAY_MODE_LEN];
- 	int w;
- 	int h;
- } common_modes[] =3D {
- 	{  "640x480",  640,  480},
- 	{  "800x600",  800,  600},
- 	{ "1024x768", 1024,  768},
- 	{ "1280x720", 1280,  720},
- 	{ "1280x800", 1280,  800},
- 	{"1280x1024", 1280, 1024},
- 	{ "1440x900", 1440,  900},
- 	{"1680x1050", 1680, 1050},
- 	{"1600x1200", 1600, 1200},
- 	{"1920x1080", 1920, 1080},
- 	{"1920x1200", 1920, 1200}
- };
-=20
- static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *enco=
der,
- 						 struct drm_connector *connector)
- {
- 	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);
- 	struct drm_display_mode *mode =3D NULL;
- 	struct drm_display_mode *native_mode =3D &amdgpu_encoder->native_mode;
- 	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
- 				to_amdgpu_dm_connector(connector);
- 	int i;
- 	int n;
-=20
- 	if ((connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP) &&
- 	    (connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS))
- 		return;
-=20
- 	n =3D ARRAY_SIZE(common_modes);
-=20
- 	for (i =3D 0; i < n; i++) {
- 		struct drm_display_mode *curmode =3D NULL;
- 		bool mode_existed =3D false;
-=20
- 		if (common_modes[i].w > native_mode->hdisplay ||
- 		    common_modes[i].h > native_mode->vdisplay ||
- 		   (common_modes[i].w =3D=3D native_mode->hdisplay &&
- 		    common_modes[i].h =3D=3D native_mode->vdisplay))
- 			continue;
-=20
- 		list_for_each_entry(curmode, &connector->probed_modes, head) {
- 			if (common_modes[i].w =3D=3D curmode->hdisplay &&
- 			    common_modes[i].h =3D=3D curmode->vdisplay) {
- 				mode_existed =3D true;
- 				break;
- 			}
- 		}
-=20
- 		if (mode_existed)
- 			continue;
-=20
- 		mode =3D amdgpu_dm_create_common_mode(encoder,
- 				common_modes[i].name, common_modes[i].w,
- 				common_modes[i].h);
- 		if (!mode)
- 			continue;
-=20
- 		drm_mode_probed_add(connector, mode);
- 		amdgpu_dm_connector->num_modes++;
- 	}
- }
-=20
- static void amdgpu_set_panel_orientation(struct drm_connector *connector)
- {
- 	struct drm_encoder *encoder;
- 	struct amdgpu_encoder *amdgpu_encoder;
- 	const struct drm_display_mode *native_mode;
-=20
- 	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP &&
- 	    connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS)
- 		return;
-=20
- 	mutex_lock(&connector->dev->mode_config.mutex);
- 	amdgpu_dm_connector_get_modes(connector);
- 	mutex_unlock(&connector->dev->mode_config.mutex);
-=20
- 	encoder =3D amdgpu_dm_connector_to_encoder(connector);
- 	if (!encoder)
- 		return;
-=20
- 	amdgpu_encoder =3D to_amdgpu_encoder(encoder);
-=20
- 	native_mode =3D &amdgpu_encoder->native_mode;
- 	if (native_mode->hdisplay =3D=3D 0 || native_mode->vdisplay =3D=3D 0)
- 		return;
-=20
- 	drm_connector_set_panel_orientation_with_quirk(connector,
- 						       DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
- 						       native_mode->hdisplay,
- 						       native_mode->vdisplay);
- }
-=20
- static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *conne=
ctor,
- 					      const struct drm_edid *drm_edid)
- {
- 	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
- 			to_amdgpu_dm_connector(connector);
-=20
- 	if (drm_edid) {
- 		/* empty probed_modes */
- 		INIT_LIST_HEAD(&connector->probed_modes);
- 		amdgpu_dm_connector->num_modes =3D
- 				drm_edid_connector_add_modes(connector);
-=20
- 		/* sorting the probed modes before calling function
- 		 * amdgpu_dm_get_native_mode() since EDID can have
- 		 * more than one preferred mode. The modes that are
- 		 * later in the probed mode list could be of higher
- 		 * and preferred resolution. For example, 3840x2160
- 		 * resolution in base EDID preferred timing and 4096x2160
- 		 * preferred resolution in DID extension block later.
- 		 */
- 		drm_mode_sort(&connector->probed_modes);
- 		amdgpu_dm_get_native_mode(connector);
-=20
- 		/* Freesync capabilities are reset by calling
- 		 * drm_edid_connector_add_modes() and need to be
- 		 * restored here.
- 		 */
- 		amdgpu_dm_update_freesync_caps(connector, drm_edid, false);
- 	} else {
- 		amdgpu_dm_connector->num_modes =3D 0;
- 	}
- }
-=20
- static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
- 			      struct drm_display_mode *mode)
- {
- 	struct drm_display_mode *m;
-=20
- 	list_for_each_entry(m, &aconnector->base.probed_modes, head) {
- 		if (drm_mode_equal(m, mode))
- 			return true;
- 	}
-=20
- 	return false;
- }
-=20
- static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
- {
- 	const struct drm_display_mode *m;
- 	struct drm_display_mode *new_mode;
- 	uint i;
- 	u32 new_modes_count =3D 0;
-=20
- 	/* Standard FPS values
- 	 *
- 	 * 23.976       - TV/NTSC
- 	 * 24           - Cinema
- 	 * 25           - TV/PAL
- 	 * 29.97        - TV/NTSC
- 	 * 30           - TV/NTSC
- 	 * 48           - Cinema HFR
- 	 * 50           - TV/PAL
- 	 * 60           - Commonly used
- 	 * 48,72,96,120 - Multiples of 24
- 	 */
- 	static const u32 common_rates[] =3D {
- 		23976, 24000, 25000, 29970, 30000,
- 		48000, 50000, 60000, 72000, 96000, 120000
- 	};
-=20
- 	/*
- 	 * Find mode with highest refresh rate with the same resolution
- 	 * as the preferred mode. Some monitors report a preferred mode
- 	 * with lower resolution than the highest refresh rate supported.
- 	 */
-=20
- 	m =3D get_highest_refresh_rate_mode(aconnector, true);
- 	if (!m)
- 		return 0;
-=20
- 	for (i =3D 0; i < ARRAY_SIZE(common_rates); i++) {
- 		u64 target_vtotal, target_vtotal_diff;
- 		u64 num, den;
-=20
- 		if (drm_mode_vrefresh(m) * 1000 < common_rates[i])
- 			continue;
-=20
- 		if (common_rates[i] < aconnector->min_vfreq * 1000 ||
- 		    common_rates[i] > aconnector->max_vfreq * 1000)
- 			continue;
-=20
- 		num =3D (unsigned long long)m->clock * 1000 * 1000;
- 		den =3D common_rates[i] * (unsigned long long)m->htotal;
- 		target_vtotal =3D div_u64(num, den);
- 		target_vtotal_diff =3D target_vtotal - m->vtotal;
-=20
- 		/* Check for illegal modes */
- 		if (m->vsync_start + target_vtotal_diff < m->vdisplay ||
- 		    m->vsync_end + target_vtotal_diff < m->vsync_start ||
- 		    m->vtotal + target_vtotal_diff < m->vsync_end)
- 			continue;
-=20
- 		new_mode =3D drm_mode_duplicate(aconnector->base.dev, m);
- 		if (!new_mode)
- 			goto out;
-=20
- 		new_mode->vtotal +=3D (u16)target_vtotal_diff;
- 		new_mode->vsync_start +=3D (u16)target_vtotal_diff;
- 		new_mode->vsync_end +=3D (u16)target_vtotal_diff;
- 		new_mode->type &=3D ~DRM_MODE_TYPE_PREFERRED;
- 		new_mode->type |=3D DRM_MODE_TYPE_DRIVER;
-=20
- 		if (!is_duplicate_mode(aconnector, new_mode)) {
- 			drm_mode_probed_add(&aconnector->base, new_mode);
- 			new_modes_count +=3D 1;
- 		} else
- 			drm_mode_destroy(aconnector->base.dev, new_mode);
- 	}
-  out:
- 	return new_modes_count;
- }
-=20
- static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *=
connector,
- 						   const struct drm_edid *drm_edid)
- {
- 	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
- 		to_amdgpu_dm_connector(connector);
-=20
- 	if (!(amdgpu_freesync_vid_mode && drm_edid))
- 		return;
-=20
- 	if (!amdgpu_dm_connector->dc_sink || !amdgpu_dm_connector->dc_link)
- 		return;
-=20
- 	if (!dc_supports_vrr(amdgpu_dm_connector->dc_sink->ctx->dce_version))
- 		return;
-=20
- 	if (dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.i=
d) &&
- 	    amdgpu_dm_connector->dc_sink->edid_caps.analog)
- 		return;
-=20
- 	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
- 		amdgpu_dm_connector->num_modes +=3D
- 			add_fs_modes(amdgpu_dm_connector);
- }
-=20
- static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
- {
- 	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
- 			to_amdgpu_dm_connector(connector);
- 	struct dc_link *dc_link =3D amdgpu_dm_connector->dc_link;
- 	struct drm_encoder *encoder;
- 	const struct drm_edid *drm_edid =3D amdgpu_dm_connector->drm_edid;
- 	struct dc_link_settings *verified_link_cap =3D &dc_link->verified_link_c=
ap;
- 	const struct dc *dc =3D dc_link->dc;
-=20
- 	encoder =3D amdgpu_dm_connector_to_encoder(connector);
-=20
- 	if (!drm_edid) {
- 		amdgpu_dm_connector->num_modes =3D
- 				drm_add_modes_noedid(connector, 640, 480);
- 		if (dc->link_srv->dp_get_encoding_format(verified_link_cap) =3D=3D DP_1=
28b_132b_ENCODING)
- 			amdgpu_dm_connector->num_modes +=3D
- 				drm_add_modes_noedid(connector, 1920, 1080);
-=20
- 		if (amdgpu_dm_connector->dc_sink &&
- 		    amdgpu_dm_connector->dc_sink->edid_caps.analog &&
- 		    dc_connector_supports_analog(dc_link->link_id.id)) {
- 			/* Analog monitor connected by DAC load detection.
- 			 * Add common modes. It will be up to the user to select one that work=
s.
- 			 */
- 			for (int i =3D 0; i < ARRAY_SIZE(common_modes); i++)
- 				amdgpu_dm_connector->num_modes +=3D drm_add_modes_noedid(
- 					connector, common_modes[i].w, common_modes[i].h);
- 		}
- 	} else {
- 		amdgpu_dm_connector_ddc_get_modes(connector, drm_edid);
- 		if (encoder)
- 			amdgpu_dm_connector_add_common_modes(encoder, connector);
- 		amdgpu_dm_connector_add_freesync_modes(connector, drm_edid);
- 	}
- 	amdgpu_dm_fbc_init(connector);
-=20
- 	return amdgpu_dm_connector->num_modes;
- }
-=20
- static const u32 supported_colorspaces =3D
- 	BIT(DRM_MODE_COLORIMETRY_BT709_YCC) |
- 	BIT(DRM_MODE_COLORIMETRY_OPRGB) |
- 	BIT(DRM_MODE_COLORIMETRY_BT2020_RGB) |
- 	BIT(DRM_MODE_COLORIMETRY_BT2020_YCC);
-=20
- void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
- 				     struct amdgpu_dm_connector *aconnector,
- 				     int connector_type,
- 				     struct dc_link *link,
- 				     int link_index)
- {
- 	struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
-=20
- 	/*
- 	 * Some of the properties below require access to state, like bpc.
- 	 * Allocate some default initial connector state with our reset helper.
- 	 */
- 	if (aconnector->base.funcs->reset)
- 		aconnector->base.funcs->reset(&aconnector->base);
-=20
- 	aconnector->connector_id =3D link_index;
- 	aconnector->bl_idx =3D -1;
- 	aconnector->dc_link =3D link;
- 	aconnector->base.interlace_allowed =3D false;
- 	aconnector->base.doublescan_allowed =3D false;
- 	aconnector->base.stereo_allowed =3D false;
- 	aconnector->base.dpms =3D DRM_MODE_DPMS_OFF;
- 	aconnector->hpd.hpd =3D AMDGPU_HPD_NONE; /* not used */
- 	aconnector->audio_inst =3D -1;
- 	aconnector->pack_sdp_v1_3 =3D false;
- 	aconnector->as_type =3D ADAPTIVE_SYNC_TYPE_NONE;
- 	memset(&aconnector->vsdb_info, 0, sizeof(aconnector->vsdb_info));
- 	mutex_init(&aconnector->hpd_lock);
- 	mutex_init(&aconnector->handle_mst_msg_ready);
-=20
- 	/*
- 	 * If HDMI HPD debounce delay is set, use the minimum between selected
- 	 * value and AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS
- 	 */
- 	if (amdgpu_hdmi_hpd_debounce_delay_ms) {
- 		aconnector->hdmi_hpd_debounce_delay_ms =3D min(amdgpu_hdmi_hpd_debounce=
_delay_ms,
- 							     AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS);
- 		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounc=
e_work);
- 		aconnector->hdmi_prev_sink =3D NULL;
- 	} else {
- 		aconnector->hdmi_hpd_debounce_delay_ms =3D 0;
- 	}
-=20
- 	/*
- 	 * configure support HPD hot plug connector_>polled default value is 0
- 	 * which means HPD hot plug not supported
- 	 */
- 	switch (connector_type) {
- 	case DRM_MODE_CONNECTOR_HDMIA:
- 		aconnector->base.polled =3D DRM_CONNECTOR_POLL_HPD;
- 		aconnector->base.ycbcr_420_allowed =3D
- 			link->link_enc->features.hdmi_ycbcr420_supported ? true : false;
- 		break;
- 	case DRM_MODE_CONNECTOR_DisplayPort:
- 		aconnector->base.polled =3D DRM_CONNECTOR_POLL_HPD;
- 		link->link_enc =3D link_enc_cfg_get_link_enc(link);
- 		ASSERT(link->link_enc);
- 		if (link->link_enc)
- 			aconnector->base.ycbcr_420_allowed =3D
- 			link->link_enc->features.dp_ycbcr420_supported ? true : false;
- 		break;
- 	case DRM_MODE_CONNECTOR_DVID:
- 		aconnector->base.polled =3D DRM_CONNECTOR_POLL_HPD;
- 		break;
- 	case DRM_MODE_CONNECTOR_DVII:
- 	case DRM_MODE_CONNECTOR_VGA:
- 		aconnector->base.polled =3D
- 			DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
- 		break;
- 	default:
- 		break;
- 	}
-=20
- 	drm_object_attach_property(&aconnector->base.base,
- 				dm->ddev->mode_config.scaling_mode_property,
- 				DRM_MODE_SCALE_NONE);
-=20
- 	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA
- 		|| (connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort && !aconnector=
->mst_root))
- 		drm_connector_attach_broadcast_rgb_property(&aconnector->base);
-=20
- 	drm_object_attach_property(&aconnector->base.base,
- 				adev->mode_info.underscan_property,
- 				UNDERSCAN_OFF);
- 	drm_object_attach_property(&aconnector->base.base,
- 				adev->mode_info.underscan_hborder_property,
- 				0);
- 	drm_object_attach_property(&aconnector->base.base,
- 				adev->mode_info.underscan_vborder_property,
- 				0);
-=20
- 	if (!aconnector->mst_root)
- 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
-=20
- 	aconnector->base.state->max_bpc =3D 16;
- 	aconnector->base.state->max_requested_bpc =3D aconnector->base.state->ma=
x_bpc;
-=20
- 	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
- 		/* Content Type is currently only implemented for HDMI. */
- 		drm_connector_attach_content_type_property(&aconnector->base);
- 	}
-=20
- 	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
- 		if (!drm_mode_create_hdmi_colorspace_property(&aconnector->base, suppor=
ted_colorspaces))
- 			drm_connector_attach_colorspace_property(&aconnector->base);
- 	} else if ((connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort && !aco=
nnector->mst_root) ||
- 		   connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
- 		if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supporte=
d_colorspaces))
- 			drm_connector_attach_colorspace_property(&aconnector->base);
- 	}
-=20
- 	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA ||
- 	    connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
- 	    connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
- 		drm_connector_attach_hdr_output_metadata_property(&aconnector->base);
-=20
- 		if (!aconnector->mst_root)
- 			drm_connector_attach_vrr_capable_property(&aconnector->base);
-=20
- 		if (adev->dm.hdcp_workqueue)
- 			drm_connector_attach_content_protection_property(&aconnector->base, tr=
ue);
- 	}
-=20
- 	if (connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
- 		struct drm_privacy_screen *privacy_screen;
-=20
- 		drm_connector_attach_panel_type_property(&aconnector->base);
-=20
- 		privacy_screen =3D drm_privacy_screen_get(adev_to_drm(adev)->dev, NULL);
- 		if (!IS_ERR(privacy_screen)) {
- 			drm_connector_attach_privacy_screen_provider(&aconnector->base,
- 								     privacy_screen);
- 		} else if (PTR_ERR(privacy_screen) !=3D -ENODEV) {
- 			drm_warn(adev_to_drm(adev), "Error getting privacy-screen\n");
- 		}
- 	}
- }
-=20
- static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
- 			      struct i2c_msg *msgs, int num)
- {
- 	struct amdgpu_i2c_adapter *i2c =3D i2c_get_adapdata(i2c_adap);
- 	struct ddc_service *ddc_service =3D i2c->ddc_service;
- 	struct i2c_command cmd;
- 	int i;
- 	int result =3D -EIO;
-=20
- 	if (!ddc_service->ddc_pin)
- 		return result;
-=20
- 	cmd.payloads =3D kzalloc_objs(struct i2c_payload, num);
-=20
- 	if (!cmd.payloads)
- 		return result;
-=20
- 	cmd.number_of_payloads =3D num;
- 	cmd.engine =3D I2C_COMMAND_ENGINE_DEFAULT;
- 	cmd.speed =3D 100;
-=20
- 	for (i =3D 0; i < num; i++) {
- 		cmd.payloads[i].write =3D !(msgs[i].flags & I2C_M_RD);
- 		cmd.payloads[i].address =3D msgs[i].addr;
- 		cmd.payloads[i].length =3D msgs[i].len;
- 		cmd.payloads[i].data =3D msgs[i].buf;
- 	}
-=20
- 	if (i2c->oem) {
- 		if (dc_submit_i2c_oem(
- 			    ddc_service->ctx->dc,
- 			    &cmd))
- 			result =3D num;
- 	} else {
- 		if (dc_submit_i2c(
- 			    ddc_service->ctx->dc,
- 			    ddc_service->link->link_index,
- 			    &cmd))
- 			result =3D num;
- 	}
-=20
- 	kfree(cmd.payloads);
- 	return result;
- }
-=20
- static u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap)
- {
- 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
- }
-=20
- static const struct i2c_algorithm amdgpu_dm_i2c_algo =3D {
- 	.master_xfer =3D amdgpu_dm_i2c_xfer,
- 	.functionality =3D amdgpu_dm_i2c_func,
- };
-=20
- static struct amdgpu_i2c_adapter *
- create_i2c(struct ddc_service *ddc_service, bool oem)
- {
- 	struct amdgpu_device *adev =3D ddc_service->ctx->driver_context;
- 	struct amdgpu_i2c_adapter *i2c;
-=20
- 	i2c =3D kzalloc_obj(struct amdgpu_i2c_adapter);
- 	if (!i2c)
- 		return NULL;
- 	i2c->base.owner =3D THIS_MODULE;
- 	i2c->base.dev.parent =3D &adev->pdev->dev;
- 	i2c->base.algo =3D &amdgpu_dm_i2c_algo;
- 	if (oem)
- 		snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c OEM bus=
");
- 	else
- 		snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus =
%d",
- 			 ddc_service->link->link_index);
- 	i2c_set_adapdata(&i2c->base, i2c);
- 	i2c->ddc_service =3D ddc_service;
- 	i2c->oem =3D oem;
-=20
- 	return i2c;
- }
-=20
- int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconn=
ector)
- {
- 	struct cec_connector_info conn_info;
- 	struct drm_device *ddev =3D aconnector->base.dev;
- 	struct device *hdmi_dev =3D ddev->dev;
-=20
- 	if (amdgpu_dc_debug_mask & DC_DISABLE_HDMI_CEC) {
- 		drm_info(ddev, "HDMI-CEC feature masked\n");
- 		return -EINVAL;
- 	}
-=20
- 	cec_fill_conn_info_from_drm(&conn_info, &aconnector->base);
- 	aconnector->notifier =3D
- 		cec_notifier_conn_register(hdmi_dev, NULL, &conn_info);
- 	if (!aconnector->notifier) {
- 		drm_err(ddev, "Failed to create cec notifier\n");
- 		return -ENOMEM;
- 	}
-=20
- 	return 0;
- }
-=20
- /*
-  * Note: this function assumes that dc_link_detect() was called for the
-  * dc_link which will be represented by this aconnector.
-  */
- static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
- 				    struct amdgpu_dm_connector *aconnector,
- 				    u32 link_index,
- 				    struct amdgpu_encoder *aencoder)
- {
- 	int res =3D 0;
- 	int connector_type;
- 	struct dc *dc =3D dm->dc;
- 	struct dc_link *link =3D dc_get_link_at_index(dc, link_index);
- 	struct amdgpu_i2c_adapter *i2c;
-=20
- 	/* Not needed for writeback connector */
- 	link->priv =3D aconnector;
-=20
-=20
- 	i2c =3D create_i2c(link->ddc, false);
- 	if (!i2c) {
- 		drm_err(adev_to_drm(dm->adev), "Failed to create i2c adapter data\n");
- 		return -ENOMEM;
- 	}
-=20
- 	aconnector->i2c =3D i2c;
- 	res =3D devm_i2c_add_adapter(dm->adev->dev, &i2c->base);
-=20
- 	if (res) {
- 		drm_err(adev_to_drm(dm->adev), "Failed to register hw i2c %d\n", link->=
link_index);
- 		goto out_free;
- 	}
-=20
- 	connector_type =3D to_drm_connector_type(link->connector_signal, link->l=
ink_id.id);
-=20
- 	res =3D drm_connector_init_with_ddc(
- 			dm->ddev,
- 			&aconnector->base,
- 			&amdgpu_dm_connector_funcs,
- 			connector_type,
- 			&i2c->base);
-=20
- 	if (res) {
- 		drm_err(adev_to_drm(dm->adev), "connector_init failed\n");
- 		aconnector->connector_id =3D -1;
- 		goto out_free;
- 	}
-=20
- 	drm_connector_helper_add(
- 			&aconnector->base,
- 			&amdgpu_dm_connector_helper_funcs);
-=20
- 	amdgpu_dm_connector_init_helper(
- 		dm,
- 		aconnector,
- 		connector_type,
- 		link,
- 		link_index);
-=20
- 	drm_connector_attach_encoder(
- 		&aconnector->base, &aencoder->base);
-=20
- 	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA ||
- 	    connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIB)
- 		amdgpu_dm_initialize_hdmi_connector(aconnector);
-=20
- 	if (dc_is_dp_signal(link->connector_signal))
- 		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
-=20
- out_free:
- 	if (res) {
- 		kfree(i2c);
- 		aconnector->i2c =3D NULL;
- 	}
- 	return res;
- }
-=20
- int amdgpu_dm_get_encoder_crtc_mask(struct amdgpu_device *adev)
- {
- 	switch (adev->mode_info.num_crtc) {
- 	case 1:
- 		return 0x1;
- 	case 2:
- 		return 0x3;
- 	case 3:
- 		return 0x7;
- 	case 4:
- 		return 0xf;
- 	case 5:
- 		return 0x1f;
- 	case 6:
- 	default:
- 		return 0x3f;
- 	}
- }
-=20
- static int amdgpu_dm_encoder_init(struct drm_device *dev,
- 				  struct amdgpu_encoder *aencoder,
- 				  uint32_t link_index)
- {
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
-=20
- 	int res =3D drm_encoder_init(dev,
- 				   &aencoder->base,
- 				   &amdgpu_dm_encoder_funcs,
- 				   DRM_MODE_ENCODER_TMDS,
- 				   NULL);
-=20
- 	aencoder->base.possible_crtcs =3D amdgpu_dm_get_encoder_crtc_mask(adev);
-=20
- 	if (!res)
- 		aencoder->encoder_id =3D link_index;
- 	else
- 		aencoder->encoder_id =3D -1;
-=20
- 	drm_encoder_helper_add(&aencoder->base, &amdgpu_dm_encoder_helper_funcs);
-=20
- 	return res;
- }
-=20
  static void manage_dm_interrupts(struct amdgpu_device *adev,
  				 struct amdgpu_crtc *acrtc,
  				 struct dm_crtc_state *acrtc_state)
@@@ -9760,7 -3425,7 +3430,7 @@@ static void dm_update_pflip_irq_state(s
  	amdgpu_irq_update(adev, &adev->pageflip_irq, irq_type);
  }
 =20
- static bool
+ STATIC_IFN_KUNIT bool
  is_scaling_state_different(const struct dm_connector_state *dm_state,
  			   const struct dm_connector_state *old_dm_state)
  {
@@@ -9777,13 -3442,15 +3447,15 @@@
  		return true;
  	return false;
  }
+ EXPORT_IF_KUNIT(is_scaling_state_different);
 =20
- static bool is_content_protection_different(struct drm_crtc_state *new_cr=
tc_state,
- 					    struct drm_crtc_state *old_crtc_state,
- 					    struct drm_connector_state *new_conn_state,
- 					    struct drm_connector_state *old_conn_state,
- 					    const struct drm_connector *connector,
- 					    struct hdcp_workqueue *hdcp_w)
+ STATIC_IFN_KUNIT bool
+ is_content_protection_different(struct drm_crtc_state *new_crtc_state,
+ 				struct drm_crtc_state *old_crtc_state,
+ 				struct drm_connector_state *new_conn_state,
+ 				struct drm_connector_state *old_conn_state,
+ 				const struct drm_connector *connector,
+ 				struct hdcp_workqueue *hdcp_w)
  {
  	struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(connec=
tor);
  	struct dm_connector_state *dm_con_state =3D to_dm_connector_state(connec=
tor->state);
@@@ -9897,6 -3564,7 +3569,7 @@@
  	pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
  	return false;
  }
+ EXPORT_IF_KUNIT(is_content_protection_different);
 =20
  static void remove_stream(struct amdgpu_device *adev,
  			  struct amdgpu_crtc *acrtc,
@@@ -9908,213 -3576,6 +3581,6 @@@
  	acrtc->enabled =3D false;
  }
 =20
- static void update_freesync_state_on_stream(
- 	struct amdgpu_display_manager *dm,
- 	struct dm_crtc_state *new_crtc_state,
- 	struct dc_stream_state *new_stream,
- 	struct dc_plane_state *surface,
- 	u32 flip_timestamp_in_us)
- {
- 	struct mod_vrr_params vrr_params;
- 	struct dc_info_packet vrr_infopacket =3D {0};
- 	struct amdgpu_device *adev =3D dm->adev;
- 	struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(new_crtc_state->base.crtc);
- 	unsigned long flags;
- 	bool pack_sdp_v1_3 =3D false;
- 	struct amdgpu_dm_connector *aconn;
- 	enum vrr_packet_type packet_type =3D PACKET_TYPE_VRR;
-=20
- 	if (!new_stream)
- 		return;
-=20
- 	/*
- 	 * TODO: Determine why min/max totals and vrefresh can be 0 here.
- 	 * For now it's sufficient to just guard against these conditions.
- 	 */
-=20
- 	if (!new_stream->timing.h_total || !new_stream->timing.v_total)
- 		return;
-=20
- 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
- 	vrr_params =3D acrtc->dm_irq_params.vrr_params;
-=20
- 	if (surface) {
- 		mod_freesync_handle_preflip(
- 			dm->freesync_module,
- 			surface,
- 			new_stream,
- 			flip_timestamp_in_us,
- 			&vrr_params);
-=20
- 		if (adev->family < AMDGPU_FAMILY_AI &&
- 		    amdgpu_dm_crtc_vrr_active(new_crtc_state)) {
- 			mod_freesync_handle_v_update(dm->freesync_module,
- 						     new_stream, &vrr_params);
-=20
- 			/* Need to call this before the frame ends. */
- 			dc_stream_adjust_vmin_vmax(dm->dc,
- 						   new_crtc_state->stream,
- 						   &vrr_params.adjust);
- 		}
- 	}
-=20
- 	aconn =3D (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
-=20
- 	if (aconn && (aconn->as_type =3D=3D FREESYNC_TYPE_PCON_IN_WHITELIST || a=
conn->vsdb_info.replay_mode)) {
- 		pack_sdp_v1_3 =3D aconn->pack_sdp_v1_3;
-=20
- 		if (aconn->vsdb_info.amd_vsdb_version =3D=3D 1)
- 			packet_type =3D PACKET_TYPE_FS_V1;
- 		else if (aconn->vsdb_info.amd_vsdb_version =3D=3D 2)
- 			packet_type =3D PACKET_TYPE_FS_V2;
- 		else if (aconn->vsdb_info.amd_vsdb_version =3D=3D 3)
- 			packet_type =3D PACKET_TYPE_FS_V3;
-=20
- 		mod_build_adaptive_sync_infopacket(new_stream, aconn->as_type, NULL,
- 					&new_stream->adaptive_sync_infopacket);
- 	}
-=20
- 	mod_freesync_build_vrr_infopacket(
- 		dm->freesync_module,
- 		new_stream,
- 		&vrr_params,
- 		packet_type,
- 		TRANSFER_FUNC_UNKNOWN,
- 		&vrr_infopacket,
- 		pack_sdp_v1_3);
-=20
- 	new_crtc_state->freesync_vrr_info_changed |=3D
- 		(memcmp(&new_crtc_state->vrr_infopacket,
- 			&vrr_infopacket,
- 			sizeof(vrr_infopacket)) !=3D 0);
-=20
- 	acrtc->dm_irq_params.vrr_params =3D vrr_params;
- 	new_crtc_state->vrr_infopacket =3D vrr_infopacket;
-=20
- 	new_stream->vrr_infopacket =3D vrr_infopacket;
- 	new_stream->allow_freesync =3D mod_freesync_get_freesync_enabled(&vrr_pa=
rams);
-=20
- 	if (new_crtc_state->freesync_vrr_info_changed)
- 		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=3D%u enabled=3D=
%d state=3D%d",
- 			      new_crtc_state->base.crtc->base.id,
- 			      (int)new_crtc_state->base.vrr_enabled,
- 			      (int)vrr_params.state);
-=20
- 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
- }
-=20
- static void update_stream_irq_parameters(
- 	struct amdgpu_display_manager *dm,
- 	struct dm_crtc_state *new_crtc_state)
- {
- 	struct dc_stream_state *new_stream =3D new_crtc_state->stream;
- 	struct mod_vrr_params vrr_params;
- 	struct mod_freesync_config config =3D new_crtc_state->freesync_config;
- 	struct amdgpu_device *adev =3D dm->adev;
- 	struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(new_crtc_state->base.crtc);
- 	unsigned long flags;
-=20
- 	if (!new_stream)
- 		return;
-=20
- 	/*
- 	 * TODO: Determine why min/max totals and vrefresh can be 0 here.
- 	 * For now it's sufficient to just guard against these conditions.
- 	 */
- 	if (!new_stream->timing.h_total || !new_stream->timing.v_total)
- 		return;
-=20
- 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
- 	vrr_params =3D acrtc->dm_irq_params.vrr_params;
-=20
- 	if (new_crtc_state->vrr_supported &&
- 	    config.min_refresh_in_uhz &&
- 	    config.max_refresh_in_uhz) {
- 		/*
- 		 * if freesync compatible mode was set, config.state will be set
- 		 * in atomic check
- 		 */
- 		if (config.state =3D=3D VRR_STATE_ACTIVE_FIXED && config.fixed_refresh_=
in_uhz &&
- 		    (!drm_atomic_crtc_needs_modeset(&new_crtc_state->base) ||
- 		     new_crtc_state->freesync_config.state =3D=3D VRR_STATE_ACTIVE_FIXE=
D)) {
- 			vrr_params.max_refresh_in_uhz =3D config.max_refresh_in_uhz;
- 			vrr_params.min_refresh_in_uhz =3D config.min_refresh_in_uhz;
- 			vrr_params.fixed_refresh_in_uhz =3D config.fixed_refresh_in_uhz;
- 			vrr_params.state =3D VRR_STATE_ACTIVE_FIXED;
- 		} else {
- 			config.state =3D new_crtc_state->base.vrr_enabled ?
- 						     VRR_STATE_ACTIVE_VARIABLE :
- 						     VRR_STATE_INACTIVE;
- 		}
- 	} else {
- 		config.state =3D VRR_STATE_UNSUPPORTED;
- 	}
-=20
- 	mod_freesync_build_vrr_params(dm->freesync_module,
- 				      new_stream,
- 				      &config, &vrr_params);
-=20
- 	new_crtc_state->freesync_config =3D config;
- 	/* Copy state for access from DM IRQ handler */
- 	acrtc->dm_irq_params.freesync_config =3D config;
- 	acrtc->dm_irq_params.active_planes =3D new_crtc_state->active_planes;
- 	acrtc->dm_irq_params.vrr_params =3D vrr_params;
- 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
- }
-=20
- static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager=
 *dm,
- 					    struct dm_crtc_state *old_state,
- 					    struct dm_crtc_state *new_state)
- {
- 	struct amdgpu_device *adev =3D drm_to_adev(new_state->base.crtc->dev);
- 	bool old_vrr_active =3D amdgpu_dm_crtc_vrr_active(old_state);
- 	bool new_vrr_active =3D amdgpu_dm_crtc_vrr_active(new_state);
-=20
- 	/* Only DCE gates vupdate on VRR, keep it enabled for DCN */
- 	bool vrr_gates_vupdate =3D amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D 0;
-=20
- 	if (!old_vrr_active && new_vrr_active) {
- 		/* Transition VRR inactive -> active:
- 		 * While VRR is active, we must not disable vblank irq, as a
- 		 * reenable after disable would compute bogus vblank/pflip
- 		 * timestamps if it likely happened inside display front-porch.
- 		 *
- 		 * We also need vupdate irq for the actual core vblank handling
- 		 * at end of vblank.
- 		 */
- 		if (vrr_gates_vupdate)
- 			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) !=
=3D 0);
- 		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) !=3D 0);
- 		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR off->on: G=
et vblank ref\n",
- 				 __func__, new_state->base.crtc->base.id);
-=20
- 		scoped_guard(mutex, &dm->dc_lock) {
- 			dc_exit_ips_for_hw_access(dm->dc);
- 			amdgpu_dm_psr_set_event(dm, new_state->stream, true,
- 				psr_event_vrr_transition, true);
- 			amdgpu_dm_replay_set_event(dm, new_state->stream, true,
- 				replay_event_vrr, true);
- 		}
- 	} else if (old_vrr_active && !new_vrr_active) {
- 		/* Transition VRR active -> inactive:
- 		 * Allow vblank irq disable again for fixed refresh rate.
- 		 */
- 		if (vrr_gates_vupdate)
- 			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) !=
=3D 0);
- 		drm_crtc_vblank_put(new_state->base.crtc);
- 		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR on->off: D=
rop vblank ref\n",
- 				 __func__, new_state->base.crtc->base.id);
-=20
- 		scoped_guard(mutex, &dm->dc_lock) {
- 			dc_exit_ips_for_hw_access(dm->dc);
- 			amdgpu_dm_psr_set_event(dm, new_state->stream, false,
- 				psr_event_vrr_transition, false);
- 			amdgpu_dm_replay_set_event(dm, new_state->stream, false,
- 				replay_event_vrr, false);
- 		}
- 	}
- }
-=20
  static void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
  {
  	struct drm_plane *plane;
@@@ -10401,14 -3862,12 +3867,12 @@@ static void amdgpu_dm_commit_planes(str
  			continue;
 =20
  		bundle->surface_updates[planes_count].surface =3D dc_plane;
- 		if (new_pcrtc_state->color_mgmt_changed || new_plane_state->color_mgmt_=
changed) {
+ 		if (new_pcrtc_state->color_mgmt_changed) {
  			bundle->surface_updates[planes_count].gamma =3D &dc_plane->gamma_corre=
ction;
  			bundle->surface_updates[planes_count].in_transfer_func =3D &dc_plane->=
in_transfer_func;
  			bundle->surface_updates[planes_count].gamut_remap_matrix =3D &dc_plane=
->gamut_remap_matrix;
  			bundle->surface_updates[planes_count].hdr_mult =3D dc_plane->hdr_mult;
- 			bundle->surface_updates[planes_count].func_shaper =3D &dc_plane->in_sh=
aper_func;
- 			bundle->surface_updates[planes_count].lut3d_func =3D &dc_plane->lut3d_=
func;
- 			bundle->surface_updates[planes_count].blend_tf =3D &dc_plane->blend_tf;
+ 			bundle->surface_updates[planes_count].cm =3D &dc_plane->cm;
  		}
 =20
  		amdgpu_dm_plane_fill_dc_scaling_info(dm->adev, new_plane_state,
@@@ -10428,7 -3887,6 +3892,6 @@@
 =20
  		fill_dc_plane_info_and_addr(
  			dm->adev, new_plane_state,
- 			afb->tiling_flags,
  			&bundle->plane_infos[planes_count],
  			&bundle->flip_addrs[planes_count].address,
  			afb->tmz_surface);
@@@ -10503,7 -3961,7 +3966,7 @@@
  		}
 =20
  		if (plane =3D=3D pcrtc->primary)
- 			update_freesync_state_on_stream(
+ 			amdgpu_dm_update_freesync_state_on_stream(
  				dm,
  				acrtc_state,
  				acrtc_state->stream,
@@@ -10624,7 -4082,7 +4087,7 @@@
  		 * re-adjust the min/max bounds now that DC doesn't handle this
  		 * as part of commit.
  		 */
- 		if (is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_state)) {
+ 		if (amdgpu_dm_is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_state=
)) {
  			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
  			dc_stream_adjust_vmin_vmax(
  				dm->dc, acrtc_state->stream,
@@@ -10784,87 -4242,6 +4247,6 @@@ cleanup
  	kfree(bundle);
  }
 =20
- static void amdgpu_dm_commit_audio(struct drm_device *dev,
- 				   struct drm_atomic_commit *state)
- {
- 	struct amdgpu_device *adev =3D drm_to_adev(dev);
- 	struct amdgpu_dm_connector *aconnector;
- 	struct drm_connector *connector;
- 	struct drm_connector_state *old_con_state, *new_con_state;
- 	struct drm_crtc_state *new_crtc_state;
- 	struct dm_crtc_state *new_dm_crtc_state;
- 	const struct dc_stream_status *status;
- 	int i, inst;
-=20
- 	/* Notify device removals. */
- 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_=
con_state, i) {
- 		if (old_con_state->crtc !=3D new_con_state->crtc) {
- 			/* CRTC changes require notification. */
- 			goto notify;
- 		}
-=20
- 		if (!new_con_state->crtc)
- 			continue;
-=20
- 		new_crtc_state =3D drm_atomic_get_new_crtc_state(
- 			state, new_con_state->crtc);
-=20
- 		if (!new_crtc_state)
- 			continue;
-=20
- 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
- 			continue;
-=20
- notify:
- 		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 			continue;
-=20
- 		aconnector =3D to_amdgpu_dm_connector(connector);
-=20
- 		mutex_lock(&adev->dm.audio_lock);
- 		inst =3D aconnector->audio_inst;
- 		aconnector->audio_inst =3D -1;
- 		mutex_unlock(&adev->dm.audio_lock);
-=20
- 		amdgpu_dm_audio_eld_notify(adev, inst);
- 	}
-=20
- 	/* Notify audio device additions. */
- 	for_each_new_connector_in_state(state, connector, new_con_state, i) {
- 		if (!new_con_state->crtc)
- 			continue;
-=20
- 		new_crtc_state =3D drm_atomic_get_new_crtc_state(
- 			state, new_con_state->crtc);
-=20
- 		if (!new_crtc_state)
- 			continue;
-=20
- 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
- 			continue;
-=20
- 		new_dm_crtc_state =3D to_dm_crtc_state(new_crtc_state);
- 		if (!new_dm_crtc_state->stream)
- 			continue;
-=20
- 		status =3D dc_stream_get_status(new_dm_crtc_state->stream);
- 		if (!status)
- 			continue;
-=20
- 		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 			continue;
-=20
- 		aconnector =3D to_amdgpu_dm_connector(connector);
-=20
- 		mutex_lock(&adev->dm.audio_lock);
- 		inst =3D status->audio_inst;
- 		aconnector->audio_inst =3D inst;
- 		mutex_unlock(&adev->dm.audio_lock);
-=20
- 		amdgpu_dm_audio_eld_notify(adev, inst);
- 	}
- }
-=20
  /*
   * amdgpu_dm_crtc_copy_transient_flags - copy mirrored flags from DRM to =
DC
   * @crtc_state: the DRM CRTC state
@@@ -10879,10 -4256,57 +4261,57 @@@ static void amdgpu_dm_crtc_copy_transie
  	stream_state->mode_changed =3D drm_atomic_crtc_needs_modeset(crtc_state);
  }
 =20
+ /**
+  * amdgpu_dm_crtc_complete_writeback - finish a pending writeback job
+  * @acrtc: the CRTC whose pending writeback should be completed
+  *
+  * Clears the pending state, signals the writeback out fence and releases=
 the
+  * vblank reference taken in dm_set_writeback() while the writeback was a=
rmed.
+  * The pending flag is tested and cleared under the writeback job lock, s=
o this
+  * is safe to call concurrently from the completion vblank IRQ
+  * (dm_crtc_high_irq()) and from the writeback teardown path
+  * (dm_clear_writeback()); only the caller that observes the pending job
+  * performs the completion.
+  *
+  * Return: true if a pending writeback job was completed by this call.
+  */
+ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
+ {
+ 	unsigned long flags;
+ 	bool pending;
+=20
+ 	if (!acrtc->wb_conn)
+ 		return false;
+=20
+ 	spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
+ 	pending =3D acrtc->wb_pending;
+ 	acrtc->wb_pending =3D false;
+ 	acrtc->wb_frame_done =3D false;
+ 	spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
+=20
+ 	if (!pending)
+ 		return false;
+=20
+ 	drm_writeback_signal_completion(acrtc->wb_conn, 0);
+ 	drm_crtc_vblank_put(&acrtc->base);
+=20
+ 	return true;
+ }
+ EXPORT_IF_KUNIT(amdgpu_dm_crtc_complete_writeback);
+=20
  static void dm_clear_writeback(struct amdgpu_display_manager *dm,
+ 			      struct amdgpu_crtc *acrtc,
  			      struct dm_crtc_state *crtc_state)
  {
  	dc_stream_remove_writeback(dm->dc, crtc_state->stream, 0);
+=20
+ 	/*
+ 	 * If the writeback is still pending when it is torn down (its
+ 	 * completion vblank IRQ never fired), signal the out fence so a
+ 	 * waiting client does not stall and release the vblank reference
+ 	 * taken in dm_set_writeback().
+ 	 */
+ 	amdgpu_dm_crtc_complete_writeback(acrtc);
  }
 =20
  /**
@@@ -11035,7 -4459,7 +4464,7 @@@ static void amdgpu_dm_commit_streams(st
 =20
  		dm_old_crtc_state =3D to_dm_crtc_state(old_crtc_state);
 =20
- 		dm_clear_writeback(dm, dm_old_crtc_state);
+ 		dm_clear_writeback(dm, acrtc, dm_old_crtc_state);
  		acrtc->wb_enabled =3D false;
  	}
 =20
@@@ -11309,9 -4733,25 +4738,25 @@@ static void dm_set_writeback(struct amd
 =20
  	dc_stream_add_writeback(dm->dc, crtc_state->stream, wb_info);
 =20
- 	acrtc->wb_pending =3D true;
  	acrtc->wb_conn =3D wb_conn;
  	drm_writeback_queue_job(wb_conn, new_con_state);
+=20
+ 	/*
+ 	 * Writeback completion is detected in the CRTC vblank IRQ
+ 	 * (dm_crtc_high_irq()). Take a vblank reference so the vblank interrupt
+ 	 * stays enabled while the writeback is pending; otherwise a
+ 	 * writeback-only commit right after drm_crtc_vblank_on() (e.g.
+ 	 * re-enabling a CRTC that was disabled) has no other vblank reference,
+ 	 * the IRQ never fires and the out fence times out. The matching put
+ 	 * happens once completion is signalled in dm_crtc_high_irq(), or when
+ 	 * the writeback is torn down in dm_clear_writeback().
+ 	 *
+ 	 * Arm wb_pending only after the reference is held so the completion IRQ
+ 	 * cannot run its matching vblank_put before this get.
+ 	 */
+ 	WARN_ON(drm_crtc_vblank_get(&acrtc->base));
+ 	acrtc->wb_frame_done =3D false;
+ 	acrtc->wb_pending =3D true;
  }
 =20
  static void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
@@@ -11462,6 -4902,75 +4907,75 @@@ static int amdgpu_dm_atomic_setup_commi
  	return 0;
  }
 =20
+ STATIC_IFN_KUNIT void set_multisync_trigger_params(
+ 		struct dc_stream_state *stream)
+ {
+ 	struct dc_stream_state *master =3D NULL;
+=20
+ 	if (stream->triggered_crtc_reset.enabled) {
+ 		master =3D stream->triggered_crtc_reset.event_source;
+ 		stream->triggered_crtc_reset.event =3D
+ 			master->timing.flags.VSYNC_POSITIVE_POLARITY ?
+ 			CRTC_EVENT_VSYNC_RISING : CRTC_EVENT_VSYNC_FALLING;
+ 		stream->triggered_crtc_reset.delay =3D TRIGGER_DELAY_NEXT_PIXEL;
+ 	}
+ }
+ EXPORT_IF_KUNIT(set_multisync_trigger_params);
+=20
+ STATIC_IFN_KUNIT void set_master_stream(struct dc_stream_state *stream_se=
t[],
+ 					int stream_count)
+ {
+ 	int j, highest_rfr =3D 0, master_stream =3D 0;
+=20
+ 	for (j =3D 0;  j < stream_count; j++) {
+ 		if (stream_set[j] && stream_set[j]->triggered_crtc_reset.enabled) {
+ 			int refresh_rate =3D 0;
+=20
+ 			refresh_rate =3D (stream_set[j]->timing.pix_clk_100hz*100)/
+ 				(stream_set[j]->timing.h_total*stream_set[j]->timing.v_total);
+ 			if (refresh_rate > highest_rfr) {
+ 				highest_rfr =3D refresh_rate;
+ 				master_stream =3D j;
+ 			}
+ 		}
+ 	}
+ 	for (j =3D 0;  j < stream_count; j++) {
+ 		if (stream_set[j])
+ 			stream_set[j]->triggered_crtc_reset.event_source =3D stream_set[master=
_stream];
+ 	}
+ }
+ EXPORT_IF_KUNIT(set_master_stream);
+=20
+ STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_stat=
e *context)
+ {
+ 	int i =3D 0;
+ 	struct dc_stream_state *stream;
+=20
+ 	if (context->stream_count < 2)
+ 		return;
+ 	for (i =3D 0; i < context->stream_count ; i++) {
+ 		if (!context->streams[i])
+ 			continue;
+ 		/*
+ 		 * TODO: add a function to read AMD VSDB bits and set
+ 		 * crtc_sync_master.multi_sync_enabled flag
+ 		 * For now it's set to false
+ 		 */
+ 	}
+=20
+ 	set_master_stream(context->streams, context->stream_count);
+=20
+ 	for (i =3D 0; i < context->stream_count ; i++) {
+ 		stream =3D context->streams[i];
+=20
+ 		if (!stream)
+ 			continue;
+=20
+ 		set_multisync_trigger_params(stream);
+ 	}
+ }
+ EXPORT_IF_KUNIT(dm_enable_per_frame_crtc_master_sync);
+=20
  /**
   * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementatio=
n.
   * @state: The atomic state to commit
@@@ -11530,7 -5039,7 +5044,7 @@@ static void amdgpu_dm_atomic_commit_tai
 =20
  		if ((new_con_state->hdmi.broadcast_rgb !=3D old_con_state->hdmi.broadca=
st_rgb) &&
  			(dm_old_crtc_state->stream->output_color_space !=3D
- 				get_output_color_space(&dm_new_crtc_state->stream->timing, new_con_st=
ate)))
+ 				amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing, =
new_con_state)))
  			output_color_space_changed =3D true;
 =20
  		abm_changed =3D dm_new_crtc_state->abm_level !=3D
@@@ -11544,7 -5053,7 +5058,7 @@@
 =20
  		stream_update.stream =3D dm_new_crtc_state->stream;
  		if (scaling_changed) {
- 			update_stream_scaling_settings(dev, &dm_new_con_state->base.crtc->mode,
+ 			amdgpu_dm_update_stream_scaling_settings(dev, &dm_new_con_state->base.=
crtc->mode,
  					dm_new_con_state, dm_new_crtc_state->stream);
 =20
  			stream_update.src =3D dm_new_crtc_state->stream->src;
@@@ -11553,7 -5062,7 +5067,7 @@@
 =20
  		if (output_color_space_changed) {
  			dm_new_crtc_state->stream->output_color_space
- 				=3D get_output_color_space(&dm_new_crtc_state->stream->timing, new_co=
n_state);
+ 				=3D amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timi=
ng, new_con_state);
 =20
  			stream_update.output_color_space =3D &dm_new_crtc_state->stream->outpu=
t_color_space;
  		}
@@@ -11565,7 -5074,7 +5079,7 @@@
  		}
 =20
  		if (hdr_changed) {
- 			fill_hdr_info_packet(new_con_state, &hdr_packet);
+ 			amdgpu_dm_fill_hdr_info_packet(new_con_state, &hdr_packet);
  			stream_update.hdr_static_metadata =3D &hdr_packet;
  		}
 =20
@@@ -11624,7 -5133,7 +5138,7 @@@
  		dm_old_crtc_state =3D to_dm_crtc_state(old_crtc_state);
 =20
  		/* For freesync config update on crtc state and params for irq */
- 		update_stream_irq_parameters(dm, dm_new_crtc_state);
+ 		amdgpu_dm_update_stream_irq_parameters(dm, dm_new_crtc_state);
 =20
  #ifdef CONFIG_DEBUG_FS
  		spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
@@@ -11773,104 -5282,6 +5287,6 @@@
  	trace_amdgpu_dm_atomic_commit_tail_finish(state);
  }
 =20
- static int dm_force_atomic_commit(struct drm_connector *connector)
- {
- 	int ret =3D 0;
- 	struct drm_device *ddev =3D connector->dev;
- 	struct drm_atomic_commit *state =3D drm_atomic_commit_alloc(ddev);
- 	struct amdgpu_crtc *disconnected_acrtc =3D to_amdgpu_crtc(connector->enc=
oder->crtc);
- 	struct drm_plane *plane =3D disconnected_acrtc->base.primary;
- 	struct drm_connector_state *conn_state;
- 	struct drm_crtc_state *crtc_state;
- 	struct drm_plane_state *plane_state;
-=20
- 	if (!state)
- 		return -ENOMEM;
-=20
- 	state->acquire_ctx =3D ddev->mode_config.acquire_ctx;
-=20
- 	/* Construct an atomic state to restore previous display setting */
-=20
- 	/*
- 	 * Attach connectors to drm_atomic_commit
- 	 */
- 	conn_state =3D drm_atomic_get_connector_state(state, connector);
-=20
- 	/* Check for error in getting connector state */
- 	if (IS_ERR(conn_state)) {
- 		ret =3D PTR_ERR(conn_state);
- 		goto out;
- 	}
-=20
- 	/* Attach crtc to drm_atomic_commit*/
- 	crtc_state =3D drm_atomic_get_crtc_state(state, &disconnected_acrtc->bas=
e);
-=20
- 	/* Check for error in getting crtc state */
- 	if (IS_ERR(crtc_state)) {
- 		ret =3D PTR_ERR(crtc_state);
- 		goto out;
- 	}
-=20
- 	/* force a restore */
- 	crtc_state->mode_changed =3D true;
-=20
- 	/* Attach plane to drm_atomic_commit */
- 	plane_state =3D drm_atomic_get_plane_state(state, plane);
-=20
- 	/* Check for error in getting plane state */
- 	if (IS_ERR(plane_state)) {
- 		ret =3D PTR_ERR(plane_state);
- 		goto out;
- 	}
-=20
- 	/* Call commit internally with the state we just constructed */
- 	ret =3D drm_atomic_commit(state);
-=20
- out:
- 	drm_atomic_commit_put(state);
- 	if (ret)
- 		drm_err(ddev, "Restoring old state failed with %i\n", ret);
-=20
- 	return ret;
- }
-=20
- /*
-  * This function handles all cases when set mode does not come upon hotpl=
ug.
-  * This includes when a display is unplugged then plugged back into the
-  * same port and when running without usermode desktop manager supprot
-  */
- void dm_restore_drm_connector_state(struct drm_device *dev,
- 				    struct drm_connector *connector)
- {
- 	struct amdgpu_dm_connector *aconnector;
- 	struct amdgpu_crtc *disconnected_acrtc;
- 	struct dm_crtc_state *acrtc_state;
-=20
- 	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
- 		return;
-=20
- 	aconnector =3D to_amdgpu_dm_connector(connector);
-=20
- 	if (!aconnector->dc_sink || !connector->state || !connector->encoder)
- 		return;
-=20
- 	disconnected_acrtc =3D to_amdgpu_crtc(connector->encoder->crtc);
- 	if (!disconnected_acrtc)
- 		return;
-=20
- 	acrtc_state =3D to_dm_crtc_state(disconnected_acrtc->base.state);
- 	if (!acrtc_state->stream)
- 		return;
-=20
- 	/*
- 	 * If the previous sink is not released and different from the current,
- 	 * we deduce we are in a state where we can not rely on usermode call
- 	 * to turn on the display, so we do it here
- 	 */
- 	if (acrtc_state->stream->sink !=3D aconnector->dc_sink)
- 		dm_force_atomic_commit(&aconnector->base);
- }
-=20
  /*
   * Grabs all modesetting locks to serialize against any blocking commits,
   * Waits for completion of all non blocking commits.
@@@ -11922,104 -5333,6 +5338,6 @@@ static int do_aquire_global_lock(struc
  	return ret < 0 ? ret : 0;
  }
 =20
- static void get_freesync_config_for_crtc(
- 	struct dm_crtc_state *new_crtc_state,
- 	struct dm_connector_state *new_con_state)
- {
- 	struct mod_freesync_config config =3D {0};
- 	struct amdgpu_dm_connector *aconnector;
- 	struct drm_display_mode *mode =3D &new_crtc_state->base.mode;
- 	int vrefresh =3D drm_mode_vrefresh(mode);
- 	bool fs_vid_mode =3D false;
-=20
- 	if (new_con_state->base.connector->connector_type =3D=3D DRM_MODE_CONNEC=
TOR_WRITEBACK)
- 		return;
-=20
- 	aconnector =3D to_amdgpu_dm_connector(new_con_state->base.connector);
-=20
- 	new_crtc_state->vrr_supported =3D new_con_state->freesync_capable &&
- 					vrefresh >=3D aconnector->min_vfreq &&
- 					vrefresh <=3D aconnector->max_vfreq;
-=20
- 	if (new_crtc_state->vrr_supported) {
- 		new_crtc_state->stream->ignore_msa_timing_param =3D true;
- 		fs_vid_mode =3D new_crtc_state->freesync_config.state =3D=3D VRR_STATE_=
ACTIVE_FIXED;
-=20
- 		config.min_refresh_in_uhz =3D aconnector->min_vfreq * 1000000;
- 		config.max_refresh_in_uhz =3D aconnector->max_vfreq * 1000000;
- 		config.vsif_supported =3D true;
- 		config.btr =3D true;
-=20
- 		if (fs_vid_mode) {
- 			config.state =3D VRR_STATE_ACTIVE_FIXED;
- 			config.fixed_refresh_in_uhz =3D new_crtc_state->freesync_config.fixed_=
refresh_in_uhz;
- 			goto out;
- 		} else if (new_crtc_state->base.vrr_enabled) {
- 			config.state =3D VRR_STATE_ACTIVE_VARIABLE;
- 		} else {
- 			config.state =3D VRR_STATE_INACTIVE;
- 		}
- 	} else {
- 		config.state =3D VRR_STATE_UNSUPPORTED;
- 	}
- out:
- 	new_crtc_state->freesync_config =3D config;
- }
-=20
- static void reset_freesync_config_for_crtc(
- 	struct dm_crtc_state *new_crtc_state)
- {
- 	new_crtc_state->vrr_supported =3D false;
-=20
- 	memset(&new_crtc_state->vrr_infopacket, 0,
- 	       sizeof(new_crtc_state->vrr_infopacket));
- }
-=20
- static bool
- is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
- 				 struct drm_crtc_state *new_crtc_state)
- {
- 	const struct drm_display_mode *old_mode, *new_mode;
-=20
- 	if (!old_crtc_state || !new_crtc_state)
- 		return false;
-=20
- 	old_mode =3D &old_crtc_state->mode;
- 	new_mode =3D &new_crtc_state->mode;
-=20
- 	if (old_mode->clock       =3D=3D new_mode->clock &&
- 	    old_mode->hdisplay    =3D=3D new_mode->hdisplay &&
- 	    old_mode->vdisplay    =3D=3D new_mode->vdisplay &&
- 	    old_mode->htotal      =3D=3D new_mode->htotal &&
- 	    old_mode->vtotal      !=3D new_mode->vtotal &&
- 	    old_mode->hsync_start =3D=3D new_mode->hsync_start &&
- 	    old_mode->vsync_start !=3D new_mode->vsync_start &&
- 	    old_mode->hsync_end   =3D=3D new_mode->hsync_end &&
- 	    old_mode->vsync_end   !=3D new_mode->vsync_end &&
- 	    old_mode->hskew       =3D=3D new_mode->hskew &&
- 	    old_mode->vscan       =3D=3D new_mode->vscan &&
- 	    (old_mode->vsync_end - old_mode->vsync_start) =3D=3D
- 	    (new_mode->vsync_end - new_mode->vsync_start))
- 		return true;
-=20
- 	return false;
- }
-=20
- static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_s=
tate)
- {
- 	u64 num, den, res;
- 	struct drm_crtc_state *new_crtc_state =3D &dm_new_crtc_state->base;
-=20
- 	dm_new_crtc_state->freesync_config.state =3D VRR_STATE_ACTIVE_FIXED;
-=20
- 	num =3D (unsigned long long)new_crtc_state->mode.clock * 1000 * 1000000;
- 	den =3D (unsigned long long)new_crtc_state->mode.htotal *
- 	      (unsigned long long)new_crtc_state->mode.vtotal;
-=20
- 	res =3D div_u64(num, den);
- 	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz =3D res;
- }
-=20
  static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
  			 struct drm_atomic_commit *state,
  			 struct drm_crtc *crtc,
@@@ -12072,7 -5385,7 +5390,7 @@@
  		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
  			goto skip_modeset;
 =20
- 		new_stream =3D create_validate_stream_for_sink(connector,
+ 		new_stream =3D amdgpu_dm_create_validate_stream_for_sink(connector,
  							     &new_crtc_state->mode,
  							     dm_new_conn_state,
  							     dm_old_crtc_state->stream);
@@@ -12100,7 -5413,7 +5418,7 @@@
 =20
  		dm_new_crtc_state->abm_level =3D dm_new_conn_state->abm_level;
 =20
- 		ret =3D fill_hdr_info_packet(drm_new_conn_state,
+ 		ret =3D amdgpu_dm_fill_hdr_info_packet(drm_new_conn_state,
  					   &new_stream->hdr_static_metadata);
  		if (ret)
  			goto fail;
@@@ -12116,7 -5429,7 +5434,7 @@@
  		 */
  		if (amdgpu_freesync_vid_mode &&
  		    dm_new_crtc_state->stream &&
- 		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
+ 		    amdgpu_dm_is_timing_unchanged_for_freesync(new_crtc_state, old_crtc=
_state))
  			goto skip_modeset;
 =20
  		if (dm_new_crtc_state->stream &&
@@@ -12158,24 -5471,24 +5476,24 @@@
  		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
  		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
  		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->strea=
m) &&
- 		    is_timing_unchanged_for_freesync(new_crtc_state,
+ 		    amdgpu_dm_is_timing_unchanged_for_freesync(new_crtc_state,
  						     old_crtc_state)) {
  			new_crtc_state->mode_changed =3D false;
  			drm_dbg_driver(adev_to_drm(adev),
  				"Mode change not required for front porch change, setting mode_change=
d to %d",
  				new_crtc_state->mode_changed);
 =20
- 			set_freesync_fixed_config(dm_new_crtc_state);
+ 			amdgpu_dm_set_freesync_fixed_config(dm_new_crtc_state);
 =20
  			goto skip_modeset;
  		} else if (amdgpu_freesync_vid_mode && aconnector &&
- 			   is_freesync_video_mode(&new_crtc_state->mode,
+ 			   amdgpu_dm_is_freesync_video_mode(&new_crtc_state->mode,
  						  aconnector)) {
  			struct drm_display_mode *high_mode;
 =20
- 			high_mode =3D get_highest_refresh_rate_mode(aconnector, false);
+ 			high_mode =3D amdgpu_dm_get_highest_refresh_rate_mode(aconnector, fals=
e);
  			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
- 				set_freesync_fixed_config(dm_new_crtc_state);
+ 				amdgpu_dm_set_freesync_fixed_config(dm_new_crtc_state);
  		}
 =20
  		ret =3D dm_atomic_get_state(state, &dm_state);
@@@ -12197,7 -5510,7 +5515,7 @@@
  		dc_stream_release(dm_old_crtc_state->stream);
  		dm_new_crtc_state->stream =3D NULL;
 =20
- 		reset_freesync_config_for_crtc(dm_new_crtc_state);
+ 		amdgpu_dm_reset_freesync_config_for_crtc(dm_new_crtc_state);
 =20
  		*lock_and_validation_needed =3D true;
 =20
@@@ -12266,7 -5579,7 +5584,7 @@@ skip_modeset
  	/* Scaling or underscan settings */
  	if (is_scaling_state_different(dm_old_conn_state, dm_new_conn_state) ||
  				drm_atomic_crtc_needs_modeset(new_crtc_state))
- 		update_stream_scaling_settings(adev_to_drm(adev),
+ 		amdgpu_dm_update_stream_scaling_settings(adev_to_drm(adev),
  			&new_crtc_state->mode, dm_new_conn_state, dm_new_crtc_state->stream);
 =20
  	/* ABM settings */
@@@ -12285,7 -5598,7 +5603,7 @@@
  	}
 =20
  	/* Update Freesync settings. */
- 	get_freesync_config_for_crtc(dm_new_crtc_state,
+ 	amdgpu_dm_get_freesync_config_for_crtc(dm_new_crtc_state,
  				     dm_new_conn_state);
 =20
  	return ret;
@@@ -12362,10 -5675,6 +5680,6 @@@ static bool should_reset_plane(struct d
  	if (new_crtc_state->color_mgmt_changed)
  		return true;
 =20
- 	/* Plane color pipeline or its colorop changes. */
- 	if (new_plane_state->color_mgmt_changed)
- 		return true;
-=20
  	/*
  	 * On zpos change, planes need to be reordered by removing and re-adding
  	 * them one by one to the dc state, in order of descending zpos.
@@@ -12453,140 -5762,13 +5767,13 @@@
  		new_afb =3D (struct amdgpu_framebuffer *)new_other_state->fb;
 =20
  		/* Tiling and DCC changes also require bandwidth updates. */
- 		if (old_afb->tiling_flags !=3D new_afb->tiling_flags ||
- 		    old_afb->base.modifier !=3D new_afb->base.modifier)
+ 		if (old_afb->base.modifier !=3D new_afb->base.modifier)
  			return true;
  	}
 =20
  	return false;
  }
 =20
- static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
- 			      struct drm_plane_state *new_plane_state,
- 			      struct drm_framebuffer *fb)
- {
- 	struct amdgpu_device *adev =3D drm_to_adev(new_acrtc->base.dev);
- 	struct amdgpu_framebuffer *afb =3D to_amdgpu_framebuffer(fb);
- 	unsigned int pitch;
- 	bool linear;
-=20
- 	if (fb->width > new_acrtc->max_cursor_width ||
- 	    fb->height > new_acrtc->max_cursor_height) {
- 		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB size %dx%d\n",
- 				 new_plane_state->fb->width,
- 				 new_plane_state->fb->height);
- 		return -EINVAL;
- 	}
- 	if (new_plane_state->src_w !=3D fb->width << 16 ||
- 	    new_plane_state->src_h !=3D fb->height << 16) {
- 		drm_dbg_atomic(adev_to_drm(adev), "Cropping not supported for cursor pl=
ane\n");
- 		return -EINVAL;
- 	}
-=20
- 	/* Pitch in pixels */
- 	pitch =3D fb->pitches[0] / fb->format->cpp[0];
-=20
- 	if (fb->width !=3D pitch) {
- 		drm_dbg_atomic(adev_to_drm(adev), "Cursor FB width %d doesn't match pit=
ch %d",
- 				 fb->width, pitch);
- 		return -EINVAL;
- 	}
-=20
- 	switch (pitch) {
- 	case 64:
- 	case 128:
- 	case 256:
- 		/* FB pitch is supported by cursor plane */
- 		break;
- 	default:
- 		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB pitch %d px\n", pitch);
- 		return -EINVAL;
- 	}
-=20
- 	/* Core DRM takes care of checking FB modifiers, so we only need to
- 	 * check tiling flags when the FB doesn't have a modifier.
- 	 */
- 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
- 		if (adev->family =3D=3D AMDGPU_FAMILY_GC_12_0_0) {
- 			linear =3D AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) =
=3D=3D 0;
- 		} else if (adev->family >=3D AMDGPU_FAMILY_AI) {
- 			linear =3D AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) =3D=3D 0;
- 		} else {
- 			linear =3D AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) !=3D DC_AR=
RAY_2D_TILED_THIN1 &&
- 				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) !=3D DC_ARRAY_1D_TI=
LED_THIN1 &&
- 				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) =3D=3D 0;
- 		}
- 		if (!linear) {
- 			drm_dbg_atomic(adev_to_drm(adev), "Cursor FB not linear");
- 			return -EINVAL;
- 		}
- 	}
-=20
- 	return 0;
- }
-=20
- /*
-  * Helper function for checking the cursor in native mode
-  */
- static int dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
- 					struct drm_plane *plane,
- 					struct drm_plane_state *new_plane_state,
- 					bool enable)
- {
-=20
- 	struct amdgpu_crtc *new_acrtc;
- 	int ret;
-=20
- 	if (!enable || !new_plane_crtc ||
- 	    drm_atomic_plane_disabling(plane->state, new_plane_state))
- 		return 0;
-=20
- 	new_acrtc =3D to_amdgpu_crtc(new_plane_crtc);
-=20
- 	if (new_plane_state->src_x !=3D 0 || new_plane_state->src_y !=3D 0) {
- 		drm_dbg_atomic(new_plane_crtc->dev, "Cropping not supported for cursor =
plane\n");
- 		return -EINVAL;
- 	}
-=20
- 	if (new_plane_state->fb) {
- 		ret =3D dm_check_cursor_fb(new_acrtc, new_plane_state,
- 						new_plane_state->fb);
- 		if (ret)
- 			return ret;
- 	}
-=20
- 	return 0;
- }
-=20
- static bool dm_should_update_native_cursor(struct drm_atomic_commit *stat=
e,
- 					   struct drm_crtc *old_plane_crtc,
- 					   struct drm_crtc *new_plane_crtc,
- 					   bool enable)
- {
- 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
- 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
-=20
- 	if (!enable) {
- 		if (old_plane_crtc =3D=3D NULL)
- 			return true;
-=20
- 		old_crtc_state =3D drm_atomic_get_old_crtc_state(
- 			state, old_plane_crtc);
- 		dm_old_crtc_state =3D to_dm_crtc_state(old_crtc_state);
-=20
- 		return dm_old_crtc_state->cursor_mode =3D=3D DM_CURSOR_NATIVE_MODE;
- 	} else {
- 		if (new_plane_crtc =3D=3D NULL)
- 			return true;
-=20
- 		new_crtc_state =3D drm_atomic_get_new_crtc_state(
- 			state, new_plane_crtc);
- 		dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
-=20
- 		return dm_new_crtc_state->cursor_mode =3D=3D DM_CURSOR_NATIVE_MODE;
- 	}
- }
-=20
  static int dm_update_plane_state(struct dc *dc,
  				 struct drm_atomic_commit *state,
  				 struct drm_plane *plane,
@@@ -12611,14 -5793,14 +5798,14 @@@
  	dm_new_plane_state =3D to_dm_plane_state(new_plane_state);
  	dm_old_plane_state =3D to_dm_plane_state(old_plane_state);
 =20
- 	update_native_cursor =3D dm_should_update_native_cursor(state,
- 							      old_plane_crtc,
- 							      new_plane_crtc,
- 							      enable);
+ 	update_native_cursor =3D amdgpu_dm_should_update_native_cursor(state,
+ 								     old_plane_crtc,
+ 								     new_plane_crtc,
+ 								     enable);
 =20
  	if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR && update_native_cursor) {
- 		ret =3D dm_check_native_cursor_state(new_plane_crtc, plane,
- 						    new_plane_state, enable);
+ 		ret =3D amdgpu_dm_check_native_cursor_state(new_plane_crtc, plane,
+ 							  new_plane_state, enable);
  		if (ret)
  			return ret;
 =20
@@@ -12740,7 -5922,7 +5927,7 @@@
  		/* Tell DC to do a full surface update every time there
  		 * is a plane change. Inefficient, but works for now.
  		 */
- 		dm_new_plane_state->dc_state->update_flags.bits.full_update =3D 1;
+ 		dm_new_plane_state->dc_state->update_bits.full_update =3D 1;
 =20
  		*lock_and_validation_needed =3D true;
  	}
@@@ -12748,8 -5930,8 +5935,8 @@@
  out:
  	/* If enabling cursor overlay failed, attempt fallback to native mode */
  	if (enable && ret =3D=3D -EINVAL && plane->type =3D=3D DRM_PLANE_TYPE_CU=
RSOR) {
- 		ret =3D dm_check_native_cursor_state(new_plane_crtc, plane,
- 						    new_plane_state, enable);
+ 		ret =3D amdgpu_dm_check_native_cursor_state(new_plane_crtc, plane,
+ 							  new_plane_state, enable);
  		if (ret)
  			return ret;
 =20
@@@ -12759,35 -5941,6 +5946,6 @@@
  	return ret;
  }
 =20
- static void dm_get_oriented_plane_size(struct drm_plane_state *plane_stat=
e,
- 				       int *src_w, int *src_h)
- {
- 	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
- 	case DRM_MODE_ROTATE_90:
- 	case DRM_MODE_ROTATE_270:
- 		*src_w =3D plane_state->src_h >> 16;
- 		*src_h =3D plane_state->src_w >> 16;
- 		break;
- 	case DRM_MODE_ROTATE_0:
- 	case DRM_MODE_ROTATE_180:
- 	default:
- 		*src_w =3D plane_state->src_w >> 16;
- 		*src_h =3D plane_state->src_h >> 16;
- 		break;
- 	}
- }
-=20
- static void
- dm_get_plane_scale(struct drm_plane_state *plane_state,
- 		   int *out_plane_scale_w, int *out_plane_scale_h)
- {
- 	int plane_src_w, plane_src_h;
-=20
- 	dm_get_oriented_plane_size(plane_state, &plane_src_w, &plane_src_h);
- 	*out_plane_scale_w =3D plane_src_w ? plane_state->crtc_w * 1000 / plane_=
src_w : 0;
- 	*out_plane_scale_h =3D plane_src_h ? plane_state->crtc_h * 1000 / plane_=
src_h : 0;
- }
-=20
  /*
   * The normalized_zpos value cannot be used by this iterator directly. It=
's only
   * calculated for enabled planes, potentially causing normalized_zpos col=
lisions
@@@ -12795,7 -5948,7 +5953,7 @@@
   * so that the iterator will not generate the same object twice, or loop
   * indefinitely.
   */
- static inline struct __drm_planes_state *__get_next_zpos(
+ struct __drm_planes_state *amdgpu_dm_get_next_zpos(
  	struct drm_atomic_commit *state,
  	struct __drm_planes_state *prev)
  {
@@@ -12833,19 -5986,6 +5991,6 @@@
  	return &state->planes[highest_i];
  }
 =20
- /*
-  * Use the uniqueness of the plane's (zpos, drm obj ID) combination to it=
erate
-  * by descending zpos, as read from the new plane state. This is the same
-  * ordering as defined by drm_atomic_normalize_zpos().
-  */
- #define for_each_oldnew_plane_in_descending_zpos(__state, plane, old_plan=
e_state, new_plane_state) \
- 	for (struct __drm_planes_state *__i =3D __get_next_zpos((__state), NULL)=
; \
- 	     __i !=3D NULL; __i =3D __get_next_zpos((__state), __i))		\
- 		for_each_if(((plane) =3D __i->ptr,				\
- 			     (void)(plane) /* Only to avoid unused-but-set-variable warning */=
, \
- 			     (old_plane_state) =3D __i->old_state,		\
- 			     (new_plane_state) =3D __i->new_state, 1))
-=20
  static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, st=
ruct drm_crtc *crtc)
  {
  	struct drm_connector *connector;
@@@ -12876,219 -6016,6 +6021,6 @@@
  	return drm_dp_mst_add_affected_dsc_crtcs(state, &aconnector->mst_root->m=
st_mgr);
  }
 =20
- /**
-  * DOC: Cursor Modes - Native vs Overlay
-  *
-  * In native mode, the cursor uses a integrated cursor pipe within each D=
CN hw
-  * plane. It does not require a dedicated hw plane to enable, but it is
-  * subjected to the same z-order and scaling as the hw plane. It also has=
 format
-  * restrictions, a RGB cursor in native mode cannot be enabled within a n=
on-RGB
-  * hw plane.
-  *
-  * In overlay mode, the cursor uses a separate DCN hw plane, and thus has=
 its
-  * own scaling and z-pos. It also has no blending restrictions. It lends =
to a
-  * cursor behavior more akin to a DRM client's expectations. However, it =
does
-  * occupy an extra DCN plane, and therefore will only be used if a DCN pl=
ane is
-  * available.
-  */
-=20
- /**
-  * dm_plane_color_pipeline_active() - Check if a plane's color pipeline a=
ctive.
-  * @state: DRM atomic state
-  * @plane: DRM plane to check
-  * @use_old: if true, inspect the old colorop states; otherwise the new o=
nes
-  *
-  * A color pipeline may be selected (color_pipeline !=3D NULL) but still =
is
-  * inactive if every colorop in the chain is bypassed.  Only return
-  * true when at least one colorop has bypass =3D=3D false, meaning the cu=
rsor
-  * would be subjected to the transformation in native mode.
-  *
-  * Return: true if the pipeline modifies pixels, false otherwise.
-  */
- static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *stat=
e,
- 					   struct drm_plane *plane,
- 					   bool use_old)
- {
- 	struct drm_colorop *colorop;
- 	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
- 	int i;
-=20
- 	for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new_=
colorop_state, i) {
- 		struct drm_colorop_state *cstate =3D use_old ? old_colorop_state : new_=
colorop_state;
-=20
- 		if (cstate->colorop->plane !=3D plane)
- 			continue;
- 		if (!cstate->bypass)
- 			return true;
- 	}
- 	return false;
- }
-=20
- /**
-  * dm_crtc_get_cursor_mode() - Determine the required cursor mode on crtc
-  * @adev: amdgpu device
-  * @state: DRM atomic state
-  * @dm_crtc_state: amdgpu state for the CRTC containing the cursor
-  * @cursor_mode: Returns the required cursor mode on dm_crtc_state
-  *
-  * Get whether the cursor should be enabled in native mode, or overlay mo=
de, on
-  * the dm_crtc_state.
-  *
-  * The cursor should be enabled in overlay mode if there exists an underl=
ying
-  * plane - on which the cursor may be blended - that is either YUV format=
ted,
-  * scaled differently from the cursor, or has a color pipeline active.
-  *
-  * Since zpos info is required, drm_atomic_normalize_zpos must be called =
before
-  * calling this function.
-  *
-  * Return: 0 on success, or an error code if getting the cursor plane sta=
te
-  * failed.
-  */
- static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
- 				   struct drm_atomic_commit *state,
- 				   struct dm_crtc_state *dm_crtc_state,
- 				   enum amdgpu_dm_cursor_mode *cursor_mode)
- {
- 	struct drm_plane_state *old_plane_state, *plane_state, *cursor_state;
- 	struct drm_crtc_state *crtc_state =3D &dm_crtc_state->base;
- 	struct drm_plane *plane;
- 	bool consider_mode_change =3D false;
- 	bool entire_crtc_covered =3D false;
- 	bool cursor_changed =3D false;
- 	int underlying_scale_w, underlying_scale_h;
- 	int cursor_scale_w, cursor_scale_h;
- 	int i;
-=20
- 	/* Overlay cursor not supported on HW before DCN
- 	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-=
plane restrictions
- 	 * as previous DCN generations, so enable native mode on DCN401/420
- 	 *
- 	 * Always set native cursor mode when the CRTC is disabled,
- 	 * to make sure it doesn't cause atomic commits to fail when
- 	 * they are trying to disable the CRTC.
- 	 */
- 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 0, 1) ||
- 	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 0) ||
- 	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 1) ||
- 	    !dm_crtc_state->base.enable) {
- 		*cursor_mode =3D DM_CURSOR_NATIVE_MODE;
- 		return 0;
- 	}
-=20
- 	/* Init cursor_mode to be the same as current */
- 	*cursor_mode =3D dm_crtc_state->cursor_mode;
-=20
- 	/*
- 	 * Cursor mode can change if a plane's format changes, scale changes, is
- 	 * enabled/disabled, z-order changes, or color management properties cha=
nge.
- 	 */
- 	for_each_oldnew_plane_in_state(state, plane, old_plane_state, plane_stat=
e, i) {
- 		int new_scale_w, new_scale_h, old_scale_w, old_scale_h;
-=20
- 		/* Only care about planes on this CRTC */
- 		if ((drm_plane_mask(plane) & crtc_state->plane_mask) =3D=3D 0)
- 			continue;
-=20
- 		if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
- 			cursor_changed =3D true;
-=20
- 		if (drm_atomic_plane_enabling(old_plane_state, plane_state) ||
- 		    drm_atomic_plane_disabling(old_plane_state, plane_state) ||
- 		    old_plane_state->fb->format !=3D plane_state->fb->format) {
- 			consider_mode_change =3D true;
- 			break;
- 		}
-=20
- 		dm_get_plane_scale(plane_state, &new_scale_w, &new_scale_h);
- 		dm_get_plane_scale(old_plane_state, &old_scale_w, &old_scale_h);
- 		if (new_scale_w !=3D old_scale_w || new_scale_h !=3D old_scale_h) {
- 			consider_mode_change =3D true;
- 			break;
- 		}
-=20
- 		if (dm_plane_color_pipeline_active(state, plane, true) !=3D
- 		    dm_plane_color_pipeline_active(state, plane, false)) {
- 			consider_mode_change =3D true;
- 			break;
- 		}
- 	}
-=20
- 	if (!consider_mode_change && !crtc_state->zpos_changed)
- 		return 0;
-=20
- 	/*
- 	 * If no cursor change on this CRTC, and not enabled on this CRTC, then
- 	 * no need to set cursor mode. This avoids needlessly locking the cursor
- 	 * state.
- 	 */
- 	if (!cursor_changed &&
- 	    !(drm_plane_mask(crtc_state->crtc->cursor) & crtc_state->plane_mask)=
) {
- 		return 0;
- 	}
-=20
- 	cursor_state =3D drm_atomic_get_plane_state(state,
- 						  crtc_state->crtc->cursor);
- 	if (IS_ERR(cursor_state))
- 		return PTR_ERR(cursor_state);
-=20
- 	/* Cursor is disabled */
- 	if (!cursor_state->fb)
- 		return 0;
-=20
- 	/* For all planes in descending z-order (all of which are below cursor
- 	 * as per zpos definitions), check their scaling and format
- 	 */
- 	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, =
plane_state) {
-=20
- 		/* Only care about non-cursor planes on this CRTC */
- 		if ((drm_plane_mask(plane) & crtc_state->plane_mask) =3D=3D 0 ||
- 		    plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
- 			continue;
-=20
- 		/* Underlying plane is YUV format - use overlay cursor */
- 		if (amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
- 			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
- 			return 0;
- 		}
-=20
- 		/* Underlying plane has an active color pipeline - cursor would be tran=
sformed */
- 		if (dm_plane_color_pipeline_active(state, plane, false)) {
- 			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
- 			return 0;
- 		}
-=20
- 		dm_get_plane_scale(plane_state,
- 				   &underlying_scale_w, &underlying_scale_h);
- 		dm_get_plane_scale(cursor_state,
- 				   &cursor_scale_w, &cursor_scale_h);
-=20
- 		/* Underlying plane has different scale - use overlay cursor */
- 		if (cursor_scale_w !=3D underlying_scale_w &&
- 		    cursor_scale_h !=3D underlying_scale_h) {
- 			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
- 			return 0;
- 		}
-=20
- 		/* If this plane covers the whole CRTC, no need to check planes underne=
ath */
- 		if (plane_state->crtc_x <=3D 0 && plane_state->crtc_y <=3D 0 &&
- 		    plane_state->crtc_x + plane_state->crtc_w >=3D crtc_state->mode.hdi=
splay &&
- 		    plane_state->crtc_y + plane_state->crtc_h >=3D crtc_state->mode.vdi=
splay) {
- 			entire_crtc_covered =3D true;
- 			break;
- 		}
- 	}
-=20
- 	/* If planes do not cover the entire CRTC, use overlay mode to enable
- 	 * cursor over holes
- 	 */
- 	if (entire_crtc_covered)
- 		*cursor_mode =3D DM_CURSOR_NATIVE_MODE;
- 	else
- 		*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
-=20
- 	return 0;
- }
-=20
  static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
  					    struct drm_atomic_commit *state,
  					    struct drm_crtc_state *crtc_state)
@@@ -13161,7 -6088,7 +6093,7 @@@ static int amdgpu_dm_atomic_check(struc
 =20
  	ret =3D drm_atomic_helper_check_modeset(dev, state);
  	if (ret) {
- 		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
+ 		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed: %pe\n", =
ERR_PTR(ret));
  		goto fail;
  	}
 =20
@@@ -13176,7 -6103,7 +6108,7 @@@
 =20
  		new_crtc_state =3D drm_atomic_get_crtc_state(state, new_con_state->crtc=
);
  		if (IS_ERR(new_crtc_state)) {
- 			drm_dbg_atomic(dev, "drm_atomic_get_crtc_state() failed\n");
+ 			drm_dbg_atomic(dev, "drm_atomic_get_crtc_state() failed: %pe\n", new_c=
rtc_state);
  			ret =3D PTR_ERR(new_crtc_state);
  			goto fail;
  		}
@@@ -13196,7 -6123,7 +6128,7 @@@
  			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
  				ret =3D add_affected_mst_dsc_crtcs(state, crtc);
  				if (ret) {
- 					drm_dbg_atomic(dev, "add_affected_mst_dsc_crtcs() failed\n");
+ 					drm_dbg_atomic(dev, "add_affected_mst_dsc_crtcs() failed: %pe\n", ER=
R_PTR(ret));
  					goto fail;
  				}
  			}
@@@ -13213,7 -6140,7 +6145,7 @@@
 =20
  		ret =3D amdgpu_dm_verify_lut_sizes(new_crtc_state);
  		if (ret) {
- 			drm_dbg_atomic(dev, "amdgpu_dm_verify_lut_sizes() failed\n");
+ 			drm_dbg_atomic(dev, "amdgpu_dm_verify_lut_sizes() failed: %pe\n", ERR_=
PTR(ret));
  			goto fail;
  		}
 =20
@@@ -13222,13 -6149,13 +6154,13 @@@
 =20
  		ret =3D drm_atomic_add_affected_connectors(state, crtc);
  		if (ret) {
- 			drm_dbg_atomic(dev, "drm_atomic_add_affected_connectors() failed\n");
+ 			drm_dbg_atomic(dev, "drm_atomic_add_affected_connectors() failed: %pe\=
n", ERR_PTR(ret));
  			goto fail;
  		}
 =20
  		ret =3D drm_atomic_add_affected_planes(state, crtc);
  		if (ret) {
- 			drm_dbg_atomic(dev, "drm_atomic_add_affected_planes() failed\n");
+ 			drm_dbg_atomic(dev, "drm_atomic_add_affected_planes() failed: %pe\n", =
ERR_PTR(ret));
  			goto fail;
  		}
 =20
@@@ -13267,7 -6194,7 +6199,7 @@@
 =20
  			if (IS_ERR(new_plane_state)) {
  				ret =3D PTR_ERR(new_plane_state);
- 				drm_dbg_atomic(dev, "new_plane_state is BAD\n");
+ 				drm_dbg_atomic(dev, "new_plane_state is BAD: %pe\n", new_plane_state);
  				goto fail;
  			}
  		}
@@@ -13281,7 -6208,7 +6213,7 @@@
  	 */
  	ret =3D drm_atomic_normalize_zpos(dev, state);
  	if (ret) {
- 		drm_dbg(dev, "drm_atomic_normalize_zpos() failed\n");
+ 		drm_dbg(dev, "drm_atomic_normalize_zpos() failed: %pe\n", ERR_PTR(ret));
  		goto fail;
  	}
 =20
@@@ -13292,10 -6219,10 +6224,10 @@@
  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
  		dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
 =20
- 		ret =3D dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
- 					      &dm_new_crtc_state->cursor_mode);
+ 		ret =3D amdgpu_dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
+ 						     &dm_new_crtc_state->cursor_mode);
  		if (ret) {
- 			drm_dbg(dev, "Failed to determine cursor mode\n");
+ 			drm_dbg(dev, "Failed to determine cursor mode: %pe\n", ERR_PTR(ret));
  			goto fail;
  		}
 =20
@@@ -13327,7 -6254,7 +6259,7 @@@
  					    &lock_and_validation_needed,
  					    &is_top_most_overlay);
  		if (ret) {
- 			drm_dbg_atomic(dev, "dm_update_plane_state() failed\n");
+ 			drm_dbg_atomic(dev, "dm_update_plane_state() failed: %pe\n", ERR_PTR(r=
et));
  			goto fail;
  		}
  	}
@@@ -13340,7 -6267,7 +6272,7 @@@
  					   false,
  					   &lock_and_validation_needed);
  		if (ret) {
- 			drm_dbg_atomic(dev, "DISABLE: dm_update_crtc_state() failed\n");
+ 			drm_dbg_atomic(dev, "DISABLE: dm_update_crtc_state() failed: %pe\n", E=
RR_PTR(ret));
  			goto fail;
  		}
  	}
@@@ -13353,7 -6280,7 +6285,7 @@@
  					   true,
  					   &lock_and_validation_needed);
  		if (ret) {
- 			drm_dbg_atomic(dev, "ENABLE: dm_update_crtc_state() failed\n");
+ 			drm_dbg_atomic(dev, "ENABLE: dm_update_crtc_state() failed: %pe\n", ER=
R_PTR(ret));
  			goto fail;
  		}
  	}
@@@ -13367,7 -6294,7 +6299,7 @@@
  					    &lock_and_validation_needed,
  					    &is_top_most_overlay);
  		if (ret) {
- 			drm_dbg_atomic(dev, "dm_update_plane_state() failed\n");
+ 			drm_dbg_atomic(dev, "dm_update_plane_state() failed: %pe\n", ERR_PTR(r=
et));
  			goto fail;
  		}
  	}
@@@ -13383,7 -6310,7 +6315,7 @@@
  	/* Run this here since we want to validate the streams we created */
  	ret =3D drm_atomic_helper_check_planes(dev, state);
  	if (ret) {
- 		drm_dbg_atomic(dev, "drm_atomic_helper_check_planes() failed\n");
+ 		drm_dbg_atomic(dev, "drm_atomic_helper_check_planes() failed: %pe\n", E=
RR_PTR(ret));
  		goto fail;
  	}
 =20
@@@ -13427,8 -6354,8 +6359,8 @@@
  		}
 =20
  		/* If HW can only do native cursor, check restrictions again */
- 		ret =3D dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
- 					      &required_cursor_mode);
+ 		ret =3D amdgpu_dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
+ 						     &required_cursor_mode);
  		if (ret) {
  			drm_dbg_driver(crtc->dev,
  				       "[CRTC:%d:%s] Checking cursor mode failed\n",
@@@ -13521,13 -6448,13 +6453,13 @@@
  	if (lock_and_validation_needed) {
  		ret =3D dm_atomic_get_state(state, &dm_state);
  		if (ret) {
- 			drm_dbg_atomic(dev, "dm_atomic_get_state() failed\n");
+ 			drm_dbg_atomic(dev, "dm_atomic_get_state() failed: %pe\n", ERR_PTR(ret=
));
  			goto fail;
  		}
 =20
  		ret =3D do_aquire_global_lock(dev, state);
  		if (ret) {
- 			drm_dbg_atomic(dev, "do_aquire_global_lock() failed\n");
+ 			drm_dbg_atomic(dev, "do_aquire_global_lock() failed: %pe\n", ERR_PTR(r=
et));
  			goto fail;
  		}
 =20
@@@ -13535,7 -6462,7 +6467,7 @@@
  		if (dc_resource_is_dsc_encoding_supported(dc)) {
  			ret =3D compute_mst_dsc_configs_for_state(state, dm_state->context, va=
rs);
  			if (ret) {
- 				drm_dbg_atomic(dev, "MST_DSC compute_mst_dsc_configs_for_state() fail=
ed\n");
+ 				drm_dbg_atomic(dev, "MST_DSC compute_mst_dsc_configs_for_state() fail=
ed: %pe\n", ERR_PTR(ret));
  				ret =3D -EINVAL;
  				goto fail;
  			}
@@@ -13544,7 -6471,7 +6476,7 @@@
 =20
  		ret =3D dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars=
);
  		if (ret) {
- 			drm_dbg_atomic(dev, "dm_update_mst_vcpi_slots_for_dsc() failed\n");
+ 			drm_dbg_atomic(dev, "dm_update_mst_vcpi_slots_for_dsc() failed: %pe\n"=
, ERR_PTR(ret));
  			goto fail;
  		}
 =20
@@@ -13556,7 -6483,7 +6488,7 @@@
  		 */
  		ret =3D drm_dp_mst_atomic_check(state);
  		if (ret) {
- 			drm_dbg_atomic(dev, "MST drm_dp_mst_atomic_check() failed\n");
+ 			drm_dbg_atomic(dev, "MST drm_dp_mst_atomic_check() failed: %pe\n", ERR=
_PTR(ret));
  			goto fail;
  		}
  		status =3D dc_validate_global_state(dc, dm_state->context, DC_VALIDATE_=
MODE_ONLY);
@@@ -13645,380 -6572,13 +6577,13 @@@ fail
  	else if (ret =3D=3D -EINTR || ret =3D=3D -EAGAIN || ret =3D=3D -ERESTART=
SYS)
  		drm_dbg_atomic(dev, "Atomic check stopped due to signal.\n");
  	else
- 		drm_dbg_atomic(dev, "Atomic check failed with err: %d\n", ret);
+ 		drm_dbg_atomic(dev, "Atomic check failed: %pe\n", ERR_PTR(ret));
 =20
  	trace_amdgpu_dm_atomic_check_finish(state, ret);
 =20
  	return ret;
  }
 =20
- static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
- 		unsigned int offset,
- 		unsigned int total_length,
- 		u8 *data,
- 		unsigned int length,
- 		struct amdgpu_hdmi_vsdb_info *vsdb)
- {
- 	bool res;
- 	union dmub_rb_cmd cmd;
- 	struct dmub_cmd_send_edid_cea *input;
- 	struct dmub_cmd_edid_cea_output *output;
-=20
- 	if (length > DMUB_EDID_CEA_DATA_CHUNK_BYTES)
- 		return false;
-=20
- 	memset(&cmd, 0, sizeof(cmd));
-=20
- 	input =3D &cmd.edid_cea.data.input;
-=20
- 	cmd.edid_cea.header.type =3D DMUB_CMD__EDID_CEA;
- 	cmd.edid_cea.header.sub_type =3D 0;
- 	cmd.edid_cea.header.payload_bytes =3D
- 		sizeof(cmd.edid_cea) - sizeof(cmd.edid_cea.header);
- 	input->offset =3D offset;
- 	input->length =3D length;
- 	input->cea_total_length =3D total_length;
- 	memcpy(input->payload, data, length);
-=20
- 	res =3D dc_wake_and_execute_dmub_cmd(dm->dc->ctx, &cmd, DM_DMUB_WAIT_TYP=
E_WAIT_WITH_REPLY);
- 	if (!res) {
- 		drm_err(adev_to_drm(dm->adev), "EDID CEA parser failed\n");
- 		return false;
- 	}
-=20
- 	output =3D &cmd.edid_cea.data.output;
-=20
- 	if (output->type =3D=3D DMUB_CMD__EDID_CEA_ACK) {
- 		if (!output->ack.success) {
- 			drm_err(adev_to_drm(dm->adev), "EDID CEA ack failed at offset %d\n",
- 					output->ack.offset);
- 		}
- 	} else if (output->type =3D=3D DMUB_CMD__EDID_CEA_AMD_VSDB) {
- 		if (!output->amd_vsdb.vsdb_found)
- 			return false;
-=20
- 		vsdb->freesync_supported =3D output->amd_vsdb.freesync_supported;
- 		vsdb->amd_vsdb_version =3D output->amd_vsdb.amd_vsdb_version;
- 		vsdb->min_refresh_rate_hz =3D output->amd_vsdb.min_frame_rate;
- 		vsdb->max_refresh_rate_hz =3D output->amd_vsdb.max_frame_rate;
- 		vsdb->freesync_mccs_vcp_code =3D output->amd_vsdb.freesync_mccs_vcp_cod=
e;
- 	} else {
- 		drm_warn(adev_to_drm(dm->adev), "Unknown EDID CEA parser results\n");
- 		return false;
- 	}
-=20
- 	return true;
- }
-=20
- static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
- 		u8 *edid_ext, int len,
- 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
- {
- 	int i;
-=20
- 	/* send extension block to DMCU for parsing */
- 	for (i =3D 0; i < len; i +=3D 8) {
- 		bool res;
- 		int offset;
-=20
- 		/* send 8 bytes a time */
- 		if (!dc_edid_parser_send_cea(dm->dc, i, len, &edid_ext[i], 8))
- 			return false;
-=20
- 		if (i+8 =3D=3D len) {
- 			/* EDID block sent completed, expect result */
- 			int version, min_rate, max_rate;
-=20
- 			res =3D dc_edid_parser_recv_amd_vsdb(dm->dc, &version, &min_rate, &max=
_rate);
- 			if (res) {
- 				/* amd vsdb found */
- 				vsdb_info->freesync_supported =3D 1;
- 				vsdb_info->amd_vsdb_version =3D version;
- 				vsdb_info->min_refresh_rate_hz =3D min_rate;
- 				vsdb_info->max_refresh_rate_hz =3D max_rate;
- 				/* Not enabled on DMCU*/
- 				vsdb_info->freesync_mccs_vcp_code =3D 0;
- 				return true;
- 			}
- 			/* not amd vsdb */
- 			return false;
- 		}
-=20
- 		/* check for ack*/
- 		res =3D dc_edid_parser_recv_cea_ack(dm->dc, &offset);
- 		if (!res)
- 			return false;
- 	}
-=20
- 	return false;
- }
-=20
- static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
- 		u8 *edid_ext, int len,
- 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
- {
- 	int i;
-=20
- 	/* send extension block to DMCU for parsing */
- 	for (i =3D 0; i < len; i +=3D 8) {
- 		/* send 8 bytes a time */
- 		if (!dm_edid_parser_send_cea(dm, i, len, &edid_ext[i], 8, vsdb_info))
- 			return false;
- 	}
-=20
- 	return vsdb_info->freesync_supported;
- }
-=20
- static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
- 		u8 *edid_ext, int len,
- 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
- {
- 	struct amdgpu_device *adev =3D drm_to_adev(aconnector->base.dev);
- 	bool ret;
-=20
- 	mutex_lock(&adev->dm.dc_lock);
- 	if (adev->dm.dmub_srv)
- 		ret =3D parse_edid_cea_dmub(&adev->dm, edid_ext, len, vsdb_info);
- 	else
- 		ret =3D parse_edid_cea_dmcu(&adev->dm, edid_ext, len, vsdb_info);
- 	mutex_unlock(&adev->dm.dc_lock);
- 	return ret;
- }
-=20
- static void parse_edid_displayid_vrr(struct drm_connector *connector,
- 				     const struct edid *edid)
- {
- 	u8 *edid_ext =3D NULL;
- 	int i;
- 	int j =3D 0;
- 	u16 min_vfreq;
- 	u16 max_vfreq;
-=20
- 	if (!edid || !edid->extensions)
- 		return;
-=20
- 	/* Find DisplayID extension */
- 	for (i =3D 0; i < edid->extensions; i++) {
- 		edid_ext =3D (void *)(edid + (i + 1));
- 		if (edid_ext[0] =3D=3D DISPLAYID_EXT)
- 			break;
- 	}
-=20
- 	if (i =3D=3D edid->extensions)
- 		return;
-=20
- 	while (j < EDID_LENGTH) {
- 		/* Get dynamic video timing range from DisplayID if available */
- 		if (EDID_LENGTH - j > 13 && edid_ext[j] =3D=3D 0x25	&&
- 		    (edid_ext[j+1] & 0xFE) =3D=3D 0 && (edid_ext[j+2] =3D=3D 9)) {
- 			min_vfreq =3D edid_ext[j+9];
- 			if (edid_ext[j+1] & 7)
- 				max_vfreq =3D edid_ext[j+10] + ((edid_ext[j+11] & 3) << 8);
- 			else
- 				max_vfreq =3D edid_ext[j+10];
-=20
- 			if (max_vfreq && min_vfreq) {
- 				connector->display_info.monitor_range.max_vfreq =3D max_vfreq;
- 				connector->display_info.monitor_range.min_vfreq =3D min_vfreq;
-=20
- 				return;
- 			}
- 		}
- 		j++;
- 	}
- }
-=20
- static int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
- 			struct amdgpu_hdmi_vsdb_info *vsdb_info)
- {
- 	struct drm_connector *connector =3D &aconnector->base;
-=20
- 	vsdb_info->replay_mode =3D connector->display_info.amd_vsdb.replay_mode;
- 	vsdb_info->amd_vsdb_version =3D connector->display_info.amd_vsdb.version;
-=20
- 	return connector->display_info.amd_vsdb.version !=3D 0;
- }
-=20
- static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
- 			       const struct edid *edid,
- 			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
- {
- 	u8 *edid_ext =3D NULL;
- 	int i;
- 	bool valid_vsdb_found =3D false;
-=20
- 	/*----- drm_find_cea_extension() -----*/
- 	/* No EDID or EDID extensions */
- 	if (edid =3D=3D NULL || edid->extensions =3D=3D 0)
- 		return -ENODEV;
-=20
- 	/* Find CEA extension */
- 	for (i =3D 0; i < edid->extensions; i++) {
- 		edid_ext =3D (uint8_t *)edid + EDID_LENGTH * (i + 1);
- 		if (edid_ext[0] =3D=3D CEA_EXT)
- 			break;
- 	}
-=20
- 	if (i =3D=3D edid->extensions)
- 		return -ENODEV;
-=20
- 	/*----- cea_db_offsets() -----*/
- 	if (edid_ext[0] !=3D CEA_EXT)
- 		return -ENODEV;
-=20
- 	valid_vsdb_found =3D parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, v=
sdb_info);
-=20
- 	return valid_vsdb_found ? i : -ENODEV;
- }
-=20
- /**
-  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
-  *
-  * @connector: Connector to query.
-  * @drm_edid: DRM EDID from monitor
-  * @do_mccs: Controls whether MCCS (Monitor Control Command Set) over
-  *	      DDC (Display Data Channel) transactions are performed. When true,
-  *	      the driver queries the monitor to get or update additional FreeS=
ync
-  *	      capability information. When false, these transactions are skipp=
ed.
-  *
-  * Amdgpu supports Freesync in DP and HDMI displays, and it is required t=
o keep
-  * track of some of the display information in the internal data struct u=
sed by
-  * amdgpu_dm. This function checks which type of connector we need to set=
 the
-  * FreeSync parameters.
-  */
- void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
- 				    const struct drm_edid *drm_edid, bool do_mccs)
- {
- 	int i =3D 0;
- 	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
- 			to_amdgpu_dm_connector(connector);
- 	struct dm_connector_state *dm_con_state =3D NULL;
- 	struct dc_sink *sink;
- 	struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
- 	struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
- 	const struct edid *edid;
- 	bool freesync_capable =3D false;
- 	enum adaptive_sync_type as_type =3D ADAPTIVE_SYNC_TYPE_NONE;
-=20
- 	if (!connector->state) {
- 		drm_err(adev_to_drm(adev), "%s - Connector has no state", __func__);
- 		goto update;
- 	}
-=20
- 	sink =3D amdgpu_dm_connector->dc_sink ?
- 		amdgpu_dm_connector->dc_sink :
- 		amdgpu_dm_connector->dc_em_sink;
-=20
- 	drm_edid_connector_update(connector, drm_edid);
-=20
- 	if (!drm_edid || !sink) {
- 		dm_con_state =3D to_dm_connector_state(connector->state);
-=20
- 		amdgpu_dm_connector->min_vfreq =3D 0;
- 		amdgpu_dm_connector->max_vfreq =3D 0;
- 		freesync_capable =3D false;
-=20
- 		goto update;
- 	}
-=20
- 	dm_con_state =3D to_dm_connector_state(connector->state);
-=20
- 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version=
))
- 		goto update;
-=20
- 	edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
-=20
- 	/* Some eDP panels only have the refresh rate range info in DisplayID */
- 	if ((connector->display_info.monitor_range.min_vfreq =3D=3D 0 ||
- 	     connector->display_info.monitor_range.max_vfreq =3D=3D 0))
- 		parse_edid_displayid_vrr(connector, edid);
-=20
- 	if (edid && (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
- 		     sink->sink_signal =3D=3D SIGNAL_TYPE_EDP)) {
- 		if (amdgpu_dm_connector->dc_link &&
- 		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_pa=
ram) {
- 			amdgpu_dm_connector->min_vfreq =3D connector->display_info.monitor_ran=
ge.min_vfreq;
- 			amdgpu_dm_connector->max_vfreq =3D connector->display_info.monitor_ran=
ge.max_vfreq;
- 			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > =
10)
- 				freesync_capable =3D true;
- 		}
-=20
- 		get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
-=20
- 		if (vsdb_info.replay_mode) {
- 			amdgpu_dm_connector->vsdb_info.replay_mode =3D vsdb_info.replay_mode;
- 			amdgpu_dm_connector->vsdb_info.amd_vsdb_version =3D vsdb_info.amd_vsdb=
_version;
- 			amdgpu_dm_connector->as_type =3D ADAPTIVE_SYNC_TYPE_EDP;
- 		}
-=20
- 	} else if (drm_edid && sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)=
 {
- 		i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
- 		if (i >=3D 0) {
- 			amdgpu_dm_connector->vsdb_info =3D vsdb_info;
- 			sink->edid_caps.freesync_vcp_code =3D vsdb_info.freesync_mccs_vcp_code;
-=20
- 			if (vsdb_info.freesync_supported) {
- 				amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_refresh_rate_hz;
- 				amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_refresh_rate_hz;
- 				if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq >=
 10)
- 					freesync_capable =3D true;
-=20
- 				connector->display_info.monitor_range.min_vfreq =3D vsdb_info.min_ref=
resh_rate_hz;
- 				connector->display_info.monitor_range.max_vfreq =3D vsdb_info.max_ref=
resh_rate_hz;
- 			}
- 		}
- 	}
-=20
- 	if (amdgpu_dm_connector->dc_link)
- 		as_type =3D dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_l=
ink);
-=20
- 	if (as_type =3D=3D FREESYNC_TYPE_PCON_IN_WHITELIST) {
- 		i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
- 		if (i >=3D 0) {
- 			amdgpu_dm_connector->vsdb_info =3D vsdb_info;
- 			sink->edid_caps.freesync_vcp_code =3D vsdb_info.freesync_mccs_vcp_code;
-=20
- 			if (vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
- 				amdgpu_dm_connector->pack_sdp_v1_3 =3D true;
- 				amdgpu_dm_connector->as_type =3D as_type;
-=20
- 				amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_refresh_rate_hz;
- 				amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_refresh_rate_hz;
- 				if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq >=
 10)
- 					freesync_capable =3D true;
-=20
- 				connector->display_info.monitor_range.min_vfreq =3D vsdb_info.min_ref=
resh_rate_hz;
- 				connector->display_info.monitor_range.max_vfreq =3D vsdb_info.max_ref=
resh_rate_hz;
- 			}
- 		}
- 	}
-=20
- 	/* Handle MCCS */
- 	if (do_mccs) {
- 		dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_lin=
k, sink);
-=20
- 		if (sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supp=
orted)
- 			freesync_capable =3D false;
-=20
- 		if (sink->mccs_caps.freesync_supported && freesync_capable)
- 			dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link=
, sink);
- 	}
-=20
- update:
- 	if (dm_con_state)
- 		dm_con_state->freesync_capable =3D freesync_capable;
-=20
- 	if (connector->state && amdgpu_dm_connector->dc_link && !freesync_capabl=
e &&
- 	    amdgpu_dm_connector->dc_link->replay_settings.config.replay_supporte=
d) {
- 		amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported =
=3D false;
- 		amdgpu_dm_connector->dc_link->replay_settings.replay_feature_enabled =
=3D false;
- 	}
-=20
- 	if (connector->vrr_capable_property)
- 		drm_connector_set_vrr_capable_property(connector,
- 						       freesync_capable);
- }
-=20
  void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
  {
  	struct amdgpu_device *adev =3D drm_to_adev(dev);
@@@ -14038,12 -6598,6 +6603,6 @@@
  	mutex_unlock(&adev->dm.dc_lock);
  }
 =20
- static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
- {
- 	if (dc->ctx->dmub_srv && !dc->ctx->dmub_srv->idle_exit_counter)
- 		dc_exit_ips_for_hw_access(dc);
- }
-=20
  void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
  		       u32 value, const char *func_name)
  {
@@@ -14072,13 -6626,6 +6631,6 @@@ uint32_t dm_read_reg_func(const struct=20
  	}
  #endif
 =20
- 	if (ctx->dmub_srv &&
- 	    ctx->dmub_srv->reg_helper_offload.gather_in_progress &&
- 	    !ctx->dmub_srv->reg_helper_offload.should_burst_write) {
- 		ASSERT(false);
- 		return 0;
- 	}
-=20
  	amdgpu_dm_exit_ips_for_hw_access(ctx->dc);
 =20
  	value =3D cgs_read_register(ctx->cgs_device, address);
@@@ -14088,179 -6635,6 +6640,6 @@@
  	return value;
  }
 =20
- int amdgpu_dm_process_dmub_aux_transfer_sync(
- 		struct dc_context *ctx,
- 		unsigned int link_index,
- 		struct aux_payload *payload,
- 		enum aux_return_code_type *operation_result)
- {
- 	struct amdgpu_device *adev =3D ctx->driver_context;
- 	struct dmub_notification *p_notify =3D adev->dm.dmub_notify;
- 	int ret =3D -1;
-=20
- 	mutex_lock(&adev->dm.dpia_aux_lock);
- 	if (!dc_process_dmub_aux_transfer_async(ctx->dc, link_index, payload)) {
- 		*operation_result =3D AUX_RET_ERROR_ENGINE_ACQUIRE;
- 		goto out;
- 	}
-=20
- 	if (!wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * =
HZ)) {
- 		drm_err(adev_to_drm(adev), "wait_for_completion_timeout timeout!");
- 		*operation_result =3D AUX_RET_ERROR_TIMEOUT;
- 		goto out;
- 	}
-=20
- 	if (p_notify->result !=3D AUX_RET_SUCCESS) {
- 		/*
- 		 * Transient states before tunneling is enabled could
- 		 * lead to this error. We can ignore this for now.
- 		 */
- 		if (p_notify->result =3D=3D AUX_RET_ERROR_PROTOCOL_ERROR) {
- 			drm_warn(adev_to_drm(adev), "DPIA AUX failed on 0x%x(%d), error %d\n",
- 					payload->address, payload->length,
- 					p_notify->result);
- 		}
- 		*operation_result =3D p_notify->result;
- 		goto out;
- 	}
-=20
- 	payload->reply[0] =3D adev->dm.dmub_notify->aux_reply.command & 0xF;
- 	if (adev->dm.dmub_notify->aux_reply.command & 0xF0)
- 		/* The reply is stored in the top nibble of the command. */
- 		payload->reply[0] =3D (adev->dm.dmub_notify->aux_reply.command >> 4) & =
0xF;
-=20
- 	/*write req may receive a byte indicating partially written number as we=
ll*/
- 	if (p_notify->aux_reply.length)
- 		memcpy(payload->data, p_notify->aux_reply.data,
- 				p_notify->aux_reply.length);
-=20
- 	/* success */
- 	ret =3D p_notify->aux_reply.length;
- 	*operation_result =3D p_notify->result;
- out:
- 	reinit_completion(&adev->dm.dmub_aux_transfer_done);
- 	mutex_unlock(&adev->dm.dpia_aux_lock);
- 	return ret;
- }
-=20
- static void abort_fused_io(
- 		struct dc_context *ctx,
- 		const struct dmub_cmd_fused_request *request
- )
- {
- 	union dmub_rb_cmd command =3D { 0 };
- 	struct dmub_rb_cmd_fused_io *io =3D &command.fused_io;
-=20
- 	io->header.type =3D DMUB_CMD__FUSED_IO;
- 	io->header.sub_type =3D DMUB_CMD__FUSED_IO_ABORT;
- 	io->header.payload_bytes =3D sizeof(*io) - sizeof(io->header);
- 	io->request =3D *request;
- 	dm_execute_dmub_cmd(ctx, &command, DM_DMUB_WAIT_TYPE_NO_WAIT);
- }
-=20
- static bool execute_fused_io(
- 		struct amdgpu_device *dev,
- 		struct dc_context *ctx,
- 		union dmub_rb_cmd *commands,
- 		uint8_t count,
- 		uint32_t timeout_us
- )
- {
- 	const uint8_t ddc_line =3D commands[0].fused_io.request.u.aux.ddc_line;
-=20
- 	if (ddc_line >=3D ARRAY_SIZE(dev->dm.fused_io))
- 		return false;
-=20
- 	struct fused_io_sync *sync =3D &dev->dm.fused_io[ddc_line];
- 	struct dmub_rb_cmd_fused_io *first =3D &commands[0].fused_io;
- 	const bool result =3D dm_execute_dmub_cmd_list(ctx, count, commands, DM_=
DMUB_WAIT_TYPE_WAIT_WITH_REPLY)
- 			&& first->header.ret_status
- 			&& first->request.status =3D=3D FUSED_REQUEST_STATUS_SUCCESS;
-=20
- 	if (!result)
- 		return false;
-=20
- 	while (wait_for_completion_timeout(&sync->replied, usecs_to_jiffies(time=
out_us))) {
- 		reinit_completion(&sync->replied);
-=20
- 		struct dmub_cmd_fused_request *reply =3D (struct dmub_cmd_fused_request=
 *) sync->reply_data;
-=20
- 		static_assert(sizeof(*reply) <=3D sizeof(sync->reply_data), "Size misma=
tch");
-=20
- 		if (reply->identifier =3D=3D first->request.identifier) {
- 			first->request =3D *reply;
- 			return true;
- 		}
- 	}
-=20
- 	reinit_completion(&sync->replied);
- 	first->request.status =3D FUSED_REQUEST_STATUS_TIMEOUT;
- 	abort_fused_io(ctx, &first->request);
- 	return false;
- }
-=20
- bool amdgpu_dm_execute_fused_io(
- 		struct amdgpu_device *dev,
- 		struct dc_link *link,
- 		union dmub_rb_cmd *commands,
- 		uint8_t count,
- 		uint32_t timeout_us)
- {
- 	struct amdgpu_display_manager *dm =3D &dev->dm;
-=20
- 	mutex_lock(&dm->dpia_aux_lock);
-=20
- 	const bool result =3D execute_fused_io(dev, link->ctx, commands, count, =
timeout_us);
-=20
- 	mutex_unlock(&dm->dpia_aux_lock);
- 	return result;
- }
-=20
- int amdgpu_dm_process_dmub_set_config_sync(
- 		struct dc_context *ctx,
- 		unsigned int link_index,
- 		struct set_config_cmd_payload *payload,
- 		enum set_config_status *operation_result)
- {
- 	struct amdgpu_device *adev =3D ctx->driver_context;
- 	bool is_cmd_complete;
- 	int ret;
-=20
- 	mutex_lock(&adev->dm.dpia_aux_lock);
- 	is_cmd_complete =3D dc_process_dmub_set_config_async(ctx->dc,
- 			link_index, payload, adev->dm.dmub_notify);
-=20
- 	if (is_cmd_complete || wait_for_completion_timeout(&adev->dm.dmub_aux_tr=
ansfer_done, 10 * HZ)) {
- 		ret =3D 0;
- 		*operation_result =3D adev->dm.dmub_notify->sc_status;
- 	} else {
- 		drm_err(adev_to_drm(adev), "wait_for_completion_timeout timeout!");
- 		ret =3D -1;
- 		*operation_result =3D SET_CONFIG_UNKNOWN_ERROR;
- 	}
-=20
- 	if (!is_cmd_complete)
- 		reinit_completion(&adev->dm.dmub_aux_transfer_done);
- 	mutex_unlock(&adev->dm.dpia_aux_lock);
- 	return ret;
- }
-=20
- bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd =
*cmd, enum dm_dmub_wait_type wait_type)
- {
- 	struct amdgpu_device *adev =3D ctx->driver_context;
-=20
- 	guard(spinlock_irqsave)(&adev->dm.dmub_lock);
- 	return dc_dmub_srv_cmd_run(ctx->dmub_srv, cmd, wait_type);
- }
-=20
- bool dm_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned int =
count, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
- {
- 	struct amdgpu_device *adev =3D ctx->driver_context;
-=20
- 	guard(spinlock_irqsave)(&adev->dm.dmub_lock);
- 	return dc_dmub_srv_cmd_run_list(ctx->dmub_srv, count, cmd, wait_type);
- }
-=20
  void dm_acpi_process_phy_transition_interlock(
  	const struct dc_context *ctx,
  	struct dm_process_phy_transition_init_params process_phy_transition_init=
_params)

--8x9LDaT+QhA6DkDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp17bEACgkQJNaLcl1U
h9C7agf/UL7EcQHjLaJLgKHUGI7UVvsbLuVyAHdiH5Fp4WyCqw8aBNNDV0lr5FAB
pOegamh4Xqlyd0ro+143ar07f9+8XNcAOt4hX1ZoVLQYSNnRn+470NZ5BGGqiPxD
ZKRd6CcJEW+wBwmot+qvEopHDwT/q3G9BUPXtFgwRAytXqiy/Osgiwb73IN89q9Y
Bmlv1oNwzmyR8xRFk+fdTdL3Mq7lM/RcgNj3dv1DTew2o4U6Wwp69u67MyCq/in3
+3DLfi9j+Sz7uwXuv3sowbF/7TkKLyT7mAvCrJYK0uP4iGjziGrNusIpMtXATuHe
nkql2u218EsWsrXRTUMCtrcWTDkWsQ==
=4Gdq
-----END PGP SIGNATURE-----

--8x9LDaT+QhA6DkDX--
