Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52526C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7523410E4E2;
	Wed, 22 Jul 2026 21:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O+s41WrG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A76310E4E2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:59:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C201060051;
 Wed, 22 Jul 2026 21:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A591F000E9;
 Wed, 22 Jul 2026 21:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784757572;
 bh=Cs69w1XeZgx1dG6wbGBDMyL5GToaChKSmsoe5Ew6Uw4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O+s41WrGOKDTVWPg+hWnCf+Dd8iuejc5iXwl2PrFTkbQed91vupNtFWn+x3oMCR2r
 WGsIZOw5plX+/c2wAgn6bnUQUukvUxyNxATsG7UT16Bx/YyerWIWvL/vrFLX2GTkHH
 2xMjNXAvd1hv3dmU1ETv/roXzvV4VgFRDDmO/6sVW9Dm2IMnVtSCJ5xxcCqkV88krb
 ZlNrM7AobPEU0qmrsvgP/uNEwp55pjOupDr0UR/fBfnY93l4AbPDzbE2FcgbGumFSU
 1VqjeM+F1Qge8LJcmpu8GQg2oOqeciAV216TMapB9tCxxyi3mxdZeSMUILgLpJVrq5
 kK4XdSm/hVpWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-hmm-v10-v1-8-606464dd601a@gmail.com>
References: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
 <20260722-hmm-v10-v1-8-606464dd601a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:59:31 +0000
Message-Id: <20260722215932.41A591F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] TOCTOU race on volatile `jiffies` can result in a 0 timeout, causi=
ng an infinite loop.
- [High] The absolute outer deadline in `drm_gpusvm_get_pages()` is defeate=
d by the relative timeout extension semantics of `hmm_range_fault_unlocked_=
timeout()`.

Pre-existing issues:
- [High] Failure to allocate `pfns` in `drm_gpusvm_range_evict()` leaks the=
 `mm_struct` reference.
--

--- Patch [8]: [PATCH v10 8/8] drm/gpusvm: Use hmm_range_fault_unlocked_tim=
eout() for range faults ---
commit f0577dfbb2f6c27cfd07d3be42e1db31600b9e4d
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>
Subject: drm/gpusvm: Use hmm_range_fault_unlocked_timeout() for range faults

This commit replaces open-coded HMM fault retry loops in the GPU SVM paths
with the new hmm_range_fault_unlocked_timeout() helper. It updates
drm_gpusvm_scan_mm(), drm_gpusvm_range_evict(), and drm_gpusvm_get_pages()
to delegate mmap_lock acquisition and retry logic to the helper.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..b946f920b7a00 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
[ ... ]
> @@ -1408,6 +1392,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	void *zdd;
>  	unsigned long timeout =3D
>  		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +	unsigned long remaining;
>  	unsigned long i, j;
>  	unsigned long npages =3D npages_in_range(pages_start, pages_end);
>  	unsigned long num_dma_mapped;
> @@ -1422,9 +1407,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	struct dma_iova_state *state =3D &svm_pages->state;
> =20
>  retry:
> -	if (time_after(jiffies, timeout))
> +	if (time_after_eq(jiffies, timeout))
>  		return -EBUSY;
> =20
> +	remaining =3D timeout - jiffies;

[Severity: High]
Does this double read of jiffies introduce a race condition?

Because jiffies is volatile, it is fetched from memory for the
time_after_eq() check, and then fetched again for the subtraction. If
jiffies increments between these reads, remaining can evaluate to 0
(if jiffies equals timeout) or ULONG_MAX (if jiffies ticks past timeout).

When remaining is 0, hmm_range_fault_unlocked_timeout() disables the
deadline entirely. When it is ULONG_MAX, the timeout is effectively
infinite, which could hang the page-fault worker.

>  	hmm_range.notifier_seq =3D mmu_interval_read_begin(notifier);
>  	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
>  		goto set_seqno;
> @@ -1439,21 +1426,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	}
> =20
>  	hmm_range.hmm_pfns =3D pfns;
> -	while (true) {
> -		mmap_read_lock(mm);
> -		err =3D hmm_range_fault(&hmm_range);
> -		mmap_read_unlock(mm);
> -
> -		if (err =3D=3D -EBUSY) {
> -			if (time_after(jiffies, timeout))
> -				break;
> -
> -			hmm_range.notifier_seq =3D
> -				mmu_interval_read_begin(notifier);
> -			continue;
> -		}
> -		break;
> -	}
> +	err =3D hmm_range_fault_unlocked_timeout(&hmm_range, remaining);

[Severity: High]
Does passing remaining defeat the absolute deadline intended for this path?

The commit message notes that drm_gpusvm_get_pages() keeps an absolute outer
deadline to prevent endless invalidation retry loops from hanging GPU
page-fault workers.

However, hmm_range_fault_unlocked_timeout() treats the passed value as a
relative timeout and recalculates its internal deadline every time the lock
is dropped:

mm/hmm.c:hmm_range_fault_unlocked_timeout() {
    ...
    if (timeout && !locked)
        deadline =3D jiffies + timeout;
    ...
}

Since remaining is passed as the full timeout budget, the helper will extend
its deadline by the full amount of remaining into the future every time it
drops the lock, which can allow an infinite loop.

>  	mmput(mm);
>  	if (err)
>  		goto err_free;
[ ... ]
> @@ -1736,24 +1708,12 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpu=
svm,
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does this error path leak the mm_struct
reference?

Earlier in drm_gpusvm_range_evict(), the code acquires an mm reference:

    if (!mmget_not_zero(mm))
        return -EFAULT;

If kvmalloc_array() fails, the function returns -ENOMEM directly, bypassing
the mmput(mm) call at the end of the function. This permanently leaks the mm
reference, preventing the target process's memory structures from being fre=
ed
upon exit.

> =20
>  	hmm_range.hmm_pfns =3D pfns;
> -	while (!time_after(jiffies, timeout)) {
> -		hmm_range.notifier_seq =3D mmu_interval_read_begin(notifier);
> -		if (time_after(jiffies, timeout)) {
> -			err =3D -ETIME;
> -			break;
> -		}
> -
> -		mmap_read_lock(mm);
> -		err =3D hmm_range_fault(&hmm_range);
> -		mmap_read_unlock(mm);
> -		if (err !=3D -EBUSY)
> -			break;
> -	}
> +	err =3D hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
> =20
>  	kvfree(pfns);
>  	mmput(mm);
> =20
> -	return err;
> +	return err =3D=3D -EBUSY ? -ETIME : err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-hmm-v10-v1=
-0-606464dd601a@gmail.com?part=3D8
