Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E4C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C026310E303;
	Tue, 15 Sep 2026 18:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E1x3931N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DFB10EC8A;
 Tue, 15 Sep 2026 18:56:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EBF4841E60;
 Tue, 15 Sep 2026 18:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790771F000FF;
 Tue, 15 Sep 2026 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498588;
 bh=ZZ6wwqCnVypjVHnMN9X1VMnDqf5GmhEbde6PNuzkdMk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E1x3931N+zguSWc+30E/6SrDa1y9G44/Z4nm+zELrdGHAeqihsx4URV7AdgiTdsRZ
 fDkvvFtr4I7T4Mq9RPVKhcInCOSzp30TMN+CDar8FdVOB5NejVZ5e+zBoBJadTHHE2
 n/CKF9Znq3zjESgOzMK1O8K3ZznwWIDedAezq3O3jdvcNvPd2nONVICNLFnChumXZu
 /GS1oJ4aTj6xa5vywszQOOWxc+neNuO/Phokbu1FIEfmT7+1EWI4P2ccr91C3+HNG6
 ozM+vP5D/UJaxf7EUNG88V//pEOXyq+nbZrOx56LzAUQrRAEi4ze3/ML27nQnew9OR
 m/wnzHeGeF+Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/18] drm/i915/alpm: Program LTTPR count for DP 2.1
 ALPM
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-13-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-13-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:56:27 +0000
Message-Id: <20260915185628.790771F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/i915/alpm: DP 2.1 ALPM LTTPR logic is unreachable dead code
- [Medium] drm/i915/alpm: Unchecked negative return from drm_dp_lttpr_count=
() causes register corruption
- [Low] drm/i915/alpm: Dead code in lttpr_count error check
- [Low] drm/i915/alpm: Comment contradicts LTTPR revision code check
--

commit a317ca0f7af6803f7b3932311f82447dfda1b648
Author: Animesh Manna <animesh.manna@intel.com>
drm/i915/alpm: Program LTTPR count for DP 2.1 ALPM

This commit programs the total number of LTTPRs for DP 2.1 ALPM before
link training by issuing an AUX write transaction to DP_TOTAL_LTTPR_CNT.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index da653a407e97e..06c1a59aa2c51 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -726,7 +726,7 @@ static void lnl_alpm_configure(struct intel_dp *intel=
_dp,
>  {
>  	struct intel_display *display =3D to_intel_display(intel_dp);
>  	enum transcoder cpu_transcoder =3D crtc_state->cpu_transcoder;
> -	u32 alpm_ctl;
> +	u32 alpm_ctl, alpm_ctl2, lttpr_count;
> =20
[ ... ]
> @@ -762,6 +762,11 @@ static void lnl_alpm_configure(struct intel_dp *inte=
l_dp,
> =20
>  	alpm_ctl |=3D ALPM_CTL_ALPM_ENTRY_CHECK(crtc_state->alpm_state.check_en=
try_lines);
> =20
> +	lttpr_count =3D drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
> +
> +	alpm_ctl2 =3D ALPM_CTL2_NUMBER_OF_LTTPR(lttpr_count);

[Severity: Medium]
Does this assignment to a u32 variable cause error codes to go unhandled?

The function drm_dp_lttpr_count() can return negative error codes like
-ERANGE or -EINVAL on failure. If this happens, assigning it to the unsigned
lttpr_count variable strips the negative sign and results in a large value
being passed into ALPM_CTL2_NUMBER_OF_LTTPR(). This could corrupt the
register programming by injecting invalid bits via REG_FIELD_PREP.

> +
> +	intel_de_write(display, ALPM_CTL2(display, cpu_transcoder), alpm_ctl2);
>  	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
>  	mutex_unlock(&intel_dp->alpm.lock);
>  }
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/driv=
ers/gpu/drm/i915/display/intel_dp_link_training.c
> index cb92cff906146..37c8306a1fa0d 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -2265,6 +2265,25 @@ intel_dp_128b132b_link_train(struct intel_dp *inte=
l_dp,
>  	return passed;
>  }
> =20
> +static void intel_dp_update_lttpr_count(struct intel_dp *intel_dp,
> +					int lttpr_count)
> +{
> +	u8 val;
> +
> +	/*
> +	 * Program only for DP2.1 and return if LTTPR revison is less than 0x20
> +	 * where 0:3 represents minor rev and 4:7 represent major rev
> +	 */

[Severity: Low]
This isn't a bug, but the comment specifies "less than 0x20", while the
code below implements a less than or equal to 0x20 (<=3D 0x20) check.

> +	if (!intel_dp_is_edp(intel_dp) ||
> +	    lttpr_count < 0 ||

[Severity: Low]
Is this lttpr_count < 0 check reachable?

In intel_dp_start_link_train(), the lttpr_count is clamped to 0 on error
before being passed to this function:

	if (lttpr_count < 0)
		/* Still continue with enabling the port and link training. */
		lttpr_count =3D 0;

	intel_dp_prepare_link_train(intel_dp, crtc_state);
	intel_dp_update_lttpr_count(intel_dp, lttpr_count);

> +	    intel_dp->lttpr_common_caps[0] <=3D 0x20)

[Severity: High]
Can this LTTPR programming ever be reached for either DP or eDP configurati=
ons?

For standard DP connections, the function returns immediately because of the
!intel_dp_is_edp(intel_dp) check above.

For eDP connections, intel_dp_init_lttpr_and_dprx_caps() explicitly skips
LTTPR capabilities initialization, leaving intel_dp->lttpr_common_caps[0]
as 0. That causes the function to also return immediately due to this
<=3D 0x20 check, rendering the feature unreachable.

> +		return;
> +
> +	val =3D intel_dp->lttpr_common_caps[DP_PHY_REPEATER_CNT -
> +					  DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
> +	drm_dp_dpcd_writeb(&intel_dp->aux, DP_TOTAL_LTTPR_CNT, val);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D12
