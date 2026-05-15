Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2990BCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E7910E147;
	Fri, 15 May 2026 06:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="krXJuO9n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCD010E147
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:51:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0161260581;
 Fri, 15 May 2026 06:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B52DC2BCB0;
 Fri, 15 May 2026 06:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778827903;
 bh=xetCbQQicxOnxA/cAWCBNjO1sljv2AqnFgNenly9yms=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=krXJuO9ndCrzCUWxfwt6siUoaECBWzO7J6x035a9dcURhIVBefNNnH4pZUv2aKhf3
 80KyKhGxol1OUXWU4jwiqFj6ZfRQ+21TaszZO/xevTwbwbrrOYL0tpcTfVlTOAH/wx
 V7/j2I8tIZ1Ifxi/wzYtObXtCHRVF9OUrkkMJCteQ9FDsltRuESAIMQdPY5BWlBeec
 a60j3O88yB6W3BoAmEcmsyostQgj9CfXIXUg/RpSeb2FzK2Tq4HYBRiHDCEpTdqzJg
 WeEZouBq5ijvovq6UCrDlC+eH+qPOjS9M0BFRZU+jqjdJxQ6ENrZsgh30yLaqFwkz3
 Y22hpb8m1qeWg==
Date: Fri, 15 May 2026 08:51:41 +0200
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
Subject: Re: [PATCH v2 02/16] dt-bindings: display: ti,am65x-dss: Simplify
 binding
Message-ID: <20260515-hidden-devout-numbat-dc6c9e@quoll>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
 <20260513-beagley-ai-display-v2-2-9e9bcefde6bc@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-beagley-ai-display-v2-2-9e9bcefde6bc@ideasonboard.com>
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

On Wed, May 13, 2026 at 04:17:24PM +0300, Tomi Valkeinen wrote:
> In principle the DT binding for the DSS IP should mainly cover the DSS
> IP. The current binding also covers the SoC integration topics outside
> the DSS, mainly via the endpoint related rules and descriptions.
> 
> A more recent SoC, AM62P, has two instances of the DSS IP, and while
> both DSS IPs are identical, they are integrated slightly differently
> (e.g. which DSS output goes to an in-SoC DSI bridge, which goes to
> DPI pins, etc.).
> 
> To make the bindings usable for both DSS instances, relax the binding
> slightly: remove the explicit endpoint rules, and generalize the
> descriptions.
> 
> Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
> Tested-by: Swamil Jain <s-jain1@ti.com>

Same comments.

Best regards,
Krzysztof

