Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C22C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 19:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B1310E1B4;
	Sat, 11 Jul 2026 19:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ajHQuPPn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F098B10E1B4
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 19:02:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4476760052
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 19:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EA71F000E9;
 Sat, 11 Jul 2026 19:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783796527;
 bh=TZHloQKNAFXMBlHDdvAHgpB/8+D6uVMJrmrRqUvTUhU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ajHQuPPnUZkVdgNztuV/tTSjRrrUdutbSE5TK23/RC7RRLwTXKoGZsL1z1bB5tj4h
 WLY9JD6caClERWQ0dQDj5aRJGxBdOWkOVcAU7CgH7PZWW8V/PkSXDdb98468TTh45Q
 Pz4x5b3bg+bW7s1eG8tLSV3Ig3/TTmKEaqDjKdyBmE+16I8DkdexzzaArrylmJI3Db
 Q/yO4kND6bxLSsa5KDHCwptNCAnqJUujYsB4u5fEpy6hZeXV3AOJ3BjI61YeMmWZGk
 9kWAHmiQYDVuU1k3IWNTkhVU5Ee/CHTLLYRx8B6mStwryBrijHBwY4Z+vja7HMcvS8
 peKBmVR4lC0yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] mm: update
 generic_get_unmapped_area[_topdown]() to use vma_flags_t
To: "Lorenzo Stoakes" <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711-b4-vma-flags-mm-v2-4-0fa2357d5431@kernel.org>
References: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
 <20260711-b4-vma-flags-mm-v2-4-0fa2357d5431@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 19:02:06 +0000
Message-Id: <20260711190206.C5EA71F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the x86-specific=
 bottom-up mmap fallback path silently discards VMA flags, bypassing the sh=
adow stack guard gap allocation.
--

--- Patch [4]: [PATCH v2 04/13] mm: update generic_get_unmapped_area[_topdo=
wn]() to use vma_flags_t ---
commit 00b351f4aaa23a000490d96bd47f04d6f2e0f5d1
Author: Lorenzo Stoakes <ljs@kernel.org>

mm: update generic_get_unmapped_area[_topdown]() to use vma_flags_t

This commit updates generic_get_unmapped_area() and
generic_get_unmapped_area_topdown() to accept vma_flags_t instead of
vm_flags_t. It also updates stack_guard_placement() to use the new type.
The architecture-specific wrappers are retained but use legacy_to_vma_flags=
()
for compatibility.

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4a88b2a233f7f..39d33f3a55c2e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c

[ ... ]

> @@ -807,7 +807,7 @@ arch_get_unmapped_area_topdown(struct file *filp, uns=
igned long addr,
>  			       unsigned long flags, vm_flags_t vm_flags)
>  {
>  	return generic_get_unmapped_area_topdown(filp, addr, len, pgoff, flags,
> -						 vm_flags);
> +						 legacy_to_vma_flags(vm_flags));

[Severity: High]
This isn't a bug introduced by this patch, but the x86-specific bottom-up m=
map
fallback path silently discards VMA flags, bypassing the shadow stack guard
gap allocation.

Is it possible for an attacker to intentionally exhaust the top-down alloca=
tion
space (e.g., via high stack limits) to force the shadow stack allocation (u=
sing
the map_shadow_stack syscall) into the fallback bottom-up path in
arch_get_unmapped_area_topdown()?

In arch/x86/kernel/sys_x86_64.c, the fallback path looks like this:

bottomup:
	/*
	 * A failed mmap() very likely causes application failure,
	 * so fall back to the bottom-up function here. This scenario
	 * can happen with large stack limits and large mmap()
	 * allocations.
	 */
	return arch_get_unmapped_area(filp, addr0, len, pgoff, flags, 0);

By passing 0 for vm_flags, does this completely drop the VM_SHADOW_STACK fl=
ag
before the guard gap allocation logic checks for it?

Could this bypass allow shadow stacks to be allocated immediately adjacent =
to
other mappings, meaning if a shadow stack overflows, it corrupts adjacent d=
ata
instead of hitting a guard page?

>  }
>  #endif
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-b4-vma-fla=
gs-mm-v2-0-0fa2357d5431@kernel.org?part=3D4
