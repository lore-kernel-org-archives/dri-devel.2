Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6DEF327B0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBB110E19E;
	Tue, 21 Apr 2026 08:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eeoMJkO4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BE110E19E;
 Tue, 21 Apr 2026 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776759597; x=1808295597;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WRS+vzBvs9hovXLxoIje0HInnctDW7hH0qlRbticGNM=;
 b=eeoMJkO4C8kPRLx3TKtnjwpnIvOvuk+e6WyVDPA+4DlVO2kFJBJr3OJw
 QC3nP7g6VxykDl+wPKsWFwuHi5p8RRzL4Eg0ngYpHGr3CejjYG2kEvsJX
 1Uoo/vGF289RlAuXWPjWYGswdRwB/VM3n42Q5+Qjb/o3DyRP8e1JsBaBN
 rqLz1eyP+sOSG51I8upKBnnBPKp3yV04yPIn499i4CRUljbFWlyPmhzrj
 A7eurKSD+6szTg5rFjhY3qfxPs721sCunFa2K7JvtqInB9vnm7olKAHuv
 4SdT0lTyPZDJSBWxQpftPc/EPRu7pcmZI6a8Jp1VdynOKjt+AI0JXDlpe A==;
X-CSE-ConnectionGUID: GsSppFomSdO5zvvl225cpg==
X-CSE-MsgGUID: Lz3QvNJRT+iQhuMZIjsM4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="103147583"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="103147583"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 01:19:56 -0700
X-CSE-ConnectionGUID: /jvypYTVRmuG9coORWO+Og==
X-CSE-MsgGUID: F1mFf/qOQ/KRJ/sn4nPQLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="236330286"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 01:19:53 -0700
Date: Tue, 21 Apr 2026 10:19:50 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v4 2/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
Message-ID: <aeczJmU41-uTgT13@black.igk.intel.com>
References: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
 <20260413133013.560239-8-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413133013.560239-8-mallesh.koujalagi@intel.com>
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

On Mon, Apr 13, 2026 at 07:00:16PM +0530, Mallesh Koujalagi wrote:
> Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to handle
> scenarios requiring device power cycle.
> 
> This method addresses cases where other recovery mechanisms
> (driver reload, PCIe reset, etc.) are insufficient to restore device
> functionality. When set, it indicates to userspace that only device power
> cycle can recover the device from its current error state. The cold reset
> method serves as a last resort when all other recovery options have been
> exhausted.
> 
> v3:
> - Update any scenario that requires cold-reset. (Riana)
> 
> v4:
> - Rename cold reset to power cyclce. (Raag)
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

Make the comment consistent with consumer expectations in next patch.

Raag
