Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9CCFD5F8F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9A810E554;
	Wed,  8 Apr 2026 07:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BeqOcXhZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6338210E556
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:49:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AF656011F;
 Wed,  8 Apr 2026 07:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C8FC19424;
 Wed,  8 Apr 2026 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775634556;
 bh=Jv086wRCTgDQEnk5xBJcqY/wA8Jo7MQuTSmZDLrN9R4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BeqOcXhZmUB350qlMNwuUtGnfMfb+r0SMedeLQzQbeaVs5sigCt5di9z+Kga2Zk7A
 fgatcOiE5u6PZMk5o8Vts61Y/atvLsycs8ApIDv0pZal6YyGumIZ25stwWJRBgv2mU
 QE1aGy6itQstaR+VdHStJ5B0nsUiIxafSy88Um0KsLK+7b54k7/DkXM/LsYnKB9hl9
 /oJEB0XR6c6PiBl8kKifX2MUcDFUswXqobJHg5bmgpegPignRfOSzDagMP7jCOe0Rc
 X2VXI7YpweE4gDOGC369Y40THtuD2NeE76orkqDKy2btgrs7xRH83tzdw0axuNiLTH
 0ysOnFd6T2Njg==
Date: Wed, 8 Apr 2026 09:49:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add Startek
 KD070HDFLD092 panel
Message-ID: <20260408-stirring-chubby-petrel-edeac9@quoll>
References: <20260407-panel-simple-startek-upstream-v1-0-76721696655f@pengutronix.de>
 <20260407-panel-simple-startek-upstream-v1-1-76721696655f@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407-panel-simple-startek-upstream-v1-1-76721696655f@pengutronix.de>
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

On Tue, Apr 07, 2026 at 11:31:16AM +0200, Stefan Kerkmann wrote:
> Add Startek KD070HDFLD092 7" WSVGA LVDS panel compatible.
> 
> Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

