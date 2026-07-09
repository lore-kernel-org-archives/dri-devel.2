Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED582C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D5B10E9DE;
	Thu,  9 Jul 2026 10:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="qYMB4Rg/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I0+b0een";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qYMB4Rg/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I0+b0een";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E6D10E9DE
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:38:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 84B9475DE2;
 Thu,  9 Jul 2026 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783593514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L493yZbr3FFd10kdHky1d7DoWV2+T+AsELyPBhE49So=;
 b=qYMB4Rg/E/PGQh8R7sJE21IYhsHhKCMd+WRMPu9r4D5Ud7iQNdAVCDFXQpQRSmSJhAvLxq
 mUZj4055sud8qZTUSx7Tujm9nZ5DIJimtwog7Sa4H6eq9yJt5gpr0AflcO2PeCMedqcbQ4
 +wyz7LfXrBOoUGlHaKyG3Plh5vn77cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783593514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L493yZbr3FFd10kdHky1d7DoWV2+T+AsELyPBhE49So=;
 b=I0+b0eenEVSuA3Vw6T8MnCoCIsofGZhD0yjpq/oKa+tPHEqEAoBMUUY5YCC8DmorPiq/rA
 on2lhCZOaRzlBGDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qYMB4Rg/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I0+b0een
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783593514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L493yZbr3FFd10kdHky1d7DoWV2+T+AsELyPBhE49So=;
 b=qYMB4Rg/E/PGQh8R7sJE21IYhsHhKCMd+WRMPu9r4D5Ud7iQNdAVCDFXQpQRSmSJhAvLxq
 mUZj4055sud8qZTUSx7Tujm9nZ5DIJimtwog7Sa4H6eq9yJt5gpr0AflcO2PeCMedqcbQ4
 +wyz7LfXrBOoUGlHaKyG3Plh5vn77cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783593514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L493yZbr3FFd10kdHky1d7DoWV2+T+AsELyPBhE49So=;
 b=I0+b0eenEVSuA3Vw6T8MnCoCIsofGZhD0yjpq/oKa+tPHEqEAoBMUUY5YCC8DmorPiq/rA
 on2lhCZOaRzlBGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65FC7779AA;
 Thu,  9 Jul 2026 10:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id woyfFip6T2pSBwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 09 Jul 2026 10:38:34 +0000
Message-ID: <5408cc9a-fca1-4af4-a915-f55290bfa02c@suse.de>
Date: Thu, 9 Jul 2026 12:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm: Implement struct
 vga_switcheroo_client_ops.pre_switch
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260709092215.168172-1-tzimmermann@suse.de>
 <20260709092215.168172-6-tzimmermann@suse.de>
 <20260709093629.4FF0E1F000E9@smtp.kernel.org>
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
In-Reply-To: <20260709093629.4FF0E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 84B9475DE2
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:url];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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



Am 09.07.26 um 11:36 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] `vga_switcheroo_client_fb_set()` and the `fb_info` field in `struct vga_switcheroo_client` are orphaned and remain as dead code.

Patch 7 cleans them up.

> --
>
> --- Patch [5]: [PATCH v2 5/7] drm: Implement struct vga_switcheroo_client_ops.pre_switch ---
> commit d5ba75db20f40c6dde86b90da7c25acad6f23b57
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm: Implement struct vga_switcheroo_client_ops.pre_switch
>
> This commit implements the pre_switch callback for vga_switcheroo in amdgpu,
> i915, nouveau, and radeon drivers. It pushes fbcon updates from vga_switcheroo
> into DRM's fbdev emulation and removes calls to vga_switcheroo_client_fb_set()
> from fbcon to prevent deadlocks.
>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index 9f5c4c101581d..974c7dcf52514 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
> [ ... ]
>> @@ -2987,10 +2983,6 @@ static int do_fb_registered(struct fb_info *info)
>>   		}
>>   	}
>>   
>> -	/* Set the fb info for vga_switcheroo clients. Does nothing otherwise. */
>> -	if (info->device && dev_is_pci(info->device))
>> -		vga_switcheroo_client_fb_set(to_pci_dev(info->device), info);
>> -
> [Severity: Low]
> With the removal of these calls from fbcon, are there any remaining users of
> vga_switcheroo_client_fb_set()?
>
> It looks like the exported function in drivers/gpu/vga/vga_switcheroo.c is
> now completely unused:
>
> void vga_switcheroo_client_fb_set(struct pci_dev *pdev,
> 				 struct fb_info *info)
> {
> 	struct vga_switcheroo_client *client;
>
> 	mutex_lock(&vgasr_mutex);
> 	client = find_client_from_pci(&vgasr_priv.clients, pdev);
> 	if (client)
> 		client->fb_info = info;
> 	mutex_unlock(&vgasr_mutex);
> }
> EXPORT_SYMBOL(vga_switcheroo_client_fb_set);
>
> Because client->fb_info is never populated, does this also leave dead code
> in vga_switchto_stage2() where it checks for the fallback?
>
> #if defined(CONFIG_FB)
> 	else if (new_client->fb_info)
> 		fb_switch_outputs(new_client->fb_info);
> #endif
>
> Would it make sense to remove the orphaned vga_switcheroo_client_fb_set()
> function, the fb_info field in struct vga_switcheroo_client, and the
> unreachable fallback block to complete the cleanup?
>
>>   	return ret;
>>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


