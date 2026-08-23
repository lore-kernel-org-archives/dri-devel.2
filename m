Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB249C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 19:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B352510E025;
	Sun, 23 Aug 2026 19:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="o6pulzMO";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DD910E025
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=/W6mkeoXvnonMNZUI3njI0qG2gH3SwBOtWLJBh8UHlM=; b=o6pulzMO03REegWhuuub+t8v3d
 fsJQF+E0p8GSd/S95Kwk/5mdjKiT0tPOtr3GvhNT+YDv6MiP6wpgBzKBT9JQjUtvPr0JFQNcnb6ta
 r5cJZQYy7vXGMgiyppwKTAxnTN9wfgUoGNaV9o1NqbAxEU1i66C0thPUmBlS4c5cJ7vQnExVl6mVk
 xPkijEuj3K2TuqXest7lqlNETwhQ6mH+OorjXwNflJek0MQiSy+HXpCQvohTq4ZviqXU9Ji4YL7yh
 npchf11iQcDW46NEXtLXcJHWntRZIPPnLY8ch9lN/wzs6yJuI9m+7mmHA2OmVQSxS2Un3YT9MN3Em
 ZyZ+uCrw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
Date: Sun, 23 Aug 2026 21:10:31 +0200
Message-ID: <9306866.NyiUUSuA9g@diego>
In-Reply-To: <dea8a038-577b-45da-bff3-703e9099b7e1@gmail.com>
References: <dea8a038-577b-45da-bff3-703e9099b7e1@gmail.com>
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

Hi Johan,

Am Sonntag, 23. August 2026, 14:47:25 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Johan Jonker:
> The function devm_drm_bridge_alloc() is the new API for allocating DRM br=
idges.
> This conversion was missed during the initial conversion of all bridges to
> the new API.
>=20
> Signed-off-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

the authorship is ambigous here. First Signed-off-by should be from the
patch author, yet this one makes you the author.

So either the author needs to change or the signed-off-by line
needs to go.


Heiko

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
> =20
>  	hdmi->dev =3D dev;
>  	hdmi->drm_dev =3D drm;
>=20




