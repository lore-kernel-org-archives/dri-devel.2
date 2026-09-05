Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D23C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E392410FB6C;
	Sat,  5 Sep 2026 01:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WsDxqXvU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D820310FB6C
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:00:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C1AC140538
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7902D1F00A3D;
 Sat,  5 Sep 2026 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788570042;
 bh=s0yGhxgB/MtKf5aNmfLgcQ6ZHftUweWwYZWb2MQVPiA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WsDxqXvUEWezUtdRIrP4uzxm7BWJ9sbmUiXcuqJ6F1eYFdh2Rda5Mu820CQ6abA0i
 wqbcQyiCc4bIUjlffI+pN7yuymvOh9icMP2Hm30SoRif/JUcbYLvxp7rRA9rI8b2+G
 60XYDE8br/4Sheow0GzL0U5PPU6kidki2XbUh6pT1OYSM8yXxL3saMIbwOgkqv18m1
 jzQ7MWqGUivXNm7/TnTgldfjW+s7b7I7xvLCTPgJlcI2zHXV/880rUByxV8skhyRVI
 1IE3eYn7Cm2KwSTkFm5dCKEgbVZOrdX1d1r3w/URS9uzw4PIJ+SPyaQaWV/OR9WQmH
 kpHZMYZtgniLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/19] accel: ethosu: Quiesce jobs before scheduler
 teardown
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-4-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-4-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:00:42 +0000
Message-Id: <20260905010042.7902D1F00A3D@smtp.kernel.org>
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
- [High] Incorrect teardown ordering and missing disable_irq() allow the IR=
Q handler to re-arm the TDR timeout work after it was cancelled, leading to=
 a Use-After-Free of scheduler runqueues.
- [High] drm_sched_entity_destroy() accesses freed scheduler runqueues when=
 the device is unbound while DRM files remain open.
--

commit 02f285145ac0684a0a3a6e4b7752353026bebfae
Author: Rob Herring (Arm) <robh@kernel.org>
accel: ethosu: Quiesce jobs before scheduler teardown

This commit aims to fix a teardown race by stopping scheduler submission,
cancelling the timeout work, resetting the NPU, and synchronizing its IRQ
before destroying the scheduler. It also adds a cancel_job callback so
queued jobs are properly signalled with -ECANCELED.

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index ec65305e0cd7d..74a1136635f87 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c

[ ... ]

> @@ -363,6 +374,15 @@ int ethosu_job_init(struct ethosu_device *edev)
> =20
>  void ethosu_job_fini(struct ethosu_device *dev)
>  {
> +	drm_sched_wqueue_stop(&dev->sched);
> +	cancel_delayed_work_sync(&dev->sched.work_tdr);
> +
> +	if (READ_ONCE(dev->in_flight_job)) {
> +		WRITE_ONCE(dev->in_flight_job, NULL);
> +		ethosu_device_reset(dev);
> +	}
> +
> +	synchronize_irq(dev->irq);

[Severity: High]
This is a pre-existing issue, but does using synchronize_irq() instead of
disable_irq() leave a race window open here?

If a hardware error IRQ fires concurrently, the IRQ thread could read the
error status before the device is reset but get preempted. Because the IRQ
is only synchronized and not disabled, the thread could resume, see the
error, and call drm_sched_fault(&dev->sched). This would re-arm
dev->sched.work_tdr after it was just cancelled.

When drm_sched_fini() is called immediately after this, it frees the
runqueues and then calls its own cancel_delayed_work_sync(&sched->work_tdr).
A re-armed work_tdr could execute concurrently in this window and access the
freed runqueues.

Should this use disable_irq() instead of synchronize_irq() to ensure the
timeout work cannot be re-armed during teardown?

[Severity: High]
This isn't a bug introduced by this patch, but does calling
ethosu_job_fini() directly from ethosu_remove() cause a use-after-free if
userspace still has the DRM file descriptor open?

If the driver is unbound (e.g., via sysfs rmmod/unbind) while userspace
holds an open file descriptor, ethosu_remove() will call ethosu_job_fini()
which in turn calls drm_sched_fini(), freeing the scheduler runqueues.

When the userspace process eventually closes the file descriptor,
ethosu_job_close() is called:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_close() {
    struct drm_sched_entity *entity =3D &ethosu_priv->sched_entity;

    drm_sched_entity_destroy(entity);
}

The drm_sched_entity_destroy() call will attempt to access the already
freed sched_rq spinlocks. Is there a way to defer the scheduler teardown to
the DRM device release callback instead of tearing it down in the remove
path?

>  	drm_sched_fini(&dev->sched);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D4
