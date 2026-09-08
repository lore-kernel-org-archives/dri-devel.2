Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6FBC79FAD
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D9A10ED98;
	Tue,  8 Sep 2026 20:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZmTLlbey";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F7510ED98
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:47:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C1A1601DE;
 Tue,  8 Sep 2026 20:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8188D1F00A3A;
 Tue,  8 Sep 2026 20:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900466;
 bh=+KP7Reu7QYCYdusFcN2vvX4YzKfsxfGgEj90qNDhOuM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZmTLlbeyS19W1F2n17CwHNvSsvgCObTtbjU6pB7a/ASzaXp1a54oSV37GyTeMhMKK
 yDVzXX/tGPx8sTtRP5ExAJFQr8yN6YdYO5t/cscR0VqHuJQ30STxpJuWBpgTSLFDKQ
 valaJmBIQQEALdoRh56tcyrzc5wnewyaNSnJ4/BTridJnRKmm9LvTqPaMUK6Sdu+sn
 fsLkh2XcowH9ZLxfgxTi7upULDpQZfLQ0ZFJUXOAA3+jo5UYKoWHCKeOqq8sanajBt
 4nmevi2OFWlTkLKEpUJbz/+FEek7+W2+qvS9kG/oN0EEEusaO+Ibvemcgf6FxPcgUG
 dg5jQTlQp/fww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/39] mm/mlock: eliminate weird VMA_IO_BIT abuse and
 simplify
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-scsi@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Heiko Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, selinux@vger.kernel.org, bpf@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-23-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-23-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:47:45 +0000
Message-Id: <20260908204745.8188D1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing munlock during concurrent unmap due to vma flag check regr=
ession
--

commit 2a2d17538653740326938f5e55760a431c727840
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/mlock: eliminate weird VMA_IO_BIT abuse and simplify

This patch simplifies the mlock implementation by eliminating the use of
the VMA_IO_BIT flag. Instead, it temporarily sets VMA_LOCKONFAULT_BIT and
clears VMA_LOCKED_BIT during page table walks to prevent double counting.
It also updates various mlock functions to check the new VMA lock state.

> diff --git a/mm/internal.h b/mm/internal.h
> index 6e27d3b10c015..04b1f1d3d9604 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -993,7 +992,7 @@ static inline void munlock_vma_folio(struct folio *fo=
lio,
>  	 * always munlock the folio and page reclaim will correct it
>  	 * if it's wrong.
>  	 */
> -	if (unlikely(vma->vm_flags & VM_LOCKED))
> +	if (unlikely(vma_test(vma, VMA_LOCKED_BIT)))

[Severity: High]
Does this change leak the mlock_count if a concurrent unmap occurs?

If a process calls mlock(), mlock_vma_pages_range() now clears
VMA_LOCKED_BIT and sets VMA_LOCKONFAULT_BIT during the walk. If another
process concurrently unmaps a file-backed page in this VMA (for example,
via ftruncate() which only takes i_mmap_rwsem), the unmap path calls
folio_remove_rmap_pte() -> munlock_vma_folio().

Because VMA_LOCKED_BIT is temporarily clear during the mlock walk, this
check evaluates to false and skips calling munlock_folio(). This leaves
the folio pinned on the unevictable LRU with an elevated mlock_count.

Would it be better to check for VMA_LOCKED_MASK here, similar to how
try_to_unmap_one() was updated in this patch?

>  		munlock_folio(folio);
>  }
> =20
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 39215a3eab1fb..4235a1518fc9e 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c

[ ... ]

> @@ -428,31 +417,29 @@ static void mlock_vma_pages_range(struct vm_area_st=
ruct *vma,
>  		.pmd_entry =3D mlock_pte_range,
>  		.walk_lock =3D PGWALK_WRLOCK_VERIFY,
>  	};
> +	const bool lock =3D vma_flags_test(new_vma_flags, VMA_LOCKED_BIT);
> +	vma_flags_t walk_flags =3D *new_vma_flags;
> =20
>  	/*
> -	 * There is a slight chance that concurrent page migration,
> -	 * or page reclaim finding a page of this now-VMA_LOCKED_BIT vma,
> -	 * will call mlock_vma_folio() and raise page's mlock_count:
> -	 * double counting, leaving the page unevictable indefinitely.
> -	 * Communicate this danger to mlock_vma_folio() with VMA_IO_BIT,
> -	 * which is a VMA_SPECIAL_FLAGS flag not allowed on VMA_LOCKED_BIT vmas.
> -	 * mmap_lock is held in write mode here, so this weird
> -	 * combination should not be visible to other mmap_lock users;
> -	 * but WRITE_ONCE so rmap walkers must see VMA_IO_BIT if VMA_LOCKED_BIT.
> +	 * LOCKONFAULT without LOCKED never otherwise occurs: it marks a walk in
> +	 * progress so that rmap-side callers, which test VMA_LOCKED_BIT, do not
> +	 * count folios, while try_to_unmap_one(), which tests VMA_LOCKED_MASK,
> +	 * still refuses to unmap them.
>  	 */
> -	if (vma_flags_test(new_vma_flags, VMA_LOCKED_BIT))
> -		vma_flags_set(new_vma_flags, VMA_IO_BIT);
> +	if (lock) {
> +		vma_flags_clear(&walk_flags, VMA_LOCKED_BIT);
> +		vma_flags_set(&walk_flags, VMA_LOCKONFAULT_BIT);
> +	}

[Severity: High]
Because VMA_LOCKED_BIT is temporarily cleared here, any concurrent rmap
walks (like a truncation unmapping pages) that rely on munlock_vma_folio()
will see a cleared lock bit and fail to drop the mlock_count.

> +
>  	vma_start_write(vma);
> -	vma_flags_reset_once(vma, new_vma_flags);
> +	vma_flags_reset_once(vma, &walk_flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D23
