Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B72C55171
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 05:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049C710E3DB;
	Sun,  2 Aug 2026 05:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T1qbkqX3";
	dkim-atps=neutral
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2734E10E3DB
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 05:47:44 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-59b074ec7ceso884932e0c.1
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 22:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785649663; cv=none;
 d=google.com; s=arc-20260327;
 b=dO138fLKzGKHTsXJGp+ayF8unobeaKeWF2kPZ7kQCKFGKCyWdCsXj/B7CH/FT0O4vx
 2iw7lJ31aJaZ1nOu9E1Xr9tqn8dN8g7lFTIgnZv5nOr4MFwbFknQ1wyFJzQW6HSeiKwc
 hUvwpBFLpZy3j1Erjqh6sk/brzNaZu2iRQ14CZp6gWLQT1tLRVB3kqkP9GTBXi2gpCWl
 yFTMdLtiINJpJ1ujXJuiw4vAkIna4euNqiftBV9I/E3wiMZgHaqu3wx6DEH/wWkAgAgq
 Z1NnlrOKiunOfXSm3Nm6yV516EDLKKuUAppnO4SbyStWLpQZrUvGQjzs9g18FGnpBIPn
 uOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pzUc3cu7eYXLZesTw+qzStppD+6/bSKMRwSOeVVbqx4=;
 fh=QwveCAKG2k5MBFYISr/DhkOqFVwX4msL/Rwqn8AbqZw=;
 b=gaZwP/7EvIK6Xr3/Vy38BUuNXNHDC10Do+5HZCXxyjk6GtvmJ43+4GlD+C+zkRwlUc
 xVzzdCbFoGpEWKsnuf8ldqNu1JTxAPfUfAspuEBkfaxPht8mnj1VlJt8M+LxgiPcV5d+
 fdT6/SxQhw6RcovN7KUO78CiXHj004kbHqOzhhHDEEJG124Cc39WSQP+d0xmThHJeEd5
 upFWNK3Gus9qE5mEc0VJOqBJe4Y8f04+Cz1qB25b2VTaNxtwEECGtxSXWMovU+PqBZvd
 1Jpmmi4GgvkHx7coI3+ZSi4XwJ/YF+Jyt9sW7HThyKs7g0zQQYC68g4TA8Cfsq0Ylncn
 h1aQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785649663; x=1786254463; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pzUc3cu7eYXLZesTw+qzStppD+6/bSKMRwSOeVVbqx4=;
 b=T1qbkqX3r0D8oZhvCKfLtY3mvXWNUeNuxUOUikiDv86Qvh8qNVU17B+UFL1C+zFcfR
 i5ULiQw2DxBoz3/jxKfXlzqGfoNCvXrxKFCvAjRP2P/tJIag3EDU2wQIVkBx8Ek2f460
 ZhKhmfVLnt4brDTVRSC2m/r69lJSe7yDAQQvpEcOBfb6nJ5Y09gJ5G3idJe1j65DIKZm
 i3fHsyLZX6CVCoUq26x7hyLCGtoz6+MRCAMd/5k4FKNiLZhM22bMVSnZGBaAvwoUmBmF
 ZiNT8B/BTomeZlpH9z6tJ725kH2YrwYR9Z+D6d4x8y5cn4UmZV3Gk39G7O6C0dy+znER
 FNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785649663; x=1786254463;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pzUc3cu7eYXLZesTw+qzStppD+6/bSKMRwSOeVVbqx4=;
 b=lXiv5accaOXw/iaS1ytwxVqXrjtTRkR22KWNIRzvCG9BBIwC6b3N3zejcv0tKBPelx
 y/vCWubDGarYq6BV3ijHJ/WBlEIkoNyuFQAhUYby0woIGoZsMkHU44CFEn4h1Psgy5/o
 ZJaFGVq59WDOxo1rMqmFxCj9X7BHED8RWiaZ7EjliFGgbl7GYE6ZJ0JDFvzVFhLHZJvn
 EPCA2HCJlkVWEvWUOLLthk28My34vectbG/eIWgRGf6z3SW7rO9I3m2RCRmdPhhMMP+a
 r1LUZeztPjNLYSE4lvTUaJKIosMQ3jSHB6sW6YYU34zcYW4CN2Kt3W5O51jsUotEr3VH
 k+SA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpppm1IYG9K2KKB3fWWcjwb924K/i2Bdr3NFdAqQXB9uKQJzL4qSq0Xv2EtG5xAqQXRpD33m9KsJcs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxvWwHWcUsFgm/uT/JE3RKFPdmfljPPCbxLgQDOnlcFALPIl/O
 mWaukHN5ZbNh638wSSEXoQrlqsP9xdooZqsj98UUOWpt1bFCYvPS4JQLr43sPJjqh6EIhr7aCIS
 c+vzJG/L5rQmkdqJc67Ejo0mGGEZ65XM=
