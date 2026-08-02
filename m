Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789ACC55171
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 05:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907E210E0D5;
	Sun,  2 Aug 2026 05:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rmnps2B6";
	dkim-atps=neutral
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD87A10E0D5
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 05:55:18 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-7564b7a9490so2386893137.1
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 22:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785650117; cv=none;
 d=google.com; s=arc-20260327;
 b=MyX0p5SyFtZfGUn8JZDpNP7GX7f8LUCw0TW+nwF0qup0VYuFPHYHNc5HiULJgHDTp1
 OseUiSz0DMavOIWo5b2Lkq4sbSADITBV9kbvfPuM/JhkA8WAMQ/+XftOzS1PM1WqMRyi
 9K+E5V3OXXDqKEnQdvEZk5wSXXrw0u5QsVO7qkfLOzRjYLROIbmnqPDGhoinGMtULcNd
 inCDGhWAdir2EtNQ+iqPmjw9/GLCSxbWC7acKU/RtdT5OKbgVtQzg3HAsMc0/+mx9AcM
 fZsAceIIpnqS6VSdU+wQyliFcb+qRehBohugLPbk/ddT5SQzIp2QwMJiSke2sGSVY7IN
 G7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Vs1SQCwA2eulFFZ+BXHMpPyX24h7ndFKDeTGaZkolU=;
 fh=qHQAfLoGrqOT0v/qUmfC/ZYURYIuM8orJCvC8kUFABQ=;
 b=VUr8yeYmWfEWwQgIirOnwV5tHEkKJ2lCpMDZYQgKRohtSLKF1iSGBPrDZxFErp7DqI
 9i1RLq5c53adBKjF4Iq85H7R9U4s10fOkSjo/suv+6W4thsey1BEFj7P29oWu70C+rUs
 ZsX0jveI42QDofRcmq/GAb9B0n2I/WMmmxHbBoEX+p6Yi+tovT2r2nJso+VUTY75NJHn
 k0WqVlyvT7BXEiPyQ6uStphNl89gtcFL9TYAeIbK1XYNjV5JOMSzqQOwWjsrxxdIx2l/
 Ap5soeZVYN8b3aLr87myROuhBEx6gjyEtD5lm66pu7UO2k+EkDmPZrzcDrzVUWJX9ulh
 ml+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785650117; x=1786254917; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Vs1SQCwA2eulFFZ+BXHMpPyX24h7ndFKDeTGaZkolU=;
 b=rmnps2B6mi9aXYXaC2Tl2zbX0flz5UtVD7cMTvbYv8uJSnHgqgd3dKVSRV1Oqjs693
 cn8tnS1hmc1zK5IIcU7z0C15knilJS5io/8s9QbzfqQwqOQC1Ul19xDOgc1ln65+OmAN
 pEF9SkU0K2Bi2NxJVlbJ/DENc2P7V4Z9VrwEgNzA2DLLWJdQ4PoACuPTF2zV0D49LNi/
 jV/q8BibvgI5nw+2nOAVhunIVkBhnzHBhCKXVy7bfcy9uSAa88SbGfHrxlTsYFgyroQN
 UvBV/Qf94zX4v0a+YxWFOQalSxVb4v4Vwp2CBSKx7DD/3nNn/P9+sj3BFzJrcg8R+qK+
 k6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785650117; x=1786254917;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Vs1SQCwA2eulFFZ+BXHMpPyX24h7ndFKDeTGaZkolU=;
 b=a7wiYcgisgnPkTHDAf7JvEra0iDguC1vFLr9a2X+PhYsXJvem3qziM/Y6ooHUWfwGY
 +9NEfrFftdvDcQ0Bxiiz9p9Ui8dGhmoqkVL9NYKK3+0OQjWnv0eKl5UVc7vnelJRg+EZ
 l2gS5YqzjAwQSdBsIz+JpC23Kk0RAA0HcOYfzSTQJw/aj00gTMm+8h+CybVBCuwC06e1
 yrNImXuSS4N3heB8Xn/+E3xzXHxqmnGw9X+4eLl9tvndLOUf5sz24pcK34YFB4FWksol
 rK4Eq2La75DxJhm3U35VvlV5HcTCoiFXAuwarGua+mX2RZiHdE1KvRQsLM91I6lWqUC6
 rfyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNFtBUQxwIivAqOYSPQxLr+IkkjhWjGlPLMwFSFbNL9+xgqni2YxEa7XopuebLbzh1a6s77iabxGY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEfDmaGeqgX5jYtjEC3LO0PLIangphBbgmX8RUovYKzT1lW3SX
 w/vUXhIgPLTqY7+sMKAcleCwPFqh7e+G4lMwE/GdrDTYLxQzgl6F9T+/2Z3TfTzsotleD/aZUKT
 oTe79EtbI3DJNVPS+ndYKuAI+jd0KKybdoU0v
