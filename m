Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ABFC44513
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC12010F20C;
	Thu, 16 Jul 2026 08:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n03Qz/UV";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665F510E048
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 10:08:21 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47de008b020so422422f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784023700; cv=none;
 d=google.com; s=arc-20260327;
 b=i3LtjVFZx24Q6FLBQOEGqE1ffMIn7mg5DhM81cccK6bS9FyDWdMYewaMf96HhAPBIL
 r4zFH8TEUdLiyn5u9lzN0t3ChIiarPJphINaPHfeDRiPh+N1ciQkdt/3RTBdexnEsbEo
 A1h+ih0x4TUF1DFSifBtAuKSaz687dOAxnkDJeyX+DVp/D0VsvtQK8eHu1NGNOmnT8uQ
 2PxwKnfxjw/9JQffEBQydunOr+rRFx3P733SHUvcd2cX/+bonjtpxgVVI4qHVdEpjuHM
 nJow14nX2XsoRikDIWdRbfqdfVbI+u4v42rRQPESFp0m4ytc58i9yk0WXRcZnZW4EDoT
 d55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pTO1GTNNIzboVVARkWkXIYBvdoHk3Wd8NYyVcWCiVLI=;
 fh=BpPVnxvQC5lHIElFDm4WJpuWLIfTgNzmRJm/Zqyjat4=;
 b=h7g5yqwed60gslQf10YLLfKdluyvWt/O4G1FmtAUS06xS9sqBDGm1Gkl2W5f9DkKdz
 ejMYF1t8Zw1XKqoIM0P8vWfT1VWkK+3XWhgpc2BE9JCsZkRGKNe/fgAQTuYFzdjwup6R
 8bH2bZQbwdOiXl467Uw5R6ilOWsyDdObWGGGTTgyvhW8wk+xD38iWmWm3J9zLGV1mTN2
 8pBKWvEqHio/nAfpXwmRy8qRKWWnYikTYJgi5Y57nTu90tDneN5s1YDHdS+3uGULvIg1
 nY6/jmT7gaG23LiQiXBvpGv2PB5vXKIe+fAEQG4jELCotJ1CAOWKBhAzfnQBFzV/Q7Ik
 wcww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784023700; x=1784628500; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pTO1GTNNIzboVVARkWkXIYBvdoHk3Wd8NYyVcWCiVLI=;
 b=n03Qz/UVKy0ZGy387eVwJuMnnNqS4xscYmnv5iugKDuYeSEGODcQj0lAbzIUc5eAnC
 Fy2vpJ4M3MRThTg7XXNk531jkgaYjsodTeT/nRGB5NA7J1FESKKkRPI1YOcWaEtZY9za
 z/NTpfd4keJGqvuVaZrF+aNH6EFOX/U4BPJQjo5sbXV4rHa52lEHdrQNOKA0YqFm/jSe
 TPWYl5zs0Wh3DCFPxc2HEg6Ay8tUnjM/nEyNQ1sh7w5HY0rvh4dJUIzCl9yhpjeKw08g
 2aHlUP7ynTDr9FZtvhWgeLL8qWrM3bxTmbalPGShs0wGHkxgBaTIQ3Lu0ii+RBATC9f1
 X36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023700; x=1784628500;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pTO1GTNNIzboVVARkWkXIYBvdoHk3Wd8NYyVcWCiVLI=;
 b=ZmKTE5Na7CVDysKI/YnxEks/Bwp2ig4tLORbon9gL+Db6pSrUO8FTfMr5gUdOjNQ1v
 QKeJh8WwrnhmUxd9N4pXCq8cC7+EVCpdJwdgJxUaEAZIW/3C1t6fHW4M+sRmamWU++1l
 kqhno2xtLo1VlhM+N0G9neqnE2LQVR0Ex4bF65NXp2IOf+xShLKqCge38mOHtAWHvJUH
 xsQkrsmn7wBtGDhS8onJFnE2xVbCTQ23swkuk0tBdkslmfyfG5AQnVSGxPslBL1STepZ
 PK6rwU99tbA+Ki6Gh+z7Lp+rd1R8wV3jrSOl9u2u9SP/fbF59uOzawpHz7rvurL6YgIv
 jmOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdMO8/jKocPeCkpraKq1/ETIi++DhqNgUJLh86JQJfgr8w4DpB1swTe+HCm2SjCsN6v7A1EcDtDUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxD7wNAEhnS17iiMaTHNUsmWJMYbHszMPnKpditBiQ6Ez02i9pq
 CieIJld8hP1eXQ3KSUQYYU9xmx4WtGC8URyNfbt44ZsdV2Dr8Z8L/ct+D10hoxHJHVvOxdpsPLu
 IcAWSsnGU3n/2LqZRSafWIICqwEYe26E=
