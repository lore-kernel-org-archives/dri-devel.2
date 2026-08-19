Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DB0C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB38F10E540;
	Wed, 19 Aug 2026 13:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TDus7vsK";
	dkim-atps=neutral
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F1D10E540
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:02:29 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-74a86e9d4a8so311149137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144548; cv=none;
 d=google.com; s=arc-20260327;
 b=Yoe5ji6bDErD1ir2KM4erv90BTdC1+DvIiPgLwJ/YVKgdVt+XP1MuV7cEJHLgaEJcK
 +ytxVNaTyFyTXifNbiSAClRt2G7lEoTtkn9aK828pyIyqxsMNG89R+1zmre9dk7Fv0FV
 iqzra/ZGfIv73yZvU8zo6LIqMDcMVtzzpKGmzBx2Mtl2bS6PoxL8PkrVWgUzx7I8LZ/q
 9GydDPKZin/qcDmlaPJTSRM/Qr+NkMqlOAQKGEjA3k7NQ2zTcH+jHMXzj5my5fsgPWtB
 loERIhZcDI/rK41G2UhU9VSnR20Pmr/lT2AMCib1Lq2yEeKUIBzEZq2oWuLcCDXNNy2b
 RQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xmuCUeXTSBWTdXqlKd0iubpusTbKWwEzyplHp2MiIhQ=;
 fh=zDQn54/tylqRFoy6Tp+dOTLdwsldH3smaiU3yDJj+uI=;
 b=d6sTZfogbZpL8d5F3kOZkQfkRmz2g6uqQLyI7t7GCXy7FGtDDgUNJVqiniD2oogxcv
 DH7yRmdXU5g3LKtyJyLhYSGf2OhTHUjKoEpOv6Nj5WbOG8N92jOgJtmv3xoMGVOJYP+4
 yCC6B1dR5IUkgbE50qvKF1fppnBvxhM6/fq32I8lKcXkJDcojfBi9iCal6WKWmD/rbyu
 q3I/KLEmjNjp30g+Im2GcwuipWJoCs+HY+VhIQ1DMfA9cQzL6Do2JyPLU6cHTxI+cxSe
 xMMYOGLXtAac/RFXV2g5JafMlQ3sgRX9bArHqXmxQf/IyaIbrk4Z+/J2p5/OSY8/ofDL
 d0Rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787144548; x=1787749348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xmuCUeXTSBWTdXqlKd0iubpusTbKWwEzyplHp2MiIhQ=;
 b=TDus7vsKTNEpEYcOWZIc+s7mzQZjvHztq0t0TWjXe2kIo2L7wD0eTlHqTw0elsRMLW
 Lg/NQMs8FeaELESvgf9vBOWgkKJI4iWG3S38DDfQpzsWe7tWYAdT+Uvrnn7K82DJZnAD
 uhiJF0aDuHkJHJ/LLfuGxus9Ubrm08xgRuiyKo1PNCshXa1OR5yS56FDh+A/vJ3Y5qCq
 e9w2AraYgYmXTi5IPUieCl80PiHU6HLhz0Ol7U3Sb2P7WVBt/d+QUOy8bHao8E50vPW2
 1YZx4t64093Gd/QdbhsuqE6dRNZiXHhZB9lmS9NpjHcoP5g+D1CrTyQQFKF9D6M/N1ci
 WiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144548; x=1787749348;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xmuCUeXTSBWTdXqlKd0iubpusTbKWwEzyplHp2MiIhQ=;
 b=GsQd9IeJtSFlv3K7WxDXXWMMhs6//LAftiGnsPCbOlKkzKMEgoK05v4XQKqrwjTtPo
 9WrE+pX6FdFp8aKR2cKOllde6N2LVwmrHIx2WZQsmgKqw9PPDInpPUvkAINPMNCV6GPs
 Vl+G5YcdL+bsAu/XrxsJUFokSmgSBQ2IJkZJsgkl9M0GU1G2WS7keDBo4zX/ythYgfT9
 +BJLlHC6SJTvDzGnq1NwXc7V1x5Tfk6M6J9slk+a1RhOTWFG0smhS9yCvpwLFDhCVI32
 WKcnbRIxq3r4XBPKbl8ajxnPDgyYFZ8Sh+cl3b7Z5rIQpbGYDuo+eb8r+V3MScS/Wbym
 A6Dg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6NlKvZBcuJkNqMmjoo2Cj1AImVzJqv4XUvyhwKkhSBNv/7PAz5UgmyZSSmZWAE0ZaayGkPpNXBns=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0MsLkmoHE0ZpFQQTIUdvvMpzhtheflgb2qowaZuOxyUm88yN3
 3Wu51wVEt3k6uNSR6e0Ao/L+6tI3c4vjvItlqjjIYT4ApXxZpVm9j0/HDeYi8tGlNRFyZBYWS4l
 mGzqJfxpE3/mtNu1F8Q1zvBsT4Q4nK96q7um8AHA=
