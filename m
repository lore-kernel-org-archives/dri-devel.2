Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59537CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E0310F23B;
	Wed, 30 Sep 2026 08:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eDaDmgYY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D87110E5A5;
 Wed, 30 Sep 2026 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790756224; x=1822292224;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=aOEXaKJAmJS74O6U1Y7qs84BuAJX4TxGsf0cgkMOFCo=;
 b=eDaDmgYYO5Vdt2RJY+ytLWYz5lveeaFJducO0XldQixPH0j4GGjkjvoX
 DvnTb2X7BeaEKhzsZG7ZX8w0GFgOgHDZp2Sx1VFnANR3pugrLwhbYbEse
 FwPfvD0gArzc3qylVvLzRQC+NNSO9SmOZfRCZ83F+p7qyMJO6gTRiayUu
 ktXAL6+iKjIzqZ4rwBnA7aFXTOl3j4f/zoU+DJYBngCqaalzxHe3yTRe4
 h5yMS4yazHRKctKfp/3P8DYYCMRRlEVQyqWmxLXQB6xQ6HtAtWb3rtW79
 mzIIVU0Xn/GZSgF9wSa79eYm1/RUTtX9YhZropIhd10ZNVGm0YrjBNgjg g==;
X-CSE-ConnectionGUID: yp7UuZVBSturhJXOegKLJw==
X-CSE-MsgGUID: j7jdVK1hQT69yhGasMNntw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102163480"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="102163480"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:17:04 -0700
X-CSE-ConnectionGUID: pCEx62D0Tyq5Ox6lp3EEHg==
X-CSE-MsgGUID: gKn672HKQGWzGOhRHJ6geQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="280368873"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.107])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:17:01 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Animesh Manna <animesh.manna@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, suraj.kandpal@intel.com, Animesh Manna
 <animesh.manna@intel.com>
Subject: Re: [PATCH v6 12/18] drm/i915/alpm: Program LTTPR count for DP 2.1
 ALPM
In-Reply-To: <20260915180449.277933-13-animesh.manna@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-13-animesh.manna@intel.com>
Date: Wed, 30 Sep 2026 11:16:59 +0300
Message-ID: <4a87eed400a220652c2da3c478f02b267eaf63f5@intel.com>
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

On Tue, 15 Sep 2026, Animesh Manna <animesh.manna@intel.com> wrote:
> Issue a AUX write transaction to DPCD DP_TOTAL_LTTPR_CNT (0xf000a)
> with total number of LTTPR before link training.
>
> v2: Cosmetic changes. [Suraj]
> v3:
> - Use same encoding format for lttpr_count. [Jouni]
> - Avoid reading alpm_ctl2 register. [Jouni]
>
> Cc: Jouni H=C3=B6gander <jouni.hogander@intel.com>
> Signed-off-by: Animesh Manna <animesh.manna@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_alpm.c     |  7 ++++++-
>  .../drm/i915/display/intel_dp_link_training.c | 21 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index da653a407e97..06c1a59aa2c5 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -726,7 +726,7 @@ static void lnl_alpm_configure(struct intel_dp *intel=
_dp,
>  {
>  	struct intel_display *display =3D to_intel_display(intel_dp);
>  	enum transcoder cpu_transcoder =3D crtc_state->cpu_transcoder;
> -	u32 alpm_ctl;
> +	u32 alpm_ctl, alpm_ctl2, lttpr_count;
>=20=20
>  	if (DISPLAY_VER(display) < 20 || (!intel_psr_needs_alpm(intel_dp, crtc_=
state) &&
>  					  !crtc_state->has_lobf))
> @@ -762,6 +762,11 @@ static void lnl_alpm_configure(struct intel_dp *inte=
l_dp,
>=20=20
>  	alpm_ctl |=3D ALPM_CTL_ALPM_ENTRY_CHECK(crtc_state->alpm_state.check_en=
try_lines);
>=20=20
> +	lttpr_count =3D drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
> +
> +	alpm_ctl2 =3D ALPM_CTL2_NUMBER_OF_LTTPR(lttpr_count);
> +
> +	intel_de_write(display, ALPM_CTL2(display, cpu_transcoder), alpm_ctl2);
>  	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
>  	mutex_unlock(&intel_dp->alpm.lock);
>  }
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/driv=
ers/gpu/drm/i915/display/intel_dp_link_training.c
> index cb92cff90614..37c8306a1fa0 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -2265,6 +2265,25 @@ intel_dp_128b132b_link_train(struct intel_dp *inte=
l_dp,
>  	return passed;
>  }
>=20=20
> +static void intel_dp_update_lttpr_count(struct intel_dp *intel_dp,
> +					int lttpr_count)
> +{
> +	u8 val;
> +
> +	/*
> +	 * Program only for DP2.1 and return if LTTPR revison is less than 0x20
> +	 * where 0:3 represents minor rev and 4:7 represent major rev
> +	 */
> +	if (!intel_dp_is_edp(intel_dp) ||
> +	    lttpr_count < 0 ||
> +	    intel_dp->lttpr_common_caps[0] <=3D 0x20)
> +		return;
> +
> +	val =3D intel_dp->lttpr_common_caps[DP_PHY_REPEATER_CNT -
> +					  DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
> +	drm_dp_dpcd_writeb(&intel_dp->aux, DP_TOTAL_LTTPR_CNT, val);

Please use the modern DPCD accessors throughout the series. See [1].

BR,
Jani.


[1] https://lore.kernel.org/r/cover.1789547331.git.jani.nikula@intel.com

> +}
> +
>  /**
>   * intel_dp_start_link_train - start link training
>   * @state: Atomic state
> @@ -2304,6 +2323,8 @@ void intel_dp_start_link_train(struct intel_atomic_=
state *state,
>=20=20
>  	intel_dp_prepare_link_train(intel_dp, crtc_state);
>=20=20
> +	intel_dp_update_lttpr_count(intel_dp, lttpr_count);
> +
>  	if (intel_dp_is_uhbr(crtc_state))
>  		passed =3D intel_dp_128b132b_link_train(intel_dp, crtc_state, lttpr_co=
unt);
>  	else

--=20
Jani Nikula, Intel
