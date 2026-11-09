Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF437606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uP4ilRSi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F20E10F033;
	Mon,  9 Nov 2026 05:20:54 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8F110F038
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:20:48 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b6f42095bcso603051a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:20:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794201647; cv=none;
 d=google.com; s=arc-20260327;
 b=V8bok1SUCTU9YLc7dT/wf2y3uSiE5+4am/p5j66ZzTcPzIsyENS+EVro8+dnDfA/1s
 cfKYo3KoSvdGlsARYvkiuzmY5Qim8tIXBgq4/akDwNLmqvb0LgMMdkGjteJA/JSvlVhZ
 fzLhgicn1TYyB2h8pDV4pYJy0zE/QxmQq5DVCxsdcryglxbeK2G7Zbl+78FIurcd3K7P
 Lp2dZJ2sFRWbZjiwdmzgBX4dXTmai8HTQ327ITNcMFWgwFf2K4YATH/8KemhWvm/GwIh
 bGpQyOoAia10dBHeAiZydFdHYlkFRBhCH+NhrOlJl//zahEhXso0UI9pHFIa7BKgukMh
 JLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WHqXmw0GVc1+mZ62lwJeX+opySq3aWGZVirYtpV1Hks=;
 fh=JRwwriiS1/rlBbjA58jlmkv547esaz4FMyKxznjIMU8=;
 b=QoRvLliOaxW68r/QMvOnqpil282UnRTgZaropc5oCygy1Rsj9ku4T5n3QZbOJZDTmq
 FQPDxQjI9FaRzZyqUJteNZhvDdPr8i6xDKWKMOvV4JTD8/uPEMc/H5HwXr/91yaEz2uI
 parwFgeFmDm4n0NEOBzJ0xLqOYLnzvUs82hK0+hANjGvqKUGtDO/VI2PdZshz3dxJXyL
 GRiw5HfYaTjBJeW20yNZ2vl6s+m3xVALoqolqIJyOOC85bh+KoHwpAcqNSgzsxOR5iuo
 poq0+VMgwkLoYS9TzMbSppppgYReadMrmtXr0oGt/gOtrVHG+GfkafafkRbadNJwfAWx
 P8zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794201647; x=1794806447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WHqXmw0GVc1+mZ62lwJeX+opySq3aWGZVirYtpV1Hks=;
 b=uP4ilRSimpS6dzYUQXZshJM0wHWKPXt04ZjqL+UuPLS/S+Xdt7carGiYfwbJtsJasX
 +kfCK5ZN6IlGSFMGnKWEN+6oDGE7Db/2KhhRM8oXKD8xqs+oxtYnvcMhlDrsovAwrcI1
 SJLTm2KD8gKNAeAXwY8kWd7LjxVmgH30cphPUYQu2QSVdKrs5pr1oaCU+yEB4g6UsQFx
 pbwrrOXrUmFpQzecyG09fDi7e1kEtXuJe1sLwt/t1+2pIRRLPnFVO5LhUaGlGGPvrl1r
 2pftr7oOu+pTJWBlkB7dWMzQ1K3vf3Glp7NOa0GpuKLlIOTLKVNMt+zQDmTVD4odh9Ua
 5ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794201647; x=1794806447;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WHqXmw0GVc1+mZ62lwJeX+opySq3aWGZVirYtpV1Hks=;
 b=h4z68EhM9uRgn3OaPdN5R8exaaMZ3APUQycmcsMRW9OM8YkWtaXchl1lhN+NO+LKaS
 UVXGGWse6y8yqTE2hmN50KFsQmis5cq25fmzsI/KilUwCFDYkcnCMzycfks27E0GMOC7
 MVM3QJ6qssVRViFMa6j5J+CqUJdL/hv+jBx8EWzeAMNwk+3YH87Nb1xjdlOioP2a60vf
 tPNaxoknMMigztO1u6/7/YUtDkuoFrztONjtVn7Nuog+mWrplaHMwV0aaIm/mpD2ZJPM
 U39cH2kq6hd1Iih9aOb37KxYPyZe9hH0yr97CoCM+nBX2kCoA1TK7M0sMeHIgk83j/cb
 eLtg==
X-Gm-Message-State: APuU4Z9QK4lyDOWmSE+LyUF5B6M6qI6sf9w3XBB+vLsGdvRYC+AtkbCH
 tdCHfBFnzgnBbM/p73OqaT4LuW5OCezGWySKPaoVJvP0UB/m3lCfPY/RVA35uTF9Vb/Sps7m14w
 fLVxh14S1s5+x9AokuYAjvcYlL9+8/54=
