Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8649C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A2F10EC31;
	Mon, 14 Sep 2026 08:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="An/ke5PO";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D1E710EC0D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789375506;
 bh=5t35/AD2DIV9TZyDKY+TCxkdh48h02qUWokLl3mkgzI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=An/ke5POqqfzDoq3Y3bRXllc9/2dKU4cpNMKg89B20Xm0rd6CBnKIpFjIKecEVNoe
 u1hj3fQY+SziIjtFyO8cx/Dj+VICwe9bFyq97cWuXLHGloV84IjXkexU9DyFypgWO3
 3ewudQUVUfJgzt7c3MX46FYNcndsonm6P5spbm0tpULeOR6LktP8W0o8amnDuH1kj3
 W0R/3Cvv/aj6FCITzc+C0JdsggwS9SlbaIlgxSKEKPiS3+KvUGM8Vo/zFJ96az0OoO
 Di3xAa6TnlF0EMnJkTWFPKFWrPC0cvjrZcaqE9wp07MtOvDTwSWv3wx29FrkOi4kKO
 KSpqfnOBc7nyg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1C0B117E020C;
 Mon, 14 Sep 2026 10:45:06 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:45:00 +0200
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
Subject: Re: [PATCH v9 05/16] drm/panfrost: Consolidate device clock
 management and reset
Message-ID: <20260914104500.6e32c6cd@fedora-21.home>
In-Reply-To: <20260912-claude-fixes-v9-5-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-5-e588feaa61ef@collabora.com>
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

On Sat, 12 Sep 2026 00:28:06 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Gather all clock enables and disables into a single function to avoid
> repetitions between driver init/fini and device resume/suspend, since
> these clocks are always handled in bulk.
>=20
> Also do clk (un)prepares and dis/enables at the same time, since the
> clk_prepare_* family of functions can simply increase the refcnt of
> an already prepared clock.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Two nits below.

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 118 +++++++++++++----------=
------
>  1 file changed, 52 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index b3a53504bd01..2fcbd223204c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -34,10 +34,46 @@ static void panfrost_reset_fini(struct panfrost_devic=
e *pfdev)
>  	reset_control_assert(pfdev->rstc);
>  }
> =20
> -static int panfrost_clk_init(struct panfrost_device *pfdev)
> +static int panfrost_clk_enable(struct panfrost_device *pfdev, bool enabl=
e_ace_clock)

I don't want to have a flag added for each new clock we decide to keep
enabled on RPM suspend, so how about s/enable_ace_clock/on_resume/?
Also, since it's enabling more than one clk, I'd go
s/panfrost_clk_enable/panfrost_clks_enable/.

>  {
>  	int err;
> +
> +	err =3D clk_prepare_enable(pfdev->clock);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_prepare_enable(pfdev->bus_clock);
> +	if (err)
> +		goto disable_clock;
> +
> +	if (enable_ace_clock) {
> +		err =3D clk_prepare_enable(pfdev->bus_ace_clock);
> +		if (err)
> +			goto disable_bus_clock;
> +	}
> +
> +	return 0;
> +
> +disable_bus_clock:
> +	clk_disable_unprepare(pfdev->bus_clock);
> +disable_clock:
> +	clk_disable_unprepare(pfdev->clock);
> +
> +	return err;
> +}
> +
> +static void panfrost_clk_disable(struct panfrost_device *pfdev, bool dis=
able_ace_clock)

Similarly, I'd go s/disable_ace_clock/on_suspend/ and
s/panfrost_clk_disable/panfrost_clks_disable/.

