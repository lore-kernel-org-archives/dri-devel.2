Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528E606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eEx6W+6P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33FD10F002;
	Mon,  9 Nov 2026 04:34:08 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411F510E1F3
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 04:34:02 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c3f04e0e65fso61291666b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 20:34:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794198840; cv=none;
 d=google.com; s=arc-20260327;
 b=oW7JMqZ+DB53MYXszli99nLBQrDiR6qpGS8wBfmFjMBUpvnYszA+MtNx6Ta5IU/kOV
 eNZCZPxVBqqTC1uVHVBpTDT6z+xg2Kv9MQh1+LCs+f1Qe8DsCm1M4/xLflMplHy9qEaA
 BiYDzpqGTMf2SRAYi8AiRrsn9xRSwNQLmaFJNtIr3P4xUhUESlLXVW+nwb9/wYhBLvnd
 p8mGGb1Duo3ukw0nV5L2ZenmwHodGM49vh8m0q1SdVw7ZE7VuY+bh96PeEpNIGY2MlK+
 n8dxmIPLKqGDFA2nSmvmCcb2boXenDQ7tm1JpC2usAIfWLbS6S1HxKTRUqTZBpBIdGiz
 93Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+KZfMQTyVl02e8ANbgPdMXZ52kWV3/1B9wyIuCkTXxg=;
 fh=F/R6BUeKFSHvVzIfdtLKRKQWKD2Oss/+SWvOFO5OcQM=;
 b=L33PPcCWSwm+Kmr6k7pPIJ1dG/deOSa6gClAMLEzvAC27tJke6yiLjf4Deba4ZElLS
 cThDHdsV8DFdScq6wQRx9Q/QdkCPEls2yHwunyZUVj0REQfaV2qNfPD8d8Sif/puSnLd
 7rY5tH+2jTSXr/GYY320tiwlD3fluZxd9Cz62R3ukKcCWuQfs2/dihoKP6VnJ2yNnKrT
 dfxWxs7ZwbcOn9Lj/TyqbOd4PhvQjXeF39daxoqAdOBAhcfWZcMuRp4vd/JM0gyuCvHz
 GTeHO4r69Qdnt1UvIvhY83agbz7LFM3aLCgiahVb/sTviLpI0RUPHfBmZKhRp5ZSC6y+
 ep7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794198840; x=1794803640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+KZfMQTyVl02e8ANbgPdMXZ52kWV3/1B9wyIuCkTXxg=;
 b=eEx6W+6PUiZ+LWSQP4Yku+nE2debE4oWteziG2ARA8EJylz1H3Z1Msyv4sG1gTTtCk
 +BR898/ASyUhu2Gou+Gt20mAqMryEm16N+a8MDp2yAO8RTA8q7RFExOO5HU3lbVg9/LN
 BH/4x5W9fTF8AFCR3pLwLfk254S8Nm/DKbH+0gNr9JaxCBMlAFZd2egtIr5KQRhtMOg+
 ckTuxPTYR4kQQgR7R9HsEMjHLKiwFJB7m8CvHh453njc8NKFJt8YJdaNcP71plOOx3eZ
 fj1oodZIsl17uf3RDzFOQVB7r/Gc239yQFAAlyyD4eLlnUGtC6yuo0uy/V7ZzDPfHyph
 OyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794198840; x=1794803640;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+KZfMQTyVl02e8ANbgPdMXZ52kWV3/1B9wyIuCkTXxg=;
 b=cqkkVDmdVcEyHFtU+TxbSXLGH0m7wgEU/NEUK1DOKy8iLbWjwIVOcLyNim6w/5jyDq
 /q//jepV7vssfWJ13vXQa52VNnp3Y8xVmvaWehYA8Vip7vMx6o7gDnV8zvZIBnFisH6I
 QD/plVuTh5DQJULL7R1yTdAjKqJyuSV/d8p7SFPs0QNuEsu1jbjqs9fLqq6vGUHyjs0z
 tTsnvRjAcBLkNawGJxiNk9ECKoq/NLDCY06GPl5+EMC6Mk9OI31oaq7DiEp72P1vOxOH
 MbfuZlV8Q7VogJHda8PliePvnIN8pKvRO94rwTgXVw0gFTBjbhJ7evPgK74YilZV8l9/
 IdmA==
X-Gm-Message-State: APuU4Z9MmHZxNdYN5h3xwLzHAxFTmwnb8tSlKtu4sv2642Wl/WRsH92c
 Qb7vVhuQ5WcKluYJOcso+N+4GbfKiryNOh15XkTB3FxIxiBRIQRfc6XsqQuIx9t1lD6XetxX8AP
 fSxZvrBQ+rEOkaUU2CQgq2/v4iM2zNvI=
