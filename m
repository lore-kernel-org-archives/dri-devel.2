Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C9606A335
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=g00dkbCd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9FE10FCDE;
	Wed,  4 Nov 2026 16:12:33 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08B510FCDE
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793808744; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E/62NSDe0vaSbCCbvaPH/G+x6dAmPjbRWxgYGA2c3+W5vcAq31UDEHDbxGjRfh0O8Au9haU82JJ3mfz/qZttVTrr2rwBFstZpO+tDTA+z25kFRAlZH41eCjJgIG+39cA4+823PrrVYI4dYGEXeGLDMGaUEW6btE/NvfCRNr8ep8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793808744;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bveTO0+StKxpuK35+DwPLa38Tc+AfBhkX4WsslUA1n0=; 
 b=fUDSEeQHqgnxpJZwm7KTwJIjtduDprKg++gxdGUw9BOm+hj3ndu9NceClATpQIjD3HRFN1varrfMAqCs3ohUuaUaJexbpTozVNosucqJZYwbpRm3E/ScC2W9/uCmwEOiROnUGYWQi0FWUzn8pcRHzLbMoA7Fzkoq2MomaO6Qp94=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=g00dkbCdKCVijxi0aOSUvqxlSJwtp4GMt050SfbyRBrL8pkzzsz6v2HpHNLLMa+DU1BQI6h2VCnKf8HmgNHU7o6FqQ+W2OcncjzDFCBIEbyQxrdJ/edqvQgGROOLF5S2mXPHayDADShRJvtUM45TymOtm0FZt6a+jEyjyMKSb8g=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=bveTO0+StKxpuK35+DwPLa38Tc+AfBhkX4WsslUA1n0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793808743618272.38594916343584; 
 Wed, 4 Nov 2026 08:12:23 -0800 (PST)
Date: Wed, 4 Nov 2026 16:12:19 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: =?utf-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/panfrost: Enable the GPU timestamp counter on
 MT8188
Message-ID: <autXXJFdiSTpir7K@sobremesa>
References: <20261003200132.866240-1-michal@nozomi.space>
 <20261003200132.866240-3-michal@nozomi.space>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003200132.866240-3-michal@nozomi.space>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.791.62
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michał,

On 03.10.2026 22:01, Michał Kopeć wrote:
> On MediaTek SoCs the GPU timestamp counter is fed by the SoC system timer
> only once the TOP_TSVALUEB enable bits are set in the MFGCFG block. The
> setting is lost whenever the GPU power domain is turned off.
> 
> Without it, GPU_TIMESTAMP reads zero, so the SYSTEM_TIMESTAMP query and
> timestamps written by jobs are always zero, which breaks timestamp
> queries in userspace drivers.
> 
> Look up the MFGCFG block from the mediatek,mfgcfg phandle and set the
> bits from the vendor quirk hook, which runs on every power-up, as the
> downstream kbase driver does. Without the phandle nothing changes.

To me this looks like the right location for the fix inside the quirk function
further below is somewhere in MT8188's device RPM handlers themselves, rather
the Panfrost driver. RPM core keeps a tree of runtime dependencies, so SoC
resume handlers would always be run before those of the child nodes (Panfrost
being among them). 

> Signed-off-by: Michał Kopeć <michal@nozomi.space>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 39 ++++++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.h    |  1 +
>  4 files changed, 42 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 1fe1554f2652b..0a73939a023c3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -134,6 +134,7 @@ struct panfrost_device {
>  	int mmu_irq;
>  
>  	void __iomem *iomem;
> +	struct regmap *mtk_mfgcfg;
>  	struct clk *clock;
>  	struct clk *bus_clock;
>  	struct clk *bus_ace_clock;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 70c05210ea846..e811652e2384d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1133,6 +1133,7 @@ static const struct panfrost_compatible mediatek_mt8188_data = {
>  	.pm_domain_names = mediatek_pm_domains,
>  	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
>  	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
> +	.vendor_quirk = panfrost_gpu_mt8188_quirk,
>  };
>  
>  static const struct panfrost_compatible mediatek_mt8192_data = {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 29ac0dce5ff89..971abc9cc222c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -9,8 +9,11 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  
>  #include <drm/drm_print.h>
>  
> @@ -114,6 +117,40 @@ void panfrost_gpu_amlogic_quirk(struct panfrost_device *pfdev)
>  	gpu_write(pfdev, GPU_PWR_OVERRIDE1, 0xfff | (0x20 << 16));
>  }
>  
> +#define MTK_MFG_TIMESTAMP			0x130
> +#define   MTK_MFG_TIMESTAMP_TOP_TSVALUEB_EN	0x3
> +
> +void panfrost_gpu_mt8188_quirk(struct panfrost_device *pfdev)
> +{
> +	/*
> +	 * The GPU timestamp counter only counts once MFGCFG routes the SoC
> +	 * system timer to it. The setting is lost whenever the GPU power
> +	 * domain is turned off, so it has to be restored on every power-up.
> +	 */
> +	if (pfdev->mtk_mfgcfg)
> +		regmap_write(pfdev->mtk_mfgcfg, MTK_MFG_TIMESTAMP,
> +			     MTK_MFG_TIMESTAMP_TOP_TSVALUEB_EN);
> +}

Here you cast an SoC issue as a GPU quirk, which is a misrepresentation of the problem.
GPU quirks are about working around GPU-model specific issues by poking GPU registers
themselves. 

> +static void panfrost_gpu_get_mtk_mfgcfg(struct panfrost_device *pfdev)
> +{
> +	struct device_node *np;
> +	struct regmap *regmap;
> +
> +	np = of_parse_phandle(pfdev->base.dev->of_node, "mediatek,mfgcfg", 0);
> +	if (!np)
> +		return;
> +
> +	regmap = device_node_to_regmap(np);
> +	of_node_put(np);
> +	if (IS_ERR(regmap)) {
> +		dev_warn(pfdev->base.dev, "failed to get MFGCFG: %pe\n", regmap);
> +		return;
> +	}
> +
> +	pfdev->mtk_mfgcfg = regmap;
> +}
> +
>  static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
>  {
>  	u32 quirks = 0;
> @@ -519,6 +556,8 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
>  {
>  	int err;
>  
> +	panfrost_gpu_get_mtk_mfgcfg(pfdev);

We cannot add SoC-specific workarounds in generic driver code. There has to be another way.

>  	err = panfrost_gpu_soft_reset(pfdev);
>  	if (err)
>  		return err;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> index b4fef11211d5f..2b974576b96e9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> @@ -23,5 +23,6 @@ unsigned long long panfrost_cycle_counter_read(struct panfrost_device *pfdev);
>  unsigned long long panfrost_timestamp_read(struct panfrost_device *pfdev);
>  
>  void panfrost_gpu_amlogic_quirk(struct panfrost_device *pfdev);
> +void panfrost_gpu_mt8188_quirk(struct panfrost_device *pfdev);
>  
>  #endif
> -- 
> 2.55.0

Adrian Larumbe
