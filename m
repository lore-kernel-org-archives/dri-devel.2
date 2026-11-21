Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31E606A33F
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JhYs+k4/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2075410E6D7;
	Sat, 21 Nov 2026 01:29:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F64110E6D7;
 Sat, 21 Nov 2026 01:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795224545; x=1826760545;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ir7RR7TU4SnIvahRgW65oHo9GJCm2molH6VVbIzmibM=;
 b=JhYs+k4/g/W2TFU6sZ9PcESXC8/+HdV0bNLYHfo7nnKLUIAIQTmnqifa
 YGKzvUjmV9lbpO0qC0fbB2JN3MFyyNnp2MHKFLfI7FERhHnrENYbmkiPQ
 HKRmLeuT4c//baOxrE4shCwEHKmozVEb9G2AMJg2sykrbM01iyhVqyfJs
 UJHbACNO/Uuv89i/Nli9gK4V8piIVVwdM6DdMvQHbrqRGsfI99+rRx+wB
 uSH4+y645ts0j/DJa9f6Pt5cCxfokLbs6x5k+W+T9BXDgNGUMwKeap+oT
 IMzyuNlwZhdlHzPCSbSH2uK+g6U3HQtB5L3oV9gRm4oE16Ty6QT4+ZAXV A==;
X-CSE-ConnectionGUID: 8TpLWShUTQ+TdkQy1wOVrQ==
X-CSE-MsgGUID: CRTVnSUlRWGulItD0XG+xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4010628"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4010628"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:29:04 -0800
X-CSE-ConnectionGUID: zBbPs4VgR6K754MgDILDqQ==
X-CSE-MsgGUID: y8MAlmp0R3uCFBuA4kjhew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="10774454"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.66])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:29:01 -0800
Date: Sat, 21 Nov 2026 03:28:57 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Yitian Shao <fighters390@qq.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@intel.com, sebastian.wick@redhat.com,
 uma.shankar@intel.com, suraj.kandpal@intel.com
Subject: Re: [PATCH v3 4/4] drm/i915/dp: Prefer SDP over DPCD for HDR content
 luminance
Message-ID: <awDz2WfzlvnUSd9q@intel.com>
References: <20261121005409.17626-1-fighters390@qq.com>
 <tencent_10977788255152703A88096844DFF3EF9D06@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_10977788255152703A88096844DFF3EF9D06@qq.com>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 08:54:09AM +0800, Yitian Shao wrote:
> intel_dp_aux_write_content_luminance() skips the DPCD write when the
> encoder cannot send a gamut metadata SDP. That is backwards: the DPCD
> register is exactly what the AUX HDR interface uses on those platforms,
> while the SDP takes precedence where it is available.
> 
> Invert the check.
> 
> Signed-off-by: Yitian Shao <fighters390@qq.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 8c7fd99..92516f3 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -250,7 +250,11 @@ intel_dp_aux_write_content_luminance(struct intel_connector *connector,
>  	int ret;
>  	u8 buf[4];
>  
> -	if (!intel_dp_has_gamut_metadata_dip(connector->encoder))
> +	/*
> +	 * When the metadata is sent as a gamut metadata SDP it takes
> +	 * precedence over the DPCD based content luminance.
> +	 */
> +	if (intel_dp_has_gamut_metadata_dip(connector->encoder))

If we want to check something here then I think it would have to be the
same 'supports_sdp_colorimetry && intel_dp_has_gamut_metadata_dip()'
check we do when setting the INTEL_EDP_HDR_TCON_SDP_OVERRIDE_AUX bit.
That is the bit that tells the tcon which source of information
to use.

The other option is to check nothing and always write the value.
INTEL_EDP_HDR_TCON_SDP_OVERRIDE_AUX will then make the tcon ignore
the written value if it supports the SDP override.

>  		return;
>  
>  	buf[0] = hdr_metadata->hdmi_metadata_type1.max_cll & 0xFF;
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
