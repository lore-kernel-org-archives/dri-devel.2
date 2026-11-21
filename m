Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1191606A330
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zn5b8h13
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A53B10E8EA;
	Sat, 21 Nov 2026 01:14:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426CE10E79F;
 Sat, 21 Nov 2026 01:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795223640; x=1826759640;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Fb5EWhvx48l1xFeHw44InO+njdx2xad3U0Y/886kfOQ=;
 b=Zn5b8h13oTKj7nZmBewp/Q7+tGFENvVhUX1ts/kHkDT7Fv7fBqP6WLVW
 gr1huUdSMfT6HhLdKTmEouOG9wN09AREAq88fgtoiZ1CA3Qwk+QRxl3bz
 mZCensQA52HgWBk0fe84LZsU7BHH3NzF/E1iW2OukmXDYvGopYFmanhWy
 xL/ppfAO6irRpZ4Oyz9qTMnDXVpJioNG2xShB4Hii/WeIN8vc71dBL6Sg
 w+PyqwcXU6f1NfDIdYhZHA/v1hwi5c6pUSBFO9N3B6Uo1W6VHXHSgUC8Z
 Lwd+BEIeqiTe4TM6SoTrIaGmai4Y0IeoFwzDgUt6JMcBGK2ZYqj6CNOv6 g==;
X-CSE-ConnectionGUID: 3YqH0IFYRtaW0ROS3Vwlog==
X-CSE-MsgGUID: wp7X9KUUSZC7n27gOIhycg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3957619"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="3957619"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:13:58 -0800
X-CSE-ConnectionGUID: dT0R7lE/RISS+z7vH5nwqg==
X-CSE-MsgGUID: WkQHQSt8TEigwEyiNNZ3Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="10840897"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.66])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:13:55 -0800
Date: Sat, 21 Nov 2026 03:13:51 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Yitian Shao <fighters390@qq.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@intel.com, sebastian.wick@redhat.com,
 uma.shankar@intel.com, suraj.kandpal@intel.com
Subject: Re: [PATCH v3 1/4] drm/i915/dp: Drop LSPCON check from
 intel_dp_has_gamut_metadata_dip()
Message-ID: <awDwT7DapivUsFJf@intel.com>
References: <20261121005409.17626-1-fighters390@qq.com>
 <tencent_B90E2647114BCF037778DE0C967949C0E908@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_B90E2647114BCF037778DE0C967949C0E908@qq.com>
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

On Sat, Nov 21, 2026 at 08:54:06AM +0800, Yitian Shao wrote:
> intel_dp_has_gamut_metadata_dip() returns false for LSPCON encoders, which
> is not what the function is asking. LSPCON does send the HDR metadata
> infoframe, only through lspcon_write_infoframe() instead of the transcoder
> DIP.

lspcon_write_infoframe() does use the same DIP for this, so this
statement is a bit confusing. I guess we just want to say something
along the lines that the DIP does exist regardless of whether
LSPCON is used or not.

Otherwise this looks good.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> The check only existed to keep intel_dp_add_properties() from attaching
> HDR_OUTPUT_METADATA before intel_lspcon_detect_hdr_capability() has probed
> the hardware. Move that check to intel_dp_add_properties() where the
> attach decision is made.
> 
> Signed-off-by: Yitian Shao <fighters390@qq.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index afd4169..2736a78 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -6672,9 +6672,6 @@ intel_dp_has_gamut_metadata_dip(struct intel_encoder *encoder)
>  	struct intel_display *display = to_intel_display(encoder);
>  	enum port port = encoder->port;
>  
> -	if (intel_bios_encoder_is_lspcon(encoder->devdata))
> -		return false;
> -
>  	if (DISPLAY_VER(display) >= 11)
>  		return true;
>  
> @@ -6715,7 +6712,9 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
>  		intel_attach_dp_colorspace_property(&connector->base);
>  	}
>  
> -	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
> +	/* LSPCON attaches the property itself in intel_dp_connector_register() */
> +	if (!intel_bios_encoder_is_lspcon(dp_to_dig_port(intel_dp)->base.devdata) &&
> +	    intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
>  		drm_connector_attach_hdr_output_metadata_property(&connector->base);
>  
>  	if (HAS_VRR(display))
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
