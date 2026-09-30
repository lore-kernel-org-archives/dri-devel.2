Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A016CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD8910F233;
	Wed, 30 Sep 2026 08:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JbjJdxQV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0BE10F229;
 Wed, 30 Sep 2026 08:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790755495; x=1822291495;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=aB8Cp4nhgf7pMdLW6i8ghQb1w1f/0/D8MNkDliazAv4=;
 b=JbjJdxQVlZ7af4VExL1DDfkhiTkrzmiYpL9eXfd0aDaYsp537+TKZk6T
 JreZSn6MqlYgPcjxU6Or7PFTU0GlXH51cVGsqAhdJ2xgUghK+4FwZ8x1s
 8tgAphk0nr494vNh37JGoLLpa7b10T59gILa+aUuLkKt6sZ5eflnujLzk
 2qVHm8kp/R+e1aLz2fDcSVa3DV2vGc/hAbvWm790VI4NTOH8EEfXZP/bW
 R2WCgBdprgSLv2xHQA5ovtpI+79sNcXjCSbFLzwrzcoauUZ25y8vVitOX
 Ph3QFrlAwXUHD0KahCrYjtXHyynSkcHouiEz3FnbT4+IRm2GgiZL3unn2 Q==;
X-CSE-ConnectionGUID: BAgFCt9gQJ6Kg1QN/IDbxw==
X-CSE-MsgGUID: xnjgwFPCS8eLKXPYYBwyXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="107873331"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="107873331"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:04:54 -0700
X-CSE-ConnectionGUID: Cu/v+AVgQF+x1mViGCxdEQ==
X-CSE-MsgGUID: dg7Wz5AVSvSpELsP3mYYzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="275761811"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.107])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:04:51 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Animesh Manna <animesh.manna@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, suraj.kandpal@intel.com, Animesh Manna
 <animesh.manna@intel.com>
Subject: Re: [PATCH v6 02/18] drm/i915/alpm: Move alpm sink capability
 readout into a separate function
In-Reply-To: <20260915180449.277933-3-animesh.manna@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-3-animesh.manna@intel.com>
Date: Wed, 30 Sep 2026 11:04:49 +0300
Message-ID: <2ed6b4ccefd2d302433fb990401b0d62efa75c84@intel.com>
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
> Abstract ALPM DPCD initialization into its own function.
>
> v2:
> - Improve commit description. [Suraj, Jouni]
>
> Cc: Jouni H=C3=B6gander <jouni.hogander@intel.com>
> Signed-off-by: Animesh Manna <animesh.manna@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_alpm.c | 11 +++++++++++
>  drivers/gpu/drm/i915/display/intel_alpm.h |  1 +
>  drivers/gpu/drm/i915/display/intel_dp.c   |  6 +-----
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 10943539bc7c..a6743fe62d48 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -43,6 +43,17 @@ bool intel_alpm_is_alpm_aux_less(struct intel_dp *inte=
l_dp,
>  		(crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp));
>  }
>=20=20
> +bool intel_alpm_init_dpcd(struct intel_dp *intel_dp)
> +{
> +	u8 dpcd;
> +
> +	if (drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CAP, &dpcd) =
< 0)
> +		return false;
> +
> +	intel_dp->alpm_dpcd =3D dpcd;
> +	return true;
> +}

Why not propagate the original error instead of flattening to a boolean?
What does boolean true/false mean for a function that's not a predicate
function but "init"?

From a maintenance perspective, the mixing of bool vs. int return values
is a problem because you never know what is being checked for in the
caller side:

	if (!intel_alpm_init_dpcd())

Does that return bool and false means failure? Or does that return int
and false means success?!


BR,
Jani.


> +
>  void intel_alpm_init(struct intel_dp *intel_dp)
>  {
>  	mutex_init(&intel_dp->alpm.lock);
> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/=
i915/display/intel_alpm.h
> index f8f605d94f96..56c3e1482e37 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.h
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.h
> @@ -15,6 +15,7 @@ struct intel_connector;
>  struct intel_atomic_state;
>  struct intel_crtc;
>=20=20
> +bool intel_alpm_init_dpcd(struct intel_dp *intel_dp);
>  void intel_alpm_init(struct intel_dp *intel_dp);
>  bool intel_alpm_compute_params(struct intel_dp *intel_dp,
>  			       struct intel_crtc_state *crtc_state);
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 0cd5e6b5034c..650c8b39270b 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4783,7 +4783,6 @@ static bool
>  intel_edp_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *c=
onnector)
>  {
>  	struct intel_display *display =3D to_intel_display(intel_dp);
> -	int ret;
>  	u8 dprx;
>=20=20
>  	/* this function is meant to be called only once */
> @@ -4829,10 +4828,7 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp, str=
uct intel_connector *connector
>  	 */
>  	intel_dp_init_source_oui(intel_dp);
>=20=20
> -	/* Read the ALPM DPCD caps */
> -	ret =3D drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CAP,
> -				    &intel_dp->alpm_dpcd);
> -	if (ret < 0)
> +	if (!intel_alpm_init_dpcd(intel_dp))
>  		return false;
>=20=20
>  	/*

--=20
Jani Nikula, Intel