X-Gm-Gg: AR+sD10IXzok8IWEmZ4kQc1u8IxFciq2ZkoeBXHT80xKzpI96BwwZ7zU3Oe9eVyuhOz
 456X8t0slakroe6dEK98TGNb8svdkJaRDqAJTZb3GbzPW8wX+UpV+EElxCRGs1dpMCILrpySSZv
 rcqgTlJFHTJHIA10KFWKCGlj1VpPTA8CD8yFcb+nkQ5sXWioIOsVPMyYpiIQsflHe5aofr86iFS
 JEbIEfjI+c9vZjOpcIh5FmBUnyWLG7uLEz3P4cHO2iWGKpfMeHJIf8deYukri7fulxluz3Bpc83
 B0RmWzB+3/o26+oluti+/3dOFuJ5tqU+1rA5fAEH5bNusnnDnCBxw08/7eOF17zWwBgDyqzewI0
 =
X-Received: by 2002:a05:6102:7ad:b0:738:f27:43fc with SMTP id
 ada2fe7eead31-758f8869b41mr1922174137.2.1785650117459; Sat, 01 Aug 2026
 22:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260716131802.1564776-1-johan@kernel.org>
In-Reply-To: <20260716131802.1564776-1-johan@kernel.org>
From: Inki Dae <daeinki@gmail.com>
Date: Sun, 2 Aug 2026 14:54:41 +0900
X-Gm-Features: AUfX_mxYVom-AX8ugZp9yvdrgZXKEh5DEfjSaw3ZzVclgiqSMtSKQ8CYJUJRy5U
Message-ID: <CAAQKjZPW+mHcXQJKQc7wJL=MGssBf10H_FO0S8D7uCjX48qrKg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: hdmi: take i2c adapter module reference
To: Johan Hovold <johan@kernel.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
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

Hi,

Merged. Thanks,
Inki Dae

2026=EB=85=84 7=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:18, =
Johan Hovold <johan@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
>
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exyno=
s/exynos_hdmi.c
> index 09b2cabb236f..b971b7098a4d 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -1913,7 +1913,7 @@ static int hdmi_get_ddc_adapter(struct hdmi_context=
 *hdata)
>                 return -ENODEV;
>         }
>
> -       adpt =3D of_find_i2c_adapter_by_node(np);
> +       adpt =3D of_get_i2c_adapter_by_node(np);
>         of_node_put(np);
>
>         if (!adpt) {
> @@ -2069,7 +2069,7 @@ static int hdmi_probe(struct platform_device *pdev)
>         if (hdata->regs_hdmiphy)
>                 iounmap(hdata->regs_hdmiphy);
>  err_ddc:
> -       put_device(&hdata->ddc_adpt->dev);
> +       i2c_put_adapter(hdata->ddc_adpt);
>
>         return ret;
>  }
> @@ -2094,7 +2094,7 @@ static void hdmi_remove(struct platform_device *pde=
v)
>         if (hdata->regs_hdmiphy)
>                 iounmap(hdata->regs_hdmiphy);
>
> -       put_device(&hdata->ddc_adpt->dev);
> +       i2c_put_adapter(hdata->ddc_adpt);
>
>         drm_bridge_put(hdata->bridge);
>
> --
> 2.54.0
>
>
