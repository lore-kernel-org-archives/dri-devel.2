Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D11FC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6334810E2D0;
	Thu,  6 Aug 2026 08:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XuqJXkF4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD09510E1F6
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:57:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90A4B415FA;
 Thu,  6 Aug 2026 08:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF01F000E9;
 Thu,  6 Aug 2026 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786006624;
 bh=c/H7nzTYi6BF4atfEvy+zdPRq8nTLE/WDkGn5YmUguE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XuqJXkF4wbrEQAxo3nqLKqmFQFapXB9waPDXoQsaGr5tDjxrkJKIBCabmI1CMdgIR
 Q77k5rlz1g/mbYg0tq8vVsk+AMi2ec0uBpplqSC4EdPWDBcVnQe4dEi5oam6fLS5UK
 h8ICKMdv3kC2OkmtsGX6FJJ6K+4Do0vwqMf6C36DmIH6BA22fSYja410lvh/zQrbPV
 oUBgXL2twPkBbrS/yQ5cm5f3SfAG4cwtZvDXrZYjiIb6rIQB18i76jz2hXXgZR9ifh
 FQg/XacnA3fvzsUfjkhAnHGGZC1UC/buoRYm6k1hTITOrTMCQ51b01LUkIfFMmcSpa
 2JR/o0f+QanCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] mm: convert PTE table entries in ptep_get()
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 dri-devel@lists.freedesktop.org, damon@lists.linux.dev
In-Reply-To: <20260806083926.1807279-6-usama.anjum@arm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-6-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 08:57:03 +0000
Message-Id: <20260806085703.C2BF01F000E9@smtp.kernel.org>
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
- [Low] ptep_get_lockless() fails to compile when both CONFIG_ARCH_HAS_HW_P=
TE_T and CONFIG_GUP_GET_PXX_LOW_HIGH are enabled.
--

--- Patch [5]: [PATCH 5/9] mm: convert PTE table entries in ptep_get() ---
commit 697ecf53dc0bc83c57005a208e0294657ed963f8
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: convert PTE table entries in ptep_get()

ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
return a logical pte_t value. Add __pte_from_hw for both generic hw_pte_t
definitions. Read the hw_pte_t table element atomically before converting
it to pte_t.

> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index dad80d264aac2..1768421755a9c 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_are=
a_struct *vma,
>  #ifndef ptep_get
>  static inline pte_t ptep_get(hw_pte_t *ptep)
>  {
> -	return READ_ONCE(*ptep);
> +	return __pte_from_hw(READ_ONCE(*ptep));
>  }
>  #endif

[Severity: Low]
Does this change cause a compilation failure in ptep_get_lockless() when
CONFIG_GUP_GET_PXX_LOW_HIGH and CONFIG_ARCH_HAS_HW_PTE_T are both enabled?

When CONFIG_ARCH_HAS_HW_PTE_T is enabled, hw_pte_t becomes a wrapper struct.
However, ptep_get_lockless() still attempts to access pte_low and pte_high
directly from the hw_pte_t pointer:

include/linux/pgtable.h:ptep_get_lockless() {
        ...
	do {
		pte.pte_low =3D ptep->pte_low;
		smp_rmb();
		pte.pte_high =3D ptep->pte_high;
		smp_rmb();
	} while (unlikely(pte.pte_low !=3D ptep->pte_low));
        ...
}

Should ptep_get_lockless() be updated to handle the wrapper struct, perhaps
by accessing the __pte member or extracting the logical pte_t first?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806083926.1807=
279-1-usama.anjum@arm.com?part=3D5
