Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E73CFC72BE
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 12:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847B810E064;
	Sun, 22 Mar 2026 12:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KEazxW4p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869C210E064
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 12:48:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D6FB740280
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 12:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F93C19424
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774183724;
 bh=+DtQACtjWQV/63LCvj8FhHvvOYsYlPtKyxT/kV73eXo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=KEazxW4pdXQkm5fA4QYCeDVSQSUyoQbVBgva9d+VcWoLuR9yLkrFgiIhiTK8/5izU
 xpL4MQ7tWsi8tRzw9F/F9gA8dp7XDjLuuZi8mieg79pIeyky1vDyRP43ZmUzY0Zqrf
 n4LzlNcyy9i+oSoov4HVmLXKGhyCuA1UNLZL7sqjif7dQg8NeV54UgQnMd0+xGPiZG
 MjJ4kqhungFGye5yRLw0y3Tkd7kJgZXugDeITeHcDwOlnv0G42mtI8p34X5jY7vZqa
 pfQV2o/zLJcm9chzDBlcazV1OSFbbCVsrZ1j6PdwcqeyRi9e+1VXPsekAqDF8vPY6q
 EjM8ivRtQSy8A==
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2c0ea57fea7so3888465eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 05:48:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU9s5aTj5DlvrX3FnBbWjMFJC0TGRzYqzDXJ9r4GdPVhAZ3nSfvMm2QF1ZQXyv4Ew1bCfeclF4m2GE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYcuCYDuW5EvwxkDNdTC9G/TGTLI45WP2Rd/Vit6aBOzlY9lX8
 ARmeOf/kroerfpLJTigs+sxqhxLcApw4HNov7Zyt/4qECJpub79/d++TYkSPEElzXXLCMKzhlnR
 gPLzK7xe5xKIEUWW+Xn9UtPzOcKkE0A==
X-Received: by 2002:a05:7022:b85:b0:128:d786:8ac8 with SMTP id
 a92af1059eb24-12a725b332fmr3592564c88.0.1774183724047; Sun, 22 Mar 2026
 05:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
In-Reply-To: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 22 Mar 2026 12:48:32 +0000
X-Gmail-Original-Message-ID: <CAAOTY__b_zjQZnHwktBTmj3x5wm7xacSsA+uZ0TzjFhabdaPNA@mail.gmail.com>
X-Gm-Features: AaiRm51LgG71Rayap4Jr4WgpvsodcOgbZVoTNsW735vZ4_JuKqtb7WjSvvTg7sg
Message-ID: <CAAOTY__b_zjQZnHwktBTmj3x5wm7xacSsA+uZ0TzjFhabdaPNA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
To: Gary Bisson <bisson.gary@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
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

Hi, Gary:

Gary Bisson <bisson.gary@gmail.com> =E6=96=BC 2026=E5=B9=B41=E6=9C=8820=E6=
=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:37=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Some bridges, such as the TI SN65DSI83, require the HS clock to be
> running in order to lock its PLL during its own pre-enable function.
>
> Without this change, the bridge gives the following error:
> sn65dsi83 14-002c: failed to lock PLL, ret=3D-110
> sn65dsi83 14-002c: Unexpected link status 0x01
> sn65dsi83 14-002c: reset the pipe
>
> Move the necessary functions from enable to pre-enable.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
> ---
> Tested on Tungsten510 module with sn65dsi83 + tm070jdhg30 panel.
>
> Left mtk_dsi_set_mode() as part of the enable function to mimic what is
> done in the Samsung DSIM driver which is known to be working the TI
> bridge.
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 35 +++++++++++++++++---------------=
---
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 0e2bcd5f67b7..b560245d1be9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -672,6 +672,21 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi=
 *dsi, u8 irq_flag, u32 t)
>         }
>  }
>
> +static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
> +{
> +       if (!dsi->lanes_ready) {
> +               dsi->lanes_ready =3D true;
> +               mtk_dsi_rxtx_control(dsi);
> +               usleep_range(30, 100);
> +               mtk_dsi_reset_dphy(dsi);
> +               mtk_dsi_clk_ulp_mode_leave(dsi);
> +               mtk_dsi_lane0_ulp_mode_leave(dsi);
> +               mtk_dsi_clk_hs_mode(dsi, 0);
> +               usleep_range(1000, 3000);
> +               /* The reaction time after pulling up the mipi signal for=
 dsi_rx */
> +       }
> +}
> +
>  static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  {
>         struct device *dev =3D dsi->host.dev;
> @@ -724,6 +739,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         mtk_dsi_set_vm_cmd(dsi);
>         mtk_dsi_config_vdo_timing(dsi);
>         mtk_dsi_set_interrupt_enable(dsi);
> +       mtk_dsi_lane_ready(dsi);
> +       mtk_dsi_clk_hs_mode(dsi, 1);
>
>         return 0;
>  err_disable_engine_clk:
> @@ -769,30 +786,12 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>         dsi->lanes_ready =3D false;
>  }
>
> -static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
> -{
> -       if (!dsi->lanes_ready) {
> -               dsi->lanes_ready =3D true;
> -               mtk_dsi_rxtx_control(dsi);
> -               usleep_range(30, 100);
> -               mtk_dsi_reset_dphy(dsi);
> -               mtk_dsi_clk_ulp_mode_leave(dsi);
> -               mtk_dsi_lane0_ulp_mode_leave(dsi);
> -               mtk_dsi_clk_hs_mode(dsi, 0);
> -               usleep_range(1000, 3000);
> -               /* The reaction time after pulling up the mipi signal for=
 dsi_rx */
> -       }
> -}
> -
>  static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
>  {
>         if (dsi->enabled)
>                 return;
>
> -       mtk_dsi_lane_ready(dsi);
>         mtk_dsi_set_mode(dsi);
> -       mtk_dsi_clk_hs_mode(dsi, 1);
> -
>         mtk_dsi_start(dsi);
>
>         dsi->enabled =3D true;
>
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260120-mtkdsi-29e4c84e7b38
>
> Best regards,
> --
> Gary Bisson <bisson.gary@gmail.com>
>
