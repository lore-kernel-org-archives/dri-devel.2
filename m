Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B31606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XoYM0/+Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8874310F009;
	Mon,  9 Nov 2026 04:41:55 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2C010F009
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 04:41:49 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c4d427836e9so57452066b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 20:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794199307; cv=none;
 d=google.com; s=arc-20260327;
 b=sfyukSIuFPwCKZxEqgdzd3eRx6k2wJ8Bh3H7iPgSEWTm1kF60Wv7AALcUKPBfw614d
 hhNVY8SrE67lyaXinYHMU0tLRKz34CpNYvHOjEUoR04b5I9x8MS7jwNjbBp1qmyQHppu
 Vec7CPHySMUsd5VTaWQjUNs0uwCtFlISfXaCPRoIUlP8dA6/R6D1Ih+YUTJaxFyWEDrv
 h7zx51/ex0dvEIazW60Qn7ilaqCyC/vNB0841kE1c83FYOnt33+qL46r5PHDXRL20j5q
 ghRjd98qvue8EmsPDhLYAODCL+jIcSuwqW7+49H/gjf2PAJgA31+IqVV8zkC4eonY3OQ
 3ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=27RG8D8CerxM4BmQ9ucwQVVSwZlvRge1TEEkPaNQ8Qk=;
 fh=F/R6BUeKFSHvVzIfdtLKRKQWKD2Oss/+SWvOFO5OcQM=;
 b=KeqDZ5/Cs/uvNo0QSh4WtpntgFeEBmMjh6VUCG32VmXqH5XyV6qS7a36VHikeHquSQ
 iDJZJZ3+hDuJKFJbDXvJpclgVcjcmRSurADA0Bg5I4tcRjFe3wANStTBSez9tkjyLpNc
 QJB0hryzC7d9vMZJp0Lxpu+2fI1eEiKXBxMsKRO4/02g/bRs16M/6/h3m2w13LxuyVl9
 Flz1z15wuomdIGswtfsU6P2etqkx9U1Sg6g49jhezp79jgF9u6RD1ISyUnSGJDsVT3Yl
 O1m+PUMgtwhtaMUDaOE2mqJWyuMvuDTlonT0Iszy0zmjDr3TokpwtEnaVhN8TatUccgn
 34+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794199307; x=1794804107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=27RG8D8CerxM4BmQ9ucwQVVSwZlvRge1TEEkPaNQ8Qk=;
 b=XoYM0/+YUd/9nfkSAR/t0M2oNX+9FMEwDTVj31XIKi0X2zDBbUSQieCeeRhzi0qamT
 htFQs8Y7yWfMKG1/5PaheNFRba6VSmmd40E5QXxsPrRyuCXr/9Q8PGx2HHXQyr51nSUM
 eOq+dR9BYghMFWJIu7DWbDhLeANR7kzXuD85daQx727CbC5r80JxKO8fJj2A2/88F6ov
 4dVLILqfLbw82GrmVS5i7VYRZN+oxvlBCUD5CIcD9fGtM4uOMl0tec0/aOtJ3xh7XZ9L
 I2zhr/ZRQLR+lTPG3Rab58R7J80jwtmBHe5ps7LasXK5iCgCgXiMYq6B/wt0+PDy25Gv
 X/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794199307; x=1794804107;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=27RG8D8CerxM4BmQ9ucwQVVSwZlvRge1TEEkPaNQ8Qk=;
 b=BmzUML1QmoQ+Y1VXTMPjq/uHh/NzA8RbDLCDU1KMOwiv1Zy8COuRB9ngZfBbnnuYXT
 Vza0cKxSsuw1IcyKbnGRHskRcqJ/E0ALITns4Aaqjyu5s6h3Bl2oOnv7apNa4cJkYJJb
 IgPxvTIK9aGCJxKwhcFz+sjvAYD3qDLmF3vY4oFKpF9N+gTAY4lc4CnqOHIM3QTfVLxH
 +Y+Zva16pkDEUkVE36BykkuTa0HBXf2OwOj/oE8erWdQFbDLHfRRl0npwLIIbs5DNoVl
 zEVlm7f3LpxUZIjODOGGP0L55vBQE7nKrtibeOciX52WzhKCjk8xFDyvEgkEWuakRjxD
 zgjA==
X-Gm-Message-State: APuU4Z+WPAPy+Y42qzi3w6REC3xQEM4d/cAFLLAAHZiEZiT0bGR4rVgy
 mBm7p0FhHDMrAcTfhRrrMypeZGGb/w5q6e9kGJaRm/Vcjf5SnAi4yzjp/A086L56NnE+FZ+R6or
 QCPY6U0u8o9AV14wTHUWZ3L29nzic+9M=
