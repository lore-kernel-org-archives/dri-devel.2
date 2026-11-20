Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CD606A60A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QTTxjt7B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0978E112BD9;
	Fri, 20 Nov 2026 16:41:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FDA112B8B;
 Fri, 20 Nov 2026 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795192906; x=1826728906;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Mt37fmIUELj0xI9G800lQNgzenR8tQzCZwNS3sQls6s=;
 b=QTTxjt7Bn70kAaH3QBpJgl1Dr5vtXilZO7jNDhEPPTNsnghTwJG21lPM
 Et9dKaYxxWbcZnAgbTFgCs5OFqY/hxSqnOFhePgUOQ0whRjL0WesKFWDK
 HFMjRgWT6IVriI9/Ztj/GHfEhq7p+9xsB+vFoC/m9wruUDFB6z55nsmDe
 KPSOMTYIPaMezrXcKoMAS7bcvXebmPXt5gaToaN9jGrYZ3SSu04u6aLXm
 E+DD94s/DNAnqzStkQdOBCoBt0fUI0prcPziYsOj9bk1CGQ8ol0oPN2Ge
 sPXWutwj5HlegjO9qImjR3Z02AoxQE7cPi2pY0T1IsPH1xypbRz04uX+q A==;
X-CSE-ConnectionGUID: 8P90kWWLSHWPQAoKZkkXsA==
X-CSE-MsgGUID: A22u1h1BTzquax9w5wqTZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3957333"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3957333"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 08:41:46 -0800
X-CSE-ConnectionGUID: eqDDr+zvTM+bRtypcysw+w==
X-CSE-MsgGUID: 01oe9egoQMy1BFDCeS6wYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="11087115"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.66])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 08:41:41 -0800
Date: Fri, 20 Nov 2026 18:41:37 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <superm1@kernel.org>,
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 01/12] drm: add connector LUMINANCE property
Message-ID: <awB4Qe83u0l0XPKA@intel.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
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

On Thu, Nov 19, 2026 at 05:27:28PM -0600, Mario Limonciello wrote:
> Panel brightness is a property of a display, and thus of a DRM
> connector. Add an atomic per-connector LUMINANCE range property so
> compositors can manage relative panel luminance together with the rest
> of the display state.
> 
> Keep the core backend-agnostic. Drivers create the property with their
> hardware range and implement connector helper callbacks to set luminance
> or disable panel emission. The atomic helpers sequence those callbacks
> around pipeline enable and disable, including luminance-only commits.
> The panel is left lit when the pipeline enters self refresh, and the
> luminance is only reprogrammed when it changes or a modeset enables the
> pipeline.
> 
> The stored property value is independent of display power. A commit made
> while the connector is inactive is retained and applied on the next
> enable; disabling the pipeline does not overwrite it.
> 
> LUMINANCE values are relative, driver-defined levels rather than
> absolute luminance in cd/m^2. The interface supports emissive panels as
> well as panels with a separate backlight.
> 
> Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
> drivers retain their legacy backlight class ABI unless the new interface
> is explicitly selected, allowing the DRM UAPI and legacy compatibility
> policy to remain separate.
> 
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v11:
>  * Don't call .disable_luminance when the CRTC enters self refresh (Sashiko)
>  * Only call .set_luminance when the luminance changes or on a modeset
>    that isn't a self refresh exit (Leo Li, Sashiko)
>  * Fix the .set_luminance self refresh documentation
> v10:
>  * Add tag
> ---
>  drivers/gpu/drm/Kconfig                    | 14 +++++
>  drivers/gpu/drm/drm_atomic_helper.c        | 98 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/drm_atomic_state_helper.c  |  7 +++
>  drivers/gpu/drm/drm_atomic_uapi.c          |  5 ++
>  drivers/gpu/drm/drm_connector.c            | 57 +++++++++++++++++
>  drivers/gpu/drm/tests/drm_connector_test.c | 28 +++++++++
>  include/drm/drm_atomic_helper.h            |  3 +
>  include/drm/drm_connector.h                | 16 +++++
>  include/drm/drm_modeset_helper_vtables.h   | 28 +++++++++
>  9 files changed, 255 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 61111d50b1c65..1bbe2c2d7c76f 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -33,6 +33,20 @@ endmenu
>  
>  if DRM
>  
> +config DRM_LUMINANCE
> +	bool "DRM connector luminance support"
> +	help
> +	  Expose relative luminance as an atomic DRM connector property. Values
> +	  are driver-defined levels rather than absolute luminance in cd/m^2.
> +	  Drivers provide connector helper callbacks to program their hardware;
> +	  the DRM core does not depend on a particular backend.
> +
> +	  Drivers migrated to this interface will use it instead of registering
> +	  a legacy backlight class device. Leave this disabled to preserve the
> +	  de-facto userspace ABI in /sys/class/backlight.

I don't think this will fly if it breaks the backlight class interface.
No one can actually enable this outside of some niche embedded use
cases where backwards compatibility is not an issue. I think what
you need is a generic backlight class implementation on top of this.

-- 
Ville Syrjälä
Intel
