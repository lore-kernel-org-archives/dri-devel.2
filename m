Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAF9FCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6A610E747;
	Wed, 18 Mar 2026 08:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l6zeqrk6";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B2E10E376
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 02:08:55 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so5998985a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773799735; cv=none;
 d=google.com; s=arc-20240605;
 b=PXPUKAeDhjamod2iaJ6btyKVi9LmuWWebMnzHJUztsPWnGM8/Cyt9nVljAg7dTCTi8
 8cYI4xfkM27igRIDMEOzDx/gaiXVIaNqL+YY0f8PHmYeXVujf76QxUHsCVUT4dNAzOgX
 fgUh0WxY/NqVjdOdVkNaGAIJ3JBzILa+DLLvKMzpNoS/y2BRAoCmyotomGFePueWtgON
 EqUtI77mp3kZ+5PyQC9YJFQF6jGo1FlXRa69IUWOv32tYOPA97pXHl4uZ+FuHZcocC6/
 24jXkOUE7AwTMv9c/Zdpr3q3MTGOtLsjLfsPJ+pGgrS6hIX05ygiAZ9fi2hjT2IWWAQJ
 LHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rPd/76BOBogMCywna/7VwaiRXh7n8XtfONYIc1woYgk=;
 fh=1dIcALEqt24i+Sn+KzaYvvEWYXbFpSPjZqZzTZ29MOo=;
 b=UTjncJD5rA4p860svG7nUKhzq/hcTJFzKptxs+UjCEJauy8+jq9jCzZ0Iezg5De3d0
 6zAFKtDlQxo9jqSMSWNRhc00z2sPG7Atnl4R3obB96kE/uu8H4BIUKuqUpWwJUIxA1bL
 /+vdhVvDUC65cpID88/se/Gu5pLJMTr9PjcipLJxDFsdN8/PZE9JA+knYUJDXb6v5lee
 lkeFhejlOt9SozDPMXcW6OrhwFAfe8DVdxYLVsTO1m4zUbYlRj3ALe8PImNHhR1FEdt8
 IbWsRPaPw8TXP3qkJpoMmH46HNhC/4D9mziYSgL/Z6qcwpvtBeLQjtMQszvWCZIERCQj
 CHOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773799735; x=1774404535; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rPd/76BOBogMCywna/7VwaiRXh7n8XtfONYIc1woYgk=;
 b=l6zeqrk6k9+ZchMSiCr1oiFgK8ORXhLMmkQdT6IQPdbVN+UMx1LAkw2j6f2CPuBz+M
 aHHlW0C+uFj/nzSzNTU9QcwfHmOPHgWgSMJSYC+Xph3uWcgRi9mIZfs5xJ8V9mp4CuTz
 UwEI9IXK0MoSC4C2Pcy9mGjx6Ic79arPP81A+csj5OD3LD0sJqJuAvyU/OZNPnhacnPw
 Aii47f2key0jlO7rv050eX1LEqgkEmGUngREm9HLbidgFzQBlW2uNvbn+bgODgk34zpe
 0FVDgCzfFdGHnHrWOWiqTJb0okw//iTh6aetG5HRk8V6JmnXB/Ke2MS0DQVgEcjhlhB4
 XwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773799735; x=1774404535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPd/76BOBogMCywna/7VwaiRXh7n8XtfONYIc1woYgk=;
 b=O/sAV7uJaqphZ2CNe1Q7Ynqzk+j9w4DVhvN7v0K+QuqA2DsgA0BW4bYxcNUKzqKrqF
 ucmvMDlVcw3uHJcItrCwcEhxVymV7nMwPCfiSUAqJNefpa7449Ea/5SueEI4ygP/d5FQ
 KBDpT6EvRMtTqzhlhLlNBU1gDA2U7CpcMwbwtmFRgUlGq9MxrSqZ99kHxy0I9NHwbgzI
 05NV1eWk3vocMDkS6OxEb7vUq/lSYJpEjUQxzFYPG3vY3IAX1v9X03rzpeCppUTEtf+s
 IOglKZU0RvdqZvR5rIafVufH4zC8p1La37/aN6KJGlrHNMXK/zmONFWsYuILuere5Ud5
 9vjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1rMawy+j6nSG/adIk/FEJrQ9Fr3l5Psx9mjxoRzmajCy5Pcw6Ned7Ph8/16ION/UEKuuPwLrI8MY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6X3CKfgL0PxiyP67i1E1WhTpO2u6nOWcrvJqTo7/CjkpIzyfn
 m23A8OEyxpa/1cyfCLdv8k34/vBqVQQVAxpaVC00HytKJWLwccHGVGrZVRb+GJjm6lRc0ct1SVt
 9hhKigN+MXSTviSrD96+86Vcq4dAlfeA=
