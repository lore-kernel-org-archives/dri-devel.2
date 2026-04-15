Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F30F41992
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3EB10E6C7;
	Wed, 15 Apr 2026 11:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l+EX8RPy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAB910E6C7
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:36:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 30E3860127;
 Wed, 15 Apr 2026 11:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBE4C19424;
 Wed, 15 Apr 2026 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776253007;
 bh=UsKEi7bahjdOzjEkGxVylrpzyQuqEnCOo5oyuVH1XOo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l+EX8RPyGK4XLywexLVSNPiOLi/MFLhVESaqsLtMiVfBZBmpWu5ErAsMknWPmRfn6
 S+DNxdwiNZ+ehvsPS9WYqTLxRJENlNIF2a/4rkTaQJP0Fcc4P/FKsXyqcnzv4nAoUf
 LNJbZw7ftq3zK6cOyog0J+3xwfHiiILh9sZirE14TrN8W8ZzdplYqdtgOe++q58fbQ
 5IT7eQWV4R7GoMXxYWoZzrEihqxcIPYWSqCvorbelsVvmfkG9m7/51qbWomDuvgcfk
 ELMQPH9jy0Bc0gF5kqO4dTMAiY0S/7eKaMFi8MZv3iifxs8QChgg/4NCGLqx5D0Mcm
 tQ0l4i0TdSSwg==
Message-ID: <964a5b13-0358-4ae9-baa9-8352e03f7a22@kernel.org>
Date: Wed, 15 Apr 2026 11:36:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] misc: fastrpc: Use context device bus for compute
 banks
To: ekansh.gupta@oss.qualcomm.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Srinivas Kandagatla <srini@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 4/14/26 4:31 PM, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Replace the platform driver approach for compute bank (CB) devices
> with the generic context_device_bus_type. Compute bank devices are
> synthetic IOMMU context banks, not real platform devices, so using
> the context device bus provides a more accurate representation in
> the device model.
> 
> Currently, fastrpc used of_platform_populate() to create platform
> devices for each "qcom,fastrpc-compute-cb" DT node, with a platform
> driver (fastrpc_cb_driver) to handle probe/remove. This approach
> had a race condition: device nodes were created before channel
> resources (like spin_lock) were initialized, and probe was async,
> so applications could open the device before sessions were available.
> 
> This patch addresses the race by manually creating and configuring
> CB devices synchronously during fastrpc_rpmsg_probe(), after all
> channel resources are initialized. The approach follows the pattern
> used in host1x_memory_context_list_init().
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/misc/Kconfig   |   1 +
>  drivers/misc/fastrpc.c | 180 ++++++++++++++++++++++++++++++++++---------------
>  2 files changed, 125 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 00683bf06258..b501462a4548 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -304,6 +304,7 @@ config QCOM_FASTRPC
>  	depends on RPMSG
>  	select DMA_SHARED_BUFFER
>  	select QCOM_SCM
> +	select CONTEXT_DEVICE_BUS
>  	help
>  	  Provides a communication mechanism that allows for clients to
>  	  make remote method invocations across processor boundary to
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a..f66fd3eea5fa 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -13,9 +13,9 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of.h>
> -#include <linux/platform_device.h>
> +#include <linux/of_device.h>
>  #include <linux/sort.h>
> -#include <linux/of_platform.h>
> +#include <linux/context_bus.h>
>  #include <linux/rpmsg.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> @@ -250,6 +250,18 @@ struct fastrpc_invoke_ctx {
>  	struct fastrpc_channel_ctx *cctx;
>  };
>  
> +/**
> + * struct fastrpc_cb_device - Compute bank device wrapper
> + * @dev: Device structure
> + * @sess: Back-pointer to the session context
> + */
> +struct fastrpc_cb_device {
> +	struct device dev;
> +	struct fastrpc_session_ctx *sess;
> +};
As part of this migration are we saying that driver and device model
should be done in the consumer driver?

May be the right question is why can not we add other bus types into
iommu supported buses.

There has been some discussion on this in the past
https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg22139.html


This is one of the restrictions that is forcing the fake the context
devices as platform devices.

for me this looks like half baked solution and very much specific to
deal with the iommu driver situation

