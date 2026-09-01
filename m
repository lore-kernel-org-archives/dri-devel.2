Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99618C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B056110E3F1;
	Tue,  1 Sep 2026 13:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QZwk9DQd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E7210E3F1
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788268743;
 bh=qV/Qw1Oeu++1QlSiJZ8tb59korzX57Tnk1SFiSIzSJo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QZwk9DQdQ9XPuiPWfXTz43J+4J7PhERLcj7Hi1plkxhUrjrkc0HdejGz01jj1DPql
 KUEQLiveC2ci9jyXIaqEdj+EwWvVgrxsaWf/LmMMOh8mbPcg4diYRnPkIvqBuludp+
 8cyKQjRlV1gwtf/4d7lj3SZogedD71wNrVOs/1HjvN7NjesN/RQhoGuMXBDKIN/oY+
 EfQsCAEK7KMAdOsIVYGZlGpKt8XUcI06EeOyCJxKYoN3xK1OszbNyhKTboSS023bgs
 l7+89gsOffQz317lmu9IMkk6Cg3cTV0Gnuf/40kz2ubPcjj9aWnXR1LlF2t2eoRzmi
 zC/PxlO96WeJQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C4E617E0260;
 Tue, 01 Sep 2026 15:19:02 +0200 (CEST)
Date: Tue, 1 Sep 2026 15:18:56 +0200
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
Subject: Re: [PATCH v7 09/17] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
Message-ID: <20260901151856.433920b6@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-9-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-9-72a13b2c125d@collabora.com>
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

On Fri, 28 Aug 2026 21:56:49 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> During device probe(), failure to do a PM get() will leave the usage_count
> set to 0, which is the value assigned at device creation time. That means
> when the autosuspend delay expires, runtime suspend callback won't be
> invoked, so the device will remain powered on forever.
>=20
> On top of that, failure to call PM put() during device unplug means
> Panfrost device's PM usage_count increases monotonically for every new
> module reload.
>=20
> The combined outcome of both of the above was that devfreq OPP transition
> notifications would be printed all the time, even when no jobs are being
> submitted. This quickly fills the kernel ring buffer with junk.
>=20
> To fix the above:
> - Manually adjust the PM refcnt at device probe and removal time.
> - Ensure pm_runtime_dont_use_autosuspend is called in the wind-down path.
> - Call pm_runtime_put_autosuspend() when device is ready to accept jobs
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")

Because of how things are currently ordered, this won't be backportable
without patch 2, which doesn't have a Fixes tag, so, either we put the
fix first, and then we move code, or we make it a single commit.

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 99f7da2180f9..70c8109ea698 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -322,6 +322,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
> =20
>  	pm_runtime_set_active(pfdev->base.dev);
>  	pm_runtime_mark_last_busy(pfdev->base.dev);
> +	pm_runtime_get_noresume(pfdev->base.dev);
>  	pm_runtime_enable(pfdev->base.dev);
>  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
>  	pm_runtime_use_autosuspend(pfdev->base.dev);
> @@ -334,9 +335,13 @@ int panfrost_device_init(struct panfrost_device *pfd=
ev)
>  	if (err < 0)
>  		goto out_devreg;
> =20
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> +
>  	return 0;
> =20
>  out_devreg:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_disable_hw(pfdev);
>  	panfrost_gem_fini(pfdev);
> @@ -363,7 +368,9 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
> =20
>  	panfrost_jm_stop_sched_jobs(pfdev);
>  	panfrost_device_disable_hw(pfdev);
>=20

