Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F91BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AC610E0DF;
	Tue, 14 Jul 2026 22:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OT7IvIl3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745BC10E0DF
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8FCB0601ED;
 Tue, 14 Jul 2026 22:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183411F000E9;
 Tue, 14 Jul 2026 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784068484;
 bh=qDL9eny4h0nib0ZhBXcHnozQtHUBCpDGXLTX5Auz6TI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OT7IvIl3D3bg+T8ShsiVKR+NSibmB0+y0KTD4AM6k+1TroyZPPSllEwY8EQIvvEgj
 mNkE1lb043RMo7dpU1R+HuMi7gdPQ5cqBqsKl1zCZI2lU393xRJ6s2fYmyObVsE18z
 aLMNQlkx4dQtYqJE7bMOE1fWFE78Pf+a1edG594b5Zq9wjGNqYFxnb+xiSoxYvN97y
 M8fFUnNFGOJv0IWH/O7apPWNBrAhDGqzTjKI0DveSPwqUHXVmWco51WbnuRRMydkl5
 ngfKS0H3DADpoUQxUFaDfsOLca/VHzTaNBNLKmiqK6p22AWudMBNxlTlNIi1ExDeSn
 XGk8Wt6XPf9MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] fixup! mm/hmm: add
 hmm_range_fault_unlocked_timeout() for mmap lock-drop support
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178406768885.1106335.9955379956617151440.stgit@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
 <178406768885.1106335.9955379956617151440.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 22:34:43 +0000
Message-Id: <20260714223444.183411F000E9@smtp.kernel.org>
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
- [High] hmm_range_fault_locked() performs VMA iteration on an external mm_=
struct without verifying if the address space is stable, risking a crash on=
 an unstable maple tree.
--

--- Patch [1]: [PATCH v2 1/4] fixup! mm/hmm: add hmm_range_fault_unlocked_t=
imeout() for mmap lock-drop support ---
commit a32e804e265d5dd30e11762ac51a889fc0abfebc
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop su=
pport

This commit updates the example in the HMM documentation to pass the notifi=
er
stored in range to mmu_interval_read_retry(). It explicitly details the
relationship between the HMM walk and the invalidation check.

> diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> index 5c88d2cf08183..fc1b8dc198250 100644
> --- a/Documentation/mm/hmm.rst
> +++ b/Documentation/mm/hmm.rst
> @@ -206,7 +206,7 @@ The usage pattern is::
>            goto out_put;
> =20
>        take_lock(driver->update);
> -      if (mmu_interval_read_retry(&interval_sub, range.notifier_seq)) {
> +      if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
>            release_lock(driver->update);
>            goto again;
>        }

[ ... ]

> @@ -225,7 +225,8 @@ The usage pattern is::
>  The driver->update lock is the same lock that the driver takes inside its
>  invalidate() callback. That lock must be held before calling
>  mmu_interval_read_retry() to avoid any race with a concurrent CPU page t=
able
> -update.
> +update. The retry check must use the same notifier and sequence number s=
tored
> +in ``range`` by ``hmm_range_fault_unlocked_timeout()``.
> =20
>  Holding the mmap lock across HMM faults
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: High]
This is a pre-existing issue, but while reviewing the documentation for
HMM faults, I noticed hmm_range_fault_locked() in mm/hmm.c might be missing
a check for a stable address space before traversing VMAs:

mm/hmm.c:hmm_range_fault_locked() {
    ...
	mmap_assert_locked(mm);

	do {
		/* If range is no longer valid force retry. */
		if (mmu_interval_check_retry(range->notifier,
					     range->notifier_seq))
			return -EBUSY;
		ret =3D walk_page_range(mm, hmm_vma_walk.last, range->end,
				      &hmm_walk_ops, &hmm_vma_walk);
    ...
}

Does this path need to call check_stable_address_space(mm) before iterating
the VMAs with walk_page_range()?

If the mm becomes unstable (for instance, if an OOM reaper sets MMF_UNSTABLE
and modifies the maple tree concurrently while a device driver processes a
page fault for a user process), could iterating the maple tree on an
external mm_struct encounter XA_ZERO_ENTRY markers and lead to undefined
behavior or a panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178406760622.110633=
5.2379450382728057793.stgit@skinsburskii?part=3D1
