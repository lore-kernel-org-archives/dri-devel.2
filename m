Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0D9FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9022710E47A;
	Thu, 30 Apr 2026 17:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="RgEvtHeO";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBA910E428
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 15:35:38 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso13267295e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777563337; x=1778168137;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlhbRUl79f9tq9R3YugScP6gF9vXwrtrDCSId5OhOrU=;
 b=RgEvtHeOpSuTL/8qu1gWbVYi2NpaVbtiamNPUsJU2syXAkSHxqm7WGyv7IottSS+4c
 /2q6HJuwglyBQ3hLJFyFUsaniWHgyLggm0cWdWREJRZ7Ls+MtAm6sdO/6R2ebbrVGmIK
 oG30ADK7VfNvkLRgkG+PEawKaEuWWvW/9GxhLBM/xsLgkFt6aNjv0bV/HRITqNKUGkDl
 ecjPUuCc/HhTlsHt6MiGyRlqY9cAykXoMo6NxuPQxCnTofhS6c5VgDwPjy2lh9bchv5h
 a1zZzQbfPHQzQyge1rlrZnTmfJR+Xyf4Ia0f0ETPY54Zqz+XeyKexlN6U38/zAKD/Zx0
 mMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777563337; x=1778168137;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NlhbRUl79f9tq9R3YugScP6gF9vXwrtrDCSId5OhOrU=;
 b=AVqX+teCzL6YJnZqARUyRWZS9flTieqNwUc9zpd/rJr675NM22LmAgMzmYnI1zw4rf
 cEDQiZCaqi7hzxEJguVKER0SEmRm6Aq2H/PCITqLbEGs2Ak/z2x9CBlpv93E63vFQzWN
 2lQGzdciQVy5pzP+8gkEzDqQQoimbvPdVaEkblamaXUD5aPIWc3xYXKW9KnNqi2Go1av
 MTDIuZJkHEsP+zZFdvP8ep5oXXAn3gkOm0KN0kuN1oqJFzWJQDVeqcDG0hVYtWMGBkzR
 vj4/58y0gIHOln6ONermgxjMtCJwlahuAD3ulScWWru8eO7WelXy0JfHW7gCOowYYVXf
 QKUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DUKKbFqWXbqoiuqyILbugfB+uq4kTGd16wHDGDpZ/mzJPFzu4gsFEKgAsw/43U4plAMn+cqyAqcw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVpVDont23z3LDnVZ76gsp8PabLzOdxa4JYMROSpFx25naRFNe
 G/e2M3E7SafD5VR5yvHHfXWw44ukRId/IWPpFKzKrOnZsL7vaQ/Wqafv9kNG/oZVvms=
X-Gm-Gg: AeBDietv6v54GJJEaSPC6RDyuvrBHOHl84FIES0D4TZsptRIL2T+Rzy6TmWmLGnloOe
 7HB+sXFv6jisg70rlW5RtwJhHk5T0LX6HQH6s4nUGjqSKSAGVWTKvqIApb3NS90Vr8KWUHrirMZ
 08Hka8rH5nHBVuKiyn/hV03QSxBG494BY+5JjtLMqr0DETbo0mkZqy+HzwX8duFYbnGEE7PJXqY
 52YG7/Ziv7kHVUJJpoPun0QUwrzSIREjFzywMNl86wIa0iZ20txnmdxm6brY9JfjZYejmG1ZzOy
 qMneIm+guzC/iEGy952F3E10wmgEITvhWtFDNIfnDrpivpfJAky+PDGxRERVBd1OyLyD1bCxGBv
 hu3qojfnlA2xt2fILLEgqlH6UxnEEuOSgFRXAOcVzP8GEMNvYdaXjMqNVzrK3vyX5aFx1HCiCy5
 djlM4wwILChfkxZaVJk0vSXD+9
X-Received: by 2002:a05:600c:c0c2:b0:489:1ff5:edda with SMTP id
 5b1f17b1804b1-48a83d66d38mr42439965e9.6.1777563337249; 
 Thu, 30 Apr 2026 08:35:37 -0700 (PDT)
Received: from [10.19.106.145] ([151.19.88.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822c832fsm122768725e9.10.2026.04.30.08.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 08:35:36 -0700 (PDT)
Message-ID: <b3c77e37128f8cc642ac7c14a5c269cd43c87cc4.camel@baylibre.com>
Subject: Re: [PATCH] drm/fb-helper: Fix clipping when damage area spans a
 single scanline
From: Francesco Lavra <flavra@baylibre.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Javier Martinez
 Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 30 Apr 2026 17:35:34 +0200
In-Reply-To: <20260210173545.733937-1-flavra@baylibre.com>
References: <20260210173545.733937-1-flavra@baylibre.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 30 Apr 2026 17:06:40 +0000
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

Friendly ping

On Tue, 2026-02-10 at 18:35 +0100, Francesco Lavra wrote:
> When the damage area resulting from a dirty memory range spans a single
> scanline, the width of the rectangle is calculated dynamically because it
> may not coincide with the framebuffer width.
> If the dirty range ends exactly at the end of the scanline, the `bit_end`
> variable is incorrectly assigned a 0 value, which results in a bogus clip
> rectangle where the x2 coordinate is 0. This prevents the dirty scanline
> from being flushed to the hardware.
> Change the calculation of the `bit_end` value to fix the x2 coordinate
> value in the above edge case.
>=20
> Fixes: ded74cafeea9 ("drm/fb-helper: Clip damage area horizontally")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
> =C2=A0drivers/gpu/drm/drm_fb_helper.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_fb_helper.c
> b/drivers/gpu/drm/drm_fb_helper.c
> index 4b47aa0dab35..d545342d24b3 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -608,7 +608,7 @@ static void drm_fb_helper_memory_range_to_clip(struct
> fb_info *info, off_t off,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * the number of horizontal pixels that need an upd=
ate.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0off_t bit_off =3D (off % line_length) * 8;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0off_t bit_end =3D (end % line_length) * 8;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0off_t bit_end =3D bit_off + len * 8;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0x1 =3D bit_off / info->var.bits_per_pixel;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0x2 =3D DIV_ROUND_UP(bit_end, info->var.bits_per_pix=
el);

