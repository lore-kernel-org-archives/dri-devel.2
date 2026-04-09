Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E2CF364B6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8813010E080;
	Thu,  9 Apr 2026 21:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="krlGezdj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EA610E080
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775769128; x=1807305128;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=oJxyh0g/A8b5OcJcuVfTmAYVKJITInLTJHPo1BiHZ5w=;
 b=krlGezdjJoITrtmxcSWc1vaq5ULk0GDWFVV/sZ5qF36xbfzV5M/B92LP
 UaZ+5P3q3mWhvl5PiOclDyEtFRfJPYjwA/KYuxB03JzVz6CCUj1mn8EOk
 VxutmCVprp7kkTlIEZvpxPQDwKG2doOXOBItD7ow6iXFcXqerjJ6Y4Tk7
 KaY4Pnrjo7Lw3LNLCE7lVt7T5aSVLDrXVIQgMssPejTcRgiP01pSYhQr2
 IEPLY+JJbPbNqovtSeo09i7PSrqPR8vE09aMf6fVci9gisCfUw26Cbkm/
 TpQKUm78QkEVHZjFPWgsUxZs/HcAwicTJWDKilHEzm59JA6SovcaMtxAG Q==;
X-CSE-ConnectionGUID: 6WkgNKP0TsauzUrVI8N9Ew==
X-CSE-MsgGUID: RdhfjGd4SjyfwkDFEL2miw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80380649"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; d="scan'208";a="80380649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 14:12:08 -0700
X-CSE-ConnectionGUID: 0ggiM17aQMOyemTMyngTTQ==
X-CSE-MsgGUID: WimCPlygQfGHw+8lwr2olw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; d="scan'208";a="252240438"
Received: from dgeiger-mobl1.ger.corp.intel.com (HELO [10.246.17.96])
 ([10.246.17.96])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 14:12:06 -0700
Message-ID: <2807038a-b931-4a7a-9d8a-ea4feb53b595@linux.intel.com>
Date: Thu, 9 Apr 2026 23:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add support for limiting NPU frequency
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com,
 lizhi.hou@amd.com, maciej.falkowski@linux.intel.com
References: <20260330083815.1806045-1-andrzej.kacprowski@linux.intel.com>
 <dcf02dcc-e49f-4d7a-8cec-95d177b32336@oss.qualcomm.com>
 <10d61ab1-216d-4a79-bd80-ff4309c4d6b4@linux.intel.com>
 <74542a6e-14d6-4736-961f-59443d59b146@oss.qualcomm.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <74542a6e-14d6-4736-961f-59443d59b146@oss.qualcomm.com>
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

On 09-Apr-26 9:19 PM, Jeff Hugo wrote:
> On 4/8/2026 7:01 AM, Andrzej Kacprowski wrote:
>> On 31-Mar-26 8:12 AM, Jeff Hugo wrote:
>>> On 3/30/2026 2:38 AM, Andrzej Kacprowski wrote:
>>>> Add configurable frequency limits to allow users to constrain the NPU
>>>> operating frequency range for power and thermal management. This 
>>>> support
>>>> requires firmware API version 3.34.0 or newer.
>>>>
>>>> New sysfs interface:
>>>>
>>>> The freq/ subdirectory contains the following attributes:
>>>>
>>>> - hw_min_freq: Minimum frequency supported by hardware (read-only)
>>>> - hw_max_freq: Maximum frequency supported by hardware (read-only)
>>>> - hw_efficient_freq: Hardware's optimal operating frequency (read-only)
>>>> - current_freq: Current NPU frequency in MHz (read-only)
>>>> - set_min_freq: Configure minimum operating frequency (50XX+ devices)
>>>> - set_max_freq: Configure maximum operating frequency (50XX+ devices)
>>> I don't see Documentation/ABI changes in this patch, which are 
>>> required for sysfs.
>>>
>> Good point. I will add required documentation for all attributes 
>> exported by the ivpu driver.
>> [PATCH V2] will follow.
>>
>>> However, I wonder if this is the best way to move forward. At best, 
>>> you appear to be implementing a completely custom version of hwmon. 
>>> However, I wonder if hwmon/sysfs will be limiting as you support 3 
>>> generations of devices if I recall correctly, and that number is 
>>> probably going to go up. With the different generations supporting 
>>> different capabilities, I suspect the sysfs approach will eventually 
>>> put you into a corner.
>> Hwmon supports a fixed set of sensor types (temperature, voltage, fan 
>> speed, etc...) but it does not support frequency, so its not suitable 
>> for the purpose.
> 
> hwmon_device_register_with_info() allows you to extend the interface 
> with the extra_groups parameter.
Indeed, looks like there is way to add custom attributes.
Still I haven't found any example where frequency would be managed 
though hwmon interface.

The intended purpose of the proposed ivpu feature is to allow system 
level power manager to limit NPU power usage and extend system battery 
life.

Hwmon does not seem to be a good match here - its main value is 
providing standardized sensors that can be accessed though common 
software like lm-sensors.

- Andrzej
> 
>> Frequency limiting is supported on 2 hardware generations (50XX and 
>> 60XX) without any delta. I'm not expecting any changes in this code 
>> for future hardware.
>>>
>>> Your collegues over in the XE area have proposed a netlink mechanism, 
>>> which is in -next currently (expected to go in the 7.1 merge window). 
>>> We collaborated on that mechanism, and have plans to extend it for 
>>> these kinds of "telemetry" items. I'm expecting we'll have some 
>>> patches posted on list in a week, maybe 2 (finishing up some of the 
>>> final details). Perhaps you would find that useful?
>> The DRM RAS over netlink seems to be tailored for reporting error 
>> counters.
>>
>> The xe driver I was mimicking, still manages frequency limiting with 
>> sysfs, even thou it supported hwmon for discrete hw sensors, and now 
>> RAS over netlink as well for error counters.
>>
>> - Andrzej
>>>
>>> -Jeff
>>
> 

