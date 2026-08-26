Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E41C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18F610E357;
	Wed, 26 Aug 2026 21:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rr/tKzIu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BC210E1B8
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:37:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAEB260254;
 Wed, 26 Aug 2026 21:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445501F000E9;
 Wed, 26 Aug 2026 21:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787780219;
 bh=vA/YWJ/09+mTSxtAbPxoD4NZ56td7yEFu/B8OZztVPM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rr/tKzIuWKX8rV3VaXDoqL08SoC1tb41jYY2qtc4KGKxV/YEu8fSp66D7DvjGSVFV
 nOhIBr1e8g+GRGlZJoEtAHJqz/DQZRcaRVKFTOp5fAZ+QQRn+Nusbrv4f9BvTIQeB8
 wlXyAZl+XiQ+FpgGMjuo26Kfn8RW8rris1PzezoUnZia49RmjqTKmkUDqQW38gp09c
 PNd2rgFja6chg37/MsBc4pWhnFuDy6ZJizxk6dem7v+XKT/G3PzFnx06ZNU7ul5qUK
 JoX0DD+SGPvqrW3lH2bUn3VH4hKstqnXd3sBQnkssa70au/KCTvD8ziPvpQpFMhM78
 yoRFpkmYzbbog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/16] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-claude-fixes-v6-13-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
 <20260826-claude-fixes-v6-13-78119af409e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:36:58 +0000
Message-Id: <20260826213659.445501F000E9@smtp.kernel.org>
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
- [High] Missing cancellation and synchronization of asynchronous GPU tasks=
 after a signal or timeout leads to software race conditions, hardware stat=
e corruption, and GPU page faults.
--

commit 5c3d775056a5b2e3ebdba73f1d3b9858fe3716ba
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent syst=
ems

This commit avoids flushing the GPU caches after a perfcnt sample is made
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
>  }
> =20
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

[Severity: High]
This is a pre-existing issue, but does this interruptible wait in
panfrost_perfcnt_dump_locked() leave the GPU hardware in a busy state if it
aborts early?

When an unprivileged user issues the DRM_IOCTL_PANFROST_PERFCNT_DUMP ioctl,
the kernel waits for the sample to complete:

panfrost_perfcnt_dump_locked() {
    ...
    ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
                                                    msecs_to_jiffies(1000));
    ...
}

If the user process is interrupted by a signal, this wait returns early,
leaving the GPU_CMD_PERFCNT_SAMPLE command executing asynchronously on the
hardware.

If the syscall is restarted by the kernel, the driver re-issues the
GPU_CMD_PERFCNT_SAMPLE command:

panfrost_perfcnt_dump_locked() {
    ...
    reinit_completion(&pfdev->perfcnt->dump_comp);
    ...
    gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
    ...
}

This issues a new command while the previous one is still in-flight, which
can corrupt the hardware state machine.

Alternatively, if the process exits instead,
panfrost_perfcnt_disable_locked() unmaps the GPU memory without waiting for
the in-flight sample to finish:

panfrost_perfcnt_disable_locked() {
    ...
    drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
    perfcnt->buf =3D NULL;
    panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
    ...
}

When the GPU finally writes the sample data, it hits unmapped memory,
causing a GPU page fault and forcing a GPU hard reset. Could proper
cancellation and synchronization of these asynchronous GPU tasks be added
after a signal or timeout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-claude-fix=
es-v6-0-78119af409e7@collabora.com?part=3D13
