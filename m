Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34E5CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1852810EA21;
	Tue, 23 Jun 2026 09:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="unkeHIG2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AARyIuhB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wFfa16KX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="liBISxoD";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF3710EA21
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 09:02:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 803F570B2C;
 Tue, 23 Jun 2026 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782205362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NTNVGX9H82niWZjEyHuT7MHuSrof4HKrcW7+3pgtOyY=;
 b=unkeHIG2rHVjMwCpgmxA5EyKNVONe+4i1kYKLY8RWUSatvOvCptTHWhIiTX7BOtWk2zWXh
 Y2HphPXnD9xMwS4AbJA0cCinzNuErJsgSq8POUln0vNGTqklYfAdiDc/+KjnAF0iGuA+X+
 iIB4LpecNW6O7TR43leCaTAiHU/20n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782205362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NTNVGX9H82niWZjEyHuT7MHuSrof4HKrcW7+3pgtOyY=;
 b=AARyIuhBrVgLoA6yMbIozFuT3XWEjPTvmu8HuV5KF8P3TaSymIuJ1IfFRXSfoZQFgx0nGl
 wUTw4GDqlIEvgvDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782205360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NTNVGX9H82niWZjEyHuT7MHuSrof4HKrcW7+3pgtOyY=;
 b=wFfa16KX3Mixcp7FZxR7HFajHrzklPOOqqxqwjR34XlUE+V6VRZHAi74CIVxdoP5/ypg4A
 e9gB3OXZa7udC/6SBXXS5WrHlF+U8R7xU5pSHtV5mO/fVa/+g22N4KI9V4jnKPEMgkgOck
 tcaTE7ePkaic17l4QvES8PuXseEXAIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782205360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NTNVGX9H82niWZjEyHuT7MHuSrof4HKrcW7+3pgtOyY=;
 b=liBISxoDbsim2ka1CtFAdBRwHGTn7HSkt1tJkcp9gEDNuwDC5OWGDSGApzKkkzeD7zn+pY
 5ke14TMPJfcOk9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4414D779A8;
 Tue, 23 Jun 2026 09:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id celmD7BLOmr4awAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 23 Jun 2026 09:02:40 +0000
Message-ID: <d162a14b-7432-4d64-9f21-78a1150f9e0c@suse.de>
Date: Tue, 23 Jun 2026 11:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drm/sysfb: simpledrm: Validate mmap size against
 framebuffer size
To: Thierry Reding <treding@nvidia.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Sashiko <sashiko-bot@kernel.org>
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-6-tzimmermann@suse.de> <ajleu0THc75Ex7uN@orome>
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
In-Reply-To: <ajleu0THc75Ex7uN@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh,lists.freedesktop.org,lists.linux.dev];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, nvidia.com:email]
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

Am 22.06.26 um 18:13 schrieb Thierry Reding:
> On Mon, Jun 22, 2026 at 03:19:39PM +0200, Thomas Zimmermann wrote:
>> The size of the mmap'ed framebuffer could be smaller than the minimum
>> required framebuffer size. Validate the resource size against the
>> framebuffer size.
>>
>> Buggy firmware that triggers this check should be fixed up with a quirk
>> on a case-by-case base.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Suggested-by: Sashiko <sashiko-bot@kernel.org>
>> ---
>>   drivers/gpu/drm/sysfb/simpledrm.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
>> index 76b9a3f5c4ef..a04f0c852ea4 100644
>> --- a/drivers/gpu/drm/sysfb/simpledrm.c
>> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/of_address.h>
>>   #include <linux/of_clk.h>
>>   #include <linux/of_reserved_mem.h>
>> +#include <linux/overflow.h>
>>   #include <linux/platform_data/simplefb.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm.h>
>> @@ -624,6 +625,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   	u16 width_mm = 0, height_mm = 0;
>>   	struct device_node *panel_node;
>>   	const struct drm_format_info *format;
>> +	u64 size;
>>   	struct resource *res, *mem = NULL;
>>   	struct drm_plane *primary_plane;
>>   	struct drm_crtc *crtc;
>> @@ -704,6 +706,15 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   		}
>>   		stride = pitch;
>>   	}
>> +	if (check_mul_overflow(height, stride, &size)) {
>> +		drm_err(dev, "framebuffer size exceeds maximum\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +	size = ALIGN(size, PAGE_SIZE);
>> +	if (size < PAGE_SIZE) {
>> +		drm_err(dev, "framebuffer alignment exceeds maximum\n");
> That error message doesn't make sense to me. Maybe "framebuffer
> alignment below minimum", or something along those lines?

This tests that the align operation did not overflow size. The result 
would then be 0. With the earlier patches limiting the height and stride 
and size being of u64, it's not possible any longer, I think. But 
testing it doesn't really cost us much.

What do you think of "aligned framebuffer size exceeds maximum"?

Best regards
Thomas

>
> With that fixed:
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


