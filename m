Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9D2C5CFEB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1DC10F06A;
	Wed, 12 Aug 2026 22:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NxnDcAN9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E30D10F06A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 22:33:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD844414B4;
 Wed, 12 Aug 2026 22:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6503E1F00A3F;
 Wed, 12 Aug 2026 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786574017;
 bh=aHVs81CE2IQ9JD4d8n66KMCOswlVQXDqi/24OSbt1Sk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NxnDcAN9Z4zXwB8VaQ4ooTdrRgky6Q8zLm6mxJ1RjWe0Ovnre8a/4e3j/pRx23n0/
 cgEf7TjrJMOhg0gmXjJXZ4JO3u25sFIG+ohZ87f1hnkqMiFEbX7HY4rFnFRxcBbrlh
 tarqc9v8P+vKy7klLcouGokQZCYzNvAPTFlHUzDvkg0nGKbkA5JZXjdnJZSEsnLwSd
 kSwV3PlOUlPY3k2iIRlibhfvsba3Q+ayHFC5C16qaWaoflAOG0WuK1M2/oFs8EbGqQ
 7FfrFAcQJBPX6Dt+03UO4/bZ+nDwz1sfdBzJP5rXNK3BVTpjgRsNEjab5htv4BFZXL
 /sa4Zn9VXn4YQ==
Date: Wed, 12 Aug 2026 17:33:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: linaro-mm-sig@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Russell King <linux@armlinux.org.uk>, linux-tegra@vger.kernel.org,
 linux-mm@kvack.org, Maxime Ripard <mripard@kernel.org>,
 Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, iommu@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sven Schnelle <svens@linux.ibm.com>, Brian Starkey <Brian.Starkey@arm.com>,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 David Hildenbrand <david@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Heiko Carstens <hca@linux.ibm.com>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
 Mike Rapoport <rppt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Suren Baghdasaryan <surenb@google.com>, Chun Ng <chunn@nvidia.com>,
 Thierry Reding <treding@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Will Deacon <will@kernel.org>, David Airlie <airlied@gmail.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v4 02/10] dt-bindings: display: tegra: Document memory
 regions
Message-ID: <178657401505.1337249.16016860893024599580.robh@kernel.org>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>
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


On Fri, 07 Aug 2026 17:54:22 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add the memory-region and memory-region-names properties to the bindings
> for the display controllers and the host1x engine found on various Tegra
> generations. These memory regions are used to access firmware-provided
> framebuffer memory as well as the video protection region.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v4:
> - typofix
> 
> Changes in v3:
> - document properties for VIC
> ---
>  .../devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml |  8 ++++++++
>  .../devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml  | 10 ++++++++++
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml   | 10 +++++++++-
>  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml          |  7 +++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

