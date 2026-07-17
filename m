Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592BBC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0D710E487;
	Fri, 17 Jul 2026 14:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="otjbGFTn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A3010E487
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:40:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9887460204;
 Fri, 17 Jul 2026 14:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9331F000E9;
 Fri, 17 Jul 2026 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784299254;
 bh=tFxvbZ7MMtMEl9Jvi7vkHY4QnawXXB2WiIHhM5eriN0=;
 h=Date:From:To:Cc:Subject;
 b=otjbGFTndP2oHKi0n3lj+gMm/5XT9TwhmdlXXOPUeemr98hUkQxVHa3B4TZp9dTAy
 2JxXossXkoO7cQkHqNX+zXDUPJUvohvFxWZAkXlNTdLJNC43sJTymej/OOZueo//r5
 fldqK6beHkazzpbMHWgIYA36gNTWp/xDA/azswiTpvIVs9Ey/QajqJPGFBnKTgsxVs
 Qw2X2lgBHxaahEK9SjklIM1TyvwHiUn+z6z3SQttodji8U2tFV+r9+KsuJO7+7fTHp
 xcbehtgK09gja8jItSeaiJqXIot8PxqshbdWU2VCZFmBA4md6pOaSH5zq5F68yV6Fe
 zvgzhFRASDJSw==
Date: Fri, 17 Jul 2026 15:40:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>,
 Charlene Liu <Charlene.Liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 George Zhang <george.zhang@amd.com>,
 Honglei Huang <honghuan@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <alo-8IRAosEQ45Ay@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5YZEPzi8xrFAEvia"
Content-Disposition: inline
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


--5YZEPzi8xrFAEvia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/core/dc.c

