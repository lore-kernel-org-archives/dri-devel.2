Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308FCC79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8803110E917;
	Mon,  7 Sep 2026 20:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q/8ew6Fu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26B310E917
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:35:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB008601FB;
 Mon,  7 Sep 2026 20:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367401F00A3A;
 Mon,  7 Sep 2026 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788813324;
 bh=ezB5JBZZCNRy0wMzbFER7Uh6UK0hrlmo+iBMym50ZPM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q/8ew6FuioSrzF+cM1YIzZ3WK76tvAOcoF2ai8UI1ZMZM0IL8PaGoAbhzclzpGu/0
 AGYY1t+UdzTXsXWX4GMviu1PuBeKQk5EATOA+ySYVtI6TMQva3tTEYQVgD8XeAjYO9
 eqC7W1Q6pOICCfetZvjyj77r41yS5mw1ehW+NCOcjshxTZ+Ij+c/YhYr1xEQt84+yh
 GI6HRWu65e4BkZXTIWCRXxdmNOCkuTCnJXT7SkUbQivIFlYoHXrU1blDxkvcK4Cr3F
 GaZZnYslyilY7U0m2FixlwgMnZ/Dk8+picWR8dGtCqr5mUl8NCGI6vPPR8HEJKTSjr
 LMsIvVfUKnWtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/16] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-13-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-13-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:35:23 +0000
Message-Id: <20260907203524.367401F00A3A@smtp.kernel.org>
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
- [High] Use-After-Free in IRQ handler during device teardown due to shared=
 interrupt firing after subsystem deinitialization.
--

commit 4af8baef18e17c6d5fb401654ac07ca6918a16ae
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent syst=
ems

This commit skips flushing the GPU caches after a performance counter sample
is made available if the GPU and CPU are fully coherent. It directly signals
the completion instead.

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
This is a pre-existing issue, but can this dereference of pfdev->perfcnt le=
ad
to a use-after-free during device teardown?

Looking at panfrost_gpu_init() in drivers/gpu/drm/panfrost/panfrost_gpu.c,
the shared GPU IRQ is requested before panfrost_perfcnt_init() allocates
pfdev->perfcnt. During driver teardown (panfrost_device_fini()), devres
cleans up allocations in reverse order. This means pfdev->perfcnt is freed
while the shared IRQ remains registered.

If an external interrupt fires on the shared IRQ line during this window,
panfrost_gpu_irq_handler() could see the GPU_IRQ_PERFCNT_SAMPLE_COMPLETED
bit set (e.g., if reading GPU_INT_STAT from unclocked hardware returns
0xFFFFFFFF).

The handler would then call panfrost_perfcnt_sample_done(), which accesses
the already freed pfdev->perfcnt pointer here.

Should the GPU IRQ be explicitly disabled or unregistered before perfcnt is
deinitialized?

>  }
> =20
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D13
