Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66426CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D4910E754;
	Tue, 13 Oct 2026 06:42:45 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C600E10E786
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=tKSErMIhxeKo4SdzWGeFlZ+IHR+EhZDVicNgJZmSdAo=; b=nn8D6ZODNqMFrDW+Ph2oEQKHy8
 dKQ/oErfglSf2KhiRL4EFNe0NTiHx117+pR50hjsRA/QagSd5yqfR4H3240MwnGE8mvGh1GVvLfCT
 3idI2p+M0ZCjyg8WTrVwU0lYQSLD5QUT3nkP0BLjhoOt5VHuGnxkD1YR71hspBftBn3L65fxWjBSS
 J14Qs3ALBxvAN0+eYUKxF6C/ji2ZTKsmB5KQfkdMbILAcISDqANIIJtM1Af3k3abLC2B20UvpOKMr
 SgbmRuui85LwoMBBvf3Fj2O5mXDDVzT1sg/A7LD2Y/JrOupA5fsmxBzM5Y7c04doz+ZysGRZnTkOi
 x3szRmfQ==;
Received: from 89.141.155.109.dyn.user.ono.com ([89.141.155.109]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xGWDZ-00GuMx-AP; Tue, 13 Oct 2026 08:42:33 +0200
Message-ID: <46655d67646a560ebb0cf3b4162a4bdacd59ad04.camel@igalia.com>
Subject: Re: [PATCH 01/11] drm/vc4: Publish the output fence outside of
 job_lock
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 13 Oct 2026 08:42:22 +0200
In-Reply-To: <20261004-vc4-misc-fixes-v1-1-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
 <20261004-vc4-misc-fixes-v1-1-b763df9e33e1@igalia.com>
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

El dom, 04-10-2026 a las 12:42 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> job_lock is taken by the V3D interrupt handler, so nesting an IRQ-
> unsafe
> lock under it creates an inversion. drm_syncobj_replace_fence() takes
> drm_syncobj::lock, which other paths acquire with interrupts enabled.
> For
> example, a thread interrupted while holding it blocks the handler on
> job_lock, and the handler can only make progress once the submit path
> releases job_lock, which it cannot do while waiting for
> drm_syncobj::lock.
>=20
> This is reported by lockdep:
>=20
> [=C2=A0 188.139076]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0 188.139086] WARNING: possible irq lock inversion dependency
> detected
> [=C2=A0 188.139096] 7.3.0-rc3-00067-gc4f3feeaf60f #67 Tainted: G=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C
> [=C2=A0 188.139108] -----------------------------------------------------=
-
> --
> [=C2=A0 188.139116] swapper/0/0 just changed the state of lock:
> [=C2=A0 188.139125] ffff0000054f8ff8 (&vc4->job_lock){-...}-{3:3}, at:
> vc4_irq+0xa8/0x28c [vc4]
> [=C2=A0 188.139234] but this lock took another, HARDIRQ-unsafe lock in th=
e
> past:
> [=C2=A0 188.139242]=C2=A0 (&syncobj->lock){+.+.}-{3:3}
> [=C2=A0 188.139256] and interrupts could create inverse lock ordering
> between them.
> [=C2=A0 188.139267] other info that might help us debug this:
> [=C2=A0 188.139275]=C2=A0 Possible interrupt unsafe locking scenario:
> [=C2=A0 188.139284]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU1
> [=C2=A0 188.139291]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----
> [=C2=A0 188.139299]=C2=A0=C2=A0 lock(&syncobj->lock);
> [=C2=A0 188.139312]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_irq_disable=
();
> [=C2=A0 188.139320]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock(&vc4->job_lo=
ck);
> [=C2=A0 188.139335]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock(&syncobj->lo=
ck);
> [=C2=A0 188.139350]=C2=A0=C2=A0 <Interrupt>
> [=C2=A0 188.139358]=C2=A0=C2=A0=C2=A0=C2=A0 lock(&vc4->job_lock);
> [=C2=A0 188.139372] *** DEADLOCK ***
>=20
> Hand the fence over after job_lock is dropped. The job can complete
> and
> drop exec->fence in that window, so take a reference first and
> publish
> through the local pointer, as exec may already be gone.
>=20
> Fixes: e84fcb95e074 ("drm/vc4: Export fence through syncobj")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/vc4/vc4_gem.c | 10 +++++++++-
> =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c
> b/drivers/gpu/drm/vc4/vc4_gem.c
> index 6ee4bd77d433..f4be154d4eb0 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -639,8 +639,11 @@ vc4_queue_submit(struct drm_device *dev, struct
> vc4_exec_info *exec,
> =C2=A0	fence->seqno =3D exec->seqno;
> =C2=A0	exec->fence =3D &fence->base;
> =C2=A0
> +	/* The job can complete and drop exec->fence as soon as
> job_lock is
> +	 * released, so hold our own reference.
> +	 */
> =C2=A0	if (out_sync)
> -		drm_syncobj_replace_fence(out_sync, exec->fence);
> +		dma_fence_get(&fence->base);
> =C2=A0
> =C2=A0	vc4_attach_fences(exec);
> =C2=A0
> @@ -662,6 +665,11 @@ vc4_queue_submit(struct drm_device *dev, struct
> vc4_exec_info *exec,
> =C2=A0
> =C2=A0	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> =C2=A0
> +	if (out_sync) {
> +		drm_syncobj_replace_fence(out_sync, &fence->base);
> +		dma_fence_put(&fence->base);
> +	}
> +

Doesn't this mean that it is theoretically possible that a very small
job completes and its FLDONE/FRDONE interrupts trigger before we had a
chance to install the fence?

Iago

> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
>=20

