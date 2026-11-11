Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95F606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mXUKobdr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC86610E117;
	Wed, 11 Nov 2026 09:00:54 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C148710E117
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:00:48 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1769744f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794387647; x=1794992447;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YwnkBq/sQXzLyTa3e267V+Hfsvd2DxUq3BpvzIujRj0=;
 b=mXUKobdr8nwmKpzkDHO1h2XKXTMc91QogytMW0F/7117CjabdDDh3E9sgO1YyWjBBz
 c7b5EuSE7fdFuIeK3BhphZZWBhZ5Ok/YhcbpjKB1e6ToWPOBQtSfzSlsKc7rzXsn/wss
 1bjVL6KeJZyA5Vy8QjSZ6krNxlxenVODrWtycKfEgcVOdtYxYsoAjhkv8C5Fd2gE2Y1f
 dX8jZC7Y81qVr2yFKGh+z4SMqhqb0id/ikfmkDLYilyEld/wF5Bfx+pRznPye0L0lxWH
 6nHe0TkvTtAjsLfLZYe8tHxx0sF0rRZLzEnXvK7+UJgy12t/LnKjG0+PgbzsJbYogYEW
 2hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387647; x=1794992447;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YwnkBq/sQXzLyTa3e267V+Hfsvd2DxUq3BpvzIujRj0=;
 b=iZ+6uVoO5R6BWGR7nY39ohKJR0vMOWryJxptPJ9swUciycG8mquPW50bW3HqqEL0C4
 Q2zkIltUSa4wNNjxNMfybDRJwB4SskZOUA0fiObU2bvaEIMthXyweTU6gd0AS6aKIu+u
 KX6WQJ//04kd0EMxicaNo7BtYdNcfy5wpE3Jj8yXnGjj1gbkZ9wJhGdIPpZRdmZoiiYA
 0EWcBDfSKzrShNPJCBX6DqYJlk9D9w//ytf1XnizOm58Um7Q5IMcAx1NDqPzQ/qVZKqC
 7DjwxSAs6HKC3uvptuiK8O9DZHlcdo2ULeESCrnZOdBA/nrteoITqIxkOaEvSYW3Naqk
 cQFg==
X-Forwarded-Encrypted: i=1;
 AL+hErG4GsC5bneCxPIJLYrCXWQmF3LRxn4316KWh2clgOMEcbvY5DNWwH6oJPsiMh40+d9uzdEdrtELd28=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9UbZkrWkcIXEUtjeyTQZSxF2aMrI6Y6hPufskj4hI8bmHh6JLB
 JFq82iOODrbfu6anluyW5F0Ab135y6lc7QL91XnfVnuohjNRcnjnTLHhsl+23nCLkbAqmv+5Q4o
 /GJJBzF0=
X-Gm-Gg: AYBFou3f1+Ka/KL9rfSGV1BSGBAlqqR/ZqYtwukoGswksDVM9DE7Z2UXoofokuIX4fM
 ZQN2nhYifNCXMkpqQvRALtob9s6fMC85wwFiMTVitwtfjQHEb1I9VB3l/wMZ00XpDp6y985Ki32
 q/bSI9qCrUPppk1yE/FjLNCmTEwxvoGv+Mpo5tSMPxHGa5GhgcUtzZpnU3NyqTAV7W/7ySRT21x
 mG9+dlnEemDFGZtHHNt1mkGNiO+s1V8rgA4hjF/YQRa2FMeuKRPkfoKi8qavmLSqdU+RxDKdkYl
 wsel1cQmITV19o0mgygtNEfmtLr8aQIAZlmrAEcjMGoC+STbdAObOZmxgv6lvhyTghd9i5xuS2O
 vhXTV+J8sWCfFjCoXgf9LMPjFiQL340JU2LKr4QgEob9famz4WN4xnDN/KbdrlKkcOoK/YtcvOM
 pemuiNZZPf9SGKEfeKHvuPeMRHZ0l0QQweeYwsi15pFizyxTVPEnIQYE2OHTvJzM3QNijJw+JYi
 QXdX870BOvalynA6sxGx/hW744fqGdgXbdAwahqECRm8imm91WJ8Zfzu/0fAOeu+h4q8+9VVv5b
 Ns45ouzV4Pp74hmaZyMZVwSifRrOMjETY+A2LaxxJGuJw/yvvYS/eS4zSG5hEBwQHwYP0UjBK0p
 ZwNOMKSyE9Ve1nw==
X-Received: by 2002:a05:6000:1a8d:b0:490:369b:f50e with SMTP id
 ffacd0b85a97d-499c5e3c18emr2760492f8f.19.1794387646810; 
 Wed, 11 Nov 2026 01:00:46 -0800 (PST)
Received: from localhost
 (p200300f65f19a90460510dd506fc51af.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:6051:dd5:6fc:51af])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-49835858f26sm10111142f8f.18.2026.11.11.01.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:00:46 -0800 (PST)
Date: Wed, 11 Nov 2026 10:00:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Don't use UTS_RELEASE directly
Message-ID: <avQufBv3rTXt6Qvj@monoceros>
References: <20260504073422.1130008-2-u.kleine-koenig@baylibre.com>
 <de7acf2e-e07c-4a94-92c7-ae0c9311c8a5@broadcom.com>
 <al0N1wqMD-_z8Uf1@monoceros>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jhq54vmbt223qxdp"
Content-Disposition: inline
In-Reply-To: <al0N1wqMD-_z8Uf1@monoceros>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--jhq54vmbt223qxdp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/vmwgfx: Don't use UTS_RELEASE directly
MIME-Version: 1.0

Hello Maaz,

On Sun, Jul 19, 2026 at 07:49:26PM +0200, Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub) wrote:
> On Wed, Jun 10, 2026 at 03:04:07PM -0700, Maaz Mombasawala wrote:
> > Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> >=20
> > Sorry for missing this patch earlier. Unfortunately our maintainer Zack
> > is out for two weeks so we'll merge this patch at that time.
>=20
> You're saying I can expect this patch to land in next around end of
> June?

It seems I could not. This patch is still unapplied =F0=9F=A5=B2

Best regards
Uwe

--jhq54vmbt223qxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr0LrkACgkQj4D7WH0S
/k7xywgAoFiBZrmixZt1cJntBcFzf6F7Y/OG9W2YC9N7bnNGlDP/9xzRto6i/vTd
D16ck2HLeqNQSwjlGmhoeFysUbRopzDBcbl5PLPJZRvU2rVgc7jeR9MlV455Q211
BOLga84ViCisAH9T0WQbUGK5tNxJKZaHRqHfowHKGKWaZYPKKOH2QJx9mtq/rgAl
glVTyV1nrCNE+JeUUgNcxGQqfJykfPCbZAGbvtfSzJSwt1l8FWOIhLUclh66QeGU
s9BUgiJ/4eVEjMDdpMQ3hWB1JM9hDjASjHSGwF2GhdC0EfvWfJ2QJM/C/be1Cgcu
tUt7R+jebfIPYdqIslBq3AE0o3lSRw==
=0ZT8
-----END PGP SIGNATURE-----

--jhq54vmbt223qxdp--
