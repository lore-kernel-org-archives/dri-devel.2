Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E8DC4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 23:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F4410E2E5;
	Wed, 22 Jul 2026 23:24:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF31F10E2E5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:24:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22860600AD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35A01F00A3A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:24:14 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso40957b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 16:24:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+xle6gF0wGGnRLI83X+0UfJh9Uh2kwvRFtyBjUS5U+NcR12GoSZ1dRQrXLMhsp+yTKp20BTK3R5M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyMqh8J1W6suXM3P1kstNkUvC6pTwDZ9x1SQpAznU80J8nAqn0
 8WsRg2Zp1hfQgjkHVxcmSiTUa5WRmfgFuwaBMWxgEGBsFA3Ngbvqkjf4hrMpbe8gtwjZ+gbtGLk
 E9afesP/CHmh//3dqbrxUz4hnJSEB3A==
X-Received: by 2002:a05:6a20:b786:b0:3c3:724d:ae7a with SMTP id
 adf61e73a8af0-3c44afb4d98mr594092637.9.1784762654438; Wed, 22 Jul 2026
 16:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260707150528.2270739-1-ruoyuw560@gmail.com>
In-Reply-To: <20260707150528.2270739-1-ruoyuw560@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 22 Jul 2026 23:24:01 +0000
X-Gmail-Original-Message-ID: <CAAOTY_9C2H4hJX0c5PAR8ucMYemPQcgYraqk37m0MbD-5BkL6w@mail.gmail.com>
X-Gm-Features: AUfX_mzXfIMvg4FClh2R9zHPqGW4oykaN4gfuRtC-scHkPiIE15gTbt7k6lUwDc
Message-ID: <CAAOTY_9C2H4hJX0c5PAR8ucMYemPQcgYraqk37m0MbD-5BkL6w@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Check CRTC state before freeing
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
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

Ruoyu Wang <ruoyuw560@gmail.com> =E6=96=BC 2026=E5=B9=B47=E6=9C=887=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> mtk_crtc_reset() destroys the current CRTC state only when crtc->state
> is non-NULL, but it always converts crtc->state to struct mtk_crtc_state
> and passes the result to kfree().
>
> When reset is called without an existing state, container_of(NULL, ...)
> does not produce NULL. Keep the mtk state free in the same crtc->state
> guard as the helper state destruction.
>
> This issue was found by a static analysis checker and confirmed by
> manual source review.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 2d267b81898e ("drm/mtk: Use __drm_atomic_helper_crtc_reset")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 8e552cdc3b53b..97e3ff412e6ee 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -154,10 +154,10 @@ static void mtk_crtc_reset(struct drm_crtc *crtc)
>  {
>         struct mtk_crtc_state *state;
>
> -       if (crtc->state)
> +       if (crtc->state) {
>                 __drm_atomic_helper_crtc_destroy_state(crtc->state);
> -
> -       kfree(to_mtk_crtc_state(crtc->state));
> +               kfree(to_mtk_crtc_state(crtc->state));
> +       }
>         crtc->state =3D NULL;
>
>         state =3D kzalloc_obj(*state);
> --
> 2.51.0
>