X-Gm-Gg: AR+sD11ptTvM7MH42cfFM9px8VZvjJ8EpBjTKIVuen+zq/AGe7XGiSNb3rUQEyaLJjn
 1T7HuqAeDUtA9a2JrvUq91sEvZ3aJzU87dFLFmnmQSkGNt34EojpiplTi5bb7m5WSP/jcfAQ9bI
 O3HVWLNHZy6zNNhLy4z9StrmlMncQ54pHodlt0tIN1OnRXICMY5vVnt7Ok7AD1tciw0CHF/MOQ7
 ECPUmx11D46Zwaxz709tCTTjxBc8G0iCkPtNeKU7cwgxxSkQBozolBa67tQME17zwd4c94rT2L8
 u/lGwbX3gAETXzBex6+Hmon+JTloSjmu6BqbpL9KtRLMB5gc5b8Q4fYQzCDzrcTa3elsEgFtzDU
 =
X-Received: by 2002:a05:6102:b0b:b0:74a:b1ee:e034 with SMTP id
 ada2fe7eead31-777f958372bmr1298668137.8.1787144547953; Wed, 19 Aug 2026
 06:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_989057BAD94EB58027BF7E9528F59A458608@qq.com>
In-Reply-To: <tencent_989057BAD94EB58027BF7E9528F59A458608@qq.com>
From: Inki Dae <daeinki@gmail.com>
Date: Wed, 19 Aug 2026 22:01:49 +0900
X-Gm-Features: AcwNN1Uag8K76WBZkAil604Sve_-nPS221p9PD--DnEWCdbR_HfRd-PUmUZjhKk
Message-ID: <CAAQKjZM_Vgx-MGNP45-yQhZzV-H2ccLSP6pWYaykU5KxLMVKfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fimd: fix clock leak on resume error path
To: Jiawen Liu <1298662399@qq.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alim Akhtar <alim.akhtar@samsung.com>
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

Hi,

2026=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:46, J=
iawen Liu <1298662399@qq.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: jiawen <1298662399@qq.com>
>
> exynos_fimd_resume() can fail when clk_prepare_enable() succeeds for
> bus_clk but fails for lcd_clk. The function returns the error without
> disabling bus_clk, leaving it prepared and enabled.
>
> Disable bus_clk before returning the error to keep the clock state
> balanced.
>
> Signed-off-by: jiawen <1298662399@qq.com>
> ---
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/e=
xynos/exynos_drm_fimd.c
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -1325,6 +1325,7 @@
>                 DRM_DEV_ERROR(dev,
>                               "Failed to prepare_enable the lcd clk [%d]\=
n",
>                               ret);
> +               clk_disable_unprepare(ctx->bus_clk);

The analysis and the fix are correct. exynos_fimd_suspend() disables
both clocks, so leaving bus_clk enabled on this error path does leave
the refcount unbalanced, and clk_disable_unprepare(ctx->bus_clk)
restores the symmetry.

Merged. Thanks,
Inki Dae

>                 return ret;
>         }
>
>
>
