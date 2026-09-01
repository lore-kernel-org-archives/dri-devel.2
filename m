Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2501C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F287010E3E9;
	Tue,  1 Sep 2026 11:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EEfSPCOM";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF0510EC73
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:05:18 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-66c744a00edso734596d50.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 04:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788260717; cv=none;
 d=google.com; s=arc-20260327;
 b=sVuDIjLIUhP4ogWm9ZuR3WyIKMCkvbL+DGBCJOnW0TQpVzXNtbRsLShas2cQBYgS4n
 /bRjSUUTmL/nsRUjdUmwMaML5uiKkv123E/I+/td/DLsFUSEtChW5T9dJARIvATw4OBN
 GVkCRMbWGI8i4mL2KTFX35BXa1VT3VSaknViA2mDMKLwUK7P3mMbOtGkJ2dSttdDhcIU
 a3yc6F0rq3UfUfpjyRFdzPU91O3yJ+MxRS51KgSRKPfmTd8cHvkXIWI4aBO9aJivg+In
 852aBovlmOpxzXCCzYFQPb9RA6lZlVaYN046Lm9UXK2fo8aa8FmFUrvUtrLuKokGW3zS
 sSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bx9TfPLmGc3whJzHzCGMQ6dldmPsKUJ1o8MScKqAu9g=;
 fh=rYB+4BAXhNG3eCNIvvN/h372aNfwY/sOE81X9WLiHrA=;
 b=MX24wdYI08jBedWc8IlJoS1JdJpM+piUdVY8cpl+DraM0D2vesWDCXRijK9HP68n2h
 2ZPzo9ySWY5WvW0ff8tUibDyzmShrrJWOHOFlhd8fMh06xv2c1X7VeXDZ9KVPAPJqg9+
 R6cEuhiT7JwGckX0WG0DKVd7MpHzqweP1CqX8Bihksnu8gYdJEqQoFLeOzDhDVsc7ZwD
 xrqmmheGdhlTmF1f2vnWnU9NOGnMYvZElsms22SGRP4DOA4doDr/HMYzkmfCToo1edpz
 /+S+P+Fs0iT5a0jYBs8uIUXIg6phYxiNSa8HAyntpxcH34mIBABdEir2WOBRH0fDVLeN
 IElQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788260717; x=1788865517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bx9TfPLmGc3whJzHzCGMQ6dldmPsKUJ1o8MScKqAu9g=;
 b=EEfSPCOMzlq1Z+SsA+BKgNBTcmh9GUA+Jg8YUB2rksshT3XEqbOCFsnuuE9OXQ/JkR
 u/jdKiz2gsHwdr2YwcmHVH51RjcZVeuvZT25SHzEvNBjKwtrMEPboQeG7x4i4WOOaZAn
 E8czeuPa9JRUqgpzkVf/OvS5//kz2F+R2khmL23Od0OdeGaKwMo1lB0QkR9kbhhwyqJn
 rARM+somf0HCPt9dyU7gANBYPmF68Vr+LSAtqIkgnUNkT+OALZxFDnG8ci3F8impADEf
 BwUUj52JKYqkf5WplMhkycLxTU17zdTbJKLmJPG8ZxksjLef4tFjUsZkQZ5gADXpWx0w
 S41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788260717; x=1788865517;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bx9TfPLmGc3whJzHzCGMQ6dldmPsKUJ1o8MScKqAu9g=;
 b=cNcH/PqbgdeHJm7a6CGKzbaHUBkvMyWJt5JZuqQXMdBaV2ByWg6BZyEQnkS2Kax4gQ
 geskUChoW9c4aRyXoP2FvDCBpoPfAvnoDTaElyo6hIhppnTbb3RKXRgOI++YmZPsotlZ
 +cOPwqOqgdQ+mFHTJ6cbqiW2taF5Jz656KOdOJACZMbs5nB3QdvH/rFGCpwwUmKRPRVq
 8kHwOhLeUIgo5vOhgDd1f9eR4+G0AT4kXGhvpOWGTh25TVIutZV4RNetA3i2pmR5vno/
 DstKOrOvGuOFRaucFrWsu7NYnY+i+05MptrVO/iiwAyKBODhCknbRkGUMu2aypoTTeTZ
 MVYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRFr87Q3L9BT6JaqupzH/4zwzd9wbZpOWHAfKUd5u2+EliCJYL7Lxl1B8ya+MHlF7y8RhnT7r94fM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lso+r1xcu5svFvvUHHNgBjNKdSPgE/FoZrVHH+Ny9Icrp6sXlN
 E6p53NddzMvuwjPg5goMoEDUmV/o2c+PUfk0xgS8MVcjT9AOfglq7JIB8xFhxVZGuGK1+995mEf
 k57G7MiVUydKEkYfQFiNarDF1HJWnp/A=
