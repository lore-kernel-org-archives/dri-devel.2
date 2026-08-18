Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581D4C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565AC10E077;
	Tue, 18 Aug 2026 23:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j/Z+JW4e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5616310E077
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:09:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45754601DE;
 Tue, 18 Aug 2026 23:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08901F000E9;
 Tue, 18 Aug 2026 23:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787094558;
 bh=B2rI3b8Hia0vW/fa4o3rfnpG+Pj+Dz6m9hUtKiuIVMA=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=j/Z+JW4eF5i8XfXi6M+/mKNpwaMAMODOHQT8SFusgY5fdkEatnADBM7Qas860H2yH
 upzwxOdrb/zsix7A6tyuhp/j6nCW6wDoeUmHOP8oluGm4lOAlZzkcVMnp6Prk71NW8
 GY+Bl1B52OJ5nqyhickvKFJ+U7nWCtAOxdfkNVq0XFg+w01h4ip5N9YO9PUgDRVDyY
 JOBWRGyPSyju2XrHbP2YN7AltitifSQtE9s/aTr9mRkuUU64swBlmdOy8TdmootFl4
 qMe/tgRLjkJOIca2Juc8bYDy66XYKvJojMopIc0skNKkA8iL7oL5/sO98GgWNAWl36
 2Kko/la8nfTQQ==
Date: Tue, 18 Aug 2026 18:09:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, tomeu@tomeuvizoso.net, 
 p.zabel@pengutronix.de, ulfh@kernel.org, will@kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 conor+dt@kernel.org, chaoyi.chen@rock-chips.com, 
 dri-devel@lists.freedesktop.org, zhangqing@rock-chips.com, 
 linux-arm-kernel@lists.infradead.org, joro@8bytes.org, 
 devicetree@vger.kernel.org, iommu@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, krzk+dt@kernel.org, alchark@flipper.net, 
 ogabbay@kernel.org, royalnet026@gmail.com, diederik@cknow-tech.com, 
 robin.murphy@arm.com, heiko@sntech.de
To: Jiaxing Hu <gahing@gahingwoo.com>
In-Reply-To: <20260817113603.1436067-5-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-5-gahing@gahingwoo.com>
Message-Id: <178709455518.1014304.1443906758035976924.robh@kernel.org>
Subject: Re: [PATCH v8 04/12] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
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


On Mon, 17 Aug 2026 23:35:55 +1200, Jiaxing Hu wrote:
> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
> already describes, but it wires them up differently: two extra CBUF
> clocks, two power domains per core, and a single reset instead of two.
> It also has no NPU SRAM supply.
> 
> Widen the property ranges to cover both, then pin each SoC back to its
> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
> required for rockchip,rk3588-rknn-core only.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml: Unresolvable reference: /schemas/input/qcom,spmi-haptics.yaml#

doc reference errors (make refcheckdocs):
Documentation/translations/pt_BR/process/security-bugs.rst: :doc:`regular path submission </../../../process/submitting-patches>`
Documentation/translations/zh_CN/how-to.rst: Documentation/translations/zh_CN/xxx.rst
arch/arm/xen/enlighten.c: Documentation/devicetree/bindings/arm/xen.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260817113603.1436067-5-gahing@gahingwoo.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

