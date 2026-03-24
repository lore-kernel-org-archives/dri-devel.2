Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC64F532E9
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3ED710E0EA;
	Tue, 24 Mar 2026 07:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="YkteVJBD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Je74jdiu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dSf+N+b7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vu3Jpwqg";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB41F10E0EA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 07:45:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 823084D1C8;
 Tue, 24 Mar 2026 07:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774338339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k8/nPj5yp4rouLaitHXnNxUFM1QrTx/JhT7nUKy+A0w=;
 b=YkteVJBDLbOrHgUd/ckKSqC7i8DDc0qlr4Crq3fWONy0q5vXF0cuX9PghBe8V81Pmnk0Wu
 hOh3JhvyI9QwHj28xyeR087p1BeMacazA/dGcdWKqya8uMzsCyJcwexzrtFr8SUT0mg2L3
 3AjAoWHaico5fwCMP5rDkVP5k4caNVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774338339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k8/nPj5yp4rouLaitHXnNxUFM1QrTx/JhT7nUKy+A0w=;
 b=Je74jdiuxwE1z0EP5q7c+Jh5byeqXgl4Tfc9pcRNvo53DT+ySl5RfpKU1xtfssyhgyIKOv
 0STGfq02PMVHjTDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dSf+N+b7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vu3Jpwqg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774338338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k8/nPj5yp4rouLaitHXnNxUFM1QrTx/JhT7nUKy+A0w=;
 b=dSf+N+b7Dpmpkm2mZx9b3M4ZT0ERquXGFbo3U9OY8M+hQmiKVLvej9rRw3m5ezNDlbD09b
 5Pm0VSZ5wJxH5Zx8bmYnLgUUKbage5mR37ILavatezQIDrXjBfpQOijdzIrYcrxJRErtfg
 DwSo+TaV3BS2yPQP7Ov2C4yNGkrzHxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774338338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k8/nPj5yp4rouLaitHXnNxUFM1QrTx/JhT7nUKy+A0w=;
 b=Vu3Jpwqg8j5yYFW7kcvfFjnhMyyDJa7/EYSRMUL8hnyfYT0JyTbT6YgrNZsvRJdyVmOEaj
 zbu1a7iYfedMzmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4025A43D17;
 Tue, 24 Mar 2026 07:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Igt0DiJBwmnRNQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 24 Mar 2026 07:45:38 +0000
Message-ID: <0b3c5e38-48dc-415c-971a-1b0fa115cff8@suse.de>
Date: Tue, 24 Mar 2026 08:45:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/2] drm: verisilicon: add support for cursor planes
To: Icenowy Zheng <uwu@icenowy.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Han Gao <rabenda.cn@gmail.com>
References: <20260309085302.3132732-1-zhengxingda@iscas.ac.cn>
 <20260309085302.3132732-3-zhengxingda@iscas.ac.cn>
 <4f4662a7-7c1c-4706-9c65-55d193de27c9@suse.de>
 <1ae34ba326bb7863e358178d7beaaed3ed58b8a9.camel@icenowy.me>
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
In-Reply-To: <1ae34ba326bb7863e358178d7beaaed3ed58b8a9.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[icenowy.me,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[8]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid, bootlin.com:url,
 suse.com:url]
X-Rspamd-Queue-Id: 823084D1C8
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

