Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A0606A693
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N/aSqzbS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5F910E0D0;
	Sat, 21 Nov 2026 01:22:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F345710E0D0;
 Sat, 21 Nov 2026 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795224120; x=1826760120;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3YWKfgjKH6FFVUnZtlfo6VCsQ5rIotK4MM1MsQL+pZM=;
 b=N/aSqzbSPfEyo5JccPJJGjqVZuaDXIOWowqkqvPB335EnMfH0B+8X6ST
 WyJHccP1tQL9yq24bdMGTVFuEwVXzEccxMu2Wr36fCd+CqDddSVskK2M0
 gGAxn4pDbOxlKAZyU+B36cO8JG6v3RuP0OCDwgX9YrGxaxJ3dj6NpWb2g
 e7Hacn+ynY9bnEM3n84GY29ukZQXyi5P76riRWWf5qscRe9Av3APq5JYh
 TFx/ea/06YTzxeuqoX8EB0tUiZF+mAw2aOID5k+E85cNWycMeskfyqkl5
 /rgBW0cUXG9nwgi7ZXjYhslBHj35n7tVecUkj2lQI+K2W4suzqh8P2WWw g==;
X-CSE-ConnectionGUID: 7IFgu/lDQCqDhBmJJSM2sg==
X-CSE-MsgGUID: 4f6ypyVDR9qxwDwTtoX+4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3959919"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="3959919"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:22:00 -0800
X-CSE-ConnectionGUID: y1o4wLL9TKurf5tvuuQoqw==
X-CSE-MsgGUID: dJm0xUBFT1WVBkQeUM7Vow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="10735723"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.66])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:21:57 -0800
Date: Sat, 21 Nov 2026 03:21:54 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Yitian Shao <fighters390@qq.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@intel.com, sebastian.wick@redhat.com,
 uma.shankar@intel.com, suraj.kandpal@intel.com
Subject: Re: [PATCH v3 3/4] drm/i915/display: Check gamut metadata DIP
 support in LSPCON HDR detection
Message-ID: <awDyMsr6IOZoZHG_@intel.com>
References: <20261121005409.17626-1-fighters390@qq.com>
 <tencent_D44B8524BAF46993C808B9E7EEBB0AEF4C07@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_D44B8524BAF46993C808B9E7EEBB0AEF4C07@qq.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 08:54:08AM +0800, Yitian Shao wrote:
> intel_lspcon_detect_hdr_capability() asks the LSPCON whether it can do HDR,
> but not whether the port can actually transmit the gamut metadata DIP. If
> an LSPCON is hooked up to a port without that capability we would advertise
> HDR support that cannot be delivered.
> 
> Refuse to claim HDR support in that case.
> 
> Signed-off-by: Yitian Shao <fighters390@qq.com>
> ---
>  drivers/gpu/drm/i915/display/intel_lspcon.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
> index 9ceabbc..797137d 100644
> --- a/drivers/gpu/drm/i915/display/intel_lspcon.c
> +++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
> @@ -137,6 +137,11 @@ bool intel_lspcon_detect_hdr_capability(struct intel_digital_port *dig_port)
>  	u8 hdr_caps;
>  	int ret;
>  
> +	if (!intel_dp_has_gamut_metadata_dip(&dig_port->base)) {
> +		lspcon->hdr_supported = false;

Maybe a bit redundant, but the other code paths also do this so 
I think we do want the redundancy in the name of consistency.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> +		return false;
> +	}
> +
>  	ret = drm_dp_dpcd_read(&intel_dp->aux, get_hdr_status_reg(lspcon),
>  			       &hdr_caps, 1);
>  
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
