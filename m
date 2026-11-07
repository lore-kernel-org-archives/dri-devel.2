Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A7606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ArJrYcIg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A9D10E584;
	Sat,  7 Nov 2026 07:00:26 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2B410EB45
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 07:00:19 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so10733705e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794034818; x=1794639618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n786pQm1n+c0v7mw5akrNmhoZ378gFgM45vYyIAzf38=;
 b=ArJrYcIgm4jlBRxADzzf1wq4GeZRy7/mHLPkJkl+OH4QErbm9/teIhIF8QWI40aqjK
 38HjvIP/GPBTbCy5gZbwSEnY9gWOYJWCyJ86yKCI6JDfC5M+YTEaDAYimndkf3qMms6x
 JhlscOw2e8LGCat4gW3cVw7fAO0yKzDyu+GmYZvRZwL7dEAGH1opWx2sC6BDaRCybKmv
 n3xoasCHq1mBqMAnxn+Rf5E0Upi3555SMVonPllu8IVNKNtkqN76srNm1I/kjyZNdNDP
 zgwaZSO2D4RM8mBCsd6a63YXRTeImmT87WXhvnlK93SpYVprvGM3fGEgpIOGLAhqNxLR
 hp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794034818; x=1794639618;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n786pQm1n+c0v7mw5akrNmhoZ378gFgM45vYyIAzf38=;
 b=y04sv1KI6KaDKmF2BeCG0uef/p/g2sBSRPh4wjluZ/2dsyVS7mKudFm9l5+CBe35e3
 VxNQniH+taWsgarAn9fXXeffjI1aBp/MABEPMpoQ9HHA7P2I8uWpz7p+btqW9FST+hTc
 TVTCgtzE1t1YzvCWhaD3EBWf8a66priAWd/JuP57XyFQVy/7pGQ97gCNWiUyqb6u2MVf
 p58AWoza3563x6fGO1dtALBC57xlcuDUDNx4n+Mcyr9jxUtuBZSVkL36c23gQuueMPxS
 Aa2i4FOeoONrSWPyKniW9HaFX57ObS9DXv1w7SG6k7XS0LDKKryNaDL0k7uoWStVpdoz
 LRpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/54F6/85aWWOc9c6FDP+mjJoQ9ptIZ2NXKQ9iJLpI7wFgN0GJclVG0eI5Qe9TSp8ZNaLDLSF5E8M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dj4vbpegxRIRNy/jgm4jPNJInwPEzK6XhmJ4fimDDSYHwec5Z
 GaY1AEd/SRs4F+/SRH4eaU+aL+EIpFaGL/E+axFxtlKe7MWGi6cqg4XG
X-Gm-Gg: AYBFou3JqbeU8VUJWe8PpL6uEltG7DWeDB4C2wb0Jaxqwirrx2D+KOICEJ8ZFHxHYUs
 4wCtBIaS9UAk0yeF4m4A7ujZrrRd52Lnnr7KhPcfOAA0ux6OdtUd7coWL0A3WGug7K7HOdVX4w1
 iK9y0P0sqaAsSLCydPD9QhraF9f03VhM83ZbK+BEsObV5tD3eO6bzsnRts49VcPkdcBnoQGAzm9
 ta335UuzJbTX2hJYWvA9dT0Cn5l+/heD6/eC3g4m+1wOFyDwVzXU/RxQuatdbjmYU6AK+abeq7C
 4d9DeCizpORNyed97m6HVZGYfLzCgdDcF6eZRbm0CP62xqgtzza2u4TEJws6uWrQ5tksv2U3doz
 d64xGqWmmBzq0GfislLseQjzlRhn6voojPIyG9rsosWu+QKbx6W3mfB//A6nTof8cwY+W0Wsp3A
 a5ynM+uGHFVlavr78dGYnUzri02dyfcYYu6rnbRgvTrFmZu2+qZ/i0O1J7p3uZ2RzpT6uD3uOfl
 k7CvXVo6iqIMSB6rWLCnc3frk4mnPO720DZNrQ2wIMbFJMaTEWlKCO4Mo/L6UvsCaNP4xIq39SA
 2UmBkgNF5OC1xP3LAwiH/ARJoxjf3jLqAy8pJBCi2yWGOHEKYRZh28FnsE3QJJTQGokwi3y1kUr
 LPw==
X-Received: by 2002:a05:600c:3e8f:b0:4a5:87b3:ddc1 with SMTP id
 5b1f17b1804b1-4b6de4a6ba1mr75908605e9.13.1794034816841; 
 Fri, 06 Nov 2026 23:00:16 -0800 (PST)
Received: from ?IPV6:240e:47e:5028:4996:f1e2:8616:8524:8b7?
 ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d73286cdsm7294188f8f.28.2026.11.06.23.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 23:00:15 -0800 (PST)
Message-ID: <d03a6988-2fe1-4ff3-b18a-31faf3d140f7@gmail.com>
Date: Sat, 7 Nov 2026 07:00:05 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vkms: Set preferred_depth to 24 for XRGB8888
 default
To: Karthik Sarvan <karthiks1mail@gmail.com>, dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, louis.chauvet@bootlin.com, melissa.srw@gmail.com,
 simona@ffwll.ch
References: <20261026071933.48366-1-karthiks1mail@gmail.com>
 <20261107031842.18152-1-karthiks1mail@gmail.com>
Content-Language: en-US
From: Oarora Etimis <oaroraetimis@gmail.com>
In-Reply-To: <20261107031842.18152-1-karthiks1mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>

On 11/7/26 3:18 AM, Karthik Sarvan wrote:
> VKMS defaults to XRGB8888, which has a color depth of 24 bits stored
> in a 32 bpp container. Setting preferred_depth to 24 reports the actual
> depth to userspace (such as Xorg) via DRM_CAP_DUMB_PREFERRED_DEPTH
> rather than returning 0, while keeping the fbdev default intact.
>
> Signed-off-by: Karthik Sarvan <karthiks1mail@gmail.com>
> ---
> v2:
> - Add commit description (Thomas Zimmermann).
>
>   drivers/gpu/drm/vkms/vkms_drv.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 5a640b531d88..10337889b1b0 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -146,12 +146,8 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>   	dev->mode_config.max_height = YRES_MAX;
>   	dev->mode_config.cursor_width = 512;
>   	dev->mode_config.cursor_height = 512;
> -	/*
> -	 * FIXME: There's a confusion between bpp and depth between this and
> -	 * fbdev helpers. We have to go with 0, meaning "pick the default",
> -	 * which is XRGB8888 in all cases.
> -	 */
> -	dev->mode_config.preferred_depth = 0;
> +	/* XRGB8888 has 24 bits of color data stored in 32 bits per pixel. */
> +	dev->mode_config.preferred_depth = 24;
>   	dev->mode_config.helper_private = &vkms_mode_config_helpers;
>   
>   	return vkms_output_init(vkmsdev);
