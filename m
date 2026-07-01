Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1840DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 19:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B596C10E20F;
	Wed,  1 Jul 2026 19:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dVQu4w7P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E23110E20F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 19:53:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12DEE601DF;
 Wed,  1 Jul 2026 19:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4A41F00A3A;
 Wed,  1 Jul 2026 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782935592;
 bh=fzFM+3fnKG0YLEDmBIloyOG/31SnlMJCbijzwmUNu+0=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=dVQu4w7P3dCUJ5KBUDAc4q3L1wAsQVNP/nKMxUpjt8ZiS/3HdSIMwTOljW8/JVMl0
 DD5yfBvXaIX6yid82xMVg80tHH93ROwQVaAxzACoOABqbDYaCrwrCdnMp9yQjhfmtv
 yM/CK/nD1+sWbi/uI5coRQ1PFmO6naJBOghjrbGdQihcbAPR/R2fxRSZsHfL3/gAe1
 dMrlH6WU1wKStdUEBTtzKgxEFvCZ0V/P2NzUQYLEfQBmrAPn+66TFX5UaD09Y1Jc/x
 xn/7dzGPjhWgaqehG2ONJtZ4IjW23B2TJGgOkXsKOGFoAeMGU/E2Pcw/2APB/MHO/i
 qx3e+GdTEgJqA==
Date: Wed, 01 Jul 2026 14:53:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linaro-mm-sig@lists.linaro.org, Lorenzo Stoakes <ljs@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Yury Norov <yury.norov@gmail.com>, 
 linux-media@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jonathan Hunter <jonathanh@nvidia.com>, linux-s390@vger.kernel.org, 
 Masami Hiramatsu <mhiramat@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
 David Hildenbrand <david@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Simona Vetter <simona@ffwll.ch>, Mike Rapoport <rppt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>, 
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Brian Starkey <Brian.Starkey@arm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 John Stultz <jstultz@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, linux-tegra@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 "T.J. Mercier" <tjmercier@google.com>, David Airlie <airlied@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>
In-Reply-To: <20260701-tegra-vpr-v3-2-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-2-d80f7b871bb4@nvidia.com>
Message-Id: <178293559078.1610192.17087150631381044391.robh@kernel.org>
Subject: Re: [PATCH v3 02/11] dt-bindings: display: tegra: Document memory
 regions
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


On Wed, 01 Jul 2026 18:08:13 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add the memory-region and memory-region-names properties to the bindings
> for the display controllers and the host1x engine found on various Tegra
> generations. These memory regions are used to access firmware-provided
> framebuffer memory as well as the video protection region.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - document properties for VIC
> ---
>  .../devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml |  8 ++++++++
>  .../devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml  | 10 ++++++++++
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml   | 10 +++++++++-
>  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml          |  7 +++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names: 'anyOf' conditional failed, one must be fixed:
	'maxitems' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names:items: {'enum': ['framebuffer', 'protected']} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names: Additional properties are not allowed ('maxitems' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names:items: {'enum': ['framebuffer', 'protected']} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml: properties:memory-region-names: Additional properties are not allowed ('maxitems' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701-tegra-vpr-v3-2-d80f7b871bb4@nvidia.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

