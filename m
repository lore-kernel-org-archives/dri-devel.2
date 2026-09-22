Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A9AC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E1310ED53;
	Tue, 22 Sep 2026 14:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CguFkjds";
	dkim-atps=neutral
X-Greylist: delayed 396 seconds by postgrey-1.36 at gabe;
 Tue, 22 Sep 2026 14:52:08 UTC
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1AC10ED5B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=k1; bh=6+7Y
 wPssrYwwbcVyy1E2zRmvrRlDS05FVVsJW9+Xl58=; b=CguFkjdsvQ8uo+wX/xEJ
 3RiokJSXD94GoXAfVLjWKz+1uejkAw7kl4/1xIpbNhEz9+k8g68TzFsoi6LLucFN
 Ndwn5b23x97IbqfUJS6Ka3H72pLXZn/70hR4VEbM5/VqqBrypDjeacVP/f3C862U
 QWEM/koX8XX8b5wCCJBbcEyGr3j/76Lp52BWBC+xXj/jZb18FDWsHby8SdFNA5AJ
 KriCM4PWx7LxDc/OHgfaqQik8Web9Ux9ddtyjZ5Nital6JoZS/EUVbsnJuy5pRGN
 wavCkHNDjeGpkkALeScB5I6OHW7dAuPRkvR3oBxySwAhM494mYq744+2PmKIpyE+
 hw==
Received: (qmail 286476 invoked from network); 22 Sep 2026 16:45:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 22 Sep 2026 16:45:25 +0200
X-UD-Smtp-Session: l3s3148p1@0aq/ahNckKNQT+F6
Date: Tue, 22 Sep 2026 16:45:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: Replace __MODULE_STRING() with __stringify()
Message-ID: <arKUgQKr99Ox6ZIW@shikoro>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-1-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sgLEH0/VtwN7fsyT"
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-1-c18766690185@suse.com>
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

--sgLEH0/VtwN7fsyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 03:32:21PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

I didn't look at all but at some of the drivers (Renesas ones, da905x,
STMP and a few others). Those looked good. I guess you generated the
changeset anyhow:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--sgLEH0/VtwN7fsyT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqylIEACgkQFA3kzBSg
KbZBaw/9FrBesyOyyDUrnxlHP0bOF3BmqDAG1eHCb7OuWj1Wcqrh68l72s5PrP8Y
omafJO2i4E1dAJdffYG+gz4rfeaT4Kj9TJCODqKn6pB7cEFOj0Gk9Tlc1Pd3sNpo
3nNxwod06QpdI/1RpmBPR76rj+a0vaK8WM1j1zoARksJT0LK8Jrfm5d73Hoisng7
2iNk+ZkddaYmPSqgADJxlB+j3VUcWAIp4t/Q4F0c6+xJgA++OzbgOAvDLpXzi4Ae
zVzinZ552qM8vWVqf9RHbEz05NCRqlYewqsc6ZzFWcLHOcC9cE9nbgwH6qtd5qWU
LWqNdIl0WXDwSXi79NzvtqsAIXCMN814bx497Fbz4Xe4Sa3KBDkfUPv/JmmRtxcZ
BQxDPqXjxauBMrmarjBbr2fJy+6JRoJ44Fb3n3USWvZufXWhUbagITi8bfkE+ikP
6YriAOJVgsI9IQnTTUN5szRzPcFEHTM9N5qptkcwjCyWa3Z61/a2gmppmR4wwQ1l
Be/BD93oE4Y+DkKI3w3dWjyamEWcx+Hq9JYIMlemrXpGx5f2OZCIJNHFwvdyS02h
k8AE3H4VIwo7A/6UYTImr/JQAtwuUTyzcK54vyXsGAPSc1FhvXr+8zgbaR06nqgD
EfSNpsEVCbms7JBhxZphEoSYGUtYUwHE6x/Vd63n78pA5DJoRQ0=
=++bp
-----END PGP SIGNATURE-----

--sgLEH0/VtwN7fsyT--
