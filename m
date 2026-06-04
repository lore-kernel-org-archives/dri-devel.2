Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD224CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE5E1125AD;
	Thu,  4 Jun 2026 02:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q59NykEs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01ADE1125AD
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780541150; x=1812077150;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zwaEOC72aj4r75+dKErQgCh/I2UYQPGFQIzWi9Bh55Y=;
 b=Q59NykEs2yiaUSVoE6zHmVyHmAlYiQWZoyUWIqOpCXQczH1Db19kIbI6
 tM8jOtLfB1Z9DpVrxE3DdrLKSFgdW8A/mDBgNVvhGWFCCiFnMsdGIIZYY
 pt3wPm/OnNvvH0UIBPc4ogwzBek0ap8FokWdymTKQuWom9BGHF3a47Ljm
 PftZ9Zb4nTQajqZ7x+Af+IBJDejklY/fr7Wf3rsgKDysAco2AwCK4DKEK
 2fBrzXrKtU4bcYwbRXPr1TOxrl7+jbKjzTXiAyIKiZII8wZE2qTCo8K1k
 tdISjGMnMewAfbmcWWSl8e8BJXtLX34GFZhh1/M2IzeYwvRZ1VH2wNeb8 A==;
X-CSE-ConnectionGUID: M2f7LjVoQo2FGYlbCmYcYA==
X-CSE-MsgGUID: 5cidNrCxTk2f85vEDUOeMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81394976"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="81394976"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 19:45:49 -0700
X-CSE-ConnectionGUID: S4I3acvjTca0y7rBk61R5g==
X-CSE-MsgGUID: OCypOtVWTQWlA8M8EeXAjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="244260671"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 19:45:43 -0700
Message-ID: <633995b3-f534-49ef-9bb5-2ebebfc2d443@linux.intel.com>
Date: Thu, 4 Jun 2026 10:44:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/32] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org, robin.murphy@arm.com,
 shiyu.zsq@linux.alibaba.com, steven.price@arm.com,
 suravee.suthikulpanit@amd.com, tzimmermann@suse.de,
 wei.guo.simon@linux.alibaba.com, will@kernel.org, xlpang@linux.alibaba.com
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/3/26 23:17, Guanghui Feng wrote:
> Add iova_to_phys_length callback to struct iommu_domain_ops alongside
> the existing iova_to_phys. The new callback returns both the physical
> address and the PTE mapping page size in a single page table walk.
> 
> Add iommu_iova_to_phys_length() core function that:
> - Checks ops->iova_to_phys_length first (preferred path)
> - Falls back to ops->iova_to_phys for unmigrated drivers
> 
> This enables callers like VFIO to efficiently traverse IOVA space
> by actual mapping granularity instead of fixed PAGE_SIZE steps.
> 
> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang<shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo<wei.guo.simon@linux.alibaba.com>
> ---
>   drivers/iommu/iommu.c | 50 ++++++++++++++++++++++++++++++++++++++-----
>   include/linux/iommu.h |  9 ++++++++
>   2 files changed, 54 insertions(+), 5 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