X-Gm-Gg: ATEYQzwzP4uSdgpbO0sKH4rmO+FW9S84szXTa/04vFYQ39iMDP2EdU1gRDBApryRhhG
 8YpLp3RJ0xGzwCFiSwuadaDFInn5QKxghjpeyX//5ZAm+F7dvnWZmPxTYzzUywYUzc2leQPBE7q
 4WwsIYCwIHxdY5T2HpRrKeQ2bVJ9TbTGQW+e6E3sMowl/AW50HF9M4dvqYCK8xya2T0NJRStxm0
 E42D8/IVlV1Y5FYo541KsV3FaCLd9aTlt1l7bL4TDSg4mxtCsFJrcHQLs0QdGxIMJF5DRF7Ne0h
 4iDhDhdj1ws1o8EWJ25D4oPrHf+TUzFH446vMypE/SLLDZQ5WHugdU9MVm8Ur8YoJ/3DO7FoZkH
 rGLXeIg==
X-Received: by 2002:a17:90b:2d8e:b0:35b:a656:a61a with SMTP id
 98e67ed59e1d1-35bb9f3eeccmr1468855a91.25.1773799734600; Tue, 17 Mar 2026
 19:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
 <20260317230500.2056077-5-vladimir.oltean@nxp.com>
In-Reply-To: <20260317230500.2056077-5-vladimir.oltean@nxp.com>
From: dhiraj thakur <saggi.dhiraj@gmail.com>
Date: Wed, 18 Mar 2026 07:38:41 +0530
X-Gm-Features: AaiRm507X2SLMRxHn5p_0owd2NEUsxu4uO4YuuIlk2TmNqldssPRPRo90TT4rOQ
Message-ID: <CACFta1tRU2NEv4g9OyW5rKvEN4YNPrNK4WbTe6Ee2uxBGpc0kg@mail.gmail.com>
Subject: Re: [PATCH v4 phy-next 04/24] drm: add <linux/pm_runtime.h> where
 missing
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
 UNGLinuxDriver@microchip.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Content-Type: multipart/alternative; boundary="00000000000015674e064d42ef6e"
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

--00000000000015674e064d42ef6e
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 18, 2026, 04:36 Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> Multiple DRM bridge drivers use runtime PM operations without
> including the proper header, instead relying on transitive inclusion
> by <linux/phy/phy.h>.
>
> The PHY subsystem wants to get rid of headers it provides for no reason,
> so modify these drivers to include what they need directly.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
>
> v1->v4: none
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 1 +
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 +
>  drivers/gpu/drm/bridge/nwl-dsi.c                    | 1 +
>  drivers/gpu/drm/bridge/samsung-dsim.c               | 1 +
>  drivers/gpu/drm/msm/dp/dp_aux.c                     | 1 +
>  drivers/gpu/drm/rockchip/cdn-dp-core.c              | 1 +
>  6 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index efe534977d12..9dfe790e6c14 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -18,6 +18,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>
>  #include <drm/bridge/analogix_dp.h>
>  #include <drm/drm_atomic.h>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 9392c226ff5b..a8b6ae58cb0a 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -32,6 +32,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/phy/phy-dp.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c
> b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 2f7429b24fc2..9ac8796ae91e 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -18,6 +18,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/sys_soc.h>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 930aaa659c97..54bc148fc29d 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/units.h>
>
>  #include <video/mipi_display.h>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c
> b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 3825a2fb48e2..5ee22f88bd28 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -6,6 +6,7 @@
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pm_runtime.h>
>  #include <drm/drm_print.h>
>
>  #include "dp_reg.h"
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index 177e30445ee8..68556daa54ae 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>
> --
> 2.43.0
>
>
>

--00000000000015674e064d42ef6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 18, 2026, 04:36 Vladimi=
r Oltean &lt;<a href=3D"mailto:vladimir.oltean@nxp.com">vladimir.oltean@nxp=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Multiple DRM br=
idge drivers use runtime PM operations without<br>
including the proper header, instead relying on transitive inclusion<br>
by &lt;linux/phy/phy.h&gt;.<br>
<br>
The PHY subsystem wants to get rid of headers it provides for no reason,<br=
>
so modify these drivers to include what they need directly.<br>
<br>
Signed-off-by: Vladimir Oltean &lt;<a href=3D"mailto:vladimir.oltean@nxp.co=
m" target=3D"_blank" rel=3D"noreferrer">vladimir.oltean@nxp.com</a>&gt;<br>
---<br>
Cc: Andrzej Hajda &lt;<a href=3D"mailto:andrzej.hajda@intel.com" target=3D"=
_blank" rel=3D"noreferrer">andrzej.hajda@intel.com</a>&gt;<br>
Cc: Neil Armstrong &lt;<a href=3D"mailto:neil.armstrong@linaro.org" target=
=3D"_blank" rel=3D"noreferrer">neil.armstrong@linaro.org</a>&gt;<br>
Cc: Robert Foss &lt;<a href=3D"mailto:rfoss@kernel.org" target=3D"_blank" r=
el=3D"noreferrer">rfoss@kernel.org</a>&gt;<br>
Cc: Laurent Pinchart &lt;<a href=3D"mailto:Laurent.pinchart@ideasonboard.co=
m" target=3D"_blank" rel=3D"noreferrer">Laurent.pinchart@ideasonboard.com</=
a>&gt;<br>
Cc: Jonas Karlman &lt;<a href=3D"mailto:jonas@kwiboo.se" target=3D"_blank" =
rel=3D"noreferrer">jonas@kwiboo.se</a>&gt;<br>
Cc: Jernej Skrabec &lt;<a href=3D"mailto:jernej.skrabec@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">jernej.skrabec@gmail.com</a>&gt;<br>
Cc: Maarten Lankhorst &lt;<a href=3D"mailto:maarten.lankhorst@linux.intel.c=
om" target=3D"_blank" rel=3D"noreferrer">maarten.lankhorst@linux.intel.com<=
/a>&gt;<br>
Cc: Maxime Ripard &lt;<a href=3D"mailto:mripard@kernel.org" target=3D"_blan=
k" rel=3D"noreferrer">mripard@kernel.org</a>&gt;<br>
Cc: Thomas Zimmermann &lt;<a href=3D"mailto:tzimmermann@suse.de" target=3D"=
_blank" rel=3D"noreferrer">tzimmermann@suse.de</a>&gt;<br>
Cc: David Airlie &lt;<a href=3D"mailto:airlied@gmail.com" target=3D"_blank"=
 rel=3D"noreferrer">airlied@gmail.com</a>&gt;<br>
