Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4036CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8AB410E013;
	Thu,  1 Oct 2026 07:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="W/QupU5X";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB2110E013
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:40:47 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57689269;
 Thu,  1 Oct 2026 09:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1790840333;
 bh=ucWAOggwr+mPb21mpQHRenVwJ30J0XlSmziq+E7u99g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W/QupU5XyuVs/IpX6JHJ19dN3sqlOXMyfDGftkw1Z7MhIrbvbamNVlZUzGClwTj2o
 RIE34WI1+eAu8K2hz4mYpoJj/GIvazSiaP+o8NXCkLZe54QhceKPo6IoYB6pb8Hnu8
 RpVpzG2YlkkVUMELxyW27yX7cKoGHLOfpv8foGzs=
Message-ID: <982ffabf-4709-427a-b2b6-481eb074f2d0@ideasonboard.com>
Date: Thu, 1 Oct 2026 10:40:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
To: abhash <a-kumar2@ti.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, s-jain1@ti.com, y-d@ti.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 devarsht@ti.com, u-kumar1@ti.com, sjakhade@cadence.com
References: <20260601095041.3042950-1-a-kumar2@ti.com>
 <3dbf5a77-c314-4511-ab63-1b1ecd2e16c1@ideasonboard.com>
 <1c8dfc23-c03c-4c98-ae52-c66ffea244e6@ti.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <1c8dfc23-c03c-4c98-ae52-c66ffea244e6@ti.com>
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

On 29/06/2026 13:32, abhash wrote:
> 
> Hi Tomi,
> 
> Thanks for the review.
> 
> On 18/06/26 14:19, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 01/06/2026 12:50, Abhash Kumar Jha wrote:
>>> Add system suspend and resume hooks to the cdns-mhdp8546 bridge driver.
>>>
>>> While resuming we either load the firmware or activate it. Firmware
>>> is loaded only when resuming from a successful suspend-resume cycle.
>>
>> It's not clear from the patch if this is a fix or improvement. It 
>> sounds a bit like a fix, but it doesn't mention any kind of issue in 
>> the driver. So, why is this patch needed?
> 
> The driver lacked support for suspend-resume as stated in the todo on 
> the driver, So the patch adds this improvement.

The patch doesn't remove any todo lines. Was that just a miss, or is 
there more to add wrt. PM?

What does it mean it didn't support PM? Does the driver not work after 
suspend-resume cycle? Or does the driver prevent a proper suspend?
>>> If resuming due to an aborted suspend, loading the firmware is not
>>> possible because the uCPU's IMEM is only accessible after a reset and 
>>> the
>>> bridge has not gone through a reset in this case. Hence, Activate the
>>> firmware that is already loaded.
>>>
>>> Use genpd_notifier to get the power domain status of the bridge and
>>> accordingly load the firmware.
>>>
>>> Additionally, introduce phy_power_off/on to control the power to the 
>>> phy.
>>
>> If you write "also" or "additionally" or such in a commit desc, you 
>> should stop and think if that part should actually be a separate 
>> patch. Also, why is that change needed? 
> 
> The phy device could be powered off while resuming. So we are explicitly 
> powering it on.
> 
> The phy driver api also recommends to always call phy_init() first 
> followed by a phy_power_on().
> 
> "Some PHY drivers may not implement `phy_init` or `phy_power_on`, but 
> controllers should always call these functions to be compatible with 
> other PHYs"

It still sounds like a separate patch to me: the current driver is 
missing phy_power_on/off from the probe/remove functions.

>> Overall, this sounds fragile/hacky to me.
>>
>> The first thing is that usually you shouldn't use system suspend/ 
>> resume in a bridge driver. When a system suspend happend, the display 
>> pipeline will be disabled, so this driver will get an atomic_disable() 
>> call, and enable when resuming. You can use runtime PM hooks if you 
>> need resume/suspend hooks.
>>
> Thanks for the suggestion, I will use the runtime PM instead.
> 
>> The second thing is the PD notifier. Is there really no way we can see 
>> the state from the MDHP IP registers? 
> 
> The other way that i found was to read the MHDP KEEP_ALIVE_p register 
> twice to know if the firmware is incrementing the counter.
> 
> Based on that we can decide if the bridge is active or not. Do you think 
> this approach would be okay over the PD notifier?
I think it would be best to be able somehow to ask this from the HW to 
find the true state, instead of guessing it second hand from the PD 
notifier (which also doesn't tell us the initial HW state at probe).

KEEP_ALIVE_p sounds fine. Or what does the mdhp IP do if you send a 
message to the firmware when it's not up? Say, if you always do 
cdns_mhdp_set_firmware_active, what happens if the FW has not been 
loaded? I would guess that there's a timeout, and that could be used to 
find out the FW is not up.

Also, if the IMEM is not accessible and you load the FW, what happens?

  Tomi

