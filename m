Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E0606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3wBaXx1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42BA910E452;
	Sun, 22 Nov 2026 07:56:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A816310E452
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:55:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8958E60ED9;
 Sun, 22 Nov 2026 07:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2314C1F000C0;
 Sun, 22 Nov 2026 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795334156;
 bh=F01tTJdf28QR/yR2rtMQVATlZKoJao4yf595FVHHP5Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G3wBaXx143DqjDMLC9d8W7aGgrxvJHLAu7PWlU80yPB3+fM/twD5zVgNFjh6iWey1
 LeA08jkkhk1+1O/yi3qc9Jj+A8GHubIHe+Lhx/DiOXcIzArDL0IvObMeyGGe1djkUg
 gXDYAfG6fy4kxW9iq5UN8J47gy21Qyj6UFyWjwmUDb2CSm0g7sEAslwDlOndpjttlz
 yqme0AKN9AvHFALnPd9ABrXXu5lFFXHgbc2c3+Z+4eTiUSwaXiTjmHbRx7oE34C+oK
 mQbZRZQ+uzdCpVhyS+8i0+dPHyzCj5//v/ROeagw8RyNss2O/C3K7HNF4gqVGX57xQ
 vmCkTSgjXOenA==
Message-ID: <sashiko-outbox-227803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] udmabuf: map huge page backed ranges with PMDs
To: "Qiliang Yuan" <qiliang.yuan@linux.dev>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261122-feat-udmabuf-huge-pfnmap-v1-2-dcba888940c2@linux.dev>
References: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
 <20261122-feat-udmabuf-huge-pfnmap-v1-2-dcba888940c2@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 07:55:55 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] udmabuf: pre-fault in udmabuf_vm_fault() hits VM_BUG_ON on
  existing huge PMD
--

commit 4678e5bd3e35a29d8e3ac62812388b08912dd829
Author: Qiliang Yuan <qiliang.yuan@linux.dev>

udmabuf: map huge page backed ranges with PMDs

This commit adds a ->huge_fault() handler to map PMD-aligned, physically
contiguous udmabuf ranges with huge PMDs, and updates udmabuf_vm_fault() to
skip PMD-mappable ranges when pre-faulting the VMA.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 018937435356e..f9c908f8b53a2 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
[ ... ]
> @@ -61,7 +112,12 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *v=
mf)
>  	if (ret & VM_FAULT_ERROR)
>  		return ret;
> =20
> -	/* pre fault */
> +	/*
> +	 * Pre-fault the rest of the VMA, except for the ranges that
> +	 * udmabuf_vm_huge_fault() maps with a PMD once they are accessed.
> +	 */
> +	pmd_ok =3D thp_vma_allowable_order(vma, vma->vm_flags, TVA_PAGEFAULT,
> +					 PMD_ORDER);
>  	pgoff =3D vma->vm_pgoff;
>  	addr =3D vma->vm_start;
> =20
> @@ -69,6 +125,14 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *v=
mf)
>  		if (addr =3D=3D vmf->address)
>  			continue;
> =20
> +		if (pmd_ok && IS_ALIGNED(addr, PMD_SIZE) &&
> +		    (vmf->address & PMD_MASK) !=3D addr &&
> +		    udmabuf_pmd_mappable(vma, addr, &pfn)) {
> +			pgoff +=3D (PMD_SIZE >> PAGE_SHIFT) - 1;
> +			addr +=3D PMD_SIZE - PAGE_SIZE;
> +			continue;
> +		}
> +
>  		if (WARN_ON(pgoff >=3D ubuf->pagecount))
>  			break;

[Severity: High]
Can the pre-fault loop in udmabuf_vm_fault() call vmf_insert_pfn() on an
address range where udmabuf_vm_huge_fault() has already installed a huge
PMD?

If a fault installs a huge PMD in one 2 MiB range of the VMA, and userspace
then disables THP for the VMA or mm (via madvise(MADV_NOHUGEPAGE) or
prctl(PR_SET_THP_DISABLE)) before faulting on another unmapped page in the
same VMA, existing huge PMDs are not split or unmapped, but pmd_ok evaluates
to false.  The pre-fault loop then does not skip the already-mapped PMD
range and calls vmf_insert_pfn() -> vmf_insert_pfn_prot() -> insert_pfn() ->
get_locked_pte() -> walk_to_pmd(), hitting VM_BUG_ON(pmd_trans_huge(*pmd))
when CONFIG_DEBUG_VM is enabled (or failing in pte_alloc_map_lock() with
VM_FAULT_OOM and aborting pre-faulting for the rest of the VMA when
CONFIG_DEBUG_VM is disabled).

Without synchronization against the PMD entry state, a concurrent PTE
insertion in udmabuf_vm_fault() can also allocate a PTE page table for a
range while another thread is in udmabuf_vm_huge_fault() ->
vmf_insert_pfn_pmd() -> insert_pmd() on a write fault, causing insert_pmd()
to see !pmd_none(*pmd) with pmd_pfn(*pmd) !=3D pfn and trigger
WARN_ON_ONCE(!is_huge_zero_pmd(*pmd)).

Conversely, when pmd_ok is true, skipping a PMD-mappable range without
checking pmd_none(*pmd) skips ranges that already have a PTE page table
allocated (for example after madvise(MADV_DONTNEED) zaps PTEs without
freeing PTE page tables); because __handle_mm_fault() only calls
create_huge_pmd() when pmd_none(*vmf.pmd) is true, those skipped ranges will
never reach udmabuf_vm_huge_fault() and will each fault back into
udmabuf_vm_fault() and re-scan the VMA.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-feat-udmab=
uf-huge-pfnmap-v1-0-dcba888940c2@linux.dev?part=3D2
