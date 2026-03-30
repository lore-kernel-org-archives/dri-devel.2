Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805D810D14A8
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D160610E5E3;
	Mon, 30 Mar 2026 11:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="bAXQbXc3";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4F210E5E3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774871452; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j1Hk0CJjKXW9sdMYJFRvns9c4GgmWAHXiggeVrANYvF1e1WO5eno+KkVL6B3B1XSTfyss1tCOavcuBwFIA39wg2XoZLFeMOQ6R2yDX7HYiNuWpylmiTAgzRH4D8+fgYBr/8ObKoPMMmWx4+z6QrCHts093ivdZnRJbkEo+KAVhU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774871452;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=15SW2UZmj9L14ZbmYWu+YmNSkGcYxzsZ3KRbJg87q3I=; 
 b=ltr1S2zrc13lTBv79d17gVoPxYOG6eJXRBaiLa1zWFHbAnGVcQEmQ4p3QKG+rGmdUQni931HC3MDEKPrf0zJRqITZWb78MdG5j3/VHL+UCqU9lR5uKiA4GzDojCdTddugbLRVv9Xi/GXFHhPvv3DdtNI/q1ICckzOeJ+b7FR2gk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774871452; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=15SW2UZmj9L14ZbmYWu+YmNSkGcYxzsZ3KRbJg87q3I=;
 b=bAXQbXc3kLCDPaMQ3hzqjOzdOkJZb9WfT560GF++gIgBEHo3aq1lRXSRAUiqxx9D
 iq2LwXzZa7mcVfod2M2LkAVYifPtpmFB45xa48FhAizJ/wxDiuTmBgg+sdjYx5EtGKI
 wPDruAutV0u+McDWdI4kKzSyXoZtK8gR45M/DTDU=
Received: by mx.zohomail.com with SMTPS id 177487144983591.88336926880925;
 Mon, 30 Mar 2026 04:50:49 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id B8AC91804F1; Mon, 30 Mar 2026 13:50:43 +0200 (CEST)
Date: Mon, 30 Mar 2026 13:50:43 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <kernel@airkyi.com>
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
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 00/10] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Message-ID: <acphlgK6ZmBitGJL@venus>
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
 <FE1BFB774BE13241+54b8a8ce-5a8c-495d-a53f-65a2440924fb@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ez6uvywry5y7oix6"
Content-Disposition: inline
In-Reply-To: <FE1BFB774BE13241+54b8a8ce-5a8c-495d-a53f-65a2440924fb@airkyi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/274.861.95
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


--ez6uvywry5y7oix6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/10] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
MIME-Version: 1.0

Hello Chaoyi,

On Mon, Mar 30, 2026 at 09:34:15AM +0800, Chaoyi Chen wrote:
> > There are two parts, which possibly need some discussion:
> >=20
> >  1. I added a dedicated bridge callback for out-of-band hotplug events,
> >     which is separate from the hotplug_notify. I have a feeling, that
> >     there might be a better solution, but haven't found it.
>=20
> Could you explain what an out-of-band hotplug event is?
>=20
> Can't the drivers/usb/typec/altmodes/displayport.c respond to these
> hot-plug events? Thank you.

That is what generates the out-of-band hotplug event in the first
place via drm_connector_oob_hotplug_event(). The oob in that call
means out of band.

If you look at that function it calls oob_hotplug_event() callback
on the DRM connector, which is then implemented by
drm_bridge_connector_oob_hotplug_event(). This function calls uses
the normal hpd handling (shared by in-band and out-of-band) and I'm
patching it, so that the bridges are aware of hpd explicitly being
provided out-of-band.

Greetings,

-- Sebastian

--ez6uvywry5y7oix6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnKY5AACgkQ2O7X88g7
+ppCWQ/9FPgpYzVbuIaK1W4l+x0qPYHV6vLjMwbbsc0KleVql8OJlXxjkvOCyN/f
l1VW8NiYtCsRcwffTey5PgDjwPCscQT9y9L4w2kRbJhGsCe/zwaYIvuQfp6hPrkY
OLDnBG3FoxxDxwR0wSK1buk+joq6UcLX8ZvB96C99j4MifkarRROr6UEzU6f7rIO
47KouuDZLCCd2hujJ2dVOmAhWoZrI9tGworvDdQYFWrpEkehDubrg15cbNJ3ob7W
KuagSE2REZF2KDM1wgzEcA3VzrYVvz1p4vpsffgR1uqZ4ds7F8+0TB61EURI1rJV
wXR7En0dBIRgRjebfw5gRq6kt+MCZLAuPn0LBCtRAotK0JsdGlhuM3MMJKay5Bx5
NUZ4obzJob04VqWMrlcN1PoTs/la+1ZMg32TO3vhyhAdpGIBDXS3mfyXKNzcDcsy
i41OK3i7GwRlpeqv7XiGCLTVGjkqf3D+qxzkuS6yejaP4AuMyFwgUfL1ePfEHU1X
+7spbpwiVijXY3Fb7gyTU3KggqStX43D7wHkXNTIRKtrWAXXJ3FrKT+RTzjDUPYm
MLwfdEzLxXpC0kJ/7O+D128J5BIRLzM1kaN8RD+UtMSEjyA0lYfP6tGXfjMEQrxP
xMfJpD5qcTvl2ktQYOa8+V6NJzVOyo6BWxH73GQpe3t9w+0zU0I=
=wqPq
-----END PGP SIGNATURE-----

--ez6uvywry5y7oix6--
