Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526C6C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A29C10F33F;
	Thu, 24 Sep 2026 07:38:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vr0aBzBH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4384E10F33F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:38:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9905F6022C;
 Thu, 24 Sep 2026 07:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A771F000FF;
 Thu, 24 Sep 2026 07:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790235510;
 bh=eBPOvIKQ6FpJWXWYIhJ7y1p+xRfM1I5q5InzDWI++bY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vr0aBzBH3L2DMg8swKtelzUgbD+zNdom0WXehLmzH9sXZTO+KsZWThAJH8bmkZGEi
 FUbNKJj6G2qXWzKpuPRrmkVmZXlpjdR3DhPHCcFtfbduPDDsB8FC2hX6IH7vhI/nQn
 JURBxUu1xa2Tp148iSQFDnSxPedPKBK6qhwiIgNgMTnBlmB3aTK5v68AUlUfx5LuNd
 sVKguExsUcw69QSE9nHsGBWIi8n8xGN5Z+xlmlyy7kkdF3RL8uDzypeI31PwGUeUo+
 P2VG2uxFGh46TFxSE1uD/+WBNHd6eqWjTD7uQPJyPQPDUj8A0n3lF99LT1E1iTZlB9
 DxzH8gpcbc7zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] drm/imagination: Release pm references in case
 of error
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-3-584796cb599d@imgtec.com>
References: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-0-584796cb599d@imgtec.com>
 <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-3-584796cb599d@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:38:29 +0000
Message-Id: <20260924073830.26A771F000FF@smtp.kernel.org>
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
- [Medium] drm/imagination: misplaced code adds dead block and fails to fix=
 PM leaks
--

commit ee55e37dd6c9d6ec50a0931a6efbed821fcc945d
Author: Alexandru Dadu <alexandru.dadu@imgtec.com>
drm/imagination: Release pm references in case of error

This commit attempts to fix power management reference leaks by adding early
releases on error.

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index b58c0887cafe5..c72f1d0b8bc00 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -820,6 +820,19 @@ static struct dma_fence *pvr_queue_run_job(struct dr=
m_sched_job *sched_job)
>  	if (WARN_ON(err))
>  		goto err_release;
> =20
> +	err =3D pvr_job_get_pm_ref(job);
> +
> +	if (WARN_ON(err))
> +		goto err_release;
> +
> +	if (job->paired_job) {
> +		err =3D pvr_job_get_pm_ref(job->paired_job);
> +		if (WARN_ON(err)) {
> +			pvr_job_release_pm_ref(job);
> +			goto err_release;
> +		}
> +	}
> +

[Severity: Medium]
Does this block act as dead code instead of fixing the error paths?

This code is placed in the success path of pvr_queue_run_job() where the PM
references are already successfully held from earlier in the function. Beca=
use
job->has_pm_ref is already true when execution reaches here,
pvr_job_get_pm_ref() simply returns 0 and does nothing.

>  	return dma_fence_get(job->done_fence);
> =20
>  err_release:
>  	pvr_kccb_release_slot(pvr_dev);
>  	return ERR_PTR(err);
>  }

[Severity: Medium]
Does the targeted PM leak remain unfixed in this error path?

When an internal job submission fails (for example, if
pvr_cccb_send_kccb_kick() fails) and execution jumps to err_release, the PM
references acquired earlier in the function are not released, which would l=
eak
the references and prevent the GPU from entering runtime suspend.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-b4-upstrea=
m-propagate-all-errors-from-kccb-cmd-submission-code-v7-0-584796cb599d@imgt=
ec.com?part=3D3
