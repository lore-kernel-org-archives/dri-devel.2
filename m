Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD7EC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4787E10F9F7;
	Fri, 25 Sep 2026 11:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n8Cr6Ked";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33EB310F9F7;
 Fri, 25 Sep 2026 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790334685; x=1821870685;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=pKJG4NNixG1bTghsu6d6b7QSc5YQncCMfKdLtiQwQAA=;
 b=n8Cr6KedIOaRj44vEtEv4kL8b6m1CFmrTQ3nyGOLbYp3BTOVcm1TBOJt
 YqP8z1W3PwLO5JP4bco72F9UCRjm66KNEE+iTCLafX77NO2O+F0SbWcaA
 OtcCNgS8SHuzgB8Jf7qBfOJW+0cqVOT7TwRc2sQjmbz1wX6Amc6GRF6WP
 NZpM5vf7QQzi4UjGGcMoIeREWKK8ZxyVhlkRPsHvyVXvaYP9SOwcKGZAj
 wijsNqisII1iD26Q8hQov63Q1gTJqXrcqRcTqLPvRhoxFMfTHLDNnUsDa
 FJrTdeSU6KJeryCZEF4M8mu06Zj6Id+yMYyZcE2wQlS1NICX4VHqTkRqB g==;
X-CSE-ConnectionGUID: TaBGkaNbT3iu39wk7+Q40Q==
X-CSE-MsgGUID: yLySgnNZSRiua1IbMuQiXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101778958"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="101778958"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 04:11:24 -0700
X-CSE-ConnectionGUID: cAeg1zLZQKKVg0SQhiZSeg==
X-CSE-MsgGUID: gN2VeGlYSaS63jTDQxoBpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="270788768"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.90])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 04:11:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Daniel Stone <daniel@fooishbar.org>, Vidith Madhu <vmadhu@nvidia.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, "Borah, Chaitanya
 Kumar" <chaitanya.kumar.borah@intel.com>, Leo Li <sunpeng.li@amd.com>,
 Daniel Stone <daniels@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, Derek Foreman
 <derek.foreman@collabora.com>, wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 06/25] drm/connector: hdmi: Add VTEM EMP generation
In-Reply-To: <CAPj87rO2+oSA7KtocG-M1hqgQTJO=3Qxmg-OMC5MmOLaja_kRg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
 <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
 <CAPj87rO2+oSA7KtocG-M1hqgQTJO=3Qxmg-OMC5MmOLaja_kRg@mail.gmail.com>
Date: Fri, 25 Sep 2026 14:11:15 +0300
Message-ID: <80ac0fee0d67a9e44a4858be904bdbb2265e50b5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 25 Sep 2026, Daniel Stone <daniel@fooishbar.org> wrote:
> Hi Vidith,
>
> On Fri, 25 Sept 2026 at 04:49, Vidith Madhu <vmadhu@nvidia.com> wrote:
>> On Mon, 21 Sep 2026, Nicolas Frattaroli wrote:
>> > +     if (!crtc_state->vrr_enabled) {
>> I don't think we should use the vrr_enabled CRTC property to determine
>> VRR_EN in the VTEM EMP. Transitioning the VRR mode sink-side typically causes
>> blanking, and it was discussed in patch [03/25] that drivers should be
>> free to handle vrr_enabled changes as a seamless switch since it only
>> concerns source-side VRR state (this is how the NVIDIA driver handles it).
>> Maybe it would make sense to extend the qms_enabled connector property
>> introduced in this patchset to an enum of {Off, Gaming, QMS}? This would allow
>> a standard path to control the VRR state on the sink, separately from
>> vrr_enabled.
>
> I remain cautious of putting this amount of policy inside the kernel
> and/or left to individual IHV choices. It's relatively obvious for
> NVIDIA and AMD to say 'we'll always enable FRL/VRR to smash the
> maximum rate (unless it's contraindicated by USB-C bandwidth somehow)
> because the power burn is inconsequential', but if you were MediaTek
> or Rockchip you'd probably make a different decision. Then again, if
> you were an MTK device living on AC power, maybe you'd make the same
> decision. Or maybe AMD would want to make a different decision on
> laptop parts because the bandwidth is noticeable then.
>
> The point is that I don't think we should bury this down in implicit
> kernel state. I'm with you on surfacing this as an explicit connector
> property. Possibly a bitmask of modes the user will use? e.g. {
> frr_only = 0, maybe_gaming_vrr = (1 << 0),  maybe_qms = (1 << 1), ...
> }? Or perhaps just a flag for whether the link should be negotiated as
> wide as possible or tight to the existing mode params?

On a tangent, Ville and I have been tossing around an idea to introduce
a drm device level property to control device "power mode" policy,
mapping to the kind of setting userspace already provides. Could start
of with the typical "performance", "balanced/default", and "power
saver".

It could be a single high-level knob to choose policy in the drm core
and drivers, instead of exposing a plethora of fine grained policy that
don't necessarily map well between drivers and may have conflicts
between them. And end up with a lot of ABI to maintain.

Policy decisions like this crop up all the time, even on things like how
to choose Display Port link config and DSC and color depth, and my gut
feeling is that just having e.g. those three options would help with
design decisions massively.

The user and userspace could use AC power or battery level or whatever
to decide which power mode to choose at the high level, and you wouldn't
have to have every desktop environment tweak every little thing at the
detailed level.


BR,
Jani.


-- 
Jani Nikula, Intel
