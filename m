Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D6DC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EE710F965;
	Fri,  4 Sep 2026 08:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G8qDtKLs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB68910F965
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:36:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDC9660A8D;
 Fri,  4 Sep 2026 08:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3F91F00A3D;
 Fri,  4 Sep 2026 08:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788510980;
 bh=EARuoU2+4Ppoh54rAYFHVilx3BHYziNxsbRS7f9DEMY=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=G8qDtKLsfO5uMyax8B940NgODoxvvXXWhkN5OLQuKDcYFhH0CmeyRV2haSxb4LG7r
 MWSZsjXuzaG8vD/O/3jJvdMTlxYrsDfDWKGL2W9Q+AcdMqvt77uFbeWDDaasQyJnqU
 /ynXB1GjWw6KKQ8SSbsZQ/q43Eah1Qqzl92vO4wz6IlwenlJAPTNU/JYMFJ/Yf0XFC
 XAYUXkuVqpq6U/9dsPVEsY7h6ZPQ5DtCOMCIHMBsY5jIhW19m5HplwlhJ+ZAScasti
 U+RWvxHTlSJ0G15qbEZn4lU2AAEP+BbdZPg9md32G3USyPeb4oQEC4l6t4RlycdAXI
 Zm7UAgNa4yiiQ==
Message-ID: <66a60c26351f41e6c9660f1f18cea9f5@kernel.org>
Date: Fri, 04 Sep 2026 08:36:17 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>
Subject: Re: [PATCH v6 12/13] drm/imx: dc-fu: Get DPR channel
In-Reply-To: <20260904-imx8-dc-prefetch-v6-12-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-12-26643e3f6cb7@nxp.com>
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

On Fri, 4 Sep 2026 15:55:02 +0800, Liu Ying wrote:
> Add a helper dc_fu_get_dprc() to get DPR channel for FetchUnit.
> And, call it from dc_{fl,fw)_bind() to get DPR channels for
> FetchLayer and FetchWarp.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
