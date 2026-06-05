Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D2CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35A311A9E2;
	Fri,  5 Jun 2026 16:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="T56ePz11";
	dkim-atps=neutral
X-Greylist: delayed 903 seconds by postgrey-1.36 at gabe;
 Fri, 05 Jun 2026 16:57:31 UTC
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6220511A9E2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780677735; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kf3peC3t98Ib9KZYHmO3v+Vj/1d7k/dGYEP3n5awo3CqJoS4nr+EmTGunekAm/OjbB8Hh7Ln4fnQ2k3bX7tzwiWmAJlv5/Qql806HoMfjbQO1w1etKQ8RpIa+tBcSSLaDT9gEoOVAyigIh0RgBZbWWixB5AfooC3WUbsdLjuwGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780677735;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Tgqhsze06HfbpZq35K9dBzb4bY+s/AG3gLWTDVJ0ELc=; 
 b=jddLMWFQ7e9GrDSSQ1kAmrwsIlFZ8EZBpfzVoXDj89Kd3iaa6rzeWfoNoHpKbs1s4dT5FTVMKs2gmn/GRnxL8ofaZxpKB5hkra5OptUl8SK5CH/7JIiopg/B9V5FMBmgY84tmobiKZraYR2vptFmfYM63Fy7hAPPa+6zASKTM/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780677735; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=Tgqhsze06HfbpZq35K9dBzb4bY+s/AG3gLWTDVJ0ELc=;
 b=T56ePz11B9/m9NhHDl03em3oN80y6mfJfVFi8zqf1iVBjHLeZVMqFwVtHJdGxUGt
 6EZ7UdXO+hjOsfo4wjehYz4pkZ1Xec2picOXlI7Z6XzOlKcWee+TJ323FtQudYmMh0r
 /qLIS+mORuVNG0MI451IC38y1gvmY2ONavrw5maA=
Received: by mx.zohomail.com with SMTPS id 1780677733010276.20170001455165;
 Fri, 5 Jun 2026 09:42:13 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 82C56181D83; Fri, 05 Jun 2026 18:42:06 +0200 (CEST)
Date: Fri, 5 Jun 2026 18:42:06 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
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
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, 
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 05/12] drm/bridge: synopsys: dw-dp: Add follow-up
 bridge support
Message-ID: <aiL4lUUa9j6_irAz@venus>
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
 <20260501-synopsys-dw-dp-improvements-v2-5-d7e7f6bac77f@collabora.com>
 <177918892313.537125.10814687633426590148.b4-review@b4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m4w4l56frz4pgctv"
Content-Disposition: inline
In-Reply-To: <177918892313.537125.10814687633426590148.b4-review@b4>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.674.88
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


--m4w4l56frz4pgctv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 05/12] drm/bridge: synopsys: dw-dp: Add follow-up
 bridge support
MIME-Version: 1.0

Hello Luca,

On Tue, May 19, 2026 at 01:08:43PM +0200, Luca Ceresoli wrote:
> On Fri, 01 May 2026 00:20:32 +0200, Sebastian Reichel <sebastian.reichel@=
collabora.com> wrote:
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/=
bridge/synopsys/dw-dp.c
> > index fc4ddb7792d7..ccc55e40e81c 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > @@ -2064,6 +2064,20 @@ struct dw_dp *dw_dp_bind(struct device *dev, str=
uct drm_encoder *encoder,
> >  		goto unregister_aux;
> >  	}
> > =20
> > +	next_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
>=20
> devm_drm_of_get_bridge() looks for either a panel or a bridge. Is it
> possible to have a panel connected here?
>=20
> If it isn't, then using of_drm_get_bridge_by_endpoint() which has just be=
en
> merged [0] would be much simpler and cleaner.

Technically this should always be connected to the USBDP PHY
on the Rockchip platforms using this IP (RK3588 & RK3576) and
there are no other upstream platforms using this code so far.

Having said that, we do have some upstream DTs, which directly
connect it to a DP connector instead (as the PHY does not yet
expose a DRM bridge, that's being handled in a different series).
But there is no upstream board connecting it to an eDP panel,
so I will switch over to of_drm_get_bridge_by_endpoint().

Thanks for the info.

Greetings,

-- Sebastian

>=20
> [0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/03d1078112fdd=
d706b2c1e4a7d98cf18700eb5df
>=20
> Luca
>=20
> --=20
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>=20

--m4w4l56frz4pgctv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmoi/FMACgkQ2O7X88g7
+pphnA//Ybl+zfoxQYVFEOrEKJfflb05xZ7uBHTS161zwMfNHamKHq0m5XtJ0Cfy
5HrJ/AQ8R5Eizb3kI09PWMimzpjr/9pDFo7d1xb25zzP42pPFsCniXq1W4p/+D39
tsiUc7RruHWxniCf4xsZHSyYQd1L05KUwPbldLV1n7P+GEp5qGdmpsCPtlCxNJxr
SJv1dGUo6Oq/enMdVd7Qs7gfE6ZQWXQ3+EHACruc7OldzfQoxi9L6+LFigsk8eAJ
9zxlu/MVy7rDhRNLzZ0JApYpXpbPz/G5mbCQFEbAhRrf1YRhiSwE3XtVyvicBUXL
8YeA+0/2e2W4WygQnC8B7bbOwnwaCYaek2hr5ftlVSjax8pLSJyH9LxGAgxY0tLF
hxTl88B9PjKJUF8zTJLasGn/amgbB2amzfQKFxn8HYxQHy3k4MuP4uyhPE4PoVWH
5CH5HQF/sHk9eEwoMowUI9Lvn8hM6iRkh2djcm4LzdAlfeVMRiV45V0nYlhvMIHZ
d6h182Vgk6yxsIhTv0bNHjkU4VTi9nslIyOhGi4hnin9BrdLdhfl+5RHQVNCb4pX
Re7DOKH8LtCN9TJkwJL7pHsN6dCdnWyYkiJc8Am2nkiNZQDXrpoZGDzxDrwU8aJZ
uyDrcem4Z+CEK8DSg6I24U5a5vJa/WPLK5VN7EF1QpXO/vij2S0=
=dAt0
-----END PGP SIGNATURE-----

--m4w4l56frz4pgctv--
