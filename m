Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD1C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA61110E84F;
	Mon,  6 Jul 2026 09:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l/eOddAd";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBC210E84F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:45:25 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32794524;
 Mon,  6 Jul 2026 11:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783331076;
 bh=M8pn+QlLLysMqwQcLRLoz0lnTqJieKWaHHlj88GmCQ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l/eOddAdOyPtNffoM9mczj3RP1ic6Gc38MwtOFPIqRqPlvgsz5EZ3KhnYEmFxlt4x
 Erd5fCEETscm3HdL3RkU3IXF8ojzNtcr4Wb54IYIP/WHSRLfeu9t2EktMSK9ffVfcB
 JXzIy1OGkvxejhGV8z5E1kNRrtzNjshDa0x3qWLA=
Date: Mon, 6 Jul 2026 12:45:22 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: vga-connector: Allow
 hardcoding EDID
Message-ID: <20260706094522.GA42740@killaraus.ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
 <20260706-capable-beaver-of-excellence-a3cf10@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706-capable-beaver-of-excellence-a3cf10@houat>
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

Hi Maxime,

On Mon, Jul 06, 2026 at 10:52:32AM +0200, Maxime Ripard wrote:
> On Mon, Jul 06, 2026 at 12:35:39AM +0300, Laurent Pinchart wrote:
> > Since DDC version 2, introduced in 1996, VGA monitors have exposed EDID
> > data over an I2C bus. The bus is also used to detect the presence of a
> > connected monitor by trying to read the EDID data.
> > 
> > Some devices where the VGA display is integrated in the device and
> > always connected do not connect the DDC pins. Some development boards,
> > such as the Renesas M3N Salvator-XS, also do not connect the DDC pins.
> > 
> > To support those, add the ability to provide hardcoded EDID data in the
> > device tree. This is mutually exclusive with specifying a DDC bus, and
> > can only be done when the VGA display is guaranteed to be always
> > connected.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> This feels redundant with the EDID firmware loading mechanism we have in
> KMS already. It should at least be mentioned why we would need to set it
> in the device tree at all.

Very good question.

I assume you're talking about CONFIG_DRM_LOAD_EDID_FIRMWARE, as the
debugfs override_edid feature isn't meant for production. If there are
other relevant mechanisms I'm not aware of, please let me know.

In the use case at hand, the VGA display is an integral part of the
device, the same way an LVDS or DSI panel would be. Using
CONFIG_DRM_LOAD_EDID_FIRMWARE, the manufacturer would need to set the
drm.edid_firmware command line parameter, and provide EDID as a file in
/lib/firmware/ (possibly in an initramfs). Beside the complexity, and
the fact it won't be very friendly to people who run a different
userspace on the device, I think EDID counts in this case as system
description, the same way we support specifying panel timings in device
tree.

Does this make sense ? If so, I'll update the commit message accordingly
in v2.

-- 
Regards,

Laurent Pinchart
