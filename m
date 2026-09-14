Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C70C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E4310F02C;
	Mon, 14 Sep 2026 16:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CFN8zg1n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CEE10F02C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:45:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BA8060142;
 Mon, 14 Sep 2026 16:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A411F000FF;
 Mon, 14 Sep 2026 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789404318;
 bh=GzzUgpg5T3Fw7SIJWr0k/zDCNh06mog6jFMZsTNMkEA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CFN8zg1nrQKpSH9hKVbpq0yf2EVgikSGjZPZk55eTjlY98JNX4Rk2OEAvNFgYtgkH
 M/HhnW4sXS3+DFMHs+GYXdqaEtphQuANd7xb1xkEMeIaifMeXnZ9kVzSh1b+0rzbE5
 UF1kjreA3QUxTNDqjUY0nvz3VYrm5E+VQNJ59ywSKdc2JarhaA43ySTRVjrFd2IgPN
 wrXFGRCwvLIAzzcSLsiFDUfl3RWIgaX/5jNiLwBBS78j/xOGP8hwY/plRY1WZ0NBoF
 IMeLywf8hMHYz9O4eLOZJCb9ldQXctwKh/yuY8XHmq18C3mT1TU6lwLiuh7O8En7rJ
 xwwPiAjJVNk3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/40] mm/vma: ensure mmap_prepare doesn't set
 actions on a mergeable vma
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: selinux@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, kvm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-perf-users@vger.kernel.org,
 kvmarm@lists.linux.dev
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-5-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-5-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 16:45:16 +0000
Message-Id: <20260914164517.61A411F000FF@smtp.kernel.org>
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
- [Critical] State modification applied to `desc->vma_flags` during action =
preparation is not propagated back to `map->vma_flags`, resulting in incorr=
ect VMA merging and the silent loss of critical flags like `VM_PFNMAP` and =
`VM_IO`.
--

commit 31f214221abd5db93fe1f46874d29ea3c59a0cc7
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/vma: ensure mmap_prepare doesn't set actions on a mergeable vma

When a user requests an mmap_action be performed in mmap_prepare, this
involves populating the VMA range with data. This patch asserts that no
future mmap action is performed on a mergeable VMA upon mmap_prepare
validation.

> diff --git a/mm/vma.c b/mm/vma.c
> index 626a18c08a269..2648fb0e19959 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2809,6 +2809,15 @@ static int mmap_validate(unsigned long prev_start,
>  int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
>  			  const struct vm_area_desc *desc)
>  {
> +	/*
> +	 * It is not valid to execute mmap actions for VMAs which can be merged,
> +	 * as any such merge would leave portions of the mapping incorrectly
> +	 * unmapped.
> +	 */
> +	if (vma_flags_can_merge(&desc->vma_flags) &&
> +	    WARN_ON_ONCE(desc->action.type !=3D MMAP_NOTHING))
> +		return -EINVAL;
> +

[Severity: Critical]
Does this check actually prevent the merge? Looking at call_mmap_prepare(),
map->vma_flags is copied from desc->vma_flags before call_action_prepare()
is called:

mm/vma.c:call_mmap_prepare() {
	...
	map->vma_flags =3D desc->vma_flags;
	...
	err =3D call_action_prepare(map, desc);
	if (err)
		return err;

	err =3D mmap_prepare_validate(&prev_desc, desc);
	...
}

If call_action_prepare() mutates desc->vma_flags to include action-specific
unmergeable flags, vma_flags_can_merge(&desc->vma_flags) will be false here,
allowing the validation to pass. However, these changes don't appear to be
synchronized back to map->vma_flags.

Could this cause the actual VMA operations to operate on the stale and
mergeable map->vma_flags?

If a VMA lacks VM_PFNMAP or VM_IO but contains PFN-mapped pages, could this
lead to memory corruption if kernel mechanisms assume the pages are normal
memory and call put_page() on raw PFNs?

>  	return mmap_validate(prev_desc->start, desc->start,
>  			     &prev_desc->vma_flags, &desc->vma_flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D5
