Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EC606A323
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DNdEAGo5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140A310E576;
	Fri, 23 Oct 2026 07:27:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B10D10E576
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:27:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5107660252;
 Fri, 23 Oct 2026 07:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D1A1F031E2;
 Fri, 23 Oct 2026 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792740466;
 bh=Fsn5fcCLJL4J5YSgosoLT98bUyV1U1KOay8uVikHbUU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DNdEAGo5uH1HZd79+tHz57jDdv7x83qxETjru6MyJPIJeV5rJ7L2adPA7xhZpVQt4
 L1O4oW27ikBgxUYzzKHPdbFgXEem7UIpY61JTI5PEMk82kG3oPuMsZzWfHt/zYYT5q
 SNbB8U8YwXGsHe31pmipdhd2qYszjP3TUjqKTJupf5BmzmILVumgZG2oFsc8CQn0Sx
 HDTLrOg6p8UTJNbQ4Ah5sMxou6sehNWuEApikSwr6si/doOrCMhDMslpgGh/9wSS01
 QWf+lJrriL51R7ryMNLPcnbFFRdEnCZ61/OJNpvU0Zzjp4HIGIFVXK6G3e2LmqLKN2
 T0bBxOshfTYtA==
Message-ID: <sashiko-outbox-182411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/16] accel/thames: Create a context per client on
 device open
To: "Tomeu Vizoso" <tomeu.vizoso@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261023-thames-v3-6-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-6-3ab40aa17157@tomeuvizoso.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:27:45 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/thames: mapping overlap in thames_context_alloc_user_pages()=
 on >4K pages
- [Medium] accel/thames: select IOMMU_IO_PGTABLE_LPAE without Kconfig depen=
dencies
--

commit aad1ae439ba5b7b0cdec19071014a9f8abea740d
Author: Tomeu Vizoso <tomeu.vizoso@gmail.com>

accel/thames: Create a context per client on device open

This commit creates a per-client context on device open and manages an
ARM_64_LPAE_S1 page table for each context using IOMMU_IO_PGTABLE_LPAE. It
allocates cyclic ASIDs, maps the core windows and per-context user stack and
save area pages, and populates the IPC context table entries.

> diff --git a/drivers/accel/thames/Kconfig b/drivers/accel/thames/Kconfig
> index c621002d8efaa..9362b92740751 100644
> --- a/drivers/accel/thames/Kconfig
> +++ b/drivers/accel/thames/Kconfig
> @@ -6,6 +6,7 @@ config DRM_ACCEL_THAMES
>  	depends on TI_K3_DSP_REMOTEPROC
>  	depends on REMOTEPROC
>  	depends on MAILBOX
> +	select IOMMU_IO_PGTABLE_LPAE

[Severity: Medium]
Can selecting IOMMU_IO_PGTABLE_LPAE here without its dependencies cause
unmet direct dependency warnings and build failures?

In drivers/iommu/Kconfig, IOMMU_IO_PGTABLE_LPAE is inside an if IOMMU_SUPPO=
RT
block (which depends on MMU) and has:

config IOMMU_IO_PGTABLE_LPAE
	bool "ARMv7/v8 Long Descriptor Format"
	select IOMMU_IO_PGTABLE
	depends on ARM || ARM64 || COMPILE_TEST
	depends on !GENERIC_ATOMIC64	# for cmpxchg64()

Because TI_K3_DSP_REMOTEPROC depends on ARCH_K3 || COMPILE_TEST,
DRM_ACCEL_THAMES can be enabled when IOMMU_SUPPORT is disabled, or under
COMPILE_TEST on architectures with GENERIC_ATOMIC64=3Dy or MMU=3Dn.

When IOMMU_SUPPORT=3Dn, drivers/iommu/iommu-pages.o is not built, causing
undefined references to iommu_alloc_pages_node_sz() and iommu_free_pages() =
in
drivers/iommu/io-pgtable-arm.c, and GENERIC_ATOMIC64=3Dy fails to compile d=
ue
to cmpxchg64_relaxed().

Should DRM_ACCEL_THAMES also depend on MMU and !GENERIC_ATOMIC64, and select
IOMMU_SUPPORT (similar to DRM_PANTHOR and DRM_PANFROST)?

