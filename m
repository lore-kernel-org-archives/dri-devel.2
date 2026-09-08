Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A053C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC7F10ED99;
	Tue,  8 Sep 2026 20:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YTjI+4Nv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3067910ED99
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:48:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A98DB601F6;
 Tue,  8 Sep 2026 20:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5E71F00A3A;
 Tue,  8 Sep 2026 20:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900487;
 bh=fxuRN8dWyYnHwvsalLZYGKX5rFAk6jiZ11/s8/5XP28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YTjI+4Nvahv27dmxLaq05MSEm00mQ1Yn+X1KBlULmk0dZJBtD8fhXnqFGXlpEA6hh
 3Ao1pfudJ5RgKRP36WoTJuvQ0PpswyRygxJlbxF239rGP1QsdYwM62oXjnTRNNUIOy
 vfuUdCUU8mmle/ONyYGFpJZcy1yRBRanJDyY1IaJH5bcOM8HT+dDV9Lh3519M6nt8h
 KUlInXgss+HLUvs0sK+aglmPEIjpAGY5gzLDtldCgTwCpqzwtewYG+EGk51GJBRVwb
 j7ZdV0NM0eew/45AgkC/0U+OOdM2oCVuBE1WQ+H8CW6yi/tpBqyh+CRDOzSdDd1F7R
 DJ/8u6tcXmyDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 32/39] mm/madvise: use predicates for madvise(...,
 MADV_DOFORK)
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, bpf@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 selinux@vger.kernel.org
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-32-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-32-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:48:06 +0000
Message-Id: <20260908204806.8D5E71F00A3A@smtp.kernel.org>
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
- [High] MADV_WIPEONFORK and __MADV_SET_ANON_VMA_NAME incorrectly use vma->=
vm_file to classify anonymous VMAs, falsely rejecting private /dev/zero map=
pings.
--

commit eca1ad64ddd91aa6f5fb87e2a56f40c30ef8259e
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/madvise: use predicates for madvise(..., MADV_DOFORK)

This commit updates MADV_DOFORK to use vma_can_merge() instead of manually
checking for VM_SPECIAL flags. This clarifies the intent, ensuring that if a
mapping isn't allowed to be merged, its CoW behavior cannot be manipulated =
on
fork. No functional change is intended.

> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0fc31835fee1a..f805a4876c875 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1400,7 +1400,7 @@ static int madvise_vma_behavior(struct madvise_beha=
vior *madv_behavior)
>  		new_flags |=3D VM_DONTCOPY;
>  		break;
>  	case MADV_DOFORK:
> -		if (new_flags & VM_SPECIAL)
> +		if (!vma_can_merge(vma))
>  			return -EINVAL;
>  		new_flags &=3D ~VM_DONTCOPY;
>  		break;

[Severity: High]
This isn't a bug introduced by this patch, but just below this in
madvise_vma_behavior(), MADV_WIPEONFORK incorrectly uses vma->vm_file to
classify anonymous VMAs:

	case MADV_WIPEONFORK:
		/* MADV_WIPEONFORK is only supported on anonymous memory. */
		if (vma->vm_file || new_flags & VM_SHARED)
			return -EINVAL;

Does this condition falsely reject private /dev/zero mappings because they
retain a file reference?

If userspace ignores this failure, wouldn't memory intended to be wiped
(such as cryptographic secrets) be copied to child processes during fork,
resulting in a cross-process information leak?

Should this use vma_is_anonymous(vma) instead?

[Severity: High]
This is also a pre-existing issue, but further down in the same function,
__MADV_SET_ANON_VMA_NAME has a similar check:

	case __MADV_SET_ANON_VMA_NAME:
		/* Only anonymous mappings can be named */
		if (vma->vm_file && !vma_is_anon_shmem(vma))
			return -EBADF;
		break;

Does this also falsely reject private /dev/zero mappings by relying on
vma->vm_file to enforce the anonymous mapping restriction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D32
