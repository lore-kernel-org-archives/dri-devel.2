Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DB3C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C580710E8A3;
	Tue, 22 Sep 2026 06:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y+5spUnM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E063D10E73F;
 Tue, 22 Sep 2026 06:09:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E3B941FA7;
 Tue, 22 Sep 2026 06:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9771F000FF;
 Tue, 22 Sep 2026 06:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790057378;
 bh=oOBGis0SBghtHwpG23pIumyQMyfBIbbwM40vF06zwBg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y+5spUnMpxluPet75ChP+a6xHbyEvTeu0d8XlVB4l38BxoIwW1pkmo0o6GlQNqheK
 gwc8F5qN6POUsWKd3wvZcwy8zNOZAbRI+M5XtM4sUko9AwHh2p/TVvuKF8d9F/cJkA
 nS98eLAdhXXdAtnLrf/QlRka7Z2fZurJe9us+c8EEvUQNHxbEKghec6ymN/kddSle5
 XZc+K7IVJYs7sumpAZfmr7aKYjA8DUowflAJlN0Ejn6/MHrP8mFrqXyArbLv5tH3tF
 EtySiJqcNFyvp9H/QLwEY5zW64syrzThy9dbL5a1kGQjRRxR9lDsBxqfPxcyAwk+A7
 E//LI1mCya1CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/12] lib/test_hmm: add a new testcase for the
 migrate on fault
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-12-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-12-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:09:37 +0000
Message-Id: <20260922060938.2B9771F000FF@smtp.kernel.org>
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
- [High] mm: test_hmm: UAF due to concurrent unmaps during migration
--

commit 561fbddf4a910a84fca4e2648f745dbccb247398
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

lib/test_hmm: add a new testcase for the migrate on fault

This commit enhances the hmm test driver (lib/test_hmm) with a new test
case for migrate on fault. It adds a new ioctl and test code to fault and
migrate anonymous memory to device private memory.

> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index cd88e8177d0ab..b39522c05d832 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
[ ... ]
> @@ -382,7 +390,9 @@ static int dmirror_range_fault(struct dmirror *dmirro=
r,
>  		break;
>  	}
> =20
> -	ret =3D dmirror_do_fault(dmirror, range);
> +	/* update device page table after migration */
> +	if (!migrate)
> +		ret =3D dmirror_do_fault(dmirror, range);
> =20
>  	mutex_unlock(&dmirror->mutex);
>  out:

[Severity: High]
Does skipping the page table update here leave us vulnerable to concurrent
unmaps during migration?

When migrate is true, the dmirror->mutex is dropped here without verifying
the final sequence or updating the device page table. This opens a race
window.

[ ... ]
> @@ -1377,6 +1387,114 @@ static int dmirror_migrate_to_device(struct dmirr=
or *dmirror,
>  	return ret;
>  }
> =20
> +static int do_fault_and_migrate(struct dmirror *dmirror, struct hmm_rang=
e *range)
> +{
> +	struct migrate_vma *migrate =3D range->migrate;
> +	int ret;
> +
> +	mmap_read_lock(dmirror->notifier.mm);
> +
> +	/* Fault-in pages for migration */
> +	ret =3D dmirror_range_fault(dmirror, range);
[ ... ]
> +	pr_debug("Migrating from sys mem to device mem\n");
> +
> +	dmirror_migrate_alloc_and_copy(migrate, dmirror);
> +	migrate_vma_pages(migrate);
> +	dmirror_migrate_finalize_and_map(migrate, dmirror);
> +	migrate_vma_finalize(migrate);

[Severity: High]
Can this sequence lead to a use-after-free of device pages if a concurrent
unmap occurs after we dropped the mutex in dmirror_range_fault()?

While mmap_read_lock() is held here, a concurrent madvise(MADV_DONTNEED)
could still execute (since it only requires the read lock or per-VMA lock)
and clear the newly installed migration PTEs, triggering the MMU interval
notifier.

Since the interval notifier invalidation would see an empty dmirror->pt (as
we haven't mapped the pages yet), it would take no action.=20

Then, dmirror_migrate_finalize_and_map() inserts the newly allocated device
pages into dmirror->pt blindly, without re-checking
mmu_interval_read_retry().=20

When migrate_vma_finalize() runs, it would fail to map the device page into
the CPU page table because the migration PTE is gone, dropping the final
reference and freeing the page while it is still mapped in the device
page table.

> +out:
> +	mmap_read_unlock(dmirror->notifier.mm);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D11
