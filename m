Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEA2FF4954
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 06:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1149110E231;
	Mon, 30 Mar 2026 06:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="r8RDwQD1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xm/rjHnn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r8RDwQD1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xm/rjHnn";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6C710E231
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 06:55:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B52B44D1F1;
 Mon, 30 Mar 2026 06:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774853698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zeFi1kedmcawwUQjn0XmQPE8rTjeYaz4FKO4GjTVKkw=;
 b=r8RDwQD176QAy2Jk1NMmPoFinziHg3Xv9/hjCm9ENL2plTnkU3wmZjL3wUwiEJNEH/LmxH
 ZaBcb4lU2mapk27o4+KsJmMq3gFfR+ISwdl4B52bZIxjsliimZ8ZPVu5SK+Wv3ha0/7fed
 av0Jlaks3rS5Wn4IIT2EUVn11oHOYJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774853698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zeFi1kedmcawwUQjn0XmQPE8rTjeYaz4FKO4GjTVKkw=;
 b=Xm/rjHnn5XIqsxKBh4HE2lEE8YfbpMdHZJJFHR/1la5wUvvfx5EiYltOzotlPxRkhh/JSe
 tGXlVtksJ0z5r7CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r8RDwQD1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Xm/rjHnn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774853698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zeFi1kedmcawwUQjn0XmQPE8rTjeYaz4FKO4GjTVKkw=;
 b=r8RDwQD176QAy2Jk1NMmPoFinziHg3Xv9/hjCm9ENL2plTnkU3wmZjL3wUwiEJNEH/LmxH
 ZaBcb4lU2mapk27o4+KsJmMq3gFfR+ISwdl4B52bZIxjsliimZ8ZPVu5SK+Wv3ha0/7fed
 av0Jlaks3rS5Wn4IIT2EUVn11oHOYJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774853698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zeFi1kedmcawwUQjn0XmQPE8rTjeYaz4FKO4GjTVKkw=;
 b=Xm/rjHnn5XIqsxKBh4HE2lEE8YfbpMdHZJJFHR/1la5wUvvfx5EiYltOzotlPxRkhh/JSe
 tGXlVtksJ0z5r7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 766934A0A2;
 Mon, 30 Mar 2026 06:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sAO1G0Ieymn8fAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 30 Mar 2026 06:54:58 +0000
Message-ID: <29b1ca90-9f7a-408e-bdc5-2815b5ea54f5@suse.de>
Date: Mon, 30 Mar 2026 08:54:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260326100248.1171828-1-wenst@chromium.org>
 <20260326100248.1171828-2-wenst@chromium.org>
 <243dbc45-cb11-4dfe-b8d1-e08f1b5f73b6@suse.de>
 <CAGXv+5F+F9oHjuUPwf-r2qKxDdXFuNV7w5Q8qogW=GXxE0GT3A@mail.gmail.com>
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
In-Reply-To: <CAGXv+5F+F9oHjuUPwf-r2qKxDdXFuNV7w5Q8qogW=GXxE0GT3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,lists.infradead.org];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:dkim, suse.de:mid,
 suse.de:email]
X-Rspamd-Queue-Id: B52B44D1F1
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

Am 27.03.26 um 10:38 schrieb Chen-Yu Tsai:
> On Fri, Mar 27, 2026 at 3:21 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 26.03.26 um 11:01 schrieb Chen-Yu Tsai:
>>> From: Rob Herring <robh@kernel.org>
>>>
>>> Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
>>> drm_mode_create_dumb. This flag is for internal kernel use to indicate
>>> if dumb buffer allocation needs a kernel mapping. This is needed only for
>>> GEM DMA where creating a kernel mapping or not has to be decided at
>>> allocation time because creating a mapping on demand (with vmap()) is not
>>> guaranteed to work.
>> I still don't understand what you're trying to achieve. As I pointed
>> out, ever driver's memory manager potentially requires a vmap. Passing
>> around flags will not solve that problem. If vmap is not possible, the
>> driver should not provide the vmap callbacks in the first place.
> I'm trying to convert the Rockchip and Exynos drivers to the GEM DMA

Ok.

> helpers. Both have their reasons for not using the helpers, one of them
> being that the DRM device is not the DMA device. This is already fixed
> by my other series. Both drivers also set DMA_ATTR_NO_KERNEL_MAPPING
> for buffer allocations other than the one used by fb_helper.
>
> Exynos's GEM implementation also sets extra DMA attributes at the
> allocation phase for their custom GEM create ioctl. But otherwise
> exynos is just reimplementing all the GEM DMA helpers in almost
> identical fashion. And to your point, exynos does not provide the
> vmap callback.
>
> Rockchip's GEM implementation splits the code path between DMA and
> IOMMU usage as it needs to attach and detach the DMA device from the
> IOMMU domain on the fly. This predates the DMA IOMMU framework. This
> GEM implementation provides the vmap callback, which will fail for
> direct DMA allocations without the kernel mapping.
>
> There's also something fishy about Rockchip's DRM driver. It's using
> fbdev-dma, even though it's not based on the GEM DMA helpers or even
> drm_gem_dma_object.

Oh!


