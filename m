Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4346DCD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 17:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E1B10E4AC;
	Thu, 21 May 2026 17:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="dR0O6l5Q";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44CE10E4AC
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 17:54:22 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8b1f2b7f1bcso96683586d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1779386062; x=1779990862; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EC6XWlOYSm7qj75HyHmp0T60BsFS50VL7KHJNUynWLU=;
 b=dR0O6l5QV7X2McFE/drIVZbf5VjYDDxca0eyTI8WGxS+YBqA5XMfjQJfGFgWYdCfMu
 50LaKYaqeOOOnynw7vQZcCX5XnMUhjFlTo9GHe0OmdhIjWT5wQcA/OYtMdqsOToFjs/F
 MN3xF8MIhHyqJPaGURELZ2oQIwsQrp0Jn/SDrKx9KkV+2JcFqilj4XSTD4ZE1U9MyG87
 7b7t+rU9cS00KPE1Hb0pDF4L+dxodywvr+RArpvGsYGBKvTjrdPEwVB05EAj6RT+i68/
 NzPD+DQSVPMn5BlBKLVx1/dd8tAWdP6nTZhgaliacNGKp//kd19cOYQ63jlRNI8eMpKq
 naFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386062; x=1779990862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EC6XWlOYSm7qj75HyHmp0T60BsFS50VL7KHJNUynWLU=;
 b=FINVkwJifZK7JgQscT4kHZar+7UBzdMpmKAH41gbNWdZO4lA276wDADY7j1fNUXaFV
 j/aerRwjxNEWbjP2oXiorfS4L7QsbGWdHt7j37vIhrErk39pi+LEk8sg79cwkW/1zeqW
 PNLpkIZPUuP44fIShObko93YAn0a4KKl5mUW4uPlQztuBxxjohklMJLEhlYpbGxI9Yxa
 QjCpL5VVBheMlhD8mH7n4LhbFVcYom7lIZK/+JGK6ijbI6LVKq4b4PIa7SsWvUpg2tBi
 +BUpMg8Ke3D8xtVBxIkpm09GCq1IJfntvxGtd8QsJY2820V1inJXOVqHhN3JLKrlZMwZ
 sjKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PeC46QYoSlPdqz+ee2TptMYZw5bDSt0eNC/1fiVkOPQ7wF8cqiLWgTeZz2mxptuPYlPtxovNiFKQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxU6EhQM1w1sMDH8BzxopQu6EmXwFEHK34b/M6tIZeWwO0EY4Yq
 AFDPE9L7o3zMc9tA3GdS8leULmEHR6s7M0oO+PoeaBy1SYsRr6FgGk69J6mAK5WVop8=
X-Gm-Gg: Acq92OHeDoSq48cCDWDle8SgmiI0C+KYRJz1KGP8ngCj1ckKOszFG9HgigPkAJ6GMDe
 beRgIBtylP8GkLcetDx7GDh0ZTPYQNPHx1x36819Iq7D3xxj22NMa09JpIy0kc/2ps7GjWzX9ZF
 4GUk3OC25YKMvOgk8w8RjQkUJ3fFHHgRijnoUy9V1kSFCCtcWW+L770qnB3U1QQ8YAqd8PJUiI4
 CTnp/KTt5FStClktdSgaKUnbWnnTm0hO0KyoN+Y2M3dvxd8iWX01vieee2d9cuW4Paa0LZbCPWy
 tpPVtEjI8kjgTurJ03wSP7Hx4++seg1DL9t/GcVRJjp3AfJpuWvHTO3wYBhqnuUtGXnBqD2lUbw
 DRZJS9A62sl3PC+Mutu+Ern9n71IrmQDmkrTMy7wSg8JjO1EaARku/cR+cNgXUCmHDGCa1zqPF6
 O6/FJx41xOCYERpRY+7amgONs4zulhNl5fcrY967XarmOw6QF2tGlmcKp+KA9wd4WgQvV3EgocV
 5BLPQ==
