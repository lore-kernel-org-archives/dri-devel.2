Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06545C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E1C10E7FC;
	Wed, 23 Sep 2026 06:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1qb9cYVU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DEjC8Jjr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nntbtdpB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1YbdpLI";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCEE10E7FC;
 Wed, 23 Sep 2026 06:39:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95D931FF96;
 Wed, 23 Sep 2026 06:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790145578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u7bqTwSJmEvWNPTJ+CYWKcE6naWtiWULFOQAh79Rnms=;
 b=1qb9cYVUBh7M55OdALbTZEOdbQWXqPTgToPAboIeTu604V5f8nrIYPK2Z4bwNy5PMWE8Ck
 TOR/f7KQDIs1QZjq13gbT8RUPfd8qpFUOoumvtqdnMfJZqNo/4QeX+8RBnKjG9KE3tDCfx
 KFI7gdmklT9r3olowIQoyPtqz8YuyGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790145578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u7bqTwSJmEvWNPTJ+CYWKcE6naWtiWULFOQAh79Rnms=;
 b=DEjC8JjrULsPoe5Ct8B7jAeEW3PQgSCy24cr+6LEfdUlLLU0LRUYit8jqDPv4SKg8f2i7K
 IUPDGOLRJaRe8uDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790145574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u7bqTwSJmEvWNPTJ+CYWKcE6naWtiWULFOQAh79Rnms=;
 b=nntbtdpB1iUnkFoDECN75ToPyiTx9LRmctNvZ96qYeXMkZYIr/RxkSg29s7QT0HE/PovWC
 6GWvnk0uiFB/mdM72H1lr7DMUh0Wtd/uY0+ip6bo/DhFoiHAPTTBwzZGBfpglYIO1XGh8P
 F/qf+eieqqOamgt1jhex0SLk9jibtpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790145574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u7bqTwSJmEvWNPTJ+CYWKcE6naWtiWULFOQAh79Rnms=;
 b=t1YbdpLIB5B03wAN/kjLAQzdGojrfTO2EaTKE+WjOtaabDmODy5PIbOXjoAg3CqV1iByDr
 X9lNek0GClQk97CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF2C2139E9;
 Wed, 23 Sep 2026 06:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jDcQMyV0s2pKLwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 23 Sep 2026 06:39:33 +0000
Message-ID: <8727cba2-aa4d-4480-9b76-a9dedc57d8ee@suse.de>
Date: Wed, 23 Sep 2026 08:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
To: Maxime Ripard <mripard@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com> <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de> <arJ0huW356NjqpGR@houat>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <arJ0huW356NjqpGR@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[14];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[amd.com,redhat.com,lists.freedesktop.org,ffwll.ch,linux.intel.com,gmail.com,kernel.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, amd.com:email, suse.com:url,
 imap1.dmz-prg2.suse.org:helo]
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

Hi

Am 22.09.26 um 14:35 schrieb Maxime Ripard:
> On Tue, Sep 22, 2026 at 02:23:17PM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 22.09.26 um 14:16 schrieb Maxime Ripard:
>>> On Tue, Sep 22, 2026 at 06:41:32AM -0500, Mario Limonciello wrote:
>>>> On 9/22/26 03:33, Javier Martinez Canillas wrote:
>>>>> Hello Mario,
>>>>>
>>>>> On Tue, Sep 8, 2026 at 6:41 AM Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>> At Display Next Hackfest 2026 we reviewed progress moving brightness
>>>>>> control into the DRM connector properties.
>>>>>>
>>>>>> There is a range LUMINANCE property that will default to 0->0.
>>>>>> Once a driver attaches a backlight it will be updated to 1->max.
>>>>>> If the panel supports the minimum backlight turning off the display
>>>>>> the range can later be updated to 0->max instead of 1->max.
>>>>>>
>>>>>> The legacy sysfs interface is synchronized with the DRM connector.
>>>>>> When a compositor using this feature is loaded, sysfs writes are disabled
>>>>>> to prevent legacy tools from going out of sync with the compositor.
>>>>>>
>>>>> I don't think I agree with the direction of this series. The main
>>>>> issue for me is that if the sysfs interface is disabled, then I don't
>>>>> understand the value of doing all the hops between the DRM and
>>>>> backlight subsystems...
>>>> The reason for all the hops is that users can switch between compositors
>>>> that support this and don't.  If you're in a compositor that supports it
>>>> that compositor will want to affirm it's in control.  If you're in a
>>>> compositor without support then you should still have a way to change
>>>> things, and that's what the sysfs interface exists for.
>>> Couldn't we make a sysfs write trigger an atomic commit then? That way,
>>> it would always go through the atomic commit path, no matter whether
>>> you're on a "legacy" compositor or not.
>>>
>>> It would also somewhat untangle the uapi from the backlight subsystem,
>>> because it's only really relevant for panels. For all the other use
>>> cases, you might want to control the brightness but you have no matching
>>> backlight device.
>> I suggested to treat these backlight changes like display-hotplug events.
>> When it happens, we'd send a uevent to user space, so it can update its
>> internal state.  Such an event could then come from any source besides
>> backlight's sysfs.   Compositors could also implement policies that are
>> currently implicit in this series, such as brightness of 0 means "display
>> off".  This is likely something a compositor should track.
>>
>> Would that work?
> It probably would, but it would create a precedent I'm not really
> familiar with. Hotplug events are kind of separate because it really is
> a hardware event most of the time: you get an interrupt, and report it
> to userspace. And it's largely outside of the properties space (except
> maybe for things like edid).
>
> If we start having the argument that a property changing must trigger a
> uevent, then it means that we can expect *any* property to do so, and
> "the compositor needs to be in control of it" can apply to many, like
> color formats, positions, tiling, etc.

I'd explicitly not treat this like a change to the DRM property. More 
like as if the user pressed a hardware button. The property update only 
comes later from what ever the compositor does with the event.

Best regards
Thomas

>
> It would be a much saner design to put it behind DRM_MASTER, and
> deprecate the sysfs interface entirely.
>
> Maxime

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


