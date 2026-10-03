Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7A4CA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 11:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9436910E909;
	Sat,  3 Oct 2026 11:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QePVbfmR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF53910E89A
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791026581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6DEk79+AjGFUJq3XsqFxT4woiJPH49kvRHU0q9Llf8=;
 b=QePVbfmRAJWTwrsrzkV93bR+te0zxNYuBF7kQkDOSw92UJJ8WEtV5Er5RLzawKZUItfHwW
 0nvf2BYZHmKiHFk+QpAowm+m3nrjQs6HkpecoVsRjx5EjT3pXdWbxjlj8LXFJDbvbg0u+g
 zIHVh0yWJdnZenh/hNbNK7nSUhTB8Fw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-mN3UE1BvP4C0x-ohZAlKNw-1; Sat, 03 Oct 2026 07:22:57 -0400
X-MC-Unique: mN3UE1BvP4C0x-ohZAlKNw-1
X-Mimecast-MFC-AGG-ID: mN3UE1BvP4C0x-ohZAlKNw_1791026576
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so205193f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 04:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791026576; x=1791631376;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n6DEk79+AjGFUJq3XsqFxT4woiJPH49kvRHU0q9Llf8=;
 b=ZbvfFnkmM99odeaQT/O+Z0Hm0yeOcxmw1y9oY8507xlwxH6LDrnt4FS9T0Yxn3uAqU
 wmMWkPCr+Jmz4ewqdi0mQDQf0i0PLwzXaAnYpM2LHiRrmMX952KgFDY8DHgjav/W7nXQ
 ahbMti6Wngq+ccgj4RwTzF5F9zPHAkLSMze0B8WNd5fOL4C28N+iLLcz8D2eeBTPPEMZ
 9NyTlDXN1ghDWr6WcMsu+ObOT4xp31gTuJrhyCQf4Nvrw/PzzjrrBNWKcb3/8nry7EiL
 yxsh/tnuaTdn2pasurE++6kCne05B86aWSmuFRWwAlBVJ7/0AQfiD2zcZGGIpLE6JIfT
 Pcew==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8LNOMrjn6CLKe/8qb4k5KwnE9uroWmvj9xTopW0iSv+kxsLplxTRqhT3J5uRDlGMud0EIe/uuiL0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLvFosnKkVNCvWZz8c+29XvlgzhKJzI6lYcu6aVZxFbghUUHzu
 0Yss0k9ubYVlfy6bv/vqRjrtVG2XN0z9wnmMhLQ6zdo9Z7etg2SJ+ceZ3aWgedZBxth02xoJoZD
 t2jEnmy5J6jlLaa6+HR+R1/hswy7UiS6GWTLYGaXnQuLe5tCE+e2ONOirk0slYOOERJTq5w==
X-Gm-Gg: AYBFou2r6ZGvxUO+wiuYOnntuCUiO9lL1i4qtVvBiTzRL/dxv54Dh/bgTEXlUmYbHJu
 Ld9A0KGehkBNFESbnr8FyyT+8pkF6nkbdaKUJ4x4dcblPPjH59eW1GAME2qtfWGDaTZCDQ9Xx1i
 +Dnw66YSN+d3e0Gu+m6iqqJHgjQxa4dObwol2W7oRDXxlKO1zst/J82BqUlZRt9EckOBdMpwgTx
 awbcfY6MfjfkL/0hDO7sWuil+wn/odd7dR8kkJvKRzYXONOhS1lamGUeN1LkGxhwD19QKprl6CG
 u0x7bi5oGxog0PGUAMQ+O72b6rHFOyaw6mivhxukccDo0qO4EYzhpgEVWnIIrCgYWEUwG8E7PoG
 rkSt1jXWA/P4m5boa45ox22LG0afciY+29eyVHxPkpAHXepZacUVrwavYR+zdU+6tYg==
X-Received: by 2002:a05:6000:18aa:b0:48b:1b1:af12 with SMTP id
 ffacd0b85a97d-48b127623bamr8872508f8f.56.1791026576000; 
 Sat, 03 Oct 2026 04:22:56 -0700 (PDT)
X-Received: by 2002:a05:6000:18aa:b0:48b:1b1:af12 with SMTP id
 ffacd0b85a97d-48b127623bamr8872483f8f.56.1791026575557; 
 Sat, 03 Oct 2026 04:22:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b383065a4sm11069220f8f.44.2026.10.03.04.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 04:22:53 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v9 09/21] drm/tiny: migrate panel-mipi-dbi to connector
 luminance
In-Reply-To: <20261002190030.211356-10-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-10-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 13:22:51 +0200
Message-ID: <xlv1h5j3gh9w.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VR3V5CyBb8Mr8ESeOStYnhRLhOE0TAAR65Tm2eLCLpY_1791026576
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

Mario Limonciello <mario.limonciello@amd.com> writes:

> Attach the connector LUMINANCE property for MIPI DBI compatible panels
> and retain the legacy backlight class interface only when DRM_LUMINANCE is
> disabled.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/tiny/Kconfig          | 2 +-
>  drivers/gpu/drm/tiny/panel-mipi-dbi.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f0e72d4b6a470..e61a429538bc0 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -73,7 +73,7 @@ config DRM_PANEL_MIPI_DBI
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_MIPI_DBI
> -	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
>  	select VIDEOMODE_HELPERS
>  	help
>  	  Say Y here if you want to enable support for MIPI DBI compatible
> diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> index 60cd65cae41d8..730f1b219fdec 100644
> --- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> +++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> @@ -485,6 +485,9 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  	drm_connector_helper_add(connector, &panel_mipi_dbi_connector_helper_funcs);
> +	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
> +	if (ret)
> +		return ret;
>

I don't see how this could work...

The drm_mipi_dbi_connector_attach_luminance_property() helper only attaches a
LUMINANCE property to the connector if DRM_LUMINANCE is enabled and backlight
is not NULL.

But if DRM_LUMINANCE is enabled, then backlight will always be NULL given that
the drivers/gpu/drm/tiny/panel-mipi-dbi.c driver does:

        dbidev->backlight = devm_of_find_backlight(dev);

and devm_of_find_backlight() is just a stub that unconditionally return NULL if
BACKLIGHT_CLASS_DEVICE is disabled:

https://elixir.bootlin.com/linux/v7.3-rc5/source/include/linux/backlight.h#L441

I don't think we will be able to add support for the LUMINANCE property to MIPI
DBI drivers unless the drivers DT binding are changed. Or maybe what this shows
is that a backlight backend is really needed.

I would leave these drivers out for now and then later figure out how to make
them work without breaking the backlight sysfs interface.

Maybe what can be done is to add a new CONFIG_BACKLIGHT_SYSFS Kconfig symbol,
that defaults to y but allows the sysfs interface to be disabled. That way,
you could still have CONFIG_BACKLIGHT_CLASS_DEVICE enabled but prevent the
uAPI breakage.

Then in this MIPI DBI drivers you could do:

select DRM_LUMINANCE if !CONFIG_BACKLIGHT_SYSFS, or something like that.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

