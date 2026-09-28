Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C180EC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0C510E0A6;
	Mon, 28 Sep 2026 11:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Rxelkcja";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5874110E0A6
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:40:30 +0000 (UTC)
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 692D21FCAD;
 Mon, 28 Sep 2026 13:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1790595627;
 bh=ck+TzNVilqQY/t61zy/0IPuuHN9u4piAsUrgySTcPUs=; h=From:To:Subject;
 b=RxelkcjaRglR3eb2moD+QraCo7PnUyVi/lf+U/cFdD3THIO9n9mylKZp73EuOyyut
 5ocDi2VCuvtdt7gyFEvLG5s94oX0jVT1W0rIQvqjuJw+JFGr7SbLIHDJe+zyz7p7b8
 JZXWmQoIQpl2WFqNOrgaQwj9I23fxizVRLlnOKq6Zxc/jr2vimC+pzQYuCWaishCCe
 30QxymNkbJNqitbj7E5BhLoe6NrBVDENaVe2YGhzAIJvJiQXbRNQ2ECpKYmfn4Ar5j
 2SI8yxIvZNRelfBXdePXtKtG4M3EI3Pg0BYZF18yyS/VKPe8DaUgLO0Yeb89aqjV8/
 0QdpeUkZPFlMw==
Date: Mon, 28 Sep 2026 13:40:22 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Subject: Re: [PATCH v5 0/4] drm: mxsfb: Support LCDIF interface bus width
Message-ID: <20260928114022.GA67479@francesco-nb>
References: <20260917140042.118181-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917140042.118181-1-francesco@dolcini.it>
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

Hello,

On Thu, Sep 17, 2026 at 04:00:35PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The width of the physical LCDIF output bus can differ from the input bus
> format advertised by the downstream panel or bridge.


Can the first two patches be picked-up by some DRM bridge maintainer
(Luca?), so that once they are in next, Frank can pick-up the two DT
patches?

Thanks a lot, appreciated
Francesco

