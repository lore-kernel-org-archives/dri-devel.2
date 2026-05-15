Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF73DCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BAE10E08D;
	Fri, 15 May 2026 06:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b9DMQ8ml";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A2A910E08D
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:51:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AC346091C;
 Fri, 15 May 2026 06:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5B0C2BCB0;
 Fri, 15 May 2026 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778827893;
 bh=pYzVa5nM9Ddh1bPK5+yxiL/X4VA1ysn4pX2lUE9O3i0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b9DMQ8mlte1O6488J8Gt6MJ/XatOpSBgRIchxwq2lA7KqXBVuRl7m75uaKhLeMZuX
 hw0fb62gEou6iU9tE0YmgwoEJYsgoG6cfhzTc3T+jKrDfEJTqu4T8F9wxT9pDWx/e4
 CUykAC3bjdX02GXKAnXSZph0ki4rYGZN48ghOLKfGOKRd7n55kExvvv069JmInJ+ha
 OFHPH67Em7+zFpeNib9EUVxkB6WMFxO1nAHHBSc55VguzwaBf7wZHoVsiW459LsqPn
 xaZyll6Z2i7VroKVhGRndhkLGJThR0+rwAh3bupAZniupnJ944IIqpkABP7VoXCOlG
 7gI1BHCwVKd8g==
Date: Fri, 15 May 2026 08:51:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/16] dt-bindings: display: ti: Move ti,am62l-dss
 binding to a new binding file
Message-ID: <20260515-mahogany-snake-from-atlantis-c2d1e9@quoll>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
 <20260513-beagley-ai-display-v2-1-9e9bcefde6bc@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-beagley-ai-display-v2-1-9e9bcefde6bc@ideasonboard.com>
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

On Wed, May 13, 2026 at 04:17:23PM +0300, Tomi Valkeinen wrote:
> We currently have two binding files for different TI K3 DSS versions:
> ti,j721e-dss.yaml which contains bindings for the "full" DSS version,
> with four planes and outputs, and ti,am65x-dss.yaml which used to
> contain bindings for the "lite" DSS version, with two planes and
> outputs.
> 
> ti,am62l-dss binding was added recently to the ti,am65x-dss.yaml file,
> which only has a single plane and a single output. To keep with the
> above "binding file per DSS model" style, and to simplify the
> ti,am65x-dss.yaml file, let's move the ti,am62l-dss to a separate, new
> file.
> 
> Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>

Drop quotes

> Tested-by: Swamil Jain <s-jain1@ti.com>

Drop

Best regards,
Krzysztof

