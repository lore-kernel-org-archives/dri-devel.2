Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C826606A321
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Bn1maMdu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E12112740;
	Fri, 30 Oct 2026 10:37:02 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DB011272E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:36:55 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261030103654euoutp0149210b3695792ed7bcbe8dd4246e276d~jSFbSUIFx2141521415euoutp01c
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:36:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261030103654euoutp0149210b3695792ed7bcbe8dd4246e276d~jSFbSUIFx2141521415euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793356614;
 bh=oXQ15hDbnS1B2Y9Ac6zuPUxaceab5plrwxGQ/lap8W4=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=Bn1maMduqupHB2mk79itTPg2YYb2s2eoTiTiCAQr3tKsoCqkIdjJg9ZyToXDicMeu
 QC/eykVusT+mvuqbMsJw99fOxSE4H3ZMEbhvSQNamO2BFBa89xl0LTJMLRvfqWADIe
 2qDnY/yqLt8qf51Cl8m0sEfa5siJiL4tsWYBI/pg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261030103653eucas1p1e35145674aa26e829f4cde451eda2411~jSFa8BzoE1749317493eucas1p10;
 Fri, 30 Oct 2026 10:36:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261030103652eusmtip25965ad5bbe769c2f2f82e49aa71e8d98~jSFZq8wI72310123101eusmtip2j;
 Fri, 30 Oct 2026 10:36:52 +0000 (GMT)
Message-ID: <6fb3327c-766c-433c-b49d-dc62470d7102@samsung.com>
Date: Fri, 30 Oct 2026 11:36:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 00/10] Make the 32-bit ARM DMA API work with normal
 IOMMU DMA default domains (+ Tegra PoC)
To: Mikko Perttunen <mperttunen@nvidia.com>, Robin Murphy
 <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Stuebner
 <heiko@sntech.de>, Thierry Reding <thierry.reding@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Hunter
 <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>, Krzysztof
 Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Yong Wu
 <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
 Clark <robin.clark@oss.qualcomm.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261030103653eucas1p1e35145674aa26e829f4cde451eda2411
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026092047eucas1p2686ac1a0ce893a16711cf7a137d081ce
X-EPHeader: CA
X-CMS-RootMailID: 20261026092047eucas1p2686ac1a0ce893a16711cf7a137d081ce
References: <CGME20261026092047eucas1p2686ac1a0ce893a16711cf7a137d081ce@eucas1p2.samsung.com>
 <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26.10.2026 10:19, Mikko Perttunen wrote:
> Depending on the probe ordering, TegraDRM does not currently probe on
> kernels with CONFIG_ARM_DMA_USE_IOMMU enabled, such as with
> multi_v7_defconfig. The Tegra SMMU puts several display and 2D/3D
> clients into one IOMMU group, and the legacy 32-bit ARM DMA API path
> creates one UNMANAGED domain per device and attaches it with
> iommu_attach_device(). That only works for one device per group, so
> every client after the first fails to attach,
> iommu_device_use_default_domain() rejects the group with -EBUSY, and the
> driver goes down with it. tegra_defconfig is currently working by virtue
> of not enabling CONFIG_ARM_DMA_USE_IOMMU.
>
> Robin suggested [1] that instead of teaching the legacy path about
> groups, we should explore modernizing the 32-bit ARM DMA code a bit by
> making it use domain cookies and have the core code own the domains, as
> is the case on other architectures. Still, ARM's own DMA code is kept to
> support existing drivers and APIs that expect it, and because dma-iommu
> is considered too big and unnecessary for 32-bit ARM.
>
> The series is in four parts:
>
> - Patches 1-2 are preparation in the IOMMU core:
>   1. Add iommu_teardown_dma_ops, counterpart to iommu_setup_dma_ops.
>   2. Add cookie type for ARM's DMA domains.
> - Patches 3-6 implement the DMA API side on 32-bit ARM:
>   3. Split up mapping alloc and init (bitmap alloc) code to separate
>      functions.
>   4. Implement parallel dma_ops / cookie APIs on ARM side.
>   5. Avoid domain allocation when IOMMU core does it.
>   6. Check upper DMA range limit during IOVA allocation.
> - Patch 7 removes the forced IDENTITY default domain in core IOMMU
>   code and adds explicit IDENTITY defaults to a few individual IOMMU
>   drivers.
> - Patches 8-10 convert Tegra:
>   8. Fixes device parameter in calls to dma_get_sgtable.
>   9. Allows deferring translation enable until driver handshake for
>      selected devices.
>   10. Switches to DMA default domain for selected Tegra devices.
>
> This moves 32-bit ARM devices from the unmanaged IOMMU DMA domain to the
> core-owned default DMA domain except for mtk_iommu_v1, ipmmu-vmsa,
> omap-iommu, and msm_iommu. (tegra-smmu also stays on the legacy path
> until the last patch in the series.) See commit 7 for further
> information. Existing drivers are intended to continue working without
> changes.
>
> Patches 8-10 are provided for demonstration; we can deal with them 
> separately if the rest of the series is accepted.
>
> Patches 1,2,3,6 are applicable independently.
> Patches 4,5 depend on the previous patches.
> Patch 7 requires the prior patches to be in place.
>
> Patches 1-7 only touch drivers/iommu/ and arch/arm/mm/ and associated 
> headers.


I've tested this patchset on ARM 32bit based Exynos boards and it works
fine, although I get the following warnings during boot:

platform 13400000.codec: Adding to iommu group 0
iommu: Failed to allocate default IOMMU domain of type 0 for group (null) - Falling back to IOMMU_DOMAIN_DMA
platform 11840000.jpeg-codec: Adding to iommu group 1
iommu: Failed to allocate default IOMMU domain of type 0 for group (null) - Falling back to IOMMU_DOMAIN_DMA

This looks like an issue in iommu core, which doesn't expect devices with
iommu to come up so early.


LLM proposes the following fix for it:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 197a8f70c6de..612933306684 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -225,10 +225,8 @@ static const char *iommu_domain_type_str(unsigned int t)
        }
 }

-static int __init iommu_subsys_init(void)
+static void __init iommu_init_def_domain_type(void)
 {
-       struct notifier_block *nb;
-
        if (!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API)) {
                if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
                        iommu_set_default_passthrough(false);
@@ -254,6 +252,11 @@ static int __init iommu_subsys_init(void)
                        iommu_dma_strict ? "strict" : "lazy",
                        (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
                                " (set via kernel command line)" : "");
+}
+
+static int __init iommu_subsys_init(void)
+{
+       struct notifier_block *nb;

        nb = kzalloc_objs(*nb, ARRAY_SIZE(iommu_buses));
        if (!nb)
@@ -2939,6 +2942,12 @@ EXPORT_SYMBOL_GPL(report_iommu_fault);

 static int __init iommu_init(void)
 {
+       /*
+        * Select the default domain type before any IOMMU driver can register
+        * and create groups, which may happen before subsys_initcall.
+        */
+       iommu_init_def_domain_type();
+
        iommu_group_kset = kset_create_and_add("iommu_groups",
                                               NULL, kernel_kobj);
        BUG_ON(!iommu_group_kset);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

