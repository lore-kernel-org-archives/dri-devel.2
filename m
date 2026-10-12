Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACCDCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD7910F183;
	Mon, 12 Oct 2026 15:05:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA05610F19E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:05:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E6EB60207;
 Mon, 12 Oct 2026 15:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE471F0089B;
 Mon, 12 Oct 2026 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791817545;
 bh=0DAbo4S5ZWJaTbKaam+b6uzqTFAZEtEn/VUI/IJpJPk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nlB+LsVH23qx+xbiTyboZOIITXxnmb8zSgyWPyqoDX39ivnW2Zp/v5QtPw5i0ros1
 f+o+AocQqleVWC27Fh1r1FpPE9p5kzOC4VlmovJEk8dzzbQotY3tS/NFw1AJkuGcw9
 I7p01blxr1EPRIFnRTKvyxJwC8f9g/EVjilvbguYnw8SQrLc8MQ36LcpBdkpoqeBKL
 v7d0FjA7ufyz7iUHL9tjRmm1ejg/0TgVItBU0yRain+/ZAY8dF60UiX/iyL143DUSc
 ADwwHMj2O6DZnPkNJxokcSEkpGjjEBaMr/GenK/yAMo4NmKQEDwkD43jSp4T4BB53H
 E6oEUPw70R4CA==
Message-ID: <sashiko-outbox-168312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 13/15] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-claude-fixes-v15-13-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
 <20261012-claude-fixes-v15-13-bc0a6c498553@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:05:44 +0000
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
- [High] drm/panfrost: UAF of perfcnt during device unbind
--

commit 1164f77fb530d75cfd2e6bee453335ff4ea53de6
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent syst=
ems
   =20
If the GPU and CPU are fully coherent, then there's no need to flush the
GPU caches after a perfcnt sample is made available.

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
                ^^^^^^^^

[Severity: High]
Does this introduce a use-after-free regression during device unbind?

If a user thread calls the perfcnt dump ioctl and blocks in
wait_for_completion_interruptible_timeout() inside
panfrost_perfcnt_dump_locked(), and the device is concurrently unbound:

panfrost_remove() will return without cancelling the wait, and devres cleans
up allocations.

Because devm_kzalloc() for perfcnt in panfrost_perfcnt_init() occurs after
devm_request_irq(), devres frees pfdev->perfcnt while the thread is still
sleeping and the IRQ is still registered.

When the thread wakes up, it will access the freed completion structure.

Additionally, if a shared interrupt fires in this window and GPU_INT_STAT
returns 0xffffffff (because clocks are off), panfrost_perfcnt_sample_done()
will dereference the freed pfdev->perfcnt pointer here.

>  }
> =20
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-claude-fix=
es-v15-0-bc0a6c498553@collabora.com?part=3D13
