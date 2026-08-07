Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B527BC5AC9F
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 18:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7E010F591;
	Fri,  7 Aug 2026 18:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="X9mI1Quq";
	dkim-atps=neutral
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com
 [157.90.84.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE9D10E118;
 Fri,  7 Aug 2026 18:09:51 +0000 (UTC)
Received: from [10.10.12.8] (host-212-18-30-247.customer.m-online.net
 [212.18.30.247]) (Authenticated sender: wse@tuxedocomputers.com)
 by mail.tuxedocomputers.com (Postfix) with ESMTPSA id A810D2FC0049;
 Fri,  7 Aug 2026 20:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
 s=default; t=1786126189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTwuih1NVg2Y0Wkavti6r8ZQzu22LsLmpdENMFz7vf0=;
 b=X9mI1Quqd0Od0bi/jNBk1BfcVfiy8x7FnJIAE6jse0smOgFONFXxhM2f2ZIhhFvOKy4OCR
 15bUWEPcR8I+OVLFTmVfqKjm9p4ksBGFj6NT7LcIlJBcUD9hfSaWucGKP+UGtfthh/x6zN
 r9uigCp7KGiEoxO5Pr4fEHVUy/phL/0=
Authentication-Results: mail.tuxedocomputers.com;
 auth=pass smtp.auth=wse@tuxedocomputers.com
 smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <af55c1d3-2362-4372-a371-d707eb440948@tuxedocomputers.com>
Date: Fri, 7 Aug 2026 20:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm/i915/display: Add quirk to force backlight
 type on some TUXEDO devices
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260804200021.171947-1-wse@tuxedocomputers.com>
 <20260804200021.171947-2-wse@tuxedocomputers.com>
 <f329f7c1-9277-4b9d-8c81-09528a66545d@tuxedocomputers.com>
 <DS4PPFE901A304F53791AC29FAD352E193DE3D12@DS4PPFE901A304F.namprd11.prod.outlook.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <DS4PPFE901A304F53791AC29FAD352E193DE3D12@DS4PPFE901A304F.namprd11.prod.outlook.com>
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

Hi,

Am 07.08.26 um 04:37 schrieb Kandpal, Suraj:
>> Subject: Re: [PATCH v3 1/1] drm/i915/display: Add quirk to force backlight type
>> on some TUXEDO devices
>>
>> Am 04.08.26 um 21:52 schrieb Werner Sembach:
>>
>>> The display backlight on TUXEDO DX1708 and InsanityBook 15 v1 with
>>> panels AUO 12701 and AUO 12701 must be forced to
>>> INTEL_DP_AUX_BACKLIGHT_ON to be able to control the brightness.
> You need to mention why that is
> "Because the broken VBT in these panels report INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE
> even though the only way to control them is via Intel's backlight interface. Which means'
> the VBT should ideally report INTEL_BACKLIGHT_DISPLAY_DDI in its params"
ok will add
>
>>> This could already be archived via a module parameter, but this patch
> * can already
> * achieved
thanks for spotting
>
>>> adds a quirk to apply this by default on the mentioned devices.
>>>
>>> This patch does not actually test for the exact panels as the id that
>>> is used in the intel_dpcd_quirks list is sadly zeroed on the devices,
>>> but afaik all these devices use try_intel_interface first anyway so
>>> all the quirk does is to add the fallback to try_vesa_interface, so
>>> the behaviour on the devices not needing the quirk and fallback should
>>> functionally stay the same.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Fixes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15679
>>
>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15679
>>
>>> ---
>>>    .../drm/i915/display/intel_dp_aux_backlight.c |  9 ++++++-
>>>    drivers/gpu/drm/i915/display/intel_quirks.c   | 24 +++++++++++++++++++
>>>    drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
>>>    3 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>>> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>>> index 266e042e00237..594c59f2d8309 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>>> @@ -41,6 +41,7 @@
>>>    #include "intel_display_types.h"
>>>    #include "intel_dp.h"
>>>    #include "intel_dp_aux_backlight.h"
>>> +#include "intel_quirks.h"
>>>
>>>    /*
>>>     * DP AUX registers for Intel's proprietary HDR backlight interface.
>>> We define @@ -687,11 +688,17 @@ int
>> intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
>>>    	struct drm_device *dev = connector->base.dev;
>>>    	struct intel_panel *panel = &connector->panel;
>>>    	bool try_intel_interface = false, try_vesa_interface = false;
>>> +	int enable_dpcd_backlight;
>>>
>>>    	/* Check the VBT and user's module parameters to figure out which
>>>    	 * interfaces to probe
>>>    	 */
> This comment need to be moved just above the switch()
ok
>
>>> -	switch (display->params.enable_dpcd_backlight) {
>>> +	enable_dpcd_backlight = display->params.enable_dpcd_backlight;
>>> +	if (enable_dpcd_backlight == INTEL_DP_AUX_BACKLIGHT_AUTO &&
>>> +	    intel_has_dpcd_quirk(intel_dp, QUIRK_ENABLE_DPCD_BACKLIGHT))
>>> +		enable_dpcd_backlight = INTEL_DP_AUX_BACKLIGHT_ON;
> Let's also have a comment here as to why a quirk was used instead of just making VESA the default interface.
> This will help developers avoid going through a series of regressions, fixes and inevitable reverts.

ok i try my best to formulate something

v4 incoming, thanks for the review

Werner Sembach

>
> Regards,
> Suraj Kandpal
>   
>>> +
>>> +	switch (enable_dpcd_backlight) {
>>>    	case INTEL_DP_AUX_BACKLIGHT_OFF:
>>>    		return -ENODEV;
>>>    	case INTEL_DP_AUX_BACKLIGHT_AUTO:
>>> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
>>> b/drivers/gpu/drm/i915/display/intel_quirks.c
>>> index 33245f44c0d50..89d82364ae45d 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
>>> @@ -100,6 +100,14 @@ static void quirk_disable_psr2(struct intel_display
>> *display)
>>>    	drm_info(display->drm, "PSR2 support not currently available for this
>> setup, applying disable PSR2 quirk\n");
>>>    }
>>>
>>> +static void quirk_enable_dpcd_backlight(struct intel_dp *intel_dp) {
>>> +	struct intel_display *display = to_intel_display(intel_dp);
>>> +
>>> +	intel_set_dpcd_quirk(intel_dp, QUIRK_ENABLE_DPCD_BACKLIGHT);
>>> +	drm_info(display->drm, "Applying Enable DPCD Backlight quirk\n"); }
>>> +
>>>    struct intel_quirk {
>>>    	int device;
>>>    	int subsystem_vendor;
>>> @@ -286,6 +294,22 @@ static const struct intel_dpcd_quirk
>> intel_dpcd_quirks[] = {
>>>    		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
>>>    		.hook = quirk_disable_edp_panel_replay,
>>>    	},
>>> +	/* TUXEDO InsanityBook 15 v1 */
>>> +	{
>>> +		.device = 0x591b,
>>> +		.subsystem_vendor = 0x1558,
>>> +		.subsystem_device = 0x9501,
>>> +		.sink_oui = SINK_OUI(0x38, 0xec, 0x11),
>>> +		.hook = quirk_enable_dpcd_backlight,
>>> +	},
>>> +	/* TUXEDO DX1708 */
>>> +	{
>>> +		.device = 0x3e9b,
>>> +		.subsystem_vendor = 0x1558,
>>> +		.subsystem_device = 0x8500,
>>> +		.sink_oui = SINK_OUI(0x38, 0xec, 0x11),
>>> +		.hook = quirk_enable_dpcd_backlight,
>>> +	},
>>>    };
>>>
>>>    void intel_init_quirks(struct intel_display *display) diff --git
>>> a/drivers/gpu/drm/i915/display/intel_quirks.h
>>> b/drivers/gpu/drm/i915/display/intel_quirks.h
>>> index 970a4fe52fafc..4996419ae76bd 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
>>> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
>>> @@ -23,6 +23,7 @@ enum intel_quirk_id {
>>>    	QUIRK_EDP_LIMIT_RATE_HBR2,
>>>    	QUIRK_DISABLE_EDP_PANEL_REPLAY,
>>>    	QUIRK_DISABLE_PSR2,
>>> +	QUIRK_ENABLE_DPCD_BACKLIGHT,
>>>    };
>>>
>>>    void intel_init_quirks(struct intel_display *display);
