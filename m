Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7EDCD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C454410FED0;
	Fri, 29 May 2026 13:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Ng5AkBHM";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9444010FECF
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:01:32 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so144777525e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780059691; x=1780664491; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TKlBWJ3ijSz9GFQ8lE7XQuNEddJ05fSbljPGAX3zb4M=;
 b=Ng5AkBHM/9l7hQmm2TjuSS84mgahQcSbneeWJJpvqlWc6stUlqSKQA1SE844viKkhG
 NVvQI2YgrujLsYt/ZIMACjbVDys5nNh2Foei7pJ89ZQX5OlOztxoSyiYk7eTKt9F8NHS
 Z1ycqnwX90vj6wGKB8srq9EZyZ4OH2ds+daBAlAhWuicL1lSBEMa/ZbKPBdPvHzMsxqF
 IqRwZlmuJtMOF6N9UMUasa1fkyY+7Hg4QnsOqq2DGncsIAsaTqpOpJdqpZiTnAx83xQY
 f+AA6YYoSXekuros68PaUmLjASoe6PKCjWNvMQxnxjx5qbMHfmjnjnF/CMraOarA2CCI
 hi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780059691; x=1780664491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKlBWJ3ijSz9GFQ8lE7XQuNEddJ05fSbljPGAX3zb4M=;
 b=rW3YUItGQokpr63rzisIuksdQSzx94n7zMnBQpEBD7YAuyKxwDAJb03eZOTBMElUNP
 Arbh2+Is6JNyVJUq29x/mjKkg0Fdszmeii+WzV2SLlDtEGdQk7pIbNgZpNrgcJeVyrQG
 f+iTv6xjYYQA4IYGvVlP8iZhjmWJ9ddikavj1x92Xd/3ISguBKZq6EPU/h1Ix3sdNgLj
 byF2lBh1OScKfbeBJua6/iQy8ZhrzeAOMo4dkfp1gUhR3FWZP8zTiFous+FuyjSRCiGP
 RT2PsfuU58g71+iJd9SNdPvEY20o1r16z1/+nWUR02vDOPPlF69bmjcNy1oIEx1vRmAj
 konw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SJCgeRt+CDlrhyLtjlfUT8h0y5U19zaum+mfvP0vqkU7jYnhS292XzUeaBrk9Vc8vGN08vOyuvvA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg1o2wxoMHUFUtQjQa4P6LGTG7dMqaky+vDu3oZ8HZWL8rHKNS
 bBkzOa39y1Eqvv1BO651VzOtdj1fQDpqw/xyjC+3YuE1164T8OUoQuUGFhL0BSw6FNc=
X-Gm-Gg: Acq92OE50+gBOvSbffIlwwCqT1Hb+DH3tjV2O9ehnwGkuCl+jUXKzmLDF1498bhb/ux
 g4RJecadQ7f0XawdWkFofLs2VXrHCA3PKgB9cDvUuJjJhBc1yEaVFtuT58CmUZD5CndjJUfIbfH
 nW0T9I3KNLBqNs80SLVP0DBzQb2+O90BAY19gfDo9toLodknVNkjgmMg15c2Xrif3AUZ/zB0SAE
 HB0lhZYUtJiBgKXYiUbAGGpKP9qvy2y5XQ3M6ZtcAOPbHm3UWETPPD7NIwlQaekpOL4yRZVdyIz
 IhM9Xwh8Uyirvm3p7wIPF/d3K4DCSIaG1QZxO6XM+CaqKsp5JGMNqTx2MHikMzTE5N/VMhKKlz7
 ax1ItQmqBNW9ZIjr9FawQKi75jD6ukfKx4bXzuoL1ZtGO/jlOf3Wc+STquvZhSOWM1+O78X8csu
 jdzUmuJL/rpVr2SppQxpf2ko4tmMpM+k9DQFmrc/FFyf4NoSo0poMYqhMMNKQ=
X-Received: by 2002:a05:600c:560d:b0:490:4ee0:82f9 with SMTP id
 5b1f17b1804b1-4909c0920c0mr38130535e9.7.1780059690792; 
 Fri, 29 May 2026 06:01:30 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909ca6575csm70478955e9.4.2026.05.29.06.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 06:01:30 -0700 (PDT)
Date: Fri, 29 May 2026 15:01:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
Message-ID: <ahmOBo02TA8u8RW2@localhost.localdomain>
References: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
 <ahCISfTlN10gD8e6@localhost.localdomain>
 <89901220-0a43-4668-9d20-aaecc72c58dd@lankhorst.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2z43jkempbrnq7gp"
Content-Disposition: inline
In-Reply-To: <89901220-0a43-4668-9d20-aaecc72c58dd@lankhorst.se>
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


--2z43jkempbrnq7gp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
MIME-Version: 1.0

On Fri, May 29, 2026 at 09:34:28AM +0200, Maarten Lankhorst <dev@lankhorst.=
se> wrote:
> > Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>
> Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>
>=20
> With your r-b it's ok to push it to the dmemcg tree?

Please go for it.

Michal

--2z43jkempbrnq7gp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahmOJBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ah7GAEAt/V3wEPGggC+JULstS3y
dmXXZPqpxAaQogu6yCs89g4BAMQxskRRFxPIHcGypjWfGqkYS3FsM2hfhSaRrkTr
5X8P
=a4Ed
-----END PGP SIGNATURE-----

--2z43jkempbrnq7gp--
