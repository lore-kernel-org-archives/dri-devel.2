Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACAECDE007
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2070B10E20A;
	Thu, 25 Jun 2026 11:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S8X2j3fL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CCE10E20A
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:56:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8416042A5C;
 Thu, 25 Jun 2026 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE961F000E9;
 Thu, 25 Jun 2026 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782388601;
 bh=mqU97Q/wpk1YAyjNSVPlT7t1b162WdSrgnLUMM6FTo4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S8X2j3fLcNIS56DR/G24aoY4pmKNT7zQvL1uPvDeYH9RIer98qIX/xM7IaHIMkUiA
 YBEd3S7sfzFslS45mhvlfcYd78psUIwlyt52fRY8CHjCZuhu75mvUQySNnfuDeb2mj
 VaM87oh9hOGtJ8H9y1FzmvQTMTmxhlyBMsBKzZjdbePVLOKhhQj7pvVOCDhTGgz+25
 NrNZF8S0+I0LTNcDpKLorm3or84Tg9VJXwpxVIAhZKoaAHloKV1XTEzFxo6DxEAwMK
 lmhkeN/u3Ln/3jb/ElZC3O/LbYrlpN6oCVybMZt++j1XVHb61SeNjdko8jXTZe6fuP
 xHthg56N8gngA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ethosu: Fix use-after-free and memory leak in
 ioctl_submit_job
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625114547.50649-1-vulab@iscas.ac.cn>
References: <20260625114547.50649-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 11:56:40 +0000
Message-Id: <20260625115641.3FE961F000E9@smtp.kernel.org>
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
- [Critical] The patch introduces a deterministic double free and RCU list =
corruption of `job->done_fence` during normal job teardown.
--

commit db241a585a8f0c1a7f9163f155e4be54743c28b8
Author: Wentao Liang <vulab@iscas.ac.cn>

accel/ethosu: Fix use-after-free and memory leak in ioctl_submit_job

This commit fixes a null pointer dereference and a memory leak of the
done_fence allocation in the error paths of ethosu_ioctl_submit_job().
It skips calling drm_sched_job_cleanup() on an uninitialized struct and
adds a kfree() to the error cleanup routine.

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index b76924645aaaf..860f4a4d4c503 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -150,6 +150,7 @@ static void ethosu_job_err_cleanup(struct ethosu_job =
*job)
>  	for (i =3D 0; i < job->region_cnt; i++)
>  		drm_gem_object_put(job->region_bo[i]);
> =20
> +	kfree(job->done_fence);

[Severity: Critical]
Will this lead to a double free and rcu list corruption during normal job
completion?

Looking at the normal teardown path in ethosu_job_cleanup(), the job's
reference to done_fence is released via dma_fence_put() before calling
this cleanup function:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_cleanup() {
	...
	dma_fence_put(job->done_fence);
	dma_fence_put(job->inference_done_fence);

	ethosu_job_err_cleanup(job);
}

If dma_fence_put() drops the last reference and frees the fence, won't the
kfree() added here try to free the same pointer again?

Additionally, if the fence is still referenced elsewhere, couldn't this
synchronous kfree() cause a use-after-free for any other subsystem holding a
reference to the fence?

>  	drm_gem_object_put(job->cmd_bo);
> =20
>  	kfree(job);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625114547.5064=
9-1-vulab@iscas.ac.cn?part=3D1
