Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A66CC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D6189233;
	Thu, 16 Jul 2026 08:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nju9Z12y";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4238110E040
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 09:01:30 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so15493205e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 02:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784019688; cv=none;
 d=google.com; s=arc-20260327;
 b=AmwNuxxkK8BgtVhv3xcxIUoaNTyyKWKbqUcrMoPt6MiUzCQJ4otNdtaVVYGv7iXfEc
 zm/zay+rwV1S4Uo/tnpu5UIKgZDMqRfbyCwVTGv8ghOUvImJUjKJbxohiNwz3pe8XHuY
 Rc/AZl6+GywsOYZQSHV+cVqQ0Vfmrcwe8Bw++rBRZxHzgHfu62RYL8aT0wNx2rjIPSc6
 Rk3AsRqlod4pZ/OUPbMEJ+rcvA81Gu4orvO3zLXPJ+r7wstU+LhkHCsjN6r6orNzWwPt
 2WxeE+8VbywWuCiwUKvdgR9fVUAK5lbQUYw4NrPgHI9WqYagXg1JskoAfaYreuz7CN1d
 zyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wlxD7X0oBy63Am7yOmAlmA0woEQNS/GD/GFnx7oC5bw=;
 fh=y4E3ZO4fHEmMP0kS9AHjSyJdsIpUtZpPUqMP7gcQWYo=;
 b=TDI/kS80PStFc2QxpzX+nGD+TE/DU2y209QP50p4MDflfoOJ2r8aCCUWw75zJrWo2D
 1MBh4hqv3AZLomClJfnJguWg59crK/hKpNovc4oJ5gRyqDrJ/YsTXMTFrwQK7amO2q3q
 XM7aIhjTmodkAkxzqDOL4vw1hdhgy8fkPFnkaYmFmNdSI0LNLG74HpWvufM3Zb5AwX61
 LoJfZ06DH17hntdgg+jl9FORscxnIh5wuZGJi6Gpta9P5jn1W1kDNjlI4BGaRwGng1ms
 CtrpgzzQwmbsGeyZc39wJ77rOhER1szTOWMHU2o0FmT5UJbuIk9n6EvO3/+lPNJx6Tnm
 /Y0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784019688; x=1784624488; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wlxD7X0oBy63Am7yOmAlmA0woEQNS/GD/GFnx7oC5bw=;
 b=Nju9Z12y8KIyQKXM1POgSm0lEanlIOuy8qkCrwDqEHNE6uX5crGUFQQ6PN1YpOOVl1
 fwZIerhI7km1WANxbknT1yIfPiT/EuEgUyiokHNIAhL5ebGY38DjJskCaFFsfQS0zp2s
 QAy0X8YKF1kxxaomZPslaqXKIRko5WVJqrEsWtC38ij1aZ8icsXLs2nZCBtnLo6lufsN
 oB2URswr7lk9pUIPIqP+zPCA8podjEZccizGVdmK0wlETpp8t+O4Wzqx8vLJEykWG8w9
 LRIiws+Sp4tGg8Kr//RDHYQ4se5YjpJ8eDb99l7BXVtCtCL/L/HJJslUTa2GsC6mPXvf
 aIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784019688; x=1784624488;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wlxD7X0oBy63Am7yOmAlmA0woEQNS/GD/GFnx7oC5bw=;
 b=fknC52APPStrLkpdoycffzhB3mdUX+Bx+A+VAu0WsCHy2brUXPTGCEYC705sxBVmJ5
 CTewmzb5sQ10XHict6HRXjNmIdDV0Ph4ra+bQuqCYMlNxWN2v5MZslcwXuQhEOgsz/Gq
 hqr5nswDQeEc4i6XlUUcmO7hTYqfuKw+v42KEy0JG+z6vqVUNitjfo8KjePAaAN0agm0
 T0sLv2Tcu6Czw3/yvm35QzKlJ+fGdZcXzbokRqOnb87L5j4hpSvHijdWu/k3oUNFF97e
 tFhIQsfPagMsGc5/ECJMb696b7gqXL0jmfBaQoZSW4oslT6AoSn/VCPTHEa3/fmbRwzu
 deZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLhE4j+zR6VCxBF0phYvNGId44Cy6+ahSvV7kfoD+xjECmyYfgl+PNV2CXHXP5Q284vJaz9oalGiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwTIgCoIZ2eXCrG1Z6l1s54elluvwB/pfHrQrtHTldziis0ayZ
 ei7t/QI8WNlxQ00Xlmn9CMAy25Sv39ntv7O88+Piqmme0WZSmciDX7/9tB8/Pxa8FdqpDLbnROf
 /DeSDGsNpD31R3IOaB8Qg27fMNto7QBg=
