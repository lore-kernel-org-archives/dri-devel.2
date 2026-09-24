Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1497EC98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682A210F2F1;
	Thu, 24 Sep 2026 06:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UqYcb29U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FF710F2F1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:29:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9406240241;
 Thu, 24 Sep 2026 06:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDCB1F000FF;
 Thu, 24 Sep 2026 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790231350;
 bh=ogI+vEaXA6wAD7/2RMBy/SJLaNnbAiFLxRN5xGG8Zkg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UqYcb29Uj4SFPBUlZAM5fE5Ba25ITNGWCINrHsslsHsdGa1H/cAi8tuVGhgmsCiPe
 t0vhOukA3V513ogTL8DBZDuEjX7tNIi7azhMhUin2asr2ECbMdIG/NXDULlGgcB9Gf
 cABoy3Oxy2Uws9DKYkJnU7drJF9OzQ870r6lLIZvK3Znkl9g/Z9VZ+o2JcZdZRHz8A
 STfLWoVwDmExs/eJehzsTcSZ3+7BQimPXNkW1CFAOQpJ81ucH1HpVLx1qct1PkjRyP
 eATlHy6QZfToy7HWMu89jOBa4RArgwWsxW6g1Y1JZA2YTCRgOKe7J3Xp43ehnfGEkp
 aIMxAZsUoYorA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] drm/imagination: Release pm references in case
 of error
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-3-d9d5375665ed@imgtec.com>
References: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-0-d9d5375665ed@imgtec.com>
 <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-3-d9d5375665ed@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:29:09 +0000
Message-Id: <20260924062910.4DDCB1F000FF@smtp.kernel.org>
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
- [High] drm/pvr: misplaced pm_ref get clobbers submission error
- [Medium] drm/pvr: misapplied PM reference error handling is dead code
--

commit 5439537ea7866cb6e72eceafcbe08fbac4918034
Author: Alexandru Dadu <alexandru.dadu@imgtec.com>

drm/imagination: Release pm references in case of error
   =20
This commit attempts to add early release of power references in case of
errors during job submission.

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index b58c0887cafe5..1b013791897dd 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c

[ ... ]

> @@ -817,9 +817,19 @@ static struct dma_fence *pvr_queue_run_job(struct dr=
m_sched_job *sched_job)
>  		trace_pvr_job_submit_fw(job);
>  	}
> =20
> +	err =3D pvr_job_get_pm_ref(job);
> +

[Severity: High]
Does this assignment overwrite the err variable containing the result of the
KCCB kick?

If pvr_cccb_send_kccb_kick() or pvr_cccb_send_kccb_combined_kick() returned
an error, pvr_job_get_pm_ref() will return 0 since the reference was already
acquired at the start of pvr_queue_run_job(). This causes the hardware
submission error to be lost, and the scheduler will receive a success
indication instead of an error.

>  	if (WARN_ON(err))
>  		goto err_release;
> =20
> +	if (job->paired_job) {
> +		err =3D pvr_job_get_pm_ref(job->paired_job);
> +		if (WARN_ON(err)) {
> +			pvr_job_release_pm_ref(job);
> +			goto err_release;

[Severity: Medium]
Is this error handling logic unreachable?

Because the PM reference for job->paired_job was already acquired at the
beginning of the function, pvr_job_get_pm_ref() will return 0, making the
WARN_ON(err) condition unreachable.

If this abort path were somehow reached after the job was successfully
submitted to the hardware, jumping to err_release would inappropriately call
pvr_kccb_release_slot(). Could this corrupt KCCB slot accounting since the
hardware kick already occurred?

> +		}
> +	}
> +
>  	return dma_fence_get(job->done_fence);
> =20
>  err_release:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-b4-upstrea=
m-propagate-all-errors-from-kccb-cmd-submission-code-v6-0-d9d5375665ed@imgt=
ec.com?part=3D3
