Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBF0C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D389B10E3E8;
	Wed, 12 Aug 2026 09:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="H1u8Im8D";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240B610E3E8
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786526098;
 bh=BMOSRgO4o9vg3eURWlnguEfeQAR1ERhR+pvEOaJw2xw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=H1u8Im8DVWdeYOloeBnHLExoEKMrTj4yXvxUOy7RDNpdpyysp8vWWAPH9UhuOcHJt
 p8B6rxkevqud9YrxPoT0gSuX/D6VNacaVFc9jEwyh0j++q7Ca9f+SX4KwgRH8TIK+c
 83ruvltWsiLSRh148wjHFpjKbTazjHS2lYCOY5PSe4k5LfgGgGxfzbo6dZUNTgkH8Q
 vfdcQplkBV/gX+MxHpVTk8i1H0ncvb1cL0kHWUUpUW5sQL3xZ7jV+XyfJzQhoqAtjz
 t+O05bnhtxaKVgO33bvRwpR8zVzaLsjirv1gHWIvniw3GDWoCSHjJXRGpvTs6TWTuo
 uiCdgJCu24vZA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 13AFE17E0967;
 Wed, 12 Aug 2026 11:14:58 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:14:53 +0200
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
Subject: Re: [PATCH v5 06/11] drm/panfrost: Explicitly enable MMU interrupts
 at device init
Message-ID: <20260812111453.330dd57a@fedora-21.home>
In-Reply-To: <20260811-claude-fixes-v5-6-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-6-3d692c9e98c2@collabora.com>
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

On Tue, 11 Aug 2026 22:42:15 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Because the device must be in a position to accept jobs between the time
> drm_dev_register() is called and autosuspend first kicks in, there's a ve=
ry
> narrow window inbetween during which jobs targeting the tiler buffer
> object would time out, since the device's PM status is 'Active', but no M=
MU
> interrupts were enabled at device initialisation time.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

It's probably good to have the IRQ regs initialized in the init()
function, though I'd like to be sure this is enough. If we assume
that a reset is what it takes to have a functional device, shouldn't we
do this reset in the device_init() path, before drm_dev_register() is
called?

>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 3fe37dd12360..a8ce5d65825c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfd=
ev, struct panfrost_mmu *mmu
>  	WARN_ON(atomic_read(&mmu->as_count) < 0);
>  }
> =20
> +static void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
> +{
> +	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> +	mmu_write(pfdev, MMU_INT_MASK, ~0);
> +}
> +
>  void panfrost_mmu_reset(struct panfrost_device *pfdev)
>  {
>  	struct panfrost_mmu *mmu, *mmu_tmp;
> @@ -355,8 +361,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
> =20
>  	spin_unlock(&pfdev->as_lock);
> =20
> -	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> -	mmu_write(pfdev, MMU_INT_MASK, ~0);
> +	panfrost_mmu_enable_interrupts(pfdev);
>  }
> =20
>  static size_t get_pgsize(u64 addr, size_t size, size_t *count)
> @@ -970,6 +975,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
> =20
> +	panfrost_mmu_enable_interrupts(pfdev);
> +
>  	return 0;
>  }
> =20
>=20

