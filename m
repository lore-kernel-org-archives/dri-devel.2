Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E48F588EA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F4F10E0BB;
	Mon, 20 Apr 2026 16:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="gWyO3qn8";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9F910E0BB
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:16:32 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488c2690057so32262165e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776701790; x=1777306590; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kKz8O8Bg6tLUv4xMMvhQo3UjBvO97yFHrMS0cTqMTEI=;
 b=gWyO3qn85UKt5dzITcaRr0JlmWycce1rb4uDFohEG6sMFH2BX+G0qM2NmMfryHkv4G
 RJnwZPnbu18Cq1QvwtSfDr4pa9MquwQghiUVxXISaamX3YcxXNtCR8pCgYW7Tt4KqYex
 UoAwEysD9VKKvlpvIDzbzPkpePIyjc0LfFQqP4xtM+WXjZjqq8DMkOrfOzAChEp23vU/
 io4KAXwMn7wXiVOD2KRR7CkAdLakpRT1jTFLOOVnHyNBY+fYUmOX6OuWAkqK7Ejqq98e
 CwQ3cUOulcdyeoPkRKdTtw47rmyQeLOba859JRaN8kSF0Vt6ZrevQQMwczdtcLE+8b+i
 Dd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776701790; x=1777306590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKz8O8Bg6tLUv4xMMvhQo3UjBvO97yFHrMS0cTqMTEI=;
 b=hQZbaDquwv7x0qIvgIjz+cCOTGYmoYe0cmAkt5RIEZr6aIiNVoP00Is+Z3ssPkhBo2
 1v9/jCpzJxuPqItnhO3P66Xo9YTploFFNXrRyPNVp40b0xyEENQMYOdvXFYTTdPMx5TO
 PUXJ9sUM3deQKpPZXVXpBlHEWuUfF6pHWPf0IzGgBBbyakObjLkgdvyGqpuwF7PnP2Di
 +lR68K9QVRS6aokKPGuUqhnjfgvo+QAzdOMaOPv4J6tNCaUuaBTZl/TC3Yih1GaM48br
 lTCGAd6WFG93oKff3GM30ATzeUJzPF+JMDqbKcw5uR/89RtjrNaNSDBzyMC92Ug42NY3
 91uA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JxUk09PuWP6/vJcrSqaqyBLEHfszANfn5V/S/ytHnweGH0iTZuWu1OISVgQJr+84RKyaPgVTKiug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvMCvNJki0d2wqbLIZo2E6p+mGEGPAiQoHRIXibyrCO86dmXRT
 2rFJn4s6Fm0mpyytxIxvsxKH7GaSQJDZerUM2EOw9Mg65Rgnf/RI50qU6OUdZC3k7XA=
X-Gm-Gg: AeBDieshlIAGY54VSh0tRtSmBGRG8DfUG83n+ggEdctoEDGarY0DimWLZSs42BHV8T4
 9Fnp3A9+JpG/EdbfwklcFpBhGLlrRp+toNS+RejQWqGiGQ5Egg3M+zUakJQaJC1r1acE8fKRVyn
 25XLZvCeTkx3QeCNsShfsD+jB39MiVUocFbBP5liWKmT7ynFlY631+Q5oV2pUJa1EoNb03fPGO5
 II1zJDxf5MnW+aDtaI1s45aFKoz6yKbhYQlIMcYoTv7nCDP4ie3GH7MV4N8A0nFQsD9vXXc+AfV
 H+Ck855X6pXy8rMe/UyuZkeNNWhKUl6fX9TfCMWHHtlzfEzW0GZUqjJIV3p7TXLo9+WgGRBET6b
 ijQ15byGGAwh6qTJXVl586miClKJirR8rBx7qCzRkMWAiCbvlL2G/2HGZx5mMfZc+bPw8mJS0Lr
 Dx7v37qtHoxnMOuR7DEJJWtw5rBZbiazziMxXYqkrL9JZc4trhzr3igVHQDmQDzjDL
X-Received: by 2002:a05:600c:705:b0:489:1c09:6c4b with SMTP id
 5b1f17b1804b1-4891c096dadmr42584455e9.6.1776701790387; 
 Mon, 20 Apr 2026 09:16:30 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc140c82sm272893225e9.12.2026.04.20.09.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:16:29 -0700 (PDT)
Date: Mon, 20 Apr 2026 18:16:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3] cgroup/dmem: allow max to be set below current usage
Message-ID: <lgkacelr76hf4yw2wb7tqevt52cakmxjnq4ww5ij5m46fdbufz@sxffiuqv5mze>
References: <20260326-dmem_max_ebusy-v3-1-8e62c06e2767@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3d3ztmeih5rgjpsw"
Content-Disposition: inline
In-Reply-To: <20260326-dmem_max_ebusy-v3-1-8e62c06e2767@igalia.com>
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


--3d3ztmeih5rgjpsw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] cgroup/dmem: allow max to be set below current usage
MIME-Version: 1.0

On Thu, Mar 26, 2026 at 12:18:17PM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> page_counter_set_max may return -EBUSY in case the current usage is above
> the new max. When writing to dmem.max, this error is ignored and the new
> max is not set.
>=20
> Instead of using page_counter_set_max when writing to dmem.max, atomically
> update its value irrespective of the current usage.
>=20
> Since there is no current mechanism to evict a given dmemcg pool, this wi=
ll
> at least prevent the current usage from growing any further.
>=20
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> When writing to dmem.max, it was noticed that some writes did not take
> effect, even though the write was successful.
>=20
> It turns out that page_counter_set_max checks if the new max value is abo=
ve
> the current usage and returns -EBUSY in case it is, which was being ignor=
ed
> by dmemcg_limit_write.
>=20
> It was also noticed that when setting limits for multiple regions in a
> single write, while setting one region's limit may fail, others might have
> succeeded before. Tejun Heo brought up that this breaks atomicity.
>=20
> Maarten Lankhorst and Michal Koutn=FD have brought up that instead of
> failing, setting max below the current usage should behave like memcg and
> start eviction until usage goes below the new max.
>=20
> However, since there is no current mechanism to evict a given region, they
> suggest that setting the new max will at least prevent further allocation=
s.
>=20
> v1 kept the multiple region support when writing to limit files, while
> returning -EBUSY as soon as setting a region's max was above the usage.
>=20
> v2 only allows setting a single region limit per write, while allowing any
> new max to be set.
>=20
> This version (v3) still allows multiple regions to be set, and explains w=
hy
> page_counter_set_max is not used anymore.
>=20
> I am sending this version dropping the multiple region restriction for no=
w,
> as we continue to discuss whether it should be supported or not.
> ---
> Changes in v3:
> - Dropped first patch as it was already applied.
> - Added comment explaining why page_counter_set_max is not used.
> - Dropped patch restricting multiple regions to be set for now.
> - Link to v2: https://lore.kernel.org/r/20260319-dmem_max_ebusy-v2-0-b5ce=
97205269@igalia.com
>=20
> Changes in v2:
> - Remove support for setting multiple regions' limits.
> - Allow any new max limit to be set.
> - Link to v1: https://lore.kernel.org/r/20260318-dmem_max_ebusy-v1-1-b7e4=
61157b29@igalia.com
> ---
>  kernel/cgroup/dmem.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--3d3ztmeih5rgjpsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeZRVxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhzsQEAzPlmclbTBSjout7PKHMK
X2eS3vMMTL5GqvW4QTX4niIBAInu/w6ghv2COtKTh59vIBfVFnygNqm6o/nWsjt6
wDIG
=XmJr
-----END PGP SIGNATURE-----

--3d3ztmeih5rgjpsw--
