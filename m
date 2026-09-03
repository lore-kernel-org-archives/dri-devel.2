Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8839EC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D808110F66F;
	Thu,  3 Sep 2026 15:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="TLDBITNR";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A7B10F66F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=uWKbj06GMxVM1AmFAtNOW8Qq7f96OKxmUAD1isOqei0=; b=TLDBITNR1KF/EL7KvbL44EZnS9
 TzA/Ndl1x7WVjwCVMd5kR8ifD3PzJsBsYgLZZHVYp/sr5iUMlaTZRMiX71hXoxQpEn4cPN/KtxYeG
 nOcLmRoDFMKcRk3Zw1ZwZ8M8q6ot5H6H9OQPjpgV4DADjNzRZVtcwkMIOkrsH1s4QEAKTL4hKtLtL
 wbi9+Yzrw59C88C/SJdVcMAgBY/P+RDbSd7+79n6ivpWHpFjfju0Ba2iioznX8OfzLHf7pE/Ye0As
 1aQeDLw92XgmkD40iZS8vSPrsH1PV5ZaDlM216ASOBIrxA5KXFwbgD9v7A6YPzONlQ/VpytHxsvXU
 N0U7IpgQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 jbx6244@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?SMO8c2V5aW4=?= BIYIK <boogiepop@gmx.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
Date: Thu, 03 Sep 2026 17:12:02 +0200
Message-ID: <2814844.6tgchFWduM@diego>
In-Reply-To: <20260824-drm-v2-1-7f9273c6020b@gmail.com>
References: <20260824-drm-v2-1-7f9273c6020b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Montag, 24. August 2026, 12:21:19 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Johan Jonker via B4 Relay:
> From: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
>=20
> The function devm_drm_bridge_alloc() is the new API for allocating DRM br=
idges.
> This conversion was missed during the initial conversion of all bridges to
> the new API.
>=20
> Signed-off-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/roc=
kchip/rk3066_hdmi.c
> index f28d6a883e09..39c65ee07caa 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> @@ -703,7 +703,6 @@ rk3066_hdmi_register(struct drm_device *drm, struct r=
k3066_hdmi *hdmi)
>  			 DRM_MODE_ENCODER_TMDS, NULL);
> =20
>  	hdmi->bridge.driver_private =3D hdmi;
> -	hdmi->bridge.funcs =3D &rk3066_hdmi_bridge_funcs;
>  	hdmi->bridge.ops =3D DRM_BRIDGE_OP_DETECT |
>  			   DRM_BRIDGE_OP_EDID |
>  			   DRM_BRIDGE_OP_HDMI |
> @@ -747,9 +746,10 @@ static int rk3066_hdmi_bind(struct device *dev, stru=
ct device *master,
>  	int irq;
>  	int ret;
> =20
> -	hdmi =3D devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> -	if (!hdmi)
> -		return -ENOMEM;
> +	hdmi =3D devm_drm_bridge_alloc(dev, struct rk3066_hdmi, bridge,
> +				     &rk3066_hdmi_bridge_funcs);
> +	if (IS_ERR(hdmi))
> +		return PTR_ERR(hdmi);

If I'm reading things correctly, the parts in rk3066_hdmi_register setting
hdmi->bridge.driver_private (should use the container field of struct
drm_bridge instead) and hdmi->bridge.funcs are redundant by this change?


Heiko



> =20
>  	hdmi->dev =3D dev;
>  	hdmi->drm_dev =3D drm;
>=20
> ---
> base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
> change-id: 20260824-drm-e4689f65ab8c
>=20
> Best regards,
>=20




