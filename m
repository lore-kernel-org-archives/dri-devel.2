Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8428CC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCD610E5E4;
	Fri,  3 Jul 2026 12:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d6VbRKa+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3151C10E5E4
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:14:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EFD26600E1;
 Fri,  3 Jul 2026 12:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126D41F000E9;
 Fri,  3 Jul 2026 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080881;
 bh=wCSekJzceclmv2Xdvl4vn/0F9vF6oLcNXpc7pUyDj0k=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=d6VbRKa+He2/cAFmwYnkVZjxIlsRAYd3koyUzl174SlRWigVinPrxLNyW1D1D0xO6
 vkKKNIjrywD5F/UoMCDkjtUhMxTDLSU421VLUP3NnsA6Yq0l9c8CZZMUbV11zQMLVm
 xMzeOzkKcw/86tXQdDzbYMe4rYh4Pzb86R5wZxWB+2w+rY6vfS4Tp4BiDgmMxVtryf
 iBGvffCRTHwx+6nF4Codf8+X4UD6mDt+kizURmVt9H/JKijTnykALPxPBgCZUpmupk
 VMwlDGrjS5G8BUxlsvjQZ0J03g4d96qrPiIHOY/A1nSnH6jTvs4ieLW2YML2tmOltj
 ytQtBS/G8QFIA==
Message-ID: <e6cccc28049a6231d50842254447c909@kernel.org>
Date: Fri, 03 Jul 2026 12:14:39 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thierry Reding" <thierry.reding@kernel.org>
Subject: Re: [PATCH v3 07/11] dma-buf: heaps: Add debugfs support
In-Reply-To: <20260701-tegra-vpr-v3-7-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-7-d80f7b871bb4@nvidia.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Benjamin Gaignard" <benjamin.gaignard@collabora.com>,
 "Brian Starkey" <Brian.Starkey@arm.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, 
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Conor
 Dooley" <conor+dt@kernel.org>, "David Airlie" <airlied@gmail.com>, "David
 Hildenbrand" <david@kernel.org>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "John Stultz" <jstultz@google.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Liam
 R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Michal
 Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Mikko
 Perttunen" <mperttunen@nvidia.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>, "Rob
 Herring" <robh@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Russell
 King" <linux@armlinux.org.uk>, "Simona Vetter" <simona@ffwll.ch>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Sumit
 Semwal" <sumit.semwal@linaro.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Sven
 Schnelle" <svens@linux.ibm.com>, "T.J. Mercier" <tjmercier@google.com>,
 "Thierry
 Reding" <thierry.reding@gmail.com>, "Thierry Reding" <treding@nvidia.com>,
 "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Yury Norov" <yury.norov@gmail.com>
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

On Wed, 1 Jul 2026 18:08:18 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a callback to struct dma_heap_ops that heap providers can implement
> to show information about the state of the heap in debugfs. A top-level
> directory named "dma_heap" is created in debugfs and individual files
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
