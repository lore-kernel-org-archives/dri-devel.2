Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78A8C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC02010F0DD;
	Mon, 14 Sep 2026 21:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SLO5ch0N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB3310F0DD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:44:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F48C43AFE;
 Mon, 14 Sep 2026 21:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AC31F000FF;
 Mon, 14 Sep 2026 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789422275;
 bh=lJQdkE1hGp3WpIdWGndQZAcOkc4mf6EeWvmOa0CrHV0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SLO5ch0ND1pxjlZaU6j8c06PyIPpVI1f0qkkDSUKmcx2BT6FIPKux1TX+gNREBdM7
 2X4O1Z4eGZSw/gkvjOXg1xTzmwSpUYdW9Wu7+9rV7rgizcCACKtt2squwJKYa4jC/C
 R0/8SeaH3x31sbV2a9sBkve/wiA3XGayT7bqzcB+dOmKxfeVpA/Up6mJQPHsc9NUyC
 GR2Pd3pHT290kJ12c1iOLZSWV5ZqRU616YZSxqvBhf27j2TrtpqhAnnjRQHXFNQKoT
 UILJQBfp/x1Bni2LlEy6cpUcpEx9k0gwsMYfWYe8Yxk1a+AnuXnvUpYjm0kQyBgNyi
 eXdCNGl4TkMzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/40] mm/mlock: eliminate weird VMA_IO_BIT abuse and
 simplify
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org,
 linux-scsi@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>,
 linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-24-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-24-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:44:34 +0000
Message-Id: <20260914214435.14AC31F000FF@smtp.kernel.org>
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
- [Low] Casting `bool` to `void *` causes a compiler warning/error (-Wint-t=
o-pointer-cast).
--

commit 5ca9abe89befb83b06ebb688a6a1ab1fe25a4e0e
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/mlock: eliminate weird VMA_IO_BIT abuse and simplify

This commit eliminates the use of VMA_IO_BIT during mlock/munlock operations
which was previously used to prevent double-counting during migration. Inst=
ead,
it threads a boolean through the page table walk and temporarily sets
VMA_LOCKONFAULT_BIT without VMA_LOCKED_BIT to indicate a locking walk in
progress. It also simplifies checking for VMA_LOCKED_BIT across various fol=
io
locking paths.

> diff --git a/mm/mlock.c b/mm/mlock.c
> index 39215a3eab1fb..4235a1518fc9e 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
[ ... ]
> @@ -428,31 +417,29 @@ static void mlock_vma_pages_range(struct vm_area_st=
ruct *vma,
[ ... ]
>  	lru_add_drain();
> -	walk_page_range_vma(vma, start, end, &mlock_walk_ops, NULL);
> +	walk_page_range_vma(vma, start, end, &mlock_walk_ops, (void *)lock);

[Severity: Low]
Does this direct cast from a boolean to a void pointer cause a compiler
warning?

Since a boolean is typically 1 byte and a void pointer is 8 bytes on 64-bit
systems, casting directly might trigger a -Wint-to-pointer-cast warning.
When building with -Werror enabled, this can result in a build failure.

Would it be safer to cast it through unsigned long first, like
(void *)(unsigned long)lock?

>  	lru_add_drain();
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D24
