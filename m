Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06152606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=O9BXcHzM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HLGMGUA8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=O9BXcHzM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HLGMGUA8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B23310E889;
	Thu, 26 Nov 2026 09:54:40 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0453010E889
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:54:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 339AE22780;
 Thu, 26 Nov 2026 09:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795686867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QenZ8YvSWTF9Tgw3lW7F/FgP3vciOBQFZTK4/U065X8=;
 b=O9BXcHzMphuVpZ2Wv19qyEju7P3lbOGNlvG+bmB4p7YF3uBPZwJPVAo5srTpmFUdPDfOma
 xg4kykYWNyXKUaBKGPv9GYTkhp2Iwe7BFFrGbgKEbxwuHfsh4NETWaWUtRDFWeAZ82ZQrY
 zPytpBtpStWrRSJpN2sgpnIu4PmARNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795686867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QenZ8YvSWTF9Tgw3lW7F/FgP3vciOBQFZTK4/U065X8=;
 b=HLGMGUA8ZGSR/1AAhfsSollqWtO6QX/x9Vd3H09lvjNxjgJ1drm5r61/yu4Dm14TrrFw+I
 O76g2pedCz+9RMBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795686867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QenZ8YvSWTF9Tgw3lW7F/FgP3vciOBQFZTK4/U065X8=;
 b=O9BXcHzMphuVpZ2Wv19qyEju7P3lbOGNlvG+bmB4p7YF3uBPZwJPVAo5srTpmFUdPDfOma
 xg4kykYWNyXKUaBKGPv9GYTkhp2Iwe7BFFrGbgKEbxwuHfsh4NETWaWUtRDFWeAZ82ZQrY
 zPytpBtpStWrRSJpN2sgpnIu4PmARNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795686867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QenZ8YvSWTF9Tgw3lW7F/FgP3vciOBQFZTK4/U065X8=;
 b=HLGMGUA8ZGSR/1AAhfsSollqWtO6QX/x9Vd3H09lvjNxjgJ1drm5r61/yu4Dm14TrrFw+I
 O76g2pedCz+9RMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB738134C3;
 Thu, 26 Nov 2026 09:54:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6sNTItIBCGvDfgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 26 Nov 2026 09:54:26 +0000
