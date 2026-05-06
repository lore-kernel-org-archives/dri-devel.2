Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2513CCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E2010E9D1;
	Wed,  6 May 2026 13:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="F64lVetS";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E28D210E9D1
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 13:54:04 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso69778665e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 06:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778075643; x=1778680443; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6KlB82Gzxw6Ep4hdvTnTO13cUo4z1IlE435VWxqkbhM=;
 b=F64lVetSsnASvv/sj6AgvjjCC4B+9maaLdeq+neyZ5FDRyqeKwlo3TxomkNofKC422
 05xG0ZebtixZfYky66foWah75JY8hZN7hPxY4aCVxXLVSDr4Csbh7dWbL1RelZ22xTe2
 DwCmKo74H1gaOIo9CdvU6Gkp1PNOhtUciwInAhym8+cL+bUczS81886T1wUcrfzb2AMG
 mqSWmwdtA9RACDwoPZ/UlvJq0VF9MHR6jmhwBCJZ0Nk1n5M8RBMM8DHXqImEkN3G1Zrt
 Mnq1mLK/ddvv39+L1nw2Gfi7YUU/yyvqOOoDufs0hA/RWCwBapNOBZzz1Q7DnMs50IbO
 Rsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075643; x=1778680443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KlB82Gzxw6Ep4hdvTnTO13cUo4z1IlE435VWxqkbhM=;
 b=KUhyRgZg1FU5nCuruhyPjkeOS0iWHByOCBL6Dudj13y8hYjsieYHvScmLFagD+hiOc
 7j8ndEPS3kDSCILfS8nKz5kH/FUdZFAuKcTU2169zBMeEOezU9RtaOqqxTR+uyhtBrFC
 DZ9a5JbHRfOUuLrKirkSWj/FgrjcGuxFlma0PE857ldp+G1ioNCtpwZZFpSNLzu7ix9m
 wgy+iqiecSXExvPlmAxhScvY7TqXa9CMMsEF9ovEaJ9KGDVKWibwZN7eUW6kBTUgiU/7
 KEQnUEmO0cRaFZqh+fKg1j5TBMUZnq2wT4OsvWQvKSizTz8w48ukDq28+05apUY8xCtR
 gPJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D8I9vgooC9q7O6gS5Vu7bjtBjcZsGCzundQVjKr4TrqHjyaHsfZwa9Mdw7nljlsZpFdZq/zdT+eg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfwRNAspI4GmePDBpdEcHIsrN1g/mX+wnUanUyZzNFGFGJFGPp
 aZVGxieVWxqdtEidBC0dYeRxXpF+YQQ3czoZ9yjxwMAYcXcrxJYUwdMx+MIH04aWXZ4=
X-Gm-Gg: AeBDieuGhmd7Hb1lvBRSPMXIbF4dLIbTdw5QK/3b1BYDAq5ajwH3tKpqTT/eI2wr6sX
 xqDJ1VrqPu4ORDz8XAlR+cv4aJ6HHBQdTM0d1UCtBO0R/QN8QXhAaZfXjyq6QFMgsHu8e5UQs/l
 EtREde37ElBev6Ut4EFbD5gMnwqkEDfK57Oxr8LIIIb5jRcL2VFJDe8b0hbgwKPZWlhrRWd3Uov
 vG12znPRnviCdefoIerF2KqY1oTj278Qs4pvwrRQ+KW7ub41qlZBxpheIdAZWTzag7q5k32gYns
 eoXFpkxhqbGK5qd1vlxL+3AxCjZwBOtyLQfU629bLMJ6S9/DayntTJjuV5L4jQue8KD70h5NXg9
 p+jy3lx6h9tDthOgCMOPRxBoO9mc2PqXZTW2LJqkaGIOP8Kq8Ifrj4kG2/nR/Nh66XjWfRWfnsG
 6Jhzf9rcwELVi44ie6SPuMBRU0r5umMy8MhK/EFzshaxBAQ6FX0u8m8F88kus=
X-Received: by 2002:a05:600c:c082:b0:489:6c22:e081 with SMTP id
 5b1f17b1804b1-48e51dd3a1bmr46595295e9.0.1778075643420; 
 Wed, 06 May 2026 06:54:03 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b19adsm17343205e9.3.2026.05.06.06.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 06:54:02 -0700 (PDT)
Date: Wed, 6 May 2026 15:53:59 +0200
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
Message-ID: <aftB-cc5EhDXxCGA@localhost.localdomain>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="reykr6qmcqnxtkqn"
Content-Disposition: inline
In-Reply-To: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
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


--reykr6qmcqnxtkqn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
MIME-Version: 1.0

Hello Thadeu.

On Wed, May 06, 2026 at 08:58:23AM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> Just like we have memory.peak, introduce a dmem.peak, which uses the
> page_counter support for that.
>=20
> It can be written to in order to reset the peak, but different from
> memory.peak, which expects any write, dmem.peak expects the region name to
> be written to it. That region peak is the one that is reset.
>=20
> That requires ofp_peak to carry a pointer to the pool that was reset.

(It'd be nicer to have generic data in that generic structure, at least
some void *priv. But see below.)

> Writing a different region name will reset the different region and make
> the original region peak get back to its non-reset value.

I'm slightly confused by this fds x pool matricity when there's only
a single slot in cgroup_file_ctx::cgroup_of_peak.

The intended use case is that users should maintain one fd per pool and
not mix it up?
This stanza would better fit to cgroup-v2.rst proper than the commit
message. Or make it simpler and start with non-resettable peak file
(like memory.peak had started too) and see how it fares. WDYT?


Thanks,
Michal

--reykr6qmcqnxtkqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaftH6xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgWBgEA78n1QkHtqLX1e7j+HqA5
/0hULtuyP0LvN9r2E3h2FskA/0/p9uNIv1XoJqaVguIXjyHW7Kp9SnAM0puHxrMQ
TzMA
=pFLa
-----END PGP SIGNATURE-----

--reykr6qmcqnxtkqn--