between commit:

  d73f4e118dc4c ("drm/amd/display: check GRPH_FLIP status before sending ev=
ent")

=66rom the drm-fixes tree and commits:

  f64a9be565368 ("drm/amd/display: check GRPH_FLIP status before sending ev=
ent")
  72b94048020ce ("drm/amd/display: limit reuse dsc capable bootup timing")
  98e08a815ef60 ("drm/amd/display: Tear down dangling pipe on boot to fix s=
0i3")
  2a5810782369b ("drm/amd/display: program dither on all OPP heads under OD=
M combine")
  f3403ab74a29f ("drm/amd/display: Add block sequence support for bandwidth=
 programming operations")
  991e0516a8072 ("drm/amd/display: use kvzalloc to allocate struct dc")
  9e0896fa6f7db ("drm/amd/display: avoid large stack allocation in commit_p=
lanes_do_stream_update_sequence")
  c1199393ec559 ("drm/amd/display: Refactor surface_update_flags to flat st=
ruct with helpers")
  b008c67efb36b ("drm/amd/display: Introduce dc_plane_cm and migrate surfac=
e update color path")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/display/dc/core/dc.c
index e25b94b65daca,8d77158229f1b..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@@ -769,22 -769,23 +769,23 @@@ void dc_stream_set_dither_option(struc
  {
  	struct bit_depth_reduction_params params;
  	struct dc_link *link =3D stream->link;
- 	struct pipe_ctx *pipes =3D NULL;
+ 	struct resource_context *res_ctx =3D &link->dc->current_state->res_ctx;
+ 	struct pipe_ctx *otg_master;
+ 	struct pipe_ctx *opp_heads[MAX_PIPES];
+ 	int opp_cnt;
  	int i;
 =20
- 	for (i =3D 0; i < MAX_PIPES; i++) {
- 		if (link->dc->current_state->res_ctx.pipe_ctx[i].stream =3D=3D
- 				stream) {
- 			pipes =3D &link->dc->current_state->res_ctx.pipe_ctx[i];
- 			break;
- 		}
- 	}
-=20
- 	if (!pipes)
+ 	otg_master =3D resource_get_otg_master_for_stream(res_ctx, stream);
+ 	if (!otg_master)
  		return;
  	if (option > DITHER_OPTION_MAX)
  		return;
 =20
+ 	opp_cnt =3D resource_get_opp_heads_for_otg_master(otg_master, res_ctx, o=
pp_heads);
+=20
+ 	if (opp_cnt =3D=3D 0)
+ 		return;
+=20
  	dc_exit_ips_for_hw_access(stream->ctx->dc);
 =20
  	stream->dither_option =3D option;
@@@ -793,16 -794,30 +794,30 @@@
  	resource_build_bit_depth_reduction_params(stream, &params);
  	stream->bit_depth_params =3D params;
 =20
- 	if (pipes->plane_res.xfm &&
- 	    pipes->plane_res.xfm->funcs->transform_set_pixel_storage_depth) {
- 		pipes->plane_res.xfm->funcs->transform_set_pixel_storage_depth(
- 			pipes->plane_res.xfm,
- 			pipes->plane_res.scl_data.lb_params.depth,
- 			&stream->bit_depth_params);
- 	}
+ 	/*
+ 	 * Program bit-depth reduction (dither) on every OPP head of the
+ 	 * stream. Under ODM combine there is more than one OPP head and they
+ 	 * must all be kept in sync, otherwise (e.g. when CRC capture requests
+ 	 * dither off) a secondary ODM segment can keep dither enabled and
+ 	 * produce a different CRC than the primary segment.
+ 	 */
+ 	for (i =3D 0; i < opp_cnt; i++) {
+ 		struct pipe_ctx *opp_head =3D opp_heads[i];
 =20
- 	pipes->stream_res.opp->funcs->
- 		opp_program_bit_depth_reduction(pipes->stream_res.opp, &params);
+ 		if (opp_head->plane_res.xfm &&
+ 		    opp_head->plane_res.xfm->funcs->transform_set_pixel_storage_depth) {
+ 			opp_head->plane_res.xfm->funcs->transform_set_pixel_storage_depth(
+ 				opp_head->plane_res.xfm,
+ 				opp_head->plane_res.scl_data.lb_params.depth,
+ 				&stream->bit_depth_params);
+ 		}
+=20
+ 		if (opp_head->stream_res.opp &&
+ 		    opp_head->stream_res.opp->funcs->opp_program_bit_depth_reduction) {
+ 			opp_head->stream_res.opp->funcs->opp_program_bit_depth_reduction(
+ 				opp_head->stream_res.opp, &params);
+ 		}
+ 	}
  }
 =20
  bool dc_stream_set_gamut_remap(struct dc *dc, const struct dc_stream_stat=
e *stream)
@@@ -1930,6 -1945,13 +1945,13 @@@ bool dc_validate_boot_timing(const stru
  		struct display_stream_compressor *dsc =3D NULL;
  		struct dcn_dsc_state dsc_state =3D {0};
 =20
+ 		if (dc->ctx->dce_version < DCN_VERSION_4_2) {
+ 			/*vbios enabled eDP dsc for one of DCN315  only but it has known issue,
+ 			since there is no production bios update, block it there*/
+ 			DC_LOG_DEBUG("boot timing validation failed due to unsupported DSC on =
this ASIC\n");
+ 			return false;
+ 		}
+=20
  		/* Find DSC associated with this timing generator */
  		if (tg_inst < (unsigned int)dc->res_pool->res_cap->num_dsc) {
  			dsc =3D dc->res_pool->dscs[tg_inst];
@@@ -2310,7 -2332,7 +2332,7 @@@ static enum dc_status dc_commit_state_n
  	for (i =3D 0; i < context->stream_count; i++) {
  		uint32_t prev_dsc_changed =3D context->streams[i]->update_flags.bits.ds=
c_changed;
 =20
- 		context->streams[i]->update_flags.raw =3D 0xFFFFFFFF;
+ 		stream_update_flags_set_full(&context->streams[i]->update_flags);
  		context->streams[i]->update_flags.bits.dsc_changed =3D prev_dsc_changed;
  	}
 =20
@@@ -2416,7 -2438,7 +2438,7 @@@
 =20
  	/* Clear update flags that were set earlier to avoid redundant programmi=
ng */
  	for (i =3D 0; i < context->stream_count; i++) {
- 		context->streams[i]->update_flags.raw =3D 0x0;
+ 		stream_update_flags_clear(&context->streams[i]->update_flags);
  	}
 =20
  	old_state =3D dc->current_state;
@@@ -2764,7 -2786,7 +2786,7 @@@ static bool is_surface_in_context
 =20
  static struct surface_update_descriptor get_plane_info_update_type(const =
struct dc_surface_update *u)
  {
- 	union surface_update_flags *update_flags =3D &u->surface->update_flags;
+ 	struct pipe_update_bits *update_bits =3D &u->surface->update_bits;
  	struct surface_update_descriptor update_type =3D { UPDATE_TYPE_FAST, LOC=
K_DESCRIPTOR_NONE };
 =20
  	if (!u->plane_info)
@@@ -2774,37 -2796,37 +2796,37 @@@
  	elevate_update_type(&update_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STRE=
AM);
 =20
  	if (u->plane_info->color_space !=3D u->surface->color_space) {
- 		update_flags->bits.color_space_change =3D 1;
+ 		update_bits->color_space_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STRE=
AM);
  	}
 =20
  	if (u->plane_info->horizontal_mirror !=3D u->surface->horizontal_mirror)=
 {
- 		update_flags->bits.horizontal_mirror_change =3D 1;
+ 		update_bits->horizontal_mirror_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STRE=
AM);
  	}
 =20
  	if (u->plane_info->rotation !=3D u->surface->rotation) {
- 		update_flags->bits.rotation_change =3D 1;
+ 		update_bits->rotation_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLO=
BAL);
  	}
 =20
  	if (u->plane_info->format !=3D u->surface->format) {
- 		update_flags->bits.pixel_format_change =3D 1;
+ 		update_bits->pixel_format_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLO=
BAL);
  	}
 =20
  	if (u->plane_info->stereo_format !=3D u->surface->stereo_format) {
- 		update_flags->bits.stereo_format_change =3D 1;
+ 		update_bits->stereo_format_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLO=
BAL);
  	}
 =20
  	if (u->plane_info->per_pixel_alpha !=3D u->surface->per_pixel_alpha) {
- 		update_flags->bits.per_pixel_alpha_change =3D 1;
+ 		update_bits->per_pixel_alpha_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STRE=
AM);
  	}
 =20
  	if (u->plane_info->global_alpha_value !=3D u->surface->global_alpha_valu=
e) {
- 		update_flags->bits.global_alpha_change =3D 1;
+ 		update_bits->global_alpha_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STRE=
AM);
  	}
 =20
@@@ -2816,7 -2838,7 +2838,7 @@@
  		 * stutter period calculation. Triggering a full update will
  		 * recalculate stutter period.
  		 */
- 		update_flags->bits.dcc_change =3D 1;
+ 		update_bits->dcc_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLO=
BAL);
  	}
 =20
@@@ -2825,25 -2847,25 +2847,25 @@@
  		/* different bytes per element will require full bandwidth
  		 * and DML calculation
  		 */
- 		update_flags->bits.bpp_change =3D 1;
+ 		update_bits->bpp_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLO=
BAL);
  	}
 =20
  	if (u->plane_info->plane_size.surface_pitch !=3D u->surface->plane_size.=
surface_pitch
  			|| u->plane_info->plane_size.chroma_pitch !=3D u->surface->plane_size.=
chroma_pitch) {
- 		update_flags->bits.plane_size_change =3D 1;
+ 		update_bits->plane_size_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STRE=
AM);
  	}
 =20
  	const struct dc_tiling_info *tiling =3D &u->plane_info->tiling_info;
 =20
  	if (memcmp(tiling, &u->surface->tiling_info, sizeof(*tiling)) !=3D 0) {
- 		update_flags->bits.swizzle_change =3D 1;
+ 		update_bits->swizzle_change =3D 1;
 =20
  		if (tiling->flags.avoid_full_update_on_tiling_change) {
  			elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STR=
EAM);
  		} else {
- 			update_flags->bits.bandwidth_change =3D 1;
+ 			update_bits->bandwidth_change =3D 1;
  			elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GL=
OBAL);
  		}
  	}
