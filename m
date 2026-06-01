Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38971CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8673E1132BF;
	Mon,  1 Jun 2026 12:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Iv6XvSp6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1C91132BF;
 Mon,  1 Jun 2026 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780316707; x=1811852707;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QBPDWS3w88qu0Bl7I+ahCYWVeJs/wsUdsmC4ZJLznp8=;
 b=Iv6XvSp61Qq8NIa3+UeZjjlatlDDRNsRz8tk2y1EEl8bmnEZJAStel3n
 +OnpQHDPK60iGms4PrjWuycYOzOx5IehZHW09//Xb4BfMEc8DwB+vBXZs
 dcwtqYiT7B19TqH09NNmFAyEkc3Wl6VmEwVRoHMVZcT1AHHnYHUHILFb1
 qgLKCZ7OFckVOoDe9RsXGQO4jXO/Il72+LypAc5TvWljqK4+XAgD92GPf
 GiVqs/u+PwKKJvn9vV5J4dUkiy9uYldHauysls0Lwjmc0Fq2xbu98di4A
 pq/u+p2jSaeuEeC8anWcB7C39+EYeB9Vsf7sALkQzysI6n3AhWl4uTPPu A==;
X-CSE-ConnectionGUID: /6S1r+IURlSMgcdw/CYAjQ==
X-CSE-MsgGUID: 8y29c62/R5GSxyKyNN2iAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80922611"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="80922611"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 05:25:07 -0700
X-CSE-ConnectionGUID: s0taGkdxQJKTcgYWk1rdBA==
X-CSE-MsgGUID: pqW4DugeR0WqLVdpZTy69A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="243686155"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 05:25:04 -0700
Date: Mon, 1 Jun 2026 14:25:01 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, dev@lankhorst.se, airlied@gmail.com,
 simona@ffwll.ch, kuba@kernel.org
Subject: Re: [PATCH v2 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
Message-ID: <ah16Hfwq7goxBm27@black.igk.intel.com>
References: <20260523050212.557292-1-raag.jadav@intel.com>
 <20260523050212.557292-5-raag.jadav@intel.com>
 <65752da7-a23d-4495-9863-541bdd3f7888@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65752da7-a23d-4495-9863-541bdd3f7888@intel.com>
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

On Mon, Jun 01, 2026 at 01:13:12PM +0200, Michal Wajdeczko wrote:
> On 5/23/2026 7:00 AM, Raag Jadav wrote:
> > Hardware errors should be logged with HW_ERR prefix. Make them
> > consistent with existing logs.
> > 
> > Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_hw_error.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
> > index 5135e8e4093f..4b72959b2276 100644
> > --- a/drivers/gpu/drm/xe/xe_hw_error.c
> > +++ b/drivers/gpu/drm/xe/xe_hw_error.c
> > @@ -223,9 +223,9 @@ static void log_hw_error(struct xe_tile *tile, const char *name,
> >  	struct xe_device *xe = tile_to_xe(tile);
> >  
> >  	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > -		drm_warn(&xe->drm, "%s %s detected\n", name, severity_str);
> > +		drm_warn(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
> 
> function is per-tile, so shouldn't we use tile-oriented logs instead?

Agree, but then it needs to be done file-wide which I'll pursue once
the fix lands and propageted.

Raag

> 		xe_tile_warn(tile, HW_ERR ...)
> 
> >  	else
> > -		drm_err_ratelimited(&xe->drm, "%s %s detected\n", name, severity_str);
> > +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
> 
> 		xe_tile_err_ratelimited(tile, HW_ERR ...)
> 
> >  }
> >  
> >  static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
> > @@ -235,10 +235,10 @@ static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
> >  	struct xe_device *xe = tile_to_xe(tile);
> >  
> >  	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > -		drm_warn(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> > +		drm_warn(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> >  			 name, severity_str, i, err);
> >  	else
> > -		drm_err_ratelimited(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> > +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> >  				    name, severity_str, i, err);
> >  }
> >  
> > @@ -255,9 +255,9 @@ static void log_soc_error(struct xe_tile *tile, const char * const *reg_info,
> >  
> >  	if (strcmp(name, "Undefined")) {
> >  		if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > -			drm_warn(&xe->drm, "%s SOC %s detected", name, severity_str);
> > +			drm_warn(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
> >  		else
> > -			drm_err_ratelimited(&xe->drm, "%s SOC %s detected", name, severity_str);
> > +			drm_err_ratelimited(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
> >  		atomic_inc(&info[index].counter);
> >  	}
> >  }
> 
