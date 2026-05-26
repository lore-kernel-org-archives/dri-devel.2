Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9219DCD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C1D10E45B;
	Tue, 26 May 2026 07:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="pxONxFnV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="423ZpdgY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ca4benR3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wTMXG0xn";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D1A10E45B
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:25:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BB3C65443;
 Tue, 26 May 2026 07:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779780338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vbopPMUAcDk7jLhilmYVg0dGzzmpzpAxF4hYZz7NYRM=;
 b=pxONxFnVbulMHn5Y6V2sHm+sTznAE0SstZoQBz0jByCjjDh8naiR1HzjD02lMQV9WTdLEK
 hmtQh6EbPnn/zrLMpXjPV8AvkX980wCiqDLkrWTFXrlUH648fW0wd0BbTytRxndUssPf2E
 0qG2yWgAMfeux3Cb7oW7647wLRezxoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779780338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vbopPMUAcDk7jLhilmYVg0dGzzmpzpAxF4hYZz7NYRM=;
 b=423ZpdgY19uNmHhgX84wNO9yS7iFotUmDFhS+TAUmtZL5xlo8RjNft2O1HxNN2eMQIPDdt
 xtBdlctJS+54viBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ca4benR3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wTMXG0xn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779780337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vbopPMUAcDk7jLhilmYVg0dGzzmpzpAxF4hYZz7NYRM=;
 b=Ca4benR3XC6eqbXaPAmkWHqrlwLdcKyEc+n/3MT3mf5n6XG6zKv1ZJqPerajkj3Suy7tts
 So+twlh3+nj0r5DVz+iVWZK+kmKiwxmjrslSf8Jr7+cAKHLGaImAvn6rJSOmFyLiFf+AQE
 Yko0vgiT/1WgekTl2sKuklJdblMZK9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779780337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vbopPMUAcDk7jLhilmYVg0dGzzmpzpAxF4hYZz7NYRM=;
 b=wTMXG0xnv1TUiYjLZz7CnWpwNZ6xbzTNONpqfzuwX41ciCODpV8v5VFKBA0BMGe3XwBjpq
 vLovYNlw6FJxUKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3E265A0AF;
 Tue, 26 May 2026 07:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bvY6MvBKFWpDBQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 26 May 2026 07:25:36 +0000
Message-ID: <07a05f2e-c015-48e0-b942-9b3f0c63858c@suse.de>
Date: Tue, 26 May 2026 09:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in
 helper
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: deller@gmx.de, simona@ffwll.ch, airlied@gmail.com, lukas@wunner.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260522123019.211059-1-tzimmermann@suse.de>
 <20260522123019.211059-4-tzimmermann@suse.de>
 <CAMuHMdXKF=fSZLqQiOuxDvygBDVSZKD+CQ3Rj+R4E_rYrz-WtA@mail.gmail.com>
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
In-Reply-To: <CAMuHMdXKF=fSZLqQiOuxDvygBDVSZKD+CQ3Rj+R4E_rYrz-WtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BB3C65443
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmx.de,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org,lists.freedesktop.org,vger.kernel.org,lists.ozlabs.org];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 internal_greylist_whitelist(0.00)[2a07:de40:b281:104:10:150:64:97];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, suse.de:email, suse.de:mid,
 suse.de:dkim]
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

Hi Geert

Am 25.05.26 um 11:31 schrieb Geert Uytterhoeven:
> Hi Thomas,
>
> On Fri, 22 May 2026 at 15:11, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
>> invokes this functionality before switching physical outputs to a new
>> graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
>> implementation details.
>>
>> Vga-switcheroo is used for switching physical outputs among graphics
>> hardware. This functionality is only supported by DRM drivers. A later
>> update will further move fb_switch_output() into DRM's fbdev emulation;
>> thus fully decoupling vga-switcheroo from fbdev.
>>
>> v2:
>> - use '#if defined' (Helge)
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Thanks for your patch, which is now commit 91458b3f2a84bc7b ("fbdev:
> Wrap fbcon updates from vga-switcheroo in helper") in fbdev/for-next.
>
>> --- a/drivers/gpu/vga/vga_switcheroo.c
>> +++ b/drivers/gpu/vga/vga_switcheroo.c
>> @@ -31,11 +31,9 @@
>>   #define pr_fmt(fmt) "vga_switcheroo: " fmt
>>
>>   #include <linux/apple-gmux.h>
>> -#include <linux/console.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/fb.h>
>>   #include <linux/fs.h>
>> -#include <linux/fbcon.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>>   #include <linux/pm_domain.h>
>> @@ -735,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
>>          if (!active->driver_power_control)
>>                  set_audio_state(active->id, VGA_SWITCHEROO_OFF);
>>
>> +#if defined(CONFIG_FB)
>>          if (new_client->fb_info)
>> -               fbcon_remap_all(new_client->fb_info);
>> +               fb_switch_outputs(new_client->fb_info);
>> +#endif
> What if CONFIG_FB is modular?
> CONFIG_VGA_SWITCHEROO is bool.

Good point. Fbcon is currently linked into fb.ko, which is build with 
CONFIG_FB.  Kconfig covers this dependency at [1]. For now, I think we 
could make it 'depends on FB=y'.  As I mentioned elsewhere, this 
fb-related logic is only relevant for DRM and supposed to be moved there 
soon.  That will also resolve any such config issues.

Let me prepare an update for this.

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v7.0.9/source/drivers/gpu/vga/Kconfig#L7

>
>>          mutex_lock(&vgasr_priv.mux_hw_lock);
>>          ret = vgasr_priv.handler->switchto(new_client->id);
> Gr{oetje,eeting}s,
>
>                          Geert
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


