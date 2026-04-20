Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E15FF5A8A5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEB310EAFC;
	Mon, 20 Apr 2026 18:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QKqabo8g";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D97710EAFC;
 Mon, 20 Apr 2026 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776708485; x=1808244485;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=u3OSShy829Tu/YEOfiMWDUEk8l3IRtNsvQVxBLt69a8=;
 b=QKqabo8gBetb+JkxvabYxd3kjLERWRE+r0C8se+YaoKNO3MCMWUomKEZ
 0NoXfWb8PlF8cn3K1PvM1Z77O569R9eR6+Il2AG5XEz8LhQ64ruRRXINY
 fUsx/WDpsQbtyiuEuoQuK/k4jh7AUGPVnaHGpKKqUGFifQKUvastnOf+Q
 V2acD8MtrCxzyPoyprvBV3kGfw4O73CzLLcAtUzI1/bUCohLbunkRzPBn
 r3xukQaxFq/u/qTjUexx04Q+pbWgeiMaAqBS/vWs319G+CpDP0TUxVdX5
 VT/d0ZTJladLrF7Hyi3buNGpnRotbeO+xMZN3Mfj6RLWsmJdB7lFDZlah w==;
X-CSE-ConnectionGUID: jY62TvugQ9GIxGAyvn1+uw==
X-CSE-MsgGUID: ciui8z1CTGysWzgQft50vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77644960"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="77644960"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 11:08:05 -0700
X-CSE-ConnectionGUID: fuJzcCWuQNS0iuIPJPxf4w==
X-CSE-MsgGUID: v5zpB2dDT5+RKmvo7Wkw9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="255261685"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.159])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 11:07:59 -0700
Date: Mon, 20 Apr 2026 21:07:55 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Melissa Wen <mwen@igalia.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, mario.limonciello@amd.com,
 alexander.deucher@amd.com, alex.hung@amd.com,
 Ivan Sergeev <ivan8215145640@gmail.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Jani Nikula <jani.nikula@intel.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Mario Limonciello <superm1@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/drm_edid: ignore continuous frequency support
 for VRR
Message-ID: <aeZre8L0zKFGA8ix@intel.com>
References: <20260223203528.213275-1-mwen@igalia.com>
 <aZ1YE6dcEfTMwly1@intel.com>
 <b6f267f4-812f-441b-939d-1ff24fd3406e@igalia.com>
 <40c88946-bd13-4bca-a1b4-5fe361f9de30@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40c88946-bd13-4bca-a1b4-5fe361f9de30@igalia.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Mon, Apr 20, 2026 at 12:15:07PM -0300, Melissa Wen wrote:
> 
> 
> On 24/02/2026 09:49, Melissa Wen wrote:
> >
> >
> > On 24/02/2026 04:49, Ville Syrjälä wrote:
> >> On Mon, Feb 23, 2026 at 05:29:46PM -0300, Melissa Wen wrote:
> >>> Display can be VRR capable even if its EDID doesn't contain the
> >>> Continuous Frequency flag. On the other hand, continuous frequency
> >>> support is expected for smooth VRR and ensures better compatibility 
> >>> with
> >>> VRR tehcnologies. As the lack of this flag can result in unexpected
> >>> issues like tearing, get monitor range even without the guarantee of
> >>> continuous frequency but add a debug message for unexpected results.
> >>>
> >>> CC: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >>> CC: Jani Nikula <jani.nikula@intel.com>
> >>> CC: Harry Wentland <harry.wentland@amd.com>
> >>> CC: Mario Limonciello <superm1@kernel.org>
> >>> CC: Alex Hung <alex.hung@amd.com>
> >>> Reported-by: Ivan Sergeev <ivan8215145640@gmail.com>
> >>> Fixes: 0159f88a ("drm/amd/display: remove redundant freesync parser 
> >>> for DP")
> >>> Signed-off-by: Melissa Wen <mwen@igalia.com>
> >>> ---
> >>>
> >>> Hello,
> >>>
> >>> After replacing the AMD driver-specific parser for VRR with the 
> >>> drm_edid
> >>> implementation, monitors without the continuous frequency flag in their
> >>> EDID stopped obtaining the monitor range because the DRM common code
> >>> considers them incompatible with VRR if they don't advertise support to
> >>> continuous frequencies. This differs from the original driver-specific
> >>> parser of AMD, that only checked EDID version, 
> >>> EDID_DETAIL_MONITOR_RANGE
> >>> and DRM_EDID_RANGE_LIMITS_ONLY_FLAG to determine the VRR range, so
> >>> switching to DRM common code caused a regression (reported by Ivan).
> >>>
> >>> The commit ca2582c66b930 `drm/edid: Parse only the VRR range for
> >>> continuous frequency displays` [1] introduced the Continuous Frequency
> >>> flag condition. While it was created to avoid issues related to
> >>> non-continuous refresh rates, it looks very restrictive to drivers that
> >>> want to deal with VRR capable monitor even without the guarantee of
> >>> continuous frequencies. I propose relaxing this restriction and 
> >>> adding a
> >>> debug message if anyone experiences problems related to the lack of
> >>> continuous frequency support.
> >> AFAIK without the continuous frequency bit the monitor isn't guaranteed
> >> to support all the refresh rates between min/max. So is this monitor
> >> trying to tell us that you are allowed to change the vtotal dynamically
> >> between the various explicit timings declared in the EDID but not 
> >> between
> >> any other other timings?
> >>
> >> Or is it just a buggy EDID that needs quirking?
> >
> > Looks like a buggy EDID. From decoded EDID I understand it supports all
> > refresh rates between 48Hz/75Hz (very small range anyway), without the
> > continuous freq flag in Features:
> >
> > ```
> >   EDID Structure Version & Revision: 1.4
> >   Vendor & Product Identification:
> >     Manufacturer: SKG
> >     Model: 10003
> >     Made in: week 25 of 2023
> >   Basic Display Parameters & Features:
> >     Digital display
> >     Bits per primary color channel: 10
> >     DisplayPort interface
> >     Maximum image size: 60 cm x 33 cm
> >     Gamma: 2.20
> >     DPMS levels: Off
> >     Supported color formats: RGB 4:4:4, YCrCb 4:4:4, YCrCb 4:2:2
> >     First detailed timing includes the native pixel format and 
> > preferred refresh rate
> >   Color Characteristics:
> >
> > [...]
> >
> > Detailed Timing Descriptors:
> > [...]
> >    Display Range Limits: Monitor ranges (Bare Limits): 48-75 Hz V, 
> > 223-223 kHz H, max dotclock 400 MHz
> > [...]
> >
> > Vendor-Specific Data Block (AMD), OUI 00-00-1A:
> > Version: 2.1
> > Minimum Refresh Rate: 48 Hz
> > Maximum Refresh Rate: 75 Hz
> > [...]
> > ```
> >
> > The reporter shared the EDID here:
> > - 
> > https://lore.kernel.org/amd-gfx/CAKx_Wg7_HBxuq5W4T_AmoFYJGQpa6TAS_Fx9SUzyy1itPmj5Bw@mail.gmail.com/ 
> >
> 
> Hi Ville,
> 
> In the end, it wasn't clear to me if this approach is acceptable or 
> should I create a quirk for this monitor.
> WDYT?

That things seems to have some AMD vendor specific VRR block. I'm
thinking that needs to added to the EDID parser and it should probably
take precedence over the base EDID stuff.

There are also some patch floating around for the DisplayID adaptive
sync block. I have no idea what the priority should be between that
and the AMD vendor specific block.

-- 
Ville Syrjälä
Intel
