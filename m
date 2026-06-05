Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AB9CD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA00C10E489;
	Fri,  5 Jun 2026 10:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Si7tSzM5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91AFC10E2A8;
 Fri,  5 Jun 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=olLqF1n1Cx/+v/Stbc0WTULGeRSHFc7JdDIug5kIWs8=; b=Si7tSzM5wzOFy8I36rwbvT4m3M
 T+0IWTwfD0v7R7Nx8LAWHslqN1GM/WFjXppJ1H4JGiWgp4UlvqbrrTz5h7fdSCuVmnc5NgAhsJJUL
 g7ZthKzM+C3dwwLaOeupTNVDhkWzV3GK19kzH6gp7nTH5oHsTe85VW1YBKDdTAIHdLv+vtDQKVA0C
 AzLkttEpMMauDaDYB2JpMnYpec6+4Y8C0xgWIqRh/YRKxdlBn0T+RU+P3s5acZjUB1iQqBcj4rLOP
 w3xHbF6RuiSQgNZJJJrMhYPY9O//6QZ//0XRX3cpNYIyoSmugu9lKtc6ctV0/bxFV8PfFH0EClErn
 5zqhr0lw==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wVRYQ-00D5t9-Ub; Fri, 05 Jun 2026 12:13:30 +0200
Message-ID: <990ab0a5-64c1-4f10-841f-2eac6332ec97@igalia.com>
Date: Fri, 5 Jun 2026 11:13:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/i915/backlight: Remove try_vesa_interface"
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Tvrtko Ursulin <tursulin@igalia.com>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "Murthy, Arun R" <arun.r.murthy@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20260515155340.1000997-1-suraj.kandpal@intel.com>
 <20260517024709.1016121-1-suraj.kandpal@intel.com>
 <53a2a8dd-d1b6-41c5-ade2-7ed870d074ac@leemhuis.info>
 <ffac6caf-0376-4a0c-908e-b89cce48d28f@leemhuis.info>
 <c7764bbd-7990-4d11-832e-ec7283c1a6c1@igalia.com>
 <DS4PPFE901A304FD9E40779C9B78A29E661E3112@DS4PPFE901A304F.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <DS4PPFE901A304FD9E40779C9B78A29E661E3112@DS4PPFE901A304F.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 05/06/2026 11:04, Kandpal, Suraj wrote:
>> -----Original Message-----
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Sent: Friday, June 5, 2026 3:23 PM
>> To: Thorsten Leemhuis <regressions@leemhuis.info>; Tvrtko Ursulin
>> <tursulin@igalia.com>; Dave Airlie <airlied@gmail.com>; Simona Vetter
>> <simona.vetter@ffwll.ch>; Kandpal, Suraj <suraj.kandpal@intel.com>
>> Cc: Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>; Murthy, Arun R
>> <arun.r.murthy@intel.com>; intel-gfx@lists.freedesktop.org; intel-
>> xe@lists.freedesktop.org; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Linux kernel
>> regressions list <regressions@lists.linux.dev>; ML dri-devel <dri-
>> devel@lists.freedesktop.org>; Jani Nikula <jani.nikula@linux.intel.com>
>> Subject: Re: [PATCH] Revert "drm/i915/backlight: Remove try_vesa_interface"
>>
>>
>> Hi Suraj,
>>
>> On 05/06/2026 07:58, Thorsten Leemhuis wrote:
>>> On 6/4/26 15:55, Thorsten Leemhuis wrote:
>>>> On 5/17/26 04:47, Suraj Kandpal wrote:
>>>>> This reverts commit 40d2f5820951dee818d05c14677277048bd85f9f.
>>>>>
>>>>> Removing the try_vesa_interface gate caused a backlight regression
>>>>> on panels whose VBT correctly reports INTEL_BACKLIGHT_DISPLAY_DDI
>>>>> and whose PWM path is the actual backlight control, but whose DPCD
>>>>> optimistically advertises DP_EDP_BACKLIGHT_AUX_ENABLE_CAP /
>> _BRIGHTNESS_AUX_SET_CAP.
>>>>> After the commit such panels silently bind to the VESA AUX backlight
>>>>> funcs; AUX writes complete but the panel ignores them, leaving
>>>>> brightness stuck (no-op backlight). Observed on at least KBL and TGL
>>>>> eDP setups.
>>>>
>>>> Lo! What's the status of this regression fix? It's a -next for two
>>>> weeks now as f30fddb4402313 ("Revert "drm/i915/backlight: Remove
>>>> try_vesa_interface""), but from the outside and checking
>>>> https://gitlab.freedesktop.org/drm/i915/kernel/-/commits/drm-intel-fi
>>>> xes it looks like it's scheduled for merging in the next cycle.
>>>
>>> Resending to Tvrtko, who sent the i915 PR yesterday (which didn't
>>> contain that fix), as well as Dave and Simona.
>>>
>>> FWIW, due to the lack of response to various inquiries I'm considering
>>> to ask Linus to directly pick up the mentioned regression fix to
>>> ensure it makes it into rc7.
>>>
>>> In case anyone wonder what regression I'm talking about:
>>>
>>> * https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16015 /
>>> https://lore.kernel.org/lkml/CADo9pHjr-
>> zZ9C3%2B026y5%2BXOGPSeRzSJMCHof
>>> 27TVPtAUNgTc8A@mail.gmail.com/
>>> * https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16043
>>> * https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16097 /
>>> https://lore.kernel.org/lkml/d2de7933-e650-4b19-8d88-90d66693dcfc@mess
>>> age-id.googlemail.com/
>>>
>>> Ciao, Thorsten
>>>
>>>> But I think it should be merged this cycle (ideally before -rc7, as
>>>> Linus wants all known regression fixed by -rc6), as it fixes a
>>>> regression that is known since the -rc1 days. I already asked for the
>>>> mainlining plans in gitlab tickets about a week ago (and since then
>>>> affected users spoke up, too), but there was no conclusive answer for
>>>> the plans, which is why I'm trying this way now.
>>
>> Was there a reason the revert was not marked with a Fixes: tag? Or in other
>> words, any particular reason why it should *not* be picked up for drm-intel-
>> fixes?
> 
> There wasn't any particular reason.
> Tbh I didn't think we would require it since this revert was fixing the issue caused by the patch in question being reverted.

