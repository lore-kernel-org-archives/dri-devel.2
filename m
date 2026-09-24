Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F52BC98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7BFB10F364;
	Thu, 24 Sep 2026 07:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DOfeHrag";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDB110F364
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:43:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62E4C60209;
 Thu, 24 Sep 2026 07:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E582C1F000FF;
 Thu, 24 Sep 2026 07:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790235784;
 bh=D2sXtPYa+ILg871cLjZey2URsuza8GY54cD1lrfNRcw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DOfeHragWGnZIgtQqivuE7AByN3AnCmf1YkAbVrfAOOEhYyWveZ0wT5WcMCz6mrxz
 YSobmYpE035vO7s3h6WnA6tV0vrwlWsFMe40cK24J2DpQeCXaPG1kwer5/B0h8pzq1
 GJloblnaXY4GSFNZW0dXJKwteccnCP14r37PvOovDQIGq0kIVORHt7v3MhHW0iKIeX
 zKi++ixQc8htRQfSO2Nh9Rj0JC3S56yapHaftchQFaEGnu8qKe67VY+CEmpEFou4C7
 FWQDx7mk8GyA0sesDUQFbpa/Lbji2ES0hN2nOua9GiYWlAVB8Czo2zZGjN2X6NtJY1
 +Ka6QP2UoMGbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] drm/imagination: Propagate all errors from KCCB
 command submission code
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-2-584796cb599d@imgtec.com>
References: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-0-584796cb599d@imgtec.com>
 <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-2-584796cb599d@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:43:03 +0000
Message-Id: <20260924074303.E582C1F000FF@smtp.kernel.org>
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
- [High] drm/imagination: CCCB state corruption and GPU UAF on job kick fai=
lure
- [Medium] drm/imagination: KCCB slot reservation leak on device loss
--

commit ceda87571c98c414f17508dd17e12fa1ee009e5d
Author: Alessio Belle <alessio.belle@imgtec.com>
Date:   Thu Sep 24 07:29:44 2026 +0000

drm/imagination: Propagate all errors from KCCB command submission code

This commit modifies pvr_kccb_send_cmd_reserved_powered() to return an int
instead of void, propagating command submission errors up the stack. These
errors now reach the DRM scheduler's run_job() callback.

> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imag=
ination/pvr_ccb.c
> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
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
When the device is lost, does this early return leak the KCCB slot reservat=
ion?

Looking at pvr_kccb_send_cmd_powered(), it reserves a slot via
pvr_kccb_reserve_slot_sync() which increments pvr_dev->kccb.reserved_count.
It then calls this function. By returning early here, reserved_count is nev=
er
decremented, leaking the slot permanently.

> =20
>  	mutex_lock(&pvr_ccb->lock);
> =20
> -	if (WARN_ON(!pvr_dev->kccb.reserved_count))
> +	if (WARN_ON(!pvr_dev->kccb.reserved_count)) {
> +		err =3D -EINVAL;
>  		goto out_unlock;
> +	}

[ ... ]

> @@ -374,8 +392,7 @@ pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev,=
 struct rogue_fwif_kccb_cmd
>  	if (err)
>  		return err;
> =20
> -	pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
> -	return 0;
> +	return pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
>  }

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -793,15 +793,15 @@ static struct dma_fence *pvr_queue_run_job(struct d=
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
> =20
>  		trace_pvr_job_submit_fw(geom_job);
>  		trace_pvr_job_submit_fw(frag_job);
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
Does propagating the error here corrupt the CCCB state and potentially caus=
e a
use-after-free?

Looking at the full context of pvr_queue_run_job(), if the kick fails, the
error is caught and handled in the error path:

	if (WARN_ON(err))
		goto err_release;
=09
	...

err_release:
	pvr_kccb_release_slot(pvr_dev);
	return ERR_PTR(err);

By this point, pvr_queue_submit_job_to_cccb() has already modified the CCCB
state, including incrementing queue->in_flight_job_count and writing the
commands to the CCCB. The err_release path aborts the DRM scheduler job wit=
hout
reverting these changes.

If the job is aborted, its resources can be freed by userspace, but its
commands remain in the CCCB. When the next job is successfully kicked, the =
GPU
will execute the aborted job's commands, leading to a use-after-free of the
freed GPU buffers. Additionally, queue->in_flight_job_count is left permane=
ntly
desynchronized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-b4-upstrea=
m-propagate-all-errors-from-kccb-cmd-submission-code-v7-0-584796cb599d@imgt=
ec.com?part=3D2
