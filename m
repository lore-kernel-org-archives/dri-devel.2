Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86427CA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D846310F878;
	Wed,  7 Oct 2026 23:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PPqtFXXw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F18F10E501
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:55:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77EF543E63;
 Wed,  7 Oct 2026 23:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ADA1F000FF;
 Wed,  7 Oct 2026 23:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791417352;
 bh=xczrcHQziDdkaHzE8QAsgHZZwqhOaNeUADw5nZS9YfU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PPqtFXXw6o6TJ+5G+f7kn4yw9fLClljt86BEyHaOZE1ioWLxjkZbSD9jwBnJz8Y1b
 zlaAuopUTHCtCHP9wnCnJuCULSoiXtVFQPtNqI4GJc3kWjNpK4q/7pN/1crs+8WRT8
 FnUTWiMhJu1cgX5wVnVuHCHELV3E3alg99FFt9mU7DuVTGFIsT4RzIOAD/XRcZd4gE
 a4qb4bY5HlYA/kHgSba9bQwkp02mWkWqDeB1n2FWLJrQbg8sHWvQ5wYrsn8dHlIXm4
 6Jww/HRS/IS2+IgjGkSi+VZ46B//RXLeBh7Wcpg24vXXgMlUbWU9ZlzoWPm7wnCz2N
 yoHZ78IN5uclQ==
Message-ID: <sashiko-outbox-163442@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 13/15] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-claude-fixes-v13-13-d6a493185860@collabora.com>
References: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
 <20261008-claude-fixes-v13-13-d6a493185860@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 23:55:51 +0000
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
- [Medium] drm: race condition in panfrost_gpu_irq_handler causes lost perf=
cnt interrupts
--

commit 54ca68cf4bae3920aff016a6d2b492d879450341
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent syst=
ems

This commit skips the GPU cache flush after a performance counter sample
becomes available when the GPU and CPU are fully coherent. It does this by
completing the dump immediately rather than issuing a cache clean command.

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

[Severity: Medium]
Since complete() is now called before the IRQ handler clears the interrupt,
could this cause a race condition where a subsequent perfcnt dump request
times out?

If the waiting process wakes up and immediately issues another perfcnt dump
request on another CPU, it might write GPU_CMD_PERFCNT_SAMPLE and trigger a
new GPU_IRQ_PERFCNT_SAMPLE_COMPLETED interrupt before the original IRQ
handler finishes.

The original IRQ handler in panfrost_gpu_irq_handler() finishes by writing
the previously read state back:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_irq_handler() {
    ...
    state =3D gpu_read(pfdev, GPU_INT_STAT);
    ...
    if (state & GPU_IRQ_PERFCNT_SAMPLE_COMPLETED)
        panfrost_perfcnt_sample_done(pfdev);
    ...
    gpu_write(pfdev, GPU_INT_CLEAR, state);
    return IRQ_HANDLED;
}

Could this gpu_write(pfdev, GPU_INT_CLEAR, state) clear the newly asserted
interrupt, causing the second dump request to hang and return -ETIMEDOUT to
userspace?

>  }
> =20
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-claude-fix=
es-v13-0-d6a493185860@collabora.com?part=3D13