Cc: Simona Vetter &lt;<a href=3D"mailto:simona@ffwll.ch" target=3D"_blank" =
rel=3D"noreferrer">simona@ffwll.ch</a>&gt;<br>
Cc: Inki Dae &lt;<a href=3D"mailto:inki.dae@samsung.com" target=3D"_blank" =
rel=3D"noreferrer">inki.dae@samsung.com</a>&gt;<br>
Cc: Jagan Teki &lt;<a href=3D"mailto:jagan@amarulasolutions.com" target=3D"=
_blank" rel=3D"noreferrer">jagan@amarulasolutions.com</a>&gt;<br>
Cc: Marek Szyprowski &lt;<a href=3D"mailto:m.szyprowski@samsung.com" target=
=3D"_blank" rel=3D"noreferrer">m.szyprowski@samsung.com</a>&gt;<br>
Cc: Rob Clark &lt;<a href=3D"mailto:robin.clark@oss.qualcomm.com" target=3D=
"_blank" rel=3D"noreferrer">robin.clark@oss.qualcomm.com</a>&gt;<br>
Cc: Dmitry Baryshkov &lt;<a href=3D"mailto:lumag@kernel.org" target=3D"_bla=
nk" rel=3D"noreferrer">lumag@kernel.org</a>&gt;<br>
<br>
v1-&gt;v4: none<br>
---<br>
=C2=A0drivers/gpu/drm/bridge/analogix/analogix_dp_core.c=C2=A0 | 1 +<br>
=C2=A0drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 +<br>
=C2=A0drivers/gpu/drm/bridge/nwl-dsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0drivers/gpu/drm/bridge/samsung-dsim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A0drivers/gpu/drm/msm/dp/dp_aux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A0drivers/gpu/drm/rockchip/cdn-dp-core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A06 files changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/g=
pu/drm/bridge/analogix/analogix_dp_core.c<br>
index efe534977d12..9dfe790e6c14 100644<br>
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c<br>
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c<br>
@@ -18,6 +18,7 @@<br>
=C2=A0#include &lt;linux/of.h&gt;<br>
=C2=A0#include &lt;linux/phy/phy.h&gt;<br>
=C2=A0#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
<br>
=C2=A0#include &lt;drm/bridge/analogix_dp.h&gt;<br>
=C2=A0#include &lt;drm/drm_atomic.h&gt;<br>
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/=
gpu/drm/bridge/cadence/cdns-mhdp8546-core.c<br>
index 9392c226ff5b..a8b6ae58cb0a 100644<br>
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c<br>
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c<br>
@@ -32,6 +32,7 @@<br>
=C2=A0#include &lt;linux/phy/phy.h&gt;<br>
=C2=A0#include &lt;linux/phy/phy-dp.h&gt;<br>
=C2=A0#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
=C2=A0#include &lt;linux/slab.h&gt;<br>
=C2=A0#include &lt;linux/wait.h&gt;<br>
<br>
diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-=
dsi.c<br>
index 2f7429b24fc2..9ac8796ae91e 100644<br>
--- a/drivers/gpu/drm/bridge/nwl-dsi.c<br>
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c<br>
@@ -18,6 +18,7 @@<br>
=C2=A0#include &lt;linux/of.h&gt;<br>
=C2=A0#include &lt;linux/phy/phy.h&gt;<br>
=C2=A0#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
=C2=A0#include &lt;linux/regmap.h&gt;<br>
=C2=A0#include &lt;linux/reset.h&gt;<br>
=C2=A0#include &lt;linux/sys_soc.h&gt;<br>
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge=
/samsung-dsim.c<br>
index 930aaa659c97..54bc148fc29d 100644<br>
--- a/drivers/gpu/drm/bridge/samsung-dsim.c<br>
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c<br>
@@ -20,6 +20,7 @@<br>
=C2=A0#include &lt;linux/of.h&gt;<br>
=C2=A0#include &lt;linux/phy/phy.h&gt;<br>
=C2=A0#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
=C2=A0#include &lt;linux/units.h&gt;<br>
<br>
=C2=A0#include &lt;video/mipi_display.h&gt;<br>
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_au=
x.c<br>
index 3825a2fb48e2..5ee22f88bd28 100644<br>
--- a/drivers/gpu/drm/msm/dp/dp_aux.c<br>
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c<br>
@@ -6,6 +6,7 @@<br>
=C2=A0#include &lt;linux/delay.h&gt;<br>
=C2=A0#include &lt;linux/iopoll.h&gt;<br>
=C2=A0#include &lt;linux/phy/phy.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
=C2=A0#include &lt;drm/drm_print.h&gt;<br>
<br>
=C2=A0#include &quot;dp_reg.h&quot;<br>
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockc=
hip/cdn-dp-core.c<br>
index 177e30445ee8..68556daa54ae 100644<br>
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c<br>
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c<br>
@@ -10,6 +10,7 @@<br>
=C2=A0#include &lt;linux/firmware.h&gt;<br>
=C2=A0#include &lt;linux/mfd/syscon.h&gt;<br>
=C2=A0#include &lt;linux/phy/phy.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
=C2=A0#include &lt;linux/regmap.h&gt;<br>
=C2=A0#include &lt;linux/reset.h&gt;<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--00000000000015674e064d42ef6e--
