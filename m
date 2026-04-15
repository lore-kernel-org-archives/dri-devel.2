Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B0DF43834
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C3B10E264;
	Wed, 15 Apr 2026 15:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JnwDW5AU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1788D10E264
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776266561;
 bh=x2GcCP98BHv21M38LvdMSWgp2wBaxJBwqyiwHbyeXOQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JnwDW5AUyMjPakQ1pQ42GH56H+cQk+PT7gHhDK9vmsVqsvTQ/gYPAMUKAtTOx4qzF
 GNpC2+OaXrsSyejwICVScg3qh8LjYSPer272PtUlpdgRtK2lc39X9AHfyWNEEIwuu6
 xaF3u7OdhKhfhvi6xIEepLOC8mM25KCxge4G4/RVZq+w0GS6hqNOFsrlgI/MFMQ/DX
 JpHnsGk2fx8h1VE7+gQkZraimQqeFdpAQUS8pBM0FZLKT3gcYXufftUQn/Puo/6knr
 d11y1OTAqC4WGSQJwSH4302Xp3s5GlpQQ39B5r4jZiGG8Tnba4PHVnqQeSLFA0HAqi
 sSK6HQg2dQjDg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D38017E0610;
 Wed, 15 Apr 2026 17:22:41 +0200 (CEST)
Date: Wed, 15 Apr 2026 17:22:33 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v7 6/6] drm/panthor: Bump the driver version to 1.9
Message-ID: <20260415172233.543c6d81@fedora>
In-Reply-To: <20260415112900.681834-7-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-7-adrian.larumbe@collabora.com>
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

On Wed, 15 Apr 2026 12:28:50 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Bump the driver version to reflect the new MMU info query ioctl
> parameter and the VM_BIND map sparse flag.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index a8090bc4e33c..c8fb63ede62c 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1787,6 +1787,8 @@ static void panthor_debugfs_init(struct drm_minor *=
minor)
>   *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
>   *       - adds drm_panthor_gpu_info::selected_coherency
>   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
> + * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
> + *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
>   */
>  static const struct drm_driver panthor_drm_driver =3D {
>  	.driver_features =3D DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |

