Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F61606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vf4k2Iib
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0498F112099;
	Wed, 18 Nov 2026 22:30:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B7E10ECE4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795041018; x=1826577018;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ocEOxHCjUhjEJmQBGAqGWjok2uOvMot+WMkADqoKh4c=;
 b=Vf4k2Iibfm1e451i+/6EkrF1BI4/L9h92tTa+Xl7AXSUwu+e2R038vKW
 H3eM6kMTYfltjBsXE/U8a0NJb03/K9+Vq1io7pIP1m/7shY8vzLWdC7MC
 AGhf9hvYnJCptRLK3/KUaZocNy9pDA6sDuuR0QEXY0rJy9qBT6t8x2Nu1
 bL/wr/K9GivV1eB7D3s8eoQEc7oePj5z9t9DvQ5H8q6QVpGxb/2VL57zl
 g1WchEBd6nqImtl0mekLCDiGgrnD4btk81akloKFbq4XIv3Sy9PVnwPW7
 Oz50Ut+DIkOvREgYO8poW9VAT2erpB5LUL4GMezl364kuBVtA4umKcwnI Q==;
X-CSE-ConnectionGUID: QyRudUzTR7iYWRw1aPLdBA==
X-CSE-MsgGUID: QvBR2k1/R/2ekISsL1jAfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3761561"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3761561"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 14:30:18 -0800
X-CSE-ConnectionGUID: R9wJBnM6QC+cEolqJxOFNw==
X-CSE-MsgGUID: pm4VkU3BQrWx4621eXC6Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10064331"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 14:30:16 -0800
Date: Thu, 19 Nov 2026 00:30:12 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 15/20] drm/imagination: Allow build with COMPILE_TEST=y
Message-ID: <av4m9D2pDH9ufbcM@intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-16-ville.syrjala@linux.intel.com>
 <sashiko-outbox-222063@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-222063@kernel.org>
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

On Wed, Nov 18, 2026 at 09:58:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] drm/imagination: COMPILE_TEST build failure on 64-bit
>   8KB/32KB page configs
> --
> 
> commit 3a0a5d98906b6758538e2c13acfa780422a1a949
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> drm/imagination: Allow build with COMPILE_TEST=y
> 
> This commit allows DRM_POWERVR to be built on any 64-bit architecture when
> COMPILE_TEST is enabled.
> 
> > diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
> > index 1fd4c635c2c96..a048d3c859385 100644
> > --- a/drivers/gpu/drm/imagination/Kconfig
> > +++ b/drivers/gpu/drm/imagination/Kconfig
> > @@ -3,7 +3,8 @@
> >  
> >  config DRM_POWERVR
> >  	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG Graphics"
> > -	depends on (ARM64 || RISCV && 64BIT)
> > +	depends on ARM64 || RISCV || COMPILE_TEST
> > +	depends on 64BIT
> >  	depends on DRM
> >  	depends on MMU
> >  	depends on PM
> 
> [Severity: Medium]
> Does enabling DRM_POWERVR under COMPILE_TEST && 64BIT break the build on
> 64-bit targets with 8KiB or 32KiB pages (such as sparc64, alpha, or 64-bit
> mips with PAGE_SIZE_8KB/PAGE_SIZE_32KB)?
> 
> drivers/gpu/drm/imagination/pvr_mmu.h defines PVR_DEVICE_PAGE_SIZE as
> PAGE_SIZE, and drivers/gpu/drm/imagination/pvr_mmu.c only supports 4KiB,
> 16KiB, 64KiB, 256KiB, 1MiB, and 2MiB pages, failing with an #error on any
> other host page size.  Should DRM_POWERVR also depend on !PAGE_SIZE_8KB &&
> !PAGE_SIZE_32KB (or restrict to supported page sizes)?

I suppose. I might have to install a few more cross compilers and set
Claude to work with them.

-- 
Ville Syrjälä
Intel
