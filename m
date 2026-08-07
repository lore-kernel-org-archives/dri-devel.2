Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEB4C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C8F10F52E;
	Fri,  7 Aug 2026 15:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eYlxfCZc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCF310F524
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 15:20:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 636A040797;
 Fri,  7 Aug 2026 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291B61F000E9;
 Fri,  7 Aug 2026 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786116022;
 bh=OYn+lFdkI7HNUp/5qsOyEJ7321jZVaacO1TWkOydQd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eYlxfCZcKcx6a/u2p0M4QLMes6d751+UsTb9LYHxdPAeB3iw4dAwp+Hes0gXCojES
 /3OEYdMxEMbm6dNhkV3zkNO1Dse3HARFBpe8Kgcgv0Dl7y+l5p0jjHjRrP7VVqi0Zj
 P3+FSTlCdcH/J3uRwGRM3QsYRN5X0jLUZaT+gJaz7V46yl8Vw6hhj4aJluDRCZxxZG
 tdJUQLBwEn0WG01kcRWYGReMc3XdcyLXQwY4VgM6E3gKFICDYFetfiTdPVwfwMSGa/
 JSC70GZs0Qd5Y2Z8ChnzbZ+uC1kfNjmLdRhLGsj24ZsWcmp9/t45B2nuwUuR16v5iL
 uKbhh/Umz8xhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: fix usage_count leak when autosuspend_delay
 is negative
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807145416.2518999-1-lgs201920130244@gmail.com>
References: <20260807145416.2518999-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:20:21 +0000
Message-Id: <20260807152022.291B61F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Background work items scheduled by IRQ handlers are not flushed or=
 canceled on the probe error path, leading to a Use-After-Free when devres =
frees the device.
--

--- Patch [1]: [PATCH] accel/ivpu: fix usage_count leak when autosuspend_de=
lay is negative ---
commit db53366ef5dbe7e33ab10b0d9f2d73d71bbd452a
Author: Guangshuo Li <lgs201920130244@gmail.com>

accel/ivpu: fix usage_count leak when autosuspend_delay is negative

ivpu_pm_init() calls pm_runtime_use_autosuspend(), but the autosuspend
setting is not disabled when the device is removed or when initialization
fails. This patch adds pm_runtime_dont_use_autosuspend() to ivpu_pm_disable=
()
and the ivpu_dev_init() error path to prevent a usage_count leak.

> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 95120957f42a5..f8460aca189cd 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
[ ... ]
> @@ -776,13 +776,15 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
> =20
>  	ret =3D ivpu_boot(vdev);
>  	if (ret)
> -		goto err_ipc_fini;
> +		goto err_pm_fini;
> =20
>  	ivpu_job_done_consumer_init(vdev);
>  	ivpu_pm_enable(vdev);
> =20
>  	return 0;
> =20
> +err_pm_fini:
> +	pm_runtime_dont_use_autosuspend(vdev->drm.dev);

[Severity: High]
This is a pre-existing issue, but since we are modifying the error paths
here, I noticed that background work items scheduled by IRQ handlers might
not be flushed or canceled on the probe error path.

If a hardware interrupt occurs during ivpu_boot() after enable_irq() is cal=
led,
the handler may queue irq_dct_work or context_abort_work. If a subsequent
initialization step like ivpu_pm_dct_init() fails, the error path disables
interrupts but skips flushing the queued works:

ivpu_boot() {
        ...
        enable_irq(vdev->irq);
        ...
        ret =3D ivpu_pm_dct_init(vdev);
        if (ret)
                goto err_disable_ipc;
        ...
err_disable_ipc:
        ivpu_ipc_disable(vdev);
        ivpu_hw_irq_disable(vdev);
        disable_irq(vdev->irq);
        ...
}

The error is then returned to ivpu_dev_init(), which jumps to err_pm_fini
where this new cleanup code is placed.

Could this lead to a memory corruption scenario? Without cancel_work_sync()
or flush_work() to halt pending tasks, devres might free the ivpu_device
structure when probe fails. Any pending work items might later execute and
dereference the freed pointer.

>  err_ipc_fini:
>  	ivpu_ipc_fini(vdev);
>  err_fw_fini:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145416.2518=
999-1-lgs201920130244@gmail.com?part=3D1
