Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C9DC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A550C10E999;
	Fri, 18 Sep 2026 19:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="p1hFKb1F";
	dkim-atps=neutral
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFDF10E999
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=lQAIrUFP3+D+tD4U17DzHrKkOc11Ho5y+ORRcF4NPXs=; b=p1hFKb1F/D9iIDg6hNHtr8GiM2
 l37aQ39NUCI6IRV6cw9gskBQm2rzWzmoVGB1A1sSt6dz5QZVE29rnly2O4sra+jAVtX5GubBbhzIT
 estioaTW7b42lemwzxUqTkaexKwqWBQXacYsSjVZzNvKbOFT+MjWkLM0OirZSxU2f7sT+NKmqaUfV
 o2SyHTECs+cKETwfqStVBNeQngTXT/DtkXdqEV9Mma6d2VcU0eUSuvkbsuX6aqp80gMFjKciNXgwC
 YI36SyWZbHBozXXE9/fXLmwHKXHr3dGHRBoTkxESWTCrljgEUe7uToA9S6ifHB5P/eblW6xIUFZVM
 uH56LcFg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1x7eRN-0000000CrxC-0gtG;
 Fri, 18 Sep 2026 13:40:10 -0600
Message-ID: <19bee27e-17d7-4b67-b796-ca5bb44e8de7@deltatee.com>
Date: Fri, 18 Sep 2026 13:39:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-3-5ef07ec9ef06@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260914-fix-p2p-acs-v4-0-v6-3-5ef07ec9ef06@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com,
 gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org,
 ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, rdunlap@infradead.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 tdave@nvidia.com, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 kvm@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 03/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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



On 2026-09-14 05:22, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> direction can unnecessarily force P2PDMA through the host bridge.
> 
> Evaluate Request Redirect for client Requests and Completion Redirect for
> provider read Completions. Continue treating enabled Egress Control
> conservatively as a Request redirect.
> 
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Core patch seems fine, minus one minor point below:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> @@ -1132,10 +1173,10 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>  /**
>   * pci_p2pdma_map_type - Determine the mapping type for P2PDMA transfers
>   * @provider: P2PDMA provider structure
> - * @dev: Target device for the transfer
> + * @dev: Client device that initiates the transfer
>   *
>   * Determines how peer-to-peer DMA transfers should be mapped between
> - * the provider and the target device. The mapping type indicates whether
> + * the provider and the client device. The mapping type indicates whether
>   * the transfer can be done directly through PCI switches or must go
>   * through the host bridge.
>   */
> 

This hunk does not seem like it belongs in this patch.
