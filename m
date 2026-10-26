Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962A606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jV4rV/Hc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C84810E16C;
	Mon, 26 Oct 2026 11:38:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9785510E16C
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:38:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0263960A7F;
 Mon, 26 Oct 2026 11:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5381F01828;
 Mon, 26 Oct 2026 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793014727;
 bh=q6h0R49Jcge4o50qZE8+SxE4VpX2L5MqJzuS9Fjqrbw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jV4rV/HcBtNhOj5aj0VZZkiTq7+t+p6ioD97qJBBO41jsvgQOJDgoZgLqsc3NqPe6
 s/rq+VyIuf7lc36pYXYlq1gpqQpFhDXoslmiprYt6lDTbH3btGsnlmlePGCzzHo+sX
 tjBCj3TsGtSQL4kx/NJHSHlx2Hqhnk3r9cJuG2EpicjvVAXI6nhO1GINWWqWsGO4WN
 bACJyeCVtkuUKa5bohcEymxeZYPZksXG9Oliyj0oaNEN4/hesivCa9wi2Lm3x1Pesw
 boj0wimIm3bGoQcksB/z0rulGgLDQuxHIeWd3kj8R0UzKn0UiFML9qPvmiBmGMwWZG
 ddGGuWKFq2QcQ==
Message-ID: <sashiko-outbox-185113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] iommu: Enable DMA default domains on (most)
 32-bit ARM platforms
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-b4-arm32-iommu-dma-cookie-v3-7-3901d74b1ff2@nvidia.com>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
 <20261026-b4-arm32-iommu-dma-cookie-v3-7-3901d74b1ff2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:38:47 +0000
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
- [Critical] iommu: missing IDENTITY default domain override for qcom_iommu=
 on ARM32
- [Critical] iommu/rockchip: use-after-free on device teardown with DMA def=
ault domain
--

commit b1b0900ebc55a49be25130b8187ffecfc2191b42
Author: Mikko Perttunen <mperttunen@nvidia.com>

iommu: Enable DMA default domains on (most) 32-bit ARM platforms

This commit enables core-owned DMA default domains on 32-bit ARM platforms
with CONFIG_ARM_DMA_USE_IOMMU by removing the IOMMU_DOMAIN_IDENTITY override
in iommu_get_default_domain_type(). For several IOMMU drivers that are not
ready to switch over, it adds a def_domain_type callback returning
IOMMU_DOMAIN_IDENTITY.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5fbb76d44a1e9..e47f95fea44d0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1884,18 +1884,6 @@ static int iommu_get_default_domain_type(struct io=
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

[Severity: Critical]
Should qcom_iommu also keep an IOMMU_DOMAIN_IDENTITY default domain on 32-b=
it
ARM platforms?

CONFIG_QCOM_IOMMU selects CONFIG_ARM_DMA_USE_IOMMU, and qcom_iommu_ops in
drivers/iommu/arm/arm-smmu/qcom_iommu.c does not define a def_domain_type
callback or release_domain:

drivers/iommu/arm/arm-smmu/qcom_iommu.c:
    static const struct iommu_ops qcom_iommu_ops =3D {
        .identity_domain =3D &qcom_iommu_identity_domain,
        .capable	=3D qcom_iommu_capable,
        .domain_alloc_paging =3D qcom_iommu_domain_alloc_paging,

With this change, iommu_setup_default_domain() allocates and attaches a
paging IOMMU_DOMAIN_DMA group->default_domain via
qcom_iommu_attach_dev() -> qcom_iommu_init_domain(), which sets
qcom_domain->iommu, programs ARM_SMMU_CB_TTBR0 and ARM_SMMU_CB_SCTLR, and
sets ctx->domain =3D group->default_domain.

When a client driver such as drm/msm in msm_iommu_new()
(drivers/gpu/drm/msm/msm_iommu.c) or Venus in venus_firmware_init()
(drivers/media/platform/qcom/venus/firmware.c) attaches its own unmanaged
paging domain, arm_iommu_detach_device() and arm_iommu_release_mapping()
become no-ops because iommu_is_dma_domain(mapping->domain) is now true,
leaving dev->dma_ops set to &iommu_ops instead of restoring direct DMA ops.
Attaching the client's unmanaged domain then overwrites the context bank
registers and sets ctx->domain to the unmanaged domain.

When that unmanaged domain is later detached and freed (for example via
mdp5_kms_destroy() -> msm_iommu_detach() followed by drm_gpuvm_put() ->
msm_gem_vm_free() -> msm_iommu_destroy() in
drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c), __iommu_group_set_core_domain()
attempts to re-attach group->default_domain through qcom_iommu_attach_dev()=
 ->
qcom_iommu_init_domain():

drivers/iommu/arm/arm-smmu/qcom_iommu.c:qcom_iommu_init_domain() {
        mutex_lock(&qcom_domain->init_mutex);
        if (qcom_domain->iommu)
                goto out_unlock;
        ...
}

Because qcom_domain->iommu is already non-NULL from the initial boot attach,
qcom_iommu_init_domain() returns early without reprogramming
ARM_SMMU_CB_TTBR0 or ARM_SMMU_CB_SCTLR and without updating ctx->domain.
This leaves ARM_SMMU_CB_TTBR0 pointing to the freed page tables with
translation still enabled in ARM_SMMU_CB_SCTLR, and leaves ctx->domain
pointing to the freed unmanaged domain where qcom_iommu_fault() will
dereference it on a context fault:

drivers/iommu/arm/arm-smmu/qcom_iommu.c:qcom_iommu_fault() {
        ...
        if (report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {
        ...
}

Similarly, during iommu_deinit_device(), because qcom_iommu_ops does not set
release_domain =3D &qcom_iommu_identity_domain, group->default_domain is fr=
eed
while the hardware context bank remains enabled and ctx->domain remains a
dangling pointer.

>  	for_each_group_device(group, gdev) {
>  		driver_type =3D iommu_get_def_domain_type(group, gdev->dev,
>  							driver_type);
> @@ -1912,11 +1900,11 @@ static int iommu_get_default_domain_type(struct i=
ommu_group *group,
>  	}
> =20
>  	/*
> -	 * If the common dma ops are not selected in kconfig then we cannot use
> -	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
> -	 * selected.
> +	 * Without an IOMMU DMA implementation, force IDENTITY if the driver
> +	 * has not selected a domain type.
>  	 */
> -	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
> +	if (!IS_ENABLED(CONFIG_IOMMU_DMA) &&
> +	    !IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {

[Severity: Critical]
Can switching rockchip-iommu to an IOMMU_DOMAIN_DMA default domain on 32-bit
ARM cause a use-after-free during device teardown?

CONFIG_ROCKCHIP_IOMMU selects CONFIG_ARM_DMA_USE_IOMMU, and rk_iommu_ops in
drivers/iommu/rockchip-iommu.c defines neither def_domain_type nor
release_domain =3D &rk_identity_domain:

drivers/iommu/rockchip-iommu.c:
    static void rk_iommu_release_device(struct device *dev)
    {
        struct rk_iommudata *data =3D dev_iommu_priv_get(dev);

        device_link_del(data->link);
    }
    ...
    static const struct iommu_ops rk_iommu_ops =3D {
        .identity_domain =3D &rk_identity_domain,
        .domain_alloc_paging =3D rk_iommu_domain_alloc_paging,
        .probe_device =3D rk_iommu_probe_device,
        .release_device =3D rk_iommu_release_device,

Previously on 32-bit ARM, group->default_domain was the static
&rk_identity_domain, and during device teardown arch_teardown_dma_ops() ->
arm_teardown_iommu_dma_ops() -> arm_iommu_detach_device() detached the lega=
cy
UNMANAGED domain (re-attaching &rk_identity_domain and removing iommu->node
from rk_domain->iommus) before freeing it.

With this patch, group->default_domain is a dynamically allocated
IOMMU_DOMAIN_DMA paging domain attached via rk_iommu_attach_device(), which
sets iommu->domain =3D domain and adds iommu->node to rk_domain->iommus. Wh=
en a
client device is removed or fails probe, arm_teardown_iommu_dma_ops() retur=
ns
early for DMA default domains, and iommu_deinit_device() sees
ops->release_domain =3D=3D NULL, calls rk_iommu_release_device() without
detaching the domain, and then calls iommu_domain_free(group->default_domai=
n)
-> rk_iommu_domain_free():

drivers/iommu/rockchip-iommu.c:rk_iommu_domain_free() {
        struct rk_iommu_domain *rk_domain =3D to_rk_domain(domain);
        int i;

        WARN_ON(!list_empty(&rk_domain->iommus));
        ...
        kfree(rk_domain);
}

This triggers the WARN_ON() and frees rk_domain and its page directory while
iommu->node is still linked on rk_domain->iommus and iommu->domain still
points to the freed rk_domain (which is later dereferenced in
rk_iommu_enable() and rk_iommu_irq()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-arm32-i=
ommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com?part=3D7
