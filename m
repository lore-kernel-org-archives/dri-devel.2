Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC74CD4F50
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 13:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48D310E309;
	Mon, 18 May 2026 13:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ALSgzLJ+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D54910E309
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:39:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E0188601E7
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9632CC2BCB8
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779111574;
 bh=1bjO3PVxRe3/4rE7yd1mVAeSvqZ+cwGYwn1Xps2SaBU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ALSgzLJ+v19bLSdcNKMsCGKuAGvNKVRKUMYWuPu0UdOUU5W345v7Yr14ulqs35hGc
 n2ZJ5WDz8pG+BIkECrdpiSG9RFfWLMszctVHVy2dEdv5UrQnUWYXaoOm7Soxr1PBGj
 f0J7stzkruGxfHyU5OKRzqfZkrNes6nAqrlGxuPojNajQyJq0nntx1Gvtr1Sng7Ztu
 G+iJir9ntiF9wrKvY+QOS7OhWaARdqM+Zgy1Rq4un3e6N/W8KPYuXEHFEjJCHRsWv3
 kRJkiNwIDaODDOlqJbg3gDg6Oec8rbQ853N2Z0W64FeYuTGI0Q1WFOokqu2bkvE4/Y
 Uo3xjmfbgXSJg==
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-133466cf955so9059585c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 06:39:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9gUsy+0qrKrlnAi9n0rZwtGgBtGSESm5K60AR2Y6XDQgTOhF6dGwzoNnQ+BUK9NSE059ho3JENq0A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIADmbWINqchrQVYAUW1VVWuyOboJr3/OjAFYHd2VdDDPtjXaC
 LWsdHstH1Bhm0AWFMQi2qG5suivcCKKQgJ0f/1sYiHcts4adwwZXK9rXlLL674o7W9tqPKj14/f
 yfpVy7DIXaHJ8SHItMxl/iTr9Gc5vBw==
X-Received: by 2002:a05:7022:f9d:b0:119:e56b:958a with SMTP id
 a92af1059eb24-1350451e343mr6439973c88.15.1779111573911; Mon, 18 May 2026
 06:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260420052008.5417-1-abhiraj21put@gmail.com>
In-Reply-To: <20260420052008.5417-1-abhiraj21put@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 18 May 2026 13:39:21 +0000
X-Gmail-Original-Message-ID: <CAAOTY_9LTmas78sFvwAnkxcXt0jqXaxZ1oa0jj_+xhL-o1Ei4g@mail.gmail.com>
X-Gm-Features: AVHnY4JN47eeSY49tByNRVwfGLFjrAA9LUtPn9wmQMHba45G9quErL5vSBBoobM
Message-ID: <CAAOTY_9LTmas78sFvwAnkxcXt0jqXaxZ1oa0jj_+xhL-o1Ei4g@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Convert legacy DRM logging to drm_* helpers
 in mtk_dsi.c
To: Abhishek Rajput <abhiraj21put@gmail.com>
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

Hi, Abhishek:

Abhishek Rajput <abhiraj21put@gmail.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=882=
0=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=885:20=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Replace DRM_INFO(), DRM_WARN() and DRM_ERROR() calls in
> drivers/gpu/drm/mediatek/mtk_dsi.c with the corresponding
> drm_info(), drm_warn() and drm_err() helpers.
>
> The drm_*() logging helpers take a struct drm_device * argument,
> allowing the DRM core to prefix log messages with the correct device
> name and instance. This is required to correctly distinguish log
> messages on systems with multiple GPUs.
>
> This change aligns the radeon driver with the DRM TODO item:
> "Convert logging to drm_* functions with drm_device parameter".

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Abhishek Rajput <abhiraj21put@gmail.com>
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 0e2bcd5f67b7..a67ad575f5f0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -510,6 +510,7 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(str=
uct mtk_dsi *dsi)
>         u32 delta;
>         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
>         struct videomode *vm =3D &dsi->vm;
> +       struct drm_device *drm =3D dsi->bridge.dev;
>
>         if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)
>                 dsi_tmp_buf_bpp =3D 2;
> @@ -543,7 +544,7 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(str=
uct mtk_dsi *dsi)
>                                              horizontal_backporch_byte /
>                                              horizontal_front_back_byte;
>         } else {
> -               DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\=
n");
> +               drm_warn(drm, "HFP + HBP less than d-phy, FPS will under =
60Hz\n");
>         }
>
>         if ((dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) &&
> @@ -623,12 +624,13 @@ static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi=
 *dsi, u32 irq_flag,
>  {
>         s32 ret =3D 0;
>         unsigned long jiffies =3D msecs_to_jiffies(timeout);
> +       struct drm_device *drm =3D dsi->bridge.dev;
>
>         ret =3D wait_event_interruptible_timeout(dsi->irq_wait_queue,
>                                                dsi->irq_data & irq_flag,
>                                                jiffies);
>         if (ret =3D=3D 0) {
> -               DRM_WARN("Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
> +               drm_warn(drm, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag)=
;
>
>                 mtk_dsi_enable(dsi);
>                 mtk_dsi_reset_engine(dsi);
> @@ -663,9 +665,10 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi=
 *dsi, u8 irq_flag, u32 t)
>  {
>         mtk_dsi_irq_data_clear(dsi, irq_flag);
>         mtk_dsi_set_cmd_mode(dsi);
> +       struct drm_device *drm =3D dsi->bridge.dev;
>
>         if (!mtk_dsi_wait_for_irq_done(dsi, irq_flag, t)) {
> -               DRM_ERROR("failed to switch cmd mode\n");
> +               drm_err(drm, "failed to switch cmd mode\n");
>                 return -ETIME;
>         } else {
>                 return 0;
> @@ -849,11 +852,12 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct=
 drm_bridge *bridge,
>                                              struct drm_atomic_state *sta=
te)
>  {
>         struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> +       struct drm_device *drm =3D bridge->dev;
>         int ret;
>
>         ret =3D mtk_dsi_poweron(dsi);
>         if (ret < 0)
> -               DRM_ERROR("failed to power on dsi\n");
> +               drm_err(drm, "failed to power on dsi\n");
>  }
>
>  static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge=
,
> @@ -916,7 +920,7 @@ static int mtk_dsi_encoder_init(struct drm_device *dr=
m, struct mtk_dsi *dsi)
>         ret =3D drm_simple_encoder_init(drm, &dsi->encoder,
>                                       DRM_MODE_ENCODER_DSI);
>         if (ret) {
> -               DRM_ERROR("Failed to encoder init to drm\n");
> +               drm_err(drm, "Failed to encoder init to drm\n");
>                 return ret;
>         }
>
> @@ -932,7 +936,7 @@ static int mtk_dsi_encoder_init(struct drm_device *dr=
m, struct mtk_dsi *dsi)
>
>         dsi->connector =3D drm_bridge_connector_init(drm, &dsi->encoder);
>         if (IS_ERR(dsi->connector)) {
> -               DRM_ERROR("Unable to create bridge connector\n");
> +               drm_err(drm, "Unable to create bridge connector\n");
>                 ret =3D PTR_ERR(dsi->connector);
>                 goto err_cleanup_encoder;
>         }
> @@ -985,6 +989,7 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host *=
host,
>  {
>         struct mtk_dsi *dsi =3D host_to_dsi(host);
>         struct device *dev =3D host->dev;
> +       struct drm_device *drm =3D dsi->bridge.dev;
>         int ret;
>
>         dsi->lanes =3D device->lanes;
> @@ -1012,7 +1017,7 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host=
 *host,
>
>         ret =3D component_add(host->dev, &mtk_dsi_component_ops);
>         if (ret) {
> -               DRM_ERROR("failed to add dsi_host component: %d\n", ret);
> +               drm_err(drm, "failed to add dsi_host component: %d\n", re=
t);
>                 drm_bridge_remove(&dsi->bridge);
>                 return ret;
>         }
> @@ -1034,11 +1039,12 @@ static void mtk_dsi_wait_for_idle(struct mtk_dsi =
*dsi)
>  {
>         int ret;
>         u32 val;
> +       struct drm_device *drm =3D dsi->bridge.dev;
>
>         ret =3D readl_poll_timeout(dsi->regs + DSI_INTSTA, val, !(val & D=
SI_BUSY),
>                                  4, 2000000);
>         if (ret) {
> -               DRM_WARN("polling dsi wait not busy timeout!\n");
> +               drm_warn(drm, "polling dsi wait not busy timeout!\n");
>
>                 mtk_dsi_enable(dsi);
>                 mtk_dsi_reset_engine(dsi);
> @@ -1123,6 +1129,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_ds=
i_host *host,
>                                      const struct mipi_dsi_msg *msg)
>  {
>         struct mtk_dsi *dsi =3D host_to_dsi(host);
> +       struct drm_device *drm =3D dsi->bridge.dev;
>         ssize_t recv_cnt;
>         u8 read_data[16];
>         void *src_addr;
> @@ -1153,7 +1160,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_ds=
i_host *host,
>         }
>
>         if (!msg->rx_buf) {
> -               DRM_ERROR("dsi receive buffer size may be NULL\n");
> +               drm_err(drm, "dsi receive buffer size may be NULL\n");
>                 ret =3D -EINVAL;
>                 goto restore_dsi_mode;
>         }
> @@ -1177,7 +1184,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_ds=
i_host *host,
>         if (recv_cnt)
>                 memcpy(msg->rx_buf, src_addr, recv_cnt);
>
> -       DRM_INFO("dsi get %zd byte data from the panel address(0x%x)\n",
> +       drm_info(drm, "dsi get %zd byte data from the panel address(0x%x)=
\n",
>                  recv_cnt, *((u8 *)(msg->tx_buf)));
>
>  restore_dsi_mode:
> --
> 2.43.0
>