@@@ -2853,10 -2875,10 +2875,10 @@@
  }
 =20
  static struct surface_update_descriptor get_scaling_info_update_type(
- 		const struct dc_check_config *check_config,
- 		const struct dc_surface_update *u)
+ 	const struct dc_check_config *check_config,
+ 	const struct dc_surface_update *u)
  {
- 	union surface_update_flags *update_flags =3D &u->surface->update_flags;
+ 	struct pipe_update_bits *update_bits =3D &u->surface->update_bits;
  	struct surface_update_descriptor update_type =3D { UPDATE_TYPE_FAST, LOC=
K_DESCRIPTOR_NONE };
 =20
  	if (!u->scaling_info)
@@@ -2873,26 -2895,26 +2895,26 @@@
  			|| u->scaling_info->clip_rect.height !=3D u->surface->clip_rect.height
  			|| u->scaling_info->scaling_quality.integer_scaling !=3D
  					u->surface->scaling_quality.integer_scaling) {
- 		update_flags->bits.scaling_change =3D 1;
+ 		update_bits->scaling_change =3D 1;
  		elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLO=
BAL);
 =20
  		if (u->scaling_info->src_rect.width > u->surface->src_rect.width
  				|| u->scaling_info->src_rect.height > u->surface->src_rect.height)
  			/* Making src rect bigger requires a bandwidth change */
- 			update_flags->bits.clock_change =3D 1;
+ 			update_bits->clock_change =3D 1;
 =20
  		if ((u->scaling_info->dst_rect.width < u->surface->dst_rect.width
  			|| u->scaling_info->dst_rect.height < u->surface->dst_rect.height)
  				&& (u->scaling_info->dst_rect.width < u->surface->src_rect.width
  					|| u->scaling_info->dst_rect.height < u->surface->src_rect.height))
  			/* Making dst rect smaller requires a bandwidth change */
- 			update_flags->bits.bandwidth_change =3D 1;
+ 			update_bits->bandwidth_change =3D 1;
 =20
  		if (u->scaling_info->src_rect.width > (int)check_config->max_optimizabl=
e_video_width &&
  			(u->scaling_info->clip_rect.width > u->surface->clip_rect.width ||
  			 u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
  			 /* Changing clip size of a large surface may result in MPC slice coun=
t change */
- 			update_flags->bits.bandwidth_change =3D 1;
+ 			update_bits->bandwidth_change =3D 1;
  	}
 =20
  	if (u->scaling_info->src_rect.x !=3D u->surface->src_rect.x
@@@ -2902,7 -2924,7 +2924,7 @@@
  			|| u->scaling_info->dst_rect.x !=3D u->surface->dst_rect.x
  			|| u->scaling_info->dst_rect.y !=3D u->surface->dst_rect.y) {
  		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STRE=
AM);
- 		update_flags->bits.position_change =3D 1;
+ 		update_bits->position_change =3D 1;
  	}
 =20
  	return update_type;
@@@ -2913,15 -2935,15 +2935,15 @@@ static struct surface_update_descripto
  		struct dc_surface_update *u)
  {
  	struct surface_update_descriptor overall_type =3D { UPDATE_TYPE_FAST, LO=
CK_DESCRIPTOR_NONE };
- 	union surface_update_flags *update_flags =3D &u->surface->update_flags;
+ 	struct pipe_update_bits *update_bits =3D &u->surface->update_bits;
 =20
  	if (u->surface->force_full_update) {
- 		update_flags->raw =3D 0xFFFFFFFF;
+ 		dc_pipe_update_bits_set_full(update_bits);
  		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GL=
OBAL);
  		return overall_type;
  	}
 =20
- 	update_flags->raw =3D 0; // Reset all flags
+ 	dc_pipe_update_bits_clear(update_bits);
 =20
  	struct surface_update_descriptor inner_type =3D get_plane_info_update_ty=
pe(u);
 =20
@@@ -2931,87 -2953,112 +2953,112 @@@
  	elevate_update_type(&overall_type, inner_type.update_type, inner_type.lo=
ck_descriptor);
 =20
  	if (u->flip_addr) {
- 		update_flags->bits.addr_update =3D 1;
+ 		update_bits->addr_update =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_ST=
REAM);
 =20
  		if (u->flip_addr->address.tmz_surface !=3D u->surface->address.tmz_surf=
ace) {
- 			update_flags->bits.tmz_changed =3D 1;
+ 			update_bits->tmz_changed =3D 1;
  			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_G=
LOBAL);
  		}
  	}
  	if (u->in_transfer_func) {
- 		update_flags->bits.in_transfer_func_change =3D 1;
+ 		update_bits->in_transfer_func_change =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STR=
EAM);
  	}
 =20
  	if (u->input_csc_color_matrix) {
- 		update_flags->bits.input_csc_change =3D 1;
+ 		update_bits->input_csc_change =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_ST=
REAM);
  	}
 =20
  	if (u->cursor_csc_color_matrix) {
- 		update_flags->bits.cursor_csc_color_matrix_change =3D 1;
+ 		update_bits->cursor_csc_color_matrix_change =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_ST=
REAM);
  	}
 =20
  	if (u->coeff_reduction_factor) {
- 		update_flags->bits.coeff_reduction_change =3D 1;
+ 		update_bits->coeff_reduction_change =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_ST=
REAM);
  	}
 =20
  	if (u->gamut_remap_matrix) {
- 		update_flags->bits.gamut_remap_change =3D 1;
+ 		update_bits->gamut_remap_change =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_ST=
REAM);
  	}
 =20
- 	if (u->blend_tf || (u->gamma && dce_use_lut(u->plane_info ? u->plane_inf=
o->format : u->surface->format))) {
- 		update_flags->bits.gamma_change =3D 1;
+ 	if ((u->cm && u->cm->flags.bits.blend_enable) ||
+ 			(u->gamma && dce_use_lut(u->plane_info ? u->plane_info->format : u->su=
rface->format))) {
+ 		update_bits->gamma_change =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_ST=
REAM);
  	}
 =20
- 	if (u->lut3d_func || u->func_shaper) {
- 		update_flags->bits.lut_3d =3D 1;
+ 	if (u->cm && (u->cm->flags.bits.lut3d_enable || u->cm->flags.bits.shaper=
_enable)) {
+ 		update_bits->lut_3d =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_ST=
REAM);
  	}
 =20
