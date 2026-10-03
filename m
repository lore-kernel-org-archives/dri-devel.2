Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02728CA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 11:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5205310E861;
	Sat,  3 Oct 2026 11:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WdHajL1f";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755B910E05B
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791025397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7CGE6fSevJn03ZxUp3hLxD+nUmt71trIKNdG07R2pFc=;
 b=WdHajL1feBd/YrIuv9WlPvxtr0VDEDrK7+VeumKdDBtWB07YsE12+iPa/3p61Es+MBraby
 eOA0Vz5xmHBVVbzZ+SKYHxOrbTged7wtkBgfeVrFFrzFQsxO4mU7juY1rs2ZB93j0NTNZf
 k8t+px4d7mcW405+ZEUHfPPao6j7tq8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-OZ1whJ-mMB-WumUebqR6Zw-1; Sat, 03 Oct 2026 07:03:16 -0400
X-MC-Unique: OZ1whJ-mMB-WumUebqR6Zw-1
X-Mimecast-MFC-AGG-ID: OZ1whJ-mMB-WumUebqR6Zw_1791025395
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b027578a4so339071f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 04:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791025395; x=1791630195;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7CGE6fSevJn03ZxUp3hLxD+nUmt71trIKNdG07R2pFc=;
 b=yb4+yi8SXyYthHTDVqwcExy0vxHgw2hPWBNAFKpq7tMxpfoESBda9PzRyCDrcgg4Ez
 3C3MIvyV5NY3stUSnpj+6UxVfiVVdo9mVJWiNzJC/ONdnDa7Buo+CLURdodKdVPaKw5Q
 E7+I4r0U3Og0rYWQsRbVdq4VqtVEWGhfsO0TsJtH/cxKc4fl75lG5oyuqhGXne6vQNIo
 70Wy4XY4BDBsYGlRj9S+f9JNkSEJLTrD+GmYRbkzVfTC8fVqZ5Q4nmyu0rxTPxJA2yUA
 1AgSO0aP5U5sdxBPo4BEc6tT5RihVSDniXSPTV2plTaHivZIsDNreCLf9n0CMqsQh0E5
 XiVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxN8TAtUzcuPcL9V3fa21avAU5Dm/pgK9+TUNUECeCPXszWmaGKC654V6OoOyUJ7z02grVe0Wn/5Jo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIQxJAecfnRgpJdbMI7YuSedaPuCNppinzwHlHwHW5VAoDaV74X
 7Eqg5VysYd96lmpyU8ALSY6SaYUVEK16LcyKwUi4QGlCctllwdWJSqcqX6eKKZJJ2G4kmrQKTez
 vkyj705W1Zjnb6nh4lxcpjNAAiEyC76yh3PYptisbUD1yhhpwOMOWtIFlUCLqseJUWeNAAA==
X-Gm-Gg: AYBFou07J4W+lpo3dsAEqqFB8o5BLr5f5ZK5q7+bEuYEtY8uGhjKAG4vlX64Z8XJwdD
 3AZVxhUx/A/lwJHHF6T/Ax4OLZeqcKqyFgwAfqtEzuSz6DxcjTPK4KPiNCPhSdbar+7mgSfkI+r
 NQCdMI0e4cu4kedTFev93b8o/GiIdESd4mpFL2LALbKewKAYpa4CHYwarSpee0fjt1Iix+rsHHE
 qb4nr+IeaYkGNj5A1BARCjvVlNo19NnRma1RfXgCqOVfQn5IMV8wY32aXzi+iKwOQYUtoLWSH3u
 xA4viXBLOE88bG/KaEqeQmesnOhEB3n6isdAGgmXc8+w//w7gnpYZEIQfDkTH88LYEWWLHhdG3Q
 dxtnYMR32/aJLcmunWWLeCVZyYWPPWfli8YrPSEsw0w88AUS193m4dwSf1z+K3Ca+tA==
X-Received: by 2002:a5d:6f01:0:b0:48a:fdde:5241 with SMTP id
 ffacd0b85a97d-48c47fdf4c3mr3224386f8f.31.1791025394971; 
 Sat, 03 Oct 2026 04:03:14 -0700 (PDT)
X-Received: by 2002:a5d:6f01:0:b0:48a:fdde:5241 with SMTP id
 ffacd0b85a97d-48c47fdf4c3mr3224335f8f.31.1791025394453; 
 Sat, 03 Oct 2026 04:03:14 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253dc9sm11935413f8f.3.2026.10.03.04.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 04:03:12 -0700 (PDT)
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
Subject: Re: [PATCH v9 08/21] drm/mipi-dbi: add connector luminance helpers
In-Reply-To: <20261002190030.211356-9-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-9-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 13:03:11 +0200
Message-ID: <xlv1ld8fgi6o.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9z4YI-5AWVMmHyts-UBBAzVjdESTdvxNnEL7I4kXkd0_1791025395
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

> Add common helpers for MIPI DBI drivers to attach the connector LUMINANCE
> property and forward updates to their backlight backend when
> CONFIG_DRM_LUMINANCE is enabled.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

[...]

> +int drm_mipi_dbi_connector_attach_luminance_property(struct drm_connector *connector)
> +{
> +	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(connector->dev);
> +	struct backlight_device *backlight = dbidev->backlight;
> +
> +	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) || !backlight)
> +		return 0;
> +
> +	return drm_connector_attach_luminance_property(connector, 0,
> +					backlight->props.max_brightness,
> +					backlight->props.brightness);
> +}
> +EXPORT_SYMBOL(drm_mipi_dbi_connector_attach_luminance_property);
> +

Drivers that call drm_connector_attach_luminance_property(), make it
conditional with if IS_ENABLED(CONFIG_DRM_LUMINANCE). I wonder if
should be the same for drivers calling this helper.

That is, instead of bailing out due !IS_ENABLED(CONFIG_DRM_LUMINANCE),
to make drivers do:

        if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) {
               ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
        ...
        }

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

