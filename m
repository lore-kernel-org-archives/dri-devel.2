Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680B1C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31F610E3C5;
	Wed,  1 Jul 2026 16:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="foSZak7+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6018D10E3C5
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782924811;
 bh=F3uHPVS1XECBg+1FJgBsfQzbfVfb5e4T+gqzbMq2A5Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=foSZak7+BxtLEwRYgivu+0IOUXwZ3OQ04aj+NCtX/mR7oZk0d2+9TLw6JHLv9hqvH
 gD+XAmcBQwF9Oo0c9klBThjh/SCCPAsGPNYZvpyVx+o+lBUT9/m3TPgWlvBT64AESc
 1VYYtkRp2dAH/mYKaR93afRjTL1tHfoNvFgEK3LH0j/n6D8lm89ZeViVFCEzORlOM+
 NO6a2s0LYpYd1YW3iAgo9LPKspHAlUFw/CVSibbOudHrMQUoG3fqEVt3205ewyFn69
 a+j72Ht3QSFWjtbjkcndWh+WwsAmy/6BqWzY3mmuyvE8chms1hnDugSMwuCq/S4Le6
 LfnTMMuWfCOpQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A56B317E0CA2;
 Wed,  1 Jul 2026 18:53:30 +0200 (CEST)
Message-ID: <f56fcbae-3ff5-46c3-bbe7-7eac462f7dd2@collabora.com>
Date: Wed, 1 Jul 2026 18:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/42] dt-bindings: display: mediatek: Introduce Digital
 Video Output HW
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, kernel@collabora.com,
 tzimmermann@suse.de, chunkuang.hu@kernel.org, simona@ffwll.ch,
 linux-arm-kernel@lists.infradead.org, jason-jh.lin@mediatek.com,
 airlied@gmail.com, conor+dt@kernel.org, maarten.lankhorst@linux.intel.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 mripard@kernel.org, devicetree@vger.kernel.org, justin.yeh@mediatek.com
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-24-angelogioacchino.delregno@collabora.com>
 <178291581273.4115171.8214844308967079622.robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <178291581273.4115171.8214844308967079622.robh@kernel.org>
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

On 7/1/26 16:23, Rob Herring (Arm) wrote:
> 
> On Wed, 01 Jul 2026 14:20:38 +0200, AngeloGioacchino Del Regno wrote:
>> Add documentation for the Digital Video Output (DVO) IP found in
>> the newer generation SoCs MT8196, MT8189 and their variants.
>>
>> This is effectively a more capable block replacing the DisplayPort
>> Interface (DPI/DP_INTF) one found in older SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../display/mediatek/mediatek,mt8196-dvo.yaml | 142 ++++++++++++++++++
>>   1 file changed, 142 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 

Those errors on literally all bindings are quite embarassing. Oops.

Already fixed locally, but since this is a huge series, I will allow some time
for reviews before compulsively pushing a v2.

Cheers,
Angelo

> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: ignoring, error in schema: properties: compatible
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
> 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-doc-validate", line 8, in <module>
>      sys.exit(main())
>               ~~~~^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 66, in main
>      ret |= check_doc(f)
>             ~~~~~~~~~^^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 37, in check_doc
>      dtsch.check_schema_refs()
>      ~~~~~~~~~~~~~~~~~~~~~~~^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 242, in check_schema_refs
>      self._check_schema_refs(resolver, self)
>      ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
>      self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
>      ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                              has_constraint=has_constraint)
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
>      self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
>      ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                              has_constraint=has_constraint)
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 203, in _check_schema_refs
>      ref_sch = resolver.lookup(schema['$ref']).contents
>                ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
>    File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
>      retrieved = self._registry.get_or_retrieve(uri)
>    File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 422, in get_or_retrieve
>      registry = self.crawl()
>    File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 500, in crawl
>      id = resource.id()
>    File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 231, in id
>      id = self._specification.id_of(self.contents)
>    File "/usr/local/lib/python3.13/dist-packages/referencing/jsonschema.py", line 50, in _dollar_id
>      return contents.get("$id")
>             ^^^^^^^^^^^^
> AttributeError: 'list' object has no attribute 'get'
> Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.example.dtb: /example-0/dvo@324c0000: failed to match any schema with compatible: ['mediatek,mt8196-edp-dvo']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260701122057.19648-24-angelogioacchino.delregno@collabora.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