+ 	if (u->cm && u->cm->flags.bits.lut3d_dma_enable !=3D u->surface->cm.flag=
s.bits.lut3d_dma_enable &&
+ 			u->cm->flags.bits.lut3d_enable && u->surface->cm.flags.bits.lut3d_enab=
le) {
+ 		/* Toggling 3DLUT loading between DMA and Host is illegal */
+ 		BREAK_TO_DEBUGGER();
+ 	}
+=20
+ 	if (u->cm && u->cm->flags.bits.lut3d_enable && !u->cm->flags.bits.lut3d_=
dma_enable) {
+ 		/* Host loading 3DLUT requires full update but only stream lock  */
+ 		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_ST=
REAM);
+ 	}
+=20
  	if (u->hdr_mult.value)
  		if (u->hdr_mult.value !=3D u->surface->hdr_mult.value) {
  			// TODO: Should be fast?
- 			update_flags->bits.hdr_mult =3D 1;
+ 			update_bits->hdr_mult =3D 1;
  			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_ST=
REAM);
  		}
 =20
  	if (u->sdr_white_level_nits)
  		if (u->sdr_white_level_nits !=3D u->surface->sdr_white_level_nits) {
  			// TODO: Should be fast?
- 			update_flags->bits.sdr_white_level_nits =3D 1;
+ 			update_bits->sdr_white_level_nits =3D 1;
  			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_G=
LOBAL);
  		}
 =20
  	if (u->cm_hist_control) {
- 		update_flags->bits.cm_hist_change =3D 1;
+ 		update_bits->cm_hist_change =3D 1;
  		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_ST=
REAM);
  	}
- 	if (u->cm2_params) {
- 		if (u->cm2_params->component_settings.shaper_3dlut_setting !=3D u->surf=
ace->mcm_shaper_3dlut_setting
- 				|| u->cm2_params->component_settings.lut1d_enable !=3D u->surface->mc=
m_lut1d_enable
- 				|| u->cm2_params->cm2_luts.lut3d_data.lut3d_src !=3D u->surface->mcm_=
luts.lut3d_data.lut3d_src) {
- 			update_flags->bits.mcm_transfer_function_enable_change =3D 1;
+=20
+ 	if (u->cm) {
+ 		const union dc_plane_cm_flags blend_only_flags =3D {
+ 			.bits =3D {
+ 				.blend_enable =3D 1,
+ 			}
+ 		};
+=20
+ 		if (u->cm->flags.bits.shaper_enable !=3D u->surface->cm.flags.bits.shap=
er_enable
+ 				|| u->cm->flags.bits.blend_enable !=3D u->surface->cm.flags.bits.blen=
d_enable
+ 				|| u->cm->flags.bits.lut3d_enable !=3D u->surface->cm.flags.bits.lut3=
d_enable
+ 				|| u->cm->flags.bits.lut3d_dma_enable !=3D u->surface->cm.flags.bits.=
lut3d_dma_enable) {
+ 			update_bits->mcm_transfer_function_enable_change =3D 1;
+ 			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_G=
LOBAL);
+ 		}
+=20
+ 		if ((u->cm->flags.all !=3D blend_only_flags.all && u->cm->flags.all !=
=3D 0) ||
+ 				(u->surface->cm.flags.all !=3D blend_only_flags.all && u->surface->cm=
=2Eflags.all !=3D 0)) {
  			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_G=
LOBAL);
  		}
  	}
 =20
- 	if (update_flags->bits.lut_3d &&
- 			u->surface->mcm_luts.lut3d_data.lut3d_src !=3D DC_CM2_TRANSFER_FUNC_SO=
URCE_VIDMEM) {
+ 	if (update_bits->lut_3d &&
+ 			!u->surface->cm.flags.bits.lut3d_dma_enable) {
  		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GL=
OBAL);
  	}
 =20
  	if (check_config->enable_legacy_fast_update &&
- 			(update_flags->bits.gamma_change ||
- 			update_flags->bits.gamut_remap_change ||
- 			update_flags->bits.input_csc_change ||
- 			update_flags->bits.cm_hist_change ||
- 			update_flags->bits.coeff_reduction_change)) {
+ 			(update_bits->gamma_change ||
+ 			update_bits->gamut_remap_change ||
+ 			update_bits->input_csc_change ||
+ 			update_bits->cm_hist_change ||
+ 			update_bits->coeff_reduction_change)) {
  		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GL=
OBAL);
  	}
  	return overall_type;
@@@ -3036,7 -3083,7 +3083,7 @@@ static void force_immediate_gsl_plane_f
  	if (has_flip_immediate_plane && surface_count > 1) {
  		for (i =3D 0; i < surface_count; i++) {
  			if (updates[i].surface->flip_immediate)
- 				updates[i].surface->update_flags.bits.addr_update =3D 1;
+ 				updates[i].surface->update_bits.addr_update =3D 1;
  		}
  	}
  }
@@@ -3191,9 -3238,9 +3238,9 @@@ struct surface_update_descriptor dc_che
  		struct dc_stream_update *stream_update)
  {
  	if (stream_update)
- 		stream_update->stream->update_flags.raw =3D 0;
+ 		stream_update_flags_clear(&stream_update->stream->update_flags);
  	for (int i =3D 0; i < surface_count; i++)
- 		updates[i].surface->update_flags.raw =3D 0;
+ 		dc_pipe_update_bits_clear(&updates[i].surface->update_bits);
 =20
  	return check_update_surfaces_for_stream(check_config, updates, surface_c=
ount, stream_update);
  }
@@@ -3304,24 -3351,55 +3351,55 @@@ static void copy_surface_update_to_plan
  			sizeof(struct dc_transfer_func_distributed_points));
  	}
 =20
