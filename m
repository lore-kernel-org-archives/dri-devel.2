Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D16C5ACD1
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 21:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8F510F45B;
	Fri,  7 Aug 2026 21:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dxyVmbv0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4E710F45B
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 21:44:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F8CC43275;
 Fri,  7 Aug 2026 21:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68071F000E9;
 Fri,  7 Aug 2026 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786139076;
 bh=Y/9ImKFoNMIcoQEcOSmOHrcaraP4OwByegPOmnFIMnE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dxyVmbv0H/ByiHbYR4KNac0YRew95e8AxTzHIrPSCeXrtaduLfP3oYh+0tgKEl7Hz
 UHbGtgO2+BpYOEufOgDr77bXh0F7XnAFO0ObnA+uxg9JSOofhqC1daY26giudThEyZ
 myNSyxBKxWlgOEbSYi8z2ZCAv+LvJl+JfKq7Q8u82/j5xCdfX/4OSHEot7KG+k/oNO
 ctSpozzl5LqDODS/SEhRzOTNVwEmm7tcuz2A1VOFlCU0Zb6Ny+9T5XeA9pYLAoFn/6
 rhSbF4YGFzJbpxpiMnXBW5H1cSfd6E1IJ8eDkFZZgMqVqdIlGl84bDZPd1NmMiqtPz
 kAzgLfxICI2Zg==
Date: Fri, 7 Aug 2026 16:44:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Marek Vasut <marex@denx.de>,
 devicetree@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 Stefan Agner <stefan@agner.ch>, Peng Fan <peng.fan@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev
Subject: Re: [PATCH v3 2/4] dt-bindings: soc: imx-iomuxc-gpr: allow bridge@18
 as child node
Message-ID: <178613907482.2073714.15421440412830681192.robh@kernel.org>
References: <20260723-arm_dts_ldb-v3-0-96c784b2b84f@nxp.com>
 <20260723-arm_dts_ldb-v3-2-96c784b2b84f@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-arm_dts_ldb-v3-2-96c784b2b84f@nxp.com>
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


On Thu, 23 Jul 2026 15:14:16 -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> The legacy i.MX6SX (>15 year) SoC imx-iomuxc-gpr contains one LDB_CTRL
> register. Allow the LVDS Display Bridge(LDB) child node under
> imx-iomuxc-gpr.
> 
> Fix below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dtb: syscon@20e4000 (fsl,imx6sx-iomuxc-gpr): '#address-cells', '#size-cells', 'bridge@18' do not match any of the regexes: '^ipu[12]_csi[01]_mux$', '^pinctrl-[0-9]+$
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v3
> - add ranges
> 
> changes in v2
> - remote status = "disabled" in example
> ---
>  .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