--srini
> +
> +#define to_fastrpc_cb_device(d) container_of(d, struct fastrpc_cb_device, dev)
> +
>  struct fastrpc_session_ctx {
>  	struct device *dev;
>  	int sid;
> @@ -2190,92 +2202,156 @@ static const struct file_operations fastrpc_fops = {
>  	.compat_ioctl = fastrpc_device_ioctl,
>  };
>  
> -static int fastrpc_cb_probe(struct platform_device *pdev)
> +static void fastrpc_cb_dev_release(struct device *dev)
> +{
> +	struct fastrpc_cb_device *cb_dev = to_fastrpc_cb_device(dev);
> +
> +	of_node_put(dev->of_node);
> +	kfree(cb_dev);
> +}
> +
> +static int fastrpc_create_cb_device(struct fastrpc_channel_ctx *cctx,
> +				    struct device *parent,
> +				    struct device_node *cb_node)
>  {
> -	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_session_ctx *sess;
> -	struct device *dev = &pdev->dev;
> -	int i, sessions = 0;
> +	struct fastrpc_cb_device *cb_dev;
>  	unsigned long flags;
> -	int rc;
> -	u32 dma_bits;
> -
> -	cctx = dev_get_drvdata(dev->parent);
> -	if (!cctx)
> -		return -EINVAL;
> +	int i, sessions = 0, rc;
> +	u32 dma_bits, sid = 0;
>  
> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
> +	/* Read SID early so it can be used in the device name */
> +	of_property_read_u32(cb_node, "reg", &sid);
> +	of_property_read_u32(cb_node, "qcom,nsessions", &sessions);
>  
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
> -		dev_err(&pdev->dev, "too many sessions\n");
> +		dev_err(parent, "too many sessions\n");
>  		spin_unlock_irqrestore(&cctx->lock, flags);
>  		return -ENOSPC;
>  	}
>  	dma_bits = cctx->soc_data->dma_addr_bits_default;
> +	if (cctx->domain_id == CDSP_DOMAIN_ID)
> +		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> +
>  	sess = &cctx->session[cctx->sesscount++];
>  	sess->used = false;
>  	sess->valid = true;
> -	sess->dev = dev;
> -	dev_set_drvdata(dev, sess);
> +	sess->sid = sid;
> +	spin_unlock_irqrestore(&cctx->lock, flags);
>  
> -	if (cctx->domain_id == CDSP_DOMAIN_ID)
> -		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> +	cb_dev = kzalloc_obj(*cb_dev);
> +	if (!cb_dev)
> +		return -ENOMEM;
>  
> -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
> -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> +	cb_dev->sess = sess;
>  
> -	if (sessions > 0) {
> -		struct fastrpc_session_ctx *dup_sess;
> +	device_initialize(&cb_dev->dev);
> +	cb_dev->dev.parent = parent;
> +	cb_dev->dev.bus = &context_device_bus_type;
> +	cb_dev->dev.release = fastrpc_cb_dev_release;
> +	cb_dev->dev.of_node = of_node_get(cb_node);
> +	cb_dev->dev.dma_mask = &cb_dev->dev.coherent_dma_mask;
> +	cb_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	dev_set_name(&cb_dev->dev, "%s:compute-cb@%u", dev_name(parent), sid);
>  
> +	rc = device_add(&cb_dev->dev);
> +	if (rc) {
> +		dev_err(parent, "failed to add CB device: %d\n", rc);
> +		goto err_put;
> +	}
> +
> +	rc = of_dma_configure(&cb_dev->dev, cb_node, true);
> +	if (rc) {
> +		dev_err(parent, "of_dma_configure failed for CB device: %d\n", rc);
> +		goto err_del;
> +	}
> +
> +	rc = dma_set_mask(&cb_dev->dev, DMA_BIT_MASK(dma_bits));
> +	if (rc) {
> +		dev_err(parent, "%u-bit DMA enable failed\n", dma_bits);
> +		goto err_del;
> +	}
> +
> +	sess->dev = &cb_dev->dev;
> +
> +	if (sessions > 0) {
> +		spin_lock_irqsave(&cctx->lock, flags);
>  		for (i = 1; i < sessions; i++) {
> +			struct fastrpc_session_ctx *dup_sess;
> +
>  			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
>  				break;
>  			dup_sess = &cctx->session[cctx->sesscount++];
>  			memcpy(dup_sess, sess, sizeof(*dup_sess));
>  		}
> -	}
> -	spin_unlock_irqrestore(&cctx->lock, flags);
> -	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
> -	if (rc) {
> -		dev_err(dev, "%u-bit DMA enable failed\n", dma_bits);
> -		return rc;
> +		spin_unlock_irqrestore(&cctx->lock, flags);
>  	}
>  
>  	return 0;
> +
> +err_del:
> +	device_del(&cb_dev->dev);
> +err_put:
> +	of_node_put(cb_dev->dev.of_node);
> +	put_device(&cb_dev->dev);
> +	return rc;
>  }
>  
> -static void fastrpc_cb_remove(struct platform_device *pdev)
> +static void fastrpc_depopulate_cb_devices(struct fastrpc_channel_ctx *cctx)
>  {
> -	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
> -	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
>  	unsigned long flags;
> -	int i;
> +	int i, j;
>  
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
> -		if (cctx->session[i].sid == sess->sid) {
> +		if (cctx->session[i].valid) {
>  			cctx->session[i].valid = false;
>  			cctx->sesscount--;
>  		}
>  	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
> +
> +	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
> +		struct device *dev = cctx->session[i].dev;
> +
> +		if (!dev)
> +			continue;
> +
> +		/* Unregister the device once */
> +		device_unregister(dev);
> +
> +		/* Clear this dev pointer from all sessions that share it */
> +		for (j = i; j < FASTRPC_MAX_SESSIONS; j++) {
> +			if (cctx->session[j].dev == dev)
> +				cctx->session[j].dev = NULL;
> +		}
> +	}
>  }
>  
> -static const struct of_device_id fastrpc_match_table[] = {
> -	{ .compatible = "qcom,fastrpc-compute-cb", },
> -	{}
> -};
> +static int fastrpc_populate_cb_devices(struct fastrpc_channel_ctx *cctx,
> +					struct device *parent,
> +					struct device_node *parent_node)
> +{
> +	struct device_node *child;
> +	int ret = 0;
>  
> -static struct platform_driver fastrpc_cb_driver = {
> -	.probe = fastrpc_cb_probe,
> -	.remove = fastrpc_cb_remove,
> -	.driver = {
> -		.name = "qcom,fastrpc-cb",
> -		.of_match_table = fastrpc_match_table,
> -		.suppress_bind_attrs = true,
> -	},
> -};
> +	for_each_child_of_node(parent_node, child) {
> +		if (!of_device_is_compatible(child, "qcom,fastrpc-compute-cb"))
> +			continue;
> +
> +		ret = fastrpc_create_cb_device(cctx, parent, child);
> +		if (ret) {
> +			dev_err(parent, "failed to create CB device for %s: %d\n",
> +				child->name, ret);
> +			of_node_put(child);
> +			fastrpc_depopulate_cb_devices(cctx);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
>  
>  static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
>  				   bool is_secured, const char *domain)
> @@ -2441,7 +2517,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	data->domain_id = domain_id;
>  	data->rpdev = rpdev;
>  
> -	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	err = fastrpc_populate_cb_devices(data, rdev, rdev->of_node);
>  	if (err)
>  		goto err_deregister_fdev;
>  
> @@ -2496,7 +2572,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	if (cctx->remote_heap)
>  		fastrpc_buf_free(cctx->remote_heap);
>  
> -	of_platform_depopulate(&rpdev->dev);
> +	fastrpc_depopulate_cb_devices(cctx);
>  
>  	fastrpc_channel_ctx_put(cctx);
>  }
> @@ -2558,16 +2634,9 @@ static int fastrpc_init(void)
>  {
>  	int ret;
>  
> -	ret = platform_driver_register(&fastrpc_cb_driver);
> -	if (ret < 0) {
> -		pr_err("fastrpc: failed to register cb driver\n");
> -		return ret;
> -	}
> -
>  	ret = register_rpmsg_driver(&fastrpc_driver);
>  	if (ret < 0) {
>  		pr_err("fastrpc: failed to register rpmsg driver\n");
> -		platform_driver_unregister(&fastrpc_cb_driver);
>  		return ret;
>  	}
>  
> @@ -2577,7 +2646,6 @@ module_init(fastrpc_init);
>  
>  static void fastrpc_exit(void)
>  {
> -	platform_driver_unregister(&fastrpc_cb_driver);
>  	unregister_rpmsg_driver(&fastrpc_driver);
>  }
>  module_exit(fastrpc_exit);
> 

