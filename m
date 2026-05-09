Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E87CD3447
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 03:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC6510E121;
	Sat,  9 May 2026 03:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aG+XLVjB";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A7F10E121
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 03:19:09 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8d736211595so186583885a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 20:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778296748; cv=none;
 d=google.com; s=arc-20240605;
 b=PumIKva+Ow2Sfi1mrVUk18pzcXroe3Pu2h9OWjUUhbAktESNlwQIKX8RFaTjgaJH0P
 lHXd1zkytVi3AzjwbDH1x14l2/BmWyki2WYWwqoNo5w0wziVrFxTKk54/2gxr27B2cSB
 FA0WEzXw5S6YuSe8V4y9wBtrlGJ+Gsnm3Tzo6Em+5GkciVHhzC3ZWBns3tuiGs8DCmeZ
 iwGJJBDp/xG/olXI7PxwoFt8Zgys5GoGkp+PkB4WQBzpS2hBj8smoU/S+muHherVOdDp
 n32Qcnj10A5jdx8rYpZLTIs2tCp3nu9eQhf1/D6DNAubfHy6ifVhU7aVKCO/SeZdsic6
 3+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CxMznwGJOgjrL67SxyQcq86ofqmaCMHw/Ooho7JXCtI=;
 fh=NFXHkCfowzjv4TnnOj5gRg7ZGC5V04GP5DX6tCErH8E=;
 b=DR3hv0GunicrMax5rMvM0kNAUqcwnXuYDxoKGL6S7nIYlisoO0ha8Vax7RECkjGaYD
 ME64rhfWHiy3t7ErFE1n8JO/q2oPhyL1f/LIU0MXF0hY0cTmihZ9S0xsYo0tpcr5Av7m
 exkrcYdUdBQWzTKwXfQ0UxPcOGEvpBM1W1fTx7AiwJyGKi8fESSGLeku5a3ICUz4X63s
 cpElLKwiCULc16q+MgvCwp+3XoUuhRdKtpeauohszRqYhAvY5SBfsIEPQz21d38F1n1W
 4mXhWsqcTc6MKxt7ZCSidNuM74cAINEvz4yLEUhJurZ3wsPiAaKYJEDEs0LcYnXYM7kd
 LfrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778296748; x=1778901548; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CxMznwGJOgjrL67SxyQcq86ofqmaCMHw/Ooho7JXCtI=;
 b=aG+XLVjBmlQzzGglhjUguWbwrzBuiByKaTRi/ZH+O4qwH2DBwLooKaiLiiHkO+3qIL
 wNovf+ZkUCZ80587Jhvjgh1OjsTX97VH9vzsprGc5M4nCqeGngbbJz3IlDEK77ObP3p1
 +x15jbQ35NT9O+DON6yhnXDD62cg2wE15kUDpOmES1qr9E1x8+b/gjzb7ALZezq6cWFZ
 LKNZ3c4Lk4VaTLm6PjxDBKPDx4ujZpUXHNBru/lsotURiExnGAmE82UUIlafsqok8TzR
 KEoeNUwtANfB1f4KTQaTH9dkTGjAdEB7t9eKB9XL8jxWaSwrwK2lMKtgkDaOAMf6zXjI
 KZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778296748; x=1778901548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxMznwGJOgjrL67SxyQcq86ofqmaCMHw/Ooho7JXCtI=;
 b=NvUaXT0Yb6ZurAru6Cm6b52AdiPcESDvUPV+8BF3VTY/TNeZ7B6vkIi4qcb7JscZj6
 9BewGnG+sxBPXM80xE9Rnks4WcXAzozKfQwLLKuFBaGKY+R+k0vjrTtDVbWnC/Lcx3qE
 G+jYkiikmAINrybVGe8CRgsMe1WUs2cMge8oDysQD8D0MevRYz6c1FEHSXVoHQJ11lYJ
 d+0myKij+cBYzuecdX/XmKNTycFEJIeHcrtk2rArskv9znn45ABRa7JGZYfUeU/guUX5
 /nx0Mgf8D0O8w2YJ6TPqTndkaSdZWNBDe5XOSEuO+5IEe9R6nvv1RGN8Fmz4NTKwgFk+
 UuNQ==
X-Gm-Message-State: AOJu0YxNMfQZQvQNSCLKY9GCA63PlKd9Y//xSXR7jPP2xKuMFGHhuich
 4qT/nQysKPTBqBWXjvaoVAhWsYL1/PQL+DbidCLkxDlctuEX2S4fIs04idmKNfCyNziMnd895ID
 C3ZsZTifZo09dOdjrJbYz1HCA66INBcQ=
X-Gm-Gg: AeBDiet0Po+eOvFQzYTQnUIbiRdqw7hn74YeEIVa1uQAnXcxRvUW1I/kulvkP/U7/b3
 XeU7uMORLG13xRWWiA3GarEyfX4icxC7DOBPMTueAsVVb4T7DAhYL9Lpd7pe58A+c6X2c2HDzuY
 NM/vMipf0JPtwitWUo4Mhxh+hn1xMPSRlTpV/w1YyPdaIE8hs37xzxYDGyrIoTKf4OZL+E6BssR
 Iohfuxoy7L4H0wMnM5t1xr9GjUkz/eYo0VSjsTGMODYflTj3MGvFH/WZ8HSdExSeajruVT+Ux/k
 AgMGvEcDyojg16x/X4SghUJ1N30rwoaWxCT/L4AXH/33k6MSafrzi5ubVx+cD62gR5irVPADAzx
 hfHAa
X-Received: by 2002:a05:620a:f0c:b0:8dd:7422:6934 with SMTP id
 af79cd13be357-904d68dee8bmr2359167685a.44.1778296747959; Fri, 08 May 2026
 20:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260429030348.3930866-1-lyude@redhat.com>
In-Reply-To: <20260429030348.3930866-1-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 9 May 2026 13:18:54 +1000
X-Gm-Features: AVHnY4JKAYfBzEvcCazoWW39EPzkIq8d6VGfmI7CrPBmf49am2bEWNkv5j3ODv4
Message-ID: <CAPM=9tyeTxS+Dacc=YdXKrqC1OrrVG78EOkFv4x8f9ykcc3TFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp/r535: Add scanline position support +
 head state support
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, 
 Dave Airlie <airlied@redhat.com>, Timur Tabi <ttabi@nvidia.com>,
 Ben Skeggs <bskeggs@nvidia.com>, 
 James Jones <jajones@nvidia.com>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>, Aaron Kling <webgeek1234@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, Zhang Enpei <zhang.enpei@zte.com.cn>,
 stable@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>
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

On Wed, 29 Apr 2026 at 13:04, Lyude Paul <lyude@redhat.com> wrote:
>
> That's right! It looks like this never actually got finished, something
> which I just noticed today when I saw this fun message spamming one of my
> test machine's kernel logs when enabling display debug output for nouveau:
>
>   [drm:drm_crtc_vblank_helper_get_vblank_timestamp_internal] crtc 0 : scanoutpos query failed.
>
> So it looks like we've been falling back to DRM's core fallback for a while
> now, whoops.
>
> So, while it seems that we do have the option of doing this through GSP -
> that doesn't seem like a great idea. Mainly because reading this from GSP
> would involve a lot more latency then we should have for vblank handling
> due to the RPC communication. So instead of implementing that, just use
> gv100_head_state and gv100_head_rgpos for implementing .state and .rgpos.
> It seems to work perfectly fine!

Does the open gpu module do this at all, I'm just mildly worried that
blackwell might have moved stuff,

If you can confirm by looking at open-gpu.

Reviewed-by: Dave Airlie <airlied@redhat.com>

Dave.
>
> Fixes: 9e9944449023 ("drm/nouveau/disp/r535: initial support")
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Ben Skeggs <bskeggs@nvidia.com>
> Cc: James Jones <jajones@nvidia.com>
> Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Aaron Kling <webgeek1234@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Zhang Enpei <zhang.enpei@zte.com.cn>
> Cc: <stable@vger.kernel.org> # v6.7+
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c       | 4 ++--
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h        | 2 ++
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 8 ++------
>  3 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
> index dbd984da75014..0608266188d3e 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
> @@ -253,7 +253,7 @@ gv100_head_vblank_get(struct nvkm_head *head)
>         nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000004, 0x00000004);
>  }
>
> -static void
> +void
>  gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
>  {
>         struct nvkm_device *device = head->disp->engine.subdev.device;
> @@ -263,7 +263,7 @@ gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
>         *hline = nvkm_rd32(device, 0x616334 + hoff) & 0x0000ffff;
>  }
>
> -static void
> +void
>  gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
>  {
>         struct nvkm_device *device = head->disp->engine.subdev.device;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> index 856252bf559a4..b642729c254fe 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> @@ -53,6 +53,8 @@ void gf119_head_rgclk(struct nvkm_head *, int);
>
>  int gv100_head_cnt(struct nvkm_disp *, unsigned long *);
>  int gv100_head_new(struct nvkm_disp *, int id);
> +void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state);
> +void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
>
>  #define HEAD_MSG(h,l,f,a...) do {                                              \
>         struct nvkm_head *_h = (h);                                            \
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index 6e63df816d855..49a1eef9bdf14 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -625,14 +625,10 @@ r535_head_vblank_get(struct nvkm_head *head)
>         nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
>  }
>
> -static void
> -r535_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
> -{
> -}
> -
>  static const struct nvkm_head_func
>  r535_head = {
> -       .state = r535_head_state,
> +       .state = gv100_head_state,
> +       .rgpos = gv100_head_rgpos,
>         .vblank_get = r535_head_vblank_get,
>         .vblank_put = r535_head_vblank_put,
>  };
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> --
> 2.54.0
>
