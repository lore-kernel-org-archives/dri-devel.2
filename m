Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC77CA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7589C10E08F;
	Wed, 30 Sep 2026 09:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QGCu08CW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3056C10E08F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:59:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3163960236;
 Wed, 30 Sep 2026 09:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1631F000FF;
 Wed, 30 Sep 2026 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790762391;
 bh=fcZCpP6kxzypYHCcA9Y6Fe3LYElLJlu/QUBiiAX4hj4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QGCu08CWmtyZAgsSl1TpA6dkctpRNZV+QllHJYvd4QS8MUl94IqF7qEqzIWTUU1Le
 Ub5f1uM90s/YBo0sQ2jKgpDAnVQwU37bZJBdP7yBnFXe4I7m3pQWtauH/KAPOXntoQ
 e6sC+nF4CrDJWI++BYDBWYPc3+BRJmIaga7Y/jKeEqKi/DErLH9x5SMcCvKQ4lYNZL
 Dv9dJ7jjxyXz2E9snzDpREL6VA2pfukWkoNWxv4IiFV/Suq9FcdifrZK8f8PTWSXz1
 za12emyXxvN0ods8cc8s1xVz+ziAwXFLLjTnMtEuzOareEgaGXvkWrt4jKlltIqcCS
 xclPFzKydafrQ==
Date: Wed, 30 Sep 2026 11:59:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Guido =?utf-8?Q?G=C3=BAnther?= <agx@sigxcpu.org>,
 Robert Chiras <robert.chiras@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 2/8] dt-bindings: embedded-controller: remove
 #address-cells and #size-cells from required
Message-ID: <20260930-light-whippet-of-fruition-faf077@quoll>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
 <20260925-cleanup_dtb_warning-v1-2-f999fafbca60@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-cleanup_dtb_warning-v1-2-f999fafbca60@nxp.com>
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

On Fri, Sep 25, 2026 at 12:37:51PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> The "^fan-controller@[0-9a-f]+$" child node is optional, so it is not

Why is it optional? Hardware can be fan-less? This should be the reason
here.

Best regards,
Krzysztof

