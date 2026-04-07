Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C720FEEF25
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 12:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC6710E40D;
	Tue,  7 Apr 2026 12:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="YLUp18Za";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB5010E40D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:48:09 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488b150559bso15297965e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775566088; x=1776170888; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jsPjgRVFyADCET9OBAbphHMErVazIwO74nJ/z5grGXg=;
 b=YLUp18ZaPZd2C6D1xCJ4gYhRwmzPkshZPjqXHDwtcIkxiS6sBjU2SU5DTmXNmQS+Md
 R3+0JreBUTflbuFPsupslutzl0FdPDBN3Msi2dRfR0FwyU/kpgQ793BiSdmMkX0BHTW8
 qTDSu5nhMzWYo0wT+VsDKBR5Zn+urN/LuT8AUK8qZNMxHFXtRduMsU6tMq/U8MAG/4nl
 mwcnfO/dg5Ud2cGppYGRXmPcGiwFgURdGOxtZkvwVazp8JVs1vFOPfbsso4RjozSa4cW
 ZtxC9TewbgJCnS+Da8caEVHeY7L3AIuFq6fEa9e+xeJ/RwOWHk30ddAv47RwHKRaFs7d
 iZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775566088; x=1776170888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsPjgRVFyADCET9OBAbphHMErVazIwO74nJ/z5grGXg=;
 b=n1YGD8SspQQCv/JNU9Lur2n59gR/MVEVZjDvRaZJuOfrRI5TSiufugGnOsxoZZGo4y
 knAqwEow45pGnWHV9U8v/7ylSBnrgHj3XZLJQ/DZUw9E4bIVrqcHluanfeKk/op66z0H
 +5ZGrmF4DiFYJIAoLbn/t883Zr/rojGNhDYPZfth1hLrThzUy1BBXdb7taxZULMdEuf8
 lZNH7s44Y7SebvqPZm1HndMs4qXeFHyL4oC/bEeJSZhEiPLA5VB6jxmokgG6rRIc+Obm
 VbnLR12t8EJjzFBN9XWfQF2CEJyVfKWKJtf5oDAHLsWOjuKEWmc9appdeuPWq67ky2t7
 NgKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgbRxBOtDjfZ3UuuPi6coFdtqduutWH3pAaFsvSS2b3qlvWYRJs1aFZ0dgcW3q7IxsqPSsG646ZeU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwE0IzH38v6Sd63Z6543rNXwWWRd02Ag6UM3mqo1NNTfzaI+PHd
 SFvg3/0U5m3+e3t95lLlgvEDKTBv6vUguPfqCZOkCKnOlYKHX9NZnVrBZpWIz2xSM1o=
X-Gm-Gg: AeBDieueRDFkOvs53qfbr9RG7W6ociUYYDBGil43X/eoIO5B9xpE7qCbxIDw84ftCZg
 fMmhqpgYWD+F0ZqmfxWa1nT83BW7lepVoiJ1W0vvQzWG0PdGmFFaQOUCzAoo6vlekyg5/yLnSRG
 54jJ0sxjzLSswWdUZZx6IselmRu3T7D4TUiFmH3zv+GayKjSG/QLC9C10wHNMlo0IfScMTqaCuC
 EodeP62M8C1VVuBkTceGan+Ns80fx59KQOtus1r4TzmJ9VV0v+BU01CFs/EeLM9aNTgI4USaRVK
 5JcQKxIOGgjKvUqNbt82+fnnp5HB8Io7FOWeSJiQgWJMO+Ugsecl+StEGnwC7p5U1HpOk+HiuCQ
 iKVGhR9K2sRLgjUfH9t1zSVm4AuuyofMeAsMMW2wt2RkcQ6r4pXlOKW+BvAJpJy7tKDn3evpC5o
 mHofXB7F1dMsaFGpwhZ8Guiv9gkIREHhyX4uz3bXDbRS4=
X-Received: by 2002:a05:600c:4593:b0:485:33ad:3c9f with SMTP id
 5b1f17b1804b1-488997de1c6mr263906175e9.25.1775566087832; 
 Tue, 07 Apr 2026 05:48:07 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d58e5sm50268531f8f.23.2026.04.07.05.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 05:48:07 -0700 (PDT)
Date: Tue, 7 Apr 2026 14:48:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH RFC 2/2] cgroup/dmem: add a node to double charge in memcg
Message-ID: <auzxmkl5jxlvlxpryibtz7srdnssguiaylb3uisheclrqelcgh@owm2nve7axb5>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
 <20260403-cgroup-dmem-memcg-double-charge-v1-2-c371d155de2a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3iqnq37lhwpyhhg3"
Content-Disposition: inline
In-Reply-To: <20260403-cgroup-dmem-memcg-double-charge-v1-2-c371d155de2a@redhat.com>
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


--3iqnq37lhwpyhhg3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 2/2] cgroup/dmem: add a node to double charge in memcg
MIME-Version: 1.0

Hi.

On Fri, Apr 03, 2026 at 10:08:36AM -0400, Eric Chanudet <echanude@redhat.co=
m> wrote:
> Introduce /cgroupfs/<>/dmem.memcg to make allocations in a dmem
> controlled region also be charged in memcg.
>=20
> This is disabled by default and requires the administrator to configure
> it through the cgroupfs before the first charge occurs.

This somehow dropped the reason from [1] that this should be per-cgroup
controllable. Is that still valid? (Otherwise, I'd ask why not make this
a simple boot cmdline parameter like cgroup.memory=3Dnokmem.)



> @@ -624,6 +656,13 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_st=
ate *pool, u64 size)
>  		return;
> =20
>  	page_counter_uncharge(&pool->cnt, size);
> +
> +	struct mem_cgroup *memcg =3D mem_cgroup_from_cgroup(pool->cs->css.cgrou=
p);

This is not necessarily same memcg as when the dmem was charged via
current (imagine dmem controller to depth N, but memcg only to N-1;
charge, then memcg is enabled up to N so this would attempt uncharge
=66rom new memcg at level N, possibly going negative).

There is a question whether dmem should enforce same-depth hierarchies
with `dmem_cgrp_subsys.depends_on =3D 1 << memory_cgrp_id` (see
io_cgrp_subsys for comparison).

And eventually, if per-cgroup attribute is desired, it would make
greater sense to me if that attribute was on the parent level, so that
siblings competing among each other are always of the same composition
(i.e. all w/out dmem or all including dmem). This likely results in this
extra-charging attribute to be properly hierarchical.

HTH,
Michal

[1] https://lore.kernel.org/all/a446b598-5041-450b-aaa9-3c39a09ff6a0@amd.co=
m/

--3iqnq37lhwpyhhg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCadT9ARsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhOewD9F+F9qnpuYx39EPNVVkg/
SKfJIBup3dSTrvEji8kA2RQA/RMerQbaK2QZn1VEv4D6kzXZgky62HGmS4B6FfWf
8XoH
=uSlM
-----END PGP SIGNATURE-----

--3iqnq37lhwpyhhg3--
