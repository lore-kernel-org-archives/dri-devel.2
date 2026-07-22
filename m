Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C76C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18A110E261;
	Wed, 22 Jul 2026 11:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bh90vcY7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162E410E261
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:42:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F32160A64;
 Wed, 22 Jul 2026 11:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7ACB1F00A3A;
 Wed, 22 Jul 2026 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784720566;
 bh=lDGSUzuqnruL+1JgXCJaZqDE49OCU+7SsRbxdJ0ydT0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bh90vcY7RKendxxtNHSK4a7P9wQyzBMXXBpQEvX6eZPRbGDdQJN4A8OkY0A90plGr
 kv8mUTSVJXM+PFpxTiIGlDav68cguiNrDehSc7UeustUrLIJv84ydnMCzxLU5A7sfF
 c+fwJe0G6kfknngeD2KvO7FJX3sAl3I05iUnLk8TnTjb+dCa7ZaOENIZA98Tcvi42m
 hI1KyOrbzCR9EBtvLwoKCI2yGQ/5UvTruqLC9Ndp4f8VvwYhZG6VJcOQfwWqRi6rX3
 Jx2j50OGuSWW9g5H1L8RI2YpJ2gSy+owX6jVy/AbEGVLs1HQk49yenTlI/4AI961mM
 5qs/q6KnmTpRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Update the trace point
 pvr_job_submit_fw()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-b4-tracepoint-fix-v1-1-f75747fa591a@imgtec.com>
References: <20260722-b4-tracepoint-fix-v1-1-f75747fa591a@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:42:46 +0000
Message-Id: <20260722114246.A7ACB1F00A3A@smtp.kernel.org>
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
- [High] Moving `trace_pvr_job_submit_fw(frag_job)` after the hardware kick=
 introduces a race condition that can result in a Use-After-Free on `frag_j=
ob`.
--

--- Patch [1]: [PATCH] drm/imagination: Update the trace point pvr_job_subm=
it_fw() ---
commit 290fb87e4c730ddd81be1c9d52004f26f109de14
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Update the trace point pvr_job_submit_fw()

This commit moves the pvr_job_submit_fw() trace point after writing the com=
mand
to the Kernel circular buffer to better represent submission to the firmwar=
e.

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
> @@ -802,6 +800,9 @@ static struct dma_fence *pvr_queue_run_job(struct drm=
_sched_job *sched_job)
>  						 job->hwrt,
>  						 frag_job->fw_ccb_cmd_type =3D=3D
>  						 ROGUE_FWIF_CCB_CMD_TYPE_FRAG_PR);
> +
> +		trace_pvr_job_submit_fw(geom_job);
> +		trace_pvr_job_submit_fw(frag_job);

[Severity: High]
Could this lead to a use-after-free on frag_job if the GPU finishes the
combined kick quickly?

If pvr_queue_run_job() issues the combined hardware kick via
pvr_cccb_send_kccb_combined_kick(), the GPU begins execution immediately.

If the thread gets preempted or the GPU simply completes the jobs very quic=
kly,
the done_fence could be signaled via interrupts before the tracepoint is
reached.

If the fragment queue's scheduler thread wakes up, processes the completion,
and frees frag_job, then geom_job's scheduler thread would resume and call
trace_pvr_job_submit_fw(frag_job) on freed memory, because geom_job doesn't
appear to hold a reference on frag_job.

Should we take an extra reference to frag_job before the hardware kick, or
perhaps move the tracepoint back before the kick?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-b4-tracepo=
int-fix-v1-1-f75747fa591a@imgtec.com?part=3D1
