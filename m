Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D9CC982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAAE10E1C4;
	Thu, 17 Sep 2026 17:08:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NOLTI1mS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC27110E1C4
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:08:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6002C6020A;
 Thu, 17 Sep 2026 17:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CC41F000FF;
 Thu, 17 Sep 2026 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789664899;
 bh=wdec75VauJqogt9xH0upTA2NajEy+dB6WBfk4djJRkU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NOLTI1mShuaskZysi3trAiy291chSG4Eh/CWgWZ2lh8C3hXXEMsMrj+RF8Obzxf2l
 nO+tIZIkfNSXCJVlVOjQSlyCkymlHr/47CqO2oub6jIu7vaLt9IPuM0ImuDY6fHpQF
 Gtzty/8l9DWyN2p4C6YNbRKRrimccIMMuvIwkAgsTWQT3PGBYJG3IG8VePY8FG76VI
 XUoMoxhqb4IQXSag1v52hN59va7Ip1w0IJDzywdjhbu9KYKrW3ycLwCmKFI1b046AO
 zcWhBPErdl/NVrhPHRPLD83233FLmq+v001Q4onf95ZQYZ8gQ11dmDWFwomyDdv48N
 ++f6MXWgda0Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO
 faults
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917165406.1881899-1-lizhi.hou@amd.com>
References: <20260917165406.1881899-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:08:18 +0000
Message-Id: <20260917170818.E3CC41F000FF@smtp.kernel.org>
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
- [High] accel/amdxdna: data race on default_flags and illegal vma_lookup i=
n invalidation
--

commit a61f87b4e6515640e66ee7d41700b39d243ec56e
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults

This commit ensures HMM_PFN_REQ_WRITE is set when handling faults for VMAs
with VM_WRITE. It introduces amdxdna_umap_set_fault_flags() to check VMA
permissions and apply the flag, calling it from the notifier registration a=
nd
invalidation paths.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 5a1a2ee261b76..4f6fe982583fd 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
[ ... ]
> @@ -249,6 +249,20 @@ u64 amdxdna_gem_dev_addr(struct amdxdna_gem_obj *abo)
>  	return amdxdna_obj_dma_addr(abo);
>  }
> =20
> +static void amdxdna_umap_set_fault_flags(struct amdxdna_umap *mapp,
> +					 struct vm_area_struct *vma)
> +{
> +	mapp->range.default_flags =3D HMM_PFN_REQ_FAULT;

[Severity: High]
Does this code introduce a data race? amdxdna_hmm_invalidate is an MMU
interval notifier invalidation callback, which can run concurrently with the
driver's page fault handler (hmm_range_fault_unlocked_timeout). Modifying
mapp->range.default_flags here without synchronization can race with
hmm_range_fault, which reads range->default_flags locklessly.

> +
> +	if (!vma)
> +		vma =3D vma_lookup(mapp->notifier.mm, mapp->range.start);

[Severity: High]
Can calling vma_lookup here trigger a lockdep warning or use-after-free?
When called from amdxdna_hmm_invalidate, MMU notifiers (such as those
triggered by page reclaim or migration) do not guarantee that mmap_lock is
held, and this code does not take rcu_read_lock(). Calling vma_lookup
without either lock is unsafe, and may cause a use-after-free when
dereferencing vma->vm_flags on a potentially freed VMA.

> +
> +	if (vma && vma->vm_start <=3D mapp->range.start &&
> +	    vma->vm_end >=3D mapp->range.end &&
> +	    (vma->vm_flags & VM_WRITE))
> +		mapp->range.default_flags |=3D HMM_PFN_REQ_WRITE;
> +}
> +
>  static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>  				   const struct mmu_notifier_range *range,
>  				   unsigned long cur_seq)
> @@ -270,6 +284,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interva=
l_notifier *mni,
>  	down_write(&xdna->notifier_lock);
>  	abo->mem.map_invalid =3D true;
>  	mapp->invalid =3D true;
> +	amdxdna_umap_set_fault_flags(mapp, NULL);
>  	mmu_interval_set_seq(&mapp->notifier, cur_seq);
>  	up_write(&xdna->notifier_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917165406.1881=
899-1-lizhi.hou@amd.com?part=3D1