X-Received: by 2002:a05:6214:1c4e:b0:8ca:1e71:c5fb with SMTP id
 6a1803df08f44-8cc6e91f389mr49249796d6.7.1779386061667; 
 Thu, 21 May 2026 10:54:21 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc768b6fc2sm11374296d6.6.2026.05.21.10.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 10:54:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wQ7bA-000000020Ak-1yKK;
 Thu, 21 May 2026 14:54:20 -0300
Date: Thu, 21 May 2026 14:54:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
 suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260521175420.GA7702@ziepe.ca>
References: <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca> <yq5aik9jcpzm.fsf@kernel.org>
 <20260424225514.GE804026@ziepe.ca>
 <20260426130531.GF804026@ziepe.ca> <yq5azf1s6aic.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5azf1s6aic.fsf@kernel.org>
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

On Thu, May 21, 2026 at 09:05:39PM +0530, Aneesh Kumar K.V wrote:
> I am wondering whether this is better
> 
> static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> 		unsigned long attrs, bool flush)
> {
> 	dma_addr_t dma_addr;
> 
> 	/*
> 	 * For a device requiring unencrypted DMA, MMIO memory is treated
> 	 * as shared.
> 	 */
> 	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> 		attrs |= DMA_ATTR_CC_SHARED;

It is an option, I would be happier if we went and fixed the few
callers to properly pass the shared. CC did this with the
pgprot_decrypted() stuff, same reasoning:

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bfdb9ed7074116..e77f6404caa3db 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -90,7 +90,7 @@ static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 	unsigned int attrs = 0;
 
 	if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= iter->p2pdma.mem->dma_mapping_flags;
 
 	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
 			rq_dma_dir(req), attrs);
@@ -115,7 +115,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 	iter->len = dma_iova_size(state);
 
 	if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= iter->p2pdma.mem->dma_mapping_flags;
 
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a34..96022fadc48245 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -147,7 +147,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 			ret = dma_iova_link(attach->dev, dma->state,
 					    phys_vec[i].paddr, 0,
 					    phys_vec[i].len, dir,
-					    DMA_ATTR_MMIO);
+					    provider->dma_mapping_flags);
 			if (ret)
 				goto err_unmap_dma;
 
@@ -155,7 +155,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 		} else {
 			addr = dma_map_phys(attach->dev, phys_vec[i].paddr,
 					    phys_vec[i].len, dir,
-					    DMA_ATTR_MMIO);
+					    provider->dma_mapping_flags);
 			ret = dma_mapping_error(attach->dev, addr);
 			if (ret)
 				goto err_unmap_dma;
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7c898542af8d5e..e4229b4d35c767 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -282,6 +282,8 @@ int pcim_p2pdma_init(struct pci_dev *pdev)
 			continue;
 
 		p2p->mem[i].owner = &pdev->dev;
+		p2p->mem[i].dma_mapping_flags =
+			DMA_ATTR_MMIO | DMA_ATTR_CC_SHARED;
 		p2p->mem[i].bus_offset =
 			pci_bus_address(pdev, i) - pci_resource_start(pdev, i);
 	}
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 873de20a224759..402dc5e5d62b0a 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -21,10 +21,12 @@ struct scatterlist;
  *
  * A p2pdma provider is a range of MMIO address space available to the CPU.
  * @owner: Device to which this provider belongs.
+ * @dma_mapping_flags: DMA attributes to use for host bridge mappings.
  * @bus_offset: Bus offset for p2p communication.
  */
 struct p2pdma_provider {
 	struct device *owner;
+	unsigned long dma_mapping_flags;
 	u64 bus_offset;
 };
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 5955f2f0c83db1..c3f445acddf873 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -811,7 +811,7 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= p2pdma_state->mem->dma_mapping_flags;
 		pfns[idx] |= HMM_PFN_P2PDMA;
 		break;
 	case PCI_P2PDMA_MAP_BUS_ADDR:
