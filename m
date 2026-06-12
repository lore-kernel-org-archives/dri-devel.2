Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1A7CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D553210EAA1;
	Fri, 12 Jun 2026 16:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="NrYnVgKT";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4BB10EAA1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781282271; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eZbpZFrHare2ZkdyH2mlS82J2OCdJQ4FvrBiaxu5MQloDqfweBtlqgapAo2lvzBt/VsowUDAujoDmKh65ObWl2o9FTfqFbJmFX64Py2iap5xUUjw2P9BmhpSmHjdqLxJi20fVF60QhdEAJSM9/j+mXPmTwVNjlA8khCCJNdtaoU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781282271;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cz0JvF5PqRn4+AvgydKR6qxMt5tufCqZlm71fI/zQJE=; 
 b=U1OSMKMnKPRcdT3LGdJ9VC6S/CrZw9aAwSXQDBEYAuJ7e64Csg2DoHKybxTI6IexcBZqopKtLYW5JwhhFIWckO3jyg2dLeluzcISdClCsJT2kYJDH2vJa7O3dur70uX6BMsPHc0Xl4hMPjSPswZlIWAjQwFwAXDwKEvOnIHu2wA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781282271; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=cz0JvF5PqRn4+AvgydKR6qxMt5tufCqZlm71fI/zQJE=;
 b=NrYnVgKTaiUOijL3nFNPT0GRc59JHJygJH2GXurDQ5WU52i418+IzzG+cEvPYoFN
 7wHye0F8/N56hPz0k3y9yYCWJuFbkwsvM1vBOEi7wwMnrtnA3Tq/o9ioKDM8LwQ7yZj
 fesFoG4rCqM5kfcfuRp9ZlpxUwEpeG0dKw9fuqj8=
Received: by mx.zohomail.com with SMTPS id 1781282268882444.94252128935307;
 Fri, 12 Jun 2026 09:37:48 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 137D8180674; Fri, 12 Jun 2026 18:37:42 +0200 (CEST)
Date: Fri, 12 Jun 2026 18:37:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
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
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/12] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
Message-ID: <aiw0VKuj6Y6tpr9f@venus>
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
 <20260501-synopsys-dw-dp-improvements-v2-7-d7e7f6bac77f@collabora.com>
 <4f4ff085-80ae-4144-b040-be9b136574ee@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p2h2tj3fgjiazqvf"
Content-Disposition: inline
In-Reply-To: <4f4ff085-80ae-4144-b040-be9b136574ee@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/281.270.71
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


--p2h2tj3fgjiazqvf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 07/12] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
MIME-Version: 1.0

Hello Chaoyi,

On Tue, Jun 02, 2026 at 04:30:59PM +0800, Chaoyi Chen wrote:
> On 5/1/2026 6:20 AM, Sebastian Reichel wrote:
> > Implement out-of-band hotplug handling, which will be used to receive
> > external hotplug information from the USB-C state machine. This is
> > currently handled by the USBDP PHY, which brings quite some trouble
> > as the register being accessed requires the power-domain from the DP
> > controller and also requires custom TypeC HPD info parsing in the
> > USBDP PHY driver.
> >=20
> > In contrast to the USBDP PHY this does not just enable the hotplug
> > signal when a DP AltMode capable adapter is plugged in, but instead
> > properly detects if a cable is plugged in for things like USB-C to
> > HDMI adapters.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> [...]
>=20
> > +static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
> > +{
> > +	struct rockchip_dw_dp *dp =3D data;
> > +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> > +
> > +	dev_dbg(dp->dev, "Force HPD connected=3D%s\n", str_yes_no(hpd));
> > +
> > +	dp->hpd_cfg =3D hpd;
> > +
> > +	regmap_write(dp->vo_grf, hpd_reg,
> > +		     FIELD_PREP_WM16_CONST(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_=
cfg));
>=20
> FIELD_PREP_WM16() should be used here because "dp->hpd_cfg" is not
> a constant expression.
>=20
> Other patches in this series have similar issues. Doesn't your
> compiler warn you about this? Thanks.

The code builds warning free for me. Also FIELD_PREP_WM16_CONST
requies that the mask is constant, which is the first argument
(i.e. ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG in this case). The second
argument should be fine as a variable as far as I can tell.

But since FIELD_PREP_WM16 is shorter anyways, gives better error
handling and can be used for all occuances in the dw-dp rockchip
glue I will use that instead.

Thanks,

-- Sebastian

--p2h2tj3fgjiazqvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmosNdIACgkQ2O7X88g7
+pr0qRAAj815LPOHnJWGnjzNNkUa/kzLFB4bzesaxqb+wG3aeeh0mPO+oeA95BCm
SAJ+4pmlt2gMl+ubhV57wIpAqet9TkklmWL1mJjItmbqTWUYO4juygwWu/BuqMBx
fXdKK6ypbX6wXEfKSA2dfXsjIdAWI1U0w3Ur/tUbWHoaf/18RczSbqaQZo1djjBm
oszzKbkhNm+y4IN+FgKWKwTWsEjuPU3dO21LwSNU2BU2SwZKXuPeFC+oBOJgikpe
CtNKqtrU+IRnZTM0G8J00BthrRYV1wCT9e/LxMkEKXDcu1Y20UPoN9FIOvDKkjHZ
XgilvLd+sd05hogeeTyWHGZsJxj3hIjFQiHGzlxi9TU8/r/m/cVyMDIKfdWWYVVA
o83o7A1MSDm41PopcT1Ig1x/4EISnG5vl2hgXa6YPEEyc35SJc9p9ONxKx+q4V8z
uASra69imY+fuQumXJdBFFvKxw2JnGWqvgFWL2J5P6CI7tdhTQEf1FeJbg4JKMxN
+4iHaKWIkwvBni35M2cqX05bm2CXTXgMQfN8Y3PuBGdeB9tY+n2n8sCFB9CTJbRR
Z9FyB3EQdld6e2/X/dScExJyHuG4UBgbvys58QuoOd6F8XCFmxoIGpbCedQRMtJH
eFzckHF+qJfPxAYUfdtEkEK8VAFYb/8BFXBQPCxc0590XvbGvdI=
=qoV1
-----END PGP SIGNATURE-----

--p2h2tj3fgjiazqvf--
