Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2957C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F354210F311;
	Thu, 24 Sep 2026 07:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SG2HZhLd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C6710E65B;
 Thu, 24 Sep 2026 07:27:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3344542DDC;
 Thu, 24 Sep 2026 07:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48111F000FF;
 Thu, 24 Sep 2026 07:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790234878;
 bh=7UEtoNIuvdVZfmT865eJ9fFM038Y9KSgZquCugzORHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SG2HZhLdLpH5TI3yZYsCxYxXrdreuVMDSS5zjTN8jXNg+O/me6234tfJQO/xwHyld
 AfnPWxw3Fzky6Wdi1/RCNnj7wnUbukPyeOVzqTg9vAS1WPD4zm4Bpngiq0ZQcpDRmf
 CSVPhsIjh/M9kK2ZDjFzpGnkXbxkLExAYY2xyJ/ujaQ7Rp4d+5mSyP24IOJ56DfcGa
 007o8OSDv6kFBbEUCFfb/eQTBXt7MHTpk3NJtO4idpJIl+aCUKHsDMPPMU1uNFqL5h
 tbhMzA6Df7Q443m73E52lgG+8tCScwQ/kHVjk+JQ6fVJo8c8uRuVeES9rry9LzNbTS
 kUniNyZkQxYjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/11] lib/test_hmm: add a new testcase for the
 migrate on fault
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260924065313.899730-11-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
 <20260924065313.899730-11-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:27:57 +0000
Message-Id: <20260924072757.D48111F000FF@smtp.kernel.org>
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
- [Medium] test_hmm: device page table desync on concurrent MMU invalidation
--

commit fba7f5abd6e7b21ba16a0224adb82cc24650eb6e
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

lib/test_hmm: add a new testcase for the migrate on fault

This commit enhances the hmm test driver (lib/test_hmm) by adding a new=20
testcase for the migrate on fault scenario.

> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index cd88e8177d0ab..31608b6998bb2 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
[ ... ]
> @@ -1377,6 +1398,127 @@ static int dmirror_migrate_to_device(struct dmirr=
or *dmirror,
[ ... ]
> +static int do_fault_and_migrate(struct dmirror *dmirror, struct hmm_rang=
e *range)
> +{
[ ... ]
> +		dmirror_migrate_alloc_and_copy(migrate, dmirror);
> +		migrate_vma_pages(migrate);
> +
> +		mutex_lock(&dmirror->mutex);
> +		if (mmu_interval_read_retry(&dmirror->notifier,
> +					    range->notifier_seq))
> +			ret =3D -EBUSY;
> +		else
> +			ret =3D __dmirror_migrate_map_locked(migrate, dmirror);
> +		mutex_unlock(&dmirror->mutex);
> +
> +		migrate_vma_finalize(migrate);

[Severity: Medium]
Will skipping the device page table update here create an inconsistent state
that migrate_vma_finalize() permanently commits?

In do_fault_and_migrate() in lib/test_hmm.c, if a concurrent page unmap (li=
ke
page reclaim) invalidates the MMU notifier interval between=20
mmu_interval_read_begin() and mmu_interval_read_retry(), the retry check
fails and ret is set to -EBUSY.

However, migrate_vma_pages() has already executed and populated the CPU page
tables. By skipping __dmirror_migrate_map_locked() on retry, the device page
table is left desynchronized. When migrate_vma_finalize() is subsequently
called, the CPU page tables irreversibly commit the migration to device
private memory without the new device mappings.

Could this cause a wasteful ping-pong migration on the subsequent retry loo=
p,
where hmm_range_fault() triggers a fault on these device-private pages, cal=
ls
the device's migrate_to_ram handler to bounce the pages back to system RAM,
only to migrate them to the device again?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065313.8997=
30-1-mpenttil@redhat.com?part=3D10
