Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXjqU6og
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC2210E10F;
	Thu, 29 Oct 2026 10:28:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBFC1121C1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:28:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9704041826;
 Thu, 29 Oct 2026 10:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419581F031E0;
 Thu, 29 Oct 2026 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793269709;
 bh=/vsZY35nyyIyyWum22pVmxNwi1a+fiR4TsLkd0bXqWk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JXjqU6og+o2MkJNzRwGG4mxXFYkFSfKAjtjGzkAl1uJIXwQPqM5BHDXq7VY+dH0VI
 7b292W7ToAuL3YghwIw/v/tBXKMKHgiG0k9RgUnuO/mYoC9x+gp1G2H7zSZa9AGMcT
 tHJDL3Q1VWrbgsvvSjwQu8EzWGjgbDrA81cpm2CeDlIM8YALMO2qgRPicL0jta5E8Z
 3XOiUQUSl8erX8OpyU/YBuEtOme35Fiy+nUuDgIJHiZLb/U9Gh7TbG8FyJQGlLA+1k
 jUSQryWcfrvppzZ8geOSwVqj6V347Wsfrvg0WYU0L+2yP9OluJv60C6kEv/G7fvhVw
 GQboOkWLfr8eA==
Message-ID: <sashiko-outbox-189132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/14] arm64: dts: ti: k3-am62p-j722s-common-main:
 Add support for DSS
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-beagley-ai-display-v4-13-dc7f2b532478@ideasonboard.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
 <20261029-beagley-ai-display-v4-13-dc7f2b532478@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:28:28 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64: dts: ti: missing cbass_main ranges for DSS1, DSI0, and DPHY=
 on AM62P
--

commit c11e92d40644178d0a46e3ee6a4f0ebbf85859f3
Author: Jayesh Choudhary <j-choudhary@ti.com>

arm64: dts: ti: k3-am62p-j722s-common-main: Add support for DSS

This commit adds device tree nodes for DSS0, DSS1, OLDI0, OLDI1, DPHY, and
DSI to the shared k3-am62p-j722s-common-main.dtsi file along with the fixed
factor OLDI pixel clock dividers in k3-am62p.dtsi and k3-j722s.dtsi.

> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arc=
h/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> index f130c7cb998d7..ae8db1bccadd5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
[ ... ]
> @@ -1111,6 +1116,63 @@ dphy0: phy@30110000 {
>  		status =3D "disabled";
>  	};
> =20
> +	dphy_tx0: phy@301c0000 {
> +		compatible =3D "ti,j721e-dphy";
> +		reg =3D <0x0 0x301c0000 0x0 0x1000>;
[ ... ]
> +	};
[ ... ]
> @@ -1119,6 +1181,54 @@ vpu: video-codec@30210000 {
>  		power-domains =3D <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
>  	};
> =20
> +	dss1: dss@30220000 {
> +		compatible =3D "ti,am62p-dss";
> +		reg =3D <0x00 0x30220000 0x00 0x1000>, /* common */
> +		      <0x00 0x30222000 0x00 0x1000>, /* vidl1 */
> +		      <0x00 0x30226000 0x00 0x1000>, /* vid */
> +		      <0x00 0x30227000 0x00 0x1000>, /* ovr1 */
> +		      <0x00 0x30228000 0x00 0x1000>, /* ovr2 */
> +		      <0x00 0x3022a000 0x00 0x1000>, /* vp1: Used for DPI/OLDI */
> +		      <0x00 0x3022b000 0x00 0x1000>, /* vp2: Used for DPI/DSI */
> +		      <0x00 0x30221000 0x00 0x1000>; /* common1 */
[ ... ]
> +	};
> +
> +	dsi0: dsi@30500000 {
> +		compatible =3D "ti,j721e-dsi";
> +		reg =3D <0x0 0x30500000 0x0 0x100000>, <0x0 0x30270000 0x0 0x100>;

[Severity: High]
Are the cbass_main bus ranges in arch/arm64/boot/dts/ti/k3-am62p.dtsi
missing entries for dphy_tx0, dss1, and dsi0?

The nodes dphy_tx0 (0x301c0000), dss1 (0x30220000), and dsi0 (0x30500000
and 0x30270000) are added under cbass_main in
arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi.

While arch/arm64/boot/dts/ti/k3-j722s.dtsi defines ranges in cbass_main
for all of these regions:

			 <0x00 0x301c0000 0x00 0x301c0000 0x00 0x00001000>, /* DPHY-TX */
			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00080100>, /* CSI window */
			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
			 <0x00 0x30210000 0x00 0x30210000 0x00 0x00010000>, /* VPU */
			 <0x00 0x30220000 0x00 0x30220000 0x00 0x00010000>, /* DSS1 */
			 <0x00 0x30270000 0x00 0x30270000 0x00 0x00010000>, /* DSI-base1 */
			 <0x00 0x30500000 0x00 0x30500000 0x00 0x00100000>, /* DSI-base2 */

arch/arm64/boot/dts/ti/k3-am62p.dtsi only has the range for DSS0
(0x30200000) and VPU (0x30210000) in cbass_main:

			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
			 <0x00 0x30210000 0x00 0x30210000 0x00 0x00010000>, /* VPU */
			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core wi=
ndow */

When dphy_tx0, dss1, or dsi0 is enabled on an AM62P board, address
translation via of_device_alloc() -> of_address_to_resource() ->
of_translate_address() -> of_translate_one() will fail to find a matching
range in cbass_main, trigger a WARN_ON(rc) in of_device_alloc(), and cause
driver probe to fail when mapping the memory resources.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-beagley-ai=
-display-v4-0-dc7f2b532478@ideasonboard.com?part=3D13
