Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D59C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AD710E46E;
	Fri, 17 Jul 2026 14:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="brh0cHYR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264CA10E46E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:40:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C83FB438E6;
 Fri, 17 Jul 2026 14:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9E01F000E9;
 Fri, 17 Jul 2026 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784299212;
 bh=yuQHt4vM4oxzyIT7gGQbZcveylM2LK1m0oDVVsHVNn0=;
 h=Date:From:To:Cc:Subject;
 b=brh0cHYRUYcSWqtSQKAi1bBfIcYHt1ja5/GmB2boKe+VonMCKi5Qu3WooUpOUn+mR
 9CRJKMLEcCOxeognYp8B3JL5bVDNIs0KPOoE8PYAG7yxN1Hlyt/PeveEyxAt3XPi1t
 zfTpI1+1hV31K2/XZQMC2lPeSNe0R/FwfvfD6hzyKezJCemAIrhXp8Xe0niHqG+tUv
 4fxBIzcKB/guUAyR/Qp/gpnAT8xIjKTVgq31jloKmvfUkxkfErSPvosudz6MjmdrTE
 tBGiZMURW9wodSfwBQlZwvntRbN2n/o2d9934IJUHJXcdXOruGvwqGDTIVcurjjkGP
 OBW9Xu9L/jfBQ==
Date: Fri, 17 Jul 2026 15:40:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Gabe Teeger <gabe.teeger@amd.com>, George Zhang <george.zhang@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matthew Stewart <matthew.stewart2@amd.com>,
 Peichen Huang <PeiChen.Huang@amd.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <alo-x_TORE2vBFlX@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZZLZ1kTB3QU/qgb3"
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


--ZZLZ1kTB3QU/qgb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c

