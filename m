Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C3CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5744F10E580;
	Fri,  2 Oct 2026 12:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="a7bm9Zut";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28FF10E587
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=5R72zJezzcO4+Kz+L42SpTWw5vtZsB6tAUvnYi0Cegg=; b=a7bm9ZutbGbQ46yvCLz5Gj3wYC
 dQHAqBA9vc1GbHKJz8s9pXrQ1DXH7n9tK7GSwrWcde7Gr+8NCaz+CSq+wTJLCqFQexuTuWv1inCUL
 4aRk6IKJ3kEprEi2zNG2j8za3ULyRAI+6DpOFxz99PoS6tYiT7gBCFDqKqP8Rt8przs+DbHQzOoYy
 M9HP8reuxLUBZJVwSSXodJJffQwNbKqIX8pG6DHnJSrxw5tXDYD0RLAQ77UYfQ55kdviBzfN255TU
 Q756nT5C7s6rDWsmiSyLJMD2luGx9lMBWcW867So69twFtJGIXguYKmTWGctOC2l7m3dp1rLSrFyO
 8URIWVSw==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xCc1m-00AabO-83; Fri, 02 Oct 2026 14:06:14 +0200
Message-ID: <61833dde-ad6a-4b1a-8540-6cc0db80bb3d@igalia.com>
Date: Fri, 2 Oct 2026 09:06:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vc4: Set DRM DMA device directly from HVS and V3D
To: Daniel Drake <dan@reactivated.net>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260928-drm-dma-device-2-v2-1-8e8b6288cd31@reactivated.net>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260928-drm-dma-device-2-v2-1-8e8b6288cd31@reactivated.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Daniel,

LGTM, just some nits below:

On 28/09/26 17:16, Daniel Drake wrote:
> vc4 uses of_dma_configure() during bind to set the DMA configuration of
> the drm device by borrowing the configuration of one of its component
> devices.
> 
> This violates driver model expectations that IOMMU probing and domain
> attachment occur before driver binding - see commit bcb81ac6ae3c ("iommu:
> Get DT/ACPI parsing into the proper probe path").
> 
> With the introduction of the bcm2712-iommu driver behind the vc4 hvs
> device, a warning is triggered:
> 
>      vc4-drm gpu: late IOMMU probe at driver bind, something fishy here!
> 
> Instead of configuring the virtual aggregate device, adopt the pattern
> used by sun4i/sun8i/exynos where candidate DMA-capable hardware components
> register themselves as the device to use for DRM allocations via
> drm_dev_set_dma_dev(), provided a DMA device has not already been
> assigned.
> 
> HVS will typically bind first and claim the DMA device. The gen6 36-bit
> DMA mask configuration was moved into vc4_hvs_bind() accordingly. For
> older generations, vc4's v3d component continues to be available as a
> fallback, and the default platform bus 32-bit DMA mask is retained.
> 
> Fixes: da8e393e23ef ("drm/vc4: drv: Adopt the dma configuration from the HVS or V3D component")
> Signed-off-by: Daniel Drake <dan@reactivated.net>
> ---
> Changes in v2:
> - Fix vc4_bo_purge() to also use the selected DMA device for freeing
>    allocations
> - Link to v1: https://lore.kernel.org/r/20260927-drm-dma-device-2-v1-1-3230afcdc851@reactivated.net
> ---
>   drivers/gpu/drm/vc4/vc4_bo.c  |  3 ++-
>   drivers/gpu/drm/vc4/vc4_drv.c | 27 ---------------------------
>   drivers/gpu/drm/vc4/vc4_hvs.c | 14 ++++++++++++++
>   drivers/gpu/drm/vc4/vc4_v3d.c |  8 ++++++++
>   4 files changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 49ea2ed0996b..320c5a0c71ed 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -303,7 +303,8 @@ static void vc4_bo_purge(struct drm_gem_object *obj)
>   
>   	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
>   
> -	dma_free_wc(dev->dev, obj->size, bo->base.vaddr, bo->base.dma_addr);
> +	dma_free_wc(drm_dev_dma_dev(dev), obj->size, bo->base.vaddr,
> +		    bo->base.dma_addr);
>   	bo->base.vaddr = NULL;
>   	bo->madv = __VC4_MADV_PURGED;
>   }
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 616caf9d9915..62f1a5731e33 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c

Could you clean up the headers of vc4_drv.c? I believe of_device.h and
dma-mapping.h might not be needed anymore.

> @@ -273,16 +273,6 @@ static void vc4_component_unbind_all(void *ptr)
>   	component_unbind_all(vc4->dev, &vc4->base);
>   }
>   
> -static const struct of_device_id vc4_dma_range_matches[] = {
> -	{ .compatible = "brcm,bcm2711-hvs" },
> -	{ .compatible = "brcm,bcm2712-hvs" },
> -	{ .compatible = "brcm,bcm2835-hvs" },
> -	{ .compatible = "brcm,bcm2835-v3d" },
> -	{ .compatible = "brcm,cygnus-v3d" },
> -	{ .compatible = "brcm,vc4-v3d" },
> -	{}
> -};
> -
>   static int vc4_drm_bind(struct device *dev)
>   {
>   	struct platform_device *pdev = to_platform_device(dev);
> @@ -295,8 +285,6 @@ static int vc4_drm_bind(struct device *dev)
>   	enum vc4_gen gen;
>   	int ret = 0;
>   
> -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> -
>   	gen = (enum vc4_gen)of_device_get_match_data(dev);
>   
>   	if (gen > VC4_GEN_4)
> @@ -304,21 +292,6 @@ static int vc4_drm_bind(struct device *dev)
>   	else
>   		driver = &vc4_drm_driver;
>   
> -	if (gen >= VC4_GEN_6_C)
> -		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> -	else
> -		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> -
> -	node = of_find_matching_node_and_match(NULL, vc4_dma_range_matches,
> -					       NULL);
> -	if (node) {
> -		ret = of_dma_configure(dev, node, true);
> -		of_node_put(node);
> -
> -		if (ret)
> -			return ret;
> -	}
> -
>   	vc4 = devm_drm_dev_alloc(dev, driver, struct vc4_dev, base);
>   	if (IS_ERR(vc4))
>   		return PTR_ERR(vc4);
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index e715147d091c..305770c87dcf 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -22,6 +22,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/clk.h>
>   #include <linux/component.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/platform_device.h>
>   
>   #include <drm/drm_atomic_helper.h>
> @@ -1662,6 +1663,19 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>   		hvs->regset.nregs = ARRAY_SIZE(vc4_hvs_regs);
>   	}
>   
> +	if (vc4->gen >= VC4_GEN_6_C) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Use the HVS as the DRM device's DMA controller for buffer
> +	 * allocations if one has not already been configured.
> +	 */

I have the impression that this comment is not needed. v3d's comment
adds an interesting information, but this one seems redudant.

> +	if (drm_dev_dma_dev(drm) == drm->dev)
> +		drm_dev_set_dma_dev(drm, dev);
> +
>   	if (vc4->gen >= VC4_GEN_5) {
>   		struct rpi_firmware *firmware;
>   		struct device_node *node;
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index f32410420d3e..1f76d4850122 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -10,6 +10,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   
> +#include <drm/drm_drv.h>

I believe this include is not needed.

Best regards,
- Maíra
