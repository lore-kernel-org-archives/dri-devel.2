Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581E0C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CF910E720;
	Mon,  7 Sep 2026 09:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NbPukJeG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FE610E720
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:29:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD7A343DD0;
 Mon,  7 Sep 2026 09:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4051F00A3A;
 Mon,  7 Sep 2026 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788773373;
 bh=U4G5mHrs1rECtxFWx801lsLwv0DQTmLbnlopsLhRqjQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NbPukJeGXOyFrDzSzoa4IHXfwY1k8hzQGcsD5q60xq51Vuzr8sivdpiv8wz3djIQJ
 e1qcsBeLs9jlSASOzpoMzCCrCKT9w0z2gyAM+7uaXfedH2AOOQto0w/aZRlXotY8ZD
 KTM0xJ9ozNZmPWmOKUQhzajHYPTg6lwC3fNS9pAz7uV9mg1Dy1OexGeBcnkVMbrBjM
 bu/o5+gpdLRFjOxpydClFf/Dl1jVkepkq5f8D4X/SEF0QcyISgMEu5NU9fOqSgFqKn
 WPtk2wCvrL3ke+OHEfjR19eQ8Mf+6NQiysacLo88sbrNJyN6EKs+sJlIk1IKg0hoEw
 WtwWEMJI02RtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/imagination: Propagate all errors from KCCB
 command submission code
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v3-1-4578a0fadf69@imgtec.com>
References: <20260907-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v3-1-4578a0fadf69@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 09:29:33 +0000
Message-Id: <20260907092933.AE4051F00A3A@smtp.kernel.org>
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
- [High] Unchecked error assignment in `pvr_queue_run_job()` completely ign=
ores the propagated KCCB error, causing the function to falsely report succ=
ess to the DRM scheduler and bypass cleanup.
- [High] KCCB slot reservation is leaked in `pvr_kccb_send_cmd_powered()` w=
hen `pvr_kccb_send_cmd_reserved_powered()` fails.
--

commit 37f41df35ee17941516339510b33ee61bff243f1
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Propagate all errors from KCCB command submission code

This commit updates pvr_kccb_send_cmd_reserved_powered to return an
integer error code instead of void. It propagates these errors up to the
DRM scheduler's run_job callback, adding error paths to
pvr_queue_run_job.

> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imag=
ination/pvr_ccb.c
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

[Severity: High]
Does this code leak the KCCB slot reservation when a command fails?

In pvr_kccb_send_cmd_powered(), a slot is successfully reserved via
pvr_kccb_reserve_slot_sync(). However, the patch adds an early return path =
in
pvr_kccb_send_cmd_reserved_powered() that returns -EIO if pvr_dev->lost is =
true.
When this occurs, pvr_kccb_send_cmd_powered() directly returns this error b=
ut
does not call pvr_kccb_release_slot() to unwind the successful reservation,
permanently leaking the KCCB slot.

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c

[ ... ]

> @@ -793,25 +795,30 @@ static struct dma_fence *pvr_queue_run_job(struct d=
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
>  	return dma_fence_get(job->done_fence);
> +
> +err_release:
> +	pvr_kccb_release_slot(pvr_dev);
> +	return ERR_PTR(err);
>  }

[Severity: High]
Does this code falsely report success to the DRM scheduler when a kick fail=
s?

In pvr_queue_run_job(), the return value from the KCCB kick functions is
assigned to the err variable but is never evaluated. The function proceeds
unconditionally to return success via dma_fence_get(job->done_fence) instead
of checking if err is non-zero and branching to the err_release label.

If a KCCB kick fails, this bypasses the intended cleanup path in err_release
and notifies the DRM scheduler of success for a job that was not sent to the
hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-b4-upstrea=
m-propagate-all-errors-from-kccb-cmd-submission-code-v3-1-4578a0fadf69@imgt=
ec.com?part=3D1