X-Gm-Gg: AfdE7ckvOk/i5ojiekP8yg23QpsxcGjek1TQD9r4VBNLkmghqFVeBRJEMokVpAaAXuB
 gmRjCA+FbGaxyCgHbKCjnT1RHeDOIYRXYB6ojhr2YK9miQvm+jfV8rXoC0WkfGey6TH2nIZU0Wa
 yLr9GpZpP1mxNV3D7jj64FrHRpwWQ8suYiswekvSElfh/N5MDPpEgdtjPC1p5d7ZVTIUtShlJoA
 SRGLnsQt9Ei/rPoS/o8RyOd5WK/9npkQ2er9DNpXFrQfG91jCQMWpjIG4RoM7LQrkFm9b+jE6C1
 P3tCJ9g=
X-Received: by 2002:a05:600c:608e:b0:493:b03c:5650 with SMTP id
 5b1f17b1804b1-493f8820806mr118572335e9.19.1784019687887; Tue, 14 Jul 2026
 02:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
 <20260612-synopsys-dw-dp-improvements-v3-7-dc61e6352508@collabora.com>
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-7-dc61e6352508@collabora.com>
From: Andy Yan <andyshrk@gmail.com>
Date: Tue, 14 Jul 2026 17:01:14 +0800
X-Gm-Features: AUfX_mwCU9A4oqlLiPw4Entf0FrW6lz46066optemxKsAiNEhc6XD5ZkZ2Pwwec
Message-ID: <CANbgqAQLROuf9wvZZWRufZg6iqubKnC4fW5Bh+DkQ7RP1x5KKQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, yubing.zhang@rock-chips.com
Content-Type: multipart/alternative; boundary="000000000000c4f60906568e7355"
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:21 +0000
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

--000000000000c4f60906568e7355
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

Sebastian Reichel <sebastian.reichel@collabora.com> =E4=BA=8E2026=E5=B9=B46=
=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:01=E5=86=99=E9=81=93=EF=BC=9A