X-Gm-Gg: AYBFou04UFclel5XEGzyi5TyTAqMdOIzOgG505gLqJN9BsaudURFwMYOlPKICreICab
 pdkxnoF1ZkWZSkDSL0eANCYpPYQRIe354ue3d18WAz4XNE23Wrag2t52ZH/mb2wSL/scHAOMnOT
 MHIA7FEkIH311lkdsXuy09wI+7nd/v3kwbVUzMvzqVaUtfdf556FvmbWhm2pnU/TmjiUPON1I1h
 K9KiHosIhk594cumL4J8zks5lSrYcUPC///HF1ip6NhwOa1bhbeGiCpjAorGJpUtmwScr0xCT0C
 fEo3V3Jxi9Q+E6cLmHgR7xXqpoRn/w+Wgvm69XltjJ5JG+fY6sq4brZZGre3GK/+lKb2W4N60nQ
 uhpUSPGGW4pi8Wu+whof7PWapFrD82bwVdjNyN6CjoLog30+nJVu3Mn5q+KqtNsXom+Z9SRRs+4
 j3kHD9YE5groqxfuENL/Sn10hDg9C9faT4tzBzdjRHgHav0pAj2QME/vaF0FEdvyiVJs7UbNDvP
 jWfL2/qga/ki4vCwvlN5xMY1HBSNh2lmZD/QmYzJuV2aKhvsw==
X-Received: by 2002:a05:6402:2349:b0:6b1:d2ee:392f with SMTP id
 4fb4d7f45d1cf-6b722462c10mr1849087a12.25.1794201646678; Sun, 08 Nov 2026
 21:20:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261005001143.576737-1-rosenp@gmail.com>
 <CAAQKjZOm5vA+38XVo5D4qV5B9eRT1seOShk-eFk_Jg_EQPdaOg@mail.gmail.com>
In-Reply-To: <CAAQKjZOm5vA+38XVo5D4qV5B9eRT1seOShk-eFk_Jg_EQPdaOg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 8 Nov 2026 21:20:34 -0800
X-Gm-Features: AclHuK-SIIyleRJSywdY0Z0pO7le2Nv4F_kttBOVsLQnGOrWIxGto2xb9JrsOXE
Message-ID: <CAKxU2N9a6+0DXxtTxNwxWm6yBxmZS+AHpBLzyNBsvfRBasgAWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: gsc: allocate formats as a flexible array
 member
To: Inki Dae <daeinki@gmail.com>
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

On Sun, Nov 8, 2026 at 8:41=E2=80=AFPM Inki Dae <daeinki@gmail.com> wrote:
>
> Hi,
>
> 2026=EB=85=84 10=EC=9B=94 5=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 9:11,=
 Rosen Penev <rosenp@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > The formats array is allocated separately with devm_kcalloc() and only
> > referenced through the gsc_context. Make it a flexible array member at
> > the end of the context and allocate both in one go with struct_size().
> >
> > Annotate it with __counted_by(num_formats) so the array accesses can be
> > bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.
> >
> > Assisted-by: LLM
>
> The allocation and lifetime changes look reasonable to me, but
> Assisted-by: LLM causes checkpatch.pl to report a non-standard
> signature and an unrecognized email address. Please describe the AI
> assistance in the commit message prose instead.
It just wrote the description. No actual code. I'll use
devm_kzalloc_flex in the next one.
>
> Thanks,
> Inki Dae
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_gsc.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/=
exynos/exynos_drm_gsc.c
> > index d9637ddfcfc4..f1807ef664e1 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> > @@ -99,7 +99,6 @@ struct gsc_context {
> >         void            *dma_priv;
> >         struct device   *dev;
> >         struct exynos_drm_ipp_task      *task;
> > -       struct exynos_drm_ipp_formats   *formats;
> >         unsigned int                    num_formats;
> >
> >         void __iomem    *regs;
> > @@ -110,6 +109,7 @@ struct gsc_context {
> >         int     id;
> >         int     irq;
> >         bool    rotation;
> > +       struct exynos_drm_ipp_formats   formats[] __counted_by(num_form=
ats);
> >  };
> >
> >  /**
> > @@ -1222,21 +1222,19 @@ static int gsc_probe(struct platform_device *pd=
ev)
> >         struct gsc_context *ctx;
> >         int num_formats, ret, i, j;
> >
> > -       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +       num_formats =3D ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_=
formats);
> > +       ctx =3D devm_kzalloc(dev, struct_size(ctx, formats, num_formats=
), GFP_KERNEL);
> >         if (!ctx)
> >                 return -ENOMEM;
> >
> > +       ctx->num_formats =3D num_formats;
> > +       formats =3D ctx->formats;
> > +
> >         driver_data =3D device_get_match_data(dev);
> >         ctx->dev =3D dev;
> >         ctx->num_clocks =3D driver_data->num_clocks;
> >         ctx->clk_names =3D driver_data->clk_names;
> >
> > -       /* construct formats/limits array */
> > -       num_formats =3D ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_=
formats);
> > -       formats =3D devm_kcalloc(dev, num_formats, sizeof(*formats), GF=
P_KERNEL);
> > -       if (!formats)
> > -               return -ENOMEM;
> > -
> >         /* linear formats */
> >         for (i =3D 0; i < ARRAY_SIZE(gsc_formats); i++) {
> >                 formats[i].fourcc =3D gsc_formats[i];
> > @@ -1256,9 +1254,6 @@ static int gsc_probe(struct platform_device *pdev=
)
> >                 formats[j].num_limits =3D driver_data->num_limits;
> >         }
> >
> > -       ctx->formats =3D formats;
> > -       ctx->num_formats =3D num_formats;
> > -
> >         /* clock control */
> >         for (i =3D 0; i < ctx->num_clocks; i++) {
> >                 ctx->clocks[i] =3D devm_clk_get(dev, ctx->clk_names[i])=
;
> > --
> > 2.56.0
> >
> >
