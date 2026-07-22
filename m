Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1208DC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6998710E4E9;
	Wed, 22 Jul 2026 21:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J/VOi871";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0615410E4E9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:53:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41E75600C3;
 Wed, 22 Jul 2026 21:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A5A1F000E9;
 Wed, 22 Jul 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784757237;
 bh=g/3DtZV/SJZfZJRD63GW8j79WaSAdUaUYeNTTmY1LGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J/VOi871GkbMhEY2kCd9eDR3qRVaX0cs7Qv7JfgH0JNVzOOhfXvhoYlpdJDDo4N4B
 UGganOGXig8rfgCZR4y1CGVQr+ququA1qm1XqjQXLLU1w3UMdPArw2fG4jTLvrNj4G
 3XjTOo39wxFUsCsZ6AjST3c2G9Xi4kZU9UIUv0ql3vUCyJe+70uwMQ3WUNLee0ed0l
 rzzgijpuiqki9qM9IWVtEYetyGllcwjKTJt2Tu9eJ9Vydw/qhsar0bRJlYDM1M/fzj
 ZrxBn8mbbVbyEn90Y2GrKPCllE6mkaDFsopLLu193jq1BE1/zL63NlD06U4QYhD+/H
 WhINNt1EvB28g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/8] selftests/mm: add HMM test for mmap
 lock-dropping faults
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-hmm-v10-v1-3-606464dd601a@gmail.com>
References: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
 <20260722-hmm-v10-v1-3-606464dd601a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:53:56 +0000
Message-Id: <20260722215356.C3A5A1F000E9@smtp.kernel.org>
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
- [Medium] `dmirror_range_fault_unlocked` fails to enforce an absolute time=
out for its `mmu_interval_read_retry` loop, leading to potential livelocks.
--

--- Patch [3]: [PATCH v10 3/8] selftests/mm: add HMM test for mmap lock-dro=
pping faults ---
commit e4ef68d1c56c2f5bfba882ccad54a4d7284e5403
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

selftests/mm: add HMM test for mmap lock-dropping faults

This commit adds test_hmm coverage for the HMM lock-dropping fault path.
It introduces a new ioctl that exercises the unbounded retry mode while
allowing the mmap lock to be dropped during fault handling, alongside a
corresponding userfaultfd read selftest.

> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 45c0cb9922184..6205fb313bd05 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c

[ ... ]

> @@ -389,6 +389,67 @@ static int dmirror_range_fault(struct dmirror *dmirr=
or,
>  	return ret;
>  }
> =20
> +static int dmirror_range_fault_unlocked(struct dmirror *dmirror,
> +					struct hmm_range *range,
> +					unsigned long timeout)
> +{
> +	int ret;
> +
> +	while (true) {
> +		ret =3D hmm_range_fault_unlocked_timeout(range, timeout);
> +		if (ret)
> +			goto out;
> +
> +		mutex_lock(&dmirror->mutex);
> +		if (mmu_interval_read_retry(range->notifier,
> +					    range->notifier_seq)) {
> +			mutex_unlock(&dmirror->mutex);
> +			continue;

[Severity: Medium]
Does this loop lack an absolute timeout enforcement?

When mmu_interval_read_retry() triggers a retry, the same relative timeout
value is passed back into hmm_range_fault_unlocked_timeout(). Because that
function calculates its internal deadline as jiffies + timeout, the
deadline gets pushed forward on every retry.

Could this lead to a livelock if this function is ever called with a non-ze=
ro
timeout, since the timeout resets infinitely during concurrent page table
invalidations?

> +		}
> +		break;
> +	}
> +
> +	ret =3D dmirror_do_fault(dmirror, range);
> +
> +	mutex_unlock(&dmirror->mutex);
> +out:
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-hmm-v10-v1=
-0-606464dd601a@gmail.com?part=3D3
