Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CEFC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3645010F05E;
	Wed, 12 Aug 2026 22:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cGPTP03w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27BF10F05E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 22:34:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC30E40AA8;
 Wed, 12 Aug 2026 22:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCDE1F000E9;
 Wed, 12 Aug 2026 22:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786574055;
 bh=zIJaVQwgy3+phEYTr1LnspZFuRmzeHEpVwwk/PBOaCo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cGPTP03wUG80YmVMBODmbasm4ppKUGuWWZcUwvqj46epN/xQO8bSWtSuxBsSzMTrm
 xVAi3EIOLC10qfV/rs8N0KHo3fqQtHQdL7PQ9jXzPzkuVeIBgKcwXHU3KIX+2rD14R
 n6ah8z+Q/9HwjWNp7R/I9R0wQg4Yqkc7nhslLLwNSozuRhmUl3Vy8JXtLk5xybQM0J
 /guRBSF2oOcCa+eBmtvEvHHraXmiyJe77EreH8uPP6jDQdm9BoLpnGwAGlm0CPZIyj
 oMUvUbXA8fJ9m9NcDjx70rQLJkU+OPiUVZtIs87OoQOux+/pyvd4DhAO9Twdc+Sp3T
 Op1aDi3RrsjGA==
Date: Wed, 12 Aug 2026 17:34:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Brian Starkey <Brian.Starkey@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Conor Dooley <conor+dt@kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 "Liam R. Howlett" <liam@infradead.org>, dri-devel@lists.freedesktop.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Heiko Carstens <hca@linux.ibm.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 David Hildenbrand <david@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-trace-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 Russell King <linux@armlinux.org.uk>, John Stultz <jstultz@google.com>,
 linux-arm-kernel@lists.infradead.org,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 iommu@lists.linux.dev, Mike Rapoport <rppt@kernel.org>,
 Chun Ng <chunn@nvidia.com>, linux-media@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "T.J. Mercier" <tjmercier@google.com>, linux-kernel@vger.kernel.org,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Yury Norov <yury.norov@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Thierry Reding <treding@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 linaro-mm-sig@lists.linaro.org, Steven Rostedt <rostedt@goodmis.org>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 03/10] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
Message-ID: <178657405441.1338311.10765338394838016729.robh@kernel.org>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>
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


On Fri, 07 Aug 2026 17:54:23 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The video protection region is a reserved memory region that can be used
> for secure video playback. NVDEC can access this region to decode images
> into securely.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

