Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81FECD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C48C10E2B6;
	Mon, 25 May 2026 12:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Trf40pUi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5E910E2B6
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779712222; x=1811248222;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5bhexpmneKoYSiRbvSbWWrxgpggJapgRMGJ1yQI3xC8=;
 b=Trf40pUi3gsjs4hLE/qJB/lr9+rBl1qmgZS4VawRI05eJrUEjj7g+AaJ
 WBHMVhpaY+i61RB0ghxRS5+BQDbxBiaUiPcSUfiXc+XzvMPwl1Hi1qVfr
 8B4otDm1dQ185xPwWY5rnCh2sieprlbnHVF/zByIFA6gVJVtgcYzXj/hs
 aXUY1rro/4Aiay2WCYhMCcTJ205iFK0vyWkyAPeEYlxmijb2rHB5UkjVu
 GajeuhU5zDeoxtOTHgV86Z8czbDk4c85hYrXd42VCDNgs+vxT0cRgK1Zk
 PNlJSp3B2vKTZGUmeaDh/dEbFkw0I0OmQaOKcx2q8n/fgE4/vgPY4ZACA w==;
X-CSE-ConnectionGUID: ndieEVxsRc6SbdYf1zjocw==
X-CSE-MsgGUID: RTecitiOTs+2L/Kw99wqKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="97960965"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="97960965"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 05:30:22 -0700
X-CSE-ConnectionGUID: wYfTuSWdQoe10+GbYDwJRA==
X-CSE-MsgGUID: DrvYC+pmQ4iok4w5G6cMPQ==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.3])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 05:30:18 -0700
Date: Mon, 25 May 2026 15:30:15 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
Message-ID: <ahRA17a7JR2PVOuJ@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
 <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
 <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
 <ahCw9zakihaGHLsN@intel.com>
 <428be9d9-06f7-4bcb-807b-d351101c3c4b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428be9d9-06f7-4bcb-807b-d351101c3c4b@linux.intel.com>
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

On Mon, May 25, 2026 at 10:13:57AM +0200, Maarten Lankhorst wrote:
> Hey,
> 
> Den 2026-05-22 kl. 21:39, skrev Ville Syrjälä:
> > On Fri, May 22, 2026 at 03:43:26PM +0200, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 22.05.26 um 15:28 schrieb Ville Syrjälä:
> >> [...]
> >>>>>> But why does your HW use CRTC 1 in the first place.
> >>>>> Could be eg. the enabled outputs can't be driven with CRTC 0.
> >>>>>
> >>>>> I guess what you want to do is pick the first crtc from modesets[]
> >>>>> which is enabled. Or perhaps even "pick the Nth enabled crtc from
> >>>>> modesets[] based on the ioctl argument".
> >>>> The enable-status of each CRTC could change later on, which might lead
> >>>> to problems.
> >>> Sound like a locking issue if someone is changing the configuration
> >>> at the same time we're trying to do the vblank wait here.
> >>
> >> I mean that the connected outputs could change at a later point or we 
> >> could have multiple CRTCs in use. Today, someone in #intel-gfx reported 
> >> a problem with panning if multiple CRTCs are in use.
> >>
> >> Therefore picking a CRTC freely could be a problem. Let's say we 
> >> configure modes from one CRTC, but later wait/pan/flush with another 
> >> CRTC. I would not trust this to work correctly.
> >>
> >> Hence, my suggestion is to select a primary CRTC during the fbdev 
> >> client's probe and use it for all later operations until the next probe 
> >> happens.  All other CRTCs would mirror the primary one.
> > 
> > Actual mirroring may not be possible due to different modes supported
> > on each output. The whole multi-output fbdev thing in the drm fb helper
> > is kind of a hack that's rather hard to make work 100% sensibly.
> > 
> > For the panning possibly the only sensible thing is to use the max of
> > hdisplay/vdisplay of all the crtcs as the xres/yres so it's clear
> > how much things can actually be panned. Oh and tiled displays (assuming
> > we would actually want the fbdev stuff to tile correctly) make the
> > situation even more complicated. I think the current support for tiled
> > displays in the fb helper is semi-busted.´
> 
> I tested fbdev on a tiled DP-MST monitor.
> It works better than my kwin's wayland compositor, as it detects both tiles
> and presents a single image spanning both tiles.

IIRC we've occasionally seen cases where it picks a non-tiled mode
on the primary connector, and also still enables the second tile.

> Kwin sees both as separate
> monitors.
> 
> I still see vertical tearing between both tiles, so it would be nice if
> intel/display would support atomic updates for both crtc's directly.
> 
> The code's already there for bigjoiner, just needs to do the same for
> tile joiner updates when all tiled crtc's are in the atomic update.

We don't have any special code for atomic updates with joiner
currently. It just happens to work most of the time.

With joiner the pipes will be in sync/phase, so that helps a bit.
But we do also try to make the pipes in sync/phase also for tiled
display via the use of the port sync. So if you see a difference
in tearing between joiner vs. tiled then that likely means the
problem is in userspace (as in it submits separate commits for
each tile).

I have occasionally pondered about hiding the tiled display stuff
completely from userspace and handling it in the kernel the same
was as joiner. But the problem is that we'd also need to cook up
a new EDID for the display that combines both tiles, and we'd
still need the second connector to be enabled internally (and 
hide that fact from userspace). None of that code exists
currently and wouldn't be entirely trivial to implement.

-- 
Ville Syrjälä
Intel
