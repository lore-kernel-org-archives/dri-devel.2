Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9D606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ErUJsxrS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B192810E43B;
	Tue, 27 Oct 2026 15:34:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E938510E43B;
 Tue, 27 Oct 2026 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793115237; x=1824651237;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=LbqxRN6z9nOk9o6pUwV9DRw24hqSBOdMEOaSuQUUDAo=;
 b=ErUJsxrSV6cpt7w/yUgiZu62ogolEATLJIY+B0DswesitTutjLDB8rpl
 vaMXc8hQmNNf1GErN26CfGfO9tcH5IuBc8m4zyxT6jYPn1txdT0O6odQ9
 Ec7015j7vtFg4kG7UOfYI6LT9ErK5lzeEFsVom1ntcCFEK0imKjk2cFLR
 cyglg14fSXvbWXYqT/kycf/Zt1a9fyY6+6V2nRLiYNEkIcQSkp8BfqHhh
 XAahBhb2ykvz6k4mN0Kx432+Nmtq3Qe2043ETZevjDmI6nJa++iINfNo9
 S5yabNbA9DLsNkEqX3M0wdDQZKbqlJkUEcgOAibzZNePWpBsREA9Y3bhL Q==;
X-CSE-ConnectionGUID: i/y8To1KSay53RUQUtTUfg==
X-CSE-MsgGUID: 73iz+32XTeOgZHQkMAIoMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1693073"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1693073"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:33:57 -0700
X-CSE-ConnectionGUID: sloGfLXQQg+gjbnvpeOoZA==
X-CSE-MsgGUID: pNg+vCLHTpykGhXZm1eSjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4963204"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.247])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:33:55 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Animesh Manna <animesh.manna@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, suraj.kandpal@intel.com, Animesh Manna
 <animesh.manna@intel.com>
Subject: Re: [PATCH v7 01/20] drm/i915/alpm: Program zero-based LFPS half
 cycle duration
In-Reply-To: <20261026054001.799894-2-animesh.manna@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-2-animesh.manna@intel.com>
Date: Tue, 27 Oct 2026 17:33:51 +0200
Message-ID: <899b4a9b4406fe7bf1287ea8e6adba7ef60d31af@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026, Animesh Manna <animesh.manna@intel.com> wrote:
> The LFPS Half Cycle Duration field, as well as the First and Last LFPS
> Half Cycle Duration fields, in PORT_ALPM_LFPS_CTL are zero-based: per
> Bspec the value programmed must be N_Symbol - 1. The number of symbols
> was programmed directly, making each half cycle one symbol clock too
> long.
>
> Subtract one in the PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION,
> PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION and
> PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION field macros so the
> programmed value matches the zero-based field encoding.
>
> Since the fields now encode 1 to 32 symbols, update the bounds check
> in _lnl_compute_aux_less_alpm_params() to accept a half cycle of 32
> symbols and reject 0, which cannot be encoded.
>
> v2: Adjust half cycle bounds check for zero-based encoding. [sashiko]
>
> Bspec: 71632
> Cc: Jouni H=C3=B6gander <jouni.hogander@intel.com>
> Signed-off-by: Animesh Manna <animesh.manna@intel.com>
> Reviewed-by: Jouni H=C3=B6gander <jouni.hogander@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_alpm.c     |  3 ++-
>  drivers/gpu/drm/i915/display/intel_psr_regs.h | 12 +++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index f54b29e193ee..8542bd9c9666 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -134,7 +134,8 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *in=
tel_dp,
>=20=20
>  	if (aux_less_wake_lines > ALPM_CTL_AUX_LESS_WAKE_TIME_MASK ||
>  	    silence_period > PORT_ALPM_CTL_SILENCE_PERIOD_MASK ||
> -	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_=
MASK)
> +	    lfps_half_cycle < 1 ||
> +	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_=
MASK + 1)
>  		return false;
>=20=20
>  	if (display->params.psr_safest_params)
> diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/=
drm/i915/display/intel_psr_regs.h
> index a57bc111290d..78a05387eab5 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
> +++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
> @@ -335,11 +335,17 @@
>  #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK		REG_GENMASK(27, 24)
>  #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN		7
>  #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(val)		REG_FIELD_PREP(PORT_A=
LPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK, (val) - PORT_ALPM_LFPS_CTL_LFPS_CYCLE_C=
OUNT_MIN)
> +/*
> + * The LFPS half cycle duration fields (including the first and last half
> + * cycle) are zero-based, i.e. the value programmed is N_Symbol - 1.
> + *
> + * Bspec: 71632
> + */

Please let's not normalize adding bspec references to code comments.

>  #define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(20=
, 16)
> -#define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP=
(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, val)
> +#define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP=
(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
>  #define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENM=
ASK(12, 8)
> -#define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIEL=
D_PREP(PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK, val)
> +#define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIEL=
D_PREP(PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
>  #define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMA=
SK(4, 0)
> -#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD=
_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, val)
> +#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD=
_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
>=20=20
>  #endif /* __INTEL_PSR_REGS_H__ */

--=20
Jani Nikula, Intel
