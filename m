Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A7DC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6CB10EDE6;
	Tue, 22 Sep 2026 17:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iJ+COoeH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45A210EDE6;
 Tue, 22 Sep 2026 17:25:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EC95417E1;
 Tue, 22 Sep 2026 17:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE771F000FF;
 Tue, 22 Sep 2026 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790097956;
 bh=GH5NHM9SMF3Y3qqzIYDs7t0XJRudoDanszTIA7TBNl8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iJ+COoeHnUsfulxKqmrHOgHPmfFsPFDR1BHEd7DN5EkuDT+uLwT+DVh6nKnhhx0kd
 6jOF39OHwCoQKodyfnRa9zMMqnPruPv0F5Y4uRUrN3i+bQ9O82bTIwnkGhf350SmMH
 fsgZAIwzEREmJcXInwshoN3qyHED7DKELRu6bhNyO3e4WXLGerFLhQjDY2VwWNbOPs
 5xPMvggl9ITtHem2X3h4BEL3c41zYL7BElmVh0TwPXZSbMUSIQdUP9iD5gdynrNlcl
 XZmQaxOGRU7L/ratpMDHur9SA9WJNWu1+3H6a5o8mZyCiwZeiKCL5nCsJ0trfBvRm5
 y6D9shH+H31Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] mm: convert PTE table entries in ptep_get()
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org,
 damon@lists.linux.dev, bpf@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-4-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-4-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:25:55 +0000
Message-Id: <20260922172556.1BE771F000FF@smtp.kernel.org>
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
- [Low] mm: build failure in ptep_get_lockless() with ARCH_HAS_HW_PTE_T
--

commit 5a58c0b37be320a1ff8bd51ae9ca94d50bf27375
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: convert PTE table entries in ptep_get()
   =20
ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
return a software PTE value. Add __pte_from_hw for both generic hw_pte_t
definitions. Read the hw_pte_t table element atomically before converting
it to pte_t.

[ ... ]

> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> index 07da05d375c2c..d6c5a7548550b 100644
> --- a/include/linux/pgtable_types.h
> +++ b/include/linux/pgtable_types.h
> @@ -8,8 +8,10 @@
> =20
>  #ifdef CONFIG_ARCH_HAS_HW_PTE_T
>  typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
> +#define __pte_from_hw(pte)	((pte).__pte)

[Severity: Low]
Does this wrapper struct cause a build failure in ptep_get_lockless()
when architectures using CONFIG_GUP_GET_PXX_LOW_HIGH (like x86-32 PAE)=20
opt into ARCH_HAS_HW_PTE_T?

When hw_pte_t is a wrapper struct instead of a typedef, the direct member=20
access fails to compile:

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

Since ptep is a pointer to the wrapper struct, it lacks the pte_low and
pte_high members.

>  #else
>  #define hw_pte_t pte_t
> +#define __pte_from_hw(pte)	(pte)
>  #endif
> =20
>  #endif /* !__ASSEMBLY__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D4