- 	if (srf_update->cm2_params) {
- 		surface->mcm_shaper_3dlut_setting =3D srf_update->cm2_params->component=
_settings.shaper_3dlut_setting;
- 		surface->mcm_lut1d_enable =3D srf_update->cm2_params->component_setting=
s.lut1d_enable;
- 		surface->mcm_luts =3D srf_update->cm2_params->cm2_luts;
+ 	/* Shaper, 3DLUT, 1DLUT */
+ 	if (srf_update->cm) {
+ 		struct kref refcount =3D surface->cm.refcount;
+=20
+ 		memcpy(&surface->cm, srf_update->cm, sizeof(surface->cm));
+ 		surface->cm.refcount =3D refcount;
+=20
+ #ifndef TRIM_CM2
+ 		/* Populate mcm_luts from cm for legacy consumers (dml2, hwseq) */
+ 		surface->mcm_luts.lut1d_func =3D &surface->cm.blend_func;
+ 		surface->mcm_luts.shaper =3D &surface->cm.shaper_func;
+ 		if (srf_update->cm->flags.bits.lut3d_dma_enable) {
+ 			surface->mcm_luts.lut3d_data.lut3d_src =3D DC_CM2_TRANSFER_FUNC_SOURCE=
_VIDMEM;
+ 			surface->mcm_luts.lut3d_data.gpu_mem_params.addr =3D surface->cm.lut3d=
_dma.addr;
+ 			surface->mcm_luts.lut3d_data.gpu_mem_params.layout =3D
+ 				(surface->cm.lut3d_dma.swizzle =3D=3D CM_LUT_3D_SWIZZLE_LINEAR_RGB) ?
+ 					DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB :
+ 				(surface->cm.lut3d_dma.swizzle =3D=3D CM_LUT_3D_SWIZZLE_LINEAR_BGR) ?
+ 					DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR :
+ 					DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR;
+ 			surface->mcm_luts.lut3d_data.gpu_mem_params.format_params.format =3D
+ 				(surface->cm.lut3d_dma.format =3D=3D CM_LUT_PIXEL_FORMAT_RGBA16161616=
_UNORM_12MSB) ?
+ 					DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12MSB :
+ 				(surface->cm.lut3d_dma.format =3D=3D CM_LUT_PIXEL_FORMAT_RGBA16161616=
_UNORM_12LSB) ?
+ 					DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12LSB :
+ 					DC_CM2_GPU_MEM_FORMAT_16161616_FLOAT_FP1_5_10;
+ 			surface->mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params=
=2Ebias =3D
+ 				surface->cm.lut3d_dma.bias;
+ 			surface->mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params=
=2Escale =3D
+ 				surface->cm.lut3d_dma.scale;
+ 			surface->mcm_luts.lut3d_data.gpu_mem_params.component_order =3D
+ 				DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA;
+ 			surface->mcm_luts.lut3d_data.gpu_mem_params.size =3D DC_CM2_GPU_MEM_SI=
ZE_TRANSFORMED;
+ 			surface->mcm_luts.lut3d_data.mpc_3dlut_enable =3D (srf_update->cm->fla=
gs.bits.lut3d_enable !=3D 0);
+ 		} else {
+ 			surface->mcm_luts.lut3d_data.lut3d_src =3D DC_CM2_TRANSFER_FUNC_SOURCE=
_SYSMEM;
+ 			surface->mcm_luts.lut3d_data.lut3d_func =3D &surface->cm.lut3d_func;
+ 		}
+=20
+ 		if (srf_update->cm->flags.bits.shaper_enable &&
+ 				srf_update->cm->flags.bits.lut3d_enable)
+ 			surface->mcm_shaper_3dlut_setting =3D DC_CM2_SHAPER_3DLUT_SETTING_ENAB=
LE_SHAPER_3DLUT;
+ 		else if (srf_update->cm->flags.bits.shaper_enable)
+ 			surface->mcm_shaper_3dlut_setting =3D DC_CM2_SHAPER_3DLUT_SETTING_ENAB=
LE_SHAPER;
+ 		else
+ 			surface->mcm_shaper_3dlut_setting =3D DC_CM2_SHAPER_3DLUT_SETTING_BYPA=
SS_ALL;
+ #endif /* TRIM_CM2 */
  	}
 =20
- 	if (srf_update->func_shaper) {
- 		memcpy(&surface->in_shaper_func, srf_update->func_shaper,
- 		sizeof(surface->in_shaper_func));
-=20
- 		if (surface->mcm_shaper_3dlut_setting >=3D DC_CM2_SHAPER_3DLUT_SETTING_=
ENABLE_SHAPER)
- 			surface->mcm_luts.shaper =3D &surface->in_shaper_func;
- 	}
-=20
- 	if (srf_update->lut3d_func)
- 		memcpy(&surface->lut3d_func, srf_update->lut3d_func,
- 		sizeof(surface->lut3d_func));
-=20
  	if (srf_update->hdr_mult.value)
  		surface->hdr_mult =3D
  				srf_update->hdr_mult;
@@@ -3330,15 -3408,10 +3408,10 @@@
  		surface->sdr_white_level_nits =3D
  				srf_update->sdr_white_level_nits;
 =20
- 	if (srf_update->blend_tf) {
- 		memcpy(&surface->blend_tf, srf_update->blend_tf,
- 		sizeof(surface->blend_tf));
-=20
- 		if (surface->mcm_lut1d_enable)
- 			surface->mcm_luts.lut1d_func =3D &surface->blend_tf;
- 	}
-=20
- 	if (srf_update->cm2_params || srf_update->blend_tf)
+ 	if (srf_update->cm &&
+ 			(srf_update->cm->flags.bits.blend_enable ||
+ 			srf_update->cm->flags.bits.shaper_enable ||
+ 			srf_update->cm->flags.bits.lut3d_enable))
  		surface->lut_bank_a =3D !surface->lut_bank_a;
 =20
  	if (srf_update->input_csc_color_matrix)
@@@ -3714,11 -3787,11 +3787,11 @@@ static bool update_planes_and_stream_st
  	if (update_type =3D=3D UPDATE_TYPE_FULL) {
  		if (stream_update) {
  			uint32_t dsc_changed =3D stream_update->stream->update_flags.bits.dsc_=
changed;
- 			stream_update->stream->update_flags.raw =3D 0xFFFFFFFF;
+ 			stream_update_flags_set_full(&stream_update->stream->update_flags);
  			stream_update->stream->update_flags.bits.dsc_changed =3D dsc_changed;
  		}
  		for (i =3D 0; i < surface_count; i++)
- 			srf_updates[i].surface->update_flags.raw =3D 0xFFFFFFFF;
+ 			dc_pipe_update_bits_set_full(&srf_updates[i].surface->update_bits);
  	}
 =20
  	if (update_type >=3D update_surface_trace_level)
@@@ -3767,7 -3840,7 +3840,7 @@@
 =20
  		if (update_type !=3D UPDATE_TYPE_MED)
  			continue;
- 		if (surface->update_flags.bits.position_change) {
+ 		if (surface->update_bits.position_change) {
  			for (j =3D 0; j < dc->res_pool->pipe_count; j++) {
  				struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[j];
 =20
@@@ -4205,8 -4278,8 +4278,8 @@@ static void commit_planes_do_stream_upd
  					hwss_add_dc_set_optimized_required(&seq_state, dc, true);
 =20
  				} else {
- 					if (get_seamless_boot_stream_count(context) =3D=3D 0)
- 						hwss_add_prepare_bandwidth(&seq_state, dc, dc->current_state);
+ 					if (get_seamless_boot_stream_count(context) =3D=3D 0 && dc->hwss.pre=
pare_bandwidth_sequence)
+ 						dc->hwss.prepare_bandwidth_sequence(dc, dc->current_state, &seq_sta=
te);
  					hwss_add_link_set_dpms_on(&seq_state, dc->current_state, dpms_pipe_c=
tx);
  				}
  			} else if (pipe_ctx->stream->link->wa_flags.blank_stream_on_ocs_change=
 && stream_update->output_color_space
@@@ -4550,14 -4623,23 +4623,23 @@@ static void build_dmub_update_dirty_rec
  	}
  }
 =20
- static bool check_address_only_update(union surface_update_flags update_f=
lags)
+ /**
+  * dc_check_address_only_update - Check if addr_update is the sole flag s=
et
+  *
+  * @update_bits: The pipe update bits to check
+  *
+  * Determines whether an update contains only an address change with no o=
ther
+  * pending updates.
+  *
+  * Return: %true if addr_update is the sole bit set, %false otherwise.
+  */
+ bool dc_check_address_only_update(struct pipe_update_bits update_bits)
  {
- 	union surface_update_flags addr_only_update_flags;
- 	addr_only_update_flags.raw =3D 0;
- 	addr_only_update_flags.bits.addr_update =3D 1;
+ 	struct pipe_update_bits check =3D update_bits;  /* 1. Copy all flags fro=
m input */
 =20
- 	return update_flags.bits.addr_update &&
- 			!(update_flags.raw & ~addr_only_update_flags.raw);
+ 	check.addr_update =3D 0;                        /* 2. Zero the addr_upda=
te bit in the copy */
+ 	return update_bits.addr_update &&             /* 3. Check addr_update wa=
s set in original */
+ 			!dc_pipe_update_bits_is_any_set(&check); /* 4. Check no other bits rem=
ain in the copy */
  }
 =20
  /**
@@@ -4617,7 -4699,7 +4699,7 @@@ static void commit_plane_for_stream_off
  				continue;
 =20
  			/* update pipe context for plane */
- 			if (pipe_ctx->plane_state->update_flags.bits.addr_update)
+ 			if (pipe_ctx->plane_state->update_bits.addr_update)
  				dc->hwss.update_plane_addr(dc, pipe_ctx);
  		}
  	}
