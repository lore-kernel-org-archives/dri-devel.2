Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB75C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983C810F4A9;
	Fri, 18 Sep 2026 18:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ISTnT5yX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C26710F4A9
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:11:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A04743DE7;
 Fri, 18 Sep 2026 18:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019901F00898;
 Fri, 18 Sep 2026 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789755118;
 bh=JC/cRxDOyPKDWV1arwY+zVR3OW2f4SfnaV443OZvB1o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ISTnT5yXc2TSOXTbV+KOQohIwrgru2ySHdIA7HrXbPq/kqAYa2xWBw708QsBOLnn/
 POeCOdprpZbIU9+2HSsM8vGbCXu/foHKzP41iZ7r4Hbl5px4njAvB+XJs4wWrRcgHb
 3jGkcsv9yGwjTc0X8pPKSjPwvYY2KDMcDOSdaDYEJ/qQO31dPv7sMDWTXWLK4xxerN
 2EfPC63NOtFROSQ30M0v7s5Jb7rqhVfWk48/QgF6nDURbKufGCKuwV0Xbn7xYfMcgX
 x4htLMYJOjhWMTczpnVPBu4II6kJB8Bc1NQTtCnEbe3aPuw95NgUgICB01TahoILZ+
 ET3f7cIrVz8yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: mt8167: Add DRM nodes
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260918175736.355305-5-l.scorcia@gmail.com>
References: <20260918175736.355305-1-l.scorcia@gmail.com>
 <20260918175736.355305-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:11:57 +0000
Message-Id: <20260918181158.019901F00898@smtp.kernel.org>
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
- [High] drm/mediatek: OF graph traversal fails probe due to disconnected r=
dma0_out
--

commit 09e4433abd1ea0bcfece829092d5582ffb8243ec
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

arm64: dts: mediatek: mt8167: Add DRM nodes

Add all the DRM nodes required to get DSI and DPI to work on MT8167 SoC.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8167.dtsi
> index 27cf32d7ae35f..a50bae4307c16 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi

[ ... ]

> @@ -120,10 +136,325 @@ iommu: m4u@10203000 {
>  			#iommu-cells =3D <1>;
>  		};

[ ... ]

>  		mmsys: syscon@14000000 {
>  			compatible =3D "mediatek,mt8167-mmsys", "syscon";
>  			reg =3D <0 0x14000000 0 0x1000>;
> +			power-domains =3D <&spm MT8167_POWER_DOMAIN_MM>;
>  			#clock-cells =3D <1>;
> +
> +			port {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				mmsys_main: endpoint@0 {

[Severity: High]
Does adding this port to mmsys cause the mtk_drm probe to fail unconditiona=
lly
on existing boards?

By adding this port, mtk_drm is forced to use OF graph traversal instead of
its legacy hardcoded array fallback. This opts the device into graph parsin=
g,
making the disconnected rdma0_out a fatal probe failure instead of falling
back to legacy arrays. This occurs unconditionally on boot for any MT8167
board that does not explicitly define the connection in its .dts file (such=
 as
the existing mt8167-pumpkin.dts).

> +					reg =3D <0>;
> +					remote-endpoint =3D <&ovl0_in>;
> +				};

[ ... ]

> +		rdma0: rdma0@14009000 {
> +			compatible =3D "mediatek,mt8167-disp-rdma", "mediatek,mt2701-disp-rdm=
a";
> +			reg =3D <0 0x14009000 0 0x1000>;
> +			clocks =3D <&mmsys CLK_MM_DISP_RDMA0>;
> +			interrupts =3D <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
> +			iommus =3D <&iommu M4U_PORT_DISP_RDMA0>;
> +			power-domains =3D <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				port@0 {
> +					reg =3D <0>;
> +					rdma0_in: endpoint {
> +						remote-endpoint =3D <&dither_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg =3D <1>;
> +					rdma0_out: endpoint { };
> +				};

[Severity: High]
Will the missing remote-endpoint at rdma0_out cause the OF graph traversal =
to
fail?

The traversal algorithm in mtk_drm_of_ddp_path_build_one walks the endpoint=
s.
Because rdma0_out lacks a remote-endpoint property,
of_graph_get_remote_port_parent() returns NULL, causing
mtk_drm_of_get_ddp_ep_cid() to return -EINVAL.

Since rdma0 is not a valid final display output, the pipeline build fails w=
ith
-EINVAL and breaks display and DRM driver initialization. If rdma0_out had
been properly connected to dsi_in in the .dtsi (which is disabled by defaul=
t),
mtk_drm_of_get_ddp_ep_cid() would have safely returned -ENODEV, allowing the
probe to succeed.

> +			};
> +		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918175736.3553=
05-1-l.scorcia@gmail.com?part=3D4
