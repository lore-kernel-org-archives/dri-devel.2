Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6D5C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074DD10E8A6;
	Mon, 14 Sep 2026 10:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EI505bum";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3618C10E462
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789381183;
 bh=rDGcdjgbm/CAUdK7EL0dgXysoeNtXkRXZp/pdyGDwHc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EI505bum8bVbquLp0u1D2ErvxoyPBW5EHp4nJ33M9Fy/NlvMCVdOFHnlkXR3K5Vuu
 dawNLw/fo4YVJ9lHh9k4UG8N0i21hYWi4u59L2YVwFzHoVH/dscJInzjrJPnFa/MsR
 tacrn+xL4iTaHc3YQK88xf1W8bMyuGqz9ZYrVRipD81TJcwX+Nw6kv/It+Wv3srzZu
 9XYlCsYK7Zmh9lwQ12MZZ6YX+tWBD4WdZ9bwi2ZyyX32nJXS+GVKJTXMndJPlFgMpa
 daMVNxdTHxETTf5yCLF9pdLOEK6IQlWYszZaLFR5vu6DnuElSHcZS12uAcZfKoKuPA
 BubScWAV4tnXg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 09C9F17E091A;
 Mon, 14 Sep 2026 12:19:43 +0200 (CEST)
Date: Mon, 14 Sep 2026 12:19:37 +0200
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
Subject: Re: [PATCH v9 16/16] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
Message-ID: <20260914121937.6f75e87b@fedora-21.home>
In-Reply-To: <20260912-claude-fixes-v9-16-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-16-e588feaa61ef@collabora.com>
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

On Sat, 12 Sep 2026 00:28:17 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Expose expanded PERFCNT_DUMP IOCTL interface to user mode.

I don't think it makes sense to have the version bump in a separate
commit when the changes adding support for a uAPI extension are all in a
single commit, so I'd squash this commit into patch 15.

>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 571a26b84126..de9b1c115181 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driv=
er_fops =3D {
>   * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
>   *	   PANFROST_IOCTL_QUERY_BO_INFO and
>   *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
> + * - 1.7 - adds PERFCNT_DUMP req state field
>   */
>  static const struct drm_driver panfrost_drm_driver =3D {
>  	.driver_features	=3D DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
> @@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver =
=3D {
>  	.name			=3D "panfrost",
>  	.desc			=3D "panfrost DRM",
>  	.major			=3D 1,
> -	.minor			=3D 6,
> +	.minor			=3D 7,
> =20
>  	.gem_create_object	=3D panfrost_gem_create_object,
>  	.gem_prime_import	=3D panfrost_gem_prime_import,
>=20

