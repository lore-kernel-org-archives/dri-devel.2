Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4DBC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 20:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B556E882D0;
	Tue, 14 Jul 2026 20:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QU5qSweR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B44C10E096
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:24:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81B4760103;
 Tue, 14 Jul 2026 20:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D851F000E9;
 Tue, 14 Jul 2026 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784060656;
 bh=+apwg8Fe1wTRyIxb1Wx/HRBQmjnk5ZMI+G9B0y0OaEk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QU5qSweRw8YtbAwnXonZeHTfS4hbPkRiwThtLruEoFhKc1tu8ic3eRHTRViq+os1D
 eTclpQEmKYIT4i2FtA0X8qRbqeGbwS9/iVAEKEQwFIifxIWRTaqRm5vvs20uVrVsee
 jBF1robR0zQk7LqUgiSNcLG/ijF5G3WO+6sx4DD4worLurEPuNGQlP5JHu8U8Hpm1l
 5dxkDr4+T3cYp7TZcrSWH++xVlxFhnfsUWr18m+dhK3jj+gZtPDuFX48ow1mPhIT6/
 C5rR7tsQcMNS76zBpDAj9dAHwp18ziZFq9RpltXGAIpb1N7mLLvm4+15lsLtP1OssC
 VJE7FiqVFfirQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] fixup! drm/gpusvm: use
 hmm_range_fault_unlocked_timeout() for range faults
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178406003318.1082778.16211328573488321338.stgit@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
 <178406003318.1082778.16211328573488321338.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 20:24:15 +0000
Message-Id: <20260714202416.15D851F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] drm_gpusvm passes uninitialized pfns arrays to hmm_range_fault, ca=
using unintended page faults and write requests.
- [High] Memory leak of `mm_struct` in `drm_gpusvm_range_evict` on allocati=
on failure.
--

--- Patch [4]: [PATCH 4/4] fixup! drm/gpusvm: use hmm_range_fault_unlocked_=
timeout() for range faults ---
commit afecb2c70fcbb0789fe0b4b948e05bb9f8070c63
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults

The patch removes the outer deadline tracking from hmm_range_fault loops
and passes msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT) directly to each
hmm_range_fault_unlocked_timeout() call. This avoids accounting for outer
driver retry logic inside the HMM retry budget.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index b8f2dd9982f53..76e8a0028c7fc 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -867,8 +866,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct=
 drm_gpusvm_range *range,
>  	hmm_range.hmm_pfns =3D pfns;
> =20
>  retry:
> -	err =3D hmm_range_fault_unlocked_timeout(&hmm_range,
> -					       max(timeout - jiffies, 1L));
> +	err =3D hmm_range_fault_unlocked_timeout(&hmm_range, timeout);

[Severity: High]
This is a pre-existing issue, but does using kvmalloc_array() without
zeroing memory cause unintended page faults?

HMM reads hmm_pfns as input to determine per-page fault requests. The
uninitialized memory can contain random bits like HMM_PFN_REQ_FAULT or
HMM_PFN_REQ_WRITE, potentially triggering unintended faults or violating
read-only mapping constraints.=20

Additionally, the retry loop reuses output flags (HMM_PFN_VALID), which
aliases with HMM_PFN_REQ_FAULT (both are the MSB), unintentionally forcing
faults on previously valid pages during a scan.

Should this allocate with kvcalloc() instead?

[ ... ]

> @@ -1495,8 +1489,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	}
> =20
>  	hmm_range.hmm_pfns =3D pfns;
> -	err =3D hmm_range_fault_unlocked_timeout(&hmm_range,
> -				max_t(long, timeout - jiffies, 1));
> +	err =3D hmm_range_fault_unlocked_timeout(&hmm_range, timeout);

[Severity: High]
This is also a pre-existing issue, but similar to drm_gpusvm_scan_mm(),
pfns is allocated with kvmalloc_array() earlier in drm_gpusvm_get_pages()
and passed to hmm_range_fault_unlocked_timeout() here.

Could this uninitialized memory cause unintended write requests or page
faults?

[ ... ]

> @@ -1734,8 +1726,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusv=
m,
>  		return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does returning -ENOMEM here
leak the mm_struct?

Earlier in drm_gpusvm_range_evict(), mmget_not_zero(mm) increments the
reference count:

	if (!mmget_not_zero(mm))
		return -EFAULT;

	pfns =3D kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
	if (!pfns)
		return -ENOMEM;

If the kvmalloc_array() allocation for pfns fails, it returns directly
without calling mmput(mm).

> =20
>  	hmm_range.hmm_pfns =3D pfns;
> -	err =3D hmm_range_fault_unlocked_timeout(&hmm_range,
> -				max_t(long, timeout - jiffies, 1));
> +	err =3D hmm_range_fault_unlocked_timeout(&hmm_range, timeout);

[Severity: High]
This is a pre-existing issue, but again, pfns is allocated with
kvmalloc_array() and passed here. Does this need to be kvcalloc() to
prevent uninitialized memory from causing unintended page faults?

> =20
>  	kvfree(pfns);
>  	mmput(mm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178405975214.108277=
8.5193079941156341151.stgit@skinsburskii?part=3D4
