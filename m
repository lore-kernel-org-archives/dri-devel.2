Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E020C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9512E10F95F;
	Fri,  4 Sep 2026 08:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jTGjJxP1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C72610F95F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:33:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E16B34381E;
 Fri,  4 Sep 2026 08:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5851F00A3D;
 Fri,  4 Sep 2026 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788510796;
 bh=y/nk14eD2Y0cqgzJGSt+5FjulJ5arXb8251Zy5w04Iw=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=jTGjJxP1aBNnB3vfu+LiWsWU/lVajEblCXSl6iHSZYPp6UGTE3BXo0Lhh/051QHsO
 m/Zfk2EEsmpNzwD9Aqi1DUj6G3uRFNtsdw8PbyDBmpItS8Y3BWj0mBINDbfLeCQdmY
 3J1I0N0AgAmwOAwdxYhNuc7UQbRMiHeFtxBSylUiCjTD0Nz9EZ94pU6GxRuRhoSs2C
 Ukwy/s3zDvBp98es3I477+izGPFpiWvGSeEXnfwu2SnRiEI8ChwSM41P3ZmOw8gxrP
 Vg/Z3Pj0ND9N3DtjqfssIcordwH/hBx8xjC/SBYeBvJUG5hSPwUcwyBe9eDKSv2gAB
 mEBaOcdLb+gSw==
Message-ID: <d6323392130ed13cc5d1da8c2165115d@kernel.org>
Date: Fri, 04 Sep 2026 08:33:13 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>
Subject: Re: [PATCH v6 09/13] drm/imx: dc-lb: Support getting secondary
 input selection
In-Reply-To: <20260904-imx8-dc-prefetch-v6-9-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-9-26643e3f6cb7@nxp.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Conor
 Dooley" <conor+dt@kernel.org>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, "Fabio Estevam" <festevam@gmail.com>, "Frank
 Li" <Frank.Li@nxp.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marek Vasut" <marek.vasut@mailbox.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Rob Herring" <robh@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
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

On Fri, 4 Sep 2026 15:54:59 +0800, Liu Ying wrote:
> Add a helper to get LayerBlend secondary input selection.  This is
> needed by disabling CRTC at boot in an upcoming commit which tries
> to get the selection.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