X-Gm-Gg: AYBFou0zwB2s7k2vdw1bFDddCwNsVbXkqqv/cUxIQlGfnXAAZaBElZQAZfUKzbCsczD
 xRCgM7EG1ZawckwEybr7HDiJ3qdHEMuncxfDB04YAkj39rBdzgagoZZ5EfJLNwzoBzO4rSRiADg
 L9aTUnCe7cL/btgEfcFQOXsopc0joNk4pFkyKbUWXvFTNrLepgpbv5PlCaagRbiUW2NeGuAu0wb
 YX1Ytzn0AHNMHl/MV0Von9qY6/uXtT67hRS8LdnxnUQVBXDU3tto+m/MoYKlx3ku8D1/pD81Az7
 qoP0vNNd0Dfa5liCmUzJ7bRvWwC7AxwTFbTbvaWK0kjO7z8X0W8rEV8=
X-Received: by 2002:a05:690e:4553:10b0:667:b645:5303 with SMTP id
 956f58d0204a3-66e55e1b9d6mr5809845d50.33.1788260717515; Tue, 01 Sep 2026
 04:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-11-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-11-4500d49a337f@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 1 Sep 2026 13:05:06 +0200
X-Gm-Features: AcwNN1VgY8cJid3XIkXmopo5LxCNbJCtH2z23zFIfWTr7goHy60IGU_6_zLdFyE
Message-ID: <CABdCQ=Neak+dO8tPTxk++AZhjL1tUbo2ygHhJhU3AeK6qqRfUQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] drm/sitronix: st7920: Convert to
 atomic_create_state
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Maxime,

The ST7920 driver changes look correct to me.

Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>

El lun, 31 ago 2026 a las 17:35, Maxime Ripard (<mripard@kernel.org>) escri=
bi=C3=B3:
>
> The st7920 crtc implementation provides a custom reset hook. However,
> this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and warns if there's a previous state.
> It does not perform any hardware reset.
>
> Since this is exactly what the atomic_create_state hook is meant to
> do, minus the old state cleanup which the caller handles, convert the
> implementation to use atomic_create_state with
> __drm_atomic_helper_crtc_state_init() instead.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/gpu/drm/sitronix/st7920.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix=
/st7920.c
> index 0a75e9319080..9887ed746ceb 100644
> --- a/drivers/gpu/drm/sitronix/st7920.c
> +++ b/drivers/gpu/drm/sitronix/st7920.c
> @@ -573,21 +573,21 @@ static void st7920_crtc_atomic_disable(struct drm_c=
rtc *crtc,
>
>         drm_dev_exit(idx);
>  }
>
>  /* Called during init to allocate the CRTC's atomic state. */
> -static void st7920_crtc_reset(struct drm_crtc *crtc)
> +static struct drm_crtc_state *st7920_crtc_create_state(struct drm_crtc *=
crtc)
>  {
>         struct st7920_crtc_state *st7920_state;
>
> -       drm_WARN_ON_ONCE(crtc->dev, crtc->state);
> -
>         st7920_state =3D kzalloc_obj(*st7920_state);
>         if (!st7920_state)
> -               return;
> +               return ERR_PTR(-ENOMEM);
>
> -       __drm_atomic_helper_crtc_reset(crtc, &st7920_state->base);
> +       __drm_atomic_helper_crtc_state_init(&st7920_state->base, crtc);
> +
> +       return &st7920_state->base;
>  }
>
>  static struct drm_crtc_state *st7920_crtc_duplicate_state(struct drm_crt=
c *crtc)
>  {
>         struct st7920_crtc_state *st7920_state;
> @@ -627,11 +627,11 @@ static const struct drm_crtc_helper_funcs st7920_cr=
tc_helper_funcs =3D {
>         .atomic_enable =3D st7920_crtc_atomic_enable,
>         .atomic_disable =3D st7920_crtc_atomic_disable,
>  };
>
>  static const struct drm_crtc_funcs st7920_crtc_funcs =3D {
> -       .reset =3D st7920_crtc_reset,
> +       .atomic_create_state =3D st7920_crtc_create_state,
>         .destroy =3D drm_crtc_cleanup,
>         .set_config =3D drm_atomic_helper_set_config,
>         .page_flip =3D drm_atomic_helper_page_flip,
>         .atomic_duplicate_state =3D st7920_crtc_duplicate_state,
>         .atomic_destroy_state =3D st7920_crtc_destroy_state,
>
> --
> 2.55.0
>
