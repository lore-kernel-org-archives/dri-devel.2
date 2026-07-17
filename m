Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C138C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E738E10E43F;
	Fri, 17 Jul 2026 08:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UnpzyVlY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E6210E43F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:59:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4626260A63;
 Fri, 17 Jul 2026 08:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96B41F000E9;
 Fri, 17 Jul 2026 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784278747;
 bh=yCccH1sP9kHlyJzjFraPq2Rr2KbVK6Uk4HI9sVzHJ9E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UnpzyVlY6ZxBFNTNullwtqpOdBhFXSZX4GGXMy4Wq/F+bS4gzcyJVUMv2c66orqJm
 8CMqd+bhKl6DnRXf9kEIFbfF18+j7lEyck+uHm4SPHYZ4XC/ENmbJz+35+JVp5E7pn
 0qVoV297Ku84xEmiIz9Pa6xiqkuBbJ3idBX3UZOGtyQ2VlQbUFnpB5FKq/dBMFqCXf
 JKr+s1I1HfURJ4sDBBxabIx19Yj/rNaD7DVpY4ALrctb++gnpbC60RA9sQRDWDxho0
 XkPzytwZQCScuNKlSztlgeJqzEnhZpNlrZCUsLdUPd3h99Fu1wTANcWQ4GHz+7nrDx
 wXClRj2TkSGFA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/9] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260717085220.3212274-2-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
 <20260717085220.3212274-2-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 08:59:06 +0000
Message-Id: <20260717085906.A96B41F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing `sram-supply` from the global `required` list makes it =
optional for `rockchip,rk3588-rknn-core`, incorrectly weakening schema vali=
dation for existing RK3588 hardware.
--

--- Patch [1]: [RFC PATCH 1/9] dt-bindings: npu: rockchip: add rockchip,rk3=
576-rknn-core ---
commit 9a2dabf1434398eb090f8e36b12d42467c86de03
Author: Jiaxing Hu <gahing@gahingwoo.com>

dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core

This commit documents the RK3576 NPU core by adding the new compatible
string rockchip,rk3576-rknn-core. It also drops sram-supply from the global
required list since the RK3576 has no NPU SRAM supply.

> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.=
yaml
> index caca2a4903cd1..d904db3bf9281 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
[ ... ]
> @@ -75,7 +76,6 @@ required:
>    - resets
>    - reset-names
>    - npu-supply
> -  - sram-supply

[Severity: Medium]
By dropping sram-supply from the global required list to accommodate the
RK3576, does this incorrectly weaken schema validation for existing
RK3588 hardware?

If an RK3588 device tree node is missing the sram-supply property, it
appears it will now silently pass make dtbs_check validation.

Could this instead use an allOf block with an if-then conditional to
enforce the sram-supply requirement specifically when the compatible string
is rockchip,rk3588-rknn-core?

> =20
>  additionalProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717085220.3212=
274-1-gahing@gahingwoo.com?part=3D1
