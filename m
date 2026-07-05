Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6731CC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F2310E7E0;
	Mon,  6 Jul 2026 07:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KLP7E0If";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B1B10E198
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 11:31:42 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47db714766aso91077f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 04:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783251101; cv=none;
 d=google.com; s=arc-20260327;
 b=Uy8390ybcBcHwO/dierDmI0rNBv5jkQ76lrHqPt//waONBZEYO/JhneU9b/kHYm4+t
 kr1nS/5NRY31jxxgYaqCDz0OJflTu+C4vYX+5ZoQ0JG6RadEM6bFsYPMne4+Rsu8Y86b
 WFmyO8exBeLpCB+wje4kGwVirjFzU5bG9g+t2L1Cj8hWpT+vc64ylwVT4CBAa6Qn9B+g
 ZVAnfK8dgChI2gujvP8Ir2OHEk+W6+YsXVRmyXZmAeWvh8NHggiIbttsjUCgANw8Ufrq
 I5JbAxLIN/0TqFrBR+GK/+IDJGdTzIbDKZTyAFThDqGHMtvmHK5cC1kJuitP8lEvX36m
 Iwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nA7Ob+odwL2G7BPv/HcXKdYKF4ZyW5MS598iUpp+TdU=;
 fh=h3V1y2t6l+xo3BjMeet+0TNB2HmqSjaBopOh8KzhEkA=;
 b=CvXB8YqkVvK4X6ZZjU9YrV90HTEomZn0xEo0kpPuiExjbJu6sAd57K0fhKLSoKLUPs
 lJVYgdnjTgjWAB5ZpBeLtuWKlt/s91vqDEQvG/LFzVfb4HkEnvLZfHg068YgV+jA3VCw
 mphLBtfnJ053h4CqaAvyDM2sN+Yb/fFlduj34cWHZDoerL9KhtJ1hX9k9eav/YeFFlKU
 zuQPPgFO6OGwYdKZkRL9wYn6nxSYzO0y0PaTzJhLmbDEwHIOAUnRSjptbthX2vpF5k7n
 pSCFpB3a7SIygPDtD16Yyyn+fELRM3EU9kmJxBpAFIkFDJhXotoRBP3szP0Qws5Fj8+K
 cJtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783251101; x=1783855901; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nA7Ob+odwL2G7BPv/HcXKdYKF4ZyW5MS598iUpp+TdU=;
 b=KLP7E0IfFPYJXNp+7XNdwxDQ/4H1PmScv3JXeHT0Su5vjztE9uiXm7H5FZT0o8kPpn
 18JAv8S4jNXdwO6dwwwuJejYAoneTOyPE1gqfMlP5T8kBgMr5C3et2g0Z5bv8NlA3q6C
 wmblBah5+0Jj9/fOW2k4/fKPuYc1bCfDoS65vrTgyOd65LPywXBqrdmUK7uC7X2nUPw4
 i6Y8p90hVRoxM+ckJjiHJBk3b90Ylg1ObSEXIBAzwf7SB7q0vaOYshXeZ1O8gBKB+y78
 mnPAf0cNT389u5j14z8HCmfTbIz6wNQNUImgQg8cA2ZHYAGy4w+6Msfft9QBF/MzmkHf
 jvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783251101; x=1783855901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nA7Ob+odwL2G7BPv/HcXKdYKF4ZyW5MS598iUpp+TdU=;
 b=YkO05Qqtp/AW2HRrsh47lPf0A9lC0nDvPeW0FxcxHl4agerVL+zLftlYf+8zkAjtTy
 NM8nYm/NJ2ksikXRcpqa0YhdKBJ2Org9SCZUAhCKjZqR/MJcCBoIm3gMZowscQLRf2KF
 Af6e/qCag05DApHDWj1yaCWdTQ3vSZjHkrCLIanr59Ci8kCGkSugkHDok4AmFMRgxhWi
 YKqqlinNmobleLsHHhrMEIJFfDMTnrVTmXxXePyWOv7nQd0QBMhpiLkTDQjxM/R65b1X
 NjR/hLdEbKcQZU8pfryJhjSuSp2EeAdEUywlZB3jNyW3pfdf5ixWB/M9HWfOah1K9rbk
 xqCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RovOpJJQX5xi7V8NIwMR4cVdR5xNazMhiZIYt3xL+wERP/CGASA9zMFOnYVKM6/wb0B/NuqBBitTfk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDWc5f5JzJPcBa3a7pdStmy68ll1p0SR/FQ8NKK4UmZx/Bfym/
 QSmA+Een2La/oA7blxI9rH/q9WOsPX9M/u3ZRP0c84oK8ue0oDJVkfwlLTYZOFvCLQ1yZHqY2jx
 ymserebTqwX4nM3MGieeZA8AWf7zZgFU=
X-Gm-Gg: AfdE7clu8tcm89TQvlGiuN5id4RB/H0ZRvXmRgwqqa34kvCzIaA4+dzB5K/MM86SASy
 f4DDimVsZpIeAT556v12nUwYFTUXA9khrHASN7cR8kfR5kFCe0WjMhJmcfXuKpKI0v8AukPv3e7
 s+6VbOUfltuY4ZU2gxELa7rgP/9CeuOEfgq5/7f/lOf8fE+TnlDWVIiU1aQlRqg8jYLuHVxJo8H
 PwBVf65qGwi0sd3NA/5zJoI7k/KsTedoAnAZKhoPjI8V91YGTprjHogokL71Kg5F7VBmL0k
X-Received: by 2002:a05:6000:25fe:b0:474:8dbb:ccd0 with SMTP id
 ffacd0b85a97d-4793685fed0mr13556662f8f.19.1783251100630; Sun, 05 Jul 2026
 04:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
 <20260612-synopsys-dw-dp-improvements-v3-1-dc61e6352508@collabora.com>
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-1-dc61e6352508@collabora.com>
From: Andy Yan <andyshrk@gmail.com>
Date: Sun, 5 Jul 2026 19:31:27 +0800
X-Gm-Features: AVVi8CcFMXgycZM9Ewe4bW5gvgUhwyoVSUwrl4zMKIQxueC9JU8itNG4OsOlAL0
Message-ID: <CANbgqARCcycittXB6CmKmU90Gae20OPjOoA+Ns4e45CbPst_hw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] drm/bridge: synopsys: dw-dp: Simplify driver
 data setting
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
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary="00000000000066007b0655db80c1"
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:13:14 +0000
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

--00000000000066007b0655db80c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sebastian=EF=BC=8C

Sebastian Reichel <sebastian.reichel@collabora.com> =E4=BA=8E2026=E5=B9=B46=
=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:01=E5=86=99=E9=81=93=EF=BC=9A

> There is no need to get the platform device just for setting up
> the driver data. Simplify the logic.
>
> Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> index 0de822360c8d..35598ab9fe84 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> @@ -74,7 +74,6 @@ static const struct drm_encoder_helper_funcs
> dw_dp_encoder_helper_funcs =3D {
>
>  static int dw_dp_rockchip_bind(struct device *dev, struct device *master=
,
> void *data)
>  {
> -       struct platform_device *pdev =3D to_platform_device(dev);
>

           In patch 06/10, this is added back again. So is this change
really necessary?



>         const struct dw_dp_plat_data *plat_data;
>         struct drm_device *drm_dev =3D data;
>         struct rockchip_dw_dp *dp;
> @@ -87,7 +86,7 @@ static int dw_dp_rockchip_bind(struct device *dev,
> struct device *master, void *
>                 return -ENOMEM;
>
>         dp->dev =3D dev;
> -       platform_set_drvdata(pdev, dp);
> +       dev_set_drvdata(dev, dp);
>
>         plat_data =3D of_device_get_match_data(dev);
>         if (!plat_data)
>
> --
> 2.53.0
>
>
>

--00000000000066007b0655db80c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Sebastian=EF=BC=8C</div><div dir=3D=
"ltr"><br></div><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">Sebastian Reichel &lt;<a href=3D"mailto:sebas=
tian.reichel@collabora.com">sebastian.reichel@collabora.com</a>&gt; =E4=BA=
=8E2026=E5=B9=B46=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:01=E5=86=99=E9=
=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
There is no need to get the platform device just for setting up<br>
the driver data. Simplify the logic.<br>
<br>
Reviewed-by: Andy Yan &lt;<a href=3D"mailto:andy.yan@rock-chips.com" target=
=3D"_blank">andy.yan@rock-chips.com</a>&gt;<br>
Signed-off-by: Sebastian Reichel &lt;<a href=3D"mailto:sebastian.reichel@co=
llabora.com" target=3D"_blank">sebastian.reichel@collabora.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/ro=
ckchip/dw_dp-rockchip.c<br>
index 0de822360c8d..35598ab9fe84 100644<br>
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c<br>
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c<br>
@@ -74,7 +74,6 @@ static const struct drm_encoder_helper_funcs dw_dp_encode=
r_helper_funcs =3D {<br>
<br>
=C2=A0static int dw_dp_rockchip_bind(struct device *dev, struct device *mas=
ter, void *data)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct platform_device *pdev =3D to_platform_de=
vice(dev);<br></blockquote><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0In patch 06/10, this is added back again. So is this change re=
ally necessary?</div><div><br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct dw_dp_plat_data *plat_data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_device *drm_dev =3D data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rockchip_dw_dp *dp;<br>
@@ -87,7 +86,7 @@ static int dw_dp_rockchip_bind(struct device *dev, struct=
 device *master, void *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dp-&gt;dev =3D dev;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, dp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_set_drvdata(dev, dp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 plat_data =3D of_device_get_match_data(dev);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!plat_data)<br>
<br>
-- <br>
2.53.0<br>
<br>
<br>
</blockquote></div></div>

--00000000000066007b0655db80c1--