@@@ -4655,8 -4737,8 +4737,8 @@@ static void commit_planes_for_stream_fa
  		should_offload_fams2_flip =3D true;
  		for (i =3D 0; i < surface_count; i++) {
  			if (srf_updates[i].surface &&
- 					srf_updates[i].surface->update_flags.raw &&
- 					!check_address_only_update(srf_updates[i].surface->update_flags)) {
+ 					dc_pipe_update_bits_is_any_set(&srf_updates[i].surface->update_bits)=
 &&
+ 					!dc_check_address_only_update(srf_updates[i].surface->update_bits)) {
  				/* more than address update, need to acquire FAMS2 lock */
  				should_offload_fams2_flip =3D false;
  				break;
@@@ -4747,7 -4829,7 +4829,7 @@@
  	 * so no need to clear here.
  	 */
  	if (top_pipe_to_program->stream)
- 		top_pipe_to_program->stream->update_flags.raw =3D 0;
+ 		stream_update_flags_clear(&top_pipe_to_program->stream->update_flags);
  }
 =20
  static void commit_planes_for_stream(struct dc *dc,
@@@ -5073,11 -5155,9 +5155,9 @@@
  				if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
  					continue;
 =20
- 				if (srf_updates[i].cm2_params &&
- 						srf_updates[i].cm2_params->cm2_luts.lut3d_data.lut3d_src =3D=3D
- 								DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM &&
- 						srf_updates[i].cm2_params->component_settings.shaper_3dlut_setting =
=3D=3D
- 								DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT &&
+ 				if (srf_updates[i].cm &&
+ 						srf_updates[i].cm->flags.bits.lut3d_enable &&
+ 						srf_updates[i].cm->flags.bits.lut3d_dma_enable &&
  						dc->hwss.trigger_3dlut_dma_load)
  					dc->hwss.trigger_3dlut_dma_load(dc, pipe_ctx);
 =20
@@@ -5087,7 -5167,7 +5167,7 @@@
  					dc->hwss.program_triplebuffer(
  						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
  				}
- 				if (pipe_ctx->plane_state->update_flags.bits.addr_update)
+ 				if (pipe_ctx->plane_state->update_bits.addr_update)
  					dc->hwss.update_plane_addr(dc, pipe_ctx);
  			}
  		}
@@@ -5178,7 -5258,7 +5258,7 @@@
 =20
  		if (pipe_ctx->bottom_pipe || pipe_ctx->next_odm_pipe ||
  				!pipe_ctx->stream || !should_update_pipe_for_stream(context, pipe_ctx=
, stream) ||
- 				!pipe_ctx->plane_state->update_flags.bits.addr_update ||
+ 				!pipe_ctx->plane_state->update_bits.addr_update ||
  				pipe_ctx->plane_state->skip_manual_trigger)
  			continue;
 =20
@@@ -5617,7 -5697,7 +5697,7 @@@ static bool commit_minimal_transition_s
  	/* force full surface update */
  	for (i =3D 0; i < dc->current_state->stream_count; i++) {
  		for (j =3D 0; j < (unsigned int)dc->current_state->stream_status[i].pla=
ne_count; j++) {
- 			dc->current_state->stream_status[i].plane_states[j]->update_flags.raw =
=3D 0xFFFFFFFF;
+ 			dc_pipe_update_bits_set_full(&dc->current_state->stream_status[i].plan=
e_states[j]->update_bits);
  		}
  	}
 =20
@@@ -5792,14 -5872,9 +5872,9 @@@ static bool full_update_required
  				(srf_updates[i].sdr_white_level_nits &&
  				srf_updates[i].sdr_white_level_nits !=3D srf_updates->surface->sdr_wh=
ite_level_nits) ||
  				srf_updates[i].in_transfer_func ||
- 				srf_updates[i].func_shaper ||
- 				srf_updates[i].lut3d_func ||
  				srf_updates[i].surface->force_full_update ||
  				(srf_updates[i].flip_addr &&
- 				srf_updates[i].flip_addr->address.tmz_surface !=3D srf_updates[i].sur=
face->address.tmz_surface) ||
- 				(srf_updates[i].cm2_params &&
- 				 (srf_updates[i].cm2_params->component_settings.shaper_3dlut_setting =
!=3D srf_updates[i].surface->mcm_shaper_3dlut_setting ||
- 				  srf_updates[i].cm2_params->component_settings.lut1d_enable !=3D srf=
_updates[i].surface->mcm_lut1d_enable))))
+ 				srf_updates[i].flip_addr->address.tmz_surface !=3D srf_updates[i].sur=
face->address.tmz_surface)))
  			return true;
  	}
 =20
