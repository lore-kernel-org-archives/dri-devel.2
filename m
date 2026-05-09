Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E380CD3445
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 16:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2472710E3CA;
	Sat,  9 May 2026 16:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iEDCqhqV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D432E10E197
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 16:01:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CBEE360120;
 Sat,  9 May 2026 16:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AB1C2BCB2;
 Sat,  9 May 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778342466;
 bh=RGetAZVR5W/l0Zsnr/kYQLvvPTBdNxC5bNYVlWymdhQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iEDCqhqV6kjsB31UJ5E/es2BHorRLdzgPaMid3VusVvSbsoGrahg1qwj6rCnVoWYJ
 rs3U1ylgFZiBGUwLuhf61CvVYUXvEw/oQKslxNMHm0UyMImphHVv1AGSvrfHIANeGA
 tWleBImoey1oLoZYYgJXhiwr3UIXgWpzpg1NmnsgCUiyxR6ZhN39QLS7PX6zAKqvLL
 agMDFyAuMdyF9O/7vm14WGyziGkVR5avHcLSdkHEG2WQzII3fwTTJfZQuyf6hkQiki
 i1w1flJu0fKaA04xed2GlX25sAcRDW9YEqVvJjB5P/dvqnQFWvy6TnFTtuM9uz3rJv
 7vF/0F4boyJ4w==
Date: Sat, 9 May 2026 17:01:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display/lvds-codec: add ti,sn75lvds93
Message-ID: <20260509-tingling-squirt-4c0126c9e729@spud>
References: <20260508214444.255992-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9g5u3xAR5F2vWSMq"
Content-Disposition: inline
In-Reply-To: <20260508214444.255992-1-Frank.Li@nxp.com>
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


--9g5u3xAR5F2vWSMq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2026 at 05:44:43PM -0400, Frank Li wrote:
> Add compatible strings for TI SN75LVDS93, a FlatLink LVDS transmitter to
> fix below CHECK_DTBS warnings:
> arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dtb: lvds-encoder (ti,sn75lv=
ds93): compatible: 'oneOf' conditional failed, one must be fixed:
> 	['ti,sn75lvds93', 'lvds-encoder'] is too long
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--9g5u3xAR5F2vWSMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaf9aPAAKCRB4tDGHoIJi
0tXlAQDTJDvyOSOUE1Io7I5H3lN/+TuzMeZQuwmNDDgv2Q4p4wEA2oGdTkq+zc3N
AuOKpz8WQ7IG2jwNy5ZLVxMtPFU+fwA=
=OvgR
-----END PGP SIGNATURE-----

--9g5u3xAR5F2vWSMq--
