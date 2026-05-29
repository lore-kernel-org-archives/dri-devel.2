Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E32FCD6E51
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A17112059;
	Fri, 29 May 2026 14:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="C8YMVfTw";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD38112059
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:56:15 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso64066125e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780066574; x=1780671374; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4sxBURKEIs5vdCG6YL1mHOm0YuBgobmnmOVB3aNVSj0=;
 b=C8YMVfTwW0GnNNgKO7qfHCathh20Wf7dRTcZx48dEiOwwIZpfVjkkWpZPBm4jniVZV
 P+bCFN99mDcWP8ngZtKPEGND8wpq5G6aToXCB8zLx59cFfB3YF9xAKmxqQYGxoIalfJN
 qqIAwXk3ls+XkmFnlnjzauQ/cZkO7QiHYzixUXP0rlfdnFqf63rAa/PLN+J8zG/0vMB4
 NlMbnxbifXDt57XMluBcxd9s6kqJFEdeH8UeArODUK4YJpWdDQ6+x5uiZga3vZ91GFuN
 vv1deMzLKOjmOZ6bztGvBSs+0HDN1JF2Ebjx8bXabGVNrLqeukOc1b+aRARoCmp4UnSG
 DAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780066574; x=1780671374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sxBURKEIs5vdCG6YL1mHOm0YuBgobmnmOVB3aNVSj0=;
 b=hE9q60FAzsxNhLkYAa1wvty4BGdAQfAIefSz9auYyfWe8YQ0qrPgXu8pFAUqN89QG6
 +h/CBXoPb3PG8bEBBnYURpq44Iw8zzUmhXsayDdJzkczTzQ7FO9Zfms09DlxW2nTx0/C
 I75cOa+wyndMpJojZZA6CFdMncxSu1xSbKmV7ObQJoWpfZiPAN3USLIrxftXg07Ta53I
 bgFaVXP0QW0VPlmNPFkA84INouD9OV1XGuC5gQc/56YA40I59RPAQzU4LtDOeSfwBxly
 Dr2fWulB5I8DamjxAkspLT2Fmlq7lLYF5Oh5jZEALbiOCYjSDU4KktMTcn1jNAXwSFGE
 /6Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ATsuMDQPv1FFJlwg1FtVzhrTum1XoCijG1c0c38/279l71i4LwJtKystIQK+MqN5sBD5ER9uaIek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkiGWHuNcMXbYfDgZ1Kh+n3Ih0hn/scil+7pcBRzGqkfk1KU9h
 Bqm/qHDThi+Ke8EtAs3gN0Zz83RVNovv0JHIFjFwABi3CoCPg8fYBpmrThO4QGatp60=
X-Gm-Gg: Acq92OHH6FiOrNvdH1CKrhYHQJ/1xwff6+sHQtmt+kmM/qN90GofGSWOn2YeuUYeqPu
 5lx+0DaK27zJ+eDqsHDxpm3i39r5h6IONwTs7XE4FX4A5zlUbL/Q7yZ9LV7eGoJd11R9AQctQhJ
 6d+QAQNAFhNBcpS5JoX7I0E8oyGAzAh1Ei8RnlDwDgo+lP2zJVXok24MF9NIgdVrqoBc1mPoFFx
 jOOrp2WTK1nhw5G2E176wnCF2WJkuIdfRAO+s5M8d29cpnvqSqqvv5BHT/wQuUl6c+wxNW4xFJu
 mMq+FGlpqmlg1+zzhYZ3pcl5Mj0zegHhJLEnjOU5G/z9rzNFx/j2aEUDv1sy1iXHJliYJ3/XKvI
 0LePZyzIrI0gUgiSaQ7oXOsts5LpLh0XudsozADlodRC8KDFZhctziHeHOONhrgdGBjEBSRtDod
 rNVSxeFurLmMmF9q2DTfAapXY5tPRnO3aFMq4MOsivsl8kBNVKOU/zpBi7ic8=
X-Received: by 2002:a05:600c:4e55:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-4909c0a7eeemr64821725e9.16.1780066573715; 
 Fri, 29 May 2026 07:56:13 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909dff2a80sm51054325e9.3.2026.05.29.07.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:56:13 -0700 (PDT)
Date: Fri, 29 May 2026 16:56:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
Message-ID: <ahmoDiQ8Q11xUgtV@localhost.localdomain>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rwilhpywdsxyo6sd"
Content-Disposition: inline
In-Reply-To: <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
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


--rwilhpywdsxyo6sd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
MIME-Version: 1.0

On Tue, May 19, 2026 at 11:59:01AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> +/**
> + * mem_cgroup_dmem_uncharge - uncharge memcg from a dmem pool allocation
> + * @cgrp: cgroup of the dmem pool
> + * @nr_pages: number of pages to uncharge
> + */
> +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages)
> +{
> +	struct cgroup_subsys_state *mem_css;
> +	struct mem_cgroup *memcg;
> +
> +	/* CGROUP_DMEM and MEMCG guarantees this cannot be NULL. */
> +	mem_css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> +
> +	memcg = mem_cgroup_from_css(mem_css);
> +	if (!memcg || mem_cgroup_is_root(memcg)) {
> +		css_put(mem_css);
> +		return;
> +	}
> +
> +	mod_memcg_state(memcg, MEMCG_DMEM, -nr_pages);
> +	refill_stock(memcg, nr_pages);

This doesn't look right.
Here should be memcg_uncharge().

Regards,
Michal

--rwilhpywdsxyo6sd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahmpBxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjhCQEAr+BVWEm8zFPKmbprS/Y0
DGDmEkJvmxq53yv7/M98beIA/RFe/RMHQUNUp4via8ejOQCz9uiKLY1q3PFlk5c+
ByIA
=eOXW
-----END PGP SIGNATURE-----

--rwilhpywdsxyo6sd--
