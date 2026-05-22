Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A906ACD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 19:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1796810E04D;
	Fri, 22 May 2026 19:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RwfN5X0e";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C9210E04D
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779478791; x=1811014791;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8qODzv8/snRPyzB4ZYUerxS720pTvueUQIu6KbHQAAU=;
 b=RwfN5X0e2wJPc2cm9Z8uMafbuIjrOEPd0PUJEcwhyoZ2VXQmj8NKObTb
 SE/cWC9mFYUeDl9eUh1+fM2keR9wetH0+YC9pbyQwV7eUKukZnASibPTL
 KlebNyOFqJ1IeCiYf7MwJOuVdbiammQ2PLcuMRq0G1qJhRs8F5l10q/av
 yn1bPQZxUW+FTCqubAKIzJKRwjN2jfa+IklHWzM+FapO37gwG2/oHWiMA
 Jv39KTM1G8ZEoR16nvKHI4uZ2X6Xh0vH1ZpHz+tHtAGInJelZAWYKk3RL
 miUzie0CWcT7eG7d6kC9JVu2keydTLJD4ytZVuPBm+QKJwc01WICTYq8x w==;
X-CSE-ConnectionGUID: 6CFMwYd0R/ivv9C+96DDbg==
X-CSE-MsgGUID: wSQ8BrZSQE2dHfJsKa3cVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="105876353"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="105876353"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 12:39:42 -0700
X-CSE-ConnectionGUID: UzTcu6xHSnSHnGQhVSGzUw==
X-CSE-MsgGUID: GKIoeDDuTG2BQchHMPJ/8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="279105916"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 12:39:40 -0700
Date: Fri, 22 May 2026 22:39:35 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
Message-ID: <ahCw9zakihaGHLsN@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
 <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
 <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
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

On Fri, May 22, 2026 at 03:43:26PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 22.05.26 um 15:28 schrieb Ville Syrjälä:
> [...]
> >>>> But why does your HW use CRTC 1 in the first place.
> >>> Could be eg. the enabled outputs can't be driven with CRTC 0.
> >>>
> >>> I guess what you want to do is pick the first crtc from modesets[]
> >>> which is enabled. Or perhaps even "pick the Nth enabled crtc from
> >>> modesets[] based on the ioctl argument".
> >> The enable-status of each CRTC could change later on, which might lead
> >> to problems.
> > Sound like a locking issue if someone is changing the configuration
> > at the same time we're trying to do the vblank wait here.
> 
> I mean that the connected outputs could change at a later point or we 
> could have multiple CRTCs in use. Today, someone in #intel-gfx reported 
> a problem with panning if multiple CRTCs are in use.
> 
> Therefore picking a CRTC freely could be a problem. Let's say we 
> configure modes from one CRTC, but later wait/pan/flush with another 
> CRTC. I would not trust this to work correctly.
> 
> Hence, my suggestion is to select a primary CRTC during the fbdev 
> client's probe and use it for all later operations until the next probe 
> happens.  All other CRTCs would mirror the primary one.

Actual mirroring may not be possible due to different modes supported
on each output. The whole multi-output fbdev thing in the drm fb helper
is kind of a hack that's rather hard to make work 100% sensibly.

For the panning possibly the only sensible thing is to use the max of
hdisplay/vdisplay of all the crtcs as the xres/yres so it's clear
how much things can actually be panned. Oh and tiled displays (assuming
we would actually want the fbdev stuff to tile correctly) make the
situation even more complicated. I think the current support for tiled
displays in the fb helper is semi-busted.

> Best regards
> Thomas
> 
> 
> >
> >> Picking the one CRTC/output with the lowest spec and
> >> mirroring it to the others might work. This CRTC would then be the one
> >> to wait for.
> >>
> >> Best regards
> >> Thomas
> >>
> >> -- 
> >> --
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> >> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> >>
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 

-- 
Ville Syrjälä
Intel
