Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C8606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gbRwd7AB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VwKq3I6D;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gbRwd7AB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VwKq3I6D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B5F10F33A;
	Tue, 24 Nov 2026 08:46:35 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A239D10F339
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:46:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D8971F7B4;
 Tue, 24 Nov 2026 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795509973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t2InmFP8kvTVD6z/BeTy4wQM7UAdsechpDXBMaZIH20=;
 b=gbRwd7ABdAogns/wr3BXb9iFr9SpqrUkK/CskB4SuKe6h9+bYnT4fnt8/lmApdfuBEqqHX
 nDYBxRZvTbNfi8+q4PMcwl/hcYZKA8sSM78732o6Y0JZCtMgJCwxouckrc5UjvUKq/7f7a
 hLhQqeHiVuZ4rgpc7pJHaD+FVhW/2Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795509973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t2InmFP8kvTVD6z/BeTy4wQM7UAdsechpDXBMaZIH20=;
 b=VwKq3I6D04GRoWt0uGkbnL9Mje8Eyj4D1Bjce/Q+EdyEZ/JZ+SgygWvmyVgBzYN2zLfUYQ
 ZxIz8KgpjbM9IcCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795509973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t2InmFP8kvTVD6z/BeTy4wQM7UAdsechpDXBMaZIH20=;
 b=gbRwd7ABdAogns/wr3BXb9iFr9SpqrUkK/CskB4SuKe6h9+bYnT4fnt8/lmApdfuBEqqHX
 nDYBxRZvTbNfi8+q4PMcwl/hcYZKA8sSM78732o6Y0JZCtMgJCwxouckrc5UjvUKq/7f7a
 hLhQqeHiVuZ4rgpc7pJHaD+FVhW/2Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795509973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t2InmFP8kvTVD6z/BeTy4wQM7UAdsechpDXBMaZIH20=;
 b=VwKq3I6D04GRoWt0uGkbnL9Mje8Eyj4D1Bjce/Q+EdyEZ/JZ+SgygWvmyVgBzYN2zLfUYQ
 ZxIz8KgpjbM9IcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAFA61339F;
 Tue, 24 Nov 2026 08:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kvhHGtROBWtwHgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 24 Nov 2026 08:46:12 +0000
Message-ID: <d9212a46-b5ea-4bee-a1b3-052549cc4ed6@suse.de>
Date: Tue, 24 Nov 2026 09:46:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4] drm/gud: move format init from gud_probe()
To: Ruben Wauters <ruben.wauters@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261123154638.2298-1-ruben.wauters@linux.dev>
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
In-Reply-To: <20261123154638.2298-1-ruben.wauters@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 FREEMAIL_TO(0.00)[linux.dev,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 linux.dev:email, suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 23.11.26 um 16:46 schrieb Ruben Wauters:
> As part of the cleanup of gud_probe(), this patch splits off format init
> code from gud_probe into it's own function. This makes the code more
> compartmentalised and easier to follow, and makes gud_probe() smaller
> and also easier to read.
>
> Signed-off-by: Ruben Wauters <ruben.wauters@linux.dev>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I have two minor comments for you to consider.

Best regards
Thomas

> ---
> V1 -> V2:
> - Removed output parameters for gud_get_formats()
> - Added gud_get_max_buffer_size() helper function
>
> Apologies this v2 took so long
>
> V2 -> V3:
> - Fix potential num_formats underflow
> - Skip XRGB8888 in size calculations if emulated
> - Remove redundant r1 and XRGB1111 size calculations
>
> V3 -> V4
> - Take XRGB8888 emulated format into account when calculating
>    max_buffer_size
> ---
>   drivers/gpu/drm/gud/gud_drv.c | 185 ++++++++++++++++++++--------------
>   1 file changed, 111 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
> index 680447f426f3..1ffb2a4fc901 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -435,11 +435,115 @@ static void gud_free_buffers_and_mutex(void *data)
>   	mutex_destroy(&gdrm->ctrl_lock);
>   }
>   
> -static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
> +static size_t gud_get_max_buffer_size(struct gud_device *gdrm, u32 *formats, u32 num_formats)
> +{
> +	struct drm_device *drm = &gdrm->drm;
> +	size_t max_buffer_size = 0;
> +	size_t fmt_buf_size;
> +	int i;

Small detail: num_format, which you're comparing to is unsigned. So 
using unsigned for i is preferable.

> +
> +	for (i = 0; i < num_formats; i++) {
> +		const struct drm_format_info *info = drm_format_info(formats[i]);
> +
> +		/* Substitute emulated XRGB8888 for proper format */
> +		if (formats[i] == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
> +			info = gdrm->xrgb8888_emulation_format;
> +
> +		fmt_buf_size = drm_format_info_min_pitch(info, 0, drm->mode_config.max_width) *
> +							 drm->mode_config.max_height;
> +		max_buffer_size = max(max_buffer_size, fmt_buf_size);
> +	}
> +
> +	return max_buffer_size;
> +}
> +
> +static int gud_get_formats(struct gud_device *gdrm, u32 *formats)
>   {
>   	const struct drm_format_info *xrgb8888_emulation_format = NULL;
>   	bool rgb565_supported = false, xrgb8888_supported = false;
>   	unsigned int num_formats_dev, num_formats = 0;
> +	u8 *formats_dev;
> +	struct drm_device *drm = &gdrm->drm;
> +	struct device *usb_device = gdrm->drm.dev;
> +	int ret, i;

Same comment here about i being signed.

> +
> +	formats_dev = devm_kmalloc(usb_device, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
> +	if (!formats_dev)
> +		return -ENOMEM;
> +
> +	ret = gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FORMATS_MAX_NUM);
> +	if (ret < 0)
> +		return ret;
> +
> +	num_formats_dev = ret;
> +	for (i = 0; i < num_formats_dev; i++) {
> +		const struct drm_format_info *info;
> +		u32 format;
> +
> +		format = gud_to_fourcc(formats_dev[i]);
> +		if (!format) {
> +			drm_dbg(drm, "Unsupported format: 0x%02x\n", formats_dev[i]);
> +			continue;
> +		}
> +
> +		if (format == GUD_DRM_FORMAT_R1)
> +			info = &gud_drm_format_r1;
> +		else if (format == GUD_DRM_FORMAT_XRGB1111)
> +			info = &gud_drm_format_xrgb1111;
> +		else
> +			info = drm_format_info(format);
> +
> +		switch (format) {
> +		case GUD_DRM_FORMAT_R1:
> +			fallthrough;
> +		case DRM_FORMAT_R8:
> +			fallthrough;
> +		case GUD_DRM_FORMAT_XRGB1111:
> +			fallthrough;
> +		case DRM_FORMAT_RGB332:
> +			fallthrough;
> +		case DRM_FORMAT_RGB888:
> +			if (!xrgb8888_emulation_format)
> +				xrgb8888_emulation_format = info;
> +			break;
> +		case DRM_FORMAT_RGB565:
> +			rgb565_supported = true;
> +			if (!xrgb8888_emulation_format)
> +				xrgb8888_emulation_format = info;
> +			break;
> +		case DRM_FORMAT_XRGB8888:
> +			xrgb8888_supported = true;
> +			break;
> +		}
> +
> +		if (format == GUD_DRM_FORMAT_R1 || format == GUD_DRM_FORMAT_XRGB1111)
> +			continue; /* Internal not for userspace */
> +
> +		formats[num_formats++] = format;
> +	}
> +
> +	if (!num_formats && !xrgb8888_emulation_format) {
> +		dev_err(usb_device, "No supported pixel formats found\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Prefer speed over color depth */
> +	if (rgb565_supported)
> +		drm->mode_config.preferred_depth = 16;
> +
> +	if (!xrgb8888_supported && xrgb8888_emulation_format) {
> +		gdrm->xrgb8888_emulation_format = xrgb8888_emulation_format;
> +		formats[num_formats++] = DRM_FORMAT_XRGB8888;
> +	}
> +
> +	devm_kfree(usb_device, formats_dev);
> +
> +	return num_formats;
> +}
> +
> +static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
> +{
> +	int num_formats = 0;
>   	struct usb_endpoint_descriptor *bulk_out;
>   	struct gud_display_descriptor_req desc;
>   	struct device *dev = &intf->dev;
> @@ -447,9 +551,8 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   	struct gud_device *gdrm;
>   	struct drm_device *drm;
>   	struct device *dma_dev;
> -	u8 *formats_dev;
>   	u32 *formats;
> -	int ret, i;
> +	int ret;
>   
>   	ret = usb_find_bulk_out_endpoint(intf->cur_altsetting, &bulk_out);
>   	if (ret)
> @@ -510,81 +613,16 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   	drm->mode_config.helper_private = &gud_mode_config_helpers;
>   
>   	/* Format init */
> -	formats_dev = devm_kmalloc(dev, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
>   	/* Add room for emulated XRGB8888 */
>   	formats = devm_kmalloc_array(dev, GUD_FORMATS_MAX_NUM + 1, sizeof(*formats), GFP_KERNEL);
> -	if (!formats_dev || !formats)
> +	if (!formats)
>   		return -ENOMEM;
>   
> -	ret = gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FORMATS_MAX_NUM);
> -	if (ret < 0)
> -		return ret;
> -
> -	num_formats_dev = ret;
> -	for (i = 0; i < num_formats_dev; i++) {
> -		const struct drm_format_info *info;
> -		size_t fmt_buf_size;
> -		u32 format;
> -
> -		format = gud_to_fourcc(formats_dev[i]);
> -		if (!format) {
> -			drm_dbg(drm, "Unsupported format: 0x%02x\n", formats_dev[i]);
> -			continue;
> -		}
> -
> -		if (format == GUD_DRM_FORMAT_R1)
> -			info = &gud_drm_format_r1;
> -		else if (format == GUD_DRM_FORMAT_XRGB1111)
> -			info = &gud_drm_format_xrgb1111;
> -		else
> -			info = drm_format_info(format);
> -
> -		switch (format) {
> -		case GUD_DRM_FORMAT_R1:
> -			fallthrough;
> -		case DRM_FORMAT_R8:
> -			fallthrough;
> -		case GUD_DRM_FORMAT_XRGB1111:
> -			fallthrough;
> -		case DRM_FORMAT_RGB332:
> -			fallthrough;
> -		case DRM_FORMAT_RGB888:
> -			if (!xrgb8888_emulation_format)
> -				xrgb8888_emulation_format = info;
> -			break;
> -		case DRM_FORMAT_RGB565:
> -			rgb565_supported = true;
> -			if (!xrgb8888_emulation_format)
> -				xrgb8888_emulation_format = info;
> -			break;
> -		case DRM_FORMAT_XRGB8888:
> -			xrgb8888_supported = true;
> -			break;
> -		}
> -
> -		fmt_buf_size = drm_format_info_min_pitch(info, 0, drm->mode_config.max_width) *
> -			       drm->mode_config.max_height;
> -		max_buffer_size = max(max_buffer_size, fmt_buf_size);
> -
> -		if (format == GUD_DRM_FORMAT_R1 || format == GUD_DRM_FORMAT_XRGB1111)
> -			continue; /* Internal not for userspace */
> -
> -		formats[num_formats++] = format;
> -	}
> +	num_formats = gud_get_formats(gdrm, formats);
> +	if (num_formats <= 0)
> +		return num_formats;
>   
> -	if (!num_formats && !xrgb8888_emulation_format) {
> -		dev_err(dev, "No supported pixel formats found\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Prefer speed over color depth */
> -	if (rgb565_supported)
> -		drm->mode_config.preferred_depth = 16;
> -
> -	if (!xrgb8888_supported && xrgb8888_emulation_format) {
> -		gdrm->xrgb8888_emulation_format = xrgb8888_emulation_format;
> -		formats[num_formats++] = DRM_FORMAT_XRGB8888;
> -	}
> +	max_buffer_size = gud_get_max_buffer_size(gdrm, formats, num_formats);
>   
>   	if (desc.max_buffer_size)
>   		max_buffer_size = le32_to_cpu(desc.max_buffer_size);
> @@ -650,7 +688,6 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   		return ret;
>   
>   	devm_kfree(dev, formats);
> -	devm_kfree(dev, formats_dev);
>   
>   	drm_client_setup(drm, NULL);
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


