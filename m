Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7127C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A95110E46A;
	Thu, 17 Sep 2026 09:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WV8lxjSs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CA210E46A
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:32:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D781D600D4;
 Thu, 17 Sep 2026 09:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE21F000FF;
 Thu, 17 Sep 2026 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789637573;
 bh=cg7fRT9q4oNFLh4c48GL5V/d54SyBKtpIriOCiDzmcI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WV8lxjSsLUNmfpMT7dt/ts7jLyJgQTLBQMKW4xPkOMcnLCZXrBTZL1pytAOPlOWz/
 I/DcRlIPmrheXH7mXKoKa3VfpJTz5Sci+GfD04WIUNWVyBorBp91U3l3t9Omjak+Ax
 aIJ9Pwlym+5ReFLjbUX+N7KbknkC/99ncn+YPvQ4gUaRI0KwBEgMr25tITSxAZTKcj
 tjuvK0z9iHPGt4AErn08a7q/AlN9Zjw0J/Ezj12Ji37/VJ3zB0rflutGQIVsAZ0F3u
 6hsfYK2O3Cm+wHJchA8+lKmKpmC1qw+Q6/WpQBtJS1tXTtGbcBTlx2hwTfOkwem1fy
 Nr8fe/k2CyKeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/lima: fix use-after-free of recover work on device
 removal
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917092027.192956-1-fanwu01@zju.edu.cn>
References: <20260917092027.192956-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 09:32:52 +0000
Message-Id: <20260917093253.64CE21F000FF@smtp.kernel.org>
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
- [High] drm/lima: unhandled interrupt storm during device teardown
--

commit 8abd934c293282a7fc2e36fd5ffb16c36332e554
Author: Fan Wu <fanwu01@zju.edu.cn>

drm/lima: fix use-after-free of recover work on device removal

This commit fixes a use-after-free issue on device removal by draining the
recover_work while the task slab and scheduler are still alive. It frees the
GP and GP MMU interrupts before the GP pipe teardown and stops the GP after
the scheduler is finished.

> diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/li=
ma_device.c
> index 7c873e62c16da..e4dbd8baf33c6 100644
> --- a/drivers/gpu/drm/lima/lima_device.c
> +++ b/drivers/gpu/drm/lima/lima_device.c
> @@ -297,8 +297,14 @@ static void lima_fini_gp_pipe(struct lima_device *de=
v)
>  {
>  	struct lima_sched_pipe *pipe =3D dev->pipe + lima_pipe_gp;
> =20
> -	lima_gp_pipe_fini(dev);
> +	cancel_work_sync(&pipe->recover_work);
> +
>  	lima_sched_pipe_fini(pipe);
> +
> +	/* a recovery may have restarted the GP job */
> +	lima_gp_stop(dev->ip + lima_ip_gp);
> +
> +	lima_gp_pipe_fini(dev);
>  }
> =20
[ ... ]
> @@ -442,17 +448,23 @@ void lima_device_fini(struct lima_device *ldev)
>  	int i;
>  	struct lima_sched_error_task *et, *tmp;
> =20
> +	lima_fini_pp_pipe(ldev);
> +
> +	/* free the IRQ sources of recover_work before the GP pipe drain */
> +	lima_fini_ip(ldev, lima_ip_gp);
> +	lima_fini_ip(ldev, lima_ip_gpmmu);
> +	lima_fini_gp_pipe(ldev);

[Severity: High]
Could unregistering the IRQ handlers before draining the GP pipe lead to an
unhandled interrupt storm?

The call to lima_fini_gp_pipe() executes cancel_work_sync(&pipe->recover_wo=
rk).
If recover_work is executing concurrently during device teardown,
cancel_work_sync() will wait for it to complete.

The recovery work calls lima_gp_task_recover(), which explicitly unmasks the
GP hardware interrupts and resumes hardware execution:

    gp_write(LIMA_GP_INT_MASK, LIMA_GP_IRQ_MASK_USED);

When the hardware subsequently completes the job or faults, it will assert =
the
IRQ line. Because the IRQ handler was already freed by the calls to
lima_fini_ip() above, the interrupt goes unhandled.

Could this cause the generic IRQ subsystem to permanently disable the shared
IRQ line and break other devices sharing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917092027.1929=
56-1-fanwu01@zju.edu.cn?part=3D1
