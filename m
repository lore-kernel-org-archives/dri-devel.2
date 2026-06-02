Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7455AC5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFDF1138C9;
	Tue,  2 Jun 2026 08:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="B4spFSfX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LQYwXYrS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DLgsJnHg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eye2sUL/";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180291138C9
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 08:08:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D22166B136;
 Tue,  2 Jun 2026 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780387723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gOus7NhNkOME8Yo5HWIQ3dfsEcU1UnAU7H5bl0e/14w=;
 b=B4spFSfXgswEnTfhT+/sfMN3OxIWxKfRIwxSln0OKiZDbzJUx7hkrFnB4cLglDO9hGBbvQ
 IzK36v3eHA3G4Cj7fx/HdQbFOH4SC5GNO9GtOs60QyGoK8Ie3Hh6upwBXEvinRGAKntXNT
 ER6Gqce6BLccRco8+WQA22Hiy+M1+MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780387723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gOus7NhNkOME8Yo5HWIQ3dfsEcU1UnAU7H5bl0e/14w=;
 b=LQYwXYrS8Feqlnmv9CDGNyW6QSmKqr7sB0eX7ckU7jefhaLNCjZ5wu9IRLVpCyw2LvUnSI
 trmw7AefZq0VnXCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DLgsJnHg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="eye2sUL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780387722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gOus7NhNkOME8Yo5HWIQ3dfsEcU1UnAU7H5bl0e/14w=;
 b=DLgsJnHgWYiMEgKq8fNcd+1je7qzQ9bi5c5TbUwIZDoSErq9eLQ5rv1gN3z1EiDm5uQCr7
 rhsHjA6H+hwiF/v9CYWUDIA+znUinPU69IOIIyHOjOYb3NrAJ1hS+SmOqmpL4lmVMZhtNf
 2v67m77c8DxdkUrXagZUmsc6D76MNUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780387722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gOus7NhNkOME8Yo5HWIQ3dfsEcU1UnAU7H5bl0e/14w=;
 b=eye2sUL/vA0tKtKa6ZP6/tQ6D7HJzTsQc1sh83sKagUvZxi0uzlrmaa9Y5JvMjyts6Yb2v
 91zo2/iQoqF0F1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 515A1779A7;
 Tue,  2 Jun 2026 08:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zploEoePHmrqfAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 02 Jun 2026 08:08:39 +0000
Message-ID: <e45c05f9-be0e-4845-898e-5dc003387bdd@suse.de>
Date: Tue, 2 Jun 2026 10:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] lib/fonts: Look up glyph data with
 font_data_glyph_buf()
To: Jocelyn Falempe <jfalempe@redhat.com>, javierm@redhat.com, deller@gmx.de, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-2-tzimmermann@suse.de>
 <db9abca9-0174-46fc-8952-aaa23a4e4574@redhat.com>
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
In-Reply-To: <db9abca9-0174-46fc-8952-aaa23a4e4574@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D22166B136
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,gmx.de,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:email, suse.de:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Am 01.06.26 um 13:18 schrieb Jocelyn Falempe:
> On 29/05/2026 16:01, Thomas Zimmermann wrote:
>> Add font_data_glyph_buf() to retrieve a character's glyph data or NULL
>> otherwise. Console fonts can currently contain 256 or 512 glyphs. The
>> kernel-internal characters are of type char, unsigned short or unsigned
>> int. Catch all of them by accepting unsigned int. Callers possibly have
>> to cast from signed to unsigned types to reach all glyphs in a font.
>
> Thanks, yes I missed to check font_data_num_glyphs(), and using signed 
> index is also problematic.
>
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

Thanks for reviewing. I'll merge the series in a few days if no other 
comments come in.

Best regards
Thomas

>
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   include/linux/font.h |  3 +++
>>   lib/fonts/fonts.c    | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/include/linux/font.h b/include/linux/font.h
>> index 6845f02d739a..ea23b727388b 100644
>> --- a/include/linux/font.h
>> +++ b/include/linux/font.h
>> @@ -101,6 +101,9 @@ font_data_t *font_data_import(const struct 
>> console_font *font, unsigned int vpit
>>   void font_data_get(font_data_t *fd);
>>   bool font_data_put(font_data_t *fd);
>>   unsigned int font_data_size(font_data_t *fd);
>> +const unsigned char *font_data_glyph_buf(font_data_t *fd,
>> +                     unsigned int width, unsigned int vpitch,
>> +                     unsigned int c);
>>   bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
>>   int font_data_export(font_data_t *fd, struct console_font *font, 
>> unsigned int vpitch);
>>   diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
>> index f5d5333450a0..4fc66722d00d 100644
>> --- a/lib/fonts/fonts.c
>> +++ b/lib/fonts/fonts.c
>> @@ -178,6 +178,37 @@ unsigned int font_data_size(font_data_t *fd)
>>   }
>>   EXPORT_SYMBOL_GPL(font_data_size);
>>   +static unsigned int font_data_num_glyphs(font_data_t *fd, unsigned 
>> int width, unsigned int height)
>> +{
>> +    return font_data_size(fd) / font_glyph_size(width, height);
>> +}
>> +
>> +/**
>> + * font_data_glyph_buf() - Returns the glyph for a specific 
>> character as raw bytes
>> + * @fd: The font data
>> + * @width: The glyph width in bits per scanline
>> + * @vpitch: The number of scanlines per glyph
>> + * @c: The character
>> + *
>> + * Glyphs start at fixed intervals within the font data. 
>> font_data_glyph_buf()
>> + * returns the glyph shape of the specified character. If no such glyph
>> + * exists in the font, it returns NULL.
>> + *
>> + * Returns:
>> + * The character's raw glyph shape, or NULL if no glyph exists for 
>> the character. The
>> + * provided buffer is read-only.
>> + */
>> +const unsigned char *font_data_glyph_buf(font_data_t *fd,
>> +                     unsigned int width, unsigned int vpitch,
>> +                     unsigned int c)
>> +{
>> +    if (c >= font_data_num_glyphs(fd, width, vpitch))
>> +        return NULL;
>> +
>> +    return font_data_buf(fd) + font_glyph_size(width, vpitch) * c;
>> +}
>> +EXPORT_SYMBOL_GPL(font_data_glyph_buf);
>> +
>>   /**
>>    * font_data_is_equal - Compares font data for equality
>>    * @lhs: Left-hand side font data
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


