Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D721610BA432
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 07:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE0010E184;
	Fri, 27 Mar 2026 07:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="C1vZXwCB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N2Gxn8OX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C1vZXwCB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N2Gxn8OX";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C6A10E184
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 07:21:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D92D5BDBD;
 Fri, 27 Mar 2026 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774596110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sVrpq9e5iFznr5g1E74jpSmarowMkSRfs5VsOhTZA5o=;
 b=C1vZXwCB8NGuNoXlDQ7eMGe2yKHKQnjtlPT9hPpPKB3tE2GRdk9xQW1P4Xfb/nyJS4oCIj
 BK0+gfwA9yU2oGE58S3HcJI43wQ2d2/ifcOxN3la1lkgnzu0i8lxLDJaLFbpWO2DV5+8vo
 8SMjWn+7QICvoL4mUmmWz1ndm11fh0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774596110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sVrpq9e5iFznr5g1E74jpSmarowMkSRfs5VsOhTZA5o=;
 b=N2Gxn8OX+CecMRJDmj11gIeqk5EHvs8enqiJz3gDJsDh3/yxValR9Fe4AY8tsDyIPy9LIz
 IZzBbiNz68maRsBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774596110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sVrpq9e5iFznr5g1E74jpSmarowMkSRfs5VsOhTZA5o=;
 b=C1vZXwCB8NGuNoXlDQ7eMGe2yKHKQnjtlPT9hPpPKB3tE2GRdk9xQW1P4Xfb/nyJS4oCIj
 BK0+gfwA9yU2oGE58S3HcJI43wQ2d2/ifcOxN3la1lkgnzu0i8lxLDJaLFbpWO2DV5+8vo
 8SMjWn+7QICvoL4mUmmWz1ndm11fh0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774596110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sVrpq9e5iFznr5g1E74jpSmarowMkSRfs5VsOhTZA5o=;
 b=N2Gxn8OX+CecMRJDmj11gIeqk5EHvs8enqiJz3gDJsDh3/yxValR9Fe4AY8tsDyIPy9LIz
 IZzBbiNz68maRsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D96804A0A2;
 Fri, 27 Mar 2026 07:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tVUpMw0wxmkQHAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 07:21:49 +0000
Message-ID: <243dbc45-cb11-4dfe-b8d1-e08f1b5f73b6@suse.de>
Date: Fri, 27 Mar 2026 08:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
To: Chen-Yu Tsai <wenst@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260326100248.1171828-1-wenst@chromium.org>
 <20260326100248.1171828-2-wenst@chromium.org>
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
In-Reply-To: <20260326100248.1171828-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[chromium.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch]; 
 RCPT_COUNT_SEVEN(0.00)[9]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.com:url,suse.de:mid,chromium.org:email,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.com:url,
 imap1.dmz-prg2.suse.org:helo]
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

Am 26.03.26 um 11:01 schrieb Chen-Yu Tsai:
> From: Rob Herring <robh@kernel.org>
>
> Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
> drm_mode_create_dumb. This flag is for internal kernel use to indicate
> if dumb buffer allocation needs a kernel mapping. This is needed only for
> GEM DMA where creating a kernel mapping or not has to be decided at
> allocation time because creating a mapping on demand (with vmap()) is not
> guaranteed to work.

I still don't understand what you're trying to achieve. As I pointed 
out, ever driver's memory manager potentially requires a vmap. Passing 
around flags will not solve that problem. If vmap is not possible, the 
driver should not provide the vmap callbacks in the first place.

Best regards
Thomas

>
> Several drivers are using reimplementing the GEM DMA helpers because
> they distinguish between kernel and userspace allocations to create a
> kernel mapping or not. Adding a flag allows migrating these drivers
> to the helpers while preserving their existing behavior. These include
> exynos, rockchip, and previously mediatek.
>
> Update the callers of drm_mode_dumb_create() to set
> drm_mode_dumb_create.flags to appropriate defaults. Currently, flags can
> be set to anything by userspace, but is unused within the kernel. Let's
> force flags to zero (no kernel mapping) for userspace callers by default.
> For in kernel clients, set DRM_MODE_DUMB_KERNEL_MAP by default. Drivers
> can override this as needed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> [wenst@chromium.org: Emit warning (once) if args->flags is not zero]
> [wenst@chromium.org: Moved flag def. to include/drm/drm_dumb_buffers.h]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Switched to drm_warn_once()
> - Moved flag definition from include/uapi/ to include/drm/drm_dumb_buffers.h
> - Reworded commit message
>
> Changes since v1:
> - Emit warning if args->flags is not zero
> ---
>   drivers/gpu/drm/drm_client.c       | 2 ++
>   drivers/gpu/drm/drm_dumb_buffers.c | 4 ++++
>   include/drm/drm_dumb_buffers.h     | 3 +++
>   3 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index 46c465bce98c..3d3e61823cc1 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -14,6 +14,7 @@
>   #include <drm/drm_client_event.h>
>   #include <drm/drm_device.h>
>   #include <drm/drm_drv.h>
> +#include <drm/drm_dumb_buffers.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
> @@ -404,6 +405,7 @@ drm_client_buffer_create_dumb(struct drm_client_dev *client, u32 width, u32 heig
>   	dumb_args.width = width;
>   	dumb_args.height = height;
>   	dumb_args.bpp = drm_format_info_bpp(info, 0);
> +	dumb_args.flags = DRM_MODE_DUMB_KERNEL_MAP;
>   	ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
>   	if (ret)
>   		return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
> index e2b62e5fb891..60f4c2d08641 100644
> --- a/drivers/gpu/drm/drm_dumb_buffers.c
> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> @@ -233,6 +233,10 @@ int drm_mode_create_dumb_ioctl(struct drm_device *dev,
>   	struct drm_mode_create_dumb *args = data;
>   	int err;
>   
> +	if (args->flags)
> +		drm_warn_once(dev, "drm_mode_create_dumb.flags is not zero.\n");
> +	args->flags = 0;
> +
>   	err = drm_mode_create_dumb(dev, args, file_priv);
>   	if (err) {
>   		args->handle = 0;
> diff --git a/include/drm/drm_dumb_buffers.h b/include/drm/drm_dumb_buffers.h
> index 1f3a8236fb3d..4657e44533f4 100644
> --- a/include/drm/drm_dumb_buffers.h
> +++ b/include/drm/drm_dumb_buffers.h
> @@ -6,6 +6,9 @@
>   struct drm_device;
>   struct drm_mode_create_dumb;
>   
> +/* drm_mode_create_dumb flags for internal use */
> +#define DRM_MODE_DUMB_KERNEL_MAP	(1<<0)
> +
>   int drm_mode_size_dumb(struct drm_device *dev,
>   		       struct drm_mode_create_dumb *args,
>   		       unsigned long hw_pitch_align,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