>  	help
>  	  Choose this option if you have a Texas Instruments J722S and want to
>  	  use its C7x DSP cores as compute accelerators.
> diff --git a/drivers/accel/thames/thames_gem.c b/drivers/accel/thames/tha=
mes_gem.c
> new file mode 100644
> index 0000000000000..b98e0fe203b08
> --- /dev/null
> +++ b/drivers/accel/thames/thames_gem.c

[ ... ]

> +static struct drm_gem_dma_object *thames_gem_create(struct drm_device *d=
dev, size_t size)
> +{
> +	struct device *dev =3D drm_dev_dma_dev(ddev);
> +	struct thames_gem_object *bo;
> +	struct drm_gem_object *obj;
> +	size_t offset =3D 0;
> +	int ret;
> +
> +	size =3D PAGE_ALIGN(size);
> +
> +	bo =3D kzalloc_obj(*bo, GFP_KERNEL);
> +	if (!bo)
> +		return ERR_PTR(-ENOMEM);
> +
> +	obj =3D &bo->base.base;
> +	obj->funcs =3D &thames_gem_funcs;
> +	bo->base.map_noncoherent =3D true;
> +
> +	ret =3D drm_gem_object_init(ddev, obj, size);

[ ... ]

> +static struct drm_gem_dma_object *thames_context_alloc_user_pages(struct=
 thames_file_priv *priv,
> +								  u64 dsp_va, size_t size)
> +{
> +	int prot =3D IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_CACHE;
> +	struct drm_gem_dma_object *dma_obj;
> +	int ret;
> +
> +	dma_obj =3D thames_gem_create(&priv->tdev->ddev, size);
> +	if (IS_ERR(dma_obj))
> +		return dma_obj;
> +
> +	ret =3D thames_context_map(priv, dsp_va, prot, dma_obj->dma_addr, dma_o=
bj->base.size);
> +	if (ret) {
> +		drm_gem_object_put(&dma_obj->base);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return dma_obj;
> +}
> +
> +static int thames_context_map_user_pages(struct thames_file_priv *priv)
> +{
> +	struct drm_gem_dma_object *dma_obj;
> +
> +	dma_obj =3D thames_context_alloc_user_pages(priv, THAMES_USER_STACK_BAS=
E,
> +						  THAMES_USER_STACK_SIZE);
> +	if (IS_ERR(dma_obj))
> +		return PTR_ERR(dma_obj);
> +	priv->user_stack =3D dma_obj;
> +
> +	dma_obj =3D thames_context_alloc_user_pages(priv, THAMES_USER_SAVE_AREA=
_BASE,
> +						  THAMES_USER_SAVE_AREA_SIZE);
> +	if (IS_ERR(dma_obj))
> +		return PTR_ERR(dma_obj);
> +	priv->save_area =3D dma_obj;
> +
> +	return 0;
> +}

[Severity: High]
What happens on arm64 kernels configured with 16 KiB or 64 KiB pages when
thames_open() calls thames_context_create() -> thames_context_map_user_page=
s()?

In drivers/accel/thames/thames_abi.h, the user region addresses are fixed at
4 KiB granularity:

#define THAMES_USER_REGION_BASE		0x10000000000ull
#define THAMES_USER_REGION_SIZE		0x200000ull
#define THAMES_USER_SAVE_AREA_BASE	(THAMES_USER_REGION_BASE + 0x2000ull)
#define THAMES_USER_SAVE_AREA_SIZE	0x2000ull
#define THAMES_USER_STACK_BASE		(THAMES_USER_REGION_BASE + 0x5000ull)
#define THAMES_USER_STACK_SIZE		0x1000ull

In thames_gem_create(), size is rounded up to the host PAGE_SIZE via
PAGE_ALIGN(size) and stored in dma_obj->base.size. Then
thames_context_alloc_user_pages() maps dma_obj->base.size bytes into the DSP
page table rather than the requested size.

When PAGE_SIZE is 16 KiB (0x4000) or 64 KiB (0x10000),
thames_context_map_user_pages() first maps user_stack starting at
THAMES_USER_REGION_BASE + 0x5000, and then maps save_area for PAGE_SIZE byt=
es
starting at THAMES_USER_REGION_BASE + 0x2000 (covering at least +0x2000 to
+0x6000).

Won't the save_area mapping cover the guard page at +0x4000 and collide with
the already-mapped user_stack PTEs at +0x5000, triggering a WARN_ON in
arm_lpae_init_pte() and failing context creation with -EEXIST?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-thames-v3-=
0-3ab40aa17157@tomeuvizoso.net?part=3D6
