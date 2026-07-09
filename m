Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78571C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2FA10E2A8;
	Thu,  9 Jul 2026 05:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="YG6NrUKP";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745B510E2A8
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 05:56:52 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260709055650euoutp025a12a0c6f53f1597c081fde8840d680e~AiXozFXMg0222702227euoutp02U;
 Thu,  9 Jul 2026 05:56:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260709055650euoutp025a12a0c6f53f1597c081fde8840d680e~AiXozFXMg0222702227euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1783576610;
 bh=0zn1dtIX1zk4qdGW1lihLluLd2XJtl/1EEzMzw8sXVc=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=YG6NrUKPsBwqBvMGbjU5xWHF+nu3KR5nOX3x74qWn9o7ulsLODQrO0+6rPDBK/gpN
 1aWd1EwavrpW47dURG/rZPG1Z8lkEaDbZyuKetZ8FW+4NfqXLobtjcACnZ9jgKwdIK
 6ZKTeq786aUMJpm83Q1TIX+j/ImTlbLRjVWgi5yM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260709055650eucas1p215ba97832f0fed53c1c322ecf192ff45~AiXoi0Jv90198801988eucas1p2U;
 Thu,  9 Jul 2026 05:56:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260709055646eusmtip2b9b69a8f7af4b283ece88d085252d254~AiXlAfqwT0885208852eusmtip2U;
 Thu,  9 Jul 2026 05:56:46 +0000 (GMT)
Message-ID: <83e5e74d-7106-4e14-9d10-56438372f6a3@samsung.com>
Date: Thu, 9 Jul 2026 07:56:45 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
To: "David Hildenbrand (Arm)" <david@kernel.org>, Thierry Reding
 <thierry.reding@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan
 Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Yury
 Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier"
 <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 linaro-mm-sig@lists.linaro.org, linux-trace-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <e212caac-6c30-448a-9e10-32fff8b842f6@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260709055650eucas1p215ba97832f0fed53c1c322ecf192ff45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260701160902eucas1p1214af933ba0f54b85630a3a4e5a4689c
X-EPHeader: CA
X-CMS-RootMailID: 20260701160902eucas1p1214af933ba0f54b85630a3a4e5a4689c
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <CGME20260701160902eucas1p1214af933ba0f54b85630a3a4e5a4689c@eucas1p1.samsung.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
 <3f47aeab-33b1-4966-a5ce-5d6d5261e0e2@samsung.com>
 <e212caac-6c30-448a-9e10-32fff8b842f6@kernel.org>
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

On 08.07.2026 10:35, David Hildenbrand (Arm) wrote:
> On 7/7/26 12:02, Marek Szyprowski wrote:
>> On 01.07.2026 18:08, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> There is no technical reason why there should be a limited number of CMA
>>> regions, so extract some code into helpers and use them to create extra
>>> functions (cma_create() and cma_free()) that allow creating and freeing,
>>> respectively, CMA regions dynamically at runtime.
>>
>> Well, the technical reason for not creating cma regions dynamically at
>> runtime is that on some architectures (like 32bit ARM) the early fixup
>> for the region is needed to make it functional for DMA.
> Can you point me at the code that does that? Thanks!
Check dma_contiguous_early_fixup() and dma_contiguous_remap() in 
arch/arm/mm/dma-mapping.c. Those functions ensures that the CPU mappings for
the CMA reserved region in linear map are remapped with 4k pages instead
of the 1M sections, so later, it will be possible to alter the mappings and
change them to coherent when needed (altering 1M sections is not possible,
because each process has it's own level-1 array even for the kernel linear
mapping).



However, in the use case in this patchset the reserved region is only shared
with buddy allocator by using the CMA infrastructure, not registered to the
regular DMA-mapping API, so it would work fine. I'm not convinced that this
is the right API to use for this though.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

