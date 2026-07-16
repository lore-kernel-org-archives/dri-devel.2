Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F41C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3E010F31B;
	Thu, 16 Jul 2026 13:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KbqUptLj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B8210F319;
 Thu, 16 Jul 2026 13:31:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 432BB40743;
 Thu, 16 Jul 2026 13:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905941F000E9;
 Thu, 16 Jul 2026 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208719;
 bh=yS9bNunJIYcGp7pM+GGsfoUYEDKOWl8+J/XHzg82dRU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KbqUptLjSwHbPDnl6EODLgtr0+4G+Vr/GtLsN8uL1R0gJIbcJrT9INA5Bsp48xFc7
 uBGW/ISebTiRPnsimApzUl9NclYX2xh1l1X4NXZZjnAeSSSFNYTRMypcY/rUhyl+X1
 /7F6szx0dZdEkzpjdZXEZE5GDp4nGDRMG6wLJU1JgK7vImT0swvx9wF8O4ht7g3joe
 kDDXkZm0rqfhR/CQny+02fMgaTBpKdu49C8Yx2xuJ87zFpVlntVhAzq2XjsDAJ5/eD
 MgCdvius755vFAuRCD11n+E/RU74UcgR42ez7mpfqR5l5mHGTHiYGsp1W8i6LKucW6
 B2mW+krILaKHg==
Date: Thu, 16 Jul 2026 14:31:43 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, 
 kasan-dev@googlegroups.com, linux-sgx@vger.kernel.org,
 etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, kvm@vger.kernel.org, 
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Ackerley Tng <ackerleytng@google.com>, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v2 00/33] mm: make VMA page offset handling more consistent
Message-ID: <aljdJD9TNWYCQ3HL@lucifer>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <c2fd5114-74d0-4996-8035-311ba976b3eb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2fd5114-74d0-4996-8035-311ba976b3eb@amd.com>
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

On Thu, Jul 16, 2026 at 12:03:41PM +0200, Christian König wrote:
>
> I only skimmed over the set but should there be any changes required to DMA-buf, amdgpu or radeon driver feel free to add
>
> Acked-by: Christian König <christian.koenig@amd.com>
>
> and merge upstream through any branch you feel fit.
>
> Regards,
> Christian.

Thanks :)

Cheers, Lorenzo