> Add runtime PM stubs to the Synopsys DesignWare DisplayPort bridge
> driver. Support is not enabled automatically and must be hooked up
> in the vendor specific glue code.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c | 27 +++++++++++++++++++++++++++
>  include/drm/bridge/dw_dp.h              |  3 +++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> index 7fa38145e35c..7f4f36c61484 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux
> *aux,
>         if (WARN_ON(msg->size > 16))
>                 return -E2BIG;
>
> +       ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> +
>         switch (msg->request & ~DP_AUX_I2C_MOT) {
>         case DP_AUX_NATIVE_WRITE:
>         case DP_AUX_I2C_WRITE:
> @@ -1655,6 +1657,8 @@ static void dw_dp_bridge_atomic_enable(struct
> drm_bridge *bridge,
>         struct drm_connector_state *conn_state;
>         int ret;
>
> +       pm_runtime_get_sync(dp->dev);
> +
>         connector =3D drm_atomic_get_new_connector_for_encoder(state,
> bridge->encoder);
>         if (!connector) {
>                 dev_err(dp->dev, "failed to get connector\n");
> @@ -1709,6 +1713,7 @@ static void dw_dp_bridge_atomic_disable(struct
> drm_bridge *bridge,
>         dw_dp_link_disable(dp);
>         bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
>         dw_dp_reset(dp);
> +       pm_runtime_put_autosuspend(dp->dev);
>  }
>
>  static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connector
> *connector)
> @@ -1729,6 +1734,8 @@ static enum drm_connector_status
> dw_dp_bridge_detect(struct drm_bridge *bridge,
>  {
>         struct dw_dp *dp =3D bridge_to_dp(bridge);
>
> +       ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
>

       This may not work correctly. Per the DW-DP TRM, the " HPD_HOT_PLUG b=
it
is asserted only after the sink is attached
and holds HPD high for at least 100ms".
Consequently, reading this bit within 100ms after resuming runtime_pm may
fail to detect the status.
I've verified this behavior on a Rock 5B board=E2=80=94the HPD bit remains
unreadable at this point.:

+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1761,12 +1761,17 @@ static enum drm_connector_status
dw_dp_bridge_detect(struct drm_bridge *bridge,

        ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);

-       if (!dw_dp_hpd_detect(dp))
+       if (!dw_dp_hpd_detect(dp)) {
+               printk(KERN_DEBUG "%s no hpd\n", __func__);
                return connector_status_disconnected;
+       }

-       if (!dw_dp_hpd_detect_link(dp, connector))
+       if (!dw_dp_hpd_detect_link(dp, connector)) {
+               printk(KERN_DEBUG "%s no link\n", __func__);
                return connector_status_disconnected;
+       }

+       printk(KERN_DEBUG "%s connected\n", __func__);
        return connector_status_connected;
 }

@@ -2149,6 +2154,7 @@ static irqreturn_t dw_dp_irq(int irq, void *data)
        u32 value;

        regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);
+       printk(KERN_DEBUG "%s value: %d\n", __func__, value);
        if (!value)
                return IRQ_NONE;

bootup
[    5.218035] panthor fb000000.gpu: [drm] Using Transparent Hugepage
[    5.219073] [drm] Initialized panthor 1.9.0 for fb000000.gpu on minor 1
[    7.953973] r8169 0004:41:00.0 enP4p65s0: Link is Up - 1Gbps/Full - flow
control off
[    8.601273] dw_dp_rockchip_runtime_resume ret: 0
[    8.702748] dw_dp_irq value: 1        // (HPD irq 100 100ms  after
runtime_resume)
[    8.714236] dw_dp_irq value: 2
[    8.714775] dw_dp_irq value: 2
[    8.715201] dw_dp_irq value: 2
[    8.715710] dw_dp_irq value: 2
[    8.715744] dw_dp_bridge_detect connected
[    9.226752] dw_dp_rockchip_runtime_suspend


Then run modetest:

# modetest
trying to open device '/dev/dri/card1'... is not a KMS device
trying to open device '/dev/dri/card0'... done
opened device `RockChip Soc DRM` on driver `rockchip` (version 1.0.0 at 0)
Encoders:
id      crtc    type    possible crtcs  possible clones
86      0       TMDS    0x00000004      0x00000001
88      0       TMDS    0x00000001      0x00000002
92      0       TMDS    0x00000002      0x00000004

Connectors:
id      encoder status          name            size (mm)       modes
encoders
87      0       disconnected    DP-1            0x0             0       86
  props:
        1 EDID:

[   13.809398] rockchip-pm-domain
fd8d8000.power-management:power-controller: sync_state() pending due to
fdee0000.hdmi_receiver
[   29.225506] dw_dp_rockchip_runtime_resume ret: 0
[   29.225940] dw_dp_bridge_detect no hpd         // no HPD read here
[   29.326986] dw_dp_irq value: 1                         // HPD irq ater
100ms
[   29.346609] dw_dp_irq value: 2
[   29.347150] dw_dp_irq value: 2
[   29.347578] dw_dp_irq value: 2
[   29.348092] dw_dp_irq value: 2


if I add a mdelay(110) after  ACQUIRE pm_runtime,  the hdp can be read.
index 02ca7fe725876..5959e79eb3e2b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1760,7 +1760,7 @@ static enum drm_connector_status
dw_dp_bridge_detect(struct drm_bridge *bridge,
        struct dw_dp *dp =3D bridge_to_dp(bridge);

        ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
-
+       mdelay(110);


[   13.816944] rockchip-pm-domain
fd8d8000.power-management:power-controller: sync_state() pending due to
fdee0000.hdmi_receiver
[   42.735529] dw_dp_rockchip_runtime_resume ret: 0
[   42.837035] dw_dp_irq value: 1
[   42.857458] dw_dp_irq value: 2
[   42.857979] dw_dp_irq value: 2
[   42.858387] dw_dp_irq value: 2
[   42.858880] dw_dp_irq value: 2
[   42.858897] dw_dp_bridge_detect connected


+
>         if (!dw_dp_hpd_detect(dp))
>                 return connector_status_disconnected;
>
> @@ -2153,6 +2160,26 @@ void dw_dp_unbind(struct dw_dp *dp)
>  }
>  EXPORT_SYMBOL_GPL(dw_dp_unbind);
>
> +int dw_dp_runtime_suspend(struct dw_dp *dp)
> +{
> +       clk_disable_unprepare(dp->aux_clk);
> +       clk_disable_unprepare(dp->apb_clk);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);
> +
> +int dw_dp_runtime_resume(struct dw_dp *dp)
> +{
> +       clk_prepare_enable(dp->apb_clk);
> +       clk_prepare_enable(dp->aux_clk);
> +
> +       dw_dp_init_hw(dp);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);
> +
>  MODULE_AUTHOR("Andy Yan <andyshrk@163.com>");
>  MODULE_DESCRIPTION("DW DP Core Library");
>  MODULE_LICENSE("GPL");
> diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
> index 2127afa26b2c..3037e0290861 100644
> --- a/include/drm/bridge/dw_dp.h
> +++ b/include/drm/bridge/dw_dp.h
> @@ -28,4 +28,7 @@ struct dw_dp_plat_data {
>  struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder=
,
>                          const struct dw_dp_plat_data *plat_data);
>  void dw_dp_unbind(struct dw_dp *dp);
> +
> +int dw_dp_runtime_suspend(struct dw_dp *dp);
> +int dw_dp_runtime_resume(struct dw_dp *dp);
>  #endif /* __DW_DP__ */
>
> --
> 2.53.0
>
>
>

--000000000000c4f60906568e7355
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Sebastian,</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Sebastian Reich=
el &lt;<a href=3D"mailto:sebastian.reichel@collabora.com">sebastian.reichel=
@collabora.com</a>&gt; =E4=BA=8E2026=E5=B9=B46=E6=9C=8813=E6=97=A5=E5=91=A8=
=E5=85=AD 02:01=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Add runtime PM stubs to the Synopsys DesignWare =
DisplayPort bridge<br>
driver. Support is not enabled automatically and must be hooked up<br>
in the vendor specific glue code.<br>
<br>
Signed-off-by: Sebastian Reichel &lt;<a href=3D"mailto:sebastian.reichel@co=
llabora.com" target=3D"_blank">sebastian.reichel@collabora.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/bridge/synopsys/dw-dp.c | 27 ++++++++++++++++++++++++=
+++<br>
=C2=A0include/drm/bridge/dw_dp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 3 +++<br>
=C2=A02 files changed, 30 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/brid=
ge/synopsys/dw-dp.c<br>
index 7fa38145e35c..7f4f36c61484 100644<br>
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c<br>
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c<br>
@@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *=
aux,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (WARN_ON(msg-&gt;size &gt; 16))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -E2BIG;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ACQUIRE(pm_runtime_active_auto, pm)(dp-&gt;dev)=
;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (msg-&gt;request &amp; ~DP_AUX_I2C_MOT) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DP_AUX_NATIVE_WRITE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DP_AUX_I2C_WRITE:<br>
@@ -1655,6 +1657,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_bri=
dge *bridge,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_connector_state *conn_state;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_get_sync(dp-&gt;dev);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 connector =3D drm_atomic_get_new_connector_for_=
encoder(state, bridge-&gt;encoder);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!connector) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dp-&gt;dev,=
 &quot;failed to get connector\n&quot;);<br>
