Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15444FF60ED
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E83910E91C;
	Tue, 31 Mar 2026 08:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aMUfkGT/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F7810E91C
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:40:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 271EB600CB;
 Tue, 31 Mar 2026 08:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A818C19423;
 Tue, 31 Mar 2026 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774946414;
 bh=9V9QYvvuD/aPzwd53OUxWY5RcMaQAmjjaBQNnIgKiCQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aMUfkGT/pA4g/AgiZb71azlf6IW9onIeJ4Xs594ikAJnw/eB0HR4/fx8Rr/y+lhcm
 8K0UkIrOeotP0c7J8e57i0lh9R5XyVOZuMf8mJ1J4aKWMYmcOcbqo4KX7UFn3nFqa6
 uL5YDAVXKgQkiANuk4X7B7puFnUpjgkSElif8JJH7NQ7POB3X+OlGU8Uv24A5xkp2L
 5euLbR62pz5ke7Cue1TEj/TkOcnUU424aUi18w1mN/7zlvkOL0igS0/UMLKq4VF5z6
 y4LNWrlEk7cE/g2y8lLncxmKiOyJDBfkQvRs3NZjUjFPNakyi9Zc8uDcIu9MfAJ/3k
 h6G0UFMK+lwIQ==
Date: Tue, 31 Mar 2026 10:40:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Joseph Guo <qijian.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: waveshare,dsp2dpi: describe
 DSI2LVDS setup
Message-ID: <20260331-roaring-carrot-stork-edaef8@quoll>
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
 <20260330-ws-lcd-v1-1-309834a435c0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330-ws-lcd-v1-1-309834a435c0@oss.qualcomm.com>
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

On Mon, Mar 30, 2026 at 04:25:50PM +0300, Dmitry Baryshkov wrote:
> Several the Waveshare DSI LCD panel kits use DSI2LVDS ICN6202 bridge

If you know the hardware bridge used, should not it be the front
compatible (with waveshare,dsi2lvds fallback)? Or even alone? Can the
waveshare kits come with different bridges? I guess yes, they could.

> together with the LVDS panels. Define new compatible for the on-kit
> bridge setup (it is not defailed and it uses Waveshare prefix since the

typo: detailed

> rest of the integration details are not known).
> 

Please also update at least description:
"...converts DSI to DPI or LVDS."
or similar.

Best regards,
Krzysztof