Okay then, thank you. I've cherry picked it and sent a new pull request. 
The previous one hasn't been pulled yet so hopefully this is still in time.

Regards,

Tvrtko

>>>> Ciao, Thorsten
>>>>
>>>>
>>>>> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
>>>>> ---
>>>>>    .../drm/i915/display/intel_dp_aux_backlight.c | 19 ++++++++++++-------
>>>>>    1 file changed, 12 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>>>>> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>>>>> index a8d56ebf06a2..7a6c07f6aaeb 100644
>>>>> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>>>>> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>>>>> @@ -691,10 +691,9 @@ int intel_dp_aux_init_backlight_funcs(struct
>> intel_connector *connector)
>>>>>    	struct intel_dp *intel_dp = intel_attached_dp(connector);
>>>>>    	struct drm_device *dev = connector->base.dev;
>>>>>    	struct intel_panel *panel = &connector->panel;
>>>>> -	bool try_intel_interface = false;
>>>>> +	bool try_intel_interface = false, try_vesa_interface = false;
>>>>>
>>>>> -	/*
>>>>> -	 * Check the VBT and user's module parameters to figure out which
>>>>> +	/* Check the VBT and user's module parameters to figure out which
>>>>>    	 * interfaces to probe
>>>>>    	 */
>>>>>    	switch (display->params.enable_dpcd_backlight) { @@ -703,6 +702,7
>>>>> @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector
>> *connector)
>>>>>    	case INTEL_DP_AUX_BACKLIGHT_AUTO:
>>>>>    		switch (panel->vbt.backlight.type) {
>>>>>    		case INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE:
>>>>> +			try_vesa_interface = true;
>>>>>    			break;
>>>>>    		case INTEL_BACKLIGHT_DISPLAY_DDI:
>>>>>    			try_intel_interface = true;
>>>>> @@ -715,12 +715,20 @@ int intel_dp_aux_init_backlight_funcs(struct
>> intel_connector *connector)
>>>>>    		if (panel->vbt.backlight.type !=
>> INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE)
>>>>>    			try_intel_interface = true;
>>>>>
>>>>> +		try_vesa_interface = true;
>>>>> +		break;
>>>>> +	case INTEL_DP_AUX_BACKLIGHT_FORCE_VESA:
>>>>> +		try_vesa_interface = true;
>>>>>    		break;
>>>>>    	case INTEL_DP_AUX_BACKLIGHT_FORCE_INTEL:
>>>>>    		try_intel_interface = true;
>>>>>    		break;
>>>>>    	}
>>>>>
>>>>> +	/* For eDP 1.5 and above we are supposed to use VESA interface for
>> brightness control */
>>>>> +	if (intel_dp->edp_dpcd[0] >= DP_EDP_15)
>>>>> +		try_vesa_interface = true;
>>>>> +
>>>>>    	/*
>>>>>    	 * Since Intel has their own backlight control interface, the majority of
>> machines out there
>>>>>    	 * using DPCD backlight controls with Intel GPUs will be using
>>>>> this interface as opposed to @@ -733,9 +741,6 @@ int
>> intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
>>>>>    	 * panel with Intel's OUI - which is also required for us to be able to
>> detect Intel's
>>>>>    	 * backlight interface at all. This means that the only sensible way for us
>> to detect both
>>>>>    	 * interfaces is to probe for Intel's first, and VESA's second.
>>>>> -	 *
>>>>> -	 * Also there is a chance some VBTs may advertise false Intel backlight
>> support even if the
>>>>> -	 * TCON DPCD says otherwise. This means we keep VESA interface as
>> fallback in that case.
>>>>>    	 */
>>>>>    	if (try_intel_interface && intel_dp->edp_dpcd[0] <= DP_EDP_14b &&
>>>>>    	    intel_dp_aux_supports_hdr_backlight(connector)) { @@ -745,7
>>>>> +750,7 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector
>> *connector)
>>>>>    		return 0;
>>>>>    	}
>>>>>
>>>>> -	if (intel_dp_aux_supports_vesa_backlight(connector)) {
>>>>> +	if (try_vesa_interface &&
>>>>> +intel_dp_aux_supports_vesa_backlight(connector)) {
>>>>>    		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] Using VESA eDP
>> backlight controls\n",
>>>>>    			    connector->base.base.id, connector->base.name);
>>>>>    		panel->backlight.funcs = &intel_dp_vesa_bl_funcs;
>>>>
>>>
> 

