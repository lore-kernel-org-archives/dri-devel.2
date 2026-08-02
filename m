Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6FEC55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 13:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610F210E108;
	Sun,  2 Aug 2026 13:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PEFguoo5";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC10D10E108
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 13:35:44 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso4196645e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785677742; x=1786282542;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UlAe688FL5SqYvNdYPiubZv5Vup2lbXf0/HgRirxAQY=;
 b=PEFguoo5v+u6AhFcoWEDNnosgkR3KB/BThpN/fq1B3vc7ldW886prR3g80aWzBI/eM
 YhseyyNzDmMnoIQQuFGjAw3qYlXnZnIRG+aPYNRTfeMHJjioIC2esXel2n5vtdURgxy+
 eEyDxLioZPFD5kJGscuUyYD/vOXPdHwwT9ZpRu5fWOaVglIqsFKZsVMSFEw45EM0MIH1
 IVSxX3P9HPSdF3cj/PfNeHWvTAVsgOyTGLkmMuB0Jgz2N5kXlCM9I2+ZWWAeGDae0w2j
 VFQ27vVe5rj4ucwZCxb8YPeVQ/QOubzFZomAzSh8t4s5baP8fR6Dw/TcViWySzblMk//
 Adag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785677742; x=1786282542;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UlAe688FL5SqYvNdYPiubZv5Vup2lbXf0/HgRirxAQY=;
 b=gNd1VOlaGOtKtiG8hH2NhK+ZltW6MuT8g4ijRtpjNC49J0VEnLUJXhn+uGd0sVOpxJ
 GjRfOnGvDep8AdHYjCkwqDk6xyDEz/y9HJC9GqQ8MN/02V/clT8DENDZC+V2Uq8I9XiU
 IR8iejsx1xJzJuHWCGQk0wJT+JeqkPrhwxL5/PclFBdQlF/NEQfpNbmfPyN+pwFcZM3K
 xZHNaeTh6oeUCCCJ2A9WG/Y7GIPNMpxt5yq34yvj/1DZhyIQHMhpF9GwxbzDL9T9GRLP
 GZpQolpvmQ4Xc11jtLI2aQj1m0JHt+bu9AFRJHh6ik7L4+LJVfYyBUfabpuZJ4Z5zae7
 s4DA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqnqAh83gqm6UYig+/xQ0/1bL5DEhtqQ+VmQms/FrKF7EK8Ai2ep3nEdZfZ+W5H2mQFWCDJbx3lEM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6AViKfVrlb7lAF5pRwK176pGGEKh6eZYTwaE0TQ4H4LbUPazX
 yz2k6yPbpcnAdIWFjapH3wtK6gztGEFN+ILfOs4kbbdTUmDhbbVUO8taDfex1lFrpm0=
X-Gm-Gg: AR+sD10gIYdV6eKX1Q+rDGPpLjLv3Nw0UTu73kA+EXP/o/EoS2AWIHuqaf8GxCQWFw/
 G4XQZk84V5+VTkJrXpbn+2I9bNElKFphBA2KHPz4GHE/vOpoK0VE1a1890/D0NfmsOWOEeS3mlh
 sbb48QAIU5A2qcVFw17KNNehRnRvg10Luyc0bIzZ3TgxyZB8FDw7BLspv0dwsDrf60IC/ypm5rN
 K0wr/kZZmK8xm5mCVpv2VWL44GfeIQjw1XK0zmgIbL1A37MnlgltFlU91/09woKBX3FOQtHCtqx
 3f0DwhMtFunp1XJmxePX0ffoqIEHMCkm/UdwYC+pqWgWcy2h/hDsTaYlvXcV31NnN5VihhL73Lf
 2qBWEVsBlbMLv+LveIXVHLxsx6sD8ArbPih+CFq9u4zE/KFMghqAG1aGszDJDSHZY36WaplaP+U
 RzzA/Q5mc1HPCKEvB8q2L3egfTB+3rSOslLAj+RUTwG+HH7302fDyDroEu3fOj1KZleQ==
X-Received: by 2002:a05:600c:3150:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-4980eb8c4c9mr97559055e9.3.1785677742549; 
 Sun, 02 Aug 2026 06:35:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4980819a030sm144499215e9.6.2026.08.02.06.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 06:35:41 -0700 (PDT)
Date: Sun, 2 Aug 2026 15:35:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <am9DGQFk6JfR6bXl@monoceros>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6rrxlhjbsv2gpeab"
Content-Disposition: inline
In-Reply-To: <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
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


--6rrxlhjbsv2gpeab
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
MIME-Version: 1.0

Hello M=C3=A0xim,

On Sun, Aug 02, 2026 at 12:01:58AM +0200, M=C3=A0xim Pedraza Padilla wrote:
> Uwe Kleine-K=C3=B6nig wrote:
> > My 0.02=E2=82=AC: Usually you want to use the display using drm and not=
 fb once
> > the machine is fully booted. If you're using fb during boot to display a
> > logo, it's hardly possible to switch to drm later in the boot process
> > without flicker.
> >
> > So my recommendation for your usecase is to not use the kernel boot logo
> > stuff, but something like https://github.com/pengutronix/platsch.
>=20
> Thanks for the pointer, I did not know platsch and it looks like a good
> fit for the problem it solves. It does not solve mine, though, and I
> think the reason is worth spelling out, because it is not about how the
> image gets drawn but about when.
>=20
> These are industrial units, and the requirement is time to first pixel
> after power is applied. If the panel stays dark for more than a moment
> the unit reads as dead, and that is a support call. Anything running in
> userspace is by construction later than the kernel: it needs the kernel
> booted, the rootfs mounted and init far enough along to exec it. I can
> measure the exact difference on our hardware if that is useful for the
> discussion.

No need to wait for init, the idea is to use init=3D/usr/sbin/platsch so
it starts before init (and once the display is setup execve()s
/sbin/init). Also you can put it in an initramfs which gets rid of the
dependency on "rootfs mounted". And if your kernel is modular apart from
what is needed for the display the time difference between kernel boot
image and platsch might be negligible compared to the simplification of
the software architecture.

Having said that, I'm against putting boot splash info in the device
tree as the pointed out alternative is IMHO good enough. But my opinion
probably isn't the one that eventually counts.

Best regards
Uwe

--6rrxlhjbsv2gpeab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpvR6YACgkQj4D7WH0S
/k55+wf+LNETFlaOPhwExqKupPUo/OH39ybKdaQJ9uAkqBo70lHb+Xm37TY6D1sa
P6+sFxOwFR6mGxWni4QEila6hAYHRNzqqp1o4Rl8mpnPTbG6vkJrRaT4vFCnOie+
6Y+yocUerh6JqqjAim+X+SGrIjaJ/54KtfaQ6dGBUxGFHr0q/pThdXedHep4ZcB6
viwOGBykkKZpx1gNKR09GiA8PlxG00jkAvA9ay3cvlzMg7zwU0nRjjIDp1d+lo7K
ef908NB2SG1R1TNMBEYy9T103E2VidGZ7bA9NsIqYLiCEGo3z1smJcAVdaXl1iTy
hyLG+z6x2P06fk2+cllcwxaOEU/dXQ==
=CFkM
-----END PGP SIGNATURE-----

--6rrxlhjbsv2gpeab--
