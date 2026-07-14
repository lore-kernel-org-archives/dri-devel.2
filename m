Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3423C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 20:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1413110E096;
	Tue, 14 Jul 2026 20:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RIs6y68j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A8F10E0CC
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:30:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 82C0160103;
 Tue, 14 Jul 2026 20:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506B61F000E9;
 Tue, 14 Jul 2026 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784061009;
 bh=nLEgCC6WrugUrijpB2lzftQCkbLplk0YOIfI5k9qedc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RIs6y68jAJZmYrMYCqHE46d5oHU8XVZMRO4YsiFu956wYxby8npCSdw3J1ZACLM+l
 /cTwdVpHRbwY6Ou50llcoeZoPYgCcAYvPkxbhH5FF/nP1dMuWAKC+pv6YEXg5BKJeJ
 VtG3DhAORfzqOkC0inkhsGmgF7NlM94I9t2zGjHrZJdEaaNERaX6ZfBhbuizAW1w6K
 ykc8zPn1ZkXPHtEO3fmKMyp/mUOP5o8NYI+RolYIvi+WlrvBdfNciSzbOmUt3Sm2sq
 ji6qpPWnvkZX/RXD4ITpKPl9eo3x7DlBuwy2VgGBKTFEns2cLKZ/i9jumf7Pb36iLq
 9Z9n69M0WWNXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] fixup! drm/nouveau: use
 hmm_range_fault_unlocked_timeout() for SVM faults
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178406001808.1082778.17299764648397654220.stgit@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
 <178406001808.1082778.17299764648397654220.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 20:30:07 +0000
Message-Id: <20260714203008.506B61F000E9@smtp.kernel.org>
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
- [High] Removal of the absolute timeout in nouveau_range_fault() allows an=
 attacker to cause an infinite loop in the global GPU page fault worker thr=
ead, stalling all SVM faults.
--

--- Patch [2]: [PATCH 2/4] fixup! drm/nouveau: use hmm_range_fault_unlocked=
_timeout() for SVM faults ---
commit acde5c43961cd86d28658d26f11cdfcde5a9ad23
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

fixup! drm/nouveau: use hmm_range_fault_unlocked_timeout() for SVM faults

This commit updates nouveau_range_fault() to pass the full relative timeout
to hmm_range_fault_unlocked_timeout() on each attempt. It also removes the
open-coded absolute deadline and remaining-time calculation, replacing the
bounded while loop with a goto-based retry loop.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouv=
eau/nouveau_svm.c
> index 4cfb6eb7c7715..b1415c2e49fcc 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
[ ... ]
> @@ -677,25 +676,16 @@ static int nouveau_range_fault(struct nouveau_svmm =
*svmm,
>  	range.start =3D notifier->notifier.interval_tree.start;
>  	range.end =3D notifier->notifier.interval_tree.last + 1;
> =20
> -	while (true) {
> -		if (time_after(jiffies, timeout)) {
> -			ret =3D -EBUSY;
> -			goto out;
> -		}
> -
> -		ret =3D hmm_range_fault_unlocked_timeout(&range,
> -						       max(timeout - jiffies,
> -							   1L));
> -		if (ret)
> -			goto out;
> +again:
> +	ret =3D hmm_range_fault_unlocked_timeout(&range, timeout);
> +	if (ret)
> +		goto out;
> =20
> -		mutex_lock(&svmm->mutex);
> -		if (mmu_interval_read_retry(range.notifier,
> -					    range.notifier_seq)) {
> -			mutex_unlock(&svmm->mutex);
> -			continue;
> -		}
> -		break;
> +	mutex_lock(&svmm->mutex);
> +	if (mmu_interval_read_retry(range.notifier,
> +				    range.notifier_seq)) {
> +		mutex_unlock(&svmm->mutex);
> +		goto again;

[Severity: High]
Can this sequence lead to an infinite loop and stall the global GPU page fa=
ult
worker thread?

If a user-space program triggers an SVM page fault and simultaneously runs
memory invalidations like madvise(MADV_DONTNEED) in a loop on the same
memory range, mmu_interval_read_retry() will continuously return true.

Since this runs in a kernel worker thread, fatal_signal_pending(current)
inside hmm_range_fault_unlocked_timeout() will check the worker thread rath=
er
than the user process. With the absolute timeout removed from
nouveau_range_fault(), does this allow an attacker to loop here indefinitely
and block all other SVM faults?

>  	}
> =20
>  	nouveau_hmm_convert_pfn(drm, &range, args);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178405975214.108277=
8.5193079941156341151.stgit@skinsburskii?part=3D2
