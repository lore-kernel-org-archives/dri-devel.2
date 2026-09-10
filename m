Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF157C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA84510F35E;
	Thu, 10 Sep 2026 08:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b8/ia5ID";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7008910F35E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789027808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ww5DLB2Q6HbTXqc3AvcjNL7DcG0OH+QY3n8HRzmcc6A=;
 b=b8/ia5IDNKCKEF+GkH/YkMBVXtrNeJExGNcQuNM0BcfBmc7Pj+zyE1U46EjnQ201gP0eYW
 DsJ2On/yzVhsKEX/jSPCr4IjjJRaXArBSC+6keXVzhd87jdbHDtnCUtjrVlJ7l2qLixD5I
 IsIUd59lZyq90yO/G680u2cFdcTQiRw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-gEq5t_KSNsGHgfk6HW0zpg-1; Thu, 10 Sep 2026 04:10:07 -0400
X-MC-Unique: gEq5t_KSNsGHgfk6HW0zpg-1
X-Mimecast-MFC-AGG-ID: gEq5t_KSNsGHgfk6HW0zpg_1789027806
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cd74fc1aaso38728165e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789027806; x=1789632606;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ww5DLB2Q6HbTXqc3AvcjNL7DcG0OH+QY3n8HRzmcc6A=;
 b=E87uqGs6GJ0x0baYGI8ElEokCttOdINtnDM2yqBZ90+Z+VPBbvvMzHpTGCHogxqrTw
 Vu1QCWt1wm0WpYXiCPsq1yPzm+QWIbgG+qEKpFF8s7c22ieAzrJjBBo0erQIvfwUX7eq
 yTzUZvQI09K9efPSAaRfx8F3Tjc/zDs5ZTY5zIc+E6Zkh20c/0DeZ8Q2opQsR51yXSoh
 JpXii5uE3tf5g/+KwnGG1ljVOamzNz6s0WA25ZBzcPW6ySMxNxbhfYqZtMhCsQDILRAr
 ahhy0K0GNwrOf2KJbGg7iUujmhCCVGlXb12o6tBRvESGp8c1CoTjyyI1Hx1ZFvDv0sGX
 fkbA==
X-Gm-Message-State: AFuF++l4z5m/a4X0EIObHqDtzC1U9wdjmLos11teszEq3Wsr9wEebF72
 Jq1fZlaPQ22J2lRdlqmiuXmheeeCfvEoL/mLxDDD5hRFyVIdtC2j56WkjVBZyekKwzYP5rpmsJy
 9PCXcNXThv87Diccndkev8Wuxb7z/z6/XHMmdxgENemA0HID8xBcRHevOlGiX35cesd0ysQ==
X-Gm-Gg: AYBFou30GPadexux/DY5N97FEMMvYgkCw9TReHC3ci3rRTUjsBVYpE6Y3xqMeGKUtTh
 UcjBU2tlxKkbfQ3qbIpDlgYkTV3REO5RXI8FQ3e/XDbD3Cckm8WCzMpPpv70/ud8KVRbGG98gpI
 1YdOT9cDSY3pytgmdMYcUF58BCEVEl4b6Wju91jaSt07zpb98kKBKNxyxOLWuo7n7Dc10oV5t77
 ziUnxQpEapVhFlHh+BKhJlxiwdH0UJ2JEITNBINZsiWxU9G1cQqesSOajxky7ZUINz3q5MLt/Qb
 w4vMpV5GlePxaz4giNlelUSkZpwj56eg26VUSanQrlnfp3IDnZwXCbuntytwt4ztjDSBeWY2pIm
 ln77V/342yBrEv2rY6SXlCeM4RKg7inJXg7pOTNJ4jg07/qKL2rJeguVMSQ==
X-Received: by 2002:a05:600c:8715:b0:49c:fa20:cc06 with SMTP id
 5b1f17b1804b1-49cfe7a30demr323256345e9.29.1789027805773; 
 Thu, 10 Sep 2026 01:10:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:49c:fa20:cc06 with SMTP id
 5b1f17b1804b1-49cfe7a30demr323255955e9.29.1789027805326; 
 Thu, 10 Sep 2026 01:10:05 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883953cfsm41228794f8f.13.2026.09.10.01.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 01:10:04 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
 ilias.apalodimas@linaro.org, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 2/3] drm/edid: Add drm_edid_detect_panel_size()
In-Reply-To: <20260904090850.43060-3-tzimmermann@suse.de>
References: <20260904090850.43060-1-tzimmermann@suse.de>
 <20260904090850.43060-3-tzimmermann@suse.de>
Date: Thu, 10 Sep 2026 10:10:03 +0200
Message-ID: <87y0d9cysk.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 79Q92HGMnNQ8UozHjdXTFuecJ0hPPzXW1AVw49x749U_1789027806
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Add drm_edid_detect_panel_size() to extract the panel's preferred
> display resolution from a given EDID. Required for setting up DRM's
> panel orientation quirks in sysfb drivers.
>
> v4:
> - fix test for EDID PTD (Jani)
> v3:
> - mention use case in documentation (Jani)
> - use is_detailed_timing_descriptor() (Jani)
> - rename helper to drm_edid_detect_panel_size()
> v2:
> - handle EDID without pixel timing descriptor (Sashiko)
> - fix checks for width and height pointers
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/gpu/drm/drm_edid.c | 47 ++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_edid.h     |  2 ++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 9990a836d0b6..1331efb4876c 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -7852,3 +7852,50 @@ bool drm_edid_is_digital(const struct drm_edid *drm_edid)
>  		drm_edid->edid->input & DRM_EDID_INPUT_DIGITAL;
>  }
>  EXPORT_SYMBOL(drm_edid_is_digital);
> +
> +/**
> + * drm_edid_detect_panel_size - Get a panel's size from EDID
> + * @drm_edid: EDID of the panel.
> + * @width: Returns the panel's width in pixels per scanline, if given
> + * @height: Returns the panel's height in scanlines, if given
> + *
> + * This function detects the preferred size of a panel from the given
> + * EDID. There is no such information stored in the EDID block directly,
> + * but the preferred mode often corresponds to the panel's native geometry.
> + *
> + * This helper should only be used during initialization before the
> + * connector is available. For regular use, retrieve the available display
> + * modes with the connector functions.
> + *
> + * Return: Zero on success, or a negative errno code otherwise.
> + */
> +int drm_edid_detect_panel_size(const struct drm_edid *drm_edid,
> +			       unsigned int *width, unsigned int *height)
> +{
> +	const struct edid *edid = drm_edid->edid;
> +	const struct detailed_timing *dt;
> +	const struct detailed_pixel_timing *pt;
> +
> +	/*
> +	 * Use display mode from the Preferred Timing Descriptor. For old
> +	 * and obscure displays, we might need better heuristics.
> +	 */
> +
> +	if (edid->revision < 4 || !(edid->features & DRM_EDID_FEATURE_PREFERRED_TIMING))
> +		return -EINVAL; /* no Preferred Timing Descriptor */
> +

I saw that Jani and you discussed this logic in v3. I originally thought that
your v3 was correct and this one was wrong, but I noticed now that this flag
changed its semantic between 1.3 and 1.4.

So I think that this latest version is correct indeed, 1.3 didn't include the
native pixel format and 1.4 does not either if DRM_EDID_FEATURE_PREFERRED_TIMING
flag is not set.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

