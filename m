Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA2606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctLKGBLv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A9610E83F;
	Mon, 26 Oct 2026 07:06:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D66F10E2B7;
 Mon, 26 Oct 2026 07:06:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2220C600CB;
 Mon, 26 Oct 2026 07:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999E41F01825;
 Mon, 26 Oct 2026 07:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792998360;
 bh=hcIWQK7DO7s3dtiLs8FopN4oSCHtHx18SXESLQ4p0Qs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ctLKGBLv8OZf3YJdOxaZ2Ux/B6NHR0iCVdV82wGSRs9/AWdruIHnx7AwkScAEnLGx
 iXPopvUivGSMvHcnjuvOAku8qItncmjcvdm8yHrXzno+QaMlsnRYjQMlpds5/6JTCN
 zl7jOzOxg3Z2bBOnQBuGYDbRtyCwwAzOI25k40pRXaBEUbkernizH0S2E/SDyNqOMm
 HQ8rznp8OTART3POLRAFf1aUEZka27UncEnpHVHOVfqusRA7XItvxLq4aUE0qTGykK
 qAxqdIlbYUfh2u+tz7SMolwbCRHzYlgWqnfDRCepbNQk3nvN8kz2+GXqNLBU0lN1bt
 BenzdxZ3j5WIA==
Message-ID: <sashiko-outbox-184650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/20] drm/i915/alpm: Half LFPS cycle calculation
To: "Animesh Manna" <animesh.manna@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026054001.799894-11-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-11-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:06:00 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/i915/alpm: uninitialized variables in get_lfps_cycle_time()
--

commit 5c47cf246b743bb16ee9903923cc22a473083617
Author: Animesh Manna <animesh.manna@intel.com>

drm/i915/alpm: Half LFPS cycle calculation

This patch updates the LFPS cycle period minimum and maximum calculation for
DP2.1 ALPM by splitting it into HAS_LT_PHY() and non-LT-PHY helpers that ch=
eck
whether the output type is eDP.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 2bf2ca9564391..b6de938990ddb 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -81,24 +81,49 @@ static int get_silence_period_symbols(const struct in=
tel_crtc_state *crtc_state)
>  		1000 / 1000;
>  }
> =20
> -static void get_lfps_cycle_min_max_time(const struct intel_crtc_state *c=
rtc_state,
> -					int *min, int *max)
> +static void lnl_get_lfps_period_min_max_time(const struct intel_crtc_sta=
te *crtc_state,
> +					     int *min, int *max)
>  {
> -	if (crtc_state->port_clock < 540000) {
> -		*min =3D 65 * LFPS_CYCLE_COUNT;
> -		*max =3D 75 * LFPS_CYCLE_COUNT;
> -	} else {
> +	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
> +		if (crtc_state->port_clock < 540000) {
> +			*min =3D 65 * LFPS_CYCLE_COUNT;
> +			*max =3D 75 * LFPS_CYCLE_COUNT;
> +		} else {
> +			*min =3D 140;
> +			*max =3D 800;
> +		}
> +	}
> +}
> +
> +static void lt_get_lfps_period_min_max_time(const struct intel_crtc_stat=
e *crtc_state,
> +					    int *min, int *max)
> +{
> +	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
>  		*min =3D 140;
>  		*max =3D 800;
> +	} else {
> +		*min =3D 320;
> +		*max =3D 1600;
>  	}
>  }
> =20
> +static void get_lfps_period_min_max_time(const struct intel_crtc_state *=
crtc_state,
> +					int *min, int *max)
> +{
> +	struct intel_display *display =3D to_intel_display(crtc_state);
> +
> +	if (HAS_LT_PHY(display))
> +		lt_get_lfps_period_min_max_time(crtc_state, min, max);
> +	else
> +		lnl_get_lfps_period_min_max_time(crtc_state, min, max);
> +}
> +
>  static int get_lfps_cycle_time(const struct intel_crtc_state *crtc_state)
>  {
>  	int tlfps_cycle_min, tlfps_cycle_max;
> =20
> -	get_lfps_cycle_min_max_time(crtc_state, &tlfps_cycle_min,
> -				    &tlfps_cycle_max);
> +	get_lfps_period_min_max_time(crtc_state, &tlfps_cycle_min,
> +				     &tlfps_cycle_max);
> =20
>  	return tlfps_cycle_min +  (tlfps_cycle_max - tlfps_cycle_min) / 2;
>  }

[Severity: High]
Can tlfps_cycle_min and tlfps_cycle_max be used uninitialized in
get_lfps_cycle_time()?

In get_lfps_cycle_time(), tlfps_cycle_min and tlfps_cycle_max are declared
without initialization and passed to get_lfps_period_min_max_time(). When
HAS_LT_PHY(display) is false, get_lfps_period_min_max_time() calls
lnl_get_lfps_period_min_max_time(), which only assigns *min and *max when
intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP) is true.

For non-eDP outputs on !HAS_LT_PHY(display) platforms, *min and *max are
never written before get_lfps_cycle_time() computes:

	return tlfps_cycle_min +  (tlfps_cycle_max - tlfps_cycle_min) / 2;

In particular, get_establishment_period() calls get_lfps_cycle_time() when
lttpr_count > 0, which only occurs in the !intel_crtc_has_type(crtc_state,
INTEL_OUTPUT_EDP) branch:

drivers/gpu/drm/i915/display/intel_alpm.c:get_establishment_period() {
	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
		num_ml_phy_lock =3D 7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1;
	} else {
		num_ml_phy_lock =3D 7;

		lttpr_count =3D drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
		...
	}
	...
	if (lttpr_count > 0) {
		/* tlw and tcs values are taken from DP2.1 spec */
		int tlw =3D 13000;
		int tcs =3D 10000;
		int tlfps_period =3D get_lfps_cycle_time(crtc_state);
		...
	}
}

Would this leave tlfps_cycle_min and tlfps_cycle_max uninitialized at
runtime for non-eDP DP outputs and trigger -Wmaybe-uninitialized or
-Wsometimes-uninitialized warnings during the build?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026054001.7998=
94-1-animesh.manna@intel.com?part=3D10