X-Gm-Gg: AYBFou2ZKOfAAH7YPDW3F6b8CQL+dvbXvjAiWyOndomGyvOa27/jg0VZU8CUvnTj6U9
 UUOTmkMsOuDfdIV5KS0tPaTia7TGqCGwTuA+ow8emRa5vBcpN/3iOkIE0nge7FmxljF3ZU+8kSg
 +kAoP5dt+OHfKvug4QECl4M+raKUmC03gkpymwFCr4Dvb9zBYIbiwX1Jh8aYx5QZT5PtOPjYPuI
 zinz5YdT79tUhmddgbpO1agUZV+YWk9BD5oNtPCcs42FXp0olMHoF3xfOWwF7TeGDsip2/df79i
 VR+ml0+DOCGy4rQebZin1raokQ6ZeBm/deT0B+9C3wy/1QMXKAk1EVFx7T1gbAME6i8FTyCAmGm
 7dDgQJaeayJEyTC479YU5fDnTw9PRxt1LCDFuWxNNznc8iD01PBh1LcsIqo+9b1D5eMjqAqMs24
 hKGQJ5ny0aH28c
X-Received: by 2002:a17:907:72c2:b0:c2e:4292:d268 with SMTP id
 a640c23a62f3a-c4d6daf7c64mr226694166b.16.1794198840452; Sun, 08 Nov 2026
 20:34:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261005001118.576198-1-rosenp@gmail.com>
In-Reply-To: <20261005001118.576198-1-rosenp@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 13:33:24 +0900
X-Gm-Features: AclHuK8JGFlUXZkSE5CgvPvR5Q5pqnVQnyO-MTmGLdNc0lY8Yjx1OxeFaWmjmHc
Message-ID: <CAAQKjZObmQm1X28cbpjd+dEVx93wfBwKNaaaxpU08o8JeFaZfA@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fimc: allocate formats as a flexible array
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
> referenced through the fimc_context. Make it a flexible array member at
> the end of the context and allocate both in one go with struct_size().
>
> Annotate it with __counted_by(num_formats) so the array accesses can be
> bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

The allocation size, initialization order, and format array lifetime
look correct to me.
checkpatch.pl reports an error for Assisted-by: LLM like below. Please
describe the AI assistance in the commit message instead of using this
trailer.

WARNING: Non-standard signature: Assisted-by:
#57:
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#57:
Assisted-by: LLM


Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/e=
xynos/exynos_drm_fimc.c
> index 09e33a26caaf..079d24d0671c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> @@ -99,7 +99,6 @@ struct fimc_context {
>         void            *dma_priv;
>         struct device   *dev;
>         struct exynos_drm_ipp_task      *task;
> -       struct exynos_drm_ipp_formats   *formats;
>         unsigned int                    num_formats;
>
>         void __iomem    *regs;
> @@ -108,6 +107,7 @@ struct fimc_context {
>         struct fimc_scaler      sc;
>         int     id;
>         int     irq;
> +       struct exynos_drm_ipp_formats   formats[] __counted_by(num_format=
s);
>  };
>
>  static u32 fimc_read(struct fimc_context *ctx, u32 reg)
> @@ -1273,20 +1273,16 @@ static int fimc_probe(struct platform_device *pde=
v)
>         if (exynos_drm_check_fimc_device(dev) !=3D 0)
>                 return -ENODEV;
>
> -       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       num_formats =3D ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_=
formats);
> +       ctx =3D devm_kzalloc(dev, struct_size(ctx, formats, num_formats),=
 GFP_KERNEL);
>         if (!ctx)
>                 return -ENOMEM;
>
> +       ctx->num_formats =3D num_formats;
> +       formats =3D ctx->formats;
>         ctx->dev =3D dev;
>         ctx->id =3D of_alias_get_id(dev->of_node, "fimc");
>
> -       /* construct formats/limits array */
> -       num_formats =3D ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_=
formats);
> -       formats =3D devm_kcalloc(dev, num_formats, sizeof(*formats),
> -                              GFP_KERNEL);
> -       if (!formats)
> -               return -ENOMEM;
> -
>         /* linear formats */
>         if (ctx->id < 3) {
>                 limits =3D fimc_4210_limits_v1;
> @@ -1320,9 +1316,6 @@ static int fimc_probe(struct platform_device *pdev)
>                 formats[j].num_limits =3D num_limits;
>         }
>
> -       ctx->formats =3D formats;
> -       ctx->num_formats =3D num_formats;
> -
>         /* resource memory */
>         ctx->regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ctx->regs))
> --
> 2.56.0
>
>
