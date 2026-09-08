Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E876C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4F110ED7A;
	Tue,  8 Sep 2026 20:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NJ30F8NP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81310ED70
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:34:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C08F4601FD;
 Tue,  8 Sep 2026 20:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1DE1F00A3A;
 Tue,  8 Sep 2026 20:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788899647;
 bh=mOKhPXd9YQloNgmf2oi41RM18BbFzj4CqtHxWVXwmjc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NJ30F8NPxj1y7QKpADTsXk5C46hyD23abj6BuzYlhZK4BlB/GfcOCWDpUZsjJPsxr
 bFjv+eJAkMyxudhVwpzxl1MeMvD6lJPhTgYm0ncBe58WZaPyzDbIgrMo4xg6lqTTj3
 4C9HzMsm9krC7mImyV6tAOvAFnqSDF6l2yYdpbjQ7migMDpYXdHxO8j9NVcp/vWutp
 hlh4pAowB9JzivA7MOn9f2lPI/Z94FizkYx7p1RH14wCdIPeKqf2H4XaqE+ia4i9BU
 cx4d1PWfBF8oV3F4RV0E8Tq+kYdeMOt/lcjdEzDesG5ImaUBq++gyXbx4JEdmN5D7T
 eHxc3TOaZTI4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/39] mm: add mmap action for discontiguous kernel page
 mapping
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, bpf@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 selinux@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>,
 kvm@vger.kernel.org
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-7-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-7-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:34:06 +0000
Message-Id: <20260908203406.AA1DE1F00A3A@smtp.kernel.org>
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
- [Low] The userland VMA testing header `dup.h` was not fully updated; the =
`map_kernel_discontig` field is missing from `struct mmap_action`.
--

commit 0017a54bcba2043c3f552b308a32a39be664f463
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm: add mmap action for discontiguous kernel page mapping

This commit introduces a new mmap action, MMAP_DISCONTIG_KERNEL_PAGES, to
allow drivers to map discontiguous ranges of struct page pointers. It provi=
des
discontig_kernel_page_ops for drivers to specify how page batches should be
retrieved, and updates the core mm and VMA test headers accordingly.

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 9ca2ea3664bc1..0cb4f96039568 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h

[ ... ]

> @@ -844,6 +880,10 @@ struct mmap_action {
>  			unsigned long nr_pages;
>  			pgoff_t pgoff;
>  		} map_kernel;
> +		struct {
> +			void *init_private;
> +			const struct discontig_kernel_page_ops *ops;
> +		} map_kernel_discontig;
>  	};
>  	enum mmap_action_type type;

[ ... ]

> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 1098655a5f4a3..52eee05e6c322 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -457,8 +457,9 @@ enum mmap_action_type {
>  	MMAP_NOTHING,
>  	MMAP_REMAP_PFN,
>  	MMAP_IO_REMAP_PFN,
> -	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
> -	MMAP_KERNEL_PAGES,	/* Map kernel page range from array. */
> +	MMAP_SIMPLE_IO_REMAP,		/* I/O remap with guardrails. */
> +	MMAP_KERNEL_PAGES,		/* Map kernel page range from array. */
> +	MMAP_DISCONTIG_KERNEL_PAGES,	/* Map kernel discontig page range. */
>  };
> =20
>  /*

[Severity: Low]
Does struct mmap_action in this userland VMA testing header also need
to be updated?

The map_kernel_discontig field was added to the kernel's mm_types.h, but
it appears to be missing from the corresponding struct mmap_action defined
in tools/testing/vma/include/dup.h.=20

If a selftest attempts to access the map_kernel_discontig union member of=20
struct mmap_action for MMAP_DISCONTIG_KERNEL_PAGES, it will fail to compile.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D7
