Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5AEC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B56310ECD1;
	Tue,  1 Sep 2026 13:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FCqLq1wj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D3C210ECD1
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788268088;
 bh=qH64igqWmhbPPqereCNZa1DEz1woVgjOvI/xPj3Lx8s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FCqLq1wjHQYD1btvljkUdwtODyAwZQyQdQKalOf1PZZYUbWb2ZsV8n0JmlL3rEHcj
 CVdcBOIG6cncmviEIPytcxC23KlY3RflHwhcQymkObO0hGp7ot31/J9gKkvk2dZZD+
 WGqPRmi3HbFdZO7J7ZB9b88s0dNq0mHKmvG+0aLYuMsgIow6qL62YrnxTxRnsZCRhh
 YxVtRPypWSqWTZErVScEGuQIBphq+41tTGIQe9binjZnnUTqCjslE5ocdWxG6nG8lL
 ZexKq0pgtq0FTxOim8UXEUuNwsnRZy8gPhRYPP/UV93ua+6Tp0Jgaurz2mmL1ahXeN
 QJ4lMRGgzIIiQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3844617E006A;
 Tue, 01 Sep 2026 15:08:08 +0200 (CEST)
Date: Tue, 1 Sep 2026 15:08:04 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 08/17] drm/panfrost: Split subsystem init/reset from
 interrupt enablement
Message-ID: <20260901150804.75ce2f47@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-8-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-8-72a13b2c125d@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 28 Aug 2026 21:56:48 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Because MMU interrupts are only enabled when the device is reset, it
> happened that after DRM device registration, the very first job targeting
> the tiler heap BO would always time out. The reason is the reset sequence
> is only part of PM runtime resume, which is not called explicitly at driv=
er
> probe time, and an actual reset work item manually triggered after a HW
> error.
>=20
> I have attempted a somewhat drastic solution, which is completely
> decoupling GPU/MMU/JM subsystem initialisation and reset from interrupt
> enablement, so that we can handle IRQ toggling a bit more flexibly.
>=20
> To this end:
> - Ensure every subsystem with its own IRQ has an 'enable interrupts'
> method, and that it doesn't enable them anywhere else.
> - Force IRQ masking at MMU reset time. Up until, now, panfrost_mmu_reset()
> was clearing the MMU IRQ suspension bit, but at no point that is set duri=
ng
> the reset sequence.
>=20
> Then manually enable all interrupts when the device is fully initialised =
at
> probe time, right before DRM device registration, or after the reset
> sequence is complete. Also disable all interrupts at device remove time,
> so that their IRQs can be sync'ed right before tearing the device down.
>=20
> Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 40 ++++++++++++++++++++++--=
------
>  drivers/gpu/drm/panfrost/panfrost_device.h |  3 ++-
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 19 ++++++++------
>  drivers/gpu/drm/panfrost/panfrost_gpu.h    |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_job.c    |  7 +++---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    |  9 +++++--
>  drivers/gpu/drm/panfrost/panfrost_mmu.h    |  2 ++
>  7 files changed, 56 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 9e02fb5f73c8..99f7da2180f9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -226,6 +226,27 @@ static int panfrost_pm_domain_init(struct panfrost_d=
evice *pfdev)
>  	return err;
>  }
> =20
> +void panfrost_device_enable_int(struct panfrost_device *pfdev)
> +{
> +	panfrost_gpu_enable_interrupts(pfdev);
> +	panfrost_mmu_enable_interrupts(pfdev);
> +	panfrost_jm_enable_interrupts(pfdev);
> +}
> +
> +static void panfrost_device_enable_hw(struct panfrost_device *pfdev)
> +{
> +	panfrost_device_enable_int(pfdev);
> +	panfrost_devfreq_resume(pfdev);
> +}
> +
> +static void panfrost_device_disable_hw(struct panfrost_device *pfdev)
> +{
> +	panfrost_devfreq_suspend(pfdev);
> +	panfrost_jm_suspend_irq(pfdev);
> +	panfrost_mmu_suspend_irq(pfdev);
> +	panfrost_gpu_suspend_irq(pfdev);

Hm, I think I'd prefer if those suspend/resume_irq() were hidden in
some subcomponent panfrost_<subcomp>_suspend,resume() helpers. And
then we just have to resume/suspend component in the right order
instead of treating IRQs as a standalone object (enabling/disabling
only makes sense if the subcomponent handling those interrupts is
resumed/suspended).
