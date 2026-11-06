Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCBA606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrupQmMi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3EB10E440;
	Fri,  6 Nov 2026 19:04:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D073010E440
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 19:04:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F999407BA;
 Fri,  6 Nov 2026 19:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548691F0089F;
 Fri,  6 Nov 2026 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793991887;
 bh=NJzgihKv5SDVEpDL2GzDunWXZSgtjUqFtOOtRN/n4aM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=WrupQmMixDgwTc0RMGmoos1W0Un5kV/6F+uLBFfERGNvPtD81Ory4owcn8IqkHMUu
 0Mf+zcXS5E8wdaTm2A1TVMPjbmynk4sodmlL/OD+i4RBB8e7GgZUbk0KuYmV9+cZAG
 X2AzDWdRGhz5Kbfx31OdJRk+frdKcxN81IVsigHOWJ48eD8Fs5tCfnnKFulESjCiOn
 05/A5CgZKh1EpGqdiK2Stf1V/N74tjIQFalENcp8T65ymmiFyCWfjjNuJFQRVxkwpV
 KMyEoY12dv5Kxp76VMqMq27hwTyQrdrh58yzlsp6lIdj9Om2yY3duTUd8ZWC2zvJtT
 Lp9PUMBoIfKkw==
Message-ID: <sashiko-outbox-202129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 2/2] accel/amdxdna: use drm_gpusvm_pages for user
 mapping tracking
To: "Lizhi Hou" <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261106184217.2720718-2-lizhi.hou@amd.com>
References: <20261106184217.2720718-1-lizhi.hou@amd.com>
 <20261106184217.2720718-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:04:46 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] accel/amdxdna: incorrect mm usage in amdxdna_hmm_register()
  [1]
--

commit c54d5e6dbf44961e3d8dc3f2a76a49df30f7a6ae
Author: Matthew Brost <matthew.brost@intel.com>

accel/amdxdna: use drm_gpusvm_pages for user mapping tracking

This commit replaces the open-coded HMM range and invalidation tracking for
user BO mappings in amdxdna with drm_gpusvm and drm_gpusvm_pages in
pages-only mode.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 09e48c794e1b0..57d87fa98d671 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> @@ -441,38 +473,34 @@ static int amdxdna_hmm_register(struct amdxdna_gem_=
obj *abo,
>  		return 0;
>  	}
> =20
> -	down_read(&xdna->notifier_lock);
> +	down_read(&xdna->gpusvm.notifier_lock);
>  	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> -		if (compare_range(mapp, current->mm, addr, addr + len)) {
> -			up_read(&xdna->notifier_lock);
> +		if (amdxdna_umap_match(mapp, current->mm, addr, addr + len)) {
> +			up_read(&xdna->gpusvm.notifier_lock);
>  			return 0;
>  		}
>  	}
> -	up_read(&xdna->notifier_lock);
> +	up_read(&xdna->gpusvm.notifier_lock);

[Severity: Critical]
This problem wasn't introduced by this patch [1], but should
amdxdna_hmm_register() use vma->vm_mm instead of current->mm here and in
mmu_interval_notifier_insert_locked() below?

When mmap() runs from a worker on behalf of another task (such as via
io_uring), current->mm does not match vma->vm_mm. Attaching mapp->notifier
to current->mm misses invalidations in the target address space, allowing
the device to access freed or migrated pages, and prevents
amdxdna_hmm_unregister() (which checks vma->vm_mm) from finding and
unregistering mapp on teardown.

[1] https://sashiko.dev/#/bug/linux-aad73166-1806-490b-9ad1-d63c62db536d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106184217.2720=
718-1-lizhi.hou@amd.com?part=3D2
