Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96A4CA5FE8
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 11:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3A710E0D4;
	Sat,  3 Oct 2026 11:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hCbzEPw5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA37C10E0D4
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 11:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791027438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHJZUWTv7rBEBUCND4bSkxxGBQPHEUSgPjoiGT34ol8=;
 b=hCbzEPw5xMyNuYQRLZM+hBXVZBX5vozOY7Ax4ZY9/NvD5JQfo1J4PbfvZ0inKBh2QI1W/c
 7kBRPjoNiiOBTBC5zzfKjYvBV3reROJiSKur+HvpE8R8yWHFsN2uFxNRc1GoE/7pAw0r5s
 YuSD+D5PR72xenrdb6FbXNVEv8uHlL0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-yfli7w52PzKBS5WPs2o01A-1; Sat, 03 Oct 2026 07:37:14 -0400
X-MC-Unique: yfli7w52PzKBS5WPs2o01A-1
X-Mimecast-MFC-AGG-ID: yfli7w52PzKBS5WPs2o01A_1791027434
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a024bce773so7966805e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 04:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791027434; x=1791632234;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lHJZUWTv7rBEBUCND4bSkxxGBQPHEUSgPjoiGT34ol8=;
 b=xm0q/ShKZeu/MD/UDWmyCn6gWgTI2OfcY6qsL8dnBxEJw61wMv6XfU5Mr3eoBznezQ
 EQdSZ5/aRpI8qkqa1aI44rHqCD9c0HUo6IvNI4RsMHYAZKgM2PXojj+uxPnEiPdS3A69
 jGn9ZNg3/3jjPlO6bu38qGH2FBQhf9TivF+5KXGDhnE4oLlKOtcjXDbQLCAnCk7ri5vY
 HAHEqqFum68J94aP0c5TwbOmXBw8zBH9KwZqyQnUHZXK39tX4UBxZ4PlzYVBWLmkgRyJ
 ZHMA+3IKVi55RGYCRjg68wKuVnY1CYnbO+W5yRLdUMTJRsVgzgsCIjHehl1yc+XZIhTV
 sybw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4ii6vIlKmnuGVtRySvzRkOFNmtHON73tiaO0X3W9a+gunoMPJV/oAgfYimAnZ7ikwdN+d1eJryGU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJfDKT64pcXt6AMrkg9v2dSgZhOATbqjT3L0VHUYXfhF/QfZ/wz
 bUrsvQmNK7LX/rNIim5bOwaezIoINEKBcBiuH/ScT35BEbZp6gmIbQMr8UD8X+DLZZdMDR+alHf
 /WF3B8Rtd8FYOc7N7L0OORXD0fxdAW6EpRHX/5qXJwCClvS/jR7q/eD7VIr9Z1BZLC66m8g==
X-Gm-Gg: AYBFou1H+Ie7GmuPEvuM4a8Y2P0J2fyGR6xisbg56Frw2RxWdEiKvGnRtn+r4lYmiob
 0iCaMlKDcOBYWM5hLInnI/i+I6X+nl9fQ5nkEQZfj8o5SDM4sWFUi+/hYSN5ptKCwTarkht2gNu
 cM2BpBbDgrohh3GONr2+SvFIDSSUKWYDvBa0VbTbMjVGbTQshQgy03++j5vYdaLQ0IYk0Sbjqoi
 YF2JBhg4rGVf1gcMYlCGnXR+XFlwJMp88WTPCC2LaIREHveakGcsWolKnMX9+CVrDVhKkM49dUV
 Oe8s31YIKEOjLo3UnEud3ssI4JG50ue4X9g3ka4nb3fDJWk054l9/ToXTfpykG1pl3VgLcj+c23
 WcwBRQLHbXLWqs7QnBL3Ss/tLgPOu00zvm1zZBwsQGpCQqR9idRbPkbK3Hk0S/gtnUw==
X-Received: by 2002:a5d:5f09:0:b0:48a:f464:2cc5 with SMTP id
 ffacd0b85a97d-48c4800d152mr3245846f8f.37.1791027433673; 
 Sat, 03 Oct 2026 04:37:13 -0700 (PDT)
X-Received: by 2002:a5d:5f09:0:b0:48a:f464:2cc5 with SMTP id
 ffacd0b85a97d-48c4800d152mr3245816f8f.37.1791027433222; 
 Sat, 03 Oct 2026 04:37:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380fab11sm11943111f8f.16.2026.10.03.04.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 04:37:12 -0700 (PDT)
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
Subject: Re: [PATCH v9 01/21] drm: add connector LUMINANCE property
In-Reply-To: <20261002190030.211356-2-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-2-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 13:37:11 +0200
Message-ID: <xlv1ece7ggm0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eQMuS0Y8iKvD8DAPQnk_RwH5A3rWYpgDTmGn4OHN6-g_1791027434
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

Hello Mario,

> Panel brightness is a property of a display, and thus of a DRM
> connector. Add an atomic per-connector LUMINANCE range property so
> compositors can manage relative panel luminance together with the rest
> of the display state.
>
> Keep the core backend-agnostic. Drivers create the property with their
> hardware range and implement connector helper callbacks to set luminance
> or disable panel emission. The atomic helpers sequence those callbacks
> around pipeline enable and disable, including luminance-only commits.
>
> The stored property value is independent of display power. A commit made
> while the connector is inactive is retained and applied on the next
> enable; disabling the pipeline does not overwrite it.
>
> LUMINANCE values are relative, driver-defined levels rather than
> absolute luminance in cd/m^2. The interface supports emissive panels as
> well as panels with a separate backlight.
>
> Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
> drivers retain their legacy backlight class ABI unless the new interface
> is explicitly selected, allowing the DRM UAPI and legacy compatibility
> policy to remain separate.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Thanks a lot for the rework. I went through this patch and have no more
objections on the core bits.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

