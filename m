Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBA3CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8A010E5C1;
	Mon, 25 May 2026 08:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ys/yUwb/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A8510E5C1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779696854; x=1811232854;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ihsnSs4yoA0E0Ix5Jf56XQK8b2iliN3qStZX19quVX0=;
 b=Ys/yUwb/mjea/zhSsAruLrzQKx6O/c0B8Ck91ZzUQxKGHuY967xN4Eoc
 iJ1MhfCGLfwoyIyVxgSa3Wcjyw80TGrunLw728UBQZTuKlKJsYVpM+Stf
 zTAQPvhUZUrkAySaTk4PWB8i9Rg/opcicNI8jaekHUuq6hmcs9yKwErnN
 KsMp0LtFyocu51vFpe1Ftntwk5uLCEalIVupLIC8eCy6LAhmg2vjTJCjG
 bb+PeX2TiUFTi+WbjoSFKxIvxG30ihbDpo2vrdMZvJYszdvSPZnqmWc0o
 6LVJFSh3VY9dh98cyAPZaOVj3kF8GQDweLCcIZTzS8TCsU4RQ8W2rG8c0 A==;
X-CSE-ConnectionGUID: JnR5IYb3QPGdwvHP6XK3SA==
X-CSE-MsgGUID: dtdreWAXQ9+udwma5P6SyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80485235"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="80485235"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:14:07 -0700
X-CSE-ConnectionGUID: OfxSNpDTQFis4634mDkFyg==
X-CSE-MsgGUID: SSzNXk1OSfC163ZZYQEVZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="241723677"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.200])
 ([10.245.245.200])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:14:04 -0700
Message-ID: <428be9d9-06f7-4bcb-807b-d351101c3c4b@linux.intel.com>
Date: Mon, 25 May 2026 10:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, stable@vger.kernel.org
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de> <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de> <ahCw9zakihaGHLsN@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <ahCw9zakihaGHLsN@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hey,

Den 2026-05-22 kl. 21:39, skrev Ville Syrjälä:
> On Fri, May 22, 2026 at 03:43:26PM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 22.05.26 um 15:28 schrieb Ville Syrjälä:
>> [...]
>>>>>> But why does your HW use CRTC 1 in the first place.
>>>>> Could be eg. the enabled outputs can't be driven with CRTC 0.
>>>>>
>>>>> I guess what you want to do is pick the first crtc from modesets[]
>>>>> which is enabled. Or perhaps even "pick the Nth enabled crtc from
>>>>> modesets[] based on the ioctl argument".
>>>> The enable-status of each CRTC could change later on, which might lead
>>>> to problems.
>>> Sound like a locking issue if someone is changing the configuration
>>> at the same time we're trying to do the vblank wait here.
>>
>> I mean that the connected outputs could change at a later point or we 
>> could have multiple CRTCs in use. Today, someone in #intel-gfx reported 
>> a problem with panning if multiple CRTCs are in use.
>>
>> Therefore picking a CRTC freely could be a problem. Let's say we 
>> configure modes from one CRTC, but later wait/pan/flush with another 
>> CRTC. I would not trust this to work correctly.
>>
>> Hence, my suggestion is to select a primary CRTC during the fbdev 
>> client's probe and use it for all later operations until the next probe 
>> happens.  All other CRTCs would mirror the primary one.
> 
> Actual mirroring may not be possible due to different modes supported
> on each output. The whole multi-output fbdev thing in the drm fb helper
> is kind of a hack that's rather hard to make work 100% sensibly.
> 
> For the panning possibly the only sensible thing is to use the max of
> hdisplay/vdisplay of all the crtcs as the xres/yres so it's clear
> how much things can actually be panned. Oh and tiled displays (assuming
> we would actually want the fbdev stuff to tile correctly) make the
> situation even more complicated. I think the current support for tiled
> displays in the fb helper is semi-busted.´

I tested fbdev on a tiled DP-MST monitor.
It works better than my kwin's wayland compositor, as it detects both tiles
and presents a single image spanning both tiles. Kwin sees both as separate
monitors.

I still see vertical tearing between both tiles, so it would be nice if
intel/display would support atomic updates for both crtc's directly.

The code's already there for bigjoiner, just needs to do the same for
tile joiner updates when all tiled crtc's are in the atomic update.

Kind regards,
~Maarten Lankhorst
