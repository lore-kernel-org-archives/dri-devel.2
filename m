Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975EDC79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD24B10E0D2;
	Mon,  7 Sep 2026 10:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oQIsitGm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BE310E0D2
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 10:31:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65A7C60AB5;
 Mon,  7 Sep 2026 10:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE71F00A3A;
 Mon,  7 Sep 2026 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788777072;
 bh=+uIJneDhRLM2Z2YLcWPJC+Jk7NJsUuOCT++U12ET0N8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oQIsitGmdRnKpLIJBzDbJmL4oE0viDNl4gsnDwIgLPjygGxWFWOKlln1vPTA4p+Q7
 rZ+rfaXDFKr1tcjbXSenBPcyAA+NYyJnJqDZqjXf4gtbE0gNj915XYroTM0W5rTuvg
 eMfSAHPYgpMryNj9eGtVeBXfr1/kuxvkUK824+bsNk3lcT9dEBqb3jkzCgRoJuRIJ8
 tacyJg3NS7WFRNB57X1DSLHij7b1CcGiesCwV0YcRCJH6sC6InbteAUaukSDvbLMkN
 LBz4GjpQgBZ7Ua2brYkTuMpFjKxyeM6JlmOBDUj10rDyRP0CCzCxVV5eYUgzhRLlvZ
 7ab7BtRKxUvhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/imagination: Propagate all errors from KCCB
 command submission code
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v4-1-b684f58a06ce@imgtec.com>
References: <20260907-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v4-1-b684f58a06ce@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:31:11 +0000
Message-Id: <20260907103111.EFAE71F00A3A@smtp.kernel.org>
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
- [High] State Corruption and Use-After-Free due to missing CCCB rollback o=
n KCCB kick failure.
- [Medium] KCCB slot reservation leak on error paths in pvr_kccb_send_cmd_p=
owered().

Pre-existing issues:
- [High] Paired fragment job hangs indefinitely if its paired geometry job =
fails early.
--

commit 169ea0ff06e137cf7e22eac4d32e0b8218dddecb
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Propagate all errors from KCCB command submission code

This patch updates pvr_kccb_send_cmd_reserved_powered() to return an int
instead of void, allowing it to propagate errors. The error is now correctly
propagated to the DRM scheduler's run_job callback in pvr_queue_run_job().

Link: https://patch.msgid.link/20260907-b4-upstream-propagate-all-errors-fr=
om-kccb-cmd-submission-code-v3-1-4578a0fadf69@imgtec.com

> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imag=
ination/pvr_ccb.c
> index b702d122d7918..dfd0682705425 100644
> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
[ ... ]
> @@ -268,19 +273,25 @@ pvr_kccb_send_cmd_reserved_powered(struct pvr_devic=
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
If pvr_kccb_send_cmd_reserved_powered() is called by
pvr_kccb_send_cmd_powered() after a successful pvr_kccb_reserve_slot_sync(),
the slot reservation count has been incremented. Returning early with -EIO
here avoids consuming the slot, but does this skip releasing the reservatio=
n?
If pvr_kccb_release_slot() is never called for this error path, it might
slowly leak KCCB slot capacity until no commands can be submitted.

[ ... ]
> @@ -378,8 +396,7 @@ pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev,=
 struct rogue_fwif_kccb_cmd
>  	if (err)
>  		return err;
> =20
> -	pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
> -	return 0;
> +	return pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
>  }

[Severity: Medium]
Similarly, when pvr_kccb_send_cmd_reserved_powered() fails and returns an
error, the caller pvr_kccb_send_cmd_powered() just propagates this error
without calling pvr_kccb_release_slot(). Could this permanently leak the
slot reservation acquired by pvr_kccb_reserve_slot_sync() earlier in the
same function?

