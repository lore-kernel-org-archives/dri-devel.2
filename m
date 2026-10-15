Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F56CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B13E10EBA1;
	Thu, 15 Oct 2026 09:07:50 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCF410E5B1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:07:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 63D5F1F7EF;
 Thu, 15 Oct 2026 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792055257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lYMwZ+Fgmcnaf42YiU+5DZVFEVKAyChCqxQwFCkXZMo=;
 b=Ja1AfWLmCAw6sP/MnQ1FgDzoR2WsFZf8BL1FoKMyQ7WmH+A3PnMtbFxXBG3+sfLYCboiYt
 YpaoN5Mjc7CAhrQACR9lfypX1wkDdqYsa7gW0V+Pjx3JbIiFg51Al7SJ04XhCQYeaqHaOn
 OLj4W66dHzQbHFLuNBd+bA5dQdyBTkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792055257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lYMwZ+Fgmcnaf42YiU+5DZVFEVKAyChCqxQwFCkXZMo=;
 b=hZcuI2h02cm67XfwdUnfUAdodQahH2sPmTVf4zw63yTjO/yHa5+edMPcl0PJALdIHfqif+
 fM31BmklQK1ytJBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ja1AfWLm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hZcuI2h0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792055257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lYMwZ+Fgmcnaf42YiU+5DZVFEVKAyChCqxQwFCkXZMo=;
 b=Ja1AfWLmCAw6sP/MnQ1FgDzoR2WsFZf8BL1FoKMyQ7WmH+A3PnMtbFxXBG3+sfLYCboiYt
 YpaoN5Mjc7CAhrQACR9lfypX1wkDdqYsa7gW0V+Pjx3JbIiFg51Al7SJ04XhCQYeaqHaOn
 OLj4W66dHzQbHFLuNBd+bA5dQdyBTkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792055257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lYMwZ+Fgmcnaf42YiU+5DZVFEVKAyChCqxQwFCkXZMo=;
 b=hZcuI2h02cm67XfwdUnfUAdodQahH2sPmTVf4zw63yTjO/yHa5+edMPcl0PJALdIHfqif+
 fM31BmklQK1ytJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0AB7132C9;
 Thu, 15 Oct 2026 09:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f2L6G9iX0Gr4OAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 15 Oct 2026 09:07:36 +0000
Message-ID: <b8b52ffd-ecec-4fba-b432-ba32135c2f99@suse.de>
Date: Thu, 15 Oct 2026 11:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
To: Helge Deller <deller@gmx.de>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251003073210.48501-1-albinbabuvarghese20@gmail.com>
 <b4af6e84-6555-4629-8291-fc4c2c99390b@gmx.de>
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
In-Reply-To: <b4af6e84-6555-4629-8291-fc4c2c99390b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 63D5F1F7EF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; XM_UA_NO_VERSION(0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[gmx.de,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[48b0652a95834717f190];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, appspotmail.com:email,
 suse.de:dkim, gmx.de:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, syzkaller.appspot.com:url]
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

Am 04.10.25 um 02:43 schrieb Helge Deller:
> On 10/3/25 09:32, Albin Babu Varghese wrote:
>> Add bounds checking to prevent writes past framebuffer boundaries when
>> rendering text near screen edges. Return early if the Y position is 
>> off-screen
>> and clip image height to screen boundary. Break from the rendering 
>> loop if the
>> X position is off-screen. When clipping image width to fit the 
>> screen, update
>> the character count to match the clipped width to prevent buffer size
>> mismatches.
>>
>> Without the character count update, bit_putcs_aligned and 
>> bit_putcs_unaligned
>> receive mismatched parameters where the buffer is allocated for the 
>> clipped
>> width but cnt reflects the original larger count, causing 
>> out-of-bounds writes.
>>
>> Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
>> Suggested-by: Helge Deller <deller@gmx.de>
>> Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
>> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
>> ---
>> Changes in v2:
>> - Partially render when height exceeding screen boundaries instead of 
>> skipping
>> - Update character count when width is clipped to prevent buffer 
>> mismatch
>>
>> Link to v1:
>> https://lore.kernel.org/all/20250927075010.119671-1-albinbabuvarghese20@gmail.com/ 
>>
>> ---
>>   drivers/video/fbdev/core/bitblit.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>
> applied.

This patch mangles fbcon output on fbdev HW drivers. It's reproducible 
on matroxfb and sisfb. Reverting the change restores these driver's 
functionality.

Fbcon from within DRM's fbdev emulation works.

Best regards
Thomas


>
> Thanks!
> Helge
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


