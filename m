Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1D1C88E5A
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 11:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A34D10E7F4;
	Sun, 13 Sep 2026 11:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="T0VFBHWp";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC47F10E7F4
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 11:10:30 +0000 (UTC)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E7E5B1FB90;
 Sun, 13 Sep 2026 13:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1789297828;
 bh=y44+A28Y3BNV9Kwrp3SpasZ4quyu/gVpv3kXvPsZ3r4=;
 h=Received:Received:From:To:Subject;
 b=T0VFBHWpT29SQ0+mCZ1RszeeutgP4OtMHS6BpRswhxVHUsxyKJAOjzTDWzV5t31Cj
 oMLwjimg1hEn9U5xEb6VE/5ryXcEuMq4KyehetNnTRjvZU29KcvxJTm05LFMX8IWTR
 jRFoEtP7vyDg4H+Be43YTOgQ+urDJEKOKh6Hjc4axSKzT16YQem3WuuAC/T+376yy5
 kuzu1QqNEvu+tNuvnVR13VcfqMdLn0rfP4jh8DfwtbQFVr//MEqZbDoehLRlcxsCMH
 tKbzxXunpmTKf3feVGyZ06Lt2p7XppYDszP849m/ZlFDzpWyGoFD0iMct6eQgtdG/c
 +VcqUgXh0btkQ==
Received: from livingston (unknown [192.168.42.11])
 by gaggiata.pivistrello.it (Postfix) with ESMTP id 81B107FA3F;
 Sun, 13 Sep 2026 13:10:27 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.98.2)
 (envelope-from <francesco@dolcini.it>) id 1x5i6N-000000002jM-1jMz;
 Sun, 13 Sep 2026 13:10:27 +0200
Date: Sun, 13 Sep 2026 13:10:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Subject: Re: [PATCH v4 0/4] drm: mxsfb: Support LCDIF interface bus width
Message-ID: <aqaEo1-aS7Srsgxv@livingston.pivistrello.it>
References: <20260813092836.38367-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813092836.38367-1-francesco@dolcini.it>
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

+ some more DRM maintainers/reviewers

Hello,
just a gentle ping to the DRM bridge maintainers.

On Thu, Aug 13, 2026 at 11:28:30AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The width of the physical LCDIF output bus can differ from the input bus
> format advertised by the downstream panel or bridge.
> 
> Such a distinction is required when the LCDIF bus width does not match the
> width of the downstream display interface. For example, an 18-bit or
> 16-bit LCDIF bus can drive a 24-bit display by wiring the available color
> bits to the appropriate display inputs. Configuring LCDIF solely from the
> display's 24-bit format in this case selects the wrong LCD_DATABUS_WIDTH
> mode, changing the color-bit assignment on the LCD_DATA pins and resulting
> in incorrect colors.
> 
> Use the common OF graph endpoint bus-width property to describe the width
> of the physical LCDIF output bus. Make the mxsfb driver derive the
> corresponding media bus format from this property and use it in preference
> to the format reported by the downstream display. When the property is
> absent, the existing behavior is preserved.
> 
> Set the endpoint bus width for the Colibri iMX6ULL and Colibri iMX7 boards,
> which route an 18-bit LCD interface.

The first two patches in this series should go through drm-misc-next.
Please let me know if any changes are still needed. Otherwise, could they be
picked up?

Thanks,
Francesco

