Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B8CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F64310EB0F;
	Wed, 10 Jun 2026 17:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Vg/O874s";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D744210EB0F
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 17:00:41 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so593785e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781110840; x=1781715640;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hit/Mlk9D4kEMW35JlzezH50DQnrNYzjvS1wHLUgqto=;
 b=Vg/O874sfnU7/URZ9OhSrjmxbDPyuzPEintO7pJ5ZJoEncqfnDRjZ5FBQdpt8KLimm
 ZWw3Ov/65AIMDWt1mvYBGiKvORTVD7ocw2g8kjr0GCKR4wZySaf6Ml5TD+rKq8VfLu1A
 mul9YJaUDNqDmn+sSnfdb6g1lpj6rZVCtOYTUE7t319pGJOm0s3ihP7EPrHM6GB/YV3Q
 F1qJWUydtOKpN/RXimCCrCPgfwkrYEeLXIz2gOJXeRBXtpmUh8qy7/jHm3K8QhZylMqb
 v0dcnN7RE9/dfOJko9BRiyXOmja8zIve8Pd9DkH/WkvaE7tuq72EPJdqt0KiveZxlpYv
 Yy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781110840; x=1781715640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hit/Mlk9D4kEMW35JlzezH50DQnrNYzjvS1wHLUgqto=;
 b=fQ2tRn0F5V/nHbqDxkq4McelkzQMYZHlE6Cr5/8VOMO6rEJp0T5GhsQAQYBM4LmR9C
 DDN2UE7Y8Ji9SoxcQfqfGVeePoHdT0EljQ7m9zsxsmU8muQ+MMXWkDz93btfTdtEtaHR
 z49jLCwEKNsI3XxOLJK30OKbbh+JysbIdwNf55d5pV+mczq0xdgnReWO0vTQuJ1dDTza
 dA7jxYPQZHlw/zhtnngjtKPsIBnNKOXqpgUXvlM5CDWh5kBqgMaGChoxqkYR2lLlLtsd
 eiisoHEDolA5kSFKU9s8npEhBYFOhuhGccN8h3ncsyVb6JctjUqUOX0ZwH+6plxXgtnT
 9Wyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9clSmEG8kCv3qNu7rm9MMaqpQk1Q9Q0BXkZu3BbtS98aRo92VziS67OpSVGIBypcLSnYJC0Cz9O3k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVKc/vGxeYMQyyo817ryc5dv7NOfE0IDEmKo8ODagCMkkYHzkL
 8yBobazM+w/Ee9KO9ao95d8BHjzb2rjmE5CVBHC/eYSxx3p3hadV/0G/YT/JlRwOZQ4=
X-Gm-Gg: Acq92OH63y0/s4gVBGkrXFbC1DZHE4d6ZojaqxDSkmMadYrwQZmJ7NSJ+pNR1TywvZI
 +9qlbZU+NMTJjJowCNTyG92ja8Os0N0bk5+kW/jzqIKOyXP1IamMswUVkSN7xjveRjKTf/CvwrG
 XGUMJXR5Tawi0HamkHQALcLESSzOWdMUf1he+i9qwZZbtRX22+1a+YtKTgdbQHbpASvEzJpn1Yt
 32gCqxMmzJGyMMO4FsCHoWMIT9SGXpLy5wyyio3niT9rm2qT8CK9AJsJ/Q8xak4BBfCfVz2TmpI
 DHSy2JrO/TZi1h5BB17ynPjrWOHHLeY2W2YLxEogZYDWbP/OSGmB3GvuPwkeQ+I0FqyUe8jp8nI
 KlRzQsPgfYCsUygHFVS2VTEViCpiV2BxJQf8xESGYsLBtRhAY73367M8Ow9dLJ1VU+QzhQzFubY
 1JFVtX8naCWJhsPXSZTpkF6QOqAlxKR0qak5yzC/TknNi/GWVMBr6kbSKKe5VC43X+9C+aO40/Z
 b6Fx2PcbuOZfj3o7ZoghIUQ0w==
X-Received: by 2002:a05:600c:6388:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490c2d1412emr330389635e9.14.1781110838915; 
 Wed, 10 Jun 2026 10:00:38 -0700 (PDT)
Received: from localhost
 (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490e2aceef4sm1699175e9.4.2026.06.10.10.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:00:37 -0700 (PDT)
Date: Wed, 10 Jun 2026 19:00:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Zack Rusin <zack.rusin@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Don't use UTS_RELEASE directly
Message-ID: <aimYDEBUcPIuhUGF@monoceros>
References: <20260504073422.1130008-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tqzyaztcmdnpyqs2"
Content-Disposition: inline
In-Reply-To: <20260504073422.1130008-2-u.kleine-koenig@baylibre.com>
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


--tqzyaztcmdnpyqs2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/vmwgfx: Don't use UTS_RELEASE directly
MIME-Version: 1.0

Hello,

On Mon, May 04, 2026 at 09:34:20AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> uncommitted changes in the source tree or new commits). So when checking
> if a patch introduces changes to the resulting binary each usage of
> UTS_RELEASE is source of annoyance.
>=20
> Instead of using UTS_RELEASE directly use init_utsname()->release which
> evaluates to the same string but with that a change of UTS_RELEASE
> doesn't affect vmwgfx_drv.o.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
> Hello,
>=20
> an alternative way to address this is to drop the kernel version string
> completely. But I'm not sure how redundant this really is so I chose the
> init_utsname() approach.

any feedback on this patch? Ideally something like "I applied it for
7.2-rc1, thanks!" :-D

Best regards
Uwe

--tqzyaztcmdnpyqs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopmDEACgkQj4D7WH0S
/k6BawgAkHk3FrAgUubLJrLmiTpgHkyYXquXl70Cy1iTCMpS6yowo0bz9x0MEdQf
aR6EKIefC0Cr+R/pqLpfnDeitQxlppPIOt4iaIgAxFHkkJVJd6FwkXG1dkK93ZPZ
GWLODUjFrTYyvZadkrOguSNQ9Hxsyp5Pg+VVpaQJ9RsIuxmhZ0Ig9LsjifWLqXEx
PCPNll9bPT0TwD6GRpqqAwAcI3K2T1aPGwWj3cyxVHM/O1LDvGIl198ZezYngr6H
9LHQRYMYch572gDYibTUBDlrIha6Df/o0FLRKbksfjoYoH2Mg0Dqy+0j2y0mhZc7
YqirjZrtTWlpAJj8wJjrBBo+jgD0sQ==
=kXpp
-----END PGP SIGNATURE-----

--tqzyaztcmdnpyqs2--
