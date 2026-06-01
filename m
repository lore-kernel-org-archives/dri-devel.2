Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CB4CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DE1112CF3;
	Mon,  1 Jun 2026 02:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BgzRNauK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF81112CF3
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 02:16:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 466AE42E05;
 Mon,  1 Jun 2026 02:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050941F00893;
 Mon,  1 Jun 2026 02:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780280163;
 bh=yP/TRVjC/7Q9E9T3KmokV8Ki6NrjRZ4h0baPgK9eilk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BgzRNauKAd9kY/bAeTwLzMQaFgF1dSIweh7ys5pMWuiIQerJZF9XxyxTWVlhwq+5X
 NQKUlO5n3hsLxbATQw0YgNf5/8niuKa6uzklYKLdKb16N62sda1KSST4CbLPb7J6UL
 gA2UT0cXHWb+ogTQYjy8iCl+P+zflSSsXAvp9Ru1/hZyEjlAUB/pGJLXYSfWEVf1x4
 Pt5Oj14jlGp931fYhNtvBLeCroyfwewEUxXYb8m2RTuhKhndXbURP6MM3NvZFm0fM1
 3QfVYRtdzPK/S6eJdIWAqY2b2qbYKA2Ueyo9CFfmDhQ40o+bw9S39Io3+O/jpsjEAu
 FgCThEsTkxI8w==
Date: Sun, 31 May 2026 21:16:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank Li <Frank.Li@nxp.com>, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/1] dt-bindings: display: imx: Add television encoder
 (TVE) for imx53
Message-ID: <178028016047.3956673.12104802707727267478.robh@kernel.org>
References: <20260521193734.1496372-1-Frank.Li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521193734.1496372-1-Frank.Li@oss.nxp.com>
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


On Thu, 21 May 2026 15:37:32 -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add television encoder (TVE) for legacy i.MX53 (over 15 years) to fix below
> DTB_CHECK warnings:
>   arch/arm/boot/dts/nxp/imx/imx53-ard.dtb: /soc/bus@60000000/tve@63ff0000: failed to match any schema with compatible: ['fsl,imx53-tve']
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v2
> - add Krzysztof Kozlowski's review tag
> - move fsl,tve-mode to required list
> 
> About cleanup 300 lines warnings for i.MX ARM platformi
> ---
>  .../bindings/display/imx/fsl,imx53-tve.yaml   | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx53-tve.yaml
> 

Applied, thanks!

