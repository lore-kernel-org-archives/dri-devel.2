Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A137CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 00:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D48110E10B;
	Fri,  8 May 2026 00:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MGTXwWx9";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367D410E047
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 00:53:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BF5841A3545;
 Fri,  8 May 2026 00:53:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7569E605D0;
 Fri,  8 May 2026 00:53:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D7BB1081952F; 
 Fri,  8 May 2026 02:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778201629; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=wuh4jrSq6HInUfrOG+rISYcrHBWF0+fSOdMKGvwq/wg=;
 b=MGTXwWx9ZEoyaq0zZ8HHN3WBOSoIaplf4xGtdD6xD6x544Mh5o8iX4RymmFCViOpY818ri
 dSZgc3yZL8HqhALSIDIh5p2+6JtSPTV8og/C3zUYtNelQTkP+hZi4cj0Q99ryBG/Bvp/d6
 CSfg4HZIN7Z7W/6mwSnSjedJ82BujLxvVMJO+944fXJdJhB8O1yUKTwhQjRxlGO0sj1a02
 b24mvW9OlZ1Vzdv3L9oA6j/aC9I+kqEn4ODoxZLjZOpCyyvLbV0MG8FA39q29NzpbTU+ct
 g2Bs1xO5h82ECdsI8yTPu1NjXshS66elo8Maueyv61YtJju6r+MWwsueQc86Lw==
Message-ID: <2a4bb4dc-8909-46a7-94cb-1d57de09c38e@bootlin.com>
Date: Fri, 8 May 2026 02:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v3 1/8] backlight: add kernel-internal backlight API
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: harry.wentland@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-2-mario.limonciello@amd.com>
 <b1a09658-ff19-4331-a184-b1a5457b7f69@bootlin.com>
 <d2e0852e-006d-4d30-b754-7fe597b9b4f0@amd.com>
