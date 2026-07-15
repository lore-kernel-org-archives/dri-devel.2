Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748F8C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D142210E209;
	Wed, 15 Jul 2026 18:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="i/YH6zzu";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B170B10E207
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784140269; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mF+82Ak2xmHGgbVpn39yFo1ujKBHtUruIeLUq0wT0hxE/5VO0yqPQx/X2vQZsW2pXD5c+hXeTXHqnqG49GgFapriRA//Ut8ZOikB+NbBQ6WKuXTatdXVJ0Zv8tsFSfuekO7RFRhpR+6uiCi+nCXHhfkM+LLRtVuGnyq4++lnCn0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784140269;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=N/wiBLYHdGXZJkCg3oiCX/MSyspe/eiXGex9ftDaZcE=; 
 b=Wq86dZDfxwLzEPjzbpEFWxu+0Bn/IBHdVt7Gplx3r/tgpwmMlScib11AeXnv4lbmBAqoprAeOviGj964g1je+zrhI3eRtNf7MS0wNXDcRtUMtLkCrmNsEvueR9Ld9Udx4yHoSX3UpeGlk8KfxYNE/GLS8rqlBb0jl5lsOfMTGbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784140269; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=N/wiBLYHdGXZJkCg3oiCX/MSyspe/eiXGex9ftDaZcE=;
 b=i/YH6zzu7szwG3X/T7xICxR7uKdgqUMZmCHJ1dMCpLh9NfGt+npTLJuO8Z0qTLeZ
 d0X+UpC7bvzAlaaAEyagubKAqouLSvOlYtfzI3FamtSP7oc8x7SH6Mb6FM1gg0K40Dr
 UpT6qfSnFS2y4v5ji2KXDYD1NCIpVdcdEXZjtX18=
Received: by mx.zohomail.com with SMTPS id 1784140267504649.5715776031727;
 Wed, 15 Jul 2026 11:31:07 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 1F034180820; Wed, 15 Jul 2026 20:31:00 +0200 (CEST)
