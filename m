Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F064CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5B110E330;
	Fri, 16 Oct 2026 15:20:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A6610E330
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792164010; x=1823700010;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5+nNn0jefcVQxAVYD3jy1Si6PfI6dKYknyYWta2gJIE=;
 b=kjFoP3zoOhIcMhIxvF+lhUAeMmSdLsB0aE8CGRnhI/rC6cylswQlJGIX
 Iila7s2VTT9W6kYF0X4JV8Pfg5B6iGGoZHvOnRJMXOULtSHuQEMNLOWdQ
 L8hiIr1u8XtdyIPmnF2Rak0BQcwghVMS1K4QitREPPXBiETgizr0IOW9j
 C4kIJYk/M3jz3skorOZ5McT5F+ID/rVHlywZRkeTE2QKbXVNsgMEhcKft
 oF/3LFho8CBARp1jRuUoFEanrfgKSG5rfwhEyyfXDEJWIFTRd9CHBrPYu
 DDTI2prStjFFKeBa54F0/998GQQaLokrds+NDpoeh0Xfhr+DkB3t1sdHh g==;
X-CSE-ConnectionGUID: w+ZR7JB2T76Y64QJ3M8Yow==
X-CSE-MsgGUID: yJF1rVPNS+u2mWLG++XDlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="814799"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="814799"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 08:20:09 -0700
X-CSE-ConnectionGUID: ddZo41uQT4KIlC4cRw1qSQ==
X-CSE-MsgGUID: gDkoODRcR0GKe/FBZ8N/XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2333231"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.56])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 08:20:06 -0700
Date: Fri, 16 Oct 2026 18:20:02 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hugo Sales <hugo@hsal.es>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 jfalempe@redhat.com, javierm@redhat.com
Subject: Re: [PATCH 0/2] drm/client: Keep larger modes in connector->modes on
 fbdev hotplug
Message-ID: <atJAora2ehsbYz90@intel.com>
References: <20261015212545.1989962-1-hugo@hsal.es>
 <atIYd0dd6ynXulwQ@intel.com> <20261016131652.483525-1-hugo@hsal.es>
 <atItSgRj26x60ACf@intel.com>
 <20261016144013.1014546-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016144013.1014546-1-hugo@hsal.es>
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

On Fri, Oct 16, 2026 at 03:40:13PM +0100, Hugo Sales wrote:
> On Fri, Oct 16, 2026 at 04:57:30PM +0300, Ville Syrjälä wrote:
> > Connectors aren't probed before something actually probes them.
> > Typically that would be fbdev.
> 
> I think I may have misspoken before. fbdev's first probe already uses
> the device's limits: __drm_fb_helper_initial_config_and_unlock() passes
> max_width and max_height. Only drm_fb_helper_hotplug_event() passes the
> framebuffer size, so the list starts with every mode and loses the
> larger ones on the first hotplug. This series makes the hotplug probe
> match the first one

Right, forgot about the initial probe. And I think we definitely
want the initial probe to use the max size because we don't want
to keep the BIOS framebuffer if it's tiny. A long time ago we
kept the BIOS fb no matter what, but that made the console pretty
much unusable (due to being too small) on some machines.

> 
> Are you suggesting a different approach?

Nah, I guess what you're doing should be fine.

-- 
Ville Syrjälä
Intel
