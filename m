Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3551010BA426
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 05:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344D810EC9F;
	Fri, 27 Mar 2026 05:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HNQJLzf9";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2891E10EC9E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 05:44:14 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a2967e5de4so2286618e87.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 22:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774590252; cv=none;
 d=google.com; s=arc-20240605;
 b=OIu1qypSp+8ciYuS0QtBFR0eA68QDr2UcveRY+ZvFdYg4qCYMelU+3PlLkUFsrld90
 QprEMqBfe3VpRiLEl/jOq6/q7somYgYm3VXvsXdMdU9D91161XW1AvVG7L7RNdw8Cnvz
 s5+Rti1X/qWKMwFrNmTWXVSbAPCNzbcagnokUMYkh57G8zUJibsLKBbZM1UJBG2we+ma
 JUazrw0Tfx/2UWe8nZ1tX49nbshri7Blh4lnGcpgpfWPlnQ6mVBtl++Xq7NS27bjD4ax
 aPckSBDutjkCukKBTildF/jcyUTm3vB4YpLw9SwqRP8Jxp1h5ytSlpcOBzHFuaAZJ2Sc
 axhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=55gQ8UIqNu/4Lu8sOqkpH3txb+MxNaA75AvyR+3jJZk=;
 fh=cMhu8jz82LBZGa//KnyD/CLrtO6i4rSh+jLIep35Qeg=;
 b=D34MVu93ykt7Uj0u356KHXmQQQnExlpBP06JuDtp5w6paoRgVyWieHmx0o7onfOe4y
 Xq8/ek4mUWG+hUxUOXMOipWR24iGcrOGWbZdjY04bk/Bg2JSbi08z8glK3iYsq9U5F1p
 cdEgVuFZS0HnGVA9AaBXBcrTQFsI3zuZK0l1ihQVkh7Zg+iuhu7zz4oxSvQ5yVGkibuO
 ko0js8/Us9ZM7SCnqtzMc1u/tE8xynG5ww/KnglsFy5dVXnxBUhLaCoWgdqHS3QMZ6xo
 SBbpVu7umL3cfISltXRJqGKPIVPNS0mb2Dd30nJPGZgs9xIthG+kyp7rIsD5gEB+1h3j
 +syw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774590252; x=1775195052;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55gQ8UIqNu/4Lu8sOqkpH3txb+MxNaA75AvyR+3jJZk=;
 b=HNQJLzf9X/6QRdWiwlJLWdbCNXYhe9kCuGLjN2vJFeAvN+jtcjESHQ4PdjrSPTQFKG
 EASx3MC/VgElr4twhZfsHd7ziHmOHxVA27jFuoMaX7A2o2Fw9HlzH23jP/7rlzvvDuwM
 nkwYRj16BOmxOxW80Gk9nMNUKq2JVB2762mR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774590252; x=1775195052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=55gQ8UIqNu/4Lu8sOqkpH3txb+MxNaA75AvyR+3jJZk=;
 b=FYVSCaGFQ5yVUZsL4io7BJu2WSMQDgPmHjTsHeYDqojOtf7QKNoVUr3IEqqAebtlFP
 4Zeu8VuekSKhnX1vKj2ARJA7Y4QvXQuehmmLGV2gJccyUlrbeAIwAz5cfrBLGnDn9vBh
 KxaRnm+ZfY6ETB4iKqemVJOx7/Xy00o4fUgonfo7kyD2SZ6CFr/rFoyTQHaKn90xiDHe
 xmfGZfGuJM9ZGyNXdgEW5kpoqDcPTTi/Vi8mGIZf2kbu35UCAjUjTS3azXM7Bk3R3jIK
 ThgdKiB66dxzx88rrGvz/DPV4E2CRWrSt01OomI9Z14CMUWoykKOb7u/2Dqljpzdc6Xy
 kZCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtT2c34KPZV0gnO/rRyk877GxndgnM9SJAA5sc8ZMuXZAUF0X65GFeHv4UhmvsuTjqDU1DKmqihPc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzkkvfmH2hgs3KJkPdJ31vdCyCge7YXLc1MLb7VLhL1/llVpUZ
 nJBLIuk2Rn/7+cP0Cwc5YyCwVrvt+UMJqV9mQp+Cttlsopuf6S/c6co3DNz091mGHJwnYgEEcFn
 ARa4pS2pgEo7qWqmfmHcjbCxE84v7BpPQrBr9IUU0
X-Gm-Gg: ATEYQzyxeN2FbLCo97uWh9r4Xup0SjsIb2pxb4M8DJMNEvUOgQ+yfdHTG3lox9GqWAE
 JgtL1dPASB7DWOyVFKr2ATWRsAQRffszQjdRhz7ORh/8I9CmMGL5+wnk4o0cpr7YDUkRdIfHVqE
 2tFEAxJW5jyHnbcsGTVnWSb7IJmrOsH9+h3xxCzoOa9MINfu7i8Ueh8FKg9hOpbGkjzZmeQvHMh
 t9Dg3BERQHikBx/jcrNDnRb3sUqHIvrIugUQFTzANvDR3XvL6yrZqnU6g7m1sGBkbdduAEQ9mZI
 aueIKkXz4aTxjvUeT03iIG9JxY6h9r6Wh7h2gV+yhh+RMYNE
X-Received: by 2002:a05:6512:2242:b0:5a2:a36f:3ef4 with SMTP id
 2adb3069b0e04-5a2ab928fe7mr379815e87.31.1774590252148; Thu, 26 Mar 2026
 22:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260326094308.1161335-1-wenst@chromium.org>
In-Reply-To: <20260326094308.1161335-1-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 27 Mar 2026 13:44:01 +0800
X-Gm-Features: AQROBzCaR6O-grRzEn_50j3NpZXhobkBat-wP0370vcp2B9JGLmH6YnTu6gaOu8
Message-ID: <CAGXv+5G2H3CSic5hCSd2g6RrfGyNSbpYS7Z9uo-XUn6No3a4Rw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/exynos: Random cleanups
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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

On Thu, Mar 26, 2026 at 5:43=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Hi,
>
> Here are some cleanups for the exynos drm driver. This was done as part
> of the conversion of the driver to GEM DMA helpers. These patches have
> no dependency, unlike the actual conversion, so I am sending them
> separately for inclusion now.
>
> Please take a look.

I should add that these patches were only compile tested.

> Thanks
> ChenYu
>
> Chen-Yu Tsai (4):
>   drm/exynos: Internalize exynos_drm_gem_free_object()
>   drm/exynos: Use DRM core dedicated DMA device tracking facility
>   drm/exynos: Drop exynos_drm_gem.size field
>   drm/exynos: Drop MAX_FB_BUFFER in favor of DRM_FORMAT_MAX_PLANES
>
>  drivers/gpu/drm/exynos/exynos_drm_dma.c | 11 +++---
>  drivers/gpu/drm/exynos/exynos_drm_drv.c |  1 -
>  drivers/gpu/drm/exynos/exynos_drm_drv.h |  9 -----
>  drivers/gpu/drm/exynos/exynos_drm_fb.c  |  6 +--
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 13 ++++---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 50 +++++++++++--------------
>  drivers/gpu/drm/exynos/exynos_drm_gem.h |  8 ----
>  drivers/gpu/drm/exynos/exynos_drm_ipp.c |  2 +-
>  drivers/gpu/drm/exynos/exynos_drm_ipp.h |  4 +-
>  9 files changed, 41 insertions(+), 63 deletions(-)
>
> --
> 2.53.0.1018.g2bb0e51243-goog
>
