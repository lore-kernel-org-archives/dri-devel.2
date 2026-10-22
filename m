Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0A606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAUOmnUw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B9610E3F0;
	Thu, 22 Oct 2026 12:11:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A72410E3F0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:11:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A77B60018;
 Thu, 22 Oct 2026 12:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5AD1F000C1;
 Thu, 22 Oct 2026 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792671079;
 bh=R45se70P3EMmhMkKtYLGOoSJA2q332w3U9R9/qm3AvU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dAUOmnUwYmXnqjnb7xpvzxZUOGMYgicvXndxs7prGd8mnPM1HRCMzBTCy5Wqgajt0
 7ydupNhuB0KEpvBHR5rfrH5IvHMKVlKDABORylIiEdm8FrF1lNL770+I6n0iaPeAVl
 YC1M6XYdYp6OHunXm7cWdAcaU2dlpD3/998uXguRKcEj5GyZBrTEdi5TpuzW9WUY6V
 uR+cGqMYiHlpxwrDQC84R50dPT0QbaRbkx4eFfEHe0Fx1GsqR0lASPJUmBltm4xaIO
 vLuGnuxQA7/bhka5CHm5PNZw6Q7Lk2fsakVxVTvA/ssGxs5iP3VkeQW16AkZtzvLOY
 hPwMuhCsUC5Uw==
Date: Thu, 22 Oct 2026 13:11:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
Message-ID: <atn3SPG5MKpj2Unj@gremlin>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
 <atnEFyGRYGGf9shA@gremlin>
 <71101695-339d-4f8f-b9d8-dfadf7dbd0ed@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71101695-339d-4f8f-b9d8-dfadf7dbd0ed@virtuozzo.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 12:44:40PM +0200, Konstantin Khorenko wrote:
> On 10/22/26 10:07, Lorenzo Stoakes (ARM) wrote:
> >> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
>
> > Was this a mistake in d8ef5e311d7b, or actually intentional for whatever reason?
> > If the latter this shouldn't be a fixes.
>
> commit d8ef5e311d7bfde54b60ab45026f206eff31b2d2
>
>     mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()
>
> ...
> +static inline void folio_dup_file_rmap_ptes(struct folio *folio,
> +               struct page *page, int nr_pages)
> +{
> +       __folio_dup_file_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE);
> +}
>
> ...
> +static inline void folio_dup_file_rmap_pmd(struct folio *folio,
> +               struct page *page)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       __folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, RMAP_LEVEL_PTE);
> +#else
> +       WARN_ON_ONCE(true);
> +#endif
> +}

OK so it was just wrong at the time :)

>
> Both functions were introduced in a single commit, i think it's a simple copy-paste issue.
>
> The helper never had a caller, so nobody could hit it. If you prefer, I
> can drop the Fixes tag and only mention d8ef5e311d7b in the changelog, as
> there is nothing to backport.

I mean, it seems like a bug to me? If there's no harm in backporting it I think you
should add Cc: stable@vger.kernel.org in that case actually.

--
Cheers, Lorenzo