Am 24.03.26 um 06:34 schrieb Icenowy Zheng:
> 在 2026-03-10二的 10:54 +0100，Thomas Zimmermann写道：
>> Hi
>>
>> Am 09.03.26 um 09:53 schrieb Icenowy Zheng:
>>> Verisilicon display controllers support hardware cursors per output
>>> port.
>>>
>>> Add support for them as cursor planes.
>>>
>>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>> ---
>>>    drivers/gpu/drm/verisilicon/Makefile          |   3 +-
>>>    drivers/gpu/drm/verisilicon/vs_crtc.c         |  11 +-
>>>    drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 273
>>> ++++++++++++++++++
>>>    .../drm/verisilicon/vs_cursor_plane_regs.h    |  44 +++
>>>    drivers/gpu/drm/verisilicon/vs_plane.h        |   1 +
>>>    .../drm/verisilicon/vs_primary_plane_regs.h   |   5 +-
>>>    6 files changed, 333 insertions(+), 4 deletions(-)
>>>    create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane.c
>>>    create mode 100644
>>> drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
>>>
>>> diff --git a/drivers/gpu/drm/verisilicon/Makefile
>>> b/drivers/gpu/drm/verisilicon/Makefile
>>> index fd8d805fbcde1..426f4bcaa834d 100644
>>> --- a/drivers/gpu/drm/verisilicon/Makefile
>>> +++ b/drivers/gpu/drm/verisilicon/Makefile
>>> @@ -1,5 +1,6 @@
>>>    # SPDX-License-Identifier: GPL-2.0-only
>>>    
>>> -verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_drm.o
>>> vs_hwdb.o vs_plane.o vs_primary_plane.o
>>> +verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_drm.o
>>> vs_hwdb.o \
>>> +	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
>>>    
>>>    obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon-dc.o
>>> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c
>>> b/drivers/gpu/drm/verisilicon/vs_crtc.c
>>> index f494017130006..5c9714a3e69a7 100644
>>> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
>>> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
>>> @@ -159,7 +159,7 @@ struct vs_crtc *vs_crtc_init(struct drm_device
>>> *drm_dev, struct vs_dc *dc,
>>>    			     unsigned int output)
>>>    {
>>>    	struct vs_crtc *vcrtc;
>>> -	struct drm_plane *primary;
>>> +	struct drm_plane *primary, *cursor;
>>>    	int ret;
>>>    
>>>    	vcrtc = drmm_kzalloc(drm_dev, sizeof(*vcrtc), GFP_KERNEL);
>>> @@ -175,9 +175,16 @@ struct vs_crtc *vs_crtc_init(struct drm_device
>>> *drm_dev, struct vs_dc *dc,
>>>    		return ERR_PTR(PTR_ERR(primary));
>>>    	}
>>>    
>>> +	/* Create our cursor plane */
>>> +	cursor = vs_cursor_plane_init(drm_dev, dc);
>>> +	if (IS_ERR(cursor)) {
>>> +		drm_err(drm_dev, "Couldn't create the cursor
>>> plane\n");
>>> +		return ERR_CAST(cursor);
>>> +	}
>>> +
>>>    	ret = drmm_crtc_init_with_planes(drm_dev, &vcrtc->base,
>>>    					 primary,
>>> -					 NULL,
>>> +					 cursor,
>>>    					 &vs_crtc_funcs,
>>>    					 NULL);
>>>    	if (ret) {
>>> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
>>> b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
>>> new file mode 100644
>>> index 0000000000000..4c86519458077
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
>>> @@ -0,0 +1,273 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (C) 2026 Institute of Software, Chinese Academy of
>>> Sciences (ISCAS)
>>> + *
>>> + * Authors:
>>> + * Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>> + */
>>> +
>>> +#include <linux/regmap.h>
>>> +
>>> +#include <drm/drm_atomic.h>
>>> +#include <drm/drm_atomic_helper.h>
>>> +#include <drm/drm_crtc.h>
>>> +#include <drm/drm_fourcc.h>
>>> +#include <drm/drm_framebuffer.h>
>>> +#include <drm/drm_gem_atomic_helper.h>
>>> +#include <drm/drm_modeset_helper_vtables.h>
>>> +#include <drm/drm_plane.h>
>>> +#include <drm/drm_print.h>
>>> +
>>> +#include "vs_crtc.h"
>>> +#include "vs_plane.h"
>>> +#include "vs_dc.h"
>>> +#include "vs_hwdb.h"
>>> +#include "vs_cursor_plane_regs.h"
>>> +
>>> +#define VSDC_CURSOR_LOCATION_MAX_POSITIVE BIT_MASK(15)
>>> +#define VSDC_CURSOR_LOCATION_MAX_NEGATIVE BIT_MASK(5)
>>> +
>>> +static bool vs_cursor_plane_check_coord(int32_t coord)
>>> +{
>>> +	if (coord >= 0)
>>> +		return coord <= VSDC_CURSOR_LOCATION_MAX_POSITIVE;
>>> +	else
>>> +		return (-coord) <=
>>> VSDC_CURSOR_LOCATION_MAX_NEGATIVE;
>>> +}
>>> +
>>> +static int vs_cursor_plane_atomic_check(struct drm_plane *plane,
>>> +					struct drm_atomic_state
>>> *state)
>>> +{
>>> +	struct drm_plane_state *new_plane_state =
>>> drm_atomic_get_new_plane_state(state,
>>> +								
>>> 		 plane);
>>> +	struct drm_crtc *crtc = new_plane_state->crtc;
>>> +	struct drm_framebuffer *fb = new_plane_state->fb;
>>> +	struct drm_crtc_state *crtc_state = NULL;
>>> +	struct vs_crtc *vcrtc;
>>> +	struct vs_dc *dc;
>>> +	int ret;
>>> +
>>> +	if (crtc)
>>> +		crtc_state = drm_atomic_get_new_crtc_state(state,
>>> crtc);
>>> +
>>> +	ret = drm_atomic_helper_check_plane_state(new_plane_state,
>>> +						  crtc_state,
>>> +						
>>> DRM_PLANE_NO_SCALING,
>>> +						
>>> DRM_PLANE_NO_SCALING,
>>> +						  true, true);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (!crtc)
>> Use "if (!new_plane_state->visible)"  for this test. The plane might
>> be
>> invisible if the crtc has been set.  you should return in all such
>> cases
>> unless you have a good reason not to.
>>
>>> +		return 0; /* Skip validity check */
>>> +
>>> +	vcrtc = drm_crtc_to_vs_crtc(crtc);
>>> +	dc = vcrtc->dc;
>>> +
>>> +	/* Only certain square sizes is supported */
>>> +	switch (new_plane_state->crtc_w) {
>>> +	case 32:
>>> +	case 64:
>>> +	case 128:
>>> +	case 256:
>> Instead of using max_cursor_size, could this be a HW-specific bit
>> field
>> that you test the cursor size against? Like
>>
>> if (!is_power_of_2(crtc_w) || !(max_cursor_size & crtc_w)
>>       return -EINVAL
>>
>> But also see my comment on the switch in atomic_update.
>>
>>
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (new_plane_state->crtc_w > dc-
>>>> identity.max_cursor_size)
>>> +		return -EINVAL;
>>> +
>>> +	if (new_plane_state->crtc_w != new_plane_state->crtc_h)
>>> +		return -EINVAL;
>>> +
>>> +	/* Check if the cursor is inside the register fields'
>>> range */
>>> +	if (!vs_cursor_plane_check_coord(new_plane_state->crtc_x)
>>> ||
>>> +	    !vs_cursor_plane_check_coord(new_plane_state->crtc_y))
>>> +		return -EINVAL;
>>> +
>>> +	if (fb) {
>>> +		/* Only ARGB8888 is supported */
>>> +		if (drm_WARN_ON_ONCE(plane->dev,
>>> +				     fb->format->format !=
>>> DRM_FORMAT_ARGB8888))
>>> +			return -EINVAL;
>> We already do this check at [1], including supported modifiers.
>>
>> [1]
>> https://elixir.bootlin.com/linux/v6.19.6/source/drivers/gpu/drm/drm_atomic.c#L739
>>
>>> +
>>> +		/* Extra line padding isn't supported */
>>> +		if (fb->pitches[0] !=
>>> +		    drm_format_info_min_pitch(fb->format, 0,
>>> +					      new_plane_state-
>>>> crtc_w))
>>> +			return -EINVAL;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int
>>> output)
>>> +{
>>> +	regmap_set_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>>> +			VSDC_CURSOR_CONFIG_COMMIT |
>>> +			VSDC_CURSOR_CONFIG_IMG_UPDATE);
>>> +}
>>> +
>>> +static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
>>> +					   struct drm_atomic_state
>>> *atomic_state)
>>> +{
>>> +	struct drm_plane_state *state =
>>> drm_atomic_get_new_plane_state(atomic_state,
>>> +								
>>>       plane);
>>> +	struct drm_crtc *crtc = state->crtc;
>>> +	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>> +	unsigned int output = vcrtc->id;
>>> +	struct vs_dc *dc = vcrtc->dc;
>>> +
>>> +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>>> +			   VSDC_CURSOR_CONFIG_FMT_MASK,
>>> +			   VSDC_CURSOR_CONFIG_FMT_ARGB8888);
>>> +
>>> +	vs_cursor_plane_commit(dc, output);
>>> +}
>>> +
>>> +static void vs_cursor_plane_atomic_disable(struct drm_plane
>>> *plane,
>>> +					    struct
>>> drm_atomic_state *atomic_state)
>>> +{
>>> +	struct drm_plane_state *state =
>>> drm_atomic_get_old_plane_state(atomic_state,
>>> +								
>>>       plane);
>>> +	struct drm_crtc *crtc = state->crtc;
>>> +	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>> +	unsigned int output = vcrtc->id;
>>> +	struct vs_dc *dc = vcrtc->dc;
>>> +
>>> +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>>> +			   VSDC_CURSOR_CONFIG_FMT_MASK,
>>> +			   VSDC_CURSOR_CONFIG_FMT_OFF);
>>> +
>>> +	vs_cursor_plane_commit(dc, output);
>>> +}
>>> +
>>> +static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
>>> +					   struct drm_atomic_state
>>> *atomic_state)
>>> +{
>>> +	struct drm_plane_state *state =
>>> drm_atomic_get_new_plane_state(atomic_state,
>>> +								
>>>       plane);
>>> +	struct drm_framebuffer *fb = state->fb;
>>> +	struct drm_crtc *crtc = state->crtc;
>>> +	struct vs_dc *dc;
>>> +	struct vs_crtc *vcrtc;
>>> +	unsigned int output;
>>> +	dma_addr_t dma_addr;
>>> +
>>> +	if (!state->visible) {
>>> +		vs_cursor_plane_atomic_disable(plane,
>>> atomic_state);
>>> +		return;
>>> +	}
>> You already set atomic_disable in the plane_helper_funcs. Therefore
>> you
>> will never take this conditional.
> Well it looks like the condition to call atomic_disable instead of
> atomic_update is drm_atomic_plane_disabling(), which only checks
> whether the plane has a CRTC bound before and no CRTC bound after.
>
> Here the code needs to be here to handle the situation that the plane
> is bound but not visible, like what's mentioned in your previous
> comment of atomic_check .

I'd have to test, but my impression is that you'd never get here if 
!visible. But I cannot find any such logic either, so I might be wrong 
about that.

Two more questions come to my mind:

What happens if you keep the plane enabled? Is the hardware not able to 
handle that?

What happens is you return -EINVAL in atomic_check if !visible?

Best regards
Thomas

>
> Thanks,
> Icenowy
>
>>> +
>>> +	vcrtc = drm_crtc_to_vs_crtc(crtc);
>>> +	output = vcrtc->id;
>>> +	dc = vcrtc->dc;
>>> +
>>> +	switch (state->crtc_w) {
>>> +	case 32:
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
>>> +				   VSDC_CURSOR_CONFIG_SIZE_32);
>>> +		break;
>>> +	case 64:
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
>>> +				   VSDC_CURSOR_CONFIG_SIZE_64);
>>> +		break;
>>> +	case 128:
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
>>> +				   VSDC_CURSOR_CONFIG_SIZE_128);
>>> +		break;
>>> +	case 256:
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
>>> +				   VSDC_CURSOR_CONFIG_SIZE_256);
>>> +		break;
>>> +	}
>> Here is another case where you can move a potential error state into
>> the
>> atomic_check.  If you add a custom vc_cursor_plane_state, you can add
>> a
>> size field that stores the size constants.  Then it would make sense
>> to
>> keep the switch statement in atomic check and set the field right
>> there.  Here in atomic_update, you'd need no switch.
>>
>>> +
>>> +	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
>>> +
>>> +	regmap_write(dc->regs, VSDC_CURSOR_ADDRESS(output),
>>> +		     lower_32_bits(dma_addr));
>>> +
>>> +	/*
>>> +	 * The X_OFF and Y_OFF fields define which point does the
>>> LOCATION
>>> +	 * register represent in the cursor image, and LOCATION
>>> register
>>> +	 * values are unsigned. To for positive left-top
>>> coordinates the
>>> +	 * offset is set to 0 and the location is set to the
>>> coordinate, for
>>> +	 * negative coordinates the location is set to 0 and the
>>> offset
>>> +	 * is set to the opposite number of the coordinate to
>>> offset the
>>> +	 * cursor image partly off-screen.
>>> +	 */
>>> +	if (state->crtc_x >= 0) {
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_X_OFF_MASK,
>>> 0);
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_LOCATION(output),
>>> +				   VSDC_CURSOR_LOCATION_X_MASK,
>>> +				   VSDC_CURSOR_LOCATION_X(state-
>>>> crtc_x));
>>> +	} else {
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_X_OFF_MASK,
>>> +				   -state->crtc_x);
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_LOCATION(output),
>>> +				   VSDC_CURSOR_LOCATION_X_MASK,
>>> 0);
>>> +	}
>>> +
>>> +	if (state->crtc_y >= 0) {
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_Y_OFF_MASK,
>>> 0);
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_LOCATION(output),
>>> +				   VSDC_CURSOR_LOCATION_Y_MASK,
>>> +				   VSDC_CURSOR_LOCATION_Y(state-
>>>> crtc_y));
>>> +	} else {
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_Y_OFF_MASK,
>>> +				   -state->crtc_y);
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_LOCATION(output),
>>> +				   VSDC_CURSOR_LOCATION_Y_MASK,
>>> 0);
>>> +	}
>>> +
>>> +	vs_cursor_plane_commit(dc, output);
>>> +}
>>> +
>>> +static const struct drm_plane_helper_funcs
>>> vs_cursor_plane_helper_funcs = {
>>> +	.atomic_check	= vs_cursor_plane_atomic_check,
>>> +	.atomic_update	= vs_cursor_plane_atomic_update,
>>> +	.atomic_enable	= vs_cursor_plane_atomic_enable,
>>> +	.atomic_disable	= vs_cursor_plane_atomic_disable,
>>> +};
>>> +
>>> +static const struct drm_plane_funcs vs_cursor_plane_funcs = {
>>> +	.atomic_destroy_state	=
>>> drm_atomic_helper_plane_destroy_state,
>>> +	.atomic_duplicate_state	=
>>> drm_atomic_helper_plane_duplicate_state,
>>> +	.disable_plane		= drm_atomic_helper_disable_plane,
>>> +	.reset			= drm_atomic_helper_plane_reset,
>>> +	.update_plane		= drm_atomic_helper_update_plane,
>>> +};
>>> +
>>> +static const u32 vs_cursor_plane_formats[] = {
>>> +	DRM_FORMAT_ARGB8888,
>>> +};
>> Maybe also add
>>
>> static const u64 vs_cursor_plane_format_modifiers[] = {
>>     DRM_FORMAT_MOD_LINEAR,
>>     DRM_FORMAT_MOD_INVALID,
>> };
>>
>> and pass it to drmm_universal_plane_alloc().  Using NULL there is
>> supported, but I'd consider it bad style. Your choice.
>>
>> Best regards
>> Thomas
>>
>>> +
>>> +struct drm_plane *vs_cursor_plane_init(struct drm_device *drm_dev,
>>> +				       struct vs_dc *dc)
>>> +{
>>> +	struct drm_plane *plane;
>>> +
>>> +	plane = drmm_universal_plane_alloc(drm_dev, struct
>>> drm_plane, dev, 0,
>>> +					   &vs_cursor_plane_funcs,
>>> +					
>>> vs_cursor_plane_formats,
>>> +					
>>> ARRAY_SIZE(vs_cursor_plane_formats),
>>> +					   NULL,
>>> +					   DRM_PLANE_TYPE_CURSOR,
>>> +					   NULL);
>>> +
>>> +	if (IS_ERR(plane))
>>> +		return plane;
>>> +
>>> +	drm_plane_helper_add(plane,
>>> &vs_cursor_plane_helper_funcs);
>>> +
>>> +	return plane;
>>> +}
>>> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
>>> b/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
>>> new file mode 100644
>>> index 0000000000000..99693f2c95b94
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
>>> @@ -0,0 +1,44 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
>>> + *
>>> + * Based on vs_dc_hw.h, which is:
>>> + *   Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
>>> + */
>>> +
>>> +#ifndef _VS_CURSOR_PLANE_REGS_H_
>>> +#define _VS_CURSOR_PLANE_REGS_H_
>>> +
>>> +#include <linux/bits.h>
>>> +
>>> +#define VSDC_CURSOR_CONFIG(n)		(0x1468 + 0x1080 * (n))
>>> +#define VSDC_CURSOR_CONFIG_FMT_MASK	GENMASK(1, 0)
>>> +#define VSDC_CURSOR_CONFIG_FMT_ARGB8888	(0x2 << 0)
>>> +#define VSDC_CURSOR_CONFIG_FMT_OFF	(0x0 << 0)
>>> +#define VSDC_CURSOR_CONFIG_IMG_UPDATE	BIT(2)
>>> +#define VSDC_CURSOR_CONFIG_COMMIT	BIT(3)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_MASK	GENMASK(7, 5)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_32	(0x0 << 5)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_64	(0x1 << 5)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_128	(0x2 << 5)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_256	(0x3 << 5)
>>> +#define VSDC_CURSOR_CONFIG_Y_OFF_MASK	GENMASK(12, 8)
>>> +#define VSDC_CURSOR_CONFIG_Y_OFF(v)	((v) << 8)
>>> +#define VSDC_CURSOR_CONFIG_X_OFF_MASK	GENMASK(20, 16)
>>> +#define VSDC_CURSOR_CONFIG_X_OFF(v)	((v) << 16)
>>> +
>>> +#define VSDC_CURSOR_ADDRESS(n)		(0x146C + 0x1080 * (n))
>>> +
>>> +#define VSDC_CURSOR_LOCATION(n)		(0x1470 + 0x1080 *
>>> (n))
>>> +#define VSDC_CURSOR_LOCATION_X_MASK	GENMASK(14, 0)
>>> +#define VSDC_CURSOR_LOCATION_X(v)	((v) << 0)
>>> +#define VSDC_CURSOR_LOCATION_Y_MASK	GENMASK(30, 16)
>>> +#define VSDC_CURSOR_LOCATION_Y(v)	((v) << 16)
>>> +
>>> +#define VSDC_CURSOR_BACKGROUND(n)	(0x1474 + 0x1080 * (n))
>>> +#define VSDC_CURSOR_BACKGRUOND_DEFAULT	0x00FFFFFF
>>> +
>>> +#define VSDC_CURSOR_FOREGROUND(n)	(0x1478 + 0x1080 * (n))
>>> +#define VSDC_CURSOR_FOREGRUOND_DEFAULT	0x00AAAAAA
>>> +
>>> +#endif /* _VS_CURSOR_PLANE_REGS_H_ */
>>> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h
>>> b/drivers/gpu/drm/verisilicon/vs_plane.h
>>> index 41875ea3d66a5..60b5b3a1bc22a 100644
>>> --- a/drivers/gpu/drm/verisilicon/vs_plane.h
>>> +++ b/drivers/gpu/drm/verisilicon/vs_plane.h
>>> @@ -68,5 +68,6 @@ dma_addr_t vs_fb_get_dma_addr(struct
>>> drm_framebuffer *fb,
>>>    			      const struct drm_rect *src_rect);
>>>    
>>>    struct drm_plane *vs_primary_plane_init(struct drm_device *dev,
>>> struct vs_dc *dc);
>>> +struct drm_plane *vs_cursor_plane_init(struct drm_device *dev,
>>> struct vs_dc *dc);
>>>    
>>>    #endif /* _VS_PLANE_H_ */
>>> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>>> b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>>> index cbb125c46b390..61a48c2faa1b2 100644
>>> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>>> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
>>> @@ -1,9 +1,12 @@
>>>    /* SPDX-License-Identifier: GPL-2.0-only */
>>>    /*
>>> - * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
>>> + * Copyright (C) 2026 Institute of Software, Chinese Academy of
>>> Sciences (ISCAS)
>>>     *
>>>     * Based on vs_dc_hw.h, which is:
>>>     *   Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
>>> + *
>>> + * Authors:
>>> + * Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>>     */
>>>    
>>>    #ifndef _VS_PRIMARY_PLANE_REGS_H_

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


