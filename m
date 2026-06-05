Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF7FCD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E182811A4D2;
	Fri,  5 Jun 2026 07:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="kL+qe9jF";
	dkim-atps=neutral
X-Greylist: delayed 526 seconds by postgrey-1.36 at gabe;
 Fri, 05 Jun 2026 07:08:56 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [194.59.206.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB7011A4D2;
 Fri,  5 Jun 2026 07:08:56 +0000 (UTC)
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gWskw3pGWz4HNY;
 Fri,  5 Jun 2026 09:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1780642808;
 bh=C4LywOONUo9mM7SYCl9JaZ1nEcm3gsy9ldzredo9jW0=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=kL+qe9jFQlDIIFWazrdM9DPHT8ZxTESUvlVZ5eHBkQwY4fZJyPV4J/Csp8xt7zZFy
 XACWiPgKk8OtyQMUjwLIy5KrvZZvz6LoN9g8tljf4aHhAydHkLFGzSCzrFIJbcP4SS
 45Elvf7avy7ydyXoj3kTM6C/ZPUgcF6eX82AkWy6h2p94+uiGe1Cg1UP0lTTqBf4ls
 3BaNScqlouL3TNQa1GcTX8dn/4jcAmoKLqevI92Ayls7BJEnfbV7DATNj6bmh8V1mo
 +b+mSwKmcZAv/xf7WreQ3u3vIAgyUs/177aIu//SKSetVjXqnUP4EKBt0zuLpSIhNh
 e1uRHnOTYDUeA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gWshp18Q2z7wPS;
 Fri,  5 Jun 2026 08:58:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gWshl5Cl8z8tXj;
 Fri,  5 Jun 2026 08:58:15 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 6D2A65F9DD;
 Fri,  5 Jun 2026 08:58:14 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ffac6caf-0376-4a0c-908e-b89cce48d28f@leemhuis.info>
Date: Fri, 5 Jun 2026 08:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/i915/backlight: Remove try_vesa_interface"
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Tvrtko Ursulin <tursulin@igalia.com>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: ankit.k.nautiyal@intel.com, arun.r.murthy@intel.com,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20260515155340.1000997-1-suraj.kandpal@intel.com>
 <20260517024709.1016121-1-suraj.kandpal@intel.com>
 <53a2a8dd-d1b6-41c5-ade2-7ed870d074ac@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <53a2a8dd-d1b6-41c5-ade2-7ed870d074ac@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178064269494.1178932.8212265372479905459@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 6D2A65F9DD
X-NC-CID: yZFu1qiK5+qb6kd4Rl2AdMorZ6t1O6HYlhAKMN1jnvJ0Ik1JIE4=
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

On 6/4/26 15:55, Thorsten Leemhuis wrote:
> On 5/17/26 04:47, Suraj Kandpal wrote:
>> This reverts commit 40d2f5820951dee818d05c14677277048bd85f9f.
>>
>> Removing the try_vesa_interface gate caused a backlight regression on
>> panels whose VBT correctly reports INTEL_BACKLIGHT_DISPLAY_DDI and whose
>> PWM path is the actual backlight control, but whose DPCD optimistically
>> advertises DP_EDP_BACKLIGHT_AUX_ENABLE_CAP / _BRIGHTNESS_AUX_SET_CAP.
>> After the commit such panels silently bind to the VESA AUX backlight
>> funcs; AUX writes complete but the panel ignores them, leaving
>> brightness stuck (no-op backlight). Observed on at least KBL and TGL
>> eDP setups.
> 
> Lo! What's the status of this regression fix? It's a -next for two weeks
> now as f30fddb4402313 ("Revert "drm/i915/backlight: Remove
> try_vesa_interface""), but from the outside and checking
> https://gitlab.freedesktop.org/drm/i915/kernel/-/commits/drm-intel-fixes
> it looks like it's scheduled for merging in the next cycle.

Resending to Tvrtko, who sent the i915 PR yesterday (which didn't
contain that fix), as well as Dave and Simona.

FWIW, due to the lack of response to various inquiries I'm considering
to ask Linus to directly pick up the mentioned regression fix to ensure
it makes it into rc7.

In case anyone wonder what regression I'm talking about:

* https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16015 /
https://lore.kernel.org/lkml/CADo9pHjr-zZ9C3%2B026y5%2BXOGPSeRzSJMCHof27TVPtAUNgTc8A@mail.gmail.com/
* https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16043
* https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16097 /
https://lore.kernel.org/lkml/d2de7933-e650-4b19-8d88-90d66693dcfc@message-id.googlemail.com/

Ciao, Thorsten

> But I think it should be merged this cycle (ideally before -rc7, as
> Linus wants all known regression fixed by -rc6), as it fixes a
> regression that is known since the -rc1 days. I already asked for the
> mainlining plans in gitlab tickets about a week ago (and since then
> affected users spoke up, too), but there was no conclusive answer for
> the plans, which is why I'm trying this way now.
> 
> Ciao, Thorsten
> 
> 
>> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
>> ---
>>  .../drm/i915/display/intel_dp_aux_backlight.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> index a8d56ebf06a2..7a6c07f6aaeb 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> @@ -691,10 +691,9 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
>>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
>>  	struct drm_device *dev = connector->base.dev;
>>  	struct intel_panel *panel = &connector->panel;
>> -	bool try_intel_interface = false;
>> +	bool try_intel_interface = false, try_vesa_interface = false;
>>  
>> -	/*
>> -	 * Check the VBT and user's module parameters to figure out which
>> +	/* Check the VBT and user's module parameters to figure out which
>>  	 * interfaces to probe
>>  	 */
>>  	switch (display->params.enable_dpcd_backlight) {
>> @@ -703,6 +702,7 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
>>  	case INTEL_DP_AUX_BACKLIGHT_AUTO:
>>  		switch (panel->vbt.backlight.type) {
>>  		case INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE:
>> +			try_vesa_interface = true;
>>  			break;
>>  		case INTEL_BACKLIGHT_DISPLAY_DDI:
>>  			try_intel_interface = true;
>> @@ -715,12 +715,20 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
>>  		if (panel->vbt.backlight.type != INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE)
>>  			try_intel_interface = true;
>>  
>> +		try_vesa_interface = true;
>> +		break;
>> +	case INTEL_DP_AUX_BACKLIGHT_FORCE_VESA:
>> +		try_vesa_interface = true;
>>  		break;
>>  	case INTEL_DP_AUX_BACKLIGHT_FORCE_INTEL:
>>  		try_intel_interface = true;
>>  		break;
>>  	}
>>  
>> +	/* For eDP 1.5 and above we are supposed to use VESA interface for brightness control */
>> +	if (intel_dp->edp_dpcd[0] >= DP_EDP_15)
>> +		try_vesa_interface = true;
>> +
>>  	/*
>>  	 * Since Intel has their own backlight control interface, the majority of machines out there
>>  	 * using DPCD backlight controls with Intel GPUs will be using this interface as opposed to
>> @@ -733,9 +741,6 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
>>  	 * panel with Intel's OUI - which is also required for us to be able to detect Intel's
>>  	 * backlight interface at all. This means that the only sensible way for us to detect both
>>  	 * interfaces is to probe for Intel's first, and VESA's second.
>> -	 *
>> -	 * Also there is a chance some VBTs may advertise false Intel backlight support even if the
>> -	 * TCON DPCD says otherwise. This means we keep VESA interface as fallback in that case.
>>  	 */
>>  	if (try_intel_interface && intel_dp->edp_dpcd[0] <= DP_EDP_14b &&
>>  	    intel_dp_aux_supports_hdr_backlight(connector)) {
>> @@ -745,7 +750,7 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
>>  		return 0;
>>  	}
>>  
>> -	if (intel_dp_aux_supports_vesa_backlight(connector)) {
>> +	if (try_vesa_interface && intel_dp_aux_supports_vesa_backlight(connector)) {
>>  		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] Using VESA eDP backlight controls\n",
>>  			    connector->base.base.id, connector->base.name);
>>  		panel->backlight.funcs = &intel_dp_vesa_bl_funcs;
> 

