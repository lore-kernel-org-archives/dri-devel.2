Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34153C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543B810F00C;
	Thu, 17 Sep 2026 17:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UW0VP+JZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E2410F01A
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:25:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BDAB40B3C;
 Thu, 17 Sep 2026 17:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA5C1F000FF;
 Thu, 17 Sep 2026 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789665931;
 bh=QzuoqblhtnSwz5/gnST/Ei99LVjZM4MfRmDaS+kz4kk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UW0VP+JZ5NERvGc+1HE1jUyYOThOnKWPd1dyhpaWH0Fo180fewQuFnWsmzzh4t0hT
 YIoudVeX+QVC+M5GspqHrkeF6YuEhhIFfRIRpy7BG8wtCEUu29ihv6JJD+5AWktLic
 mdPJ6UuZlFCBWuX31X/Gml3TLgWgO2flJi8+BpfuOmk2S1pM+Z5jdUDh/EZ7zgzPHY
 MCLRkVlPPrd6K3TBI+vQ26qhxDlEZx9PD3OirRBi8WOSenAl9W8hPL4yP0Ng+GeB9Y
 z2te/RTOvYe1IsQnalr17z8me6rKCyHT0e7ITIHtli7pq47c4X0ak6fNoEr9uZ6nCB
 hQBR6n4fIrCEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/40] mm: add mmap action for discontiguous kernel
 page mapping
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, selinux@vger.kernel.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-8-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-8-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:25:29 +0000
Message-Id: <20260917172530.5BA5C1F000FF@smtp.kernel.org>
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
- [High] mm: discontig_kernel_map_page_range() design causes stack UAF
--

commit 799ff7230f10cd5417cb7a7e859eaf5d9ab5e253
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm: add mmap action for discontiguous kernel page mapping

This commit introduces a new mmap action for mapping discontiguous kernel
pages. It provides the discontig_kernel_page_ops interface, allowing
drivers to specify how batches of pages should be retrieved and mapped.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a1f2d375cf7d8..2a92193ac6a5e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> +static inline void
> +discontig_kernel_map_page_range(struct discontig_kernel_page_state *stat=
e,
> +				struct page **page_arr, unsigned long nr_pages)
> +{
> +	state->action =3D DISCONTIG_KERNEL_PAGE_MAP_PAGE_RANGE;
> +	state->__page_arr =3D page_arr;

[Severity: High]
Does this design create a risk of a stack use-after-free regression for
drivers using this helper?

Here, discontig_kernel_map_page_range() saves the page_arr pointer into the
state structure. However, this pointer is not consumed immediately.

> +	state->__nr_pages =3D nr_pages;
> +}

[ ... ]

> diff --git a/mm/memory.c b/mm/memory.c
> index 448342883e9da..45b21bb04a18b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> +int map_discontig_kernel_pages_complete(struct vm_area_struct *vma,
> +					struct mmap_action *action)
> +{
[ ... ]
> +	do {
> +		unsigned long end, pgoff_end;
> +		unsigned long nr_pages;
> +
> +		/* Default to abort. */
> +		state.action =3D DISCONTIG_KERNEL_PAGE_ABORT;
> +		err =3D ops->get(&state);
> +		if (err || state.action =3D=3D DISCONTIG_KERNEL_PAGE_ABORT)
> +			return err;
> +		nr_pages =3D state.__nr_pages;
> +
> +		if (!nr_pages || nr_pages > state.nr_pages_remain)
> +			return -EINVAL;
> +		end =3D state.addr + PAGE_SIZE * nr_pages;
> +		pgoff_end =3D state.pgoff + nr_pages;
> +
> +		err =3D apply_discontig_action(vma, &state);

[Severity: High]
Can this result in apply_discontig_action() dereferencing an invalid pointe=
r?

Because discontiguous pages must be assembled into an array, and there is no
post-get callback to cleanly free dynamically allocated memory, drivers are
highly incentivized to allocate the page array on the stack inside their
ops->get() callback.

When ops->get() returns, its stack frame is popped. If page_arr points to
that destroyed stack frame, apply_discontig_action() will then read from it
via state->__page_arr when mapping the range, leading to a stack
use-after-free.

> +		if (err)
> +			return err;
> +
> +		state.addr =3D end;
> +		state.pgoff =3D pgoff_end;
> +		state.nr_pages_mapped +=3D nr_pages;
> +		state.nr_pages_remain -=3D nr_pages;
> +	} while (state.addr < vma->vm_end);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D8
