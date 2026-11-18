Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D960A2624
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=R/M15U1n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8104E10FD02;
	Wed, 18 Nov 2026 14:09:35 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C3A10FD20
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:09:29 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so5745795e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795010967; x=1795615767;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BuXYFaBcEpxxdVh263XmjfkKH8YtfB7LNGgPFFLmQSc=;
 b=R/M15U1nvxUa0QK/PJhWC26xXyoXRhjMDTyQ9NMl/e6kkrcRNCTMH7BN5+QAeqVdAm
 EQJdTQ0FaMITMwKRVBbrlU6P0uj5phusmnLEaPxmecUZP+bmzOLQb7qxTeL8EwBkrIeO
 udQZX4UBlyoIQyPRvsz3gpsLiMDQ5lzFqgKaL8wpZfcemHakmsSfcyoLpg7Us81wDPDE
 f2ubZqDlx5N7oGPGXsnR7oRdJwUgR50+gwn2cDbbR7xob0OB6FgewkBDloahh5akx0a6
 1+PNi7VyNLa0RitkZXwRts3EdxUyWlUAnZIEDtPkJ/AYobt48iSvuMJXATFzdv2oSzcQ
 Ns8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795010967; x=1795615767;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BuXYFaBcEpxxdVh263XmjfkKH8YtfB7LNGgPFFLmQSc=;
 b=mVbwTj6QRRjsDIoN5evUdXE7J2aVivdAS2Fd/FTvZauF14R5SmXubpN5GvHd7lU565
 00XJnL1SzQfGHlK+vfk+fegEZmaUprWEkKsk9Jko3AETkrcagStPtXGG2uLLcD3XA+DW
 ZvCwU3CASPiAULP3Ru1bJTInsiPLOoLPyTsQI0jcxibzFxo3IAgbM5nTO/8rFmy+VaTU
 EDspiYbqXUak4RwVy1eHkQWSrqpx+AKcbb4Q3z2mozrDBZhp6OhuEA2t6zi6QXJp4Yte
 JpkJKS2ns7z1Ntqevn8KTTYGqoIP4o8FnADP7/l0vGi8kkNxAF9p5IcxJQFrJbfm5BvA
 K+PA==
X-Forwarded-Encrypted: i=1;
 AL+hErF5RMfACZGtaIjgad2zZzlS9q6iwZ7jQgrZpb3jWvn/efSh/3jjWrHBSMOi1tTbdFL7xd63CMKJ8b4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Fcygq0o707qXeul4HKicUqnzDF7h+kpVQeyUY3/+Xl/TT03qq
 yLRoWqUmBcNsHDMuZu5JywnYgZAEa6Tr2befB2UkPM54KMIEcyj/PX/fSAPODRBTfVQ=
X-Gm-Gg: AYBFou053dAPAvc+dV2AuDBaE1Xn6RVNorJP5OdrydBNRFYZnjy4zxn0xIQNMxbUQ8w
 92Ffhp9PFUPy8QOhH2yTAvUwJii2LmYK4XXqQmyvShtVwiTbnsIC4DlSa9i0Jy87mh3sXxtkthg
 3koItIUKrwVWu/Ul4U+n8jjTBEy5ekhd5kpiBdnrXsqNWYzXBu2abcKF4LXQDFxPCxGLRlghUxn
 i5C+xMfPW9fjEO+zmnGelG1W7e5CGx9lCH6U7s2C4l6O4z+V2GH35KobrPKQa/5kiO2zRPu92ZJ
 Dt9iCMmE/QNgLTZcpNqpP5UvT8fM15DDLhlwfhDNapCZgEgu4X7krGgeqdbl0hQjUMLZUrstVZN
 2wPonCBteHdOJjAbvFxdo/NRWGi6U8lee+kkx/VW5ak0OgxGtnkR4zeo3SXByJtcwsuZlqppGZE
 zAjlACXOvOcMIDVlMJaIkfke8UJgnwk+tIfqexPG2iRicQ6cABX4bKKKHhobKbWzR2acTI5SMxj
 ONjrlTiFwYPZPyGJ9ceAtdznBwZGo8ctb3GpcdkpLISTH4QiEs/eWs159be+I+/Yt5R/hcOWpcP
 QWITVKidQeEuceLNh/peUebnWV7wCv2u0w==
X-Received: by 2002:a05:600c:3b1c:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb7da24a26mr52924905e9.12.1795010967389; 
 Wed, 18 Nov 2026 06:09:27 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb78422d2dsm209777635e9.10.2026.11.18.06.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:09:26 -0800 (PST)
Date: Wed, 18 Nov 2026 15:09:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: Re: [PATCH v1 8/9] drm/pl111: Use an empty initializer as amba_id
 array terminator
Message-ID: <av2w-YURTKRrWWMM@monoceros>
References: <cover.1795002467.git.ukleinek@kernel.org>
 <69cc3ae97cac70a5178befb171205bf6035958ff.1795002467.git.ukleinek@kernel.org>
 <CAD++jLmjGwCVk1+Q6fJweajFoZkuufGQg61Ksy9kJLTLhkDfig@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e26zyfnxaxmrnrlz"
Content-Disposition: inline
In-Reply-To: <CAD++jLmjGwCVk1+Q6fJweajFoZkuufGQg61Ksy9kJLTLhkDfig@mail.gmail.com>
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--e26zyfnxaxmrnrlz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 8/9] drm/pl111: Use an empty initializer as amba_id
 array terminator
MIME-Version: 1.0

Hello Linus,

On Wed, Nov 18, 2026 at 02:09:53PM +0100, Linus Walleij wrote:
> On Wed, Nov 18, 2026 at 1:08=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
>=20
> > Rely on the default initialisation provided by the compiler instead of
> > explicitly assigning zeros.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>=20
> Tell me if I should just apply the patch, I'm just assuming you have
> DRM commit rights.

Thanks. up to now I always declined when I was offered commit rights for
drm-misc :-)

I suggest to not apply it yet, in the hope that the series is picked up
completely by David or Simona.

Best regards
Uwe

--e26zyfnxaxmrnrlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr9sZIACgkQj4D7WH0S
/k6WNAgAmERF0vIvXVGoWfONLXbbVE7u+UB4/6/nFTR4im7HvTdOp3t/9OELhZ2l
DfJGxkhubjyHEdfEPvVfTpqta8R2yrQXuinyQbXdLYfW+IlAr9CDeZS9DkrOng9D
SINhxgpwRg5h1C0yVPVtp0TeizLO/GYU1hOKp+dXOhqodLFQTldtInc2gzi+BAeS
G2sKiDQGYjDcbHaBG902VuhLFGRE6OIIAoel6tVmYJ/uhV7uAH1MH8bjnKrJMnNv
I0jaMBapbGpu0t7qnixq1fpkilyZqhrWzc7r6LzFWWBy/8/9KMaXIZXnZrJUubyx
5kTixstfmm1/RhQYQZoGHJBMwG2FHw==
=RDYd
-----END PGP SIGNATURE-----

--e26zyfnxaxmrnrlz--
