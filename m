Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8FA10BA42D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 05:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FDA10ECA1;
	Fri, 27 Mar 2026 05:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GYpL4cUv";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADB310ECA1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 05:48:51 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5a12cd0bd79so2013018e87.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 22:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774590530; cv=none;
 d=google.com; s=arc-20240605;
 b=AoqPmX8+t9CnGak0FyImH4FhUMGLrEUzbTVOzemMvoBJwMjEnispK2OjMv/waFQUEh
 bPKvSP8NWadZP8/VszYkPU7+XsOhQvT4iGWy1hc3H0S/sdNHFQprrokWYgsoS/oA5Kod
 ltKShD5RbRHse8ByRosY5W1SRKVTxEqnBSrDslAtL4xmBsq6z3bgNbIVdig+j+wk3C85
 2t1+WXUQGfgcdFadlF8h5zg1VIA/1MUTkZI93moMyW4JcEvpyz+UvR+sdkbMF/HeZ2DJ
 I+eeEY1oN0vkcV21kKgr6BuJJOKYcwznVEv/feE81xibNRW6Lqsqu5o3JWXip54c2nGd
 aJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1qpLZngxvD5vGzgjAq9F8kx7Hz38KrclZnLPXkRhlc4=;
 fh=Kv+B6Pb1oc5GwlGqxr7Z1nvSKsmKWMoX3QI5kJwyu7E=;
 b=ApSq3hU5b2rSFSmYtY1Kh1rXOOjHyBBEyNE4uW33aXQWDlx55yEtDCfbtz1qHihRkt
 2HPvHk50fhao8XYC2yG6uAB7YgfDyxbS7Dyf9SE/WHmZaa/iCEsfnrpR3X6GV1WgvVJ9
 0Z3lWuwALthZnsy12Q6jD3g4elhZEUI7iQYR2WUEUqB/0wC+7EMN+GXOxG5jsy9GhZzi
 1AwAHLNHU0GW/SQehJ/HNhFvfSVX0PvnQGHALxUNmuoC4pG+y1Bb3SCZ/RwyLXbKV44r
 86SIhdsHWCI7Hv1HGIXZ6Sviasc1kmqhAk+6D7UpuvQ0/l5FK3na1YIY9wcbqVFijaaa
 /eZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774590530; x=1775195330;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qpLZngxvD5vGzgjAq9F8kx7Hz38KrclZnLPXkRhlc4=;
 b=GYpL4cUvrUEHW28pWM2chOnqhC7gNysGn4zTcnlxKSoyzMU4EoSpEeKW+rfbJ83cWl
 Z3dvoqqYNvKj2FCnxI0Q8x+oPxxhUx8RhS6NWcV2gAzP7qAuW0y672z6xfbN7ZQkvyhk
 O4K45e1Ex46RyQ25mD+nzh9VNGLne2KTV77LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774590530; x=1775195330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1qpLZngxvD5vGzgjAq9F8kx7Hz38KrclZnLPXkRhlc4=;
 b=iu7Y1yvtfyoYvSfHKYgyYI0Z3zCqkKclQEuZPP3YMuttMefDXHgUh40QvZsVAKqzZN
 MkSzWjQoUgoA2wj/itq+VHo+7UL5tvio4u0LTe5Q1fcPz0elCAOqEkEHTsfLRHNYlJlX
 nvJcQfnOtYLFkvccMX32GF1zYKNdmb/BjqLRUI2jSxe2J/vCZ2gWX9Ffq/NHKM/A719t
 DlwC9g8J1LAOcMtTsvBoEJD3uIVOSVwYyfTKvM/ww3Rj6N7PzxmG+poankakWBmu/4iM
 bjeRYKjLkDiD7oLczcx+Utv0JXrZjzZvanDz06gjU0L1cr7i5a3c2N8O44ogW1i/zd7p
 CfHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAphlX5HqBTosGowe32lgtnYsqe7o0+avV1oM4uBnMlLL90GaQ2okUZMA3t0xRTgHgRJBwS+0lQXE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSV9BdRyVm6W92bqGy3E+Eq03R3Tf0OaDMgW0xqST3Sexg3fZW
 5CLzc23Orz5d5QlImzJWd8gkYnCK+sRXEVIXuNeIsIOl6VlVcUKOKxK2hcoQUJ41XIP2M4qZOh6
 rwd9EiIxIkBq3upR+Uj1ypMhJnprWj96fJL6NboB/
