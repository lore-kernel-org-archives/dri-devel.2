Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A588DCD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 21:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F6810E4C8;
	Mon, 15 Jun 2026 21:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f2snKoPo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F82910E4C8
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 21:04:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3E1560172;
 Mon, 15 Jun 2026 21:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728481F000E9;
 Mon, 15 Jun 2026 21:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781557475;
 bh=4b0Lv74/nBILk2gIMYWUm6i3SoTaSg4GpRxXNoby7dE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=f2snKoPoB7CwlS7KzqRFdoObM/38la6po2Kp5PWfB8qUzXHJ7XEvm+T0D7AOk8ofj
 zItneTSHyEJIJzLhdCGE9qPCSyykot/o54R3ctVUIme7V9qXDtxjb0XsTBpY/5fnIb
 9OkOeybaXMpaG+mfcB/ob6KHmJZu9QLZNl0Utc/DALIZZSerMOK85bUpv7VdpklzwF
 SAaEUCvo0iba0yAhcjRHytmxWNsqFl7o6RV055yko/bwBKbD3w6bmOFXFCIUjiOHhD
 qZlnmHo1y2SXxmlAl91AoR9BMuwC4ypUNB1kXUoLsxiJ0Qx7F8gpM3bBOrXal05L2J
 Ow0qzPJQT6s5w==
Date: Mon, 15 Jun 2026 16:04:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Fabio Estevam <festevam@gmail.com>, David Airlie <airlied@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Ying Liu <victor.liu@nxp.com>
Subject: Re: [PATCH v9 4/9] dt-bindings: display: imx: Add i.MX94 DCIF
Message-ID: <178155747196.1679059.5104272619144115714.robh@kernel.org>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
 <20260612-dcif-upstreaming-v9-4-8d0ff89aa3c5@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-dcif-upstreaming-v9-4-8d0ff89aa3c5@oss.nxp.com>
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


On Fri, 12 Jun 2026 14:58:35 +0300, Laurentiu Palcu wrote:
> DCIF is the i.MX94 Display Controller Interface which is used to
> drive a TFT LCD panel or connects to a display interface depending
> on the chip configuration.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx94-dcif.yaml       | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

