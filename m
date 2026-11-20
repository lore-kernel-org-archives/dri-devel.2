Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723FC60A3832
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=WjSiwlRP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9D910E907;
	Fri, 20 Nov 2026 13:56:36 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D2210E907
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:56:30 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 600C94E6;
 Fri, 20 Nov 2026 14:53:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795182838;
 bh=Aar6XZczj/4btUv+pjLkVDhGtVoJXtRsa+7PZSfK/vQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WjSiwlRPN5GTQ+4eWSR1eK2LcBuiAy779feehu9+FUTGvJycfCjcK6MruVBUKIPdI
 5bbFSa7fShPG8lTS1taz/aCKyP+UVwTDuN9TxyHFJNj3XRNg1m2DYoM5vHgAYRUz7P
 nYzTATGTYuA9hJ99ynhQ6lF5C3CXZ8MufzWGBdmc=
Message-ID: <e40cd28f-eb52-4205-a799-8340b59c0a60@ideasonboard.com>
Date: Fri, 20 Nov 2026 15:56:24 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
To: Benjamin Robin <benjamin.robin@bootlin.com>,
 "Kumar, Abhash" <a-kumar2@ti.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, s-jain1@ti.com, y-d@ti.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 devarsht@ti.com, u-kumar1@ti.com, sjakhade@cadence.com
References: <20260601095041.3042950-1-a-kumar2@ti.com>
 <f1089720-2a8e-4f0f-b995-fc7ef0836da0@ti.com>
 <73ebfed6-a3ad-4134-a8b9-d17213442fa9@ideasonboard.com>
 <oN6DWNeSTbeo_5NexR3j3A@bootlin.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <oN6DWNeSTbeo_5NexR3j3A@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 20/11/2026 15:11, Benjamin Robin wrote:
