Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C148C531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2A210E5C3;
	Thu, 23 Jul 2026 16:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OMdoClnp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B1210E5C2;
 Thu, 23 Jul 2026 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784823111; x=1816359111;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jUcotzTeGHseDTEsvIVAaM/5dkYSEPp61sUE3M2Ha4I=;
 b=OMdoClnp0AUnUkdPMPkWejkdDqCfA5Yrurrzw6faf8BydyqO/PtX8hFd
 gZS8+WJM0T1IhtXBIVPsnes85tljGrXPwtQmG6SeDuy8S/Ei/sdFe4FtA
 7DAvqE289YMoOOxJEnrT50BrPE0SI1QKU3g/CzgISG3T2OncB1TeuGGHI
 MFObJuzffPUIwM9HSWxt41hszjaiEcIPV645UnUAyAe/Onym1wpdg8Hlq
 a7B6Iz5mfB2RpALcR3DvTCt2dtjf+N7e12l/8ZFGPkyL6UFed8nUlX1mT
 VY9ZhyAOx48UP3pMpYdqOjb9KjjkVYwdNYQt9qENnHW2oDfRErF8naFhG Q==;
X-CSE-ConnectionGUID: Lk4q/8XhQ/KtkDDHZkF1Lg==
X-CSE-MsgGUID: YwXM8GzzRCO9IjdAhQzNxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102893201"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="102893201"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 09:11:50 -0700
X-CSE-ConnectionGUID: 0bMapSTvSbuSZqtNqgKM6w==
X-CSE-MsgGUID: 7CSbUSIcTp6N/vvPakIgRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="281753336"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 09:11:46 -0700
Date: Thu, 23 Jul 2026 18:11:44 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
 soham.purkait@intel.com, Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v6 2/2] drm/xe/xe_ras: Report correctable/uncorrectable
 error events to userspace
Message-ID: <amI9QO9_4QcfG4jc@black.igk.intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-6-riana.tauro@intel.com>
 <amDglMC44EIWChvp@black.igk.intel.com>
 <f08a30a8-afca-4cad-8353-5c3ce091a9ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08a30a8-afca-4cad-8353-5c3ce091a9ef@intel.com>
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

On Thu, Jul 23, 2026 at 08:34:39PM +0530, Tauro, Riana wrote:
> On 22-07-2026 20:54, Raag Jadav wrote:
> > On Wed, Jul 22, 2026 at 03:11:37PM +0530, Riana Tauro wrote:
> > > When an interrupt is received for correctable errors indicating that error
> > > counter has crossed its threshold, read the current counter value and
> > > deliver a drm-ras error-event to userspace for each affected component.
> > > 
> > > Also send drm-ras error-event to userspace for uncorrectable errors on
> > > receiving an AER.
> > > 
> > > To avoid sending duplicate events when the same component appears multiple
> > > times in the response, Send the error-event once per component.
> > ...
> > 
> > > @@ -425,6 +487,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
> > >   			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
> > >   				sev_to_str(severity));
> > Similar to threshold crossed case, we should probably have a BUILD_BUG_ON()
> > against XE_RAS_NUM_ERROR_ARR.
> 
> This is already added part of correctable. Seems unnecessary to add it twice

'sent' is a local variable and needs its own BUILD_BUG_ON() IMO, but
upto you.

Raag
