Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4AFCD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE6A10E472;
	Tue, 26 May 2026 07:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="drbPsgR/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cOFoouFl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="drbPsgR/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cOFoouFl";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D2B10E472
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:59:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08B7F6AA8A;
 Tue, 26 May 2026 07:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779782347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bx0lurtaN52QrUYB6xJ2wqH5K2DGxqm0pYsgrAvMCeg=;
 b=drbPsgR/CfBK48nm4MF1tZGN1JiKM+JXZvT/Z34IKTQAdtOTk3nh+a4OIw+g5+swNfTXBS
 a5udVYQiY9jTDj6oMup/VTETIpqdWNtrm94NUm4jqAqan9jzitEkMi5OcbhxiOgiC6QvZa
 VS0KfhivjQlPNJq6RumUQ5oVAFnI8R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779782347;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bx0lurtaN52QrUYB6xJ2wqH5K2DGxqm0pYsgrAvMCeg=;
 b=cOFoouFlCsv1EWpWBYRSGYSXFBX0swRMKaVEBkRh604k41Nbkdd1Utc2GkEVZh4plKbC/G
 c6cqpR9J5cT43iDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779782347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bx0lurtaN52QrUYB6xJ2wqH5K2DGxqm0pYsgrAvMCeg=;
 b=drbPsgR/CfBK48nm4MF1tZGN1JiKM+JXZvT/Z34IKTQAdtOTk3nh+a4OIw+g5+swNfTXBS
 a5udVYQiY9jTDj6oMup/VTETIpqdWNtrm94NUm4jqAqan9jzitEkMi5OcbhxiOgiC6QvZa
 VS0KfhivjQlPNJq6RumUQ5oVAFnI8R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779782347;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bx0lurtaN52QrUYB6xJ2wqH5K2DGxqm0pYsgrAvMCeg=;
 b=cOFoouFlCsv1EWpWBYRSGYSXFBX0swRMKaVEBkRh604k41Nbkdd1Utc2GkEVZh4plKbC/G
 c6cqpR9J5cT43iDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE2015A0D1;
 Tue, 26 May 2026 07:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3dmVKMpSFWouJgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 26 May 2026 07:59:06 +0000
Message-ID: <fbaaa197-bf04-4047-8e4e-88a60880f36a@suse.de>
Date: Tue, 26 May 2026 09:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, stable@vger.kernel.org
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de> <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de> <ahCw9zakihaGHLsN@intel.com>
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
In-Reply-To: <ahCw9zakihaGHLsN@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org,icenowy.me];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 internal_greylist_whitelist(0.00)[10.150.64.97];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:mid]
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

Am 22.05.26 um 21:39 schrieb Ville Syrjälä:
> On Fri, May 22, 2026 at 03:43:26PM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 22.05.26 um 15:28 schrieb Ville Syrjälä:
>> [...]
>>>>>> But why does your HW use CRTC 1 in the first place.
>>>>> Could be eg. the enabled outputs can't be driven with CRTC 0.
>>>>>
>>>>> I guess what you want to do is pick the first crtc from modesets[]
>>>>> which is enabled. Or perhaps even "pick the Nth enabled crtc from
>>>>> modesets[] based on the ioctl argument".
>>>> The enable-status of each CRTC could change later on, which might lead
>>>> to problems.
>>> Sound like a locking issue if someone is changing the configuration
>>> at the same time we're trying to do the vblank wait here.
>> I mean that the connected outputs could change at a later point or we
>> could have multiple CRTCs in use. Today, someone in #intel-gfx reported
>> a problem with panning if multiple CRTCs are in use.
>>
>> Therefore picking a CRTC freely could be a problem. Let's say we
>> configure modes from one CRTC, but later wait/pan/flush with another
>> CRTC. I would not trust this to work correctly.
>>
>> Hence, my suggestion is to select a primary CRTC during the fbdev
>> client's probe and use it for all later operations until the next probe
>> happens.  All other CRTCs would mirror the primary one.
> Actual mirroring may not be possible due to different modes supported
> on each output. The whole multi-output fbdev thing in the drm fb helper
> is kind of a hack that's rather hard to make work 100% sensibly.

I know, but we have to support it to some extent. The current mirroring 
logic at least works, except that it assumes CRTC 0 to be present.

Best regards
Thomas

>
> For the panning possibly the only sensible thing is to use the max of
> hdisplay/vdisplay of all the crtcs as the xres/yres so it's clear
> how much things can actually be panned. Oh and tiled displays (assuming
> we would actually want the fbdev stuff to tile correctly) make the
> situation even more complicated. I think the current support for tiled
> displays in the fb helper is semi-busted.
>
>> Best regards
>> Thomas
>>
>>
>>>> Picking the one CRTC/output with the lowest spec and
>>>> mirroring it to the others might work. This CRTC would then be the one
>>>> to wait for.
>>>>
>>>> Best regards
>>>> Thomas
>>>>
>>>> -- 
>>>> --
>>>> Thomas Zimmermann
>>>> Graphics Driver Developer
>>>> SUSE Software Solutions Germany GmbH
>>>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>>>> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
>>>>
>> -- 
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


