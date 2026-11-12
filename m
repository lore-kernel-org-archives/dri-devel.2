Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=DBmDNN+R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD3710EB5F;
	Thu, 12 Nov 2026 08:16:05 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643F110EB5F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=FS0+vGeKNtvOfgv5OXVopu/rQI02csVeg7b9BvVsjrk=; t=1794471360; x=2109831360; 
 b=DBmDNN+RIlrOW9CbjEB3qTh2YXZSADs3oi/Kx9F2A3HgPnsgcrux8jzcl6LR0M+1l+FOi51ESgT
 pyfKALsCX2auVxpGSBvZx5pahYr+S0MF88uVArbh5ymyu00MXLNFnTqopU6Kwo/WXJjSTxb6s2JM8
 ugEScUTWdrv6HgdhVlsSltQTfBtzcESRymNnyiI2v06lmRMc1rbjCS5tnqAFyyNXZxjTA+BiMIE49
 8k5/5xXmemrX8NeJaaVoLstK1V9HjvxIRXfk0Aq6tGP3mEbXqHhUkc/mPJU3fc4fzWHLMIrWtPY25
 2xJnGXfGEmQ2V8m2dynwVVdJ5wGoqsc7VVNg==;
Received: from [192.168.12.229] by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRPyN-009Mb6-Or; Thu, 12 Nov 2026 09:15:55 +0100
Message-ID: <aab3777ba5bfeabcf5433c406a6becede74a1eb0.camel@igalia.com>
Subject: Re: [PATCH v2 0/4] drm/vc4: Fix the V3D interrupt state across
 power transitions
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Thu, 12 Nov 2026 09:15:55 +0100
In-Reply-To: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
References: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks! looks good to me:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El mi=C3=A9, 11-11-2026 a las 12:05 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> The V3D block is runtime suspended whenever it goes idle, and the
> driver
> does not fully restore its interrupt state on the way back up. This
> series
> fixes the paths that lose that state, or that touch V3D registers
> while
> the block is powered down.
>=20
> PATCH 1 takes a runtime PM reference around the binner BO allocation.
> vc4_create_bo_ioctl() reaches bin_bo_alloc() without powering the
> block
> up, so its write to V3D_INTENA can land on a suspended device.
>=20
> PATCH 2 rebuilds the interrupt mask on every resume. The out-of-
> memory
> interrupt was armed once, when the binner BO was allocated, and
> masked on
> every suspend, so an overflow after an autosuspend raised nothing and
> the
> binner stalled until the hangcheck. vc4_irq_enable() now derives that
> bit
> from whether a binner BO exists, and vc4_irq_reset() goes through it.
>=20
> PATCH 3 re-enables the IRQ line after a GPU reset. vc4_reset()
> disables
> it through vc4_irq_disable() and nothing enables it again, so after
> the
> first hang, jobs only retire through hangcheck resets. This is a
> v7.4-rc1
> regression and relies on PATCH 2.
>=20
> PATCH 4 is a small clean-up for drm-misc-next.
>=20
> Let me know your thoughts.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> v1 -> v2:
> https://lore.kernel.org/r/20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igal=
ia.com
>=20
> - Rebased on drm-misc-fixes, which now carries the reset controller
> series.
> - Dropped "drm/vc4: Bound the wait for a binner slot in the overflow
> work",
> =C2=A0 superseded by commit cca01232d94a ("drm/vc4: Fix binner slot
> allocation
> =C2=A0 failing on an idle GPU").
> - Dropped "drm/vc4: Hold a runtime PM reference in the binner
> overflow
> =C2=A0 work", as vc4_v3d_runtime_suspend() already drains the work before
> =C2=A0 powering down.
> - Dropped "drm/vc4: Let runtime PM tear the V3D down at unbind".
> - New patch: "drm/vc4: Re-enable the V3D interrupt after a GPU
> reset".
>=20
> ---
> Ma=C3=ADra Canal (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Hold a runtime PM reference while=
 allocating the
> binner BO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Rebuild the V3D interrupt mask on=
 every power
> transition
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Re-enable the V3D interrupt after=
 a GPU reset
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Take the IRQ number from vc4_dev =
in vc4_irq_install()
>=20
> =C2=A0drivers/gpu/drm/vc4/vc4_drv.h |=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/vc4/vc4_irq.c | 49 ++++++++++++++++++++++----------=
-
> ----------
> =C2=A0drivers/gpu/drm/vc4/vc4_v3d.c | 10 ++++++---
> =C2=A03 files changed, 33 insertions(+), 28 deletions(-)
> ---
> base-commit: 8bf8cda54c08ee3693f4dd1e2b7607fe5e466c79
> change-id: 20260816-vc4-irq-cleanup-8a38d16f5a35
>=20
>=20

