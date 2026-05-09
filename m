Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C73CD343F
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 05:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B8B10E366;
	Sat,  9 May 2026 05:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JN0Q4Wf3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E1610E364;
 Sat,  9 May 2026 05:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778306102; x=1809842102;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5hRHi2UuH9Kopvp+C43fqR0+YbJ1bkI0syw3vymYipA=;
 b=JN0Q4Wf3n39mlyxXMNy6BdWr7bo8ATZfyAtn9I2ZD8ckhZl+HztDQzsq
 Bcp7okK7+xNBhM4Iai3VfsSUlvGJJdSMwVcUQ3F5rIGleu2VzlXhh5yUI
 rtxM7AHSWjPv2XKEV/T4FHBRBeZuY9O6qmiCi3+W247MsPfIVEuDypKdz
 oEAQn0PzfrGcCqIELNZIkILmbbzkuq5DxAAdSTEOLL6x24NIqOOht9X0a
 chKytzuAoy9980Z1SW8QXGSrcmziqdh/lR7eeyLQCZhndcKDhTAIofd4m
 BlcDIV19zkoHWR0NIhXGbWH4EzrgI2uXcYpb86vKWDMiBCeyImM6iEMHW Q==;
X-CSE-ConnectionGUID: hxfJFbBbR8CnTNsqQxDXFA==
X-CSE-MsgGUID: tl/Vn8NOSrWawnYM3jld9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="104736197"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="104736197"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 22:55:01 -0700
X-CSE-ConnectionGUID: AldiaZa1SEm+ZwknPId4VA==
X-CSE-MsgGUID: UOkFPcjBRhq7NgYOC6BJPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="260411284"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by fmviesa002.fm.intel.com with ESMTP; 08 May 2026 22:54:58 -0700
Date: Sat, 9 May 2026 13:31:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 21/26] dma-buf: Add the Physical Address List DMA
 mapping type
Message-ID: <af7GzASJiASopYiN@yilunxu-OptiPlex-7050>
References: <21-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com>
 <20260413121628.GE2588311@nvidia.com>
 <f6d38a08-009c-4efe-9dc3-6bcf00ac35f7@amd.com>
 <20260422115306.GI3199414@nvidia.com>
 <fd8065ce-fd0e-4df5-9c80-8e9603657cfe@amd.com>
 <20260422131337.GJ3199414@nvidia.com>
 <e67426b9-4ded-4f6c-8309-7f847adb4540@amd.com>
 <20260422150000.GK3199414@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422150000.GK3199414@nvidia.com>
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

> Would you be open to an in-between? The exporter and importer both
> have information that should not leak into each other's drivers. 
> 
> What if the dmabuf mapping type core code was the only thing that had
> access to *BOTH*? The exporter provides the address data, the importer
> provides the iommu_domain. The core code, and only the core code, has
> both and does the required operation?

I think that may not work for KVM. On IOMMU side, IOMMUFD acts as the
address space (iova) manager and dma_api/IOMMU driver acts as the
actual page table mapper. But for KVM, it is both. KVM doesn't allow
another component to provide an unknown address space (GPA space) and
say "map it", so doesn't expose to other components about "KVM domain".

Even if we expose "KVM domain", KVM still acts as the importer and the
mapper, is it wierd to say we trust KVM-the-mapper, but don't trust
KVM-the-as-manager?

Is it also wierd that we trust IOMMU-the-mapper, but don't trust
IOMMUFD-the-as-manager? There are more IOMMU drivers than IOMMUFD...