[ ... ]
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 09993e858df8b..ffac59ee8ae52 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -769,17 +769,19 @@ static struct dma_fence *pvr_queue_run_job(struct d=
rm_sched_job *sched_job)
>  		    (job->type !=3D DRM_PVR_JOB_TYPE_GEOMETRY ||
>  		     job->paired_job->type !=3D DRM_PVR_JOB_TYPE_FRAGMENT ||
>  		     job->hwrt !=3D job->paired_job->hwrt ||
> -		     job->ctx !=3D job->paired_job->ctx)))
> -		return ERR_PTR(-EINVAL);
> +		     job->ctx !=3D job->paired_job->ctx))) {
> +		err =3D -EINVAL;
> +		goto err_release;
> +	}
> =20
>  	err =3D pvr_job_get_pm_ref(job);
>  	if (WARN_ON(err))
> -		return ERR_PTR(err);
> +		goto err_release;
> =20
>  	if (job->paired_job) {
>  		err =3D pvr_job_get_pm_ref(job->paired_job);
>  		if (WARN_ON(err))
> -			return ERR_PTR(err);
> +			goto err_release;
>  	}

[Severity: High]
This is a pre-existing issue, but it is further exposed by this new early
failure check. If a paired geometry job fails early here and returns an err=
or,
the geometry job aborts. However, the paired fragment job's execution of
pvr_queue_run_job() unconditionally returns its done_fence:

    if (job->paired_job && job->type =3D=3D DRM_PVR_JOB_TYPE_FRAGMENT &&
        job->done_fence->ops) {
            return dma_fence_get(job->done_fence);
    }

Since the fragment job relies entirely on the geometry job to submit both
jobs to the hardware, does this early failure leave the fragment job waiting
forever for a fence that will never signal, permanently hanging the fragment
queue scheduler?

> =20
>  	/* Submit our job to the CCCB */
> @@ -793,25 +795,33 @@ static struct dma_fence *pvr_queue_run_job(struct d=
rm_sched_job *sched_job)
> =20
>  		/* Submit the fragment job along the geometry job and send a combined =
kick. */
>  		pvr_queue_submit_job_to_cccb(frag_job);
> -		pvr_cccb_send_kccb_combined_kick(pvr_dev,
> -						 &geom_queue->cccb, &frag_queue->cccb,
> -						 pvr_context_get_fw_addr(geom_job->ctx) +
> -						 geom_queue->ctx_offset,
> -						 pvr_context_get_fw_addr(frag_job->ctx) +
> -						 frag_queue->ctx_offset,
> -						 job->hwrt,
> -						 frag_job->fw_ccb_cmd_type =3D=3D
> -						 ROGUE_FWIF_CCB_CMD_TYPE_FRAG_PR);
> +		err =3D pvr_cccb_send_kccb_combined_kick(pvr_dev,
> +						       &geom_queue->cccb, &frag_queue->cccb,
> +						       pvr_context_get_fw_addr(geom_job->ctx) +
> +						       geom_queue->ctx_offset,
> +						       pvr_context_get_fw_addr(frag_job->ctx) +
> +						       frag_queue->ctx_offset,
> +						       job->hwrt,
> +						       frag_job->fw_ccb_cmd_type =3D=3D
> +						       ROGUE_FWIF_CCB_CMD_TYPE_FRAG_PR);
>  	} else {
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
>  	}
> =20
> +	if (WARN_ON(err))
> +		goto err_release;

[Severity: High]
When pvr_queue_submit_job_to_cccb() executes, it copies the job commands in=
to
the shared Client Circular Command Buffer (CCCB) and advances the local
write_offset.

If the subsequent firmware kick fails and returns an error, the new error
handling path jumps to err_release and returns ERR_PTR(err). The DRM
scheduler then frees the job and its associated memory.

However, the driver does not roll back the CCCB write_offset. When a future
job successfully kicks the KCCB, will the firmware process the aborted job's
commands from the CCCB and attempt to access memory that the host has alrea=
dy
freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-b4-upstrea=
m-propagate-all-errors-from-kccb-cmd-submission-code-v4-1-b684f58a06ce@imgt=
ec.com?part=3D1