Content-Language: en-US
In-Reply-To: <d2e0852e-006d-4d30-b754-7fe597b9b4f0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 5/4/26 19:55, Mario Limonciello wrote:
> 
> 
> On 5/4/26 08:55, Louis Chauvet wrote:
>> [You don't often get email from louis.chauvet@bootlin.com. Learn why 
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On 4/25/26 00:09, Mario Limonciello wrote:
>>> From: David Herrmann <dh.herrmann@gmail.com>
>>>
>>> So far backlights have only been controlled via sysfs. However, sysfs is
>>> not a proper user-space API for runtime modifications, and never was
>>> intended to provide such. The DRM drivers are now prepared to provide
>>> such a backlight link so user-space can control backlight via DRM
>>> connector properties. This allows us to employ the same access- 
>>> management
>>> we use for mode-setting.
>>>
>>> This patch adds few kernel-internal backlight helpers so we can modify
>>> backlights from within DRM.
>>>
>>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>>>
>>> V2: Marta Lofstedt <marta.lofstedt@intel.com>
>>> - rebase
>>> - minor edit for checkpatch warning
>>>
>>> Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>
>>>
>>> V3: Mario Limonciello <mario.limonciello@amd.com>
>>>   - rebase
>>>   - Use guard(mutex)
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/video/backlight/backlight.c | 60 +++++++++++++++++++++++++++++
>>>   include/linux/backlight.h           | 16 ++++++++
>>>   2 files changed, 76 insertions(+)
>>>
>>> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/ 
>>> backlight/backlight.c
>>> index ab87a5e3dbf70..c3673bee6d9cf 100644
>>> --- a/drivers/video/backlight/backlight.c
>>> +++ b/drivers/video/backlight/backlight.c
>>> @@ -513,6 +513,66 @@ static int devm_backlight_device_match(struct 
>>> device *dev, void *res,
>>>       return *r == data;
>>>   }
>>>
>>> +/**
>>> + * backlight_device_lookup - find a backlight device
>>> + * @name: sysname of the backlight device
>>> + *
>>> + * @return Reference to the backlight device, NULL if not found.
>>> + *
>>> + * This searches through all registered backlight devices for a 
>>> device with the
>>> + * given device name. In case none is found, NULL is returned, 
>>> otherwise a
>>> + * new reference to the backlight device is returned. You must drop 
>>> this
>>> + * reference via backlight_device_unref() once done.
>>> + * Note that the devices might get unregistered at any time. You 
>>> need to lock
>>> + * around this lookup and inside of your backlight-notifier if you 
>>> need to know
>>> + * when a device gets unregistered.
>>> + *
>>> + * This function can be safely called from IRQ context.
>>> + */
>>> +struct backlight_device *backlight_device_lookup(const char *name)
>>> +{
>>> +     struct backlight_device *bd;
>>> +     const char *t;
>>> +
>>> +     guard(mutex)(&backlight_dev_list_mutex);
>>> +     list_for_each_entry(bd, &backlight_dev_list, entry) {
>>> +             t = dev_name(&bd->dev);
>>> +             if (t && !strcmp(t, name)) {
>>> +                     backlight_device_ref(bd);
>>> +                     return bd;
>>> +             }
>>> +     }
>>> +
>>> +     return NULL;
>>> +}
>>> +EXPORT_SYMBOL_GPL(backlight_device_lookup);
>>>
>>
>> Hello,
>>
>> I think this function can be repalced with backlight_device_get_by_name.
> 
> Yes; good call.
> 
>>
>>> +/**
>>> + * backlight_set_brightness - set brightness on a backlight device
>>> + * @bd: backlight device to operate on
>>> + * @value: brightness value to set on the device
>>> + * @reason: backlight-change reason to use for notifications
>>> + *
>>> + * This is the in-kernel API equivalent of writing into the 
>>> 'brightness' sysfs
>>> + * file. It calls into the underlying backlight driver to change the 
>>> brightness
>>> + * value. The value is clamped according to device bounds.
>>> + * A uevent notification is sent with the reason set to @reason.
>>> + */
>>> +void backlight_set_brightness(struct backlight_device *bd, unsigned 
>>> int value,
>>> +                           enum backlight_update_reason reason)
>>> +{
>>> +     guard(mutex)(&bd->ops_lock);
>>> +     if (bd->ops) {
>>> +             value = clamp(value, 0U,
>>> +                           (unsigned int)bd->props.max_brightness);
>>
>> Why did you use a clamping here? I think it is better to return error
>> instead.
>>
> 
> This is called from a work queue.  This is the call path:
> 
> __drm_backlight_worker().
> -> __drm_backlight_schedule()
> ->-> __drm_backlight_prop_changed()
> ->->-> drm_backlight_set_luminance().
> 
> So - I suppose that actually what you are suggesting is to plumb an 
> error all the way from the work queue up to all the callers.  That might 
> for a change to make things synchronous that weren't 'intended' to be 
> synchronous.

You are right, this is not a good idea to make this synchronous.

After looking a bit more at the code, I think you can simply not clamp 
at all and use a warn. In all cases:
- drm should never ask for a value outside 0..U16_MAX
- the conversion from 0..U16_MAX to 0..bd->props.max_brightness should 
never be bigger than bd->props.max_brightness

So if you have to clamp, it means there is a bug somewhere in the process.

I imagine something like:

b_set_brightness(value)
	if value > max:
		return -EINVAL
	[...]

__drm_backlight_worker()
	r = b_set_brightness(new_value)
	if r == -EINVAL: # This should never be the case, new_value should be 
clamped to 0..max_value before
		WARN("Invalid backlight value requested")
		# maybe add a fallback to at least have a coherent on/off state and 
avoid complete black screens
		if new_value==0: b_set_brightness(0)
		else: b_set_brightness(max_value)

__drm_backlight_prop_changed(u16 requested_value)
	new_value = requested_value * max_value / U16_MAX
	schedule_work(new_value)


> Maybe a better solution is to try to look at the max brightness 
> 'directly' in drm_backlight_set_luminance() and then reject it before 
> going down the work queue path.
>
> Thoughts?

That also a solution, but I think it is better to have a clear interface 
for drm_backlight_set_luminance and the backlight property: 
drm_backlight_set_luminance must get a 0..U16_MAX value, any other value 
is invalid.

But I have a question for this: is the scale of luminance linear or not? 
I think this information should be given to userspace.
And if lunimance is not linear, I don't think you can easily scale 
between 0..U16MAX to 0..max_value.

Same thing for backlight=0, IIRC sometimes the backlight driver switch 
off the light, sometimes it is just the minimum luminosity.

I think that can be a topic for discussion at drm hackfest, but it may 
also require more precise information / specification from the backlight 
subsystem / to the userspace interface.


>>> +             dev_dbg(&bd->dev, "set brightness to %u\n", value);
>>> +             bd->props.brightness = value;
>>> +             backlight_update_status(bd);
>>> +     }
>>> +     backlight_generate_event(bd, reason);
>>> +}
>>> +EXPORT_SYMBOL_GPL(backlight_set_brightness);
>>>
>>
>> I think this could be nice to update backlight_device_set_brightness to
>> avoid code duplication:
>>
>> int backlight_device_set_brightness(...) {
>>         return backlight_set_brightness(..., BACKLIGHT_UPDATE_SYSFS);
>> }
> 
> OK.

(note: this is only valid if you don't clamp in 
backlight_set_brightness, current code return -EINVAL if it is outside 
the range)

>>
>>>   /**
>>>    * backlight_register_notifier - get notified of backlight 
>>> (un)registration
>>>    * @nb: notifier block with the notifier to call on backlight 
>>> (un)registration
>>> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
>>> index d905173c7f73c..7e4fee65fddd9 100644
>>> --- a/include/linux/backlight.h
>>> +++ b/include/linux/backlight.h
>>> @@ -429,6 +429,22 @@ static inline void 
>>> backlight_notify_blank_all(struct device *display_dev,
>>>   { }
>>>   #endif
>>>
>>> +struct backlight_device *backlight_device_lookup(const char *name);
>>> +void backlight_set_brightness(struct backlight_device *bd, unsigned 
>>> int value,
>>> +                           enum backlight_update_reason reason);
>>> +
>>> +static inline void backlight_device_ref(struct backlight_device *bd)
>>> +{
>>> +     if (bd)
>>> +             get_device(&bd->dev);
>>> +}
>>> +
>>> +static inline void backlight_device_unref(struct backlight_device *bd)
>>> +{
>>> +     if (bd)
>>> +             put_device(&bd->dev);
>>> +}
>>> +
>> Most of the kernel use _put and _get functions, I think it could be nice
>> to keep the same naming.
> 
> OK.
> 

