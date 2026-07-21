Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57611C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1AE10E517;
	Tue, 21 Jul 2026 14:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DEdnrGnm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7075A10E517
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 14:55:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3288F41AC3;
 Tue, 21 Jul 2026 14:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE21A1F00A3A;
 Tue, 21 Jul 2026 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784645723;
 bh=sGLA1oqQx4bYLG3XBqhDuXsnGxss7Hzt9GBEXS4EmYo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DEdnrGnmlNlUThh0c4gZDY4lTwFm156Pv/Jff10y/tK2gtaLOFRbfuzoOtqKnKLBc
 8PD0ZzDpaP0bfzJg6VjlSVgB4JJVJU6OUtJZ7Di7umlQ5NVzqAZo1QLl3rPIzUc3EQ
 O2N5CZrPb6Cvzdckikxwlc6oKBvZZQriis3KuoOtyaoZtDJkvua+8GlCpWlOE/ARQ1
 S06isJuKu07uZdS5KMPnuVrBHLC7SDG26OZhRpN3/+IDThASaakw4ptBUv2RmD2MCt
 ZrOurL7S4H5LF+3xNlC5JLQ0W7HnWUW3UA847WBVrgiLE5kraUM7knrFc2G4ngHZIo
 4usCOYX5ezrdQ==
Date: Tue, 21 Jul 2026 09:55:22 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wojciech Dubowik <wojciech.dubowik@mt.com>, linux-kernel@vger.kernel.org,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: display: sn65dsi83: Add output
 data-lanes property
Message-ID: <20260721145522.GB3790672-robh@kernel.org>
References: <20260721071253.1098652-1-wojciech.dubowik@mt.com>
 <20260721071253.1098652-3-wojciech.dubowik@mt.com>
 <12527bdb-c96f-40f1-b2dd-2c95ded1bdd4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12527bdb-c96f-40f1-b2dd-2c95ded1bdd4@kernel.org>
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

On Tue, Jul 21, 2026 at 09:27:46AM +0200, Krzysztof Kozlowski wrote:
> On 21/07/2026 09:12, Wojciech Dubowik wrote:
> > From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > 
> > Add an optional output lvds data lanes property with two allowed values.
> > The array <1 2 3 4> for standard layout and <4 3 2 1> for reversed lvds
> > output lanes. The latter informs the driver that reverse lvds config
> > option has to be set in config register for the respective output channel.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> You are not allowed to invent tag contents. This is not what you received.

You may want to reconsider any tag other than nak. This is fundamentally 
flawed which sashiko has pointed out since v4 and has been ignored.

Rob
