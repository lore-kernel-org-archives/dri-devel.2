Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1201CC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560F110F48D;
	Fri, 28 Aug 2026 21:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Swn8ynkC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7A110F48D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:14:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A52944044A;
 Fri, 28 Aug 2026 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6141F000E9;
 Fri, 28 Aug 2026 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787951682;
 bh=DueaX3ATHjENYVhB9Fm5mx0dMylzIS0HVz21YOManrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Swn8ynkCnKOj4bVgNxyUgzVzm+yxuimVWpy77F2zZVO/rmzh4TGD6cjN+c8Z+E3ga
 28agiWTZOMqD7WVsLxzK8nHmrUP7ckN8mM9eHoMIBbIbR5s/Rr3/29rdFGSX+2SO4e
 dgRbpRl5plhSxBUxDMHy02mluOewA7TArfE/L7qddT9wzNt9ZHv1LpFuBnnYrhG1aI
 xfqXrmE2jywiHd9G+wxiknDd7yO2kz/uH7yjx71z9P9c42WvWXet2xIMeCzaIEs4mD
 ytHJ2NakQT3lVghDk2/wR9uUWp/tax63l7DmsOlcDHmNX8+R5OM13ms4SywRchaG3W
 xd+cKkUBnW+KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/17] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-claude-fixes-v7-14-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-14-72a13b2c125d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:14:41 +0000
Message-Id: <20260828211442.5E6141F000E9@smtp.kernel.org>
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
- [Medium] The GPU interrupt handler acknowledges hardware interrupts after=
 signaling the waitqueue completion, creating a race window where a subsequ=
ent hardware operation's interrupt is erroneously cleared.
--

commit a4bf01da864f9ea533a5e37d387ba8e2c63a2a99
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent syst=
ems

This commit optimizes the performance counter sample path by skipping the G=
PU=20
cache flush on fully coherent (ACE) systems. It directly signals completion=
=20
instead of issuing a cache clean command.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index ffc77121070e2..b3f71d7fd82a9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
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
Does bypassing the cache clean step and calling complete() directly here
expose a race condition with the GPU interrupt handler?

In the baseline, the final completion was triggered by a different bit
(GPU_IRQ_CLEAN_CACHES_COMPLETED). With this patch, the
GPU_IRQ_PERFCNT_SAMPLE_COMPLETED handler path now calls complete() directly
on ACE coherent systems.

If the awoken user thread immediately issues a new dump, and the GPU comple=
tes
it before the original IRQ handler in panfrost_gpu_irq_handler() acknowledg=
es
the hardware interrupt:

panfrost_gpu.c:panfrost_gpu_irq_handler()
    ...
    // Software completion happens here (which now wakes the user thread)
    panfrost_perfcnt_sample_done(pfdev);
    ...
    // Meanwhile, a new dump is requested and finishes, raising a new inter=
rupt
    ...
    // The original handler then clears the interrupt using its stale state
    gpu_write(pfdev, GPU_INT_CLEAR, state);

Could the original handler inadvertently clear the new interrupt because its
local state variable still holds the GPU_IRQ_PERFCNT_SAMPLE_COMPLETED bit?

This could cause back-to-back performance counter dumps (e.g., if a local
user calls the perfcnt dump ioctl in a tight loop) to sporadically fail with
an ioctl timeout when their completion interrupt is lost.

>  }
> =20
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-claude-fix=
es-v7-0-72a13b2c125d@collabora.com?part=3D14
