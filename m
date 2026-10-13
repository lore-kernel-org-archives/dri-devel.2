Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B794CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF3AF10E75D;
	Tue, 13 Oct 2026 08:31:58 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD2B10E75D
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=9JlqceaW4Z8vjAr0ORd+79aNIdJmpMYabQrXzFtD9l8=; b=kMHlGNzExMltJCnBzmXRKlp7sB
 xhLCrtUqz7hVcjAGPRpiabLAZgavf5IzkPalSbSJ6qJuEo4o8qrHHEajcDqIsmVrjSaI0Zpkgijk0
 vTyEwSa/J5A2kowRYbvMrj3SzqmcAMBawT0ChQQ2JNAx0dsv5gCaUKnrJ+wv0D6wKyG4Jm+511WpJ
 7KTKbwP1ZiZ6PA2tzPcafx8V0cz98WH9pz7lOCBC0rqf8ETwarYBgmkS468ugJBrA4qfezGb8izqZ
 k68Cknkz6bi4zHtAWlbK8f99BEJviPksdyhUqD5l0473YE5FdsZewn0jXh4PRgOz8KeoP7xMD4tNA
 9FOQl9Sw==;
Received: from 89.141.155.109.dyn.user.ono.com ([89.141.155.109]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xGXvG-00Gxfl-JC; Tue, 13 Oct 2026 10:31:46 +0200
Message-ID: <41ecc5aba207d2de26a9a5dddfc382dd66c1a41f.camel@igalia.com>
Subject: Re: [PATCH 00/11] drm/vc4: Split and shrink job_lock
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 13 Oct 2026 10:31:35 +0200
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This looks good to me, I asked a couple of questions about patches 1
and 5, everything else is:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El dom, 04-10-2026 a las 12:42 -0300, Ma=C3=ADra Canal escribi=C3=B3:
>=20
(...)

> On a Raspberry Pi 3B+ running `glmark2-wayland --off-screen`,
> lock_stat
> shows job_lock contentions reduced by 90% (2093 -> 207 per run) and
> total
> wait time by 96% (14.7 ms -> 0.6 ms). The longest job_lock hold,
> during
> which interrupts are disabled, drops from 747 us to 27 us, as the
> render
> done handler no longer signals fences under the lock. The workload is
> GPU-bound, so the glmark2 score is unchanged (239.6 vs 240.2) [1].

If you want to force a CPU bound scenario you may be able to achieve
that by dropping output resolution to a minimum (passing something like
-s 32x32) . That would make GPU-side work very small and CPU work might
become dominant.

Iago

>=20
> About 99k acquisitions per run move off job_lock onto the per-fence
> locks,
> and 185k more onto bin_alloc_lock, with little contention on either.
>=20
> Considering that glmark2 is a GPU-bound client, it's important to
> notice
> that contention improvements might be higher with several clients or
> a
> CPU-bound workload, which I did not measure.
>=20
> This series applies on top of "drm/vc4: Fix binner slot allocation
> failing
> on an idle GPU" [2].
>=20
> [1] `glmark2-wayland --off-screen` scores are the mean of 5 runs per
> kernel
> without CONFIG_LOCK_STAT enabled. The lock data is the mean of 3 runs
> from
> CONFIG_LOCK_STAT builds.
>=20
> [2]
> https://lore.kernel.org/dri-devel/20260930182204.1877361-1-mcanal@igalia.=
com/T/
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (11):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Publish the output fence outside =
of job_lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Drop the BO reservations outside =
of job_lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Refcount vc4_exec_info
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Return the seqno of the submitted=
 job
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Attach the job fences outside of =
job_lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Use the inline fence lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Signal the render fence outside o=
f job_lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Take job_lock only once to drain =
job_done_list
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Protect perfmon state with a dedi=
cated lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Protect the hang state with a ded=
icated lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Split out bin_alloc_lock
>=20
> =C2=A0drivers/gpu/drm/vc4/vc4_drv.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++=
+++--
> =C2=A0drivers/gpu/drm/vc4/vc4_gem.c=C2=A0=C2=A0=C2=A0=C2=A0 | 106 +++++++=
++++++++++++---------
> ----------
> =C2=A0drivers/gpu/drm/vc4/vc4_irq.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 80 ++=
++++++++++++++------------
> =C2=A0drivers/gpu/drm/vc4/vc4_perfmon.c |=C2=A0 40 +++++++++-----
> =C2=A0drivers/gpu/drm/vc4/vc4_v3d.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 2 +-
> =C2=A05 files changed, 146 insertions(+), 102 deletions(-)
> ---
> base-commit: 64eded63d88ea70466c57cf433761bb1efea37a4
> change-id: 20261002-vc4-misc-fixes-2b313622f570
>=20
>=20

