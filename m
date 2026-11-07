Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F219606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LV0xyQZa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A0D10E51E;
	Sat,  7 Nov 2026 07:31:38 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2942410E527
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 07:31:33 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso9333355e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794036691; x=1794641491; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GtaWYHPm4HYRZp6fsjCqnEzPGr6jgfDenl0ZwJSm4zI=;
 b=LV0xyQZaMJrErkOCFTamyFF48UWPlD0ozmsgNEqCnUSIVildAhCz6slbZVcG04EDFi
 3NnZnN/V64GNCO/HuHzHJY/6BOHwdw9mnpR89M0KtixOQLpKxxZr/aAOpTl0qKFHG1ta
 alm0L8+fXdgJTppsRrq3pVQFqujragxk+8B/GwmhFOrKs1BOAqkEgVSD33OX7grFeryg
 pUnrCFt4mXLyZMaaF9ThvplHsbKx+6GXZ9T0gg1fdnmkpGI7tI0aRON+FRR05FxHYG3J
 IQJOR0k2Fd3jDuySB8CqBZLIthEtWk8yvj1QJxN0mu6iJq3GwxBFRW3Ivhv5Je3f8VwY
 Frjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036691; x=1794641491;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GtaWYHPm4HYRZp6fsjCqnEzPGr6jgfDenl0ZwJSm4zI=;
 b=HON3OU7/EU201RfrFsJb4wAdrUwXEpz+bQyE8UE197067wmIbo2lIztkG08zzGFtzO
 O+XbcL9KERODEN8zJVYsTviBYKpag+Z+heuhPF1OursiDmuDqlUhDqOH0AYW7nqE77Po
 YRdebbbUUvRt4tuZG7IVTEjY0WrzaF/U6NzCbJvOG909822nzrjpFanGX0E7m+KpVWiK
 R63yepVQRF8i5qXxJazEptt/9MsrU+hRnR9kY0PVVvJEtpMW4f9yYWl6qa/uqvGn3EvR
 GKZpWD63AKJvd5sRnf/w3djtDNLicXcwYs5vRkkX3jCXANUVbnhArgjthXTMCo7YgZgf
 HApg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkeAszagUBIEHxVkuAL2UMd3aNYsGdfXYJ+IT5Wet78XnAHDZxIvZYG11+2N5dIsw0kF0PubQ4nxc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+tEnn6rJo/0WgtAaEn2Wx0sjZIZaJrHMLdXJs8Uvd2S141gUgR
 l6oXaB8bdzlX5/i15K4xsUrMP6icworjmC7CMHHM0Mwbat7dJBVKJBtV
X-Gm-Gg: AYBFou1OxlcuURng1Rw9wbKeQwoUGtD6zZqVoPDj0JiATPgQjpv25XwDDQmSygEginZ
 ohHc/rXn0mZEuKoRWQ/nhrrNFouTM8NJE04OtdylOzf3eU8fsnLN4gJN0xXFSrEeawva7dDM1Kk
 v42eSGZaLeJbP9eOvGiHQOkGF1EDUcDJ2gSlsAvNhq/rvSFtxpk5Nd4RxpxlrkxQ8WXn8ec7078
 3+5+5CiXqVq12rNYm8Utma7456t4nS8ph8482h88NWZkFvAAdqOU+09hPB41TpmTHutYLNm9IkM
 IkTnzyCRsj9z5C3g8F8SuVS9ehOXXQ3EJml5BXTPM4P0rrahHrc6XuCccL4u3bI+NLLVf0JYaCA
 oLrUZ0olQx+1xaxr0dV2woeX/sy/2QrBQQbtb8BSBDAMghc6WJd8RM9RCm0w/OXoUkkfJ/FH2Wt
 fb5GtuD3zaVrcbnnGAnKTsoFnwf5QllYfT6WyDX6FGGB6IcT2ah8iKSxqoVLe0dCaT7bQTxnvnV
 azxiS0POPGOy5Nd3CpMD33gbDmi21N1gJRokLVdumqmy6n4LDYszzRO23Ac5+qiCp7aAjC3GG3C
 GXcVJNtEd8izr0BeMa9DkZHnmUoQNfmduLWNsfFRDxjq8zKxK0+P2ZBAtIHrZWG9VHy0OpuVZY7
 nVA==
X-Received: by 2002:a05:600c:6990:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4b6dd82aa17mr71513925e9.9.1794036691250; 
 Fri, 06 Nov 2026 23:31:31 -0800 (PST)
Received: from ?IPV6:240e:47e:5028:4996:f1e2:8616:8524:8b7?
 ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e2e9ad7esm45804755e9.1.2026.11.06.23.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 23:31:30 -0800 (PST)
Message-ID: <74b9133d-92bd-4fe0-898c-340c2fd46fd4@gmail.com>
Date: Sat, 7 Nov 2026 07:31:26 +0000
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

I can't find v2 in the archives ; it seems it wasn't CC'd to the list.

Could you resend it to the list as a new thread, as is customary for new 
versions?


Thank you,
Oarora Etimis
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
