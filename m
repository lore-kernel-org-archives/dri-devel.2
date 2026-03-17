Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BB5FD875A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9873F10E2D4;
	Tue, 17 Mar 2026 12:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="CWuV4W9S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HHfVXFS3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CWuV4W9S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HHfVXFS3";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC83310E2D4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:24:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 274755BCC6;
 Tue, 17 Mar 2026 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773750278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=piWa4QJetmgkzTmrwsJCLmXyV+O7+jApdEUH4ceN9Kk=;
 b=CWuV4W9SAGtmEk5nkMr+dEegXhKfjZZgJlF7F/nTWJzcE7iPqH7D//F3pMeBkvQxFdgyJh
 vCAIlxekyEwqYXXSaTT4lxpLfcGbalezYe+yav3VPM28YQxhCjy9wYZk6Tf5/oTn3D6XJO
 0uVhUa2bn99CqDJj19eUUN9wqV0uACg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773750278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=piWa4QJetmgkzTmrwsJCLmXyV+O7+jApdEUH4ceN9Kk=;
 b=HHfVXFS3msNj3E3dgCb2JMHWL7bjEZjtpwhYCfs31D09sz+uPalcD+iRTRAUNAGp6OUyJo
 kbRCxOVBOKS9xACg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CWuV4W9S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HHfVXFS3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773750278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=piWa4QJetmgkzTmrwsJCLmXyV+O7+jApdEUH4ceN9Kk=;
 b=CWuV4W9SAGtmEk5nkMr+dEegXhKfjZZgJlF7F/nTWJzcE7iPqH7D//F3pMeBkvQxFdgyJh
 vCAIlxekyEwqYXXSaTT4lxpLfcGbalezYe+yav3VPM28YQxhCjy9wYZk6Tf5/oTn3D6XJO
 0uVhUa2bn99CqDJj19eUUN9wqV0uACg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773750278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=piWa4QJetmgkzTmrwsJCLmXyV+O7+jApdEUH4ceN9Kk=;
 b=HHfVXFS3msNj3E3dgCb2JMHWL7bjEZjtpwhYCfs31D09sz+uPalcD+iRTRAUNAGp6OUyJo
 kbRCxOVBOKS9xACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD924273B;
 Tue, 17 Mar 2026 12:24:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rvRaMQVIuWmVfAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Mar 2026 12:24:37 +0000
