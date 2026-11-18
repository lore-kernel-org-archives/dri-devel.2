Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD7606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLnGJ4iY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC9110E6F1;
	Wed, 18 Nov 2026 01:14:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E003410E6F1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:14:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0CEA4063D;
 Wed, 18 Nov 2026 01:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD751F000C4;
 Wed, 18 Nov 2026 01:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794964471;
 bh=E5di7BErvTJeU9fV1ghFsLbJhRJchUQy4HH2act6erU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OLnGJ4iYEmTqUCvrDY+gVrIOgsWyN85FFay5JNKpIUwBqPbAr8C+oeu7bpvv5TAME
 BWdOk5K85sC77GJiDBL85xbUltRvsDtsTKrv1RyC8S5rZNJ2uY2rQXjBM8OWQueVH9
 SFvI4m/vwO7JOLVfitWRsr9LVuaS0K/03nsKkMpKPFNrpjBfUSMGBlKjp4k3zZo+8b
 OvH9VHieN+i7wEuCNi9JXngnRL4W+gPHKDupW+mnatBXnQs1C2eYoEtXPP7kE9WqQb
 LOrx97xxIjKiVJASvS3yCP1UZD+zHtxWd1h0YfXoxTXPoGS91vvaDiPY+1dNaWGkLy
 Ghl+ON3OcFO+Q==
Message-ID: <sashiko-outbox-219899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/12] iommu: Enable DMA default domains on (most)
 32-bit ARM platforms
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118-b4-arm32-iommu-dma-cookie-v4-8-0c5561288e22@nvidia.com>
References: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
 <20261118-b4-arm32-iommu-dma-cookie-v4-8-0c5561288e22@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 01:14:30 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] iommu/rockchip: use-after-free on device teardown with DMA
  default domain
--

commit 8d1920bbbf8a787c5aa107cb5120874184f3935a
Author: Mikko Perttunen <mperttunen@nvidia.com>

iommu: Enable DMA default domains on (most) 32-bit ARM platforms

This commit removes the unconditional IOMMU_DOMAIN_IDENTITY override for
CONFIG_ARM_DMA_USE_IOMMU in iommu_get_default_domain_type(), allowing
32-bit ARM platforms to use DMA default domains except on drivers that
explicitly opt out via def_domain_type.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 31c5e336dac76..2eaae4818913d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1887,18 +1887,6 @@ static int iommu_get_default_domain_type(struct io=
mmu_group *group,
> =20
>  	lockdep_assert_held(&group->mutex);
> =20
> -	/*
> -	 * ARM32 drivers supporting CONFIG_ARM_DMA_USE_IOMMU can declare an
> -	 * identity_domain and it will automatically become their default
> -	 * domain. Later on ARM_DMA_USE_IOMMU will install its UNMANAGED domain.
> -	 * Override the selection to IDENTITY.
> -	 */
> -	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
> -		static_assert(!(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) &&
> -				IS_ENABLED(CONFIG_IOMMU_DMA)));
> -		driver_type =3D IOMMU_DOMAIN_IDENTITY;
> -	}
> -
>  	for_each_group_device(group, gdev) {
>  		driver_type =3D iommu_get_def_domain_type(group, gdev->dev,
>  							driver_type);

[Severity: High]
Does switching rockchip-iommu to a DMA default domain on 32-bit ARM cause
a use-after-free of rk_domain when a client device is removed?

Previously on 32-bit ARM, group->default_domain was the static
rk_identity_domain, and arm_teardown_iommu_dma_ops() detached the legacy
UNMANAGED domain (re-attaching rk_identity_domain and unlinking
iommu->node from rk_domain->iommus) before freeing it.

With this change, group->default_domain is a dynamically allocated
IOMMU_DOMAIN_DMA domain.  On device teardown, arm_teardown_iommu_dma_ops()
returns early for DMA default domains, and iommu_deinit_device() frees
group->default_domain without detaching the device because rk_iommu_ops
sets neither release_domain nor detachment logic in
rk_iommu_release_device():

drivers/iommu/rockchip-iommu.c:rk_iommu_release_device() {
	struct rk_iommudata *data =3D dev_iommu_priv_get(dev);

	device_link_del(data->link);
}

drivers/iommu/rockchip-iommu.c:rk_iommu_domain_free() {
	struct rk_iommu_domain *rk_domain =3D to_rk_domain(domain);
	...
	WARN_ON(!list_empty(&rk_domain->iommus));
}

When the last device in the group is deinitialized, rk_iommu_domain_free()
hits the WARN_ON() and frees rk_domain while iommu->node remains on
rk_domain->iommus and iommu->domain still points to the freed domain,
which is later dereferenced in rk_iommu_resume() or rk_iommu_irq().

Setting .release_domain =3D &rk_identity_domain in rk_iommu_ops (or opting
rockchip-iommu out via def_domain_type) would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-b4-arm32-i=
ommu-dma-cookie-v4-0-0c5561288e22@nvidia.com?part=3D8
