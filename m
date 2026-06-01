Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C5BCD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772B91131FB;
	Mon,  1 Jun 2026 11:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UaQKAz1Q";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FB91131FB
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780312667; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MtOIe2F2NDU7+6mRWpfmiGDgJgT9if9OJXK+XzOhhP3mWFk6jInA9u7uaOKBK1A14n6BCmDPM5MX48j50/0AUFFfzv37mT6StsL9Xv9riA5VP4j9pQ0d27AD/kLKQkeiBBWzlxICwY5W8/8gwBH20zu6bico+q11hVwl6JDMfn8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780312667;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OXhsAs0eCmvLurN/cUXZy1negkPi8CtoEtem/pwCT58=; 
 b=a4gkjZ3BXGtg4eM0EUHe97RGPxrctKIW3IMWgF1jJZPH4MVHh5qO4kikmzEK3ee2Lq3Brl6QdlKMZI0N6aXgS8tEXgQADzX3n5+fDMFMGiLHMmSv0KYk9gOd0kg3vPwenJAHFleUwuzxV8X27bMJbhERXElqQ5vU0elDhxv6m9U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780312667; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=OXhsAs0eCmvLurN/cUXZy1negkPi8CtoEtem/pwCT58=;
 b=UaQKAz1Qgs2xRvCGBSg9mdYEpg9ZgRAPZ2sPvm8EMEoeuUZM64vsW69Vfnps9rMx
 TGU7x4exz8BPM8o7ZeTSjpAx+N4I2Kx9cmeTUL+YjXBNNvZgDu5s0wrhAgiHIIP+bPR
 WPIpGtO3yKMmfOZ1uMSvd0y0uHQqHtv+NHzHH6a0=
Received: by mx.zohomail.com with SMTPS id 1780312664410658.9277971875678;
 Mon, 1 Jun 2026 04:17:44 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 03508181D80; Mon, 01 Jun 2026 13:17:39 +0200 (CEST)
Date: Mon, 1 Jun 2026 13:17:39 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
Message-ID: <ah1pBCZhCSuoHIBk@venus>
References: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jkxgxidvvfygd4in"
Content-Disposition: inline
In-Reply-To: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.300.36
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


--jkxgxidvvfygd4in
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
MIME-Version: 1.0

Hello Detlev,

On Tue, May 19, 2026 at 02:00:11PM -0400, Detlev Casanova wrote:
> -EOPNOTSUPP is not logged as an error by the ASoC subsystem, but -ENODEV
> is.
> It also better represents the situation: The operation is currently not
> supported (because clocks are not enabled and tmds_char_rate is
> unavailable), but the hardware is present.
>=20
> Using -EOPNOTSUPP in the audio_prepare callback removes possible repeated
> warning log lines when HDMI is not connected.
>=20
> Returning -EOPNOTSUPP in the audio_enable callback is also needed as it
> avoids logging 0-valued ELD errors.
>=20
> When tmds_char_rate is available, the clocks are enabled and the
> functions will keep returning 0 as before.
>=20
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Fixes: fd0141d1a8a2a ("drm/bridge: synopsys: Add audio support for dw-hdmi-=
qp")

Greetings,

-- Sebastian

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5..270c8c47d853 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -469,8 +469,10 @@ static int dw_hdmi_qp_audio_enable(struct drm_bridge=
 *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi =3D dw_hdmi_qp_from_bridge(bridge);
> =20
> -	if (hdmi->tmds_char_rate)
> -		dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SW=
DISABLE);
> +	if (!hdmi->tmds_char_rate)
> +		return -EOPNOTSUPP;
> +
> +	dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWD=
ISABLE);
> =20
>  	return 0;
>  }
> @@ -484,7 +486,7 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge=
 *bridge,
>  	bool ref2stream =3D false;
> =20
>  	if (!hdmi->tmds_char_rate)
> -		return -ENODEV;
> +		return -EOPNOTSUPP;
> =20
>  	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
>  		dev_err(hdmi->dev, "unsupported clock settings\n");
>=20
> ---
> base-commit: 1a2ab0feaa23147e347b4d4cb79cb3fc392118eb
> change-id: 20260519-fix-hdmi-audio-warnings-139062ec00b9
>=20
> Best regards,
> -- =20
> Detlev Casanova <detlev.casanova@collabora.com>
>=20

--jkxgxidvvfygd4in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmodakcACgkQ2O7X88g7
+pppiRAAnOCwUHwGAXwKknIc6RDWsixgxUqdd3h2PptUCxTZsmbHOoDuMsvS02it
ciD4i6wF0/9VeljJYQgEulE8fFlIAy5JF/S7b6+xusjQVNGH60q1+3l+PPKtlXcD
IumpN5EP9xq9DYOOsRpbRCjyoRIBd592N7QbxcWTZKL+hM/4fiQi/1a3BZM6K1xy
+LEVkiM5JY7kifxsddFnbW4b37nPSuT+1pznd4OQImGq0QRqD2jDUXIB9ivJjIrC
s8Z2ya29NahHTKqnurrXKlN/HRYYWL/Tw9XPVEGLUE1YovIxtsVVDYwRSI39/MjU
vqh0JaQZzwIUjD6BGOczdthn1j0S51Mwi4jMVB+auzKGUtAZWkx8R/jusFnqvxgC
TPDPTw2haz5ATjCW7STwI99BTPz08Q0UUE8Tt6mhTa2np0A8qI30GjAuEQ5RZ/OC
muAytgfezVfCEOfttXnSDWs1rK2EV4LpQSDrrfLbZz7sUKFMKEnESphBUZlQBaIM
KA9pXnfke4Ra0Ai9A6WT38WmSHz2y08f/KgBEFoUdh6bjwyENh51XDcgnz9ZsKpA
hxmRkG9pat/u8W6zOCNihcq4L1VYpyob/6wkiLxzA/c1rRaF3wIYJuDrktXTfWio
RnO/+HeBf+AbdyB2rs968CQWzg5FDqbr/abQwQQiq9kiRwgZwrw=
=hu1F
-----END PGP SIGNATURE-----

--jkxgxidvvfygd4in--
