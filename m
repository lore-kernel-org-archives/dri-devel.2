Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89C2CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 18:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227D810E070;
	Tue,  6 Oct 2026 18:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MGpurnpJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380CE10E070
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=PBhPGHM3H5YMCfWnb8Woct2TK8TsNUryiGGa4HNcke8=; b=MGpurnpJfTINoiGOqysYeO3pMC
 41zjdsvjaVfZI5RRCloPL+BW/H+HopUPQZy4cwmQ9ZoFztC3hYQkXpOKdDtB+y9nxA4O7ym6MXaEg
 Nxm4hC8TqED0cz7SCYV7RtJIzMcwQdGcjxjhd9JRyT1iISryZH8tf9ACa3TMP00SDPAuvTZU0WgPO
 KOIAGHTgjn+GZnV2FhLSdWKwNyfBhZPcLIC3WWPuauxq2VqWGEexnlaRIVSdnncKQBEP2uk1okB1c
 9IjqoXJar07r1mY9wSkzo99ijrUJNS/wytNJP2IW34d+RmrzaMZH4iq25caZBNH+XDHOonj/HvKId
 1UWUUnCw==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xEACY-00DZne-5z; Tue, 06 Oct 2026 20:47:46 +0200
Message-ID: <0bb880c5-2f40-4d63-bc4c-0e4a1c5b4fa6@igalia.com>
Date: Tue, 6 Oct 2026 15:47:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm: use dmaengine API instead of raw function
 pointers
To: Frank.Li@oss.nxp.com, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 "open list:DRM DRIVERS FOR TI OMAP" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
References: <20261002200620.230735-1-Frank.Li@oss.nxp.com>
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
In-Reply-To: <20261002200620.230735-1-Frank.Li@oss.nxp.com>
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

Hi Frank,

On 02/10/26 17:06, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace direct calls through dma_async_tx_descriptor and
> dma_device function pointers with the proper dmaengine API
> wrappers in vc4_dsi and omap_dmm_tiler.
> 
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

For VC4:

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra
> ---
>   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 2 +-
>   drivers/gpu/drm/vc4/vc4_dsi.c            | 8 +++-----
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> index a2c702b831a7c..c5dd350f937f4 100644
> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> @@ -87,7 +87,7 @@ static int dmm_dma_copy(struct dmm *dmm, dma_addr_t src, dma_addr_t dst)
>   		return -EIO;
>   	}
>   
> -	cookie = tx->tx_submit(tx);
> +	cookie = dmaengine_submit(tx);
>   	if (dma_submit_error(cookie)) {
>   		dev_err(dmm->dev, "Failed to do DMA tx_submit\n");
>   		return -EIO;
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 0148f2befed14..b1626c2d3a582 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -628,16 +628,14 @@ dsi_dma_workaround_write(struct vc4_dsi *dsi, u32 offset, u32 val)
>   
>   	*dsi->reg_dma_mem = val;
>   
> -	tx = chan->device->device_prep_dma_memcpy(chan,
> -						  dsi->reg_paddr + offset,
> -						  dsi->reg_dma_paddr,
> -						  4, 0);
> +	tx = dmaengine_prep_dma_memcpy(chan, dsi->reg_paddr + offset,
> +				       dsi->reg_dma_paddr, 4, 0);
>   	if (!tx) {
>   		drm_err(drm, "Failed to set up DMA register write\n");
>   		return;
>   	}
>   
> -	cookie = tx->tx_submit(tx);
> +	cookie = dmaengine_submit(tx);
>   	ret = dma_submit_error(cookie);
>   	if (ret) {
>   		drm_err(drm, "Failed to submit DMA: %d\n", ret);

