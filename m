Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05723FD5F85
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604C810E513;
	Wed,  8 Apr 2026 07:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ptei7VjT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B8E10E0B9;
 Wed,  8 Apr 2026 07:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775634389; x=1807170389;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HOeinGHosQvwWxDQCIs7G2hT79WlRxD2duGbULb62Og=;
 b=Ptei7VjTKYClzj3S5f5GkhbxJNuh8clDwWcXgXWezh2ZUU28GL0aVj0Y
 Kofq1Duesyrpw5KWEkYW6YC4T8kHpryDnJXjQX//R3oWnZjfFqqfBECFC
 zvKmZuVNsQEGDr7D/HKaEd91G4CHrAhqIZspqszYb4O4XMGhhVeeSvdwV
 juLKVtfakkbdJBBvPlPhtUDscrDsqpu1FGx7DyKx/K/sLEA1YWPcuSPum
 e5KO5f17JDeMv3tfvdm0FKsT1XeqeYH/+6R5YT9qrsuu1PAJPDa+MNGpb
 tq+bD0/M2ttENfRpF0hal9iU+UB/aa/VB9n8B7s/I2SnaEffwTpYKCiB0 w==;
X-CSE-ConnectionGUID: nhqPdJvgSbGlEDrddaHzrA==
X-CSE-MsgGUID: CFbYPidbScKrYUJP1/L5pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102064444"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="102064444"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 00:46:28 -0700
X-CSE-ConnectionGUID: 1fifSydpTwaioDY3vViO+Q==
X-CSE-MsgGUID: HxfpuXoUTfGsd5SJyuNUUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="228334091"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 00:46:25 -0700
Date: Wed, 8 Apr 2026 09:46:22 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v3 2/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
Message-ID: <adYHzt76lEXSyRkg@black.igk.intel.com>
References: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
 <20260406142325.157035-8-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406142325.157035-8-mallesh.koujalagi@intel.com>
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

On Mon, Apr 06, 2026 at 07:53:28PM +0530, Mallesh Koujalagi wrote:
> Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery
> method to handle scenarios requiring complete cold reset.

s/complete cold reset/device power cycle

> This method addresses cases where other recovery mechanisms
> (driver reload, PCIe reset, etc.) are insufficient to restore
> device functionality. When set, it indicates to userspace that
> only a full cold reset can recover the device from its current

Ditto.

> error state. The cold reset method serves as a last resort
> when all other recovery options have been exhausted.

We usually try to utilize the full 75 character space where possible but
ofcourse it's a personal preference.

Raag

> v3:
> - Update any scenario that requires cold-reset. (Riana)
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 2 ++
>  include/drm/drm_device.h  | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 985c283cf59f..8c0236e2e6a6 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -535,6 +535,8 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
>  		return "bus-reset";
>  	case DRM_WEDGE_RECOVERY_VENDOR:
>  		return "vendor-specific";
> +	case DRM_WEDGE_RECOVERY_COLD_RESET:
> +		return "cold-reset";
>  	default:
>  		return NULL;
>  	}
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index bc78fb77cc27..3e386eb42023 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -37,6 +37,7 @@ struct pci_controller;
>  #define DRM_WEDGE_RECOVERY_REBIND	BIT(1)	/* unbind + bind driver */
>  #define DRM_WEDGE_RECOVERY_BUS_RESET	BIT(2)	/* unbind + reset bus device + bind */
>  #define DRM_WEDGE_RECOVERY_VENDOR	BIT(3)	/* vendor specific recovery method */
> +#define DRM_WEDGE_RECOVERY_COLD_RESET	BIT(4)	/* full device cold reset */
>  
>  /**
>   * struct drm_wedge_task_info - information about the guilty task of a wedge dev
> -- 
> 2.34.1
> 
