Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EDAC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D82D10E749;
	Thu, 16 Jul 2026 08:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bQ0F/vYb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B557D10E749
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:39:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56F4240538;
 Thu, 16 Jul 2026 08:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FABC1F000E9;
 Thu, 16 Jul 2026 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784191163;
 bh=OUxruNSuHn7w0XeJN1yVMfiBHwn5BPUZRGI+Cu1ZWlA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bQ0F/vYb0RJ7VsNA4+LEmjJb2mGnM1m05iS9jIrmXqJGFxFXLCM1cpnIU6k8JOQ7X
 0yp2rFyhveWOQw3ChVXcl6Is8xwGtB197I7dacijpE3wzOifU7YYfU5uU3IKY07gku
 YYarnTT0sMfNMASWmazOKwpK40eRyK7PX8XcZBT91PBd7BAM8mAuUfpQ14b4Irdc2u
 frqb2nRg4tDkpOt/sv4kyZCww6ocRT09srgSovzRD1NvQGLw4omSrUm5aJ3NcaI4Kp
 IojymCWpQMFT98FkrmRCb0NFE3Nu4z0GLWyxqurCiQMSztqA347GBFVLF9G/pdKA6Y
 q5rzNKrIV7igA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] accel/ethosu: fix job completion fence cleanup
To: zhaoguohan@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716082530.1023538-4-zhaoguohan@kylinos.cn>
References: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
 <20260716082530.1023538-4-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 08:39:22 +0000
Message-Id: <20260716083923.0FABC1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but... If done_fence=
 allocation fails in ethosu_ioctl_submit_job(), the error path jumps to out=
_cleanup_job and calls drm_sched_job_cleanup() on an uninitialized ejob->ba=
se, causing a kernel panic.
- [High] This problem wasn't introduced by this patch, but... The shared IR=
Q handler accesses hardware registers while the device might be runtime sus=
pended, and the suspend callback lacks synchronize_irq().
--

--- Patch [3]: [PATCH 3/3] accel/ethosu: fix job completion fence cleanup -=
--
commit 985100a317b693007577d3f37217a236dddcfd49
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>

accel/ethosu: fix job completion fence cleanup

Fixes a leak of the uninitialized done fence and a potential refcount
underflow in the job cleanup paths.

Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kyl=
inos.cn?part=3D1

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -152,6 +152,13 @@ static void ethosu_job_err_cleanup(struct ethosu_job=
 *job)
> =20
>  	drm_gem_object_put(job->cmd_bo);
> =20
> +	if (job->done_fence) {
> +		if (dma_fence_was_initialized(job->done_fence))
> +			dma_fence_put(job->done_fence);
> +		else
> +			dma_fence_free(job->done_fence);
> +	}
> +
>  	kfree(job);
>  }

[ ... ]

[Severity: High]
This is a pre-existing issue, but can this cleanup path cause a NULL pointer
dereference during job submission?

If done_fence allocation fails in ethosu_ioctl_submit_job(), the code
jumps to out_cleanup_job before drm_sched_job_init() initializes
ejob->base:

ethosu_ioctl_submit_job() {
        ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
        if (!ejob->done_fence) {
                ret =3D -ENOMEM;
                goto out_cleanup_job;
        }
        ...
out_cleanup_job:
        if (ret)
                drm_sched_job_cleanup(&ejob->base);
}

This unconditionally invokes drm_sched_job_cleanup() on the uninitialized
ejob->base, which will dereference job->s_fence:

drm_sched_job_cleanup() {
        if (kref_read(&job->s_fence->finished.refcount)) {
        ...
}

Could this allow userspace to trigger a kernel panic by causing a memory
allocation failure?

[Severity: High]
This is a pre-existing issue, but does the IRQ handler safely access
hardware if the device is suspended?

The shared IRQ handler accesses hardware registers unconditionally:

ethosu_job_irq_handler() {
        struct ethosu_device *dev =3D data;
        u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
        ...
}

Since the IRQ line is shared, another device might trigger the IRQ while
this device is in runtime suspend (clocks disabled). If the handler
accesses NPU_REG_STATUS without calling pm_runtime_get_if_active() to
check the PM state, could this cause a bus fault or invalid memory access?

Also, in ethosu_device_suspend(), the clocks are disabled without
calling synchronize_irq():

ethosu_device_suspend() {
        clk_bulk_disable_unprepare(ethosudev->num_clks, ethosudev->clks);
        ...
}

Should synchronize_irq() be called here to ensure no IRQ handler is
mid-flight before powering down the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716082530.1023=
538-1-zhaoguohan@kylinos.cn?part=3D3
