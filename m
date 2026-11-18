Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2C606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V9nauUfo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B15710FD9B;
	Wed, 18 Nov 2026 15:15:19 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD2110FD9B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:15:12 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso565306f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795014911; x=1795619711;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NMyCaXf5z5oe2JRwa4VbW5PgsfLFNCTM5DQAiHr/6xY=;
 b=V9nauUfo84MBJzcidGGXiUX9CnOWKaYTHZ4VUxdMsddopfVovoUMcTAxoA6nylsb8X
 JydHm7KymsJ1QMxP5c1PzvsqVyRVAxqiYa81uIjAyypz2BhjJUKP88PIju1S0QzIVmOj
 3K/JARPrhcwAzs6pD0Asxh9WhFjyiiOF+h9weymIZnkK7PGwKVe/5rD+e2/0PJEPWTOM
 ineLC05a849W6WrT8NO+mTXiNTFATe2NkuPlzaN16ybTlKcQNa8r4rBO9EHV2ULYOhA/
 lPxMYeLFnAMe6WR5i+rNsYDnwmcwez3BA4JBgmPosH6PSbA+RTeIqrGeiu10sixTVFZT
 Irbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795014911; x=1795619711;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NMyCaXf5z5oe2JRwa4VbW5PgsfLFNCTM5DQAiHr/6xY=;
 b=UvvWXixA5TwEY9G1qid1//07bIMCSl1S8j9EELbanuMzBa11oqNA92ZSDYEInau7FK
 nElQgdPOOnvCubUoxT0vVESJtbdhPimaIolFWyQI0KkJ9m+3E1jWAOGdIGMGJiHXpyRE
 OWpVIZuiTHPrTc/6KBluxrwDvqIm06ZTJZAo35HzehXIHyVdm0RJOqWcb/vHqrTjaFw1
 a8dXtUsJiir9jFieeS6py7v07XfOdNbc6lSa0m3BrMFCbx5EaNEFkmd0dS6b9nUvgIzA
 IV350JmDhnQlUa3oYskA1RypzO8dePfsIJDMKm10BIG2Upcmx0JedQfHaRXlleWRjgeA
 XRDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHm0vpapkSmspXts1io9ux4Ksukbh0kjhZq1BTnR31xain+5m9z3fyEfv7RLQzivL8nQIwxqBaP6mQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/IoXUnczFCMpjzemgRK+AMHMYdksl1KRw4/oQROFKuAEP+1YgE
 CMcBVOpr81Sbw+Fp7DOlLZHD3swSkTFkcXwfyIt/VqfVoEVKB8d5kfMpLYNZXynsZoE=
X-Gm-Gg: AZFdTZf3EiuLsyxLanvZgoEgDBAz3xaohkb3VLw0rjIceCqPM5FB31CyQw/zhIxZO5p
 EMlUWK5CYLm8Il1jZRitc/7Q1+pIPlEXYY0dJWt20T69hmwWzX4mMilDkgratdjirJKAAAE6f1a
 r3JGVvE8gIvhn+h6mdwOoNgI435pgHc6Wcja89AiyU9DnCt+PAbO0Q2Hwkjk0tbPSG1HmZ2g5h6
 Bu69gql3zL0ET8fJsztWw3LLiLmYHKXSemj3Kbms3z+Eea4NNEoU47BdgT40fPW40o39jUpjFuq
 gh8d7UvFgB5U8ykso89oAWq7XTiF+z+OxtvmAS0sxrLXPgxWHHOWbHps+FaSCkwMBXFQMX2QgP0
 BUDDE8S/hSbMup3QWy6rlNMNwp8eDEd8Rjfd3PYKzoftz0v0zIpnuvAYE8Up/RUS8UmjYCEjjXC
 6JPj57Bs0N4XkteqAiugXQFfRJtDjKx6GHXCVTFRkjCeX3bJzzHbIoPQQchf7uCq2e3JNAUJ4oK
 +Du01n9s4khpA72h+Eia9VQhOy3x/ortO2hZFZa9L7CeY76nQ08NsU/DkfIxfV0PzYz+Jajfr3z
 fvIKQYZ3nyyT/rQsEiOV7xdosVU+ApdIf/fpE0Rtx7A64YcaNpxXZHO8Sq4NFcfqA4YAodyVvmT
 lUDswBjuMv3Hddiau
X-Received: by 2002:a05:6000:46c5:b0:48e:6357:c76d with SMTP id
 ffacd0b85a97d-4a63d2cf09cmr4070440f8f.21.1795014910678; 
 Wed, 18 Nov 2026 07:15:10 -0800 (PST)
Received: from localhost
 (p200300f65f19a904f642bba75325d003.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:f642:bba7:5325:d003])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4a6575a5c28sm5424703f8f.59.2026.11.18.07.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:15:09 -0800 (PST)
Date: Wed, 18 Nov 2026 16:15:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] drm: Use named initializers for arrays of
 i2c_device_data
Message-ID: <av3AMIcRXCy7PxOQ@monoceros>
References: <cover.1794386771.git.u.kleine-koenig@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yqlhfm52kcn3z6dt"
Content-Disposition: inline
In-Reply-To: <cover.1794386771.git.u.kleine-koenig@baylibre.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--yqlhfm52kcn3z6dt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/2] drm: Use named initializers for arrays of
 i2c_device_data
MIME-Version: 1.0

Hello,

On Wed, Nov 11, 2026 at 09:49:43AM +0100, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> v2 is available at
> https://lore.kernel.org/cover.1784545092.git.u.kleine-koenig@baylibre.com.
> The first patch of the v2 series was applied, so this is a resend of the
> two remaining patches with the collected tags added and (trivially)
> rebased to v7.4-rc1.

This series is superseded by
https://lore.kernel.org/dri-devel/cover.1795002467.git.ukleinek@kernel.org/
It contains the first patch as #2 and the second as #5. (I only noticed
now, sorry.)

Best regards
Uwe

--yqlhfm52kcn3z6dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr9wPAACgkQj4D7WH0S
/k4AhAgAoL9dnbHgbbj8R0XrasdtXwSZVvDr8O01kZzWsXqYjwvs7LdZui2+YlsN
SkiOdu3/FT2+Gh6i0J3OqqX12WBliJIgrYx6zY7BFQeKrYTM1WLkGQuyp42IZp+A
ppLIuB/v0oaI/GNGEBkaNCIHFN9oOkIBac3jJngETehLC2ryvpWGee6tLhONicwh
whuVxHfT5tP7ghp05rH3XP2KnElh326S2eO0KOpiJkADAWmzqNOCkN7wmReFW+Vx
SPYjcuT+4QJBUm8Qv6SuMDL+QlPoOjBZcw6TgIAxWU3sCjR57xcSiCDTbldaSeJg
4sepDhgw5sq6F2F7Dq4/sEiPzbBvDw==
=1snT
-----END PGP SIGNATURE-----

--yqlhfm52kcn3z6dt--
