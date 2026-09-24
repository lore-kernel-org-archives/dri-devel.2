Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A766FC98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038A210F2F5;
	Thu, 24 Sep 2026 06:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jbSR7Hrk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D4A10F30E
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:31:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7EB340F4A;
 Thu, 24 Sep 2026 06:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804531F000FF;
 Thu, 24 Sep 2026 06:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790231502;
 bh=uI246G8mmRf5iNxf0lngvj9/gmTpBlRAfYpm7jbebps=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jbSR7HrksR1Fn/SmybDPYtQ+5ghJMLyO1KvfWkjqO8kB007OeFCjBDxUjKC76CHNY
 PN/0psTgRqWpgReAA6Q1xZ8WUKUzAsnQsnHC9CyVAcGl1iOlWsy+OPOWVNMCF2nkgc
 J/I8ahYM2yYBFF+04l+4IR2N62pm9u24XY93rUjjdtzaK6y0pzWeM+dK10w5rorvN9
 YEUIpIevJsy5eWpotOkIBKPwoZiA/eYLo/rL0KRs+hU/owYZBPfy9cZmDJjUD9eYLw
 usjtIM9/WOU/uq0RYZD6W1NOJZALF1ZBlZfuS2mXdmW0NGxSitXeSOwGPIJ3A//TIO
 FVS63UwfpR6MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] drm/imagination: Propagate all errors from KCCB
 command submission code
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-2-d9d5375665ed@imgtec.com>
References: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-0-d9d5375665ed@imgtec.com>
 <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v6-2-d9d5375665ed@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:31:42 +0000
Message-Id: <20260924063142.804531F000FF@smtp.kernel.org>
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
- [High] drm/imagination: use-after-free and state corruption due to missin=
g CCCB rollback on KCCB kick failure
- [Medium] drm/imagination: resource leak of KCCB slot reservations on error
--

commit a2bdc84028e3fc1451749b3764c3318c1a8c6d75
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Propagate all errors from KCCB command submission code

This commit updates the KCCB command submission code to propagate errors
back to the caller. The DRM scheduler's run_job callback is updated to
return these errors instead of unconditionally succeeding.

> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imag=
ination/pvr_ccb.c
> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
[ ... ]
> @@ -264,19 +269,25 @@ pvr_kccb_send_cmd_reserved_powered(struct pvr_devic=
e *pvr_dev,
>  	struct rogue_fwif_ccb_ctl *ctrl =3D pvr_ccb->ctrl;
>  	u32 old_write_offset;
>  	u32 new_write_offset;
> +	int err;
> =20
> -	WARN_ON(pvr_dev->lost);
> +	if (pvr_dev->lost)
> +		return -EIO;

[Severity: Medium]
If we return early here, does it leak the KCCB slot reservation?

When this is called from pvr_kccb_send_cmd_powered(), a slot has already=20
been reserved by incrementing pvr_dev->kccb.reserved_count. The success=20
path decrements this count later in the function, but this early return=20
does not, which could lead to slot starvation and eventual -EBUSY errors=20
on all future KCCB submissions.

[ ... ]
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
> @@ -809,9 +809,10 @@ static struct dma_fence *pvr_queue_run_job(struct dr=
m_sched_job *sched_job)
>  		struct pvr_queue *queue =3D container_of(job->base.sched,
>  						       struct pvr_queue, scheduler);
> =20
> -		pvr_cccb_send_kccb_kick(pvr_dev, &queue->cccb,
> -					pvr_context_get_fw_addr(job->ctx) + queue->ctx_offset,
> -					job->hwrt);
> +		err =3D pvr_cccb_send_kccb_kick(pvr_dev, &queue->cccb,
> +					      pvr_context_get_fw_addr(job->ctx) +
> +					      queue->ctx_offset,
> +					      job->hwrt);
> =20
>  		trace_pvr_job_submit_fw(job);
>  	}

[Severity: High]
If pvr_cccb_send_kccb_kick() fails here and pvr_queue_run_job() returns=20
ERR_PTR(err), could this lead to a use-after-free and state corruption?

Earlier in pvr_queue_run_job(), pvr_queue_submit_job_to_cccb() is called=20
which increments queue->in_flight_job_count and writes the job's commands=20
into the firmware's CCCB ring buffer. If the kick fails and the DRM=20
scheduler frees this job, the commands remain in the CCCB without being=20
rolled back.=20

When a subsequent job is successfully submitted, won't the firmware=20
process the leftover commands from the freed job, accessing freed resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-b4-upstrea=
m-propagate-all-errors-from-kccb-cmd-submission-code-v6-0-d9d5375665ed@imgt=
ec.com?part=3D2
