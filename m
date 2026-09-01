Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99325C624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAE510E3C9;
	Tue,  1 Sep 2026 09:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="WWlu9Q71";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE3A10E3C9
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:40:36 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so5266405e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788255634; x=1788860434; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5j9n+oKHaFzgx1DDinsR7OA0Nu8ZG/xJIjlL9o5nBTU=;
 b=WWlu9Q71AzKOq9ZLwMJlns4jwEv/devwS3PxIrY1KS/GhKH4vH2bUOtz+T/EGFa5oK
 1aHdFOCLZS4AxRpUAYBiGDkCENOMB6ly3fBUZJGx4N8IUd8WVV/EGySVyYDb14LEu5MR
 BGyvwXUvoztHRqn3tkrTKflCRfwARzYkWHyKeCjJF9PgF9S++SnRfFHLOmXpZj5VX/tf
 nCRX8K9XBeaFa6fHGjQEeap8fDrpdKa+mhyoKrCngkF97u5c3UA1RCL+GdJ3apGZUwDh
 6SIATF+xn+uoo+l/EeKUwNs0wcs1o7yke5z4qlO9kSOBcmxGMEjq+hz8TVjKEDZgHRTi
 3Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788255634; x=1788860434;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5j9n+oKHaFzgx1DDinsR7OA0Nu8ZG/xJIjlL9o5nBTU=;
 b=CLqkxpz/F02ZX4I92M3mgZYMqSa9MEyp8/wBO4GNRnFdLVX3ZxewZes3FEf3+XUTDc
 hKQzq17Y/yr9NuVXTE4P0PRYpivYdC1VBBegRsgWQhiBSrP1wa6YMINAlHAQx9K+vsMs
 w+JHTZvSwcAXonlUTOHNJEAPOg2UGtRykKW9HzKKhg2fQu79pWBx0m/Hj872JxWhOyVK
 8M1tGA+mOD9u5tgJvHM++Nfl5bwfOyT1aqSJZVmrifr98k6Gb2zwEJnZCBGwejd4Pbem
 EhYBya8sIpQenbRy31qwrvNyjL5gqYynQORk+ALldEz5pzbEy+hEZq95nU/j2IVu+o/C
 TXeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rom6qFfH1xocKfe6z7hA/QovkK6mnZiYnLBwrFskpktUH4T6qxjZdDdJ+/RmuhMk9uCf6/SmX2XcY4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ln3QYAqoeOkKXYxXi9a1nyFXqqEvvQWHg4ZnoHH6Riz/T/+iBO
 OGlI8GP3X0TBnzfJE28BH3wljefdu7zyLQ+WAXAE62+7Kw2Shy2WReJEY2hZFo+r6ic=
X-Gm-Gg: AR+sD12SAfto82OVc97d3D+ihtGg3SMl1HVFzWEZsHOKoULYj881vU9LEiaOo2jS6EP
 hcu58BA5/uJnhkbAOXzSGamRpKWgQzbiaZwXaHTxzKrpr3PT7PsJvcuKFmOdFHAu+nHa/oiTDfu
 i6qf/eYKDBk99V8h7R3EGbm/YqDPZeHjvMOWaONsBInli9ZCXRHe6YTHWXtZtgNXf3/qzCFyiXY
 yN5hA5hb6FMzWlZKgfK1bw3XWq3rJT6B/fXoocUe0QwFXKrcgcnYiuz8UNL/aCu/IpfGNYMO8NY
 sOOxRLzJ4vwyPYAgaflLyIbEOYkWSD4RtCBYsPNRTAJXvHsEXWVgCOw9sHftWidYMsxJ2iCfd2r
 cJYpqM87U2ogj96zvUwMlg6KhfNBaOdoXv1JRoS5tAVjd9JKVUdmr0VrBR5/FegqBiAXIL8t6Pg
 s8rjINaOQCu81x0byml9varF0laUghX1Zv489KmiPl8vV52Vg122BcqqVdlblq4/w=
X-Received: by 2002:a05:600c:1f91:b0:499:bf8c:cfd1 with SMTP id
 5b1f17b1804b1-49b91c1c784mr475965405e9.2.1788255634423; 
 Tue, 01 Sep 2026 02:40:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm54689305e9.15.2026.09.01.02.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 02:40:33 -0700 (PDT)
Date: Tue, 1 Sep 2026 11:40:31 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
 roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
 rppt@kernel.org, surenb@google.com, dev@lankhorst.se, mripard@kernel.org, 
 nat@pixelcluster.dev, tj@kernel.org, osalvador@suse.de, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-team@meta.com
Subject: Re: [PATCH v5 7/7] mm/memcontrol: add stock to the memsw page_counter
Message-ID: <apaZdbM_l3kJIiyK@localhost.localdomain>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
 <20260831163752.2193337-8-joshua.hahnjy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xo3yor5m4gjcubez"
Content-Disposition: inline
In-Reply-To: <20260831163752.2193337-8-joshua.hahnjy@gmail.com>
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


--xo3yor5m4gjcubez
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 7/7] mm/memcontrol: add stock to the memsw page_counter
MIME-Version: 1.0

Hello Joshua.

On Mon, Aug 31, 2026 at 09:37:51AM -0700, Joshua Hahn <joshua.hahnjy@gmail.=
com> wrote:
> Before this series, each memcg had one stock shared by all its
> page_counters (memory + memsw). Now that the memcg stock was folded
> into the page_counter level, give memsw its own page_counter_stock
> so that it can benefit from caching charges as well.
>=20
> Note that while the allocation is conditional on do_memsw_account(),
> the freeing is not; the freer will only free non-NULL stocks. This
> matters because do_memsw_account() could have changed in between the
> allocation and the free.

(Just a passerby comment, I have no remarks to the overhaul.)

The change of do_memsw_account() is because of re-attaching the memory
controller between v1 and v2 trees. That's not so common operation (but
not ruled out), pre-condition for that is that there's only a single
online memcg, namely the root memcg. So it needs treatment especially at
memcg offlining (which is what drain_all_stock() (also) does).

I don't know how expensive page_counter_drain_stock_async() is going to
be [1] but the v1 parts here could could be guarded with
!cgroup_on_dfl(memcg->css.cgroup).

Regards,
Michal

[1] Now, I see in 5/7 that there's the counter->stock check which should
    be quick bailout on v2 (maybe quicker than the cgroup_on_dfl()
    I=A0proposed above).

--xo3yor5m4gjcubez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCapadjBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AiQnQEAn+3D5Q8gH9HbW/icWG8F
xGfgUIWouB8aOWqljr/HvZ8BANwLXDa9DIP7tkMWmP7WhMnwN1qjocussmXJE+Bl
QhQK
=VQ9y
-----END PGP SIGNATURE-----

--xo3yor5m4gjcubez--
