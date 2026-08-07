Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DF6C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DD210F50D;
	Fri,  7 Aug 2026 14:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fjj3/7Kb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F33510F50D
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:42:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEF2860051;
 Fri,  7 Aug 2026 14:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FFC1F00AC4;
 Fri,  7 Aug 2026 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786113776;
 bh=VdwGpuBsIMSdUUZpa1SC6i0wbOq9wdCggYK01AzpwMY=;
 h=Date:From:To:Cc:Subject;
 b=fjj3/7Kb4ApnotXDuPrihjWBlQEhY5Ege6xMzyD9QWdUMeFlQ7oeBPcnyT1g65maz
 DYrKbx7Sper+IkeMaRjYoowaAoacRS41Xg7T7gx5lqR5ZIiJMNWYQmfD0r5h59wV/c
 DUMtABvSBFK89ANxpJTU4Wr+NOCsGqqoJOguxGmCNlWis5Gf27jX5+pFKd7YaUurKZ
 IvZdMwPcYcmD00eAXXRm5E7oq1gvvQxKB6eEm6jdIwQoWqj0xf6qfrbusWLwqQr97p
 7Tmxrd23Nfm4TJyW0G5tJWy326Yeve519Oi9CyL8M+WiL7aIz3IBwMEISbInoy+RUV
 l6eI9ubeI8InA==
Date: Fri, 7 Aug 2026 15:42:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Ray Wu <ray.wu@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <anXu7K7kjkoJHEbZ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R5k9hXJEqYTJYcOx"
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


--R5k9hXJEqYTJYcOx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c

between commits:

  3141e3d61469b ("drm/amd/display: Check for tg ops in dce110_set_avmute")
  443290d70b01e ("drm/amd/display: Add AV mute wait frames to dce110_set_av=
mute")

=66rom the drm-fixes tree and commit:

  414da24137ace ("drm/amd/display: Add AV mute wait frames to dce110_set_av=
mute")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

This is a pretty clear example of the sorts of issues the constant
cherry picking causes.

diff --combined drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index f5b3a2eff94a0,f91ce2b4b1bfa..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@@ -607,11 -607,10 +607,10 @@@ dce110_translate_regamma_to_hw_format(c
  }
 =20
  static bool
- dce110_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
- 				const struct dc_stream_state *stream)
+ dce110_set_output_transfer_func(struct set_output_transfer_func_params *p=
arams)
  {
- 	(void)dc;
- 	struct transform *xfm =3D pipe_ctx->plane_res.xfm;
+ 	struct transform *xfm =3D params->xfm;
+ 	const struct dc_stream_state *stream =3D params->stream;
 =20
  	xfm->funcs->opp_power_on_regamma_lut(xfm, true);
  	xfm->regamma_params.hw_points_num =3D GAMMA_HW_POINTS_NUM;
@@@ -1348,10 -1347,7 +1347,7 @@@ void dce110_set_avmute(struct pipe_ctx=20
  		 * process the mute state, especially after link re-establishment
  		 * with HDMI 2.0 scrambling enabled.
  		 */
- 		if (enable && pipe_ctx->stream_res.tg &&
- 		    pipe_ctx->stream_res.tg->funcs->is_tg_enabled &&
- 		    pipe_ctx->stream_res.tg->funcs->wait_for_state &&
- 		    pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.=
tg)) {
+ 		if (enable && pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->s=
tream_res.tg)) {
  			int i;
 =20
  			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg=
, CRTC_STATE_VACTIVE);
@@@ -2826,23 -2822,26 +2822,26 @@@ static void program_surface_visibility(
 =20
  }
 =20
- static void program_gamut_remap(struct pipe_ctx *pipe_ctx)
+ static void program_gamut_remap(struct program_gamut_remap_params *params)
  {
+ 	struct transform *xfm =3D params->xfm;
+ 	const struct dc_stream_state *stream =3D params->stream;
  	int i =3D 0;
  	struct xfm_grph_csc_adjustment adjust;
+=20
  	memset(&adjust, 0, sizeof(adjust));
  	adjust.gamut_adjust_type =3D GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
 =20
 =20
- 	if (pipe_ctx->stream->gamut_remap_matrix.enable_remap =3D=3D true) {
+ 	if (stream->gamut_remap_matrix.enable_remap =3D=3D true) {
  		adjust.gamut_adjust_type =3D GRAPHICS_GAMUT_ADJUST_TYPE_SW;
 =20
  		for (i =3D 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
  			adjust.temperature_matrix[i] =3D
- 				pipe_ctx->stream->gamut_remap_matrix.matrix[i];
+ 				stream->gamut_remap_matrix.matrix[i];
  	}
 =20
- 	pipe_ctx->plane_res.xfm->funcs->transform_set_gamut_remap(pipe_ctx->plan=
e_res.xfm, &adjust);
+ 	xfm->funcs->transform_set_gamut_remap(xfm, &adjust);
  }
  static void update_plane_addr(const struct dc *dc,
  		struct pipe_ctx *pipe_ctx)
@@@ -3188,13 -3187,13 +3187,13 @@@ static void dce110_program_front_end_fo
  				plane_state->rotation);
 =20
  	/* Moved programming gamma from dc to hwss */
- 	if (pipe_ctx->plane_state->update_flags.bits.full_update ||
- 			pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
- 			pipe_ctx->plane_state->update_flags.bits.gamma_change)
+ 	if (pipe_ctx->plane_state->update_bits.full_update ||
+ 			pipe_ctx->plane_state->update_bits.in_transfer_func_change ||
+ 			pipe_ctx->plane_state->update_bits.gamma_change)
  		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 =20
- 	if (pipe_ctx->plane_state->update_flags.bits.full_update)
- 		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
+ 	if (pipe_ctx->plane_state->update_bits.full_update)
+ 		hwss_set_output_transfer_func(dc, pipe_ctx);
 =20
  	DC_LOG_SURFACE(
  			"Pipe:%d %p: addr hi:0x%x, "

--R5k9hXJEqYTJYcOx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp17usACgkQJNaLcl1U
h9C5ugf/Y8dGx6/ndTxTAdsSVmVR1w+gbOx0DVSGU/6OKS4M/MWm/0ketBXAgrLx
HrDkcnRuBQduATAevluif2Rt9WJi3SDIBeZUulFC3PFzoseVAzQSpnxttChedPef
QFqf0/jk9kYa2A7CbZWWxJNHrGonNSeB1OeRdfYsLfHOl1QZwQeMnkjjggwyhLE/
owjhBgFcMZ7s3IxnaNiqAwESlRWDVKifJAWiwmkq1AAdWtpWeVoQm9BmCLyngxhg
ECX78grzJUYoVpMSwYXypIguVh1GILH/6c1ZxCgH67WbERjyA3awTRYH8icvyfj6
DzAFH8YFb1O77/minMzlw625qw4V6g==
=bZGt
-----END PGP SIGNATURE-----

--R5k9hXJEqYTJYcOx--
