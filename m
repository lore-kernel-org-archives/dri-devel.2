Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958EDC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B126910F0B8;
	Thu, 27 Aug 2026 14:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RfNgf9YI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DKiqoyjk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fSBCyOpL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cPePCkT2";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA0810F0B8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:44:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1EA31F854;
 Thu, 27 Aug 2026 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787841857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xfdt9NuC3X1wEU8idm0OQAVUYE0XtkUGS6bU1nGq/iI=;
 b=RfNgf9YIsa9KxC38fRXNaAI3N2c47cOEvEhl9dr+Ne3eX0FhjKxDfTaZL6qsJ9PF+wsILq
 QGCXaYbxawOOcFr75/oacM1Mo7FEdwPnBv9Ic1IBFwDjltw7ITqldrhVW0RgseUIWxdHmz
 aaMCxxDShjeq6p/Y1kLsDYqN50oMD+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787841857;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xfdt9NuC3X1wEU8idm0OQAVUYE0XtkUGS6bU1nGq/iI=;
 b=DKiqoyjk7elnZApU+yVkjHAXmz+CDqW4SeVSr0kDXj6JjCRf8X+P4Rlt46KA7tySIti/Dp
 WT0pRYGt8YaWdjBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fSBCyOpL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cPePCkT2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787841853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xfdt9NuC3X1wEU8idm0OQAVUYE0XtkUGS6bU1nGq/iI=;
 b=fSBCyOpLfN7tieZbkj8eR2ZHj68O06bKRXojlNTcdsiA/1jEoKtSD01ZZRjVUdnfOLWL/A
 KenEuqO1+zNlZKFGI+Q5/tSrcgTcc99r6w4/hhra+pJN4HHZwsHe3XI73e9OBwrTtyYs3k
 L+7knFMZsrLCb/K1nX37zJz+83cQoyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787841853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xfdt9NuC3X1wEU8idm0OQAVUYE0XtkUGS6bU1nGq/iI=;
 b=cPePCkT25V+zw08qFXwMEHztIQYruUYtcyjAdrtoqMwPWklRHgd9vkcu/iI6pl5s9A3FVD
 J8wljhx5dZDwphCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA9D01352C;
 Thu, 27 Aug 2026 14:44:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iqECKD1NkGreOQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 14:44:13 +0000
Message-ID: <eca20b6f-0f46-47c1-b6c7-5c906b23b7d6@suse.de>
Date: Thu, 27 Aug 2026 16:44:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/sysfb: Use preferred panel size for panel
 orientation quirks
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260827140726.420734-1-tzimmermann@suse.de>
 <20260827140726.420734-3-tzimmermann@suse.de>
 <20260827142139.E0D121F00A3A@smtp.kernel.org>
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
In-Reply-To: <20260827142139.E0D121F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C1EA31F854
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
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



Am 27.08.26 um 16:21 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] The sysfb drivers parse unvalidated EDID data to extract the preferred size.

If we read bogus values, the panel orientation could be wrong. Nothing 
worse happens.  Apart from that, most drivers call 
drm_edid_header_is_valid(). I'll add this call to ofdrm, which is 
currently missing it.
>
> Pre-existing issues:
> - [High] drm_edid_get_preferred_size() incorrectly checks the value pointed to by width/height instead of validating the pointers themselves.

That's just fallout from the typo in patch 1.

