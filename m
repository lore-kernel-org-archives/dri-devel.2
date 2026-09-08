Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3652FC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CB310EA4B;
	Tue,  8 Sep 2026 07:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BQPT05Zc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F84510EA3E
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:36:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E969601DB;
 Tue,  8 Sep 2026 07:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB131F00A3A;
 Tue,  8 Sep 2026 07:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788852986;
 bh=TWgLeXn/XAnbhfbNSo0SFTJ2P5whhvomnAy4yjqKkaU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BQPT05Zc9aegjvjQhuiV08CM3tkHsBHGV1R2y6D01XiONdeaUsvXGyTQAel8hJV7g
 cZtK8KrwMNg0L6WAlMKQD81/5/uqgJo0eMoIrh0Bj9O4PgOlcgwZDKlHK7YMZnkt9u
 2m8qzDBpZCqvItlximFXTVPoOqs6F4VN737xgC5yNW6F4FpIiHDDOUdG+OOsdXHwOa
 M7LFkabyoQ4KhM/6MP9p43qMi3RuEbDM5w/eveJQipgbtnbHmrhoVK1NBHqEturTKd
 yTD9LMUskC4LgQAoNvEeAuUB/haJ+Q20THvHVYY35U44z4/AnVhatSmxvM2zBayVFy
 Q6WYpLjKEwGHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/imagination: Propagate all errors from KCCB
 command submission code
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v5-1-5e262721454b@imgtec.com>
References: <20260908-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v5-1-5e262721454b@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:36:25 +0000
Message-Id: <20260908073625.DAB131F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Unrecoverable queue state, CCCB corruption, and Use-After-Free=
 when a KCCB kick fails in pvr_queue_run_job().
- [High] KCCB slot reservation leak in pvr_kccb_send_cmd_powered() on error.
- [Medium] WARN_ON(err) triggers continuously when the device is lost, floo=
ding dmesg.

Pre-existing issues:
- [High] Paired fragment job hangs indefinitely when the geometry job fails=
 to acquire PM reference or fails the KCCB kick.
- [High] Kernel's CCCB `write_offset` is not reset during a GPU hard reset,=
 causing immediate firmware faults on subsequent submissions.
--

commit 71ee1590b98c30900f70c9456403e8740176ca27
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Propagate all errors from KCCB command submission code

This commit updates the KCCB kick command variants to propagate errors
up to the DRM scheduler's run_job callback. It introduces error checking
in pvr_queue_run_job and early returns for lost devices.

Link: https://patch.msgid.link/20260907-b4-upstream-propagate-all-errors-fr=
om-kccb-cmd-submission-code-v4-1-b684f58a06ce@imgtec.com

> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imag=
ination/pvr_ccb.c
> index b702d122d7918..dfd0682705425 100644
> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
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

[Severity: High]
Does this early return cause a permanent resource leak of KCCB slot
reservations?

When the device is lost, this returns -EIO directly and bypasses the success
path where pvr_dev->kccb.reserved_count-- is decremented.

Is a call to pvr_kccb_release_slot() needed here or in the caller to undo
the reservation?

[ ... ]
> @@ -378,8 +396,7 @@ pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev,=
 struct rogue_fwif_kccb_cmd
>  	if (err)
>  		return err;
> =20
> -	pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
> -	return 0;
> +	return pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);

[Severity: High]
Similarly, if pvr_kccb_send_cmd_reserved_powered() fails, does this direct
return propagate the error without releasing the slot reserved earlier in t=
his
function by pvr_kccb_reserve_slot_sync()?

[ ... ]
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 09993e858df8b..8aba8fbfccfa4 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
>  	if (job->paired_job) {
>  		err =3D pvr_job_get_pm_ref(job->paired_job);
>  		if (WARN_ON(err))
> -			return ERR_PTR(err);
> +			goto err_release;

[Severity: High]
This is a pre-existing issue, but can an early failure here (like failing to
acquire the PM ref) or during a KCCB kick failure cause a paired fragment j=
ob
to hang indefinitely?=20

The geometry job would abort and be completed with an error by the DRM
scheduler, but it doesn't appear to clean up or error out the paired fragme=
nt
job.=20

Since the combined firmware submission never occurred, the fragment queue
might stall indefinitely, eventually triggering a full GPU reset.

[ ... ]
> @@ -793,25 +795,37 @@ static struct dma_fence *pvr_queue_run_job(struct d=
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
> +	}
> +
> +	if (WARN_ON(err)) {

[Severity: Critical]
If a KCCB kick fails (e.g., due to a lost device), does taking this error p=
ath
leave the queue in an unrecoverable state?

Before sending the kick, pvr_queue_submit_job_to_cccb() is called, which wr=
ites
the job commands to the CCCB and advances the write offset.=20

If the kick fails and the error is propagated to the DRM scheduler, the job=
's
memory backing will be freed. However, because the CCCB write_offset and
in_flight_job_count are not rolled back, the aborted commands remain pendin=
g in
the hardware queue.=20

Can this lead to CCCB corruption and a use-after-free by the firmware?

[Severity: Medium]
Additionally, does WARN_ON(err) cause excessive dmesg spam?

When the device is lost, pvr_kccb_send_cmd_reserved_powered() legitimately
returns -EIO. If the DRM scheduler subsequently attempts to process queued =
jobs,
each one will fail with -EIO and trigger a full stack trace warning.

[Severity: High]
This is a pre-existing issue, but does a GPU hard reset break future submis=
sions
because the kernel's CCCB write_offset is not reset?

During a hard reset, the firmware's control offsets are reset to 0 (e.g., in
cccb_ctrl_init(), WRITE_ONCE(ctrl->write_offset, 0)). However, the kernel's
local pvr_cccb->write_offset is never synchronized to match.=20

On the next submission, the kernel writes at the old offset, but the firmwa=
re
expects commands at offset 0, which might contain zero-filled memory, leadi=
ng
to immediate firmware faults.

> +		pvr_job_release_pm_ref(job);
> +		if (job->paired_job)
> +			pvr_job_release_pm_ref(job->paired_job);
> +		goto err_release;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-upstrea=
m-propagate-all-errors-from-kccb-cmd-submission-code-v5-1-5e262721454b@imgt=
ec.com?part=3D1