@@ -1709,6 +1713,7 @@ static void dw_dp_bridge_atomic_disable(struct drm_br=
idge *bridge,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dw_dp_link_disable(dp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitmap_zero(dp-&gt;sdp_reg_bank, SDP_REG_BANK_S=
IZE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dw_dp_reset(dp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_put_autosuspend(dp-&gt;dev);<br>
=C2=A0}<br>
<br>
=C2=A0static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connec=
tor *connector)<br>
@@ -1729,6 +1734,8 @@ static enum drm_connector_status dw_dp_bridge_detect(=
struct drm_bridge *bridge,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dw_dp *dp =3D bridge_to_dp(bridge);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ACQUIRE(pm_runtime_active_auto, pm)(dp-&gt;dev)=
;<br></blockquote><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0This may n=
ot work correctly. Per the DW-DP TRM, the &quot;=C2=A0<code class=3D"gmail-=
hyc-common-markdown__code__inline">HPD_HOT_PLUG=C2=A0</code>bit is asserted=
 only after the sink is attached</div><div>and holds HPD high for at least =
100ms&quot;<span style=3D"background-color:transparent">.=C2=A0</span></div=
><div><span style=3D"background-color:transparent">Consequently, reading th=
is bit within 100ms after resuming </span><code class=3D"gmail-hyc-common-m=
arkdown__code__inline" style=3D"background-color:transparent">runtime_pm=C2=
=A0</code><span style=3D"background-color:transparent">may fail to detect t=
he status.=C2=A0</span></div><div><span style=3D"background-color:transpare=
nt">I&#39;ve verified this behavior on a Rock 5B board=E2=80=94the HPD bit =
remains unreadable at this point.:</span></div><div><span style=3D"backgrou=
nd-color:transparent"><br></span></div><div>+++ b/drivers/gpu/drm/bridge/sy=
nopsys/dw-dp.c<br>@@ -1761,12 +1761,17 @@ static enum drm_connector_status =
dw_dp_bridge_detect(struct drm_bridge *bridge,<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ACQUIRE(pm_runtime_active_auto, pm)(dp-&gt;dev);<br>=C2=A0<br=
>- =C2=A0 =C2=A0 =C2=A0 if (!dw_dp_hpd_detect(dp))<br>+ =C2=A0 =C2=A0 =C2=
=A0 if (!dw_dp_hpd_detect(dp)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 printk(KERN_DEBUG &quot;%s no hpd\n&quot;, __func__);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return connector_statu=
s_disconnected;<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>- =C2=A0 =C2=A0 =
=C2=A0 if (!dw_dp_hpd_detect_link(dp, connector))<br>+ =C2=A0 =C2=A0 =C2=A0=
 if (!dw_dp_hpd_detect_link(dp, connector)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG &quot;%s no link\n&quot;, __func=
__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return conn=
ector_status_disconnected;<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>+ =C2=
=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG &quot;%s connected\n&quot;, __func__);<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return connector_status_connected;<br>=C2=A0=
}<br>=C2=A0<br>@@ -2149,6 +2154,7 @@ static irqreturn_t dw_dp_irq(int irq, =
void *data)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 value;<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 regmap_read(dp-&gt;regmap, DW_DP_GENERAL_INTERRUPT, &a=
mp;value);<br>+ =C2=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG &quot;%s value: %d\n=
&quot;, __func__, value);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!value)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_NONE;<span =
style=3D"background-color:transparent"></span></div><div><br></div><div>boo=
tup=C2=A0</div><div>[ =C2=A0 =C2=A05.218035] panthor fb000000.gpu: [drm] Us=
ing Transparent Hugepage<br>[ =C2=A0 =C2=A05.219073] [drm] Initialized pant=
hor 1.9.0 for fb000000.gpu on minor 1<br>[ =C2=A0 =C2=A07.953973] r8169 000=
4:41:00.0 enP4p65s0: Link is Up - 1Gbps/Full - flow control off<br>[ =C2=A0=
 =C2=A08.601273] dw_dp_rockchip_runtime_resume ret: 0<br>[ =C2=A0 =C2=A08.7=
02748] dw_dp_irq value: 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 // (HPD irq 100 100ms=
=C2=A0 after runtime_resume)<br>[ =C2=A0 =C2=A08.714236] dw_dp_irq value: 2=
<br>[ =C2=A0 =C2=A08.714775] dw_dp_irq value: 2<br>[ =C2=A0 =C2=A08.715201]=
 dw_dp_irq value: 2<br>[ =C2=A0 =C2=A08.715710] dw_dp_irq value: 2<br>[ =C2=
=A0 =C2=A08.715744] dw_dp_bridge_detect connected<br>[ =C2=A0 =C2=A09.22675=
2] dw_dp_rockchip_runtime_suspend</div><div><br></div><div><br></div><div>T=
hen run modetest:</div><div><br></div><div># modetest <br>trying to open de=
vice &#39;/dev/dri/card1&#39;... is not a KMS device<br>trying to open devi=
ce &#39;/dev/dri/card0&#39;... done<br>opened device `RockChip Soc DRM` on =
driver `rockchip` (version 1.0.0 at 0)<br>Encoders:<br>id =C2=A0 =C2=A0 =C2=
=A0crtc =C2=A0 =C2=A0type =C2=A0 =C2=A0possible crtcs =C2=A0possible clones=
<br>86 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 TMDS =C2=A0 =C2=A00x00000=
004 =C2=A0 =C2=A0 =C2=A00x00000001<br>88 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=
=A0 =C2=A0 TMDS =C2=A0 =C2=A00x00000001 =C2=A0 =C2=A0 =C2=A00x00000002<br>9=
2 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 TMDS =C2=A0 =C2=A00x00000002 =
=C2=A0 =C2=A0 =C2=A00x00000004<br><br>Connectors:<br>id =C2=A0 =C2=A0 =C2=
=A0encoder status =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0size (mm) =C2=A0 =C2=A0 =C2=A0 modes =C2=A0 encoder=
s<br>87 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 disconnected =C2=A0 =C2=
=A0DP-1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 86<br>=C2=A0 props:<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 1 EDID:</div><div><br></div><div>[ =C2=A0 13.809398] r=
ockchip-pm-domain fd8d8000.power-management:power-controller: sync_state() =
pending due to fdee0000.hdmi_receiver<br>[ =C2=A0 29.225506] dw_dp_rockchip=
_runtime_resume ret: 0<br>[ =C2=A0 29.225940] dw_dp_bridge_detect no hpd=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// no HPD read here<br>[ =C2=A0 29.326986] d=
w_dp_irq value: 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// HPD irq ater 100ms<br>[ =C2=A0 29.3466=
09] dw_dp_irq value: 2<br>[ =C2=A0 29.347150] dw_dp_irq value: 2<br>[ =C2=
=A0 29.347578] dw_dp_irq value: 2<br>[ =C2=A0 29.348092] dw_dp_irq value: 2=
</div><div>=C2=A0<span style=3D"background-color:transparent"></span></div>=
<div><br></div><div>if I add a mdelay(110) after=C2=A0 ACQUIRE pm_runtime,=
=C2=A0 the hdp can be read.</div><div>index 02ca7fe725876..5959e79eb3e2b 10=
0644<br>--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c<br>+++ b/drivers/gpu/=
drm/bridge/synopsys/dw-dp.c<br>@@ -1760,7 +1760,7 @@ static enum drm_connec=
tor_status dw_dp_bridge_detect(struct drm_bridge *bridge,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct dw_dp *dp =3D bridge_to_dp(bridge);<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ACQUIRE(pm_runtime_active_auto, pm)(dp-&gt;dev);<b=
r>-<br>+ =C2=A0 =C2=A0 =C2=A0 mdelay(110);</div><div><br></div><div><br></d=
iv><div>[ =C2=A0 13.816944] rockchip-pm-domain fd8d8000.power-management:po=
wer-controller: sync_state() pending due to fdee0000.hdmi_receiver<br>[ =C2=
=A0 42.735529] dw_dp_rockchip_runtime_resume ret: 0<br>[ =C2=A0 42.837035] =
dw_dp_irq value: 1<br>[ =C2=A0 42.857458] dw_dp_irq value: 2<br>[ =C2=A0 42=
.857979] dw_dp_irq value: 2<br>[ =C2=A0 42.858387] dw_dp_irq value: 2<br>[ =
=C2=A0 42.858880] dw_dp_irq value: 2<br>[ =C2=A0 42.858897] dw_dp_bridge_de=
tect connected</div><div><br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dw_dp_hpd_detect(dp))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return connector_st=
atus_disconnected;<br>
<br>
@@ -2153,6 +2160,26 @@ void dw_dp_unbind(struct dw_dp *dp)<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(dw_dp_unbind);<br>
<br>
+int dw_dp_runtime_suspend(struct dw_dp *dp)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(dp-&gt;aux_clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(dp-&gt;apb_clk);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);<br>
+<br>
+int dw_dp_runtime_resume(struct dw_dp *dp)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_prepare_enable(dp-&gt;apb_clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_prepare_enable(dp-&gt;aux_clk);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dw_dp_init_hw(dp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);<br>
+<br>
=C2=A0MODULE_AUTHOR(&quot;Andy Yan &lt;<a href=3D"mailto:andyshrk@163.com" =
target=3D"_blank">andyshrk@163.com</a>&gt;&quot;);<br>
=C2=A0MODULE_DESCRIPTION(&quot;DW DP Core Library&quot;);<br>
=C2=A0MODULE_LICENSE(&quot;GPL&quot;);<br>
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h<br>
index 2127afa26b2c..3037e0290861 100644<br>
--- a/include/drm/bridge/dw_dp.h<br>
+++ b/include/drm/bridge/dw_dp.h<br>
@@ -28,4 +28,7 @@ struct dw_dp_plat_data {<br>
=C2=A0struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *enco=
der,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const struct dw_dp_plat_data *plat_data);<br>
=C2=A0void dw_dp_unbind(struct dw_dp *dp);<br>
+<br>
+int dw_dp_runtime_suspend(struct dw_dp *dp);<br>
+int dw_dp_runtime_resume(struct dw_dp *dp);<br>
=C2=A0#endif /* __DW_DP__ */<br>
<br>
-- <br>
2.53.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000c4f60906568e7355--
