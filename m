Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60BECD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAA510E553;
	Wed,  6 May 2026 15:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="gmXwgwbg";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EBA10E553
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:09:29 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so93020175e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778080167; x=1778684967; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PtBGz2x9WQ+HNP+qaMuedUIcyx8fnxzRJan7d8nhIVw=;
 b=gmXwgwbgHIEWckwYemEyi4ImbubeIE6Qg491BdcLzs4qjlOHhMxyXhdsMyImb65oN/
 y23M8ebe6sbdOymjBuVdUKm9Qyf5o6LEvA2MMMjrFPoGCRD8PxG15YuRJhpgIjEkBjrl
 46/IgQq42x/iFnYJHNPQ0llyaz7v2nC13TNDAtHEUZgccPNysnoqvjh/mAH3X/YodJp6
 hUQX4wlKON7HkzwEYXLpwda6LLMwuaX8aCbqQijcL5zMXT9VpYlHjBP/kQ2D/SvN9CRf
 r0ltpEIcLLl6yFtfnTEehUj+RnH1PNP/cpXxjbPJV4iLJRk/DRH3aaaWpqf161Ugodl3
 hAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080167; x=1778684967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PtBGz2x9WQ+HNP+qaMuedUIcyx8fnxzRJan7d8nhIVw=;
 b=F+FwBKh6uA9tXGNdz+KWS3lyDf4L/9YZUIgklZWkMi1QLQwtBq+t2RMBy4P7l8VboZ
 lHS3XDEKR08wJ1aPr8YV2zWqOSOdgcwAHdVd5ysJmXlGgLcWbgGAuv1OpFp86UhDo1Ex
 kEaHU2xS5/oxkBXdAxm2P9v+PSu1H0eGFeHyxvUcnZjyVAek9Jq0TWluDZYW2+KMofMo
 TaV+DpfekN5N7N7IkRfSSI0Ov+tmek9myohAK3I37MH9ubcHyLKED1yGBUdSjK42Zocl
 K+UESRb8Mzhl54hTAvhk/k9XeJKy0IfZ/tKUMJ2vXzITWA+UyxjyySusblTA24oFEim7
 sNDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WrhArLt+TMIpMzQ2x6cPFPmYEdMCNn75kTiup30M64+cP1lU1pBb+3ndH4HQA7E4gnV//+CS+BP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBTHQxYAzLx4KhAcSfS4Qun35JyB4ujgoG8re1aX2rXgnRxzJ7
 k8vLWUmdRac8V8TcFZmuQsBE9pO4QlztvqkPkYsmvH+28S3gaegotqzuO+2O3H39u5g=
X-Gm-Gg: AeBDiesPMUNLji8PKo7dYDQsaDbvU7Fq7q/3K+nqWwPKkv+SeFwfl2zFNk2wxic+86S
 Aw78d71JCsw5A91dv19mYkbmaXOR+bYelkpmAd5lBpNQB35pXtc5GAwj3Gd6yotS9fh35RxnFPU
 utu6SxO9SMDr7kBdPO7yftqBwe4roxfRAVzgEj65+bamyMgTF/uEfrJKZH1ug+YGDoszIRadHSz
 a2fsmkypEV/mgzp60dYNmqPoUbox9m6ZNoRJqkYREmVki4RAAzUKiRuFFkzcHNKPNm/u3O6pPz2
 zqyMvypqOFDgk4XfndNk8v04ACiVSWFrVIi6z7qhZo1KbW7KpA/E3Z6wWaPNikmlmT5pltiL4TR
 x705bh15E1sSQ/wtPWCB1SoVJ8ymHpmlVFML8eVhfB07QhZ4YMWQWyUH8d/5a42OYnF+S9j+LZS
 8Kof9pt8spSxMxYRBJRMRoYd5JI2psnowrPtBP5Wx/iwDnB6ja9dklUVE8Bng=
X-Received: by 2002:a05:600c:8906:b0:488:ffad:6728 with SMTP id
 5b1f17b1804b1-48e51f46d7bmr49899505e9.19.1778080167469; 
 Wed, 06 May 2026 08:09:27 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm18475835e9.18.2026.05.06.08.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:09:27 -0700 (PDT)
Date: Wed, 6 May 2026 17:09:24 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
Message-ID: <aftQijvIHNZo_UyS@localhost.localdomain>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
 <aftB-cc5EhDXxCGA@localhost.localdomain>
 <aftNsqrv2sGPOPHX@quatroqueijos.cascardo.eti.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pjfnm2wcpgmp3gca"
Content-Disposition: inline
In-Reply-To: <aftNsqrv2sGPOPHX@quatroqueijos.cascardo.eti.br>
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


--pjfnm2wcpgmp3gca
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
MIME-Version: 1.0

On Wed, May 06, 2026 at 11:18:26AM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> I used void *, at first, but as the only current use is for the pool and =
as
> mixing different uses may lead to misuse, I thought it would be safer to
> use the type directly. This has been pointed out before for other members
> of cgroup_file_ctx. See [1].

That mail reacts to union overlaps and pointer vs embedded struct
allocations. Correct me if I missed your part.

I agree that having properly typed pointer is safer.
cgroup_file_ctx sub-structs are for generic cgroup files. But here
somehow a specific controller needs propagated to the generic member.

What about storing also the `list_head *watchers` inside `struct
cgroup_of_peak` and each subsys would manage it as needed?
(ofp->watchers =3D=3D NULL could also substitute ofp->value =3D=3D
OFP_PEAK_UNSET)


> I started with a non-resettable peak file, but as memory.peak can be rese=
t,
> I added that feature too.=20

At the same time pids.peak has survived without reset option till today.

> If we want to merge a non-resettable support ealier and need to take
> longer to discuss how to work on the resettable support given the
> above, I can resubmit. But I guess we can see if we can reach an
> agreement sonner rather than later.

What kind of users do you envision (i.e. would they need resets at all)?
Anyway, the behavior should be explained in cgroup-v2.rst since that's
where they'll look for it.

HTH,
Michal

--pjfnm2wcpgmp3gca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaftZoBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Agf3gEAnS3SQwtU72d+vybPMvLs
abYBuiDKjsiW+4zy1RFNTAwA/36oWRqQ1pjGEuPTFgTxHnl4+5Ls3E65Byjp41wO
W6cN
=obKI
-----END PGP SIGNATURE-----

--pjfnm2wcpgmp3gca--