Message-ID: <ada8ca6f-a2f2-4f8c-b916-f6dc24db6db5@suse.de>
Date: Tue, 17 Mar 2026 13:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
To: wens@kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev
References: <20260317064049.696795-1-wenst@chromium.org>
 <20260317064049.696795-3-wenst@chromium.org>
 <607daaca-79ed-45b2-941e-1680a17618e8@suse.de>
 <CAGb2v66D3=s9c8oJyYEAK90A4SekW6FjLUpWBGRHnJwtfMvUeg@mail.gmail.com>
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
In-Reply-To: <CAGb2v66D3=s9c8oJyYEAK90A4SekW6FjLUpWBGRHnJwtfMvUeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[12];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[chromium.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ideasonboard.com,lists.freedesktop.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.com:url,
 chromium.org:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 274755BCC6
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

Am 17.03.26 um 11:58 schrieb Chen-Yu Tsai:
> On Tue, Mar 17, 2026 at 4:12 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 17.03.26 um 07:40 schrieb Chen-Yu Tsai:
>>> From: Rob Herring <robh@kernel.org>
>>>
>>> Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
>>> drm_mode_create_dumb. This flag is for internal kernel use to indicate
>>> if dumb buffer allocation needs a kernel mapping. This is needed only for
>>> CMA where creating a kernel mapping or not has to be decided at allocation
>>> time because creating a mapping on demand (with vmap()) is not guaranteed
>>> to work. Several drivers are using CMA, but not the CMA helpers because
>>> they distinguish between kernel and userspace allocations to create a
>>> kernel mapping or not.
>> Any dumb allocation might require vmap. This is not limited to internal
>> buffers.  Because if the dumb buffer is shared with another driver, that
>> driver might require the vmap for displaying the buffer content. There
>> are enough of such drivers.
> By sharing, do you mean exported via PRIME then imported by another device?
> Or just passing around GEM objects within the kernel?

I mean PRIME/dma-buf sharing.

>
> And could you provide an example?

Create a dumb GEM buffer on one of those CMA devices and mirror it to a 
display or udl device.  These devices have no means of scanning out the 
provided buffer directly, so their drivers vmap the buffer and copy the 
pixel data into their internal memory (via a peripheral bus). The vmap 
call happens via the kernel's internal dma-buf interfaces. Hence any 
driver needs support for vmap if it wants to support this use case.

Best regards
Thomas

>
>>> Update the callers of drm_mode_dumb_create() to set
>>> drm_mode_dumb_create.flags to appropriate defaults. Currently, flags can
>>> be set to anything by userspace, but is unused within the kernel. Let's
>>> force flags to zero (no kernel mapping) for userspace callers by default.
>>> For in kernel clients, set DRM_MODE_DUMB_KERNEL_MAP by default. Drivers
>>> can override this as needed.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> [wenst@chromium.org: Emit warning if args->flags is not zero]
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> Changes since v1:
>>> - Emit warning if args->flags is not zero
>>> ---
>>>    drivers/gpu/drm/drm_client.c       | 1 +
>>>    drivers/gpu/drm/drm_dumb_buffers.c | 4 ++++
>>>    include/uapi/drm/drm_mode.h        | 2 ++
>>>    3 files changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
>>> index 46c465bce98c..1a57e7eadc0f 100644
>>> --- a/drivers/gpu/drm/drm_client.c
>>> +++ b/drivers/gpu/drm/drm_client.c
>>> @@ -404,6 +404,7 @@ drm_client_buffer_create_dumb(struct drm_client_dev *client, u32 width, u32 heig
>>>        dumb_args.width = width;
>>>        dumb_args.height = height;
>>>        dumb_args.bpp = drm_format_info_bpp(info, 0);
>>> +     dumb_args.flags = DRM_MODE_DUMB_KERNEL_MAP;
>>>        ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
>>>        if (ret)
>>>                return ERR_PTR(ret);
>>> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
>>> index e2b62e5fb891..ccdcc401d4dc 100644
>>> --- a/drivers/gpu/drm/drm_dumb_buffers.c
>>> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
>>> @@ -233,6 +233,10 @@ int drm_mode_create_dumb_ioctl(struct drm_device *dev,
>>>        struct drm_mode_create_dumb *args = data;
>>>        int err;
>>>
>>> +     if (args->flags)
>>> +             drm_warn(dev, "drm_mode_create_dumb.flags is not zero.\n");
>> At most use drm_warn_once() to not let this spam the kernel log.
> Sure.
>
>>> +     args->flags = 0;
>>> +
>>>        err = drm_mode_create_dumb(dev, args, file_priv);
>>>        if (err) {
>>>                args->handle = 0;
>>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>>> index 3693d82b5279..7d5f50e4af70 100644
>>> --- a/include/uapi/drm/drm_mode.h
>>> +++ b/include/uapi/drm/drm_mode.h
>>> @@ -1272,6 +1272,8 @@ struct drm_mode_create_dumb {
>>>        __u64 size;
>>>    };
>>>
>>> +#define DRM_MODE_DUMB_KERNEL_MAP     (1<<0)  /* For internal kernel use */
>>> +
>> If this is an internal flag, it should not live in the UAPI header.
>> include/drm/drm_dumb_buffers.h would be a good place.
> Makes sense.
>
>
> Thanks
> ChenYu
>
>> Best regards
>> Thomas
>>
>>>    /* set up for mmap of a dumb scanout buffer */
>>>    struct drm_mode_map_dumb {
>>>        /** Handle for the object being mapped. */
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
>>
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


