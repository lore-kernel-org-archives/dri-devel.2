Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CBBCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1216F10F00E;
	Thu, 28 May 2026 10:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D0n/ViCh";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD3B10F00E
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:55:43 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so6648748a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779965741; cv=none;
 d=google.com; s=arc-20240605;
 b=KXPQdeY6/CnoV0iSvSrugLkxsSp8dh9yJOqp3NeP0YLXK5DTTyhoaBMQjj78qIc6C7
 woY6mlb/Yw8sNTuTjsgD342tyBAr00m1RVsx2/3Is57KyiI6L/klN40dIiNthUDh0BVQ
 HvcIHP8yiG+bMOovSdM7ZnaVZ9eeedjysMQ0U38Py/KesY77FxbKzqaPozUW/xH7mlA6
 ytOZ245Ae4W+Ix2oD3MrprirJwn44PEKWWXv0HwQWjKfAXq6SfqfJIhTtwl8rVqSdp03
 30/wnHHP4GCu3GQIQzS43gU7hgAjbB9gJQE56WVLI2fMaFikreDkpSI1DpOBMXmA2yAI
 cL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d5uo6wkwn+JKE+tD6L/Er2v5SeX7iezWGUT0Vd+Sn2s=;
 fh=unId95udebRJe9BbkfI3OnDpCCn+I4/KPPSOXoqkbaA=;
 b=gWAc97LutNHChZG5YI+tJ8ZsEEpfFzMWcYIQDxg5RuXvkK3g/iaud5W4a4HkDqKXWI
 hZAwVntew4GAm9LT9xyI+EI1wAPILCvJQUMLsh0MG94N7cnMYfhvI3lrvYuKkXu9FqEa
 2wn9KX/H7dog62FOzHQzAAtsW/559LGCWOXk5feDT0EeVVXKLAUC9JdzJ9y4J5IAbQhY
 BWgjIEbsDIw99ApCKuPVE1dFztG+T0mo5oikn7zuWvZYAkBIhlgaxlW3QEQ6abaYH5ab
 L8Ux8e9EttpQsQOX+g1cehEj3sRNizA9RyYlwBPSE4RhKyIv+Dp+TF95MkVGyp1HPleW
 r0pg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779965741; x=1780570541; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d5uo6wkwn+JKE+tD6L/Er2v5SeX7iezWGUT0Vd+Sn2s=;
 b=D0n/ViChYyWzXy86/eoflwb6HWLHfeiWoPc0WgQT/aansHh+DiqNs6X/cd4Nf9hevp
 ALoMOSlkZmNZqHRxR7sXRLtCYCy24oTr2Cw4v36TDpDpTxsf2gkV/d0wfmUorA3U1VZR
 ae0Ejoq/ViaQmS1LfUsc0R3aQeb/lO3dV5vyoRqsiFkGGmYIRdJiZfjY3UUhKnFIKXHp
 2p7iEx+OX5Gof+o7GptmZermEAbGgyVTMgw1fV0GuoaYJ+tcXGT3ZjKgKy0htmbKj5Xu
 Pk8ct8uU3r0gn75Jxg5L02B1QYGi2NXIL4+WgokV9KFdTFeeVE+FkQHrGmAsvX8jlVgi
 S7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779965741; x=1780570541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5uo6wkwn+JKE+tD6L/Er2v5SeX7iezWGUT0Vd+Sn2s=;
 b=bSQnH4PprHVAME0YCv6Ow8YO6k8JFbPaRpKspdDeG+7VQyzy5+W4QYBN+mBh39Dxic
 CluJGA1+ZoSDrSEWYzjIkk0IuxmlBHKrRu+sS8S50Rl3ZzBAY/IR1YfP3tLwLlK0zfPa
 nWfvfC8MlT0UHxppFWaBn3HTFXogfQu+7b8pDUV0akkB/LbVIZKg/NdALMJWLhzJWONP
 viDHB359mkYiiVmo+lLAAjnEo3L+LeVdCeQDgM1mcrsz7iGyTZCl29mE7mNMFAKDiDG2
 slpMGT4QdJGjbE4yyM1OyaAiXdFXig8CNO6LFQykTSl8KW84R1PkwdgMBWgE1d1Nh/dd
 b8qQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yDUSKmkbOvw1Ca/jv3slBJT0Ki4fhhwtmKLLkWYeByHMM/ZvecjyKq1rGoi2cP9nCaOAzHWZAme4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUwXRl8CKlgl8Bt7E6jrQXx6TUuXhKQzB5lQOeuBIO0iQQRCpH
 ZdlwSYAHtBgo1j4w95C7XGNnV2Y8qh6afymq4oZgzet5h4v997v2YdLcYGvo2rWLJFYolBS4pkv
 WPFSSUFTOV40LD3DkTcJB54M1PMV7YxQLZB1rZNND/g==
X-Gm-Gg: Acq92OEH0aCwZNUbRkpthtQ3ye45l9j2aoMEmWhWB3Us4rl66PV2/B96+B/GIYAwr0I
 UaaRFPUnfF3vjSc7IREG790eg7SnjnNwdAabJ5UI+POmVKGq/lD2NbjIaBVnh+e3VDPA/84mjO2
 3GuuGa4qBm0mKOaVocX1PzWNMmJbhivyN5+aqUty0JfYo5leHpMXf+QAb4XK3Rct1tfGi3o9V0+
 C8eqSvW4TqbEnoTYYmQbwcRrS1kkt9IclP8yp6ijJQWxdLxyl9cebGj6e5aKcndGC9nIEtx+p5E
 byi0C1S56vh7FOJDMKj9SSnJ+IPWD+TIxVndtBikyr3dIGW4aEdL
X-Received: by 2002:a05:6402:354c:b0:681:5b59:648a with SMTP id
 4fb4d7f45d1cf-6889c4412dcmr16690059a12.11.1779965741591; Thu, 28 May 2026
 03:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260527194525.45762-1-arnd@kernel.org>
In-Reply-To: <20260527194525.45762-1-arnd@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 28 May 2026 11:55:30 +0100
X-Gm-Features: AVHnY4Ix0Hmm_eG6_V7iRj-xJ3NfAcKZMBspXlN6j33nPsnkEIVRn4_MuHlGmIA
Message-ID: <CADrjBPp55hZmkJMa3Lz3h=K0ZOBS-k4BY1=EmgtSYfqeCbJg0g@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fix size_t format string
To: Arnd Bergmann <arnd@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Chen-Yu Tsai <wenst@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, 
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
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

On Wed, 27 May 2026 at 20:45, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The exynos_gem->base.size argument is a size_t rather than an
> unsigned long, so adapt the printk() format string accordingly:
>
> In file included from drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
> drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_alloc_buf':
> drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
>       |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    70 |                         (unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
>       |                                                              ~~~~~~~~~~~~~~~~~~~~~
>       |                                                                              |
>       |                                                                              size_t {aka unsigned int}
>
> The dma_addr in the same line is already printed using a cast
> to unsigned long, so change that similarly to use the correct
> %pad format.
>
> Fixes: 11e898373fba ("drm/exynos: Drop exynos_drm_gem.size field")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