X-Gm-Gg: AYBFou0Kcck1u6ZyFkIIPARl03VZIeisvQ3fdRuxjubKcQDd6ngWjWUQAZBMZmhTdg4
 j9ViZsfwEnikzmsVsYYTEHDD+IYdMe8l3zf0rPPwdkJdX4qqZfGgaht8i+z0gK95y8edOMzfsmV
 05cJWSzP+vJ7cXgC/6O4EOxwYMCmGiTf/cAOduaenrYn7eemDuFsoDYHYDd9YWU6LThj08vF3q9
 UKG2ZX55dCnnIZXlZQNrKd8P6YZKzKdL68zpd7X6ZgEhPLG0Gf7h0wzAdPvC7EHuvVFw/g20O87
 PJbw+a0tcQgWlR7dEwbe4ccRXRY2b2bfn7vnoBWv17ecddUu4RfRasnFIwIFP1xoC79Hxz5goJ4
 0pAwxz94bQtLHH1dnACAKUaVe1dzkA+vjudq5jImPxJpm2/IU6XIUoFSrxh0FVv8zbfo=
X-Received: by 2002:a17:907:2d93:b0:c26:19de:9aec with SMTP id
 a640c23a62f3a-c4d6dd8cb24mr224378766b.43.1794199307082; Sun, 08 Nov 2026
 20:41:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261005001143.576737-1-rosenp@gmail.com>
In-Reply-To: <20261005001143.576737-1-rosenp@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 13:41:10 +0900
X-Gm-Features: AclHuK-aAUizeCRuM8WnAlvp8mvibSB9oiekBPg9ucUpGQvhhZ0l_iKHx8QZ7R4
Message-ID: <CAAQKjZOm5vA+38XVo5D4qV5B9eRT1seOShk-eFk_Jg_EQPdaOg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: gsc: allocate formats as a flexible array
 member
To: Rosen Penev <rosenp@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 "moderated list:ARM/SAMSUNG S3C,
 S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
 "open list:ARM/SAMSUNG S3C,
 S5P AND EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 "open list:KERNEL HARDENING (not covered by other
 areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

2026=EB=85=84 10=EC=9B=94 5=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 9:11, R=
osen Penev <rosenp@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The formats array is allocated separately with devm_kcalloc() and only
> referenced through the gsc_context. Make it a flexible array member at
> the end of the context and allocate both in one go with struct_size().
>
> Annotate it with __counted_by(num_formats) so the array accesses can be
> bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.
>
> Assisted-by: LLM

The allocation and lifetime changes look reasonable to me, but
Assisted-by: LLM causes checkpatch.pl to report a non-standard
signature and an unrecognized email address. Please describe the AI
assistance in the commit message prose instead.

Thanks,
Inki Dae

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_gsc.c
> index d9637ddfcfc4..f1807ef664e1 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> @@ -99,7 +99,6 @@ struct gsc_context {
>         void            *dma_priv;
>         struct device   *dev;
>         struct exynos_drm_ipp_task      *task;
> -       struct exynos_drm_ipp_formats   *formats;
>         unsigned int                    num_formats;
>
>         void __iomem    *regs;
> @@ -110,6 +109,7 @@ struct gsc_context {
>         int     id;
>         int     irq;
>         bool    rotation;
> +       struct exynos_drm_ipp_formats   formats[] __counted_by(num_format=
s);
>  };
>
>  /**
> @@ -1222,21 +1222,19 @@ static int gsc_probe(struct platform_device *pdev=
)
>         struct gsc_context *ctx;
>         int num_formats, ret, i, j;
>
> -       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       num_formats =3D ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_fo=
rmats);
> +       ctx =3D devm_kzalloc(dev, struct_size(ctx, formats, num_formats),=
 GFP_KERNEL);
>         if (!ctx)
>                 return -ENOMEM;
>
> +       ctx->num_formats =3D num_formats;
> +       formats =3D ctx->formats;
> +
>         driver_data =3D device_get_match_data(dev);
>         ctx->dev =3D dev;
>         ctx->num_clocks =3D driver_data->num_clocks;
>         ctx->clk_names =3D driver_data->clk_names;
>
> -       /* construct formats/limits array */
> -       num_formats =3D ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_fo=
rmats);
> -       formats =3D devm_kcalloc(dev, num_formats, sizeof(*formats), GFP_=
KERNEL);
> -       if (!formats)
> -               return -ENOMEM;
> -
>         /* linear formats */
>         for (i =3D 0; i < ARRAY_SIZE(gsc_formats); i++) {
>                 formats[i].fourcc =3D gsc_formats[i];
> @@ -1256,9 +1254,6 @@ static int gsc_probe(struct platform_device *pdev)
>                 formats[j].num_limits =3D driver_data->num_limits;
>         }
>
> -       ctx->formats =3D formats;
> -       ctx->num_formats =3D num_formats;
> -
>         /* clock control */
>         for (i =3D 0; i < ctx->num_clocks; i++) {
>                 ctx->clocks[i] =3D devm_clk_get(dev, ctx->clk_names[i]);
> --
> 2.56.0
>
>