X-Gm-Gg: AR+sD120wbtHMXYV63Gx2/30M7Z/42uP54esPkZy1jn0i3bcnt3tehA5fHujwnqxlCV
 oNohoJLre6DtYur7KlJ73kTCnvpzg5I+fE1NRnJg09ZOQYh2xNkCkBCC+jM8eZgxFZvpq7BH/M1
 Qk69+i8iXrRSvOyNP47b13RbvMjvsznsMe3MZVuEb/ocWexklCJZiBwyF3h1fVxU20vtfJWcFzO
 SsVVtw1LYc7JWL9690dkvunFzGN2YskcWdQjdry90Ovq1uh0E1nrMA4QvPuaKrDzeyB9OFsCXFe
 N1orrQiKu4FDLwc1rpI/VNCbuyEhPOMawpMOQuqoeh6pAsZMLLkh4L0RXuY0Pw2ev0uv8Q4w7ws
 kg4+9/8M08A==
X-Received: by 2002:a05:6102:6899:b0:726:cd42:d023 with SMTP id
 ada2fe7eead31-75b2375d6eemr3857526137.11.1785649662796; Sat, 01 Aug 2026
 22:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
 <CAAQKjZN12OSBg+ch+xf+-uO6_Sbrtq-o8AkLdLA3mFQ_ubiLxA@mail.gmail.com>
 <CAJpoHp48cXPLrwvANAt_-D-jE=DcSyodAL=p36kQw3cGtQW_fw@mail.gmail.com>
In-Reply-To: <CAJpoHp48cXPLrwvANAt_-D-jE=DcSyodAL=p36kQw3cGtQW_fw@mail.gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Sun, 2 Aug 2026 14:47:05 +0900
X-Gm-Features: AUfX_mymp3gbWIvEFlOpn_puCcmLWjZUNex9N8Qxwa40WVIlIo2zevDdW66QGDA
Message-ID: <CAAQKjZM5cY8V_YaZzgF734Brabz=zwRkp2k-+b9CbqS2_Xvi2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/exynos: DRM encoder improvements for Exynos
 devices
To: Diogo Silva <diogompaissilva@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Diogo,

Thanks for the patch. The conversion itself looks correct.

Two small things to fix:

1. exynos_hdmi.c: double blank line

> +static const struct drm_encoder_funcs exynos_hdmi_encoder_funcs =3D {
> +   .destroy =3D drm_encoder_cleanup,
> +};
> +
> +
>  static const struct drm_encoder_helper_funcs exynos_hdmi_encoder_helper_=
funcs =3D {

Please drop one of the blank lines. The other four files are fine,
only exynos_hdmi.c has this.

2. exynos_drm_dsi.c: header include order

> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -13,7 +13,7 @@
>  #include <drm/bridge/samsung-dsim.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_encoder.h>

Here the new include was put in place of the removed one, which breaks
the alphabetical ordering. In the other four files you added
<drm/drm_encoder.h> at the correct sorted position, so please do the
same here:

 #include <drm/bridge/samsung-dsim.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_probe_helper.h>

Both are trivial, so no need to resend - I will fix them up myself
while applying the patch.

Thanks,
Inki Dae

2026=EB=85=84 7=EC=9B=94 5=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 4:54, Di=
ogo Silva <diogompaissilva@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Inki,
>
> > It looks like you may have forgotten to post the v2 patch. Could you
> > please check?
>
> I think they are here:
> https://lore.kernel.org/all/20260623-exynos-drm-simple-v2-1-a8d59678b7d2@=
gmail.com/
> https://lore.kernel.org/all/20260623-exynos-drm-simple-v2-2-a8d59678b7d2@=
gmail.com/
>
> If I did something wrong tell me and I will re-send them.
>
> Thanks,
> Diogo