>
> As you are against changing the existing *_dumb_create() interface,
> I will look into reusing drm_gem_dma_object with driver-specific
> functions. I believe I will need to keep patch 2 adding dma_attrs
> though. Would that be acceptable?

I think so. Sharing code is good, but I don't like these flags that 
change a function's overall behavior. I think that's the case here. 
Flags are OK when they extent or modify a little detail, but extensively 
used the affected code becomes unmaintainable. It's better to have a 
dedicated function for such special cases. What you could do is to 
provide a separate helper that allocates an object with the specific 
vmap behavior and use it for these drivers. The allocator function 
should also set dedicated gem-object funcs w/o vmap/vunmap where 
possible.  Drivers can then pick the helpers.

If you 're looking for an example, take a look at commit 660cd44659a0 
("drm/shmem-helper: Import dmabuf without mapping its sg_table")  and 
it's patch series.  With gem-shmem, many drivers don't work correctly 
with the sg-table imported.  The commit provides them with a separate 
import helper that takes care of this.

Best regards
Thomas


>
> Once again, thank you for your patience.
>
>
> ChenYu
>
>
>> Best regards
>> Thomas
>>
>>> Several drivers are using reimplementing the GEM DMA helpers because
>>> they distinguish between kernel and userspace allocations to create a
>>> kernel mapping or not. Adding a flag allows migrating these drivers
>>> to the helpers while preserving their existing behavior. These include
>>> exynos, rockchip, and previously mediatek.
>>>
>>> Update the callers of drm_mode_dumb_create() to set
>>> drm_mode_dumb_create.flags to appropriate defaults. Currently, flags can
>>> be set to anything by userspace, but is unused within the kernel. Let's
>>> force flags to zero (no kernel mapping) for userspace callers by default.
>>> For in kernel clients, set DRM_MODE_DUMB_KERNEL_MAP by default. Drivers
>>> can override this as needed.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> [wenst@chromium.org: Emit warning (once) if args->flags is not zero]
>>> [wenst@chromium.org: Moved flag def. to include/drm/drm_dumb_buffers.h]
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> Changes since v2:
>>> - Switched to drm_warn_once()
>>> - Moved flag definition from include/uapi/ to include/drm/drm_dumb_buffers.h
>>> - Reworded commit message
>>>
>>> Changes since v1:
>>> - Emit warning if args->flags is not zero
>>> ---
>>>    drivers/gpu/drm/drm_client.c       | 2 ++
>>>    drivers/gpu/drm/drm_dumb_buffers.c | 4 ++++
>>>    include/drm/drm_dumb_buffers.h     | 3 +++
>>>    3 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
>>> index 46c465bce98c..3d3e61823cc1 100644
>>> --- a/drivers/gpu/drm/drm_client.c
>>> +++ b/drivers/gpu/drm/drm_client.c
>>> @@ -14,6 +14,7 @@
>>>    #include <drm/drm_client_event.h>
>>>    #include <drm/drm_device.h>
>>>    #include <drm/drm_drv.h>
>>> +#include <drm/drm_dumb_buffers.h>
>>>    #include <drm/drm_file.h>
>>>    #include <drm/drm_fourcc.h>
>>>    #include <drm/drm_framebuffer.h>
>>> @@ -404,6 +405,7 @@ drm_client_buffer_create_dumb(struct drm_client_dev *client, u32 width, u32 heig
>>>        dumb_args.width = width;
>>>        dumb_args.height = height;
>>>        dumb_args.bpp = drm_format_info_bpp(info, 0);
>>> +     dumb_args.flags = DRM_MODE_DUMB_KERNEL_MAP;
>>>        ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
>>>        if (ret)
>>>                return ERR_PTR(ret);
>>> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
>>> index e2b62e5fb891..60f4c2d08641 100644
>>> --- a/drivers/gpu/drm/drm_dumb_buffers.c
>>> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
>>> @@ -233,6 +233,10 @@ int drm_mode_create_dumb_ioctl(struct drm_device *dev,
>>>        struct drm_mode_create_dumb *args = data;
>>>        int err;
>>>
>>> +     if (args->flags)
>>> +             drm_warn_once(dev, "drm_mode_create_dumb.flags is not zero.\n");
>>> +     args->flags = 0;
>>> +
>>>        err = drm_mode_create_dumb(dev, args, file_priv);
>>>        if (err) {
>>>                args->handle = 0;
>>> diff --git a/include/drm/drm_dumb_buffers.h b/include/drm/drm_dumb_buffers.h
>>> index 1f3a8236fb3d..4657e44533f4 100644
>>> --- a/include/drm/drm_dumb_buffers.h
>>> +++ b/include/drm/drm_dumb_buffers.h
>>> @@ -6,6 +6,9 @@
>>>    struct drm_device;
>>>    struct drm_mode_create_dumb;
>>>
>>> +/* drm_mode_create_dumb flags for internal use */
>>> +#define DRM_MODE_DUMB_KERNEL_MAP     (1<<0)
>>> +
>>>    int drm_mode_size_dumb(struct drm_device *dev,
>>>                       struct drm_mode_create_dumb *args,
>>>                       unsigned long hw_pitch_align,
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


