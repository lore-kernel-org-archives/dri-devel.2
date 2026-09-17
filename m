Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35FBC982CD
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D30810E52B;
	Thu, 17 Sep 2026 06:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="AZkiVDIo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NAOOfaLR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LH5ruNMC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T1hDRImX";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE7010E52B
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 06:16:57 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E9D72003F;
 Thu, 17 Sep 2026 06:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789625812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=03sHb354peHDuLnPpFcI1Biva5JylP/nsFdqNGyHyw8=;
 b=AZkiVDIor1HT4MlarqJYseMlAIlTZxRb1HnUwgAZxXsif3NuxUfExx7qGFRFZh1GVTWP7D
 W7oeEurwpZjr9FzoO3p5Y8Zhm9fpnuEleMMqQePTORe430k6b51LC5rchAEbKWB2r1oEAJ
 qKjyw/xzP8lcUzA9zVUaWds4zSbDlkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789625812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=03sHb354peHDuLnPpFcI1Biva5JylP/nsFdqNGyHyw8=;
 b=NAOOfaLRHwIDCzUxZXR9/VQ5BjMqWE1d0yfrwJIDA/2iKh3zIp1PZpbjw99KJXI+By8z9d
 LacJT12rcjFqSvBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LH5ruNMC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T1hDRImX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789625808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=03sHb354peHDuLnPpFcI1Biva5JylP/nsFdqNGyHyw8=;
 b=LH5ruNMCBZxhucjIK9liS/OAcunv1c8xNWycrYqlsZhX0ZLSr+NwK61ooLw9FFiTObMNw+
 0Yj8lTikjZxhUvKbYjM3HjIuJXOE5RSienWjSVZ3ueSyZB663bMyE6/5vpHo3/Dc6edjHt
 M3084ly7ys7QiukXriAg5uKogtNh0Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789625808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=03sHb354peHDuLnPpFcI1Biva5JylP/nsFdqNGyHyw8=;
 b=T1hDRImXPRaigjvJ0g+rH9dma/NjInNe1HIWbFzUNULE5H/KdIzqCFLI2VORNMIBUc0DM3
 zU8TY57KrW3GkxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE17013786;
 Thu, 17 Sep 2026 06:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5YDrE8+Fq2plSgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 17 Sep 2026 06:16:47 +0000
Message-ID: <1f98d0ec-8432-41ea-a3b1-0fbed621e1bf@suse.de>
Date: Thu, 17 Sep 2026 08:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/loongson: Create blend mode property for cursor
 plane
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Huacai Chen <chenhuacai@kernel.org>,
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org
References: <20260903084212.3621540-1-chenhuacai@loongson.cn>
 <a740569552a88eeb51055b73c8f05333269a0780.camel@iscas.ac.cn>
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
In-Reply-To: <a740569552a88eeb51055b73c8f05333269a0780.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2E9D72003F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 FREEMAIL_TO(0.00)[iscas.ac.cn,loongson.cn,gmail.com,ffwll.ch,kernel.org,linux.intel.com,aosc.io,xry111.site];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,loongson.cn:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
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



Am 17.09.26 um 07:08 schrieb Icenowy Zheng:
> 在 2026-09-03四的 16:42 +0800，Huacai Chen写道：
>> After commit 860e748bddcc929 ("drm: ensure blend mode supported if
>> pixel
>> format with alpha exposed") we get warnings at boot:
>>
>> loongson 0000:00:06.1: [drm] [PLANE:41:ls-cursor-plane-0] pixel
>> format with alpha exposed but blend mode not setup. Please fix.
>> loongson 0000:00:06.1: [drm] [PLANE:46:ls-cursor-plane-1] pixel
>> format with alpha exposed but blend mode not setup. Please fix.
>>
>> The reason is the cursor plane supports color formats with alpha but
>> the
>> driver doesn't create blend mode property, which triggers the warning
>> in
>> validate_blend_mode_for_alpha_formats().
>>
>> The loongson DC HW doesn't support DRM_MODE_BLEND_PREMULTI, so create
>> blend mode property with DRM_MODE_BLEND_COVERAGE for cursor planes
>> since
>> it is the only one implemented in the driver.
> It looks like this patch is hanging here for weeks. Should I apply it
> to drm-misc-fixes?

Go ahead

>
> Thanks,
> Icenowy
>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_plane.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
>> b/drivers/gpu/drm/loongson/lsdc_plane.c
>> index bea42215796d..bcc0ffa17bdf 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
>> @@ -7,6 +7,7 @@
>>   
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_blend.h>
>>   #include <drm/drm_framebuffer.h>
>>   #include <drm/drm_gem_atomic_helper.h>
>>   #include <drm/drm_print.h>
>> @@ -765,7 +766,7 @@ int ls7a1000_cursor_plane_init(struct drm_device
>> *ddev,
>>   
>>   	drm_plane_helper_add(plane,
>> &ls7a1000_cursor_plane_helper_funcs);
>>   
>> -	return 0;
>> +	return drm_plane_create_blend_mode_property(plane,
>> BIT(DRM_MODE_BLEND_COVERAGE));
>>   }
>>   
>>   int ls7a2000_cursor_plane_init(struct drm_device *ddev,
>> @@ -790,5 +791,5 @@ int ls7a2000_cursor_plane_init(struct drm_device
>> *ddev,
>>   
>>   	drm_plane_helper_add(plane,
>> &ls7a2000_cursor_plane_helper_funcs);
>>   
>> -	return 0;
>> +	return drm_plane_create_blend_mode_property(plane,
>> BIT(DRM_MODE_BLEND_COVERAGE));
>>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


