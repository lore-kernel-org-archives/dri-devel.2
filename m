Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D509C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B28A10F45D;
	Tue, 15 Sep 2026 11:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fkP3BfES";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7891A10F45D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789473487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrOHLRfT4Oom2IJCIMxO8ZxH4CpZaDZtjN+oo/YQUdY=;
 b=fkP3BfESVDezRKV6Zbb0/bjlKUd7ZKTULUgND3xg5sPbHQlIF22quoLwBXN03Dc48dh5QS
 CWWtOe9ooan6EV9qFd8Opg2AnfpO7GeUAYF2OEWgXaQFD4wE3tEbJev3Akoz9ej3L3kEnE
 psi4EAbSdOgTNlOialfhvYFKInDurqQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-_XCLaXdTNeGclaCz5hNuKQ-1; Tue, 15 Sep 2026 07:58:06 -0400
X-MC-Unique: _XCLaXdTNeGclaCz5hNuKQ-1
X-Mimecast-MFC-AGG-ID: _XCLaXdTNeGclaCz5hNuKQ_1789473485
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d94a158dc8so65021635ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 04:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789473485; x=1790078285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rrOHLRfT4Oom2IJCIMxO8ZxH4CpZaDZtjN+oo/YQUdY=;
 b=SPWXZmtCTqRDwA6TIgR8BKCkCU2vucDeufP/DE4SulNDYQ+wXP6NwB38E12PyLkmIj
 k+hmWBkh5CkIw+1MFH3Wsh6uLGGrilYnx4kY+aYHXaHEFREDigIC7nApyDaUTx1dIsK6
 Q0Bk8wNgka6EiduWQLbWqua1RfBX/Tg7ktfQjhheSasZGjboHoPmB4eSArXt5ZsB2vCu
 luNh8npMc645TeMONevJaycs+byEoI0jVukFJrVf5s+/UlRRNyKd62nKnv3Wa4510xnS
 UY/E1x1Z4QSYF3W0zl6yBlaGEOAmlLmv1IPVQcDz726yAsvwjyJFyrOdWwyq3HOMf18/
 7r0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0I8ZUO0LzHJ3lvd8hjYthJJ5e0h2DntaVpbzKXVhdenIzjwnohiBUE4rGZZeK49m7xdpHDtuFIqw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkRG2feSRP856MuGmXWpNtC8xKa5gxUHFFgEcrBwA2Xx+Dmafd
 byrLc74gLLVFjUIGvRhnwSEYWyvzwN1F6O5rlW5hqkMtLjZ2d9bnfF92HHXbmOK4TpUWmMUcTe0
 Jk/H3YWAzXWSTudgZrdvP99b4exeF7CUmFWkm17alJ/ti6yGWRpuMuN4UoZNth3zz/mUaqGDyMo
 Thy0LkEBYLBZdsSbakFBlxuhhrLQOVNvoryUyrr9J0eD6P
X-Gm-Gg: AYBFou2wmeCAvpB7nJwhmMozc7u5mvWX7PUz1NO4/NMH9Tj/VociWAFyFtoDObVRcKM
 b5aN28qrA1BWMskUjLZ6QCpQ+VmzSv6dHcQyepONQxsurxBVygXzTRlIN7iyTcjaaAF1Vpp3eg1
 Bv2dvQy6ZI4Ysy+AwUdjiBXjPVxIPvJe1qXxW65MBiRlWSgrzj3FRYt8Z6
X-Received: by 2002:a17:903:f86:b0:2d1:134:b86e with SMTP id
 d9443c01a7336-2dd6c5cc385mr136087595ad.2.1789473485037; 
 Tue, 15 Sep 2026 04:58:05 -0700 (PDT)
X-Received: by 2002:a17:903:f86:b0:2d1:134:b86e with SMTP id
 d9443c01a7336-2dd6c5cc385mr136087265ad.2.1789473484598; Tue, 15 Sep 2026
 04:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org>
 <20260911-drm-no-more-crtc-reset-v4-1-662e0ccd815c@kernel.org>
In-Reply-To: <20260911-drm-no-more-crtc-reset-v4-1-662e0ccd815c@kernel.org>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Tue, 15 Sep 2026 13:57:52 +0200
X-Gm-Features: AcwNN1Ve6_xryIepL3-REHyXDMVgx4PDwpRwZNkvmXJBVXk-I8x2iknW16bA5ig
Message-ID: <CAFOAJEfpXP__y40xFuZskxE2Ni7KzM4Ugw0itchx8Zseoi_0sA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] drm/gm12u320: Switch to
 drm_atomic_helper_crtc_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Hans de Goede <hansg@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JMbBKnY_ZzBTRhn_3VxPLQ3V0srrgEPU4jJgRddiK9k_1789473485
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

On Fri, Sep 11, 2026 at 3:21=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The tilcdc crtc implementation uses the deprecated
> drm_atomic_helper_crtc_reset() as its reset hook.
>
> Switch to drm_atomic_helper_crtc_create_state() instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>
> Cc: Hans de Goede <hansg@kernel.org>
> ---
>  drivers/gpu/drm/tiny/gm12u320.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u=
320.c
> index 754617722a0d..ddc19cd3e03c 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -650,12 +650,12 @@ static const struct drm_crtc_helper_funcs gm12u320_=
crtc_helper_funcs =3D {
>  };
>
>  static const struct drm_crtc_funcs gm12u320_crtc_funcs =3D {
>         .set_config             =3D drm_atomic_helper_set_config,
>         .page_flip              =3D drm_atomic_helper_page_flip,
> -       .reset                  =3D drm_atomic_helper_crtc_reset,
>         .destroy                =3D drm_crtc_cleanup,
> +       .atomic_create_state    =3D drm_atomic_helper_crtc_create_state,
>         .atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_stat=
e,
>         .atomic_destroy_state   =3D drm_atomic_helper_crtc_destroy_state,
>  };
>
>  static const struct drm_encoder_funcs gm12u320_encoder_funcs =3D {
>
> --
> 2.55.0
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