X-Gm-Gg: AfdE7cnZlt2BHyNT2KaSrmi3Pb9UFx+szElxVeUxs7m32aBXHNIGwD8VQv6lqrcUF7j
 jJXnfl7KqJ3MDn5ko6zCK6YVGD4qi9STP04weDeeWGBqqOzJJ/MXonQa8sG7LRxSWRJs+kzxPS+
 jR4CeT20G79PDGBVtywl34X6dCa14y3EwJO0gZYxqMqwZ8iwLkkOOVWyzq63uqVO/6kOJkd+oaf
 f38wnJ9uZi8dVKGcrG+NlScG7uenxCyx2hYA0sQnjZrirQnk3kkYPQyW/VBpAn2FzoXYxyt
X-Received: by 2002:a5d:64e4:0:b0:46e:65ac:cfb3 with SMTP id
 ffacd0b85a97d-47f2dc79bc1mr16166592f8f.1.1784023699524; Tue, 14 Jul 2026
 03:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
 <20260612-synopsys-dw-dp-improvements-v3-8-dc61e6352508@collabora.com>
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-8-dc61e6352508@collabora.com>
From: Andy Yan <andyshrk@gmail.com>
Date: Tue, 14 Jul 2026 18:08:06 +0800
X-Gm-Features: AUfX_mxgniT99k8JDvnjfP-4oHZz3X_4f2yQpndYat9AXCkqI2Gd8j1jsaon-W4
Message-ID: <CANbgqATR-V0rRGfzj0hdJ2hsJex-iWzHMwD1L4vavTi2Jd79Kw@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] drm/rockchip: dw_dp: Add runtime PM support
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
Content-Type: multipart/alternative; boundary="000000000000e190cd06568f62c5"
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

--000000000000e190cd06568f62c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,


Sebastian Reichel <sebastian.reichel@collabora.com> =E4=BA=8E2026=E5=B9=B46=
=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:01=E5=86=99=E9=81=93=EF=BC=9A

> Add support for runtime PM to the Rockchip RK3576/3588 Synopsys
> DesignWare DisplayPort driver.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 40
> +++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> index 9c53f1d2c29a..1f53228e56d9 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> @@ -12,6 +12,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/videodev2.h>
>
> @@ -58,6 +59,8 @@ static void dw_dp_rockchip_hpd_sw_sel(void *data, bool
> force_hpd_from_sw)
>
>         dp->hpd_sel =3D force_hpd_from_sw;
>
> +       ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
>


      This can triger  HPD irq for USB-C DP AltMode, but for a standard DP
port, this is no way to acquire runtime,

     so there will no irq when plug in .


> +
>         regmap_write(dp->vo_grf, hpd_reg,
>                      FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL,
> dp->hpd_sel));
>  }
> @@ -71,6 +74,8 @@ static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool
> hpd)
>
>         dp->hpd_cfg =3D hpd;
>
> +       ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> +
>         regmap_write(dp->vo_grf, hpd_reg,
>                      FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG,
> dp->hpd_cfg));
>  }
> @@ -213,6 +218,12 @@ static int dw_dp_rockchip_bind(struct device *dev,
> struct device *master, void *
>         if (IS_ERR(dp->base))
>                 return PTR_ERR(dp->base);
>
> +       pm_runtime_use_autosuspend(dev);
> +       pm_runtime_set_autosuspend_delay(dev, 500);
> +       ret =3D devm_pm_runtime_enable(dev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to enable runtime
> PM\n");
> +
>         connector =3D drm_bridge_connector_init(drm_dev, encoder);
>         if (IS_ERR(connector)) {
>                 dw_dp_unbind(dp->base);
> @@ -246,6 +257,34 @@ static void dw_dp_remove(struct platform_device *pde=
v)
>         component_del(&pdev->dev, &dw_dp_rockchip_component_ops);
>  }
>
> +static int dw_dp_rockchip_runtime_suspend(struct device *dev)
> +{
> +       struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> +
> +       return dw_dp_runtime_suspend(dp->base);
> +}
> +
> +static int dw_dp_rockchip_runtime_resume(struct device *dev)
> +{
> +       struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> +       u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +       int ret;
> +
> +       ret =3D dw_dp_runtime_resume(dp->base);
> +       if (ret)
> +               return ret;
> +
> +       regmap_write(dp->vo_grf, hpd_reg,
> +                    FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL,
> dp->hpd_sel) |
> +                    FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG,
> dp->hpd_cfg));
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops dw_dp_pm_ops =3D {
> +       RUNTIME_PM_OPS(dw_dp_rockchip_runtime_suspend,
> dw_dp_rockchip_runtime_resume, NULL)
> +};
> +
>  static const struct rockchip_dw_dp_plat_data rk3588_dp_plat_data =3D {
>         .num_ctrls =3D 2,
>         .ctrl_ids =3D {0xfde50000, 0xfde60000},
> @@ -280,5 +319,6 @@ struct platform_driver dw_dp_driver =3D {
>         .driver =3D {
>                 .name =3D "dw-dp",
>                 .of_match_table =3D dw_dp_of_match,
> +               .pm =3D pm_ptr(&dw_dp_pm_ops),
>         },
>  };
>
> --
> 2.53.0
>
>
>

--000000000000e190cd06568f62c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Sebastian,</div><div><br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">Sebastian Reichel &lt;<a href=3D"mailto:sebastian.reichel@collabora.com">=
sebastian.reichel@collabora.com</a>&gt; =E4=BA=8E2026=E5=B9=B46=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=85=AD 02:01=E5=86=99=E9=81=93=EF=BC=9A<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Add support for runtime PM to =
the Rockchip RK3576/3588 Synopsys<br>
DesignWare DisplayPort driver.<br>
<br>
Signed-off-by: Sebastian Reichel &lt;<a href=3D"mailto:sebastian.reichel@co=
llabora.com" target=3D"_blank">sebastian.reichel@collabora.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 40 ++++++++++++++++++++++=
+++++++++<br>
=C2=A01 file changed, 40 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/ro=
ckchip/dw_dp-rockchip.c<br>
index 9c53f1d2c29a..1f53228e56d9 100644<br>
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c<br>
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c<br>
@@ -12,6 +12,7 @@<br>
=C2=A0#include &lt;linux/mfd/syscon.h&gt;<br>
=C2=A0#include &lt;linux/of_device.h&gt;<br>
=C2=A0#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
=C2=A0#include &lt;linux/regmap.h&gt;<br>
=C2=A0#include &lt;linux/videodev2.h&gt;<br>
<br>
@@ -58,6 +59,8 @@ static void dw_dp_rockchip_hpd_sw_sel(void *data, bool fo=
rce_hpd_from_sw)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dp-&gt;hpd_sel =3D force_hpd_from_sw;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ACQUIRE(pm_runtime_active_auto, pm)(dp-&gt;dev)=
;<br></blockquote><div><br></div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 T=
his can triger=C2=A0 HPD irq for=C2=A0<span style=3D"color:rgb(0,0,51);font=
-size:13px;white-space:pre-wrap;background-color:transparent">USB-C DP AltM=
ode, but for a  standard DP port,  this is no way to acquire runtime,</span=
></div><div><span style=3D"background-color:transparent"><br></span></div><=
div><span style=3D"background-color:transparent">=C2=A0 =C2=A0 =C2=A0so the=
re will no irq when plug in .</span></div><div><span style=3D"background-co=
lor:transparent">=C2=A0</span></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 regmap_write(dp-&gt;vo_grf, hpd_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp-&gt;hpd_sel));<br>
=C2=A0}<br>
@@ -71,6 +74,8 @@ static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hp=
d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dp-&gt;hpd_cfg =3D hpd;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ACQUIRE(pm_runtime_active_auto, pm)(dp-&gt;dev)=
;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 regmap_write(dp-&gt;vo_grf, hpd_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp-&gt;hpd_cfg));<br>
=C2=A0}<br>
@@ -213,6 +218,12 @@ static int dw_dp_rockchip_bind(struct device *dev, str=
uct device *master, void *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(dp-&gt;base))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(dp-&=
gt;base);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_use_autosuspend(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_set_autosuspend_delay(dev, 500);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D devm_pm_runtime_enable(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_err_prob=
e(dev, ret, &quot;failed to enable runtime PM\n&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 connector =3D drm_bridge_connector_init(drm_dev=
, encoder);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(connector)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dw_dp_unbind(dp-&gt=
;base);<br>
@@ -246,6 +257,34 @@ static void dw_dp_remove(struct platform_device *pdev)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 component_del(&amp;pdev-&gt;dev, &amp;dw_dp_roc=
kchip_component_ops);<br>
=C2=A0}<br>
<br>
+static int dw_dp_rockchip_runtime_suspend(struct device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rockchip_dw_dp *dp =3D dev_get_drvdata(d=
ev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return dw_dp_runtime_suspend(dp-&gt;base);<br>
+}<br>
+<br>
+static int dw_dp_rockchip_runtime_resume(struct device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rockchip_dw_dp *dp =3D dev_get_drvdata(d=
ev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 hpd_reg =3D dp-&gt;pdata-&gt;hpd_reg[dp-&gt=
;id];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dw_dp_runtime_resume(dp-&gt;base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regmap_write(dp-&gt;vo_grf, hpd_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FIEL=
D_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp-&gt;hpd_sel) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FIEL=
D_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp-&gt;hpd_cfg));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static const struct dev_pm_ops dw_dp_pm_ops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RUNTIME_PM_OPS(dw_dp_rockchip_runtime_suspend, =
dw_dp_rockchip_runtime_resume, NULL)<br>
+};<br>
+<br>
=C2=A0static const struct rockchip_dw_dp_plat_data rk3588_dp_plat_data =3D =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_ctrls =3D 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ctrl_ids =3D {0xfde50000, 0xfde60000},<br>
@@ -280,5 +319,6 @@ struct platform_driver dw_dp_driver =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .driver =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;dw-=
dp&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D=
 dw_dp_of_match,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pm =3D pm_ptr(&amp=
;dw_dp_pm_ops),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0};<br>
<br>
-- <br>
2.53.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000e190cd06568f62c5--
