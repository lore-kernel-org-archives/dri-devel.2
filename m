Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24927C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB8B10E8E8;
	Mon, 10 Aug 2026 15:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AXtaDj+r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF4610E8E8
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:02:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 94C1560A6E;
 Mon, 10 Aug 2026 15:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761BC1F000E9;
 Mon, 10 Aug 2026 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786374155;
 bh=hEk4BuzvaC+vu6TqSvCp8+5pFlEXL/ArMkk50WgIKWA=;
 h=Date:From:To:Cc:Subject;
 b=AXtaDj+rCdd7YYlGf54va4A93f1lU198JPIBCBHL6d2DGcw7wyXOC9J8BFUxZa93x
 gqK4LqSbw8loaER62Ezj/vK0hvX+aTE8383ShhszY+kYI8okH83iJ7fpHt1gKPQA/F
 bm5LXP7sDu3or3JBpualhSPRrPrl/Zzc7yqlu6cm96t7zJYV3D00ngNcknVwwsTmhw
 EwWuG+WmaKzQSH4/Bsp9s+h+rjxWmhtz13A0NM/jPfFs4KDo0+1IDJQxmiG6z2gv1r
 bwl6PLIxN6EiMWoxKn0gn3GRbpHvVpQ4pjidSFGElxyLHyAdA10rEoOHeh5RnVpcVo
 oldWLk/qiVpQA==
Date: Mon, 10 Aug 2026 16:02:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 George Zhang <george.zhang@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matthew Stewart <Matthew.Stewart2@amd.com>, Roman Li <roman.li@amd.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <annoBpNA9VXWao4L@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qspAP+TxOsXsf+oQ"
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


--qspAP+TxOsXsf+oQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c

