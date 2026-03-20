Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AC41099B3A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 20:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C287E10EB04;
	Fri, 20 Mar 2026 20:27:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RhHsNnN/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F64C10EB0C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774038439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJMXPSFWArYmrnP7zLSkM+CTFVv6oJClq2Ka1iADR9M=;
 b=RhHsNnN/i7WVOmW6KhKvohRwQtvEIeLF3rrePujJJC8AtmY7ey8sMvbaxAmX8pqqMPyLBl
 OzdOaW6fK9ZIRWO6a5Sd1Jn8cwHLlVhxD9Pu3/uwVB7AiK8lEjgp6QkYgbxp7g//zv9FpS
 nk6/UkE9WL09aj4FsqZAS7XuwXlP2Uw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-LqV9VdXYPa-vZ-YRIUTAXA-1; Fri, 20 Mar 2026 16:27:18 -0400
X-MC-Unique: LqV9VdXYPa-vZ-YRIUTAXA-1
X-Mimecast-MFC-AGG-ID: LqV9VdXYPa-vZ-YRIUTAXA_1774038437
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89c4b118740so120053566d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 13:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774038437; x=1774643237;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MB0+rSNGBKBl0fATluwYhfYR/8s/ouHiFI/my1DN3XI=;
 b=coScTj9WxCqJcV5wOY33XM8IUV32sQvbN4efmQkeYuLPR6ojrsyOpUnqDcqsJ2aq6y
 RufrSzlIwEBdXYUm8LrabuYhUCdbcNVhfvtl2VH93tgtPIu0PVbunK/ErzuRlQyBDJVG
 W2XafJPT9I7Wqr6sYOAolLTy0o2RhvnrZGzFE3X+hbpPBNGNmHKaR9MH3z7q9K9Sxffy
 e9Yb08h8qDRx9HnehfD21neiH8HJPcTD+3CwfaRaKL6kBkxzaEUzYmu/XAgRM07XL6TY
 /kdkB96a+ZaqVbqaQ+uX6lrDY2OGlshsrWwZVib04GRmuVbUzrjQwFwWhb6dGnayOlEF
 Hr2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy7LEe9uEGNrA9av/N2EgxR/2MgcZqtbOCr0vnFO7ETxyEESQKaENcinCh4lz1qOza4fDkjSQLDYk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/ZuFJWH3kCPpQVdIrxrWS5jNtW3p2JywSU03T+bT+UkR6UOoK
 fImnqqCChYc61YENu5z5LLFFdyAKhZTWBty3uqDcRvqMP7YywMZy4IU3n86liHywl4A7GKyzDio
 Xqf/M6OHt+3jlH2j7w/4cZzbmD2VDHH1JRx2Fw9ywYHNr2JuKNYmEXG9Eg25XQuymr6ANdg==
X-Gm-Gg: ATEYQzw0Vpk0xAKMzLQx9reEJuhucxxzzuYl6IAaCAhMCUwemWxgIU3IY3ra3MeFmUr
 GKwdGLo2ogjgaFHdopaGIe5lOn2L/gahKOZgL1aVPEdKt1oxoqHIjCPQix1vSiiXeodkicpmC+9
 YFoDm9AfnsI9zehMJHjSmK2d3zYvKPCjD97H37s/JkkicMguWTLJoYxYuoOC8h4bD5rv9LicgIw
 mPQ8RN2B8qGa/1ax/scApixE7AjJKQrHsk1xZVjknL8bezuTlx6qZYpjfhWhJ12VDqJh7wKqout
 Or/xLzrfvAz8hSZGxCVfURVdDZUDN88xyDeBwZemyg+YAPMv6isTA60CdDJO7BWxekmJwWIKvCW
 g29+wzd00E1N/7/bxRQ==
X-Received: by 2002:ad4:5968:0:b0:89c:4ea7:a70f with SMTP id
 6a1803df08f44-89c859e8c82mr70322186d6.14.1774038437330; 
 Fri, 20 Mar 2026 13:27:17 -0700 (PDT)
X-Received: by 2002:ad4:5968:0:b0:89c:4ea7:a70f with SMTP id
 6a1803df08f44-89c859e8c82mr70321736d6.14.1774038436929; 
 Fri, 20 Mar 2026 13:27:16 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85361ac2sm27015786d6.41.2026.03.20.13.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:27:16 -0700 (PDT)
Message-ID: <5cbcc6ff5b5dd72e0c4737cdff8ef897fa10cb61.camel@redhat.com>
Subject: Re: [PATCH v11 43/65] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
From: lyude@redhat.com
To: Jim Cromie <jim.cromie@gmail.com>, airlied@gmail.com, simona@ffwll.ch, 
 jbaron@akamai.com, gregkh@linuxfoundation.org, Danilo Krummrich
 <dakr@kernel.org>,  Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann	
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Date: Fri, 20 Mar 2026 16:27:15 -0400
In-Reply-To: <20260313132103.2529746-44-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-44-jim.cromie@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p08i90S75B9GEpAZ5Cr6nuf95xsDjXKJ8lWpLdbkGdo_1774038437
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2026-03-13 at 07:20 -0600, Jim Cromie wrote:
> Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
> DRM_CLASSMAP_USE.=C2=A0 This refs the defined & exported classmap, rather
> than re-declaring it redundantly, and error-prone-ly.
>=20
> This resolves the appearance of "class:_UNKNOWN_" in the control file
> for the driver's drm_dbg()s.
>=20
> Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2
> helpers, 3 drivers.")
>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c | 12 +-----------
> =C2=A01 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 5d8475e4895e..d205b58aff70 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -74,17 +74,7 @@
> =C2=A0#include "nouveau_uvmm.h"
> =C2=A0#include "nouveau_sched.h"
> =C2=A0
> -DECLARE_DYNDBG_CLASSMAP(drm_debug_classes,
> DD_CLASS_TYPE_DISJOINT_BITS, 0,
> -=09=09=09"DRM_UT_CORE",
> -=09=09=09"DRM_UT_DRIVER",
> -=09=09=09"DRM_UT_KMS",
> -=09=09=09"DRM_UT_PRIME",
> -=09=09=09"DRM_UT_ATOMIC",
> -=09=09=09"DRM_UT_VBL",
> -=09=09=09"DRM_UT_STATE",
> -=09=09=09"DRM_UT_LEASE",
> -=09=09=09"DRM_UT_DP",
> -=09=09=09"DRM_UT_DRMRES");
> +DRM_CLASSMAP_USE(drm_debug_classes);
> =C2=A0
> =C2=A0MODULE_PARM_DESC(config, "option string to pass to driver core");
> =C2=A0static char *nouveau_config;

