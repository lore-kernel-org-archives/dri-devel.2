Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D21606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OT0sKfpB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ep//QPDc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UE6p2RtN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lukt8XQw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552EC10EA89;
	Fri,  6 Nov 2026 15:59:16 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A534310EA89
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:59:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 117791F460;
 Fri,  6 Nov 2026 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793980744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XD4w82qPjOWQFx8UqrLwZ4eHH7poLw1AabtQc12HKyY=;
 b=OT0sKfpByfOzCb2QxuiYR1xEiomUzoz65jRelVN4iJCoAMEmm2iFoh3B+dzGOLk6e8gef2
 HxZFvolry8bRKxeJ7++Sp3qDE47uLEo3N9BUyOXxdvK0zfzvOhXKryUICH+WQ0cMNZSain
 KvGKT0OR8J+OBIInUKeqO0Oz6E9dwx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793980744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XD4w82qPjOWQFx8UqrLwZ4eHH7poLw1AabtQc12HKyY=;
 b=Ep//QPDctSmwCWibSRmKryZhO/zZIgoR3hHZgGHXTzIheTQajbA6s2YNdPUGPaI7pDkbLu
 xrBubzjbadvkGQCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793980743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XD4w82qPjOWQFx8UqrLwZ4eHH7poLw1AabtQc12HKyY=;
 b=UE6p2RtNyQiyhRWL1LEawPmQ2kKZZS44VYM4Pur2z8VRcIojDwgQiXqPXOke2cDJWI2KVg
 Ob1FmU9XXc+5hRwSiF6S68GgXzmf5hxXu0LFBUtVmml2kCalzkRT0DiQqeDggsTx89YmIh
 pa1xDZ3fKvRKHZzA681cLUoFebIcRFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793980743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XD4w82qPjOWQFx8UqrLwZ4eHH7poLw1AabtQc12HKyY=;
 b=lukt8XQwH0zrCCifIi7RDJNJI3olVenITUzkvV1JmtrXHmU77HSx14RI8s6zzkz6vgwC7Z
 Qxa2fja6FysKmcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C05DE134F4;
 Fri,  6 Nov 2026 15:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Cy3VJkb57WoVUgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 06 Nov 2026 15:59:02 +0000
Message-ID: <ceea8fbd-91ff-427d-962d-369349adcc8a@suse.de>
Date: Fri, 6 Nov 2026 16:59:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Set preferred_depth to 24 for XRGB8888 default
To: Oarora Etimis <oaroraetimis@gmail.com>,
 Karthik Sarvan <karthiks1mail@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Louis Chauvet
 <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
References: <20261026071933.48366-1-karthiks1mail@gmail.com>
 <20261106154108.515215-1-oaroraetimis@gmail.com>
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
In-Reply-To: <20261106154108.515215-1-oaroraetimis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,bootlin.com,ffwll.ch,gmail.com];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 06.11.26 um 16:41 schrieb Oarora Etimis:
> Thanks for your patch. I don't think it should be merged as it is.

The patch is absolutely correct.

>
> 1. The patch changes almost nothing
>
> vkms takes the path where no explicit format is passed, so the
> framebuffer is XRGB8888 before and after the patch. This is the
> function that decides it
> (drivers/gpu/drm/clients/drm_fbdev_client.c:drm_fbdev_client_setup()):
>
> int drm_fbdev_client_setup(struct drm_device *dev, const struct drm_format_info *format)
> {
> 	struct drm_fb_helper *fb_helper;
> 	unsigned int color_mode;
> 	int ret;
>
> 	/* TODO: Use format info throughout DRM */
> 	if (format) {
> 		...
> 	} else {
> 		switch (dev->mode_config.preferred_depth) {
> 		case 0:
> 		case 24:
> 			color_mode = 32;
> 			break;

This is a workaround because the setting of format, depth and bpp has 
always been somewhat inconsistent.

> 		default:
> 			color_mode = dev->mode_config.preferred_depth;
> 		}
> 	}
>
> 	...
> }
>
> 0 and 24 are two labels on the same branch, so the patch neither adds a
> user of that branch nor removes one; it only changes which label vkms
> takes. The only visible difference is that DRM_IOCTL_GET_CAP with
> DRM_CAP_DUMB_PREFERRED_DEPTH returns 24 instead of 0.

User space (specifically Xorg) takes this value to decide about the 
color format.


>
> 2. This field conflates depth and bpp; no value can fix that.

No, that field stores the depth, which is 24 for both RGB888 and 
XRGB888.  Drivers sometimes do conflate the meaning.


>
> XRGB8888 is 24 bits of colour in 32 bits per pixel. This field holds the
> first number, the fbdev helpers want the second, and the switch above is
> what patches over the difference - without it, 24 would select RGB888.
> And the newer formats have no depth to give. XRGB16161616 and its three
> siblings are .depth = 0 in struct drm_format_info, and vkms advertises
> all four on its primary plane. Move the default to one of them and
> there is no number to write.
>
> So 0 is not a placeholder waiting to be filled in; it is the only value
> that does not claim to name a format.

That's also not really the case.  Ideally, we want preferred_depth to go 
away in all drivers. Instead the primary plane would tell us what the 
preferred depth is. But that's not so easy and might never work.  
Setting the correct value to preferred_depth it the next best thing.


>
> 3. Deleting the comment loses the only explanation of 0

The current comment is misleading. There is no confusion about depth and 
bpp.

Best regards
Thomas

>
> Nothing else in the tree says what 0 means here. The kerneldoc for
> preferred_depth is a single line, "preferred RBG pixel depth, used by fb
> helpers", and does not mention 0 at all. If that FIXME goes, the next
> person who wonders why vkms writes 0 has nowhere to look. If it has to
> go because the helper no longer substitutes depth for bpp, then replace
> it with something that still explains the 0.
>
> Thanks,
> Oarora Etimis
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


