Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E861606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=badxh/+D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17F610ECC9;
	Wed, 18 Nov 2026 22:28:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA21B10ECC9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795040912; x=1826576912;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZtRJ9VUBqowhR7H8EyZuNy6+UQZ80k9gz9GHbW1SFUo=;
 b=badxh/+DXR2Y0/RViXnMfB++QiCUjf9xIslnDXr53dxO7SkQL95uEbdB
 Brj4vDR5hDKfAuSoCtb6PjDVgfLUswbCtQL0tKaBfj4fdxDUewsqIfiT6
 AK9nvDMRmgEbaMN0s3x7nsc4/mQtZHOFxa82IVzP4+XJNi0coucmvUA/E
 7Mb1F/09XvrtU3+BD+6aYOnbfHh2YlYMAsg6t3xYDCLjmPWWTBQ28XLLw
 L1c4taL4SrLLxnItzuLuW1Wb5jriF8K9nbjwlLs0hcmiS2ASbd986UtoG
 uBiuZvKX7outH/2y3762rD65v/DitYUvUiDquZEjj7I3uYyP8tVrI0QH7 w==;
X-CSE-ConnectionGUID: tfPNgfyBRkGQmeMRoEZKag==
X-CSE-MsgGUID: sy4SfvrDRLSDCiurvi515Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3767633"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3767633"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 14:28:32 -0800
X-CSE-ConnectionGUID: wZUMpexdTWmXChSZPIe9VA==
X-CSE-MsgGUID: RnSFZeoPRxGY5TBS8DOBBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10134787"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 14:28:31 -0800
Date: Thu, 19 Nov 2026 00:28:26 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 19/20] drm/nouveau: Allow platform driver build with
 COMPILE_TEST=y
Message-ID: <av4miu_2zQEDnBJx@intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-20-ville.syrjala@linux.intel.com>
 <sashiko-outbox-222062@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-222062@kernel.org>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 09:57:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] drm/nouveau: build failure in nouveau_platform_resume() when
>   PM_DEVFREQ=n
> --
> 
> commit 7f3a768f8ef913fb90efb9c01241f3d8714fc297
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> drm/nouveau: Allow platform driver build with COMPILE_TEST=y
> 
> This commit allows NOUVEAU_PLATFORM_DRIVER to be enabled when COMPILE_TEST=y
> even on non-Tegra architectures.
> 
> > diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> > index 3b5757aed9c84..d7b432c839e5f 100644
> > --- a/drivers/gpu/drm/nouveau/Kconfig
> > +++ b/drivers/gpu/drm/nouveau/Kconfig
> > @@ -34,7 +34,7 @@ config DRM_NOUVEAU
> >  
> >  config NOUVEAU_PLATFORM_DRIVER
> >  	bool "Nouveau (NVIDIA) SoC GPUs"
> > -	depends on DRM_NOUVEAU && ARCH_TEGRA
> > +	depends on DRM_NOUVEAU && (ARCH_TEGRA || COMPILE_TEST)
> >  	default y
> >  	help
> >  	  Support for Nouveau platform driver, used for SoC GPUs as found
> 
> [Severity: Medium]
> Does this break the build in nouveau_platform_resume() when
> CONFIG_PM_SLEEP=y and CONFIG_PM_DEVFREQ=n?
> 
> DRM_NOUVEAU only has "select PM_DEVFREQ if ARCH_TEGRA", so when
> ARCH_TEGRA=n and COMPILE_TEST=y, CONFIG_PM_DEVFREQ can remain disabled.
> The fallback stub for gk20a_devfreq_resume() in
> drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a_devfreq.h is missing the
> pointer asterisk on its parameter:
> 
> drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a_devfreq.h:
>     #if defined(CONFIG_PM_DEVFREQ)
>     int gk20a_devfreq_init(struct nvkm_clk *base, struct gk20a_devfreq **devfreq);
>     int gk20a_devfreq_resume(struct device *dev);
>     int gk20a_devfreq_suspend(struct device *dev);
>     #else
>     static inline int gk20a_devfreq_init(struct nvkm_clk *base, struct gk20a_devfreq **devfreq)
>     {
>     	return 0;
>     }
> 
>     static inline int gk20a_devfreq_resume(struct device dev) { return 0; }
>     static inline int gk20a_devfreq_suspend(struct device *dev) { return 0; }
>     #endif
> 
> Passing struct device *dev from nouveau_platform_resume() to
> gk20a_devfreq_resume() then fails to compile with an incompatible type
> error.

Ack. Fix is now on my local branch. I'll include it if/when I resend.

-- 
Ville Syrjälä
Intel
