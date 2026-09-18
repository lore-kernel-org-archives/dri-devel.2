Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE515C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DB110E2C0;
	Fri, 18 Sep 2026 18:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="b3tlnCmF";
	dkim-atps=neutral
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0B510E2C0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=AYAzVP/8f8Otb2PCzWFEmkBr82oGzj3BYT7jfwM6D3U=; b=b3tlnCmFMy+rn6Z8ytScOTSJLh
 VoMg/px+h/5RcvrIBShYg4emqzl/iSzEpUeGPk6kD3cVzqoONFrL8e9aGiAXmvIZdu+eyf46YbXlX
 YNVtd+SKyOaKRCk1E8c5HTsOo1YQ7sT6LojpDeSaMwKg7pYA3y0zdoWwMOuRIsIAMXarZcnqFZX63
 a1TPmVGdteTzf8U02YBpscdW6Ea6cDXWEFP/jPxHBrt4iVxPHJUZ4l//EFec9R1z4wn2XazgxjSKy
 EYn1VAxl6GBy4K07T2IkhN6tU89vT0Vnqrel3nAnIubRCb63mmCijvdTNGmXTAa2+7F+oFaVidO99
 ApHlYtXw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1x7dH6-0000000CrEc-2a01;
 Fri, 18 Sep 2026 12:25:29 -0600
Message-ID: <6e4f0c2f-eae8-4cd5-9c10-9b9a59941d2f@deltatee.com>
Date: Fri, 18 Sep 2026 12:25:01 -0600
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
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, Matt Evans <matt@ozlabs.org>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-1-5ef07ec9ef06@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260914-fix-p2p-acs-v4-0-v6-1-5ef07ec9ef06@nvidia.com>
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
 kvm@vger.kernel.org, matt@ozlabs.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 01/18] PCI/P2PDMA: Document pdev->p2pdma lifetime rules
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
> pdev->p2pdma is normally accessed through provider-owned references, but
> pci_p2pmem_find_many() and the p2pmem sysfs attributes may race with driver
> unbind.
> 
> Document initialization, teardown, and how the release grace period
> protects both the P2PDMA state and its optional allocation pool.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reads correct to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
