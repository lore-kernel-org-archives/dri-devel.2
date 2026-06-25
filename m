Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A7ECDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1EB510E19D;
	Thu, 25 Jun 2026 09:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="FS2ks8jw";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A205B10E19D
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:19:24 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49263703c6eso10945665e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782379163; x=1782983963; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ECEn+V2NhWD3Cl+wFoaowjzh5mZpSqtDy2oOQW/aJbc=;
 b=FS2ks8jw2gnHlF0ksmkAV3+FuaABl+YUDnA6qcsTIELaroYsoYuJlUh8G3FsZvq5jJ
 dYAYawETVSwA4lYCORlXqHPZye7Jc8/B7vNxQGvnXG4pVpOjIfUdXQYZmQH3CmaL7nMC
 1ojQGh2ZcbKR3EnAsK01CV5jdsUtLS/dGcFdJZsAuol2bas+7x8fTMGo3Ao6A7Q5HUBF
 EyGiLZYdbdgRFcxi4i8E2CN6foNib5ZxLNmTBKUKpRpX4+5QDfkmkRxLpCGIgy5S4k83
 TO0clZXiqNE9gNdbgcFKxfZtokUqs5jEkL4PAZmdmImAVKWTmfym43L8I9tcuIuuEC73
 qquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782379163; x=1782983963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECEn+V2NhWD3Cl+wFoaowjzh5mZpSqtDy2oOQW/aJbc=;
 b=p9KX3qdnaHYmHP1B27mG0iJbafHMGn62NPwGAdqeI99p1aUU9WXbPEnwuYcRyYTV8Q
 98N0suj1UpYEgUjnOwX8K7TcORj8tWN8bYvLvOO3mByCkigYRyNQPBDmLFDqYF+k6ofE
 ECiy+B6T8IHSFKM1A1GhjFej/EtRgXiTybTohIDL620Th4jcWjGjPPP6EMILOpyzRZyT
 bER2Qf5bAnFidDfUl+emDx4vZ6Aqjgl6p1GEwZQ+pbiflzQjFHl1oCA0qDzU/twt8V0K
 I/vMRvHtGiDAGWOTfU5c9X/pwSg4mC+CSoQdZNTDbxOB/JjEaL/1P1jENzAG1lg7nTYw
 dIFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SsxK+8crSNoL0+1xvDgKbw4+Zi30uQPVeD8JKVyOnArw2XwXN6lzEPVJvfBUOKbt8h/D7uT4wbXg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGcMzMWO943k6HxsGSFgPQlD1+i7injYzWiBcgG73iRl0Frr2Y
 eL/HBLXGNZ2bWiBzGOVmFTeWR+GSwC5Ui8ASfD3zw+DpaBacYd0zx79wZSgo9IkmblSFxH6D7b2
 RPXQzGoA=
X-Gm-Gg: AfdE7cnXFhaFHwEYhpctG6WFqTGpSZn1/ZlYJGuRMxNqvBHYBwY/US1o9XQdf0wFHm0
 vPzibC5nyrI5LikolvVOsXYEep2HFZbGI+KhSuex1Do28gIyo+hco5ktqaoCmyLHA7F9n6apRyc
 EjPhMbDO43vZpIcy/rbDx6GthYe1dgsGiTICYZx4aSQgaDrYHScxSVMcxdXTB5MJksfoi9LRJJJ
 m7v7cNsk7D6smnhWVgpUY45Z3pdDgDePozANplVI3zMYUxMXJ32FAbJDpS9uKn6cSIeFEUKP2sq
 6gk79zgJqu2ptoOc66JseiWmb03EodpOYDKixjuP88pNJBDyI0vm8XYSvkOoC4QpEXn6e9/KMeQ
 ZcuUES7wxz8H0fBm6ZAE0er/UJQbmJDqWqugrESI06kgsBKB9AttVK7luJCVVur1OmRgQs2h4IT
 1V+uQzr6ezRVl7uKiQrA==
X-Received: by 2002:a05:600d:8443:10b0:490:d32b:39c3 with SMTP id
 5b1f17b1804b1-4926685feb6mr16924745e9.6.1782379163017; 
 Thu, 25 Jun 2026 02:19:23 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49264082426sm60418065e9.9.2026.06.25.02.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:19:22 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:19:19 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, 
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, 
 Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
Message-ID: <ajzxLABtnWym81Dp@localhost.localdomain>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
 <ajBJU-Jp2QVy14qt@slm.duckdns.org>
 <ajBLAsNoKesXmFcs@slm.duckdns.org>
 <ajlUPmaMsa2gxOLg@quatroqueijos.cascardo.eti.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lrl2vho5y5eomexp"
Content-Disposition: inline
In-Reply-To: <ajlUPmaMsa2gxOLg@quatroqueijos.cascardo.eti.br>
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


--lrl2vho5y5eomexp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 12:26:54PM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> As far as I understood the patchset, it doesn't fail the write if it fails
> to reclaim. It sets the new max, then, if the write is blocking, starts
> reclaim and eventually returns after multiple attempts. But it still
> returns success.
>=20
> So I believe this is behaving as you would expect.

I was alarmed by the EBUSY mention similarly to Tejun but then I
couldn't find it in pre-patch (840ef6c78e6a2) nor in patched (v5) code.
Please make sure the EBUSY return behavior is not introduced
(essentially match memory.max behavior) and that the accompanying
message refers up to date code ;-)

Michal

--lrl2vho5y5eomexp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajzykhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AihGwEA1SCEBfnAwyeubLR7IllY
8xY1mJBt88wz9mCIeM9+iY8A/0e+2PnPs29VJ7kdk24/ZbM72Eltcu2Pv4++6deM
lMAL
=i/jW
-----END PGP SIGNATURE-----

--lrl2vho5y5eomexp--
