Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5572AC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 18:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B20D010E2F4;
	Fri, 17 Jul 2026 18:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z36jQ+nx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA6010E2F4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 18:44:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E28543727;
 Fri, 17 Jul 2026 18:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180351F000E9;
 Fri, 17 Jul 2026 18:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784313889;
 bh=GDf0SHTCTXzajyFneAnVkXteY4zVvuU8fcfR6nj7tFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z36jQ+nxUJfkvV9idRAd2w0tSjY+NJGePRRNPqyp+IDVeGeJG/EX/8CtX+CPfGAAG
 DmSFUaF0YhEtKkItXGVn433F6SJQYsAW0Cd6lQQZ/ZWe8b1qr90c5OZCmdTlWtdT9d
 LhumZWncdKSvi3J0BEInpl42oTIFfwHpDOIjpdKmiuoAk/5vbxH837ZweYRSrQcoDA
 9NgmfhV1a3MaLX6S4Lp+sqPThmNgTFTDao15RQ2S0YHmWl6duMzSHhajxK7u3buv0f
 pqOWkgbhkc+9MZZ8iFYbDJ2Rh1AbcH32SK6inzi1vOCWy9G0rkV7MoiS3sU4Yjtyqc
 0qvWP8uJ0foxg==
Date: Fri, 17 Jul 2026 13:44:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 Stefan Agner <stefan@agner.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Marek Vasut <marex@denx.de>,
 Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/4] dt-bindings: display: bridge: ldb: allow a single
 reg for fsl,imx6sx-ldb
Message-ID: <178431388818.1805043.6740193643637538952.robh@kernel.org>
References: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
 <20260708-arm_dts_ldb-v1-1-4f5579b85797@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-arm_dts_ldb-v1-1-4f5579b85797@nxp.com>
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


On Wed, 08 Jul 2026 16:29:02 -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> The i.MX6SX LDB only provides a single register region for the LDB block,
> while other supported LDB variants require two register regions.
> 
> Update the binding schema to allow a single reg entry for
> fsl,imx6sx-ldb while keeping the existing constraints unchanged for the
> other compatible strings.
> 
> Fix below DTB_CHECK warings:
>   arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dtb: bridge@18 (fsl,imx6sx-ldb): reg: [[24, 4]] is too short
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Related two theads:
> - https://lore.kernel.org/imx/178154922879.1630652.11500293336634076421.robh@kernel.org/
> 
> Mixing the addressable and non-addressable child nodes is allowed according to discussion [1].
> 
> Link: https://lore.kernel.org/all/n6akxiayi3g6gxcqhreb4iaohmeokoalnqup6h5r2fwdt4zijt@u2wyps55ayqm/ [1]
> ---
>  .../bindings/display/bridge/fsl,ldb.yaml           | 23 +++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

