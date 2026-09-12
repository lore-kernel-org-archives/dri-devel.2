Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C96C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B488610E42C;
	Sat, 12 Sep 2026 07:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LxGJsAHr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B9710E42C
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:02:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CCE0600D4;
 Sat, 12 Sep 2026 07:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4201F000FF;
 Sat, 12 Sep 2026 07:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789196570;
 bh=LmrPmsYp6MSL7jNbxOBz/TwjFifdaJKw/HSV7epDhY4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LxGJsAHr/pdnpEl4b3dKvhCoRaIx3mPBOXblGI8lWUOUq0D68YuFSF0sJfEI3IUIP
 JYYS0mjaJOmzlZsrRw8P+CtzqCJbBeRjNOBBXeLDVvwUybi9yUWWu3Jcl5XFfhQqdf
 +TahE/iP1f9pMMXH/+SSAMXjyswhv7TkW2ibloIANKhtLF1XyVEAFU0WJnS8fRdFtt
 AZ8NrifKSvIK7x+lTgv6YkCDM+WAOmFjMwotIV987kq5OXXvkjHt77wB0FNklA7kHI
 zXe5EtmdYwBVce4HBIiQuhU4P1fKj9VWWWl3Wk4eLXE54bd0f/sXuHOSAJ9TXfh7Vl
 XfILx7fs0cPiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/14] dt-bindings: iommu: rockchip: describe the
 RK3576 NPU MMU
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260912065053.1519165-9-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
 <20260912065053.1519165-9-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 07:02:50 +0000
Message-Id: <20260912070250.8C4201F000FF@smtp.kernel.org>
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
- [High] The `rockchip,rk3568-iommu` fallback compatible string is invalid =
for `rockchip,rk3576-npu-iommu` because older OS drivers binding to the fal=
lback will only enable 2 clocks, causing device failure.
--

commit 0d5ec29abf5273f66b488bef225aa90e06766258
Author: Jiaxing Hu <gahing@gahingwoo.com>

dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks where
every other Rockchip MMU takes two, the extra three being the compute clock
and the two convolution buffer clocks.

> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml =
b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index 6ce41d11ff5e5..83d7e7c8e0c22 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -26,6 +26,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,rk3576-iommu
> +              - rockchip,rk3576-npu-iommu
>                - rockchip,rk3588-iommu
>            - const: rockchip,rk3568-iommu

[Severity: High]
Is rockchip,rk3568-iommu a safe fallback compatible string for
rockchip,rk3576-npu-iommu?

If an older kernel (e.g., prior to the July 2026 driver update introducing
devm_clk_bulk_get_all) boots with an updated device tree, it will bind to t=
he
rockchip,rk3568-iommu fallback. The older driver hardcodes requests for onl=
y 2
clocks (aclk and iface) and leaves the 3 required NPU clocks disabled during
register access.

On Rockchip SoCs, accessing registers with disabled clocks typically causes=
 a
bus hang or synchronous external abort, panicking the system. Does this
violate device tree backward compatibility guarantees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912065053.1519=
165-1-gahing@gahingwoo.com?part=3D8
