Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116E606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nq85jMNq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5123910E134;
	Wed, 18 Nov 2026 01:01:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7920310E134
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:01:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0EA460E1F;
 Wed, 18 Nov 2026 01:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805081F000C4;
 Wed, 18 Nov 2026 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794963676;
 bh=jIpgTOulB+h6BFaXEIIL7VG6YqJxL/WMMuRUXqXozq0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nq85jMNqR10j8JOzmardWkTHvlmOGqHvHfuOehLT/4MUwD0bPATYb/eyhZvFwUmOZ
 mx4ENqNAlHFK3fkVzXee70b7h2WugZKamLAZm/8UBw54Z9D245le33iNGaX96Sx06J
 uBesOA73t/LYxqW6VWDJ81R7x82DwvTWl7ajTHENS49GLMf0Y4kJh5Fi3vItRMHav0
 huHI1Q3kr/f5qnzXEkSeiHc2ZBSTxLGIDFzWzbr2FIzI7VfMs52ZfJetxLPU7dd7e9
 b5cKtv9w74DuuS8LDgRaHKaOQIWb/vn6Gzc16NvpdTDHQLrUPZSPtQrcRADvIRcqsX
 1h69w0cWgK4tg==
Message-ID: <sashiko-outbox-219890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] iommu/tegra-smmu: Use a DMA API default domain
 per swgroup
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118-b4-arm32-iommu-dma-cookie-v4-12-0c5561288e22@nvidia.com>
References: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
 <20261118-b4-arm32-iommu-dma-cookie-v4-12-0c5561288e22@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 01:01:16 +0000
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
- [High] iommu/tegra-smmu: NULL dereference in
  tegra_smmu_identity_attach() on probe fail
--

commit 771cf7a7b7503c071081ede10ec54512cfe880ec
Author: Mikko Perttunen <mperttunen@nvidia.com>

iommu/tegra-smmu: Use a DMA API default domain per swgroup

This commit enables IOMMU_DOMAIN_DMA default domains on a per-swgroup
basis for TegraDRM and Host1x devices and sets .release_domain to the
identity domain in tegra_smmu_ops.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 0e8414d8a5047..3f938ae4cffc6 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -997,16 +997,20 @@ static int tegra_smmu_of_xlate(struct device *dev,
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
> =20
>  static const struct iommu_ops tegra_smmu_ops =3D {
>  	.identity_domain =3D &tegra_smmu_identity_domain,
> +	.release_domain =3D &tegra_smmu_identity_domain,
>  	.def_domain_type =3D &tegra_smmu_def_domain_type,

[Severity: High]
Can setting .release_domain =3D &tegra_smmu_identity_domain cause a NULL
pointer dereference in tegra_smmu_identity_attach() if attaching the
default DMA domain fails during device probe?

When iommu_setup_default_domain() attaches a newly allocated paging
domain via __iommu_group_set_domain_internal() with
IOMMU_SET_DOMAIN_MUST_SUCCEED, group->domain is set even if
tegra_smmu_attach_dev() -> tegra_smmu_as_prepare() fails (for example,
when all 4 hardware ASIDs on Tegra30/Tegra114 are in use and
tegra_smmu_alloc_asid() returns -ENOSPC), leaving as->smmu as NULL and
as->use_count as 0:

drivers/iommu/tegra-smmu.c:tegra_smmu_as_prepare() {
	...
	err =3D tegra_smmu_alloc_asid(smmu, &as->id);
	if (err < 0)
		goto err_unmap;
	...
	as->smmu =3D smmu;
	as->use_count++;
}

On the error unwind path in __iommu_probe_device(), iommu_deinit_device()
attaches release_domain and passes group->domain as old to
tegra_smmu_identity_attach(), which unconditionally reads smmu =3D as->smmu
and dereferences it in tegra_smmu_disable() and
tegra_smmu_as_unprepare():

drivers/iommu/tegra-smmu.c:tegra_smmu_identity_attach() {
	...
	as =3D to_smmu_as(old);
	smmu =3D as->smmu;
	for (index =3D 0; index < fwspec->num_ids; index++) {
		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
		tegra_smmu_as_unprepare(smmu, as);
	}
}

Similarly, if a second device joining an already active shared group
fails in __iommu_probe_device() before attaching to group->domain,
iommu_deinit_device() calls tegra_smmu_identity_attach() with the shared
group->domain, disabling the swgroup and decrementing as->use_count for
a device that never attached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-b4-arm32-i=
ommu-dma-cookie-v4-0-0c5561288e22@nvidia.com?part=3D12