@@@ -6063,17 -6138,17 +6138,17 @@@ static bool update_planes_and_stream_v3
  	return true;
  }
 =20
- static void clear_update_flags(struct dc_surface_update *srf_updates,
+ static void clear_update_bits(struct dc_surface_update *srf_updates,
  	int surface_count, struct dc_stream_state *stream)
  {
  	int i;
 =20
  	if (stream)
- 		stream->update_flags.raw =3D 0;
+ 		stream_update_flags_clear(&stream->update_flags);
 =20
  	for (i =3D 0; i < surface_count; i++)
  		if (srf_updates[i].surface)
- 			srf_updates[i].surface->update_flags.raw =3D 0;
+ 			dc_pipe_update_bits_clear(&srf_updates[i].surface->update_bits);
  }
 =20
  bool dc_update_planes_and_stream(struct dc *dc,
@@@ -6125,7 -6200,7 +6200,7 @@@ void dc_commit_updates_for_stream(struc
  	}
 =20
  	if (ret && dc->ctx->dce_version >=3D DCN_VERSION_3_2)
- 		clear_update_flags(srf_updates, surface_count, stream);
+ 		clear_update_bits(srf_updates, surface_count, stream);
  }
 =20
  uint8_t dc_get_current_stream_count(struct dc *dc)
@@@ -6165,6 -6240,115 +6240,6 @@@ void dc_interrupt_ack(struct dc *dc, en
  	dal_irq_service_ack(dc->res_pool->irqs, src);
  }
 =20
 -/* Preserve this tg if a physical link is still lighting a present displa=
y */
 -static bool should_preserve_tg(struct dc *dc, struct timing_generator *tg)
 -{
 -	unsigned int i, j;
 -
 -	/* Check if a physical link is lighting this tg */
 -	for (i =3D 0; i < dc->link_count; i++) {
 -		struct dc_link *link =3D dc->links[i];
 -		int fe;
 -
 -		if (!link || link->ep_type !=3D DISPLAY_ENDPOINT_PHY ||
 -				!link->link_enc ||
 -				!link->link_enc->funcs->is_dig_enabled ||
 -				!link->link_enc->funcs->is_dig_enabled(link->link_enc) ||
 -				!link->link_enc->funcs->get_dig_frontend)
 -			continue;
 -
 -		/* Get the DIG front-end this link's encoder drives; skip if none */
 -		fe =3D link->link_enc->funcs->get_dig_frontend(link->link_enc);
 -		if (fe =3D=3D ENGINE_ID_UNKNOWN)
 -			continue;
 -
 -		/* Find the stream encoder bound to this link's front-end */
 -		for (j =3D 0; j < dc->res_pool->stream_enc_count; j++) {
 -			struct stream_encoder *se =3D dc->res_pool->stream_enc[j];
 -
 -			/* Skip unless this stream encoder feeds our front-end and drives this=
 tg */
 -			if (se->id !=3D fe || !se->funcs->dig_source_otg ||
 -					(int)se->funcs->dig_source_otg(se) !=3D tg->inst)
 -				continue;
 -
 -			/* This link drives the OTG: keep a seamless-boot eDP, or
 -			 * any external link whose sink is still connected.
 -			 */
 -			if (link->connector_signal =3D=3D SIGNAL_TYPE_EDP)
 -				return true;
 -			if (link->link_enc->funcs->get_hpd_state &&
 -					dc->link_srv->get_hpd_state(link))
 -				return true;
 -		}
 -	}
 -
 -	return false;
 -}
 -
 -/*
 - * GOP/vBIOS may leave an OPTC enabled for a display present at power-on =
but no
 - * longer driven (e.g. external DP unplugged at boot). Such a dangling pi=
pe keeps
 - * DCN out of idle and blocks s0i3. If nothing needs to survive (no commi=
tted
 - * stream or seamless-boot eDP) and no sink is still connected, power dow=
n all hw
 - * blocks.
 - */
 -void dc_disable_dangling_timing_generators(struct dc *dc)
 -{
 -	struct dce_hwseq *hws =3D dc->hwseq;
 -	bool any_dangling =3D false;
 -	bool any_preserved =3D false;
 -	bool any_connected =3D false;
 -	unsigned int i;
 -
 -	/* No real hw to touch on a virtual/emulated environment */
 -	if (dc->ctx->dce_environment =3D=3D DCE_ENV_VIRTUAL_HW)
 -		return;
 -
 -	/* Wake hw out of IPS before reading/touching tg state */
 -	dc_exit_ips_for_hw_access(dc);
 -
 -	/* Classify every enabled tg as either to-preserve or dangling */
 -	for (i =3D 0; i < dc->res_pool->timing_generator_count; i++) {
 -		struct timing_generator *tg =3D dc->res_pool->timing_generators[i];
 -
 -		if (!tg || !tg->funcs->is_tg_enabled ||
 -				!tg->funcs->is_tg_enabled(tg))
 -			continue;
 -
 -		if (should_preserve_tg(dc, tg))
 -			any_preserved =3D true;
 -		else
 -			any_dangling =3D true;
 -	}
 -
 -	/* A physically connected sink (HPD asserted) will be re-lit by a
 -	 * subsequent atomic commit. For that case we don't call the global
 -	 * power_down().
 -	 */
 -	for (i =3D 0; i < dc->link_count; i++) {
 -		struct dc_link *link =3D dc->links[i];
 -
 -		if (link && link->ep_type =3D=3D DISPLAY_ENDPOINT_PHY &&
 -				link->link_enc && link->link_enc->funcs &&
 -				link->link_enc->funcs->get_hpd_state &&
 -				dc->link_srv->get_hpd_state(link)) {
 -			any_connected =3D true;
 -			break;
 -		}
 -	}
 -
 -	if (!any_dangling)
 -		return;
 -
 -	if (!any_preserved && !any_connected && hws && hws->funcs.power_down) {
 -		/* Truly headless / all sinks unplugged: nothing to preserve */
 -		DC_LOG_DC("%s: powering down dangling hw blocks to allow idle\n",
 -				__func__);
 -		hws->funcs.power_down(dc);
 -		return;
 -	}
 -}
 -
  /*
   * dc_get_flip_pending_on_otg() - Check if a GRPH_FLIP is still pending o=
n OTG
   *
@@@ -6183,7 -6367,7 +6258,7 @@@
  bool dc_get_flip_pending_on_otg(struct dc *dc, int otg_inst)
  {
  	bool flip_pending =3D false;
- 	int i;
+ 	unsigned int i;
 =20
  	if (!dc || !dc->current_state)
  		return false;
@@@ -7587,7 -7771,7 +7662,7 @@@ bool dc_capture_register_software_state
  			struct dc_plane_state *plane_state =3D pipe_ctx->plane_state;
 =20
  			/* MPCC blending tree and mode control - capture actual blend configur=
ation */
- 			state->mpc.mpcc_mode[i] =3D (plane_state->blend_tf.type !=3D TF_TYPE_B=
YPASS) ? 1 : 0;
+ 			state->mpc.mpcc_mode[i] =3D (plane_state->cm.blend_func.type !=3D TF_T=
YPE_BYPASS) ? 1 : 0;
  			state->mpc.mpcc_alpha_blend_mode[i] =3D plane_state->per_pixel_alpha ?=
 1 : 0;
  			state->mpc.mpcc_alpha_multiplied_mode[i] =3D plane_state->pre_multipli=
ed_alpha ? 1 : 0;
  			state->mpc.mpcc_blnd_active_overlap_only[i] =3D 0; /* Default - no ove=
rlap restriction */
@@@ -7920,7 -8104,7 +7995,7 @@@ struct dc_update_scratch_space=20
  	struct dc_stream_state *stream;
  	struct dc_stream_update *stream_update;
  	bool update_v3;
- 	bool do_clear_update_flags;
+ 	bool do_clear_update_bits;
  	enum surface_update_type update_type;
  	struct dc_state *new_context;
  	enum update_v3_flow flow;
@@@ -7963,8 -8147,8 +8038,8 @@@ static bool update_planes_and_stream_cl
  		const struct dc_update_scratch_space *scratch
  )
  {
- 	if (scratch->do_clear_update_flags)
- 		clear_update_flags(scratch->surface_updates, scratch->surface_count, sc=
ratch->stream);
+ 	if (scratch->do_clear_update_bits)
+ 		clear_update_bits(scratch->surface_updates, scratch->surface_count, scr=
atch->stream);
 =20
  	return false;
  }
@@@ -8218,8 -8402,8 +8293,8 @@@ static bool update_planes_and_stream_cl
  		ASSERT(false);
  	}
 =20
- 	if (scratch->do_clear_update_flags)
- 		clear_update_flags(scratch->surface_updates, scratch->surface_count, sc=
ratch->stream);
+ 	if (scratch->do_clear_update_bits)
+ 		clear_update_bits(scratch->surface_updates, scratch->surface_count, scr=
atch->stream);
 =20
  	return false;
  }
@@@ -8242,7 -8426,7 +8317,7 @@@ struct dc_update_scratch_space *dc_upda
  		.stream =3D stream,
  		.stream_update =3D stream_update,
  		.update_v3 =3D version >=3D DCN_VERSION_4_01 || version =3D=3D DCN_VERS=
ION_3_2 || version =3D=3D DCN_VERSION_3_21,
- 		.do_clear_update_flags =3D version >=3D DCN_VERSION_1_0,
+ 		.do_clear_update_bits =3D version >=3D DCN_VERSION_1_0,
  	};
 =20
  	return scratch;

--5YZEPzi8xrFAEvia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaPu8ACgkQJNaLcl1U
h9AWWQf/UzNyvoG41J2CRqXB7A6Mm7+hUFc1kXLcxmyoUOTClNo9MNHxHBoK1NRT
vB+rYlYT777sSYSBpPAMZ/YoDaJrLm/uTmea49IbEyjWdZIK2MTI6dnQrVYQlJ4r
0+wmP5E0JVa78D9a307qVj+BIv1xL03AKpwRWVMRqXYYwMCNTlQY2qIfhifp7kfA
W402zlbwMEoTawS7ooIxNhtz47JukwdBjhoYSnyXXSRMGRTIaIXfcGWn7Gst8Xnl
mtumBMmfAkT0xNs5JQHP9B6NJylxLmQtDu+4FO7s4YUFhKielwnNiletsnfpv8At
p8xx2mat5TXlLSR8UErFtoJVGfQr5g==
=tzh1
-----END PGP SIGNATURE-----

--5YZEPzi8xrFAEvia--
