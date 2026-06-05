Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94928CD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 06:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D787E11A4A4;
	Fri,  5 Jun 2026 06:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Fs2nzRGD";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58BB911A4A4
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780642623;
 bh=LDNE0PCqdr8cYX/2zuHR/Om4KYmu/RC087LLjZvTnHg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Fs2nzRGDRMdASQMYj9SnCgp8VmFdLY7KngQF/0+JEWtI6rDlVWEzxzamvdduFZLbZ
 7hAzsbW0GLoQHs1kg1VsW9tynKaKDEQ3GEJCrHQIEQAtO3QEC0z8f21ZF8+7vpNIG7
 AFxs26QluGo9Wr0NrIdZisI1D3kEsJ3eG8YexFD2uwcQUGUHJueSDwJHU/3SN7Bw5Z
 WbseE0z7REZU2awXP80xqAF1WaVabF9X9GiH7Kp1DDyv2a+87QLhf1ijJoO7yq2Xdf
 okdn5JgjxPrkaucj2qGqMknKhxcAKsEDckNlhCdDSL+AMIZNaxs9oHDz16gsx9oWQb
 PWxr6WeSAFIiQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 269EE17E0413;
 Fri,  5 Jun 2026 08:57:03 +0200 (CEST)
Date: Fri, 5 Jun 2026 08:56:57 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 7/7] drm/panfrost: Explicitly enable MMU interrupts
 at device init
Message-ID: <20260605085657.1c56998e@fedora-2.home>
In-Reply-To: <20260604-claude-fixes-v2-7-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-7-57c6bd4c1655@collabora.com>
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

On Thu, 04 Jun 2026 18:35:26 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Because the device must be in a position to accept jobs between the time
> drm_dev_register() is called and autosuspend first kicks in, there's a ve=
ry
> narrow window inbetween during which jobs targeting the tiler buffer
> object would time out, since the device's PM status is 'Active', but no M=
MU
> interrupts were enabled at device initialisation time.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 +++++++++--
>  drivers/gpu/drm/panfrost/panfrost_mmu.h |  2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 4a3162c3b659..0e1ad6256c2c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfd=
ev, struct panfrost_mmu *mmu
>  	WARN_ON(atomic_read(&mmu->as_count) < 0);
>  }
> =20
> +void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
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
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.h
> index 27c3c65ed074..3140eb4fea0f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> @@ -12,6 +12,8 @@ struct panfrost_mmu;
>  int panfrost_mmu_map(struct panfrost_gem_mapping *mapping);
>  void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping);
> =20
> +void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev);

You don't need to expose this function, it's only used inside
panfrost_mmu.c.

> +
>  int panfrost_mmu_init(struct panfrost_device *pfdev);
>  void panfrost_mmu_fini(struct panfrost_device *pfdev);
>  void panfrost_mmu_reset(struct panfrost_device *pfdev);
>=20

