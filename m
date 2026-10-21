Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAD606A320
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H/yf0Ewu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C114110E295;
	Wed, 21 Oct 2026 17:39:40 +0000 (UTC)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB9410E295
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:39:35 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-677dbe051d4so850573d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792604370; cv=none;
 d=google.com; s=arc-20260327;
 b=d/msXqs9MdnG35Gffo5E5TMfN8HLWUNKNDeYTgyPr7XiJciwpfk31rz1IKLPbEvSS3
 RIgzQkPZChT4VDybs2kFufRxWuu1riwAV96GnZPEFtEJJKAtBabVx6nbc2OsHtKPWWUN
 KcDq7SZTWAfSK1wO2LL8TDHxjYq/p4JcsLo7Ik0AOSEPfrpzBcNrk6hEyAj/2WoWBD7q
 +DQBl4feJsrdbQ86hjltnPeWYxuui8y1KEyjN7+fa0enLh0exVgEjFBNRSims0AfAMct
 /F7KSNKuFbv/ehF164mt8JcHN6voJE3gFOypBXL8EqSBdniMZ3Rg61E108KJChMuV0Cm
 JUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2rJv6/RSKgnnA72uLjrrV1LhR17fP7wpK9EwaJW8j9w=;
 fh=a6H00ADDYtNGmfzmt8TS+xUVJbq2RpY1SAPOJwdzpTQ=;
 b=psiFxfYsOVm1voBcwFSuR7yI/WhOiHAR1MoFUWcosEO8tcaBCH2to86HVWfJhYmnOo
 wHrB6Y0jqn1gN1AeMSzw3JogF4cbx6z/nvyBMhXAPXVH4uEoajO1lk91ovT5J9UybxfX
 pqyYfxmafUH8937wJsj3qGTlRsarregFC3/h8752LmIg7oLFyiNcPthiWw9hgrzyc4pZ
 Qtjy2Y+d04JUKiWNvAejY26kCTwQBVxoStwHsbLt30inIJrrD9k/nkr/zilqVRE8mxtZ
 LXW0EOQoFQtiQzhr+p3p8/c7jTDZAjy2GvjaJc3IX/WdpHkk0kqx9S+kXRbqCdtMiddx
 ukjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792604370; x=1793209170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2rJv6/RSKgnnA72uLjrrV1LhR17fP7wpK9EwaJW8j9w=;
 b=H/yf0Ewu1nBhdNuP0gE6uIRYWVmPadtCzWBG2RBxvtzuDsXkNO4nPBD2DI3soP++6/
 G/YTXidkEigSd7ffxQ9y/u7OSY5hXzyuUSc9JtcXNtCFRQtG4XUuOKXrRqD4lea7SC6n
 gpek7Nxj4FXnZiDDfSxxwP/JaAiqgXg6mRfRUosWLwrFqq8neUPsKgNsX8anfdolfQiD
 GHT76KLceH5G1DGnCJ8/oz9pp/xXa4Rrj8TnHhfxKDb6vhZ+cOCOaZ+ueC1aFu5L7rRP
 luUbHci0JJTkNF6fsRI1Le0kfK7oWn7W1ABQgrjJNfXIyzYEIXo/kxt1lJeD2o+EpUAk
 hHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604370; x=1793209170;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2rJv6/RSKgnnA72uLjrrV1LhR17fP7wpK9EwaJW8j9w=;
 b=fVLguWblsytD/gJFcH2ai5Ep9L8X2S3os73Bv3vSdogsvQeXNhFCA1gfoKXEeOSQ5p
 Xm2LkqHhMVaCQD0bO5wVxW6j3V6TZeLBreaJRYBtS8UAismgCTGuHNXFoV6xy7tmjifk
 cLczaDB0Lxdfj7CxNmA2vEimf5W53RiLtWCX+XvFOj8PGvThdzYyeQ7oUNOxPiXYfzDz
 t0ndYV30fRxLgp/PI9Adu24YN+Z32tzFphSoIlJ3RAQwO0mXDCbFJmFKJD/DwbNOi+gd
 7OHR2gJkpzFGQjLs99vDM1vfXEHevlGyx2Aw0XRcU67DNxmYdA9Zsdqz8PFSdOfTt+kY
 R5rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+UX+zxLrgdVDTs832qs59DwirG2pcjrVCS/phs2LQhzcJtTxwt5OpfJKObRT24KsLJ6N3q9LZLhE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKIR1/4oJdxVWDusBzyCWNnMPNKmOQeGP8UDPTMi+EO5pd/Y2xi
 zSmTWhuI3+KDsvGn2PDzGhXQWljm2jHb/DWIdhrYop9bsyJk+ZAkgDOQQp5ShgJu4rz/x3tZrkT
 aVetiiXaV3uJ483EbCNwZQ40r0J1uzMs=
X-Gm-Gg: AYBFou3DP04foBBmBbEx/s7OdRRRnpVXB4qOmGKMWmBJ4BM55z8KqTLbKMVvkZhgx29
 jdQybEuOD+3ZIooQpB/iqe4o9lHdZReqFxMKIJ6m/CbPTBtkrdhiArOcAQBUAGtXkNLQ3maz9s5
 SlQ/Wh9P9dnxub7JoR+uSQIfIcYKbEhRbKsZuffcaQ6JltdfXqPLtBZt3oAxkdGbPB/BBjqkgwC
 6flCQDighX4wOg98RIvq4Olc6fOMGT8TQP4QBQeSIzW0L/CcbRLi57AhmVkRvmFryK1Av/OCCQS
 PLVd5UD/+3hBqdwCQlmYIGWeft0xW78V3TyASeCdvBf/l9uhTDGeEEamj66cLLph+A4aBCoxYqk
 /Ao1ALFiTae067E/cWJyjloIscz1JoGRz1uzGYw==
X-Received: by 2002:a05:690c:8d06:b0:8b0:afb6:c85f with SMTP id
 00721157ae682-8b13410a95bmr8684597b3.110.1792604370533; Wed, 21 Oct 2026
 10:39:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-34-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-34-586c9c026823@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 21 Oct 2026 19:39:00 +0200
X-Gm-Features: AclHuK81ClEGv7S_JNvSxAhXsbDt82Hl2nQ5l7j5JalMuSvYJrGIxf8dSn6HH8Q
Message-ID: <CABdCQ=MThu45g_O6H+NoXh9r1ncvU=SHoHDVQyJA9VLO=e0sWg@mail.gmail.com>
Subject: Re: [PATCH 34/75] drm/sitronix: st7920: Switch to
 drm_atomic_helper_connector_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

The ST7920 driver changes look correct to me.

Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>

El mi=C3=A9, 14 oct 2026 a las 19:29, Maxime Ripard (<mripard@kernel.org>) =
escribi=C3=B3:
>
> The sitronix: st7920 connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>
> Switch to drm_atomic_helper_connector_create_state() instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/gpu/drm/sitronix/st7920.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix=
/st7920.c
> index 9887ed746ceb..0b838ddd13fe 100644
> --- a/drivers/gpu/drm/sitronix/st7920.c
> +++ b/drivers/gpu/drm/sitronix/st7920.c
> @@ -651,11 +651,11 @@ static int st7920_connector_get_modes(struct drm_co=
nnector *connector)
>  static const struct drm_connector_helper_funcs st7920_connector_helper_f=
uncs =3D {
>         .get_modes =3D st7920_connector_get_modes,
>  };
>
>  static const struct drm_connector_funcs st7920_connector_funcs =3D {
> -       .reset =3D drm_atomic_helper_connector_reset,
> +       .atomic_create_state =3D drm_atomic_helper_connector_create_state=
,
>         .fill_modes =3D drm_helper_probe_single_connector_modes,
>         .destroy =3D drm_connector_cleanup,
>         .atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate=
_state,
>         .atomic_destroy_state =3D drm_atomic_helper_connector_destroy_sta=
te,
>  };
>
> --
> 2.55.0
>
