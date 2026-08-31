Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09AEC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1171310E7D3;
	Mon, 31 Aug 2026 15:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GQlUcTZO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FEE10E944
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:13:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A19D400DF
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC1A1F00A3D;
 Mon, 31 Aug 2026 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788189195;
 bh=R9IfOjR4DweFy8yleMafqpLFDScM6so9xsAKss8RoBU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GQlUcTZOa7bedJ3gC4oCxGoiiVyFll3RuIAe6zxF8UQySjFPh7wuWikqt703uNQyy
 ZI0+M46Zfz3TnstqWlWqgxnXtsVE2F33omysKcD7fQcCB01CYe9IEmCFSHUE6TP0C+
 iSKpesuhCU+bGDpu0nlYVGcVyrAoh4UiS17GydUEBlgOpoXHCQ9FR1UdazdYfqQTcc
 hWcs392xSOVWelZKqdv/ySwAFb1983rHj/J915RyaYg+oyDr/SoWLccBzg1w3STK8k
 962Jeb0ntQ31Z0R7hUMakbwGGyDL2SdFC1ROzRoOzH6V+dhaYiQaghZ7AovAMk3+Mj
 Hl/XwQJA9m+5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/imagination: Don't timeout job if its
 fence has been signaled
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-239-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-239-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:13:14 +0000
Message-Id: <20260831151314.EBC1A1F00A3D@smtp.kernel.org>
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
- [High] Calling `dma_fence_is_signaled(s_job->s_fence->parent)` can result=
 in a NULL pointer dereference because the parent fence may not be initiali=
zed when the timeout handler is invoked.
--

commit 3504f98145fc1193c182b77188d8026b264fe31f
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>
drm/imagination: Don't timeout job if its fence has been signaled

This commit adds a check in the timeout handler to verify if the job's
fence has been signaled. This prevents unnecessary hang recovery when the
job has already completed.

Link: https://patch.msgid.link/20260519-b4-context_reset-v2-2-931018a7131d@=
imgtec.com

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index fc415dd0d7a73..8d5629ea3e520 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
> @@ -814,6 +816,9 @@ pvr_queue_timedout_job(struct drm_sched_job *s_job)
>  	struct pvr_job *job;
>  	u32 job_count =3D 0;
> =20
> +	if (dma_fence_is_signaled(s_job->s_fence->parent))
> +		return DRM_GPU_SCHED_STAT_NO_HANG;
> +

[Severity: High]
Can this result in a NULL pointer dereference?=20

In drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_timedout_job(), if the
timeout worker executes concurrently while the driver's run_job() callback =
is
still blocked (e.g., due to power management or firmware delays),
drm_sched_fence_scheduled() will not have executed yet.

In that scenario, s_job->s_fence->parent is uninitialized and remains NULL.
Passing this uninitialized parent pointer directly to dma_fence_is_signaled=
()
would unconditionally dereference it, which could cause a regression if a
timeout fires before job submission completes.

>  	dev_err(sched->dev, "Job timeout\n");
> =20
>  	/* Before we stop the scheduler, make sure the queue is out of any list=
, so

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-239-sashal@kernel.org?part=3D1
