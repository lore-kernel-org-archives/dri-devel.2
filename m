Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5D2C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 19:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E72C10E265;
	Wed,  1 Jul 2026 19:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SW5Xw1L4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C971210E20F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 19:53:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2744433C5;
 Wed,  1 Jul 2026 19:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA4B1F000E9;
 Wed,  1 Jul 2026 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782935591;
 bh=Btp8Coh0/YDoX5eWIBILnB6rkqO9aOJKzbTAJEfWmYk=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=SW5Xw1L4n6km0go7iiQIUMhYp6NAfj0RV6eYQqCVHodCALEB8dTOYsfQaNULAMbqI
 xB7nUW5AdUfmj/kfqGM0ge94GbUCCvRDC/EQnSopZqdpLC3YWJPU3hhxzoB7TiuMXK
 rgwksGyFQDkLQ4L1Zv//reedGipqwPdRgCwYfIYn7SUowcW/xIaoKQgA7tLYyowF21
 vtZqvsjUt5lA/qYPA9GV1RiCdmGczJhLUDM+otUG+k4cTl/W4Sjha1gMK6icACBU9B
 4gKGJaZ253aNPnE8hxuMfX5mHW4TnINK1IFn2iP7EiwQlNNuW7HvzKuCaOFexbJrlV
 u/4ONeNo3HSXg==
Date: Wed, 01 Jul 2026 14:53:10 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 dri-devel@lists.freedesktop.org, David Hildenbrand <david@kernel.org>, 
 Yury Norov <yury.norov@gmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-trace-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>, 
 Will Deacon <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 David Airlie <airlied@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 linaro-mm-sig@lists.linaro.org, Heiko Carstens <hca@linux.ibm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Thierry Reding <treding@nvidia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, John Stultz <jstultz@google.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Brian Starkey <Brian.Starkey@arm.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Michal Hocko <mhocko@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 devicetree@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
 linux-tegra@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, iommu@lists.linux.dev, 
 Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>
To: Thierry Reding <thierry.reding@kernel.org>
In-Reply-To: <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com>
Message-Id: <178293558945.1610040.13281502080616690110.robh@kernel.org>
Subject: Re: [PATCH v3 01/11] dt-bindings: reserved-memory: Document Tegra VPR
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


On Wed, 01 Jul 2026 18:08:12 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Video Protection Region (VPR) found on NVIDIA Tegra chips is a
> region of memory that is protected from CPU accesses. It is used to
> decode and play back DRM protected content.
> 
> It is a standard reserved memory region that can exist in two forms:
> static VPR where the base address and size are fixed (uses the "reg"
> property to describe the memory) and a resizable VPR where only the
> size is known upfront and the OS can allocate it wherever it can be
> accomodated.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add examples for fixed and resizable VPR
> ---
>  .../nvidia,tegra-video-protection-region.yaml      | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra-video-protection-region.example.dtb: protected@2a8000000 (nvidia,tegra-video-protection-region): reg: [[2, 2818572288], [0, 1879048192]] is too long
	from schema $id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra-video-protection-region.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra-video-protection-region.example.dtb: protected@2a8000000 (nvidia,tegra-video-protection-region): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra-video-protection-region.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

