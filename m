Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473D7C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906F810E39C;
	Wed,  1 Jul 2026 14:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EzLT8/YB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CE110E397
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 14:23:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F5F96001D;
 Wed,  1 Jul 2026 14:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241651F000E9;
 Wed,  1 Jul 2026 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782915820;
 bh=Ao2e4oml9wyP8ZDiiFp/FwD87zl/XZ7fR7vvHotuJkc=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=EzLT8/YBy4/tcL4Rg0lEVmwQyXjQbxJ/R1A2Rv2piwbsp6FOOAtl/tlWOPCYLZ6+H
 iLNiwTVx2u5CU//oPivoXTEYzi0oK7Woa3UHg4MURm9TOb2TK0qzChygYJtdEJ+Eev
 TaUJPYtJi03UxekA81CxgjXTqGK8l5rGtvFPBB7BIQbgkgVO+fqrxWVCjTDvMbOmm+
 Iqts+D4oaIZgkENj8uXQxN/ki2aLO7JeWT1tYedFtFmiYBNxHxf55GXS0aEWy5VNOe
 LbpPao9oFTkAIinQTEGFcZ9hF4mfQXk4SBqFf2XfV4kCOAf+kwQJ/g3sW8kbj2lJPt
 y3qLXeLGaJ71A==
Date: Wed, 01 Jul 2026 09:23:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, kernel@collabora.com, 
 tzimmermann@suse.de, chunkuang.hu@kernel.org, simona@ffwll.ch, 
 linux-arm-kernel@lists.infradead.org, jason-jh.lin@mediatek.com, 
 airlied@gmail.com, conor+dt@kernel.org, maarten.lankhorst@linux.intel.com, 
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, 
 mripard@kernel.org, devicetree@vger.kernel.org, justin.yeh@mediatek.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-24-angelogioacchino.delregno@collabora.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-24-angelogioacchino.delregno@collabora.com>
Message-Id: <178291581273.4115171.8214844308967079622.robh@kernel.org>
Subject: Re: [PATCH 23/42] dt-bindings: display: mediatek: Introduce
 Digital Video Output HW
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


On Wed, 01 Jul 2026 14:20:38 +0200, AngeloGioacchino Del Regno wrote:
> Add documentation for the Digital Video Output (DVO) IP found in
> the newer generation SoCs MT8196, MT8189 and their variants.
> 
> This is effectively a more capable block replacing the DisplayPort
> Interface (DPI/DP_INTF) one found in older SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mt8196-dvo.yaml | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: ignoring, error in schema: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml: properties:compatible: [{'const': 'mediatek,mt8189-dp-dvo'}, {'const': 'mediatek,mt8189-edp-dvo'}, {'const': 'mediatek,mt8196-edp-dvo'}] is not of type 'object', 'boolean'
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 66, in main
    ret |= check_doc(f)
           ~~~~~~~~~^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 37, in check_doc
    dtsch.check_schema_refs()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 242, in check_schema_refs
    self._check_schema_refs(resolver, self)
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
    self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
    self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 203, in _check_schema_refs
    ref_sch = resolver.lookup(schema['$ref']).contents
              ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 422, in get_or_retrieve
    registry = self.crawl()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 500, in crawl
    id = resource.id()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 231, in id
    id = self._specification.id_of(self.contents)
  File "/usr/local/lib/python3.13/dist-packages/referencing/jsonschema.py", line 50, in _dollar_id
    return contents.get("$id")
           ^^^^^^^^^^^^
AttributeError: 'list' object has no attribute 'get'
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.example.dtb: /example-0/dvo@324c0000: failed to match any schema with compatible: ['mediatek,mt8196-edp-dvo']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701122057.19648-24-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