between commit:

  fbbbd98f200f1 ("drm/amd/display: Fix DCN42B null registers & register mas=
ks")

=66rom the origin tree and commits:

  77c9d06187f18 ("drm/amd/display: Add missing DCN42B register defines")
  183bbded999a7 ("drm/amd/display: fix dcn42b det allocation order")
  fd651b9a3be9e ("drm/amd/display: Add DCN42B VID_CRC_CONTROL and HBLANK_CO=
NTROL registers")
  b7d69145907cd ("drm/amd/display: Fix DCN42B null registers & register mas=
ks")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resou=
rce.c
index 94e166c0a9b0b,41f0c67f57fff..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@@ -13,6 -13,7 +13,7 @@@
 =20
  #include "resource.h"
  #include "include/irq_service_interface.h"
+ #include "basics/conversion.h"
 =20
  #include "dcn42b_resource.h"
  #include "dcn20/dcn20_resource.h"
@@@ -134,6 -135,34 +135,34 @@@
  #define regHUBP3_HUBPREQ_DEBUG                0x088d
  #define regHUBP3_HUBPREQ_DEBUG_BASE_IDX       2
 =20
+ #define regDP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL                    =
                               0x3687
+ #define regDP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX           =
                               2
+ #define regDP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL                    =
                               0x375b
+ #define regDP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX           =
                               2
+ #define regDP_SYM32_ENC2_DP_SYM32_ENC_VID_CRC_CONTROL                    =
                               0x382f
+ #define regDP_SYM32_ENC2_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX           =
                               2
+ #define regDP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL                     =
                               0x366b
+ #define regDP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX            =
                               2
+ #define regDP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL                     =
                               0x373f
+ #define regDP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX            =
                               2
+ #define regDP_SYM32_ENC2_DP_SYM32_ENC_HBLANK_CONTROL                     =
                               0x3813
+ #define regDP_SYM32_ENC2_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX            =
                               2
+=20
+ #define DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_ENABLE__SHIFT    =
                                     0x0
+ #define DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_CONT_MODE_ENABLE_=
_SHIFT                               0x4
+ #define DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_ENABLE_MASK      =
                                     0x00000001L
+ #define DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_CONT_MODE_ENABLE_=
MASK                                 0x00000010L
+ #define DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL__HBLANK_MINIMUM_SYMBOL_=
WIDTH__SHIFT                         0x0
+ #define DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL__HBLANK_MINIMUM_SYMBOL_=
WIDTH_MASK                           0x0000FFFFL
+=20
+=20
+ #define DP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_ENABLE__SHIFT    =
                                     0x0
+ #define DP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_CONT_MODE_ENABLE_=
_SHIFT                               0x4
+ #define DP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_ENABLE_MASK      =
                                     0x00000001L
+ #define DP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_CONT_MODE_ENABLE_=
MASK                                 0x00000010L
+ #define DP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL__HBLANK_MINIMUM_SYMBOL_=
WIDTH__SHIFT                         0x0
+ #define DP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL__HBLANK_MINIMUM_SYMBOL_=
WIDTH_MASK                           0x0000FFFFL
+=20
  enum dcn401_clk_src_array_id {
  	DCN401_CLK_SRC_PLL0,
  	DCN401_CLK_SRC_PLL1,
@@@ -253,10 -282,10 +282,10 @@@ static struct bios_registers bios_regs
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
@@@ -351,15 -380,15 +380,15 @@@ static const struct dcn10_link_enc_mas
  	LINK_ENCODER_MASK_SH_LIST_DCN42B(_MASK)};
 =20
  #define hpo_dp_stream_encoder_reg_init(id) \
- 	DCN42B_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
+ 	DCN42_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 =20
  static struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_reg=
s[4];
 =20
  static const struct dcn31_hpo_dp_stream_encoder_shift hpo_dp_se_shift =3D=
 {
- 	DCN4_2B_HPO_DP_STREAM_ENC_MASK_SH_LIST(__SHIFT)};
+ 	DCN4_2_HPO_DP_STREAM_ENC_MASK_SH_LIST(__SHIFT)};
 =20
  static const struct dcn31_hpo_dp_stream_encoder_mask hpo_dp_se_mask =3D {
- 	DCN4_2B_HPO_DP_STREAM_ENC_MASK_SH_LIST(_MASK)};
+ 	DCN4_2_HPO_DP_STREAM_ENC_MASK_SH_LIST(_MASK)};
 =20
  #define hpo_dp_link_encoder_reg_init(id) \
  	DCN42B_HPO_DP_LINK_ENC_REG_LIST_RI(id)
@@@ -756,6 -785,7 +785,7 @@@ static const struct dc_plane_cap plane_
  	.min_height =3D 64};
 =20
  static const struct dc_debug_options debug_defaults_drv =3D {
+ 	.limit_ffe =3D 3,
  	.disable_dmcu =3D true,
  	.force_abm_enable =3D false,
  	.clock_trace =3D true,
@@@ -775,7 -805,7 +805,7 @@@
  	.underflow_assert_delay_us =3D 0xFFFFFFFF,
  	.dwb_fi_phase =3D -1, // -1 =3D disable,
  	.dmub_command_table =3D true,
- 	.pstate_enabled =3D false,
+ 	.pstate_enabled =3D true,
  	.enable_mem_low_power =3D {
  		.bits =3D {
  			.vga =3D false,
@@@ -801,7 -831,7 +831,7 @@@
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
@@@ -823,7 -853,7 +853,7 @@@
  	.disable_timeout =3D true,
  	.min_disp_clk_khz =3D 50000,
  	.static_screen_wait_frames =3D 2,
- 	.disable_z10 =3D true,
+ 	.disable_z10 =3D false,
  	.ignore_pg =3D true,
  	.disable_stutter_for_wm_program =3D true,
  	.min_deep_sleep_dcfclk_khz =3D 8000,
@@@ -1034,9 -1064,9 +1064,9 @@@ static struct hubp *dcn42b_hubp_create
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
@@@ -1842,7 -1872,7 +1872,7 @@@ static struct link_encoder *dcn42b_link
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
@@@ -1854,6 -1884,8 +1884,8 @@@
  			ctx,
  			&link_enc_feature,
  			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+ 			&le_shift,
+ 			&le_mask,
  			eng_id);
 =20
  	return &enc20->enc10.base;
@@@ -2002,11 -2034,10 +2034,10 @@@ static bool dcn42b_resource_construct
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
@@@ -2066,6 -2097,7 +2097,7 @@@
  	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_format_support.float_fp1_5_10 =
=3D 1;
  	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_pixel_order_support.order_rgba =
=3D 1;
  	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_pixel_order_support.order_bgra =
=3D 1;
+ 	dc->caps.color.mpc.max_gamut_remap_coeff =3D dc_fixpt_from_fraction(S3D1=
2_MAX, DIVIDER);
 =20
  	dc->caps.num_of_host_routers =3D 0;
  	dc->caps.num_of_dpias_per_host_router =3D 0;

--qspAP+TxOsXsf+oQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp56AYACgkQJNaLcl1U
h9DS7gf/XbZWotxD07B283xLMPi+d6xIW9iGPWN9kCONXDtCR8pBgoHg3rr+aqmD
Y/FQVicZrF3vR/4avvoDXfznJtalSs3hzZaJiI5Sv6OWkabndUfYdyAa133h/lI4
M3TjPOPEolq1R15RZMSXjlZzAGw7+Fs65ZYvStlurcT171q1nrxd0bnOE5exbmAw
loBjAk8slXwf4D+nl0QqUc4yO8r8kvTdApx1JnCSV1fdqEYsEviHNHW0DBMVR7E9
/yTp3n1muTy/WCKqHMKB1STAhUKNtO9F69myQkpQbLi/7lNZ55NAr0SeekdgiU1M
iNK6nl1Rs+LL9JSM3C/7hDURwnLNLQ==
=Ozg+
-----END PGP SIGNATURE-----

--qspAP+TxOsXsf+oQ--
