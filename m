Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3643F588EF
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343E310E6EB;
	Mon, 20 Apr 2026 16:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="dkyDDQsr";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD6C10E6EB
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:20:21 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48374014a77so42347725e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776702020; x=1777306820; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OdYPpUkMeCBk1OjhiaGOqWLSXmyMXptKmdQdv1p8ctw=;
 b=dkyDDQsrXFXG0QtFpqrMz/DJIyC5bw9j+uqawk2d27qeTKTDKz9WFK8dz9YtXs+UM0
 URiwzc46KnY0SVYDi2P/fgU3emb0DOi9nXNLOWyXuba1VE/Eh/Ac+jceSA0BnzdMR+pR
 3/gylSb+q5HBsg81Xokt9m4kKb0Dy29RQGcXx7Wa7wrw8BvmN1ChkFEiDGQ5NYmF2mtH
 9cRdbUr195CoYOux8W8DlKcjA1gTLAxGE1NeaBKAI8OefjEFVgGfEio586cCxBX5PzBf
 1FHtcLBXXmgUjNLYCdJeai3uCeohlzlN4pK569azI+qwx8DhDX7M5jF+Y5mL7rY2I+V4
 yLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776702020; x=1777306820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdYPpUkMeCBk1OjhiaGOqWLSXmyMXptKmdQdv1p8ctw=;
 b=DnQIjLoVUCIxhd/SmhcKukuSvNLCydUaKk0DAXBmdy/2To/6Is8ovKT3N9Ue6fQq7T
 tOfAQcybR40rEAbFDW9IrsuiTxWvmmP8vdc0+LfrUqUwQNPPjod456BphPhlBf59M0ZY
 6t3snDGGiREIN63H7JMgY0fVh7Kv5SmN8/GFGdAnOGW4DDd4EFnlwxokIYUpzCGISIXi
 A8OvCrZvtj8QBLXzag2HzMYhTxcrWKUMKz3oj65potnZNJXSZ430b+5P520DbTTQuZKW
 UgBhanoTIfFLBwc8oaDjDFW5iu9bI6VayGtXe0GLEGVZ248ozZ5VII399HaAkk9BUhl0
 Aa0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PuvNbu9ILQLVFYHFS8HNASMxKhvURpB26/AVM4C79YXmDZx6T+07OOM9dDa+Ox30FXYHfDQl4/Xs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCukvMtLyWV4ypgUPbXhwZG8uNRj1QvayPqBKvBCwwt7Hru8Fh
 wAqTvAGzQgeJTnkidLqB7AvCRv8sa4oldxiVQEmv8b/54Oagbuofc2/+pNBmRLnBIUc=
X-Gm-Gg: AeBDietKMeIXTa3FIEAf5cjvjiuBH7xNzWRybX6cQWA6bnSqrN28UzNrRqnj3Puz/jk
 rVoQTsQvHogT+MePEnUxvHOf8x7Omtp2s2Udk2Uuuc1J+OXNLYiUyBY5c06eOfqN06BuwYNoXXK
 tbt8A3Q/DXHGmtEeIeHSzhHytgCphMxdEdej+/U6Ths2TyKk3ClrCWF8fclJVh61YHESqZtDIfE
 BlseXrfAw8mMPdjAF/HFr4NP5Xmih5B53yJpe7qkdyJwtKVbhOTXupHj1Qp0gGneNFrDyiBjU23
 v871qzZO23eLO2djv0is9mC/qspS8gANUefX7zvbcuowCsSqbZoJTYqY5Gw5BMHQiJohggupH75
 6yaAWhD/1l40/SqMY63TI+AwT9AQpDTQVvlEQGAEdBb/Cje8n8ZjVkyJ+eBSUICWhGWTJGk5s7Z
 bkPOYn21mLyIEI9KLVrJ2jUvHTPXAtmzqHRXsIFy+S30xnhVYgXAJpEA==
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488fb78a0famr170297225e9.26.1776702020135; 
 Mon, 20 Apr 2026 09:20:20 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4c221cdsm30182533f8f.0.2026.04.20.09.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:20:19 -0700 (PDT)
Date: Mon, 20 Apr 2026 18:20:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Tejun Heo <tj@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
Message-ID: <p6cazw2amahycpvmim5364t46b7wrkw7quzo7dnsug7grlolxh@w7foqs6zs7wo>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
 <b099d9248df084fed8d4252e3c6fc485@kernel.org>
 <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
 <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
 <f1edec8a-f446-4fdc-b39b-1dbb690ff57e@lankhorst.se>
 <acVPnzeUS0jiUioj@quatroqueijos.cascardo.eti.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="23iuyz5d2rkbqv6i"
Content-Disposition: inline
In-Reply-To: <acVPnzeUS0jiUioj@quatroqueijos.cascardo.eti.br>
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


--23iuyz5d2rkbqv6i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
MIME-Version: 1.0

On Thu, Mar 26, 2026 at 12:24:15PM -0300, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> Is there any reason to keep the support for handling multiple regions in a
> single write?

+1
(I can't think of any. Additionaly, there's nothing like atomic charging
across multiple regions, so the charging side could still race against
the limit changes.)

Michal

--23iuyz5d2rkbqv6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeZSPRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai3VQD+JXDA1+znyDGKCvPc+cJ9
Jol+l1WquVsZ7KLxdCWVbFwA/27lAKMrEiht4cAqlLRcW/tsFlA2xU7fN0yVxCsb
hMEE
=3Xdt
-----END PGP SIGNATURE-----

--23iuyz5d2rkbqv6i--
