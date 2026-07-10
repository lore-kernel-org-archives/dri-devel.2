Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F86AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE5910F85B;
	Fri, 10 Jul 2026 11:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BTqsezLc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469D010F85B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:09:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D679A412D4;
 Fri, 10 Jul 2026 11:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D591F000E9;
 Fri, 10 Jul 2026 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783681744;
 bh=MjRsU3sr75q3hUHKBEEe46byx3XjvXC0+Q/tTNQDiUU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BTqsezLcAtRRAUt+tbM5YqLL0W6rfK/9S/uXUB7ugT0CUfCZAJNkZoZWe40t7PSqw
 oDivQtN4wnoyYhWwsRToY/yi0VJXKr8csZJZWU3x1yFs/Ji1WuDkMHjbAMgRKrQLF/
 lVoADgffcTU3NoAyTbyFJOxrVWw/07M1ksqOApr/NDaDNWAJ9bHDCgEI5cgEvtYbKi
 IIBvvakGoqPii+xP4qSBOsUjH0/B5auuUWUuRI37fJAI5bzig9svcGNvRF1ZvaPztI
 BtyZ+LIlyDxvKcUPDGXOXEpMBE7ps+a3yUGOL6atIPpMNa201afs+YPFmQduNtoC1v
 rQ076yaY0QfiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] accel: rocket: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710105937.409992-3-panchuang@vivo.com>
References: <20260710105937.409992-1-panchuang@vivo.com>
 <20260710105937.409992-3-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:09:03 +0000
Message-Id: <20260710110904.74D591F000E9@smtp.kernel.org>
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
- [High] Unsafe register access in shared IRQ handler when device is runtim=
e-suspended or unpowered.
- [High] Calling `drm_sched_fini()` on a partially initialized scheduler du=
ring error handling leads to a crash.
--

--- Patch [2]: [PATCH 2/2] accel: rocket: Remove redundant dev_err() ---
commit 8d11ad4c2f7d7988ccd404acec217989feeb7613
Author: Pan Chuang <panchuang@vivo.com>

accel: rocket: Remove redundant dev_err()

This commit removes a redundant dev_err() call after=20
devm_request_threaded_irq(), as the core already logs detailed error=20
messages automatically on failure.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -468,10 +468,8 @@ int rocket_job_init(struct rocket_core *core)
>  	ret =3D devm_request_threaded_irq(core->dev, core->irq,
>  					rocket_job_irq_handler,
>  					rocket_job_irq_handler_thread,
>  					IRQF_SHARED, dev_name(core->dev),
>  					core);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to register this
IRQ as shared before the device is powered on, or to keep it active during
runtime suspend?

If another device sharing the line triggers an interrupt,
rocket_job_irq_handler() will unconditionally read hardware registers:

    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);

Could this cause a bus fault if the device is unclocked or unpowered at the
time the shared interrupt fires?

> -	if (ret) {
> -		dev_err(core->dev, "failed to request job irq");
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	core->reset.wq =3D alloc_ordered_workqueue("rocket-reset-%d", 0, core->=
index);

[Severity: High]
This is a pre-existing issue, but can calling drm_sched_fini() in the error
handling path of this function cause a panic if drm_sched_init() fails?

Looking further down in rocket_job_init(), if drm_sched_init() fails (e.g.,
due to memory allocation failure), the code jumps to err_sched:

    err_sched:
        drm_sched_fini(&core->sched);

If drm_sched_init() fails early, core->sched.job_scheduled.head.next might
still be NULL. When drm_sched_fini() calls wake_up_all(&sched->job_schedule=
d),
will it evaluate waitqueue_active() on a zeroed wait queue and trigger a NU=
LL
pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710105937.4099=
92-1-panchuang@vivo.com?part=3D2
