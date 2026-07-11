Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6880C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 08:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1963910E214;
	Sat, 11 Jul 2026 08:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Pj+fWrEQ";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1D310E214
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1783758451; x=1784017651;
 bh=PlOt4NbNmlRlFRophHEiAi0ynsEu/WmQ+w5dHk7ziXw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Pj+fWrEQAHY2lFD81TrVw4qdqh5a/EqaMEyOCSZ/gbRRN3mdcihapcwpHRmGtZY1g
 fK4BeqI4vic6i14vTSUZnxRoEC8+4sUYy6BhLOY33QGxXo58Cu21UohPBol9vSk1Aa
 DaucRJNjd9FMAbSALNkIIMpolIHpNHoXdw+SsdDjjbo+aWRTR/zZ6YFW9tT2wI5So5
 7lIpCIm+xPMsM6nCM1YRz2LyoXIwfxfkPS1bXvdtlpTCvpKPIDopelQcrKeejZ4MeZ
 esEDjieTJXwEjhq63JoT+BmRYV5ltt0f7UzMre5nMj9XRPZbDyjDV+DUqr6gb6E9MW
 /UzF+dhsKw7Pg==
X-Pm-Submission-Id: 4gy1z22L2Jz2ScPY
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Yury Norov <ynorov@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Tamir Duberstein <tamird@kernel.org>,
 Timur Tabi <ttabi@nvidia.com>, Trevor Gross <tmgross@umich.edu>,
 Yury Norov <yury.norov@gmail.com>, Zhi Wang <zhiw@nvidia.com>,
 maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance for
 region allocations
Date: Sat, 11 Jul 2026 11:27:08 +0300
Message-ID: <20260711082725.12176-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260711063602.426311-1-ynorov@nvidia.com>
References: <20260711063602.426311-1-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 11 Jul 2026 02:36:01 -0400=0D
Yury Norov <ynorov@nvidia.com> wrote:=0D
=0D
> Compare the cost of allocating and freeing variable-sized regions using=0D
> a bitmap, IDA and a Maple Tree. All implementations process the same=0D
> randomly generated sequence of region sizes, ranging from 1 to 32 entries=
,=0D
> until the configured capacity is exhausted.=0D
> =0D
> Run the benchmark at several capacities to show how the approaches=0D
> scale. Report allocation and free times separately because bitmap,=0D
> IDA and Maple Tree removal have substantially different costs.=0D
> =0D
> On x86/kvm, the output example is:=0D
> =0D
> type       alloc (ns)      free (ns)   capacity   memory (B)=0D
> bitmap      179573071         342105    1000000       125000=0D
> IDA          46555636       33931498    1000000       134864=0D
> maple        18629665       19741396    1000000      1548304=0D
> bitmap        1630912          30933     100000        12504=0D
> IDA           6144785        3354590     100000        14288=0D
> maple         1745026        1825032     100000       155408=0D
> bitmap          28448           3374      10000         1256=0D
> IDA            418978         333641      10000         1872=0D
> maple          185398         211138      10000        15632=0D
> bitmap           2253            610       1000          128=0D
> IDA             42755          36432       1000          144=0D
> maple           19728          23474       1000         1552=0D
> =0D
> Reported IDA and Maple Tree memory figures exclude slab overhead=0D
> and transient allocations. The Maple Tree figure is additionally=0D
> a lower-bound estimate that assumes fully occupied leaf nodes and=0D
> excludes internal nodes.=0D
=0D
The report itself doesn't make it obvious. I think "memory (B)" can be=0D
misleading. Perhaps we should use a clearer column name or add a short note=
=0D
before/after the report for explaining the columns?=0D
=0D
Regards,=0D
Onur=0D
=0D
> =0D
> IDA has no region-allocation API, so each region is implemented as=0D
> a sequence of single-ID allocations. The IDs remain contiguous=0D
> because this benchmark fills an initially empty IDA monotonically.=0D
> =0D
> The benchmark is motivated by the discussion at the link below about=0D
> choosing the best data structure for the channel ID pool with the=0D
> capacity of 2048 IDs for the nova GPU driver.=0D
> =0D
> Specifically for 2048 IDs the result is:=0D
> =0D
> bitmap           3907            831       2048          256=0D
> IDA             83545          71007       2048          848=0D
> maple           34632          39710       2048         3600=0D
> =0D
> Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@n=
vidia.com/=0D
> Signed-off-by: Yury Norov <ynorov@nvidia.com>=0D
> ---=0D
> v2: add IDA benchmark (Matthew)=0D
> v1: https://lore.kernel.org/all/20260711013910.349586-1-ynorov@nvidia.com=
/=0D
> =0D
>  MAINTAINERS                  |   3 +=0D
>  lib/Kconfig.debug            |   9 ++=0D
>  lib/Makefile                 |   1 +=0D
>  lib/region_alloc_benchmark.c | 174 +++++++++++++++++++++++++++++++++++=0D
>  4 files changed, 187 insertions(+)=0D
>  create mode 100644 lib/region_alloc_benchmark.c=0D
> =0D
> diff --git a/MAINTAINERS b/MAINTAINERS=0D
> index 7cc4bca5a2c5..9e487a94aba4 100644=0D
> --- a/MAINTAINERS=0D
> +++ b/MAINTAINERS=0D
> @@ -4615,6 +4615,7 @@ F:	lib/bitmap.c=0D
>  F:	lib/cpumask.c=0D
>  F:	lib/find_bit.c=0D
>  F:	lib/find_bit_benchmark.c=0D
> +F:	lib/region_alloc_benchmark.c=0D
>  F:	lib/test_bitmap.c=0D
>  F:	lib/tests/cpumask_kunit.c=0D
> +		bitmap_count =3D benchmark_bitmap(capacities[i]);=0D
=0D
[...]=0D
=0D
> +		ida_count =3D benchmark_ida(capacities[i]);=0D
> +		maple_count =3D benchmark_maple_tree(capacities[i]);=0D
> +		WARN_ON(bitmap_count !=3D ida_count);=0D
> +		WARN_ON(bitmap_count !=3D maple_count);=0D
> +	}=0D
> +=0D
> +	/* Let the benchmark be loaded and run repeatedly without rmmod. */=0D
> +	return -EINVAL;=0D
> +}=0D
> +module_init(region_alloc_benchmark);=0D
> +=0D
> +MODULE_AUTHOR("Yury Norov <ynorov@nvidia.com>");=0D
> +MODULE_DESCRIPTION("Benchmark bitmap, IDA and Maple Tree region allocati=
on");=0D
> +MODULE_LICENSE("GPL");=0D
> -- =0D
> 2.53.0=0D
> =0D
