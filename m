Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363A8C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696CE10E3D3;
	Fri, 11 Sep 2026 15:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="ZreST20C";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF58010E3D3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:17:24 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c29432715d2so184492066b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789139843; x=1789744643; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2JzqsoiLxocAa5D2L3SPzdIZsS+OW1mUD+PJx4LQgiw=;
 b=ZreST20CEPm/0welbd5t6IS3EdGx9xIYZZULDZrwZZ9sKgasGJmo1NGvPM5ZhvToIp
 TNV+8AJvM697kH2BI/nFttvkgPss/qfAWNaaFQ7FVEuDR2rOWbOiC8ZCTrD3Ur6O4BgB
 +dvoPxio8subxMmu3m4PN2m6fa8hHOUa1KuhKh7MtiU+OzMnqrW1TYzpKha3uBViS4WU
 1gno/yY1gGUxAltUxHEduJo2HRUK9P0jSibYOA9ov86MEtP9/KzW7LmnIeqeTz7Is3ds
 mhDpKTU8iUfbMt2Q5C+3ycnuYcnRQl1a3iDRvJmQlC/QkjAMjCiOGOS0p19uRxq41oEz
 u11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139843; x=1789744643;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2JzqsoiLxocAa5D2L3SPzdIZsS+OW1mUD+PJx4LQgiw=;
 b=TCz6pun05rV9kdD4z3pFWkINHmSjPud4vxjzChXL5D03MCXrSnDXKCJKZIKNXY6Twa
 vXFyqUKVGYJtlCE6WUEnsLOQ1GmVP2+Gd6IkKGYqBk+kloNwy1nSZJKQ8MM406p3Jr+l
 VOsNZsQwuSRFx3WnwEEwauPlO27YXbc47mSmYH9ujA83m+3plYlQvbBqlvpQo0w/hosR
 t/G74c3xacuywKtaEEU3jk5kS//Sf1wU/1bzSWZvc/pPNTo28e2OoTXiki6UqXahJCTs
 deASa23RsiIkJP+jKsGSIoG3BeRoqGSWOI+vBpYBQaXshSdCSTrsZ+iNqayMh4fhLwnI
 craA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0r8ZfbLmBCl+psklGGXkqz/oFrGmKIPzYkCCtXHk4iIO3B+PZuUleYNuV+6Iv1dbFIGjBTViZ4gY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kAxo1S4hs66+rK7WI2db6lqDX7qeqRWZfUfYnTLFUlpa0W73Ng
 SIJ3BClp7NFvjlxNgjqqDb/6I3uFJe7BvQVv19AdPjr8t0vQumaNeJ03eY501zUHfVU=
X-Gm-Gg: AYBFou08DB/PhM7WzMhDkEpD9snFowtagAVgbfJzLacabepGuQUXFRqgJI+BZ3UE0Xo
 xfNIQR4IAo1KPTbng65J/2mrshRhXG7ZgFGZcZGtiD8XX3WPrcV5PPOrsvrmFaABf1/QdPVVZCe
 Qu+9i8HOHvEHB0IrRkmIcqjptai2FEIHA+Z6ziGxk+p0VY7QEvJgnwg/OtPb2WJtpTc1NvQzzuD
 1+FE2BPZlRt9QUAvLEMhM3i75C+KVa3hrvOupKILPydmhF7OkmOTpqS2kBwz9ZWmenr6xqQFHpV
 Z2sspoKN9osPf022to4Mgl0NcO0q1RuAcgdVW2CZZRzU3e0/xTTXSDO7NykibgKkSkBoZf4WCC9
 vn8HSbMOQoVe8zYohpy+tL52IiPD8KoIaQs/gvw5s/h7XAh9MJf/cmHB6YdDFDb9ACoQvslYYn/
 MoScDRqsuxVBfcioecd1+whsPrtrjxRHd/bPZgDOr2pmUSbyuz7AGTrWEOLlZe2M6xooADEkGjV
 g==
X-Received: by 2002:a17:906:6a03:b0:c29:45ce:85ad with SMTP id
 a640c23a62f3a-c29667f24c6mr225571866b.1.1789139843199; 
 Fri, 11 Sep 2026 08:17:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966026e2esm93138666b.19.2026.09.11.08.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:17:22 -0700 (PDT)
Date: Fri, 11 Sep 2026 17:17:20 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: linuszeng@tencent.com
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <nat@pixelcluster.dev>, Tejun Heo <tj@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, 
 Jingxiang Zeng <jingxiangzeng.cas@gmail.com>, Michal Hocko <mhocko@suse.com>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/3] mm: page_counter: move hierarchical protection
 out of struct page_counter
Message-ID: <aqQZus_Cc3mRiuXn@localhost.localdomain>
References: <20260909-descriptive-name-v2-0-d7dd7c099049@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ozrropszbqjorccy"
Content-Disposition: inline
In-Reply-To: <20260909-descriptive-name-v2-0-d7dd7c099049@tencent.com>
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


--ozrropszbqjorccy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 0/3] mm: page_counter: move hierarchical protection
 out of struct page_counter
MIME-Version: 1.0

Hi.

On Wed, Sep 09, 2026 at 05:44:18PM +0800, linuszeng via B4 Relay <devnull+linuszeng.tencent.com@kernel.org> wrote:
> No functional change is intended: protection semantics and the cgroup
> v1/v2 behaviour are preserved.

It is not clear from the description what is the intention then :-)

Do you have any measurements that the reduced cache footprint
changes performance for setups without protection?
And what is the positive impact on protected scenarios where the
counters are in (possibly) different cacheline and one indirection
further?

Thanks,
Michal

--ozrropszbqjorccy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaqQbfBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjHdwEA9eabDSoks6Xn+ni3bc0I
AP32Ul+BBWTmz5HMyoTjovoA/2JJSh5lKBEsuu0fwEMrZGzX9XiTI5mG6CHzszPG
ztkH
=VS/g
-----END PGP SIGNATURE-----

--ozrropszbqjorccy--