Date: Wed, 15 Jul 2026 20:31:00 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andy Yan <andyshrk@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
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
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, yubing.zhang@rock-chips.com
Subject: Re: [PATCH v3 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
Message-ID: <alfQl182eZjaDwgZ@venus>
References: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
 <20260612-synopsys-dw-dp-improvements-v3-7-dc61e6352508@collabora.com>
 <CANbgqAQLROuf9wvZZWRufZg6iqubKnC4fW5Bh+DkQ7RP1x5KKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k4oubbgopkkrgoq4"
Content-Disposition: inline
In-Reply-To: <CANbgqAQLROuf9wvZZWRufZg6iqubKnC4fW5Bh+DkQ7RP1x5KKQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.121.97
X-ZohoMailClient: External
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


--k4oubbgopkkrgoq4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
MIME-Version: 1.0

Hello Andy,

On Tue, Jul 14, 2026 at 05:01:14PM +0800, Andy Yan wrote:
> Hello Sebastian,
>=20
> Sebastian Reichel <sebastian.reichel@collabora.com> =E4=BA=8E2026=E5=B9=
=B46=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:01=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Add runtime PM stubs to the Synopsys DesignWare DisplayPort bridge
> > driver. Support is not enabled automatically and must be hooked up
> > in the vendor specific glue code.
> >
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-dp.c | 27 +++++++++++++++++++++++++=
++
> >  include/drm/bridge/dw_dp.h              |  3 +++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > index 7fa38145e35c..7f4f36c61484 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > @@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_a=
ux
> > *aux,
> >         if (WARN_ON(msg->size > 16))
> >                 return -E2BIG;
> >
> > +       ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> > +
> >         switch (msg->request & ~DP_AUX_I2C_MOT) {
> >         case DP_AUX_NATIVE_WRITE:
> >         case DP_AUX_I2C_WRITE:
> > @@ -1655,6 +1657,8 @@ static void dw_dp_bridge_atomic_enable(struct
> > drm_bridge *bridge,
> >         struct drm_connector_state *conn_state;
> >         int ret;
> >
> > +       pm_runtime_get_sync(dp->dev);
> > +
> >         connector =3D drm_atomic_get_new_connector_for_encoder(state,
> > bridge->encoder);
> >         if (!connector) {
> >                 dev_err(dp->dev, "failed to get connector\n");
> > @@ -1709,6 +1713,7 @@ static void dw_dp_bridge_atomic_disable(struct
> > drm_bridge *bridge,
> >         dw_dp_link_disable(dp);
> >         bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
> >         dw_dp_reset(dp);
> > +       pm_runtime_put_autosuspend(dp->dev);
> >  }
> >
> >  static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connect=
or
> > *connector)
> > @@ -1729,6 +1734,8 @@ static enum drm_connector_status
> > dw_dp_bridge_detect(struct drm_bridge *bridge,
> >  {
> >         struct dw_dp *dp =3D bridge_to_dp(bridge);
> >
> > +       ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> >
>=20
> This may not work correctly. Per the DW-DP TRM, the " HPD_HOT_PLUG
> bit is asserted only after the sink is attached and holds HPD high
> for at least 100ms". Consequently, reading this bit within 100ms
> after resuming runtime_pm may fail to detect the status. I've
> verified this behavior on a Rock 5B board=E2=80=94the HPD bit remains
> unreadable at this point.
>=20
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1761,12 +1761,17 @@ static enum drm_connector_status
> dw_dp_bridge_detect(struct drm_bridge *bridge,
>=20
>         ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
>=20
> -       if (!dw_dp_hpd_detect(dp))
> +       if (!dw_dp_hpd_detect(dp)) {
> +               printk(KERN_DEBUG "%s no hpd\n", __func__);
>                 return connector_status_disconnected;
> +       }
>=20
> -       if (!dw_dp_hpd_detect_link(dp, connector))
> +       if (!dw_dp_hpd_detect_link(dp, connector)) {
> +               printk(KERN_DEBUG "%s no link\n", __func__);
>                 return connector_status_disconnected;
> +       }
>=20
> +       printk(KERN_DEBUG "%s connected\n", __func__);
>         return connector_status_connected;
>  }
>=20
> @@ -2149,6 +2154,7 @@ static irqreturn_t dw_dp_irq(int irq, void *data)
>         u32 value;
>=20
>         regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);
> +       printk(KERN_DEBUG "%s value: %d\n", __func__, value);
>         if (!value)
>                 return IRQ_NONE;
>=20
> bootup
> [    5.218035] panthor fb000000.gpu: [drm] Using Transparent Hugepage
> [    5.219073] [drm] Initialized panthor 1.9.0 for fb000000.gpu on minor 1
> [    7.953973] r8169 0004:41:00.0 enP4p65s0: Link is Up - 1Gbps/Full - fl=
ow
> control off
> [    8.601273] dw_dp_rockchip_runtime_resume ret: 0
> [    8.702748] dw_dp_irq value: 1        // (HPD irq 100 100ms  after
> runtime_resume)
> [    8.714236] dw_dp_irq value: 2
> [    8.714775] dw_dp_irq value: 2
> [    8.715201] dw_dp_irq value: 2
> [    8.715710] dw_dp_irq value: 2
> [    8.715744] dw_dp_bridge_detect connected
> [    9.226752] dw_dp_rockchip_runtime_suspend
>=20
>=20
> Then run modetest:
>=20
> # modetest
> trying to open device '/dev/dri/card1'... is not a KMS device
> trying to open device '/dev/dri/card0'... done
> opened device `RockChip Soc DRM` on driver `rockchip` (version 1.0.0 at 0)
> Encoders:
> id      crtc    type    possible crtcs  possible clones
> 86      0       TMDS    0x00000004      0x00000001
> 88      0       TMDS    0x00000001      0x00000002
> 92      0       TMDS    0x00000002      0x00000004
>=20
> Connectors:
> id      encoder status          name            size (mm)       modes
> encoders
> 87      0       disconnected    DP-1            0x0             0       86
>   props:
>         1 EDID:
>=20
> [   13.809398] rockchip-pm-domain
> fd8d8000.power-management:power-controller: sync_state() pending due to
> fdee0000.hdmi_receiver
> [   29.225506] dw_dp_rockchip_runtime_resume ret: 0
> [   29.225940] dw_dp_bridge_detect no hpd         // no HPD read here
> [   29.326986] dw_dp_irq value: 1                         // HPD irq ater
> 100ms
> [   29.346609] dw_dp_irq value: 2
> [   29.347150] dw_dp_irq value: 2
> [   29.347578] dw_dp_irq value: 2
> [   29.348092] dw_dp_irq value: 2
>=20
>=20
> if I add a mdelay(110) after  ACQUIRE pm_runtime,  the hdp can be read.
> index 02ca7fe725876..5959e79eb3e2b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1760,7 +1760,7 @@ static enum drm_connector_status
> dw_dp_bridge_detect(struct drm_bridge *bridge,
>         struct dw_dp *dp =3D bridge_to_dp(bridge);
>=20
>         ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> -
> +       mdelay(110);

Interesting, I did not notice this issue with the Sige 5 (RK3576).
Thanks for not just reporting it to not work, but also figuring out
what is going on :) I will add an msleep(110); in the next version.

Greetings,

-- Sebastian

--k4oubbgopkkrgoq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpX0eMACgkQ2O7X88g7
+proiw//TpC4KRIooalLSV6qAZujhx/NZeM1RZgdMyLHA8A5+uvrO4uhjIrPPivv
zUqwAU90nbdoVNt8zyKhjwpabHHXtrh2wxwMjesYOYO1SLNDgLvF7IrUYdOfXzJA
00hzJglxvIB5aJllxCzSkrP2WpNEqjrBpL3QfuzObOc/qd9yq/Z/OmNh6HTWsmFi
6lASNypyehhXPwwgyP8brI7Nb+w7IaemGTEAbOMkbxDZ1VnBOLde0BKCsLyKwZV0
jtSEozTs8Hzh6Wfpu66oklAsxZhp64lbYDNpOtYb5YsBeyoy56D4mR1++hYXcIxf
tr0TaiVMSEwa32cX1YEg2ZaDGz+odB+nGdiPffg3+2UhNQoae/qxrpmRpgvTWijW
Wz5YqfGmFs/s/iR10Osxwy3YBY/mKScp81F6S4Lv191vDCfs+9j5wYArv/52m7zf
hPUbiy0k2SRTgt0VSmHly81fQRTzM1VUamYBTzdy0Gik5EsYwRZSggLip8aWHlct
tQHNgpu8iOhaDP9aEu19HMQtKF1ppHBPJPIREBT19JOyr4Shv18IzGbBNjrZuQU5
nO94Xviw9otQpWfWGdvHgXSgsWIkgNLGuHrgOQK3YZF0V9N9/C4cCqSf3N6vFqUu
rqHu9882Hg7u63fDL0KVTrVGzfg+FH6MNF1N5mHwKthNiCkbPHM=
=fomM
-----END PGP SIGNATURE-----

--k4oubbgopkkrgoq4--