> On Wednesday, October 14, 2026 at 3:25 PM, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 06/10/2026 11:49, Kumar, Abhash wrote:
>>> Hi,
>>>
>>> On 10/1/2026 1:10 PM, Tomi Valkeinen wrote:
>>>> Hi,
>>>>
>>>> On 29/06/2026 13:32, abhash wrote:
>>>>>
>>>>> Hi Tomi,
>>>>>
>>>>> Thanks for the review.
>>>>>
>>>>> On 18/06/26 14:19, Tomi Valkeinen wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 01/06/2026 12:50, Abhash Kumar Jha wrote:
>>>>>>> Add system suspend and resume hooks to the cdns-mhdp8546 bridge
>>>>>>> driver.
>>>>>>>
>>>>>>> While resuming we either load the firmware or activate it. Firmware
>>>>>>> is loaded only when resuming from a successful suspend-resume cycle.
>>>>>>
>>>>>> It's not clear from the patch if this is a fix or improvement. It
>>>>>> sounds a bit like a fix, but it doesn't mention any kind of issue in
>>>>>> the driver. So, why is this patch needed?
>>>>>
>>>>> The driver lacked support for suspend-resume as stated in the todo on
>>>>> the driver, So the patch adds this improvement.
>>>>
>>>> The patch doesn't remove any todo lines. Was that just a miss, or is
>>>> there more to add wrt. PM?
>>> Yeah, i will remove the TODO in the next revision.
>>>>
>>>> What does it mean it didn't support PM? Does the driver not work after
>>>> suspend-resume cycle? Or does the driver prevent a proper suspend?
>>>
>>> When we resume, the cdns_mhdp_link_up function fails.
>>>
>>> Failure log at resume:
>>>
>>> [  55.329452] tidss 4a00000.dss: PM: calling tidss_resume [tidss] @
>>> 1053, parent: bus@100000
>>>
>>> [ 183.381228] cdns-mhdp8546 a000000.bridge: Failed to read receiver
>>> capabilities
>>>
>>> [ 191.391548] cdns-mhdp8546 a000000.bridge: get block[0] edid failed: -110
>>>
>>> [ 193.392713] cdns-mhdp8546 a000000.bridge: Failed to read register
>>>
>>> [ 261.415544] cdns-mhdp8546 a000000.bridge: Failed to read register
>>>
>>> [ 263.946153] tidss 4a00000.dss: Timeout waiting for framedone on crtc 0
>>>
>>> [ 391.991358] cdns-mhdp8546 a000000.bridge: Failed to read receiver
>>> capabilities
>>>
>>> [ 392.026847] tidss 4a00000.dss: PM: tidss_resume [tidss] returned 0
>>> after 336689133 usecs
>>>
>>> I guess it is fair to say that the driver does not work after suspend-
>>> resume cycle.
>>>
>>>>>>> If resuming due to an aborted suspend, loading the firmware is not
>>>>>>> possible because the uCPU's IMEM is only accessible after a reset
>>>>>>> and the
>>>>>>> bridge has not gone through a reset in this case. Hence, Activate the
>>>>>>> firmware that is already loaded.
>>>>>>>
>>>>>>> Use genpd_notifier to get the power domain status of the bridge and
>>>>>>> accordingly load the firmware.
>>>>>>>
>>>>>>> Additionally, introduce phy_power_off/on to control the power to
>>>>>>> the phy.
>>>>>>
>>>>>> If you write "also" or "additionally" or such in a commit desc, you
>>>>>> should stop and think if that part should actually be a separate
>>>>>> patch. Also, why is that change needed?
>>>>>
>>>>> The phy device could be powered off while resuming. So we are
>>>>> explicitly powering it on.
>>>>>
>>>>> The phy driver api also recommends to always call phy_init() first
>>>>> followed by a phy_power_on().
>>>>>
>>>>> "Some PHY drivers may not implement `phy_init` or `phy_power_on`, but
>>>>> controllers should always call these functions to be compatible with
>>>>> other PHYs"
>>>>
>>>> It still sounds like a separate patch to me: the current driver is
>>>> missing phy_power_on/off from the probe/remove functions.
>>>>
>>> I will add that as a separate patch
>>>>>> Overall, this sounds fragile/hacky to me.
>>>>>>
>>>>>> The first thing is that usually you shouldn't use system suspend/
>>>>>> resume in a bridge driver. When a system suspend happend, the
>>>>>> display pipeline will be disabled, so this driver will get an
>>>>>> atomic_disable() call, and enable when resuming. You can use runtime
>>>>>> PM hooks if you need resume/suspend hooks.
>>>>>>
>>>>> Thanks for the suggestion, I will use the runtime PM instead.
>>>>>
>>>>>> The second thing is the PD notifier. Is there really no way we can
>>>>>> see the state from the MDHP IP registers?
>>>>>
>>>>> The other way that i found was to read the MHDP KEEP_ALIVE_p register
>>>>> twice to know if the firmware is incrementing the counter.
>>>>>
>>>>> Based on that we can decide if the bridge is active or not. Do you
>>>>> think this approach would be okay over the PD notifier?
>>>> I think it would be best to be able somehow to ask this from the HW to
>>>> find the true state, instead of guessing it second hand from the PD
>>>> notifier (which also doesn't tell us the initial HW state at probe).
>>>>
>>>> KEEP_ALIVE_p sounds fine. Or what does the mdhp IP do if you send a
>>>> message to the firmware when it's not up? Say, if you always do
>>>> cdns_mhdp_set_firmware_active, what happens if the FW has not been
>>>> loaded? I would guess that there's a timeout, and that could be used
>>>> to find out the FW is not up.
>>>>
>>> Yes, there is a 2 second timeout if we send a message and the firmware
>>> is not up. I would prefer the KEEP_ALIVE_p method, as that is a better
>>> indication of the
>>
>> But that's a driver imposed timeout, and it sounds rather arbitrary (and
>> bad). How quickly does the firmware usually reply? What would be the
>> situation where the firmware takes e.g. 1.5s to reply? I would guess
>> that if the FW updates the KEEP_ALIVE_p every N us, it would also reply
>> to us in that time.
>>
>> In any case, changing MAILBOX_TIMEOUT_US would be another patch.
>> KEEP_ALIVE_p sounds fine if you know how often the FW updates it.
>>
>>    Tomi
> 
> Hi,
> 
> I wanted to check on the status of this series, as I'm quite interested
> in it since my series [1] depends on it.
> 
> For my use case, the suspend/resume support isn't essential, but the
> calls to phy_power_on() and phy_power_off() are.
> 
> Thanks for any update.
> 
> [1] https://lore.kernel.org/all/20261120-phy-cadence-torrent-ng-v1-0-da2db7125cd7@bootlin.com/T/
> 

Yep, it could as well be sent separately. Abhash, are you working on 
this still? Can you send the phy power on/off as a separate patch.

  Tomi

