Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A07C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C008F10E1F5;
	Sat, 18 Jul 2026 21:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="UJK5EPk7";
	dkim-atps=neutral
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234E110E1F5
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 21:47:56 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso2211641f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784411275; x=1785016075;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LSej48dHmbtGy45nBhv0MbNaCCnVPoeB1r++WlGI0W4=;
 b=UJK5EPk7c3JvPpNKaAdJWGZ7E0CRpaAo+PI123rDNhXXlEet3ngKjXX8fBloq6+98m
 XPWo+oLpaKhDGfxeiMXAee+c5OaRq4NHO9BZEFPt9mC9JYdHX7OkSmvmQQf8wAwr/pv9
 Gbb8T6Ons0P6NZTOZpEE60HvzS6pOWc2C6zfCs+gaAF+N0v/JGuaV6ubae3f6cyzgypO
 D88OGztgVxu0fEu9P14ScxWqKqCZC6eaapXYQ9ol+IS5Ei/zbhdiFcwUWxakn0yZbcCI
 pihzn+eB/r1UpQfopLPj+yHTOIo8kPsHktqlWN1LQ9A05TEJTH2Ets6/sVlWKFA8dWYV
 phhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784411275; x=1785016075;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LSej48dHmbtGy45nBhv0MbNaCCnVPoeB1r++WlGI0W4=;
 b=gLmwLX8y5WIj8FkhsFoYRVIjIpqw7d7/TSQ18AGQ6GLGg+vIhno5lVx6Y3rzVIwTAp
 0nd6kalCL4YAjzCnVS6asF9n5+lwXg6SiDsEJ6r0JWNaqurViqeZsN77Q8hGlc5jPUvd
 OC6xavggtu2zMxqtDO/y6g3cNzpXxGEi8eFRFPboKDPY9guZLMznP67BCdDHQaOjupob
 f8sHPPTFLmRZiYSK0Uk9pBxiFrziFZG3SbYT3zKt2gEcc4nVOAlUOcHLXFyxCW7jgsfp
 tavGjiS5Lpq7Wl4wZb7jwl0Z7zGKb0Oyu/vTDkPB2tlkXcylMXxRcMEVr0RbnwDBMDhl
 yWUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5vVIjvTRgOvjJN11/gXBrkdCLEUyut79e5d5BHXbLefTDjtZE386QQ9Mxu+eGPpZQy0Gj/xnUuCs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK0AusdPyfpI5l2eqtvtUvGoSKEdEFDgtkmwPMEAwqRlVSguyL
 Gy6BKeBx7hn6YdXnBL74nQjcAUvO/ZBQinnomFM/fcWsc9uPq8S0XraN4VnvPMxEvHo=
X-Gm-Gg: AfdE7clKNMuGkQCj20DnQvJ/G1Nqo3fIvL4+clORHSBQHB7vKMl6KV/nlRITjL80biI
 UP91WN4XcnwsQkF+8o+Q/npK0P3DTemnaFtwhf2t145LrvaUEJgzqY5QRm4q4CgOHFpFEOYZsG5
 q6lBqiprUW0AQUtS3X6IFGCrJJgQ1Kqbp8hdZ70YQ5TN8HtQ7dA8kZtGw7E1hBj5vQ1zpG1izQC
 zHl0DdDsvN4/1Au6JqusqZiMdmFOkgzayNNp0TGegE0Hc1xjSCIJwKj5PVAtiXmSh5lEd6DUw9e
 L4VwQwnimbJ6t//uSP/VRAzXTY0fnS/deLiQlHe9vLfo05+xzFAYPoqwG4cOG7Nj31Cvoa2AJEQ
 8/LNz0NRrUg5aWoKR5ydGbDuC1Zj0wLz8DBzfz58md1GttohXoKMVJJTy34QK4lwDQ64rlTXsoA
 tKT1ZzMQc=
X-Received: by 2002:a05:6000:2509:b0:46f:1b89:999 with SMTP id
 ffacd0b85a97d-47f5a676c8emr16623315f8f.30.1784411274957; 
 Sat, 18 Jul 2026 14:47:54 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f63eeb360sm16216646f8f.34.2026.07.18.14.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 14:47:54 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:47:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Kees Cook <kees@kernel.org>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: fbdev: arkfb: Move a variable assignment behind a condition
 check in ics5342_init()
Message-ID: <alvzxjwBr1gxu3Eb@monoceros>
References: <36d0eba7-e78d-4a06-95bc-c97d9b91f8f0@web.de>
 <40d5e392-3f99-44c9-b30a-3481f60143ba@gmx.de>
 <550584cc-863d-48c3-813b-3a0cb45d9084@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f3fkxfadp6qkpugc"
Content-Disposition: inline
In-Reply-To: <550584cc-863d-48c3-813b-3a0cb45d9084@web.de>
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


--f3fkxfadp6qkpugc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: fbdev: arkfb: Move a variable assignment behind a condition
 check in ics5342_init()
MIME-Version: 1.0

Hallo Markus,

On Sat, Jul 18, 2026 at 10:34:33PM +0200, Markus Elfring wrote:
> >> The address of a data structure member was determined before
> >> a corresponding null pointer check in the implementation of
> >> the function =E2=80=9Cics5342_init=E2=80=9D.
> >>
> >> Thus avoid the risk for undefined behaviour by moving the assignment
> >> for the variable =E2=80=9Cinfo=E2=80=9D behind a condition check.
> >>
> >> This issue was detected by using the Coccinelle software.
> >=20
> > There is no "risk" here.
> > It just adds an offset to a potential NULL value (which isn't then used=
 afterwards).
> Does your understanding of programming language details differ from the v=
iew of
> SEI CERT C Coding Standard (from the Carnegie Mellon University)?
> https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-stand=
ard/rules/expressions-exp/exp34-c/

We recently discussed a similar case where several people told you that
the "problem" you fixed wasn't actually a problem. This patch is in the
same category and your reference doesn't match the code touched here.

Please stop to absorb maintainer attention with useless stuff.

Uwe

--f3fkxfadp6qkpugc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpb9IAACgkQj4D7WH0S
/k4yugf/X7EoA2Tt7mChQ8eG4wWf3eTDK6E37TtKWLPT3R1witunWCOP7nOhxZc3
D139hRqc3qXlbwDBHpZTY0c+y7G2EE/7aBrnnhF73GmWLJaSb+CQ2WVCbUuMJ4kC
qPGNY/7HaxPwlylhjJSxmeBt1JtxWDy6qAOgR78JEDzCVSN9+aWL5fFL3SFQOJhR
OjLghlkWaKckJbm//CWA3NLVNHAgFZq58ozqVfTKmXKmKqvYH+iARxU8+V8jfPyV
nFaA9mHT7NuhT+oLzm6orz0tQTgvszXI6SpaGBxiXoe1gbvexg+4MArqV19Gb11W
7j6X45B9ImkYY6zrD6JK3heICJiHbA==
=5CWK
-----END PGP SIGNATURE-----

--f3fkxfadp6qkpugc--
