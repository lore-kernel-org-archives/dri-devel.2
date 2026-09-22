Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594D9C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613E010E3F8;
	Tue, 22 Sep 2026 12:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="yBG74wlv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="inL/amZd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fAd/pp9J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G4Z6tJBy";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF3E89DA9;
 Tue, 22 Sep 2026 12:23:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83B5E1FB5D;
 Tue, 22 Sep 2026 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790079803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lvKlOCqZMbqn6LWSZQqs6CKgHMgQ7e2lx3beQ5aW97A=;
 b=yBG74wlvSXIh9kx6mg1LeemTkuEMvH+OcYr+STuGXCHvNq0E2tUbYXrLyULj+aLrDe4KGY
 K0KV8j1QkUM+71TYY+2U/LwlgIYpINMNO5Fyr30XLUof3vmpKKRmP0R/7pQv6GCzEetqGg
 CUuDObJVc2UMBSdDSwk12NitZVcSF30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790079803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lvKlOCqZMbqn6LWSZQqs6CKgHMgQ7e2lx3beQ5aW97A=;
 b=inL/amZdyllB6xcE0kNv3UU6/3+bVcwEE/J893QEkCoIfnjYPoZ5dbBe3TI9Q2PS32lJ4H
 61I6BzbZe252eLBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="fAd/pp9J";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G4Z6tJBy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790079799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lvKlOCqZMbqn6LWSZQqs6CKgHMgQ7e2lx3beQ5aW97A=;
 b=fAd/pp9JJcBRM4+Ufz3HY5A2q2toMvXa8Q1WdYN2c8tMTSbX3lKjY7Wr2/jc4c7y8UEEZu
 o1GwMKFepG5FZCTbgtakohNE3mmJ3W39idK7+j0Xaf1zL/FG/cbYk5SvIqoArDW4lLLtvY
 6Nnr0uxTr2S1hmauDZ4UkIzMgwyWpyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790079799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lvKlOCqZMbqn6LWSZQqs6CKgHMgQ7e2lx3beQ5aW97A=;
 b=G4Z6tJBymGwuWoZZC7g4Yfi13gjCyiv+1U4WDE6ufFrQ82Z5GSHrQ29zW64+Q7Zf+tAImv
 c4eIt+HIcopbdoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6BF9136D9;
 Tue, 22 Sep 2026 12:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4HK6IjZzsmrmKwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 22 Sep 2026 12:23:18 +0000
Message-ID: <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de>
Date: Tue, 22 Sep 2026 14:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
To: Maxime Ripard <mripard@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
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
In-Reply-To: <arJwOSq6-oSywTK6@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 83B5E1FB5D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,lists.freedesktop.org,amd.com,ffwll.ch,linux.intel.com,gmail.com,kernel.org];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, suse.de:dkim, suse.de:mid,
 amd.com:email]
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

Am 22.09.26 um 14:16 schrieb Maxime Ripard:
> On Tue, Sep 22, 2026 at 06:41:32AM -0500, Mario Limonciello wrote:
>>
>> On 9/22/26 03:33, Javier Martinez Canillas wrote:
>>> Hello Mario,
>>>
>>> On Tue, Sep 8, 2026 at 6:41 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>> At Display Next Hackfest 2026 we reviewed progress moving brightness
>>>> control into the DRM connector properties.
>>>>
>>>> There is a range LUMINANCE property that will default to 0->0.
>>>> Once a driver attaches a backlight it will be updated to 1->max.
>>>> If the panel supports the minimum backlight turning off the display
>>>> the range can later be updated to 0->max instead of 1->max.
>>>>
>>>> The legacy sysfs interface is synchronized with the DRM connector.
>>>> When a compositor using this feature is loaded, sysfs writes are disabled
>>>> to prevent legacy tools from going out of sync with the compositor.
>>>>
>>> I don't think I agree with the direction of this series. The main
>>> issue for me is that if the sysfs interface is disabled, then I don't
>>> understand the value of doing all the hops between the DRM and
>>> backlight subsystems...
>> The reason for all the hops is that users can switch between compositors
>> that support this and don't.  If you're in a compositor that supports it
>> that compositor will want to affirm it's in control.  If you're in a
>> compositor without support then you should still have a way to change
>> things, and that's what the sysfs interface exists for.
> Couldn't we make a sysfs write trigger an atomic commit then? That way,
> it would always go through the atomic commit path, no matter whether
> you're on a "legacy" compositor or not.
>
> It would also somewhat untangle the uapi from the backlight subsystem,
> because it's only really relevant for panels. For all the other use
> cases, you might want to control the brightness but you have no matching
> backlight device.

I suggested to treat these backlight changes like display-hotplug 
events. When it happens, we'd send a uevent to user space, so it can 
update its internal state.  Such an event could then come from any 
source besides backlight's sysfs.   Compositors could also implement 
policies that are currently implicit in this series, such as brightness 
of 0 means "display off".  This is likely something a compositor should 
track.

Would that work?

Best regards
Thomas


>
>>> IMO when a driver sets the DRIVER_CONNECTOR_LUMINANCE feature and the
>>> client advertise the DRM_CLIENT_CAP_LUMINANCE capability, then the DRM
>>> driver should be in full control of the brightness control and not go
>>> through the backlight subsystem at all.
>> OK but so let's say I start at 100% brightness.  I open up Kwin, I change
>> the luminance property to 0%.  Let's pretend that backlight subsystem
>> doesn't get updated.
>>
>> Then I log into Xorg + Xfce.  The luminance property should be left at 0%,
>> the brightness subsystem is 100%.
> Make backlight read the current property then.
>
> The way I see it, you're trying to untangle multiple issues at once, and
> I'm not sure it's the best strategy here. I'd start with the luminance
> property itself that wouldn't involve the backlight framework itself
> (DDC/CI or MIPI-DCS sound like obvious candidates here), and once it's
> in, I would figure out the relationship between backlight and that property.
>
> Maxime

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


