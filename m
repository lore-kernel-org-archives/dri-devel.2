Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159B5C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 04:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F3410E1BE;
	Fri, 24 Jul 2026 04:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XBTiWaaC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E503810E1BE
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 04:55:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1602B600B1;
 Fri, 24 Jul 2026 04:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3AA1F00A3D;
 Fri, 24 Jul 2026 04:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784868932;
 bh=j4q8S2+npknwOQ99FzebY/v5y03S9cxLJjcAGnDCGM0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XBTiWaaCkbESbNkG+ScMRFzL+3nj6ScGLc7Osyk1lcR9Jo23xYq7dAKoP2B7Z8xXh
 VxvMEaZW4MbWQl0Q8FOLqH2SelvRVVjaJ2ALmyhF5nnG8EuOZgfZYIhCe1477aWkJU
 8jcTk/e2BkMghfqvo0ltLMOsOojz4ACYfFSnTOklnEKPbjJwa1YWtsDyHRQzRJQ4Tl
 DzK3HaXeacVNVfOOhU9WlcOksV6NWIxIYDoVyCA5BriR8f8tSVWkYQnOH9EcIjRuzP
 m3BAMrjgTQDf8jbZ/hwh/C5NPetmkThgsj77e6EuTpqgKnSC5ef8sDOU2cxA8YQvFn
 UlgMnHHMNHeKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imagination: Update the trace point
 pvr_job_submit_fw()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-b4-tracepoint-fix-v2-1-e6a81a348394@imgtec.com>
References: <20260724-b4-tracepoint-fix-v2-1-e6a81a348394@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 04:55:31 +0000
Message-Id: <20260724045532.8D3AA1F00A3D@smtp.kernel.org>
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
- [Medium] The `pvr_job_submit_fw` tracepoint for fragment jobs in paired s=
ubmissions is emitted asynchronously from actual firmware submission, break=
ing the tracepoint's intended semantics.
--

--- Patch [1]: [PATCH v2] drm/imagination: Update the trace point pvr_job_s=
ubmit_fw() ---
commit f1ff23a928ba06505b47c3b88a51019e853a537e
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>
drm/imagination: Update the trace point pvr_job_submit_fw()

This patch moves the trace recording for pvr_job_submit_fw() to occur after
writing the command to the Kernel circular buffer. The intention is to more
accurately represent the exact moment a command is submitted to the firmwar=
e.

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 941c017399fc3..fd968d7def660 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
> @@ -758,6 +756,7 @@ static struct dma_fence *pvr_queue_run_job(struct drm=
_sched_job *sched_job)
>  	 */
>  	if (job->paired_job && job->type =3D=3D DRM_PVR_JOB_TYPE_FRAGMENT &&
>  	    job->done_fence->ops) {
> +		trace_pvr_job_submit_fw(job);

[Severity: Medium]
For paired submissions, the geometry scheduler thread submits both the
geometry and fragment jobs to the firmware simultaneously in a combined kic=
k.

Since this path executes in the independent fragment scheduler thread, does=
n't
emitting the tracepoint here mean it happens asynchronously from the actual
firmware submission?

Because the fragment scheduler thread runs independently, it may wake up and
emit this tracepoint an arbitrary amount of time after the combined hardware
submission (or even after the hardware has finished the job).

Would it better represent the submission time to emit the fragment job's
tracepoint from the geometry job's pvr_queue_run_job() execution, where both
are actually submitted to the firmware via pvr_cccb_send_kccb_combined_kick=
()?

>  		return dma_fence_get(job->done_fence);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-b4-tracepo=
int-fix-v2-1-e6a81a348394@imgtec.com?part=3D1