Message-ID: <e9d6ae3e-585b-4240-8f07-8c06911d83cd@suse.de>
Date: Thu, 26 Nov 2026 10:54:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/log: Add an automatic integer scaling
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261124224408.728354-1-jfalempe@redhat.com>
 <b5f237cf-582a-42f5-8ebc-c006ccecf62f@suse.de>
 <fe5485e4-c3fc-4f18-86b2-d37106876c47@redhat.com>
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
In-Reply-To: <fe5485e4-c3fc-4f18-86b2-d37106876c47@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_SEVEN(0.00)[8];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 26.11.26 um 10:02 schrieb Jocelyn Falempe:
> On 11/26/26 08:47, Thomas Zimmermann wrote:
>> Hi Jocelyn
>>
>> Am 24.11.26 um 23:42 schrieb Jocelyn Falempe:
>>> On HiDPI screen, the default font might be too small, so if no
>>> scaling is specified, try to upscale reasonably.
>>> The auto scaling is computed for each display.
>>>
>>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>>> ---
>>>   drivers/gpu/drm/clients/drm_log.c | 36 
>>> ++++++++++++++++++++-----------
>>>   1 file changed, 24 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/ 
>>> clients/drm_log.c
>>> index 4654091fe11a..7a0db2690b55 100644
>>> --- a/drivers/gpu/drm/clients/drm_log.c
>>> +++ b/drivers/gpu/drm/clients/drm_log.c
>>> @@ -25,9 +25,9 @@ MODULE_AUTHOR("Jocelyn Falempe");
>>>   MODULE_DESCRIPTION("DRM boot logger");
>>>   MODULE_LICENSE("GPL");
>>> -static unsigned int scale = 1;
>>> +static unsigned int scale = 0;
>>>   module_param(scale, uint, 0444);
>>> -MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, 
>>> default is 1");
>>> +MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, 
>>> default is 0 (auto)");
>>>   /**
>>>    * DOC: overview
>>> @@ -42,6 +42,7 @@ struct drm_log_scanout {
>>>       const struct font_desc *font;
>>>       u32 rows;
>>>       u32 columns;
>>> +    u32 scale;
>>>       u32 scaled_font_h;
>>>       u32 scaled_font_w;
>>>       u32 line;
>>> @@ -72,17 +73,17 @@ static struct drm_log *console_to_drm_log(struct 
>>> console *con)
>>>   static void drm_log_blit(struct iosys_map *dst, unsigned int 
>>> dst_pitch,
>>>                const u8 *src, unsigned int src_pitch,
>>> -             u32 height, u32 width, u32 px_width, u32 color)
>>> +             u32 height, u32 width, u32 blit_scale, u32 px_width, 
>>> u32 color)
>>>   {
>>>       switch (px_width) {
>>>       case 2:
>>> -        drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, 
>>> width, scale, color);
>>> +        drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, 
>>> width, blit_scale, color);
>>>           break;
>>>       case 3:
>>> -        drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, 
>>> width, scale, color);
>>> +        drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, 
>>> width, blit_scale, color);
>>>           break;
>>>       case 4:
>>> -        drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, 
>>> width, scale, color);
>>> +        drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, 
>>> width, blit_scale, color);
>>>           break;
>>>       default:
>>>           WARN_ONCE(1, "Can't blit with pixel width %d\n", px_width);
>>> @@ -122,7 +123,7 @@ static void drm_log_draw_line(struct 
>>> drm_log_scanout *scanout, const char *s,
>>>           if (src)
>>>               drm_log_blit(&map, fb->pitches[0], src, font_pitch,
>>>                        scanout->scaled_font_h, scanout->scaled_font_w,
>>> -                     px_width, color);
>>> +                     scanout->scale, px_width, color);
>>>           iosys_map_incr(&map, scanout->scaled_font_w * px_width);
>>>       }
>>> @@ -206,6 +207,15 @@ static u32 drm_log_find_usable_format(struct 
>>> drm_plane *plane)
>>>       return DRM_FORMAT_INVALID;
>>>   }
>>> +/* Find the biggest integer scaling to get about 120x50 chars on 
>>> the screen */
>>
>> Something like 80x30 (VGA mode 0x17) or 80x50 (VGA mode 0x102) seems 
>> natural. But what is the reason for 120x50?
>
> I think this was a good default with old 15" CRT at 640x480. But for 
> example for code line length, it's now configured in the 100-120 range 
> in most codebase.
> When looking at dmesg, a lot of lines are longer than 100, so 120 
> allows to avoid too much line splitting.
> For the number of rows, it's important to have some log history, so 50 
> looks to be the sweet spot.
> User can set a scaling manually, or build the kernel with bigger fonts 
> if they don't like the default.

Some general thoughts on this:

Each font is designed for it's specific glyph resolution. Therefore, I 
think it is a problem to scale x and y independent from each other. That 
can mess up the font. I'd suggest to make the output aim for a certain 
display height. Text runs from top to bottom and number of lines is 
usually what people care for most. OTOH the display's right side is 
usually empty.

I agree that the original VGA mode 0x17 is a bit short one lines. The 50 
lines you choose seem right to me. For the number of lines, I'd start 
with the current font and scale if the number of lines becomes too 
large. So that the resulting console has between 30 and 70 lines.

For the number of columns, why not pick the preferred number of columns 
in relation to the scaled font height and the display-mode resolution? 
That keeps the font geometry at a correct ratio.


I know all this is close to nitpicking and maybe the code does some of 
this already. I just think it's important to make it look good on a 
variety of displays.


>
> Currently, with 8x16 font (which is the most common), the default in 
> full HD is 240x67. In 4K it's 480x135. So doing some integer scaling 
> make the default experience much better.

Right, the current fonts are too small on modern displays.

Best regards
Thomas

>
> Best regards,
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


