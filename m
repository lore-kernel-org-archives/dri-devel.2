Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B01C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3712310E130;
	Tue,  4 Aug 2026 12:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a3xn+2hr";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EFD10E130
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:33:53 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a18180so5705722a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785846831; cv=none;
 d=google.com; s=arc-20260327;
 b=fAUXAiBKW9S60EKgE6X90UIIJ5g3r1YNBxNI2dHtRsLSYsyEjJGHVtKKJkYuCNpOFS
 /mU98d1hAPqL8TAnpZ3nI/ybTtfKIE5Akd+2etThtak9aicTz7C8LPmxjq2CrSfu5siM
 AaJHiop/w+Iov14PKg8mDIbwMftcAUKXIEcYVbW085cMcYaG+pVplgm/1IyGCwm/WY+3
 nBe+vdITMdNr/ctxCvKxVp684thvyty9WIADUxA6qUEOrIxv5e7insQuKGNg+kabzIJB
 El+jbOU3r+yNn6NabpOgOQtAvbTBG3RszDrQQ2Jt3E/TbDUCmnTcHf/s/V0LIMW0YIgA
 MP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HxBuSuUOsN3xcHdKVMUU11HrTG94kQJTqxpKG7QuLAE=;
 fh=7TI9YjXojqdE63Z2rQ0nUNBMFpIIVFNRP+09PCNC+GQ=;
 b=FOj3bK7q4ISifUe/4xzmr/4xOQex++tEL/ZEVYaBS64SWknvju0TmFuFr4ppsmpoQG
 cKgOXmglcTElRSyZDI3gCIbYI1qeoCMy76Xv7qpsYvlqlo5UrC38uxPg8g0tKf+KQocd
 BNM6SCef3/LjlBsAzhvIBKJO0AavfPLTI5dhODu3uiAwadz/ebAEEij89RU81k8HYo6a
 0fsBFWedfm22AZogL0tW85uhCQZg4Rww5R6gOBU7eVDXs32NcAg7CCcOJ2Rf9RVUu9z7
 ANTri/4ZS0MUovg8r1y7AV04zxKD9dpEPFyvXvrGksukqxtD1eOTbasp24L5aIfU7fBd
 a3nw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785846831; x=1786451631; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HxBuSuUOsN3xcHdKVMUU11HrTG94kQJTqxpKG7QuLAE=;
 b=a3xn+2hrXECCOM1xRLNKPfd6jvjtOtMxJNEuljMfIDAz3u+BW+gXrlVpET+D0wetBF
 V0lC10NsQbotvDqUsmj0e2RdINWUNHE0TZGZu42Y2hR6DSyNGXEoar0p8lYDu2Gn0bS5
 FTD74PUnoBuhuNyA6SgHb+kNIJw5ajPlRvoznFR+sXUmE5S5zY7XnWpbqNKsNbsh0eko
 pl4zVxteiEqORgoaBYfTmvQ8Add4eY6waCGVadyPzFW/bk0btlCFZk0gxKP6ZQN2WEPg
 4LHNSv37Bj0yYtarNkC24/7r35DZojKZz5YNEVyKILCURToaGDWGuVHHyrVUzO9nz12C
 RoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785846831; x=1786451631;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HxBuSuUOsN3xcHdKVMUU11HrTG94kQJTqxpKG7QuLAE=;
 b=QtaXY6ka89/OXScWy8qCcv+/gDt1mr8Wk+tL+G3i6wBrLqYdio5KReefWPlDX1CAh2
 ON81XjTmUpp7TJPlV89YZILoqgOsIDN8M16+s9tpRn3qdhkbtUSE+bKMfLfZLdqLmOb7
 iyLsEgICIY/yIcJMajhlOo5NbvFgRBMbaFlFOgxmm3J4e3G8EFBvW5ECeG6tUjpJ4o0j
 NLDDmMnFmKhbnu6FR12J4C4imF+1sn3Ru0oOXWa0/9oyLwfQc2fLtkvqPUwALgIro/Xn
 RYlervjy+i5IqeyaL++PW1ZEULSqwjcEynt04ZETxI3r4PZHjOmUxt7NeNBfc6nvBxIY
 RY+g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrmo564gfKtZqiwfOx4ObBvF8+0B763bsIH38tALWm2jZuq6P65NwRMjGjyyXKSrES0gCRJDkJvJO4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyABLihxLisfeD74FQX68eZDqQvb+hhLK9H08DeYEFaIrlv/UOd
 X2dBYi1dlbMaVNJ+OgevdWhku6Q9T+eBf5B0z832WAnvarB1W4rWXNmF3fvxqSqWs7sZ5+E1IqI
 KBAittdDBhdaudHWCw0bvEO7VJ7hsAMBDJKTC+LD8Ug==
X-Gm-Gg: AR+sD13P0p2CXj3aO9x10n4xrkZ+FK/B7av9IhHChgz41CfgK+8i9In5iKp3ig/OyzC
 00SfpdZuBmvSTOZmDv3NxuV8xaaMHjwN+CQtss/S1i8g/FuAOcaxMpBB28jF5enpkjMVfKH/6Sq
 PxO1cLduMfuY2uLP89Z8D8aR0CKsUdLaBYkZK9JH+V0RuG/BdXGteuZpQT5QucwzDz57xGPGWbT
 hxz8g3HzVFQsfB3Wt8xsJ0v78WAiP7IMcpBrIryZQOq0/yMVIFhznx329rhFW2P++rQ5kyUm/LQ
 pwrz0rNvC1Hvc74L6Wf8qtdbh1UaGP8zuH2YKRm2k81Mfad1NPO+/6B0T1gzLsiINsRMTFuVE8Y
 dmjw=
X-Received: by 2002:a05:6402:a6ca:20b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a0dda38483mr5803047a12.0.1785846831292; Tue, 04 Aug 2026
 05:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260803135322.2898247-1-wenst@chromium.org>
In-Reply-To: <20260803135322.2898247-1-wenst@chromium.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 4 Aug 2026 13:33:39 +0100
X-Gm-Features: AUfX_myS2cidHM43LBbhd8UVPlKcCVWzzAL3r2Xg4qgdaYQLg0tQthlf_dnS1Jc
Message-ID: <CADrjBPqVOTqfj6Xx6LMvnrVS8-gxrwh=-_XevD56Nf+ypSNhAg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos/gem: Drop extra "0x" prefix in front of "%pad"
 format
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 3 Aug 2026 at 15:28, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> The recent size_t format string fix for exynos DRM driver left the "0x"
> prefix in front of "%pad" format around. Since the pointer format output
> already provides "0x" prefix, this ends up adding an extra prefix.
>
> Drop the redundant "0x" prefix".
>
> Fixes: 3470274dca48 ("drm/exynos: fix size_t format string")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> index 0208c9259572..acb8def747de 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -80,7 +80,7 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
>                 return;
>         }
>
> -       DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%pad), size(0x%zx)\n",
> +       DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(%pad), size(0x%zx)\n",
>                           &exynos_gem->dma_addr, exynos_gem->base.size);
>
>         dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exynos_gem->cookie,
> --
> 2.55.0.571.g244d577d93-goog
>
>