between commits:

  6351003b1f4ec ("drm/amd/display: wire DCN42B mcache programming callback")
  57cf172be2827 ("drm/amd/display: fix dcn42b det allocation order")
  c4bc7ffb91586 ("drm/amd/display: Fix DCN42B null registers & register mas=
ks")

=66rom the drm-fixes tree and commits:

  85453fb4ff726 ("drm/amd/display: wire DCN42B mcache programming callback")
  183bbded999a7 ("drm/amd/display: fix dcn42b det allocation order")
  fd651b9a3be9e ("drm/amd/display: Add DCN42B VID_CRC_CONTROL and HBLANK_CO=
NTROL registers")
  219fb1f4c5b91 ("drm/amd/display: Enable zstate support and fix seamless b=
oot")
  b7d69145907cd ("drm/amd/display: Fix DCN42B null registers & register mas=
ks")
  6cefc59d36667 ("drm/amd/display: Enable IPS support for DCN4 Variant")
  329baa1c5f62b ("drm/amd/display: Enable PSR and Replay on DCN4 variant [P=
art 2]")
  e14fcf9e5d2b5 ("drm/amd/display: correct encoder minimal creation")
  d2184b1ba1be2 ("drm/amd/display: Enable pstate for DCN4 non-emulation bui=
lds")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resou=
rce.c
index 94e166c0a9b0b,2334bc5b75b8f..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@@ -134,6 -134,19 +134,6 @@@
  #define regHUBP3_HUBPREQ_DEBUG                0x088d
  #define regHUBP3_HUBPREQ_DEBUG_BASE_IDX       2
 =20
 -#define regDP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL                    =
                               0x3687
 -#define regDP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX           =
                               2
 -#define regDP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL                    =
                               0x375b
 -#define regDP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX           =
                               2
 -#define regDP_SYM32_ENC2_DP_SYM32_ENC_VID_CRC_CONTROL                    =
                               0x382f
 -#define regDP_SYM32_ENC2_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX           =
                               2
 -#define regDP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL                     =
                               0x366b
 -#define regDP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX            =
                               2
 -#define regDP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL                     =
                               0x373f
 -#define regDP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX            =
                               2
 -#define regDP_SYM32_ENC2_DP_SYM32_ENC_HBLANK_CONTROL                     =
                               0x3813
 -#define regDP_SYM32_ENC2_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX            =
                               2
 -
  enum dcn401_clk_src_array_id {
  	DCN401_CLK_SRC_PLL0,
  	DCN401_CLK_SRC_PLL1,
@@@ -253,10 -266,10 +253,10 @@@ static struct bios_registers bios_regs
  static struct dce110_clk_src_regs clk_src_regs[5];
 =20
  static const struct dce110_clk_src_shift cs_shift =3D {
- 	CS_COMMON_MASK_SH_LIST_DCN3_2(__SHIFT)
+ 	CS_COMMON_MASK_SH_LIST_DCN4_0_1(__SHIFT)
  };
  static const struct dce110_clk_src_mask cs_mask =3D {
- 	CS_COMMON_MASK_SH_LIST_DCN3_2(_MASK)
+ 	CS_COMMON_MASK_SH_LIST_DCN4_0_1(_MASK)
  };
  #define abm_regs_init(id) \
  	ABM_DCN42B_REG_LIST_RI(id)
@@@ -351,7 -364,7 +351,7 @@@ static const struct dcn10_link_enc_mas
  	LINK_ENCODER_MASK_SH_LIST_DCN42B(_MASK)};
 =20
  #define hpo_dp_stream_encoder_reg_init(id) \
- 	DCN42B_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
+ 	DCN42_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 =20
  static struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_reg=
s[4];
 =20
@@@ -775,7 -788,7 +775,7 @@@ static const struct dc_debug_options de
  	.underflow_assert_delay_us =3D 0xFFFFFFFF,
  	.dwb_fi_phase =3D -1, // -1 =3D disable,
  	.dmub_command_table =3D true,
- 	.pstate_enabled =3D false,
+ 	.pstate_enabled =3D true,
  	.enable_mem_low_power =3D {
  		.bits =3D {
  			.vga =3D false,
@@@ -801,7 -814,7 +801,7 @@@
  		}
  	},
  	.seamless_boot_odm_combine =3D DML_FAIL_SOURCE_PIXEL_FORMAT,
- 	.enable_z9_disable_interface =3D false, /* Allow support for the PMFW in=
terface for disable Z9*/
+ 	.enable_z9_disable_interface =3D true, /* Allow support for the PMFW int=
erface for disable Z9*/
  	.minimum_z8_residency_time =3D 1, /* Always allow when other conditions =
are met */
  	.support_eDP1_5 =3D true,
  	.use_max_lb =3D true,
@@@ -823,7 -836,7 +823,7 @@@
  	.disable_timeout =3D true,
  	.min_disp_clk_khz =3D 50000,
  	.static_screen_wait_frames =3D 2,
- 	.disable_z10 =3D true,
+ 	.disable_z10 =3D false,
  	.ignore_pg =3D true,
  	.disable_stutter_for_wm_program =3D true,
  	.min_deep_sleep_dcfclk_khz =3D 8000,
@@@ -1034,9 -1047,9 +1034,9 @@@ static struct hubp *dcn42b_hubp_create
  }
  static const struct dc_panel_config dcn42b_panel_config_defaults =3D {
  	.psr =3D {
- 		.disable_psr =3D true,
+ 		.disable_psr =3D false,
  		.disallow_psrsu =3D true,
- 		.disallow_replay =3D true,
+ 		.disallow_replay =3D false,
  	},
  	.ilr =3D {
  		.optimize_edp_link_rate =3D true,
@@@ -1842,7 -1855,7 +1842,7 @@@ static struct link_encoder *dcn42b_link
  {
  	struct dcn20_link_encoder *enc20;
 =20
- 	if ((unsigned int)(eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap=
->num_dig_link_enc)
+ 	if ((unsigned int)(eng_id - ENGINE_ID_DIGA) >=3D ctx->dc->res_pool->res_=
cap->num_dig_link_enc)
  		return NULL;
 =20
  	enc20 =3D kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@@ -1854,6 -1867,8 +1854,8 @@@
  			ctx,
  			&link_enc_feature,
  			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+ 			&le_shift,
+ 			&le_mask,
  			eng_id);
 =20
  	return &enc20->enc10.base;
@@@ -2002,11 -2017,10 +2004,10 @@@ static bool dcn42b_resource_construct
  	dc->caps.dmcub_support =3D true;
  	dc->caps.is_apu =3D true;
  	dc->caps.seamless_odm =3D true;
- 	dc->caps.zstate_support =3D false;
- 	dc->caps.ips_support =3D false;
+ 	dc->caps.zstate_support =3D true;
+ 	dc->caps.ips_support =3D true;
  	dc->caps.max_v_total =3D (1 << 15) - 1;
  	dc->caps.vtotal_limited_by_fp2 =3D true;
- 	dc->config.disable_ips =3D DMUB_IPS_DISABLE_ALL;
 =20
  	/* Color pipeline capabilities */
  	dc->caps.color.dpp.dcn_arch =3D 1;

--ZZLZ1kTB3QU/qgb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaPsYACgkQJNaLcl1U
h9ArGAf/dlUzmiBaiMxRIJeqDXrNp5EwMGCaq/ZZyCBc7TCM9SGl+OGqRjQ2QzsF
Hqrw9ZuKi5ZAzVNOSMzjkIxvXTdWxMOXMV479LhADLHH5CxRuM7/RAeY2mp0fVoQ
nFb4HCbA6KQf8V7Ug6br1qxH4L4gbw+fhOC4xGE+w07Twyhsgx+9qiyclkjp5L0r
6EtFnyPpZ/sd2E4ZvLIZ8P5cA/IvN9DpLb4f2MEBu0bmhrSJHiQBfyd+PuBm+iDC
Eha0ZMUzl6+X7mwlr+CCkgQwuttrMABQaYXh8mtNr8f+i2KzLUL5HxWEHBadYP+8
uBCfOH0fX7pFmFS+oQCJKTyu4xWvWQ==
=E5qr
-----END PGP SIGNATURE-----

--ZZLZ1kTB3QU/qgb3--
