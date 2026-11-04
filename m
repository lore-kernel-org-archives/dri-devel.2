Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD142606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxPL261t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351D310E745;
	Wed,  4 Nov 2026 06:18:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FB010E73F;
 Wed,  4 Nov 2026 06:17:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22041601F6;
 Wed,  4 Nov 2026 06:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E204F1F000C1;
 Wed,  4 Nov 2026 06:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793773078;
 bh=KzRz0mWVu4wXP01ly7b7+gfO1U+HljkH+loKYdoDA+Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QxPL261tfgN71EeYGn9wxGTO+7F7xwxREMzTTfaCc+lw1jsv93bppOiSf6UJTQsFK
 Z5vR0aXEeelAWTxuaFMULwgeulpj8bdAOjJaOEZKf+HcMBrnLJyyAHO+4WwBSm9Ej5
 qz4mgNO/3Yfs4JsvlB9Zpbx/vtx9l5cGCLZp5U+Vzj+j4/ndUSS6cvyifS5kaAqNWT
 aBjbkcLiwsvVyYRBHT0bi1dILTDloKP5DQo7KgQRC8FbnOm2T5mzH/ACMgDTWeFhBp
 5ef267A/XnYuEFUfRABED374bD+Y7/W+k0Cf3l0XqaiK3DN0dKH+fZnBz1cwuyPLEj
 0ZEPzzJ+TCZQA==
Message-ID: <sashiko-outbox-196742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 04/12] mm/hmm: do the plumbing for HMM to
 participate in migration
To: mpenttil@redhat.com, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, "David
 Hildenbrand" <david@kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Balbir Singh" <balbirs@nvidia.com>, "Zi Yan" <ziy@nvidia.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@suse.cz>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Lyude Paul" <lyude@redhat.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20261103061629.972669-5-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <20261103061629.972669-5-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:17:57 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/hmm: hmm_vma_walk_pmd() skips remaining PTEs on folio split f=
ailure
--

commit 467255657c2d81a197c74dccb6095cef3e48051a
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: do the plumbing for HMM to participate in migration

This commit prepares hmm_range_fault() and the HMM pagewalk callbacks for
migration collection by adding PMD and PTE locking during the walk and wiri=
ng
in the migration preparation hooks.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 9220e6648636d..854d2c090b20c 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c

[ ... ]

> @@ -532,24 +739,65 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  	 * recover.
>  	 */
>  	if (pmd_bad(pmd)) {
> -		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
> +		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns_start, npages, 0))
>  			return -EFAULT;
> -		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
> +		return hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
>  	}
> =20
> -	ptep =3D pte_offset_map(pmdp, addr);
> -	if (!ptep)
> +	if (minfo) {
> +		ptep =3D pte_offset_map_lock(mm, pmdp, addr, &hmm_vma_walk->ptl);
> +		if (ptep)
> +			hmm_vma_walk->ptelocked =3D true;
> +	} else {
> +		ptep =3D pte_offset_map(pmdp, addr);
> +	}
> +	if (!ptep) {
> +		addr =3D start;
>  		goto again;
> +	}
> +
>  	for (; addr < end; addr +=3D PAGE_SIZE, ptep++, hmm_pfns++) {
> -		int r;
> =20
>  		r =3D hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, hmm_pfns);
>  		if (r) {
> -			/* hmm_vma_handle_pte() did pte_unmap() */
> +			/* hmm_vma_handle_pte() did pte_unmap() / pte_unmap_unlock */
> +			if (unmapped)
> +				flush_tlb_range(walk->vma, start, addr);
>  			return r;
>  		}
> +
> +		r =3D hmm_vma_handle_migrate_prepare(walk, pmdp, ptep, addr, hmm_pfns,=
 &unmapped);
> +		if (r =3D=3D -EAGAIN) {
> +			HMM_ASSERT_UNLOCKED(hmm_vma_walk);
> +			if (unmapped) {
> +				flush_tlb_range(walk->vma, start, addr);
> +				unmapped =3D false;
> +			}
> +			goto again;
> +		}
> +		if (r) {
> +			/*
> +			 * Splitting the folio failed; migrate_vma_split_folio()
> +			 * already dropped the PTE lock. Don't migrate the rest
> +			 * of the pmd range; addr keeps its valid pfn.
> +			 */
> +			HMM_ASSERT_UNLOCKED(hmm_vma_walk);
> +			if (unmapped)
> +				flush_tlb_range(walk->vma, start, addr);
> +			return 0;
> +		}

[Severity: Medium]
As reported by Sashiko on v16 [1], when hmm_vma_handle_migrate_prepare()
returns a non-zero error other than -EAGAIN in hmm_vma_walk_pmd() (such as
when migrate_vma_split_folio() fails to split a PTE-mapped large folio in
the subsequent patch "mm/hmm: migrate collection in HMM pagewalk - pte
level"), does returning 0 here leave the remaining entries in
[addr + PAGE_SIZE, end) completely unprocessed?

At the start of a migrating walk, hmm_range_fault_locked() clears
range->hmm_pfns[]:

mm/hmm.c:hmm_range_fault_locked() {
	...
	if (hmm_select_migrate(range)) {
		WARN_ON_ONCE(range->pfn_flags_mask);
		WARN_ON_ONCE(range->dev_private_owner !=3D
			     range->migrate->pgmap_owner);
		memset(range->hmm_pfns, 0,
		       ((range->end - range->start) >> PAGE_SHIFT) *
		       sizeof(*range->hmm_pfns));
	}
	...
}

While the current address addr already ran hmm_vma_handle_pte() and keeps i=
ts
valid PFN, returning 0 directly from the PTE loop terminates processing for
the rest of the PMD range [addr + PAGE_SIZE, end) while reporting success to
walk_page_range().

Consequently, for any addresses in [addr + PAGE_SIZE, end), neither
hmm_vma_handle_pte() nor hmm_vma_handle_migrate_prepare() is called.
Independent migratable pages in that remainder are not collected, unmapped =
or
read-only PTEs are not faulted in even when HMM_PFN_REQ_FAULT is requested,
and hmm_range_fault() can return 0 with those range->hmm_pfns[] entries sti=
ll
zeroed and lacking HMM_PFN_VALID.

[1] https://lore.kernel.org/r/20261021060506.2377545-5-mpenttil@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103061629.9726=
69-1-mpenttil@redhat.com?part=3D4
