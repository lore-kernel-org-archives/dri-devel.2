Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2BFCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE538112170;
	Fri,  9 Oct 2026 14:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KPJ72usg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B4B112192
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:25:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C859A40AAB;
 Fri,  9 Oct 2026 14:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818F91F00898;
 Fri,  9 Oct 2026 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791555914;
 bh=3LNIeKxNM4N4aWkv2O4h68LfgMId+jGNEf+Lx4MMOFw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KPJ72usgkqsAwmkn8Jiy5CRU+zSfgILvkUhbl5JLSLZr0MveE4ySY1zc1yHseoYwn
 ThAyfoMxRfR8ydKFslQAXhBDIADsHw1wUgwC4V5NvvjyJhxaQvF14zynGK36Njtx5u
 uzReLLlSsSHLqfDqhHdM1hpIzliZBwN20vDED8FVQPehcILLq9/Q21qtrSmWCpfPyI
 gVQGwTInwsuBkz37giGoHN0ovngupqh5HGxKJrdXFyqSNKl2YplT9Hu9zGBb8jHeM4
 44ttakahU+3y8Qmr19i62qN0cbxq0S5oPiDO74hZtWPAgov+q+tHY/MboRO9C61cWF
 jMGsJkWo4g21A==
Message-ID: <sashiko-outbox-165705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 13/15] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-claude-fixes-v14-13-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-13-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:25:14 +0000
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
- [High] drm: NULL pointer dereference in panfrost_perfcnt_sample_done() on=
 spurious interrupt
- [Medium] drm/panfrost: perfcnt dump race on timeout or signal
--

commit ce948f180a0ee3902b304893abf73fc5060945c5
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent syst=
ems

The commit avoids flushing the GPU caches after a perfcnt sample is made
available if the GPU and CPU are fully coherent.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index ffc77121070e2..b3f71d7fd82a9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -52,7 +52,10 @@ void panfrost_perfcnt_clean_cache_done(struct panfrost=
_device *pfdev)
> =20
>  void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
>  {
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> +	if (pfdev->features.selected_coherency !=3D COHERENCY_ACE)
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> +	else
> +		complete(&pfdev->perfcnt->dump_comp);

[Severity: High]
Could this lead to a NULL pointer dereference if a spurious interrupt
arrives early during device initialization?

In the initialization sequence, the GPU IRQ handler is registered before
the performance counter data structure is allocated:

panfrost_device_init()
  panfrost_gpu_init()
    devm_request_irq(... panfrost_gpu_irq_handler ...);
  ...
  panfrost_perfcnt_init(pfdev);

If a spurious interrupt or unhandled prior hardware state triggers the IRQ
handler before panfrost_perfcnt_init() completes, the handler can call
panfrost_perfcnt_sample_done(). On fully coherent systems, this would now
dereference pfdev->perfcnt before it is allocated.

[Severity: Medium]
Does this completion handling introduce a race condition if the ioctl wait
is interrupted?

When userspace requests a performance counter dump, it eventually waits for
the completion to be signaled:

panfrost_perfcnt_dump_locked()
  ...
  reinit_completion(&pfdev->perfcnt->dump_comp);
  ...
  wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp, ...)

If this wait is interrupted by a signal or times out, it leaves the GPU
command in-flight. If userspace immediately issues a new dump request,
reinit_completion() is called while the previous request is still pending.

When the GPU completes the original request and asserts the interrupt, it
will call complete() here, which immediately satisfies the new wait. Will
this cause the ioctl to return a premature success to userspace while the
GPU is still actively writing the new sample, leading to corrupted profiling
statistics?
>  }
> =20
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-claude-fix=
es-v14-0-cb743b3b973b@collabora.com?part=3D13