> --
>
> commit df008c5490e15b30036ebe81983d7a6c0c6e5b33
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/sysfb: Use preferred panel size for panel orientation quirks
>
> Sysfb drivers currently use the given display mode for looking up the
> panel orientation. But the look-up table stores the native geometry of
> the panels, so the lookup fails if the current mode sizes differs.
>
> Get the panel's native geometry with drm_edid_get_preferred_size() from
> the EDID and use it for looking up the panel orientation.
>
>> diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
>> index 3f9cd5d03efb2..7a7d12003304f 100644
>> --- a/drivers/gpu/drm/sysfb/efidrm.c
>> +++ b/drivers/gpu/drm/sysfb/efidrm.c
> [ ... ]
>> @@ -217,6 +218,20 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
>>   	if (drm_edid_header_is_valid(dpy->edid.dummy) == 8)
>>   		sysfb->edid = dpy->edid.dummy;
>>   #endif
>> +
>> +	panel_width = width;
>> +	panel_height = height;
>> +
>> +	if (sysfb->edid) {
>> +		const struct drm_edid *drm_edid;
>> +
>> +		drm_edid = drm_edid_alloc(sysfb->edid, EDID_LENGTH);
>> +		if (drm_edid) {
>> +			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);
> [Severity: High]
> This isn't a bug introduced by this patch, but I wanted to ask about the
> semantics of drm_edid_get_preferred_size(). In drivers/gpu/drm/drm_edid.c,
> it does:
>
> 	if (*width)
> 		*width = (pt->hactive_hblank_hi & 0xf0) << 4 | pt->hactive_lo;
> 	if (*height)
> 		*height = (pt->vactive_vblank_hi & 0xf0) << 4 | pt->vactive_lo;
>
> This incorrectly checks the values pointed to by width/height instead of
> validating the pointers themselves. A caller passing a NULL pointer for
> either width or height will cause a kernel panic (NULL pointer dereference).
>
> Furthermore, passing a pointer to a zero-initialized variable evaluates to
> false, causing the function to silently skip populating the preferred size.
> While this patch bypasses the crash by passing non-NULL pointers initialized
> to >0, is it worth fixing the generic API so other callers do not trip over
> this?
>
> [Severity: Medium]
> Does parsing an unvalidated EDID block pose a risk here? The sysfb drivers
> parse unvalidated EDID data to extract the preferred size.
>
> If the firmware provides a corrupted EDID where only the 8-byte header is
> valid, this code extracts geometry from potentially corrupted firmware data,
> which can result in bogus resolutions being passed to the panel orientation
> quirk lookup.
>
>> +			drm_edid_free(drm_edid);
>> +		}
>> +	}
>> +
> [ ... ]
>> diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
>> index 819aed466727e..6cf2440d7d9e2 100644
>> --- a/drivers/gpu/drm/sysfb/ofdrm.c
>> +++ b/drivers/gpu/drm/sysfb/ofdrm.c
> [ ... ]
>> @@ -994,6 +995,19 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
>>   		sysfb->fb_gamma_lut_size = OFDRM_GAMMA_LUT_SIZE;
>>   	sysfb->edid = edid;
>>   
>> +	panel_width = width;
>> +	panel_height = height;
>> +
>> +	if (sysfb->edid) {
>> +		const struct drm_edid *drm_edid;
>> +
>> +		drm_edid = drm_edid_alloc(sysfb->edid, EDID_LENGTH);
>> +		if (drm_edid) {
>> +			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);
> [Severity: Medium]
> Similarly here in ofdrm_device_create(), unvalidated EDID data is parsed.
> Could this lead to bogus geometry being extracted from a corrupted EDID?
>
>> +			drm_edid_free(drm_edid);
>> +		}
>> +	}
>> +
> [ ... ]
>> diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
>> index 6a67b2d2e451b..8c52bbac6d2ff 100644
>> --- a/drivers/gpu/drm/sysfb/vesadrm.c
>> +++ b/drivers/gpu/drm/sysfb/vesadrm.c
> [ ... ]
>> @@ -484,6 +485,20 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
>>   	if (drm_edid_header_is_valid(dpy->edid.dummy) == 8)
>>   		sysfb->edid = dpy->edid.dummy;
>>   #endif
>> +
>> +	panel_width = width;
>> +	panel_height = height;
>> +
>> +	if (sysfb->edid) {
>> +		const struct drm_edid *drm_edid;
>> +
>> +		drm_edid = drm_edid_alloc(sysfb->edid, EDID_LENGTH);
>> +		if (drm_edid) {
>> +			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);
> [Severity: Medium]
> Likewise in vesadrm_device_create(), parsing unvalidated EDID data may
> result in bogus resolutions being passed to the panel orientation quirk
> lookup. Should the EDID be fully validated first?
>
>> +			drm_edid_free(drm_edid);
>> +		}
>> +	}
>> +

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


