Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0085DC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CC310E733;
	Mon, 10 Aug 2026 09:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aNteT2hs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93E6E10E1E9;
 Mon, 10 Aug 2026 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786352434; x=1817888434;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=aBla1GdjrZzE2U81Np1weJRn78Yirl09PISBrS8Wfjk=;
 b=aNteT2hsvE7GmjyQO+oQqtnnSQs93vAIJEAgIRq+Qd0JYo3jAxWn7S4U
 +7qEWhMkS21OD3pAI4TfXtydk5WGySOIQ55MgW5WaNn8AaKxJoPoqbVm2
 pt37Maxzrq0IT2xqk3kSj4U3lyoGCyqrnVewSTVlt+d9Fl9DnWRR6qfX6
 rjH5HqbjZL5r1VcQAbkls/+HD+HgG65UwrlNf6zUKLiotaN2PfObUnosE
 hpmLt65jfpXAo2vB1LRfrV4F6V6nFTnNwWd/lGrZdfBUPfIyqtDHzX6N8
 GcK8lzreH5c82q5P7jvh3VgErpMKR/V/qtUtp0lm69hpAXX/vTlCP/6s4 g==;
X-CSE-ConnectionGUID: 94885zmtQ9OeFcwZ8JmzFQ==
X-CSE-MsgGUID: Vm3ZpJ3IShKa13wh0gr6vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98011378"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="98011378"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 02:00:33 -0700
X-CSE-ConnectionGUID: 1eooUKPrQXSqNF6iyA5v6Q==
X-CSE-MsgGUID: Ot0FgtJ9SUanv3Sz08oEaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="259125323"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.103])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 02:00:22 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Igor Paunovic <royalnet026@gmail.com>, dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Imre Deak <imre.deak@intel.com>, Ankit
 Nautiyal <ankit.k.nautiyal@intel.com>, Igor Paunovic
 <royalnet026@gmail.com>
Subject: Re: [PATCH 1/5] drm/dp: Add drm_dp_hdr_metadata_infoframe_sdp_pack()
In-Reply-To: <20260808095749.9428-2-royalnet026@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260808095749.9428-1-royalnet026@gmail.com>
 <20260808095749.9428-2-royalnet026@gmail.com>
Date: Mon, 10 Aug 2026 12:00:20 +0300
Message-ID: <d128b937ee3ca1987d2bd543f92cbabab84ea440@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 08 Aug 2026, Igor Paunovic <royalnet026@gmail.com> wrote:
> i915 packs HDR static metadata into an HDR Metadata InfoFrame SDP
> (DP 1.4a spec, Table 2-100 and Table 2-101) with a driver-private
> helper, intel_dp_hdr_metadata_infoframe_sdp_pack(). Nothing in it is
> i915 specific: it converts a generic struct hdmi_drm_infoframe into a
> generic struct dp_sdp.
>
> Move it to drm_dp_helper.c as drm_dp_hdr_metadata_infoframe_sdp_pack(),
> next to drm_dp_vsc_sdp_pack(), and convert i915 to the new helper. The
> Synopsys DesignWare DisplayPort bridge driver (dw-dp) needs to send the
> same SDP to support HDR and should not have to duplicate the packing
> code.
>
> The helper takes a struct drm_device pointer in place of the i915
> display pointer for its two debug messages, and an i915-specific
> comment about GEN11+ GMP register sizes is dropped. No functional
> change.
>
> Signed-off-by: Igor Paunovic <royalnet026@gmail.com>

'git show --color-moved' says it's fine. ;)

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via drm-misc.

> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 88 +++++++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c | 84 +----------------------
>  include/drm/display/drm_dp_helper.h     |  4 ++
>  3 files changed, 95 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index 9c31e14cc413..7b3b079403c4 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -25,6 +25,7 @@
>  #include <linux/dynamic_debug.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/hdmi.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/iopoll.h>
> @@ -3672,6 +3673,93 @@ ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vs=
c_sdp *vsc,
>  }
>  EXPORT_SYMBOL(drm_dp_vsc_sdp_pack);
>=20=20
> +/**
> + * drm_dp_hdr_metadata_infoframe_sdp_pack() - pack HDR Metadata InfoFram=
e SDP
> + * @dev: DRM device
> + * @drm_infoframe: HDMI DRM infoframe carrying the HDR static metadata
> + * @sdp: valid handle to the generic dp_sdp which will be packed
> + * @size: valid size of the passed sdp handle
> + *
> + * Pack a CTA-861 Dynamic Range and Mastering infoframe into an HDR
> + * Metadata InfoFrame SDP, as defined in DP 1.4a spec, Table 2-100 and
> + * Table 2-101.
> + *
> + * Returns: length of sdp on success and error code on failure
> + */
> +ssize_t drm_dp_hdr_metadata_infoframe_sdp_pack(struct drm_device *dev,
> +					       const struct hdmi_drm_infoframe *drm_infoframe,
> +					       struct dp_sdp *sdp,
> +					       size_t size)
> +{
> +	size_t length =3D sizeof(struct dp_sdp);
> +	const int infoframe_size =3D HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFO=
FRAME_SIZE;
> +	unsigned char buf[HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE];
> +	ssize_t len;
> +
> +	if (size < length)
> +		return -ENOSPC;
> +
> +	memset(sdp, 0, size);
> +
> +	len =3D hdmi_drm_infoframe_pack_only(drm_infoframe, buf, sizeof(buf));
> +	if (len < 0) {
> +		drm_dbg_kms(dev,
> +			    "buffer size is smaller than hdr metadata infoframe\n");
> +		return -ENOSPC;
> +	}
> +
> +	if (len !=3D infoframe_size) {
> +		drm_dbg_kms(dev, "wrong static hdr metadata size\n");
> +		return -ENOSPC;
> +	}
> +
> +	/*
> +	 * Set up the infoframe sdp packet for HDR static metadata.
> +	 * Prepare VSC Header for SU as per DP 1.4a spec,
> +	 * Table 2-100 and Table 2-101
> +	 */
> +
> +	/* Secondary-Data Packet ID, 00h for non-Audio INFOFRAME */
> +	sdp->sdp_header.HB0 =3D 0;
> +	/*
> +	 * Packet Type 80h + Non-audio INFOFRAME Type value
> +	 * HDMI_INFOFRAME_TYPE_DRM: 0x87
> +	 * - 80h + Non-audio INFOFRAME Type value
> +	 * - InfoFrame Type: 0x07
> +	 *    [CTA-861-G Table-42 Dynamic Range and Mastering InfoFrame]
> +	 */
> +	sdp->sdp_header.HB1 =3D drm_infoframe->type;
> +	/*
> +	 * Least Significant Eight Bits of (Data Byte Count =E2=80=93 1)
> +	 * infoframe_size - 1
> +	 */
> +	sdp->sdp_header.HB2 =3D 0x1D;
> +	/* INFOFRAME SDP Version Number */
> +	sdp->sdp_header.HB3 =3D (0x13 << 2);
> +	/* CTA Header Byte 2 (INFOFRAME Version Number) */
> +	sdp->db[0] =3D drm_infoframe->version;
> +	/* CTA Header Byte 3 (Length of INFOFRAME): HDMI_DRM_INFOFRAME_SIZE */
> +	sdp->db[1] =3D drm_infoframe->length;
> +	/*
> +	 * Copy HDMI_DRM_INFOFRAME_SIZE size from a buffer after
> +	 * HDMI_INFOFRAME_HEADER_SIZE
> +	 */
> +	BUILD_BUG_ON(sizeof(sdp->db) < HDMI_DRM_INFOFRAME_SIZE + 2);
> +	memcpy(&sdp->db[2], &buf[HDMI_INFOFRAME_HEADER_SIZE],
> +	       HDMI_DRM_INFOFRAME_SIZE);
> +
> +	/*
> +	 * Size of DP infoframe sdp packet for HDR static metadata consists of
> +	 * - DP SDP Header(struct dp_sdp_header): 4 bytes
> +	 * - Two Data Blocks: 2 bytes
> +	 *    CTA Header Byte2 (INFOFRAME Version Number)
> +	 *    CTA Header Byte3 (Length of INFOFRAME)
> +	 * - HDMI_DRM_INFOFRAME_SIZE: 26 bytes
> +	 */
> +	return sizeof(struct dp_sdp_header) + 2 + HDMI_DRM_INFOFRAME_SIZE;
> +}
> +EXPORT_SYMBOL(drm_dp_hdr_metadata_infoframe_sdp_pack);
> +
>  /**
>   * drm_dp_get_pcon_max_frl_bw() - maximum frl supported by PCON
>   * @dpcd: DisplayPort configuration data
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 6e3fa6662cbe..093a3b7961f7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5157,84 +5157,6 @@ static ssize_t intel_dp_as_sdp_pack(const struct d=
rm_dp_as_sdp *as_sdp,
>  	return length;
>  }
>=20=20
> -static ssize_t
> -intel_dp_hdr_metadata_infoframe_sdp_pack(struct intel_display *display,
> -					 const struct hdmi_drm_infoframe *drm_infoframe,
> -					 struct dp_sdp *sdp,
> -					 size_t size)
> -{
> -	size_t length =3D sizeof(struct dp_sdp);
> -	const int infoframe_size =3D HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFO=
FRAME_SIZE;
> -	unsigned char buf[HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE];
> -	ssize_t len;
> -
> -	if (size < length)
> -		return -ENOSPC;
> -
> -	memset(sdp, 0, size);
> -
> -	len =3D hdmi_drm_infoframe_pack_only(drm_infoframe, buf, sizeof(buf));
> -	if (len < 0) {
> -		drm_dbg_kms(display->drm,
> -			    "buffer size is smaller than hdr metadata infoframe\n");
> -		return -ENOSPC;
> -	}
> -
> -	if (len !=3D infoframe_size) {
> -		drm_dbg_kms(display->drm, "wrong static hdr metadata size\n");
> -		return -ENOSPC;
> -	}
> -
> -	/*
> -	 * Set up the infoframe sdp packet for HDR static metadata.
> -	 * Prepare VSC Header for SU as per DP 1.4a spec,
> -	 * Table 2-100 and Table 2-101
> -	 */
> -
> -	/* Secondary-Data Packet ID, 00h for non-Audio INFOFRAME */
> -	sdp->sdp_header.HB0 =3D 0;
> -	/*
> -	 * Packet Type 80h + Non-audio INFOFRAME Type value
> -	 * HDMI_INFOFRAME_TYPE_DRM: 0x87
> -	 * - 80h + Non-audio INFOFRAME Type value
> -	 * - InfoFrame Type: 0x07
> -	 *    [CTA-861-G Table-42 Dynamic Range and Mastering InfoFrame]
> -	 */
> -	sdp->sdp_header.HB1 =3D drm_infoframe->type;
> -	/*
> -	 * Least Significant Eight Bits of (Data Byte Count =E2=80=93 1)
> -	 * infoframe_size - 1
> -	 */
> -	sdp->sdp_header.HB2 =3D 0x1D;
> -	/* INFOFRAME SDP Version Number */
> -	sdp->sdp_header.HB3 =3D (0x13 << 2);
> -	/* CTA Header Byte 2 (INFOFRAME Version Number) */
> -	sdp->db[0] =3D drm_infoframe->version;
> -	/* CTA Header Byte 3 (Length of INFOFRAME): HDMI_DRM_INFOFRAME_SIZE */
> -	sdp->db[1] =3D drm_infoframe->length;
> -	/*
> -	 * Copy HDMI_DRM_INFOFRAME_SIZE size from a buffer after
> -	 * HDMI_INFOFRAME_HEADER_SIZE
> -	 */
> -	BUILD_BUG_ON(sizeof(sdp->db) < HDMI_DRM_INFOFRAME_SIZE + 2);
> -	memcpy(&sdp->db[2], &buf[HDMI_INFOFRAME_HEADER_SIZE],
> -	       HDMI_DRM_INFOFRAME_SIZE);
> -
> -	/*
> -	 * Size of DP infoframe sdp packet for HDR static metadata consists of
> -	 * - DP SDP Header(struct dp_sdp_header): 4 bytes
> -	 * - Two Data Blocks: 2 bytes
> -	 *    CTA Header Byte2 (INFOFRAME Version Number)
> -	 *    CTA Header Byte3 (Length of INFOFRAME)
> -	 * - HDMI_DRM_INFOFRAME_SIZE: 26 bytes
> -	 *
> -	 * Prior to GEN11's GMP register size is identical to DP HDR static met=
adata
> -	 * infoframe size. But GEN11+ has larger than that size, write_infoframe
> -	 * will pad rest of the size.
> -	 */
> -	return sizeof(struct dp_sdp_header) + 2 + HDMI_DRM_INFOFRAME_SIZE;
> -}
> -
>  static void intel_write_dp_sdp(struct intel_encoder *encoder,
>  			       const struct intel_crtc_state *crtc_state,
>  			       unsigned int type)
> @@ -5253,9 +5175,9 @@ static void intel_write_dp_sdp(struct intel_encoder=
 *encoder,
>  		len =3D drm_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp);
>  		break;
>  	case HDMI_PACKET_TYPE_GAMUT_METADATA:
> -		len =3D intel_dp_hdr_metadata_infoframe_sdp_pack(display,
> -							       &crtc_state->infoframes.drm.drm,
> -							       &sdp, sizeof(sdp));
> +		len =3D drm_dp_hdr_metadata_infoframe_sdp_pack(display->drm,
> +							     &crtc_state->infoframes.drm.drm,
> +							     &sdp, sizeof(sdp));
>  		break;
>  	case DP_SDP_ADAPTIVE_SYNC:
>  		len =3D intel_dp_as_sdp_pack(&crtc_state->infoframes.as_sdp, &sdp,
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/dr=
m_dp_helper.h
> index ab16c1be3900..c158628f0d38 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -32,6 +32,7 @@
>  struct drm_device;
>  struct drm_dp_aux;
>  struct drm_panel;
> +struct hdmi_drm_infoframe;
>=20=20
>  bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  			  int lane_count);
> @@ -1029,6 +1030,9 @@ int drm_dp_bw_channel_coding_efficiency(bool is_uhb=
r);
>  int drm_dp_max_dprx_data_rate(int max_link_rate, int max_lanes);
>=20=20
>  ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc, struct dp_=
sdp *sdp);
> +ssize_t drm_dp_hdr_metadata_infoframe_sdp_pack(struct drm_device *dev,
> +					       const struct hdmi_drm_infoframe *drm_infoframe,
> +					       struct dp_sdp *sdp, size_t size);
>  int drm_dp_link_symbol_cycles(int lane_count, int pixels, int dsc_slice_=
count,
>  			      int bpp_x16, int symbol_size, bool is_mst);

--=20
Jani Nikula, Intel
