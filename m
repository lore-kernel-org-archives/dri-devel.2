Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6871CA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDD710E972;
	Thu,  8 Oct 2026 19:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="boTpVs5s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D0B10E972
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 19:43:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A77B260DAD;
 Thu,  8 Oct 2026 19:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAE91F000FF;
 Thu,  8 Oct 2026 19:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791488600;
 bh=NZwiRd4JpA+xTYM34D1mENI6YZR63Qw0QaDPwvT4gzE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=boTpVs5sF+REI2wKV5fSoTw2NWmn+MTdUsV/8j/fV/Nw4dRGKlsFHFR0Nx4LJ16NZ
 Ax/cHogE88gT4jo3fgQzHeM2vkhUtNyRCQEEYcdLoZa4FNOJI9fKe27kqopb2p6Bo4
 VGohsikO1syqPowOqLywR3Nr1y7HWZc5JVKSOM16OVjwm3ctohb1H56/TTVp0txYUn
 eYs8Iux1PisgmhrQnC4XHe29eFEI8WK+NnK3nV9Zsnyqs8bhMgBArCNvC4WLpcIWQu
 oI3ND69q7obsnboE6+ghfIPaguaZODFJH3Bf6YT3qmctBiEknkMucYol8qwhMmmBRk
 8Ph/den9jgvrA==
Date: Thu, 8 Oct 2026 14:43:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 devicetree@vger.kernel.org, upstream@lists.phytec.de,
 linux-arm-kernel@lists.infradead.org, David Airlie <airlied@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Sam Ravnborg <sam@ravnborg.org>, Frank Li <Frank.Li@nxp.com>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel-simple: Allow
 "data-mapping" for "auo,g104sn02"
Message-ID: <179148859709.884257.1016647053232080228.robh@kernel.org>
References: <20261008053850.2941955-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008053850.2941955-1-primoz.fiser@norik.com>
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


On Thu, 08 Oct 2026 07:38:49 +0200, Primoz Fiser wrote:
> As per the AUO G104SN02 datasheet, section 6.4.1 "SEL68", this panel's
> SEL68 pin selects between 6 bits (SEL68 low/NC) and 8 bits (SEL68 high)
> per color over LVDS, i.e. an 18-bit or a 24-bit input format.
> 
> Currently, the auo_g104sn02 panel_desc only allows for the 24-bit
> configuration by default. Boards wired for the 18-bit configuration need
> the override introduced by commit 1cd3ea3e4b12 ("drm/panel-simple: allow
> LVDS format override")) to describe that instead.
> 
> Thus allow "data-mapping" override for "auo,g104sn02" in the schema.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

