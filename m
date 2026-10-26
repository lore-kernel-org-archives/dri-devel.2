Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F900606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAJg6+R2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07BB10EEDD;
	Mon, 26 Oct 2026 12:24:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFEE10EEB3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:24:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C631040392;
 Mon, 26 Oct 2026 12:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1E51F01825;
 Mon, 26 Oct 2026 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793017473;
 bh=4uCgUlVYLirbQogzf43cD3y2t28DleD4KOxqpG/A26Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gAJg6+R27XPOFSp/nNu30l90JtCDwvdmhhQeEII4g7pi9AWfrZu/cvR4CNAgvwvmP
 QfPCGoxaRqPDJUF4hrygotOp+lW9kCAa+qdNUATla+jhEakwbiT1VFmKj1IUWrpiNe
 S/iGyDjUPgK9nyT/alRW8vGKgJ9STnnFTZtJNUK6YGvzm7i6J9+6A0x9R3en4LBiwi
 bseCKrMfmgQLWMn1BiCkeb9Vge9YmGGbaXKsRAH5GmI0tWhDZ8GRw1CPukai+Z/UA4
 Qv51sjpN1MCyWjKuH7YMOGEQUVqLMYTPqmb5JNGY5nMvpBeSEwHv8uPY9/Vi1JphhR
 df/wXNQ+mLhIA==
Message-ID: <sashiko-outbox-185204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] iommu/tegra-smmu: Use a DMA API default domain
 per swgroup
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-b4-arm32-iommu-dma-cookie-v3-10-3901d74b1ff2@nvidia.com>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
 <20261026-b4-arm32-iommu-dma-cookie-v3-10-3901d74b1ff2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:24:33 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] iommu/tegra-smmu: tegra_smmu_attach_dev() leaks old paging domain =
resources
- [High] iommu/tegra-smmu: NULL dereference in tegra_smmu_identity_attach()=
 on probe failure
--

commit 82c4953fbede4f90881980155ea701c19e530777
Author: Mikko Perttunen <mperttunen@nvidia.com>

iommu/tegra-smmu: Use a DMA API default domain per swgroup

This commit enables IOMMU_DOMAIN_DMA default domains on a per-swgroup
basis via a use_dma_api flag, initially enabled for TegraDRM and Host1x
devices, and sets .release_domain to tegra_smmu_identity_domain.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 6779528a9e7cc..73c6151db8f8c 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -994,16 +994,20 @@ static int tegra_smmu_of_xlate(struct device *dev,
> =20
>  static int tegra_smmu_def_domain_type(struct device *dev)
>  {
> -	/*
> -	 * FIXME: For now we want to run all translation in IDENTITY mode, due
> -	 * to some device quirks. Better would be to just quirk the troubled
> -	 * devices.
> -	 */
> -	return IOMMU_DOMAIN_IDENTITY;
> +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> +	struct tegra_smmu *smmu =3D dev_iommu_priv_get(dev);
> +	const struct tegra_smmu_swgroup *swgroup;
> +
> +	swgroup =3D tegra_smmu_find_swgroup(smmu, fwspec->ids[0]);
> +	if (WARN_ON(!swgroup) || !swgroup->use_dma_api)
> +		return IOMMU_DOMAIN_IDENTITY;
> +
> +	return IOMMU_DOMAIN_DMA;
>  }

[Severity: High]
Does transitioning between two paging domains leak the old domain's as->id
and as->pd_dma?

When tegra_smmu_def_domain_type() returns IOMMU_DOMAIN_DMA,
group->default_domain is a paging domain (struct tegra_smmu_as) rather than
tegra_smmu_identity_domain.

When switching between two paging domains (for example, attaching or
detaching an explicit unmanaged domain or a blocking domain over the
IOMMU_DOMAIN_DMA default domain, or changing the default domain type via
sysfs), the core invokes tegra_smmu_attach_dev(domain, dev, old). However,
tegra_smmu_attach_dev() ignores old and only prepares and enables the new
domain:

drivers/iommu/tegra-smmu.c:tegra_smmu_attach_dev() {
	...
	for (index =3D 0; index < fwspec->num_ids; index++) {
		err =3D tegra_smmu_as_prepare(smmu, as);
		if (err)
			goto disable;

		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
	}
	...
}

Because tegra_smmu_as_unprepare() is only called from
tegra_smmu_identity_attach(), the replaced paging domain's as->use_count is
never decremented. When that domain is later freed via
tegra_smmu_domain_free(), it triggers WARN_ON_ONCE(as->use_count) and
permanently leaks its hardware ASID in smmu->asids and its page directory
DMA mapping as->pd_dma.

> =20
>  static const struct iommu_ops tegra_smmu_ops =3D {
>  	.identity_domain =3D &tegra_smmu_identity_domain,
> +	.release_domain =3D &tegra_smmu_identity_domain,

[Severity: High]
Can setting .release_domain to tegra_smmu_identity_domain cause a NULL
pointer dereference in tegra_smmu_identity_attach() if attaching the
default domain fails during probe?

During __iommu_probe_device() -> iommu_setup_default_domain(), a new
IOMMU_DOMAIN_DMA domain is allocated with as->smmu =3D NULL and
as->use_count =3D 0, and attached via:

  __iommu_group_set_domain_internal(group, dom, IOMMU_SET_DOMAIN_MUST_SUCCE=
ED)

If tegra_smmu_attach_dev() fails inside tegra_smmu_as_prepare() (for
example, if tegra_smmu_alloc_asid() returns -ENOSPC when all 4 hardware
ASIDs on Tegra30/Tegra114 are in use, or dma_map_single() fails), as->smmu
remains NULL. Because IOMMU_SET_DOMAIN_MUST_SUCCEED is passed,
__iommu_group_set_domain_internal() still assigns group->domain =3D dom
before returning the error.

On the error unwind path in __iommu_probe_device(), iommu_deinit_device()
attaches ops->release_domain while passing group->domain as old, which
calls tegra_smmu_identity_attach():

drivers/iommu/tegra-smmu.c:tegra_smmu_identity_attach() {
	...
	if (old =3D=3D identity_domain || !old)
		return 0;

	as =3D to_smmu_as(old);
	smmu =3D as->smmu;
	for (index =3D 0; index < fwspec->num_ids; index++) {
		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
		tegra_smmu_as_unprepare(smmu, as);
	}
	return 0;
}

Here, smmu is NULL, which is then dereferenced in tegra_smmu_disable() and
tegra_smmu_as_unprepare(). Similarly, if a second device joining an already
active shared group fails in __iommu_probe_device() before attaching to
group->domain, iommu_deinit_device() will call tegra_smmu_identity_attach()
and unprepare the shared group->domain even though the failing device never
prepared it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-arm32-i=
ommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com?part=3D10