X-Gm-Gg: ATEYQzzk6zczNfxJJ0BkCoUJr9h0F6mZ/79nqOVLsGVQ8qcYndlQLnWA/jRrtef+HgD
 lPFk9iSTxkwM4edubEgmSM2ZylxZUqe2gSLU9jjjHY+oUIygWDDXAXOSA9VVERLS0YXXRFjvQWY
 sZRApujUgCLRyGhDJTReownw2d4cMd3+NbX0m7AmMgP1VDAUPOtjEa3cUX6xgAd1Hkb/8FQZ4EV
 BxrPFwPoerKug2v+DhusqU4qJF7kBqCcvPjetwJc9h3OzR13mrP9jpwceSRK/tLOi1tmaTlcBnC
 kYv4YaVQGz/zm9s9oz614oCzMFJU/LZrLblYcxQIOcoSykMv
X-Received: by 2002:a05:6512:1381:b0:5a2:a174:8958 with SMTP id
 2adb3069b0e04-5a2ab92ecf0mr476484e87.35.1774590529804; Thu, 26 Mar 2026
 22:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260326100248.1171828-1-wenst@chromium.org>
 <20260326100248.1171828-3-wenst@chromium.org>
In-Reply-To: <20260326100248.1171828-3-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 27 Mar 2026 13:48:38 +0800
X-Gm-Features: AQROBzARD5T-N88wRerzc6s3uT8QWrLP8JTHwtVEEck-nl5IEJvH7p2VWcn5d8s
Message-ID: <CAGXv+5EsqS6N85q6e+t1zYt-58MR2rRUUuAgeW-4RUWTYc0Cgg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/gem-dma: Use the dma_*_attr API variant
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Thu, Mar 26, 2026 at 6:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> From: Rob Herring <robh@kernel.org>
>
> In preparation to allow DRM DMA users to adjust the DMA_ATTR_* flags,
> convert the DMA helper code to use the dma_*_attr APIs instead of the
> dma_*_wc variants.
>
> Only the DMA_ATTR_WRITE_COMBINE and DMA_ATTR_NO_WARN attributes are set
> in this commit, so there's no functional change.
>
> Update rcar_du_vsp_map_fb() to use dma_get_sgtable_attrs() instead of
> dma_get_sgtable().
>
> Also change the dma_free_wc() call in vc4_bo_purge() in the vc4 driver
> to use dma_free_attrs() to match. vc4_bo is a sub-class of
> drm_gem_dma_object.
>
> Sub-classes of |struct drm_gem_dma_object| can also set additional
> DMA_ATTR_* flags if they choose so. For example a sub-class could
> set DMA_ATTR_FORCE_CONTIGUOUS in certain cases.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> [wenst@chromium.org: Rebase onto renamed DMA helpers]
> [wenst@chromium.org: Make vc4_bo_purge() use matching dma_free_attrs()]
> [wenst@chromium.org: Make rcar_du_vsp_map_fb() use dma_get_sgtable_attrs(=
)]
> [wenst@chromium.org: Expand commit message to mention that sub-classes
>                      can set extra DMA_ATTR_* flags]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> ---
> Changes since v2:
> - rcar-du: Change dma_get_sgtable() to dma_get_sgtable_attrs()
>
> Changes since v1:
> - Rebased onto renamed DMA helpers
> - Made vc4_bo_purge() use matching dma_free_attrs()
> - Expanded commit message to mention that sub-classes can set extra
>   DMA_ATTR_* flags
> ---
>  drivers/gpu/drm/drm_gem_dma_helper.c          | 26 +++++++++++--------
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c |  5 ++--
>  drivers/gpu/drm/vc4/vc4_bo.c                  |  2 +-
>  include/drm/drm_gem_dma_helper.h              |  3 +++
>  4 files changed, 22 insertions(+), 14 deletions(-)

[...]

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/=
drm/renesas/rcar-du/rcar_du_vsp.c
> index 94c22d2db197..a4896096e3bc 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> @@ -291,8 +291,9 @@ int rcar_du_vsp_map_fb(struct rcar_du_vsp *vsp, struc=
t drm_framebuffer *fb,
>                                 dst =3D sg_next(dst);
>                         }
>                 } else {
> -                       ret =3D dma_get_sgtable(rcdu->dev, sgt, gem->vadd=
r,
> -                                             gem->dma_addr, gem->base.si=
ze);
> +                       ret =3D dma_get_sgtable_attrs(rcdu->dev, sgt, gem=
->vaddr,
> +                                                   gem->dma_addr, gem->b=
ase.size
> +                                                   gem->dma_attrs);

This doesn't compile. Sorry for the noise.
