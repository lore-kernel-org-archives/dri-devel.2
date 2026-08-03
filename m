Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5F3C55162
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 06:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7EC610E4B5;
	Mon,  3 Aug 2026 06:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LaVyvb0Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4220B10E4B5
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 06:43:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 369B0600FF;
 Mon,  3 Aug 2026 06:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861D21F000E9;
 Mon,  3 Aug 2026 06:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785739396;
 bh=8+nAouAuXvyDU7VJvvOC4UNpwl9RZe5dgUCmC2jZ2gU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LaVyvb0YDuH5TbAn6LmrElxm4p+Hrw1lOsUoVhA/jFTQzBFWDLiVJ76SqIm4oUDop
 jp8CSX0D9n1KhyuVzV8XXDac9IyDsfKu9hqrP0tAsW+AXX94WIlxGS/n+WITQglmqN
 dGITfFBDoIQ0xeKyfaR5Ip6Yq8BntywbLSsBH2OXbh2pI+7pH77t/pn81pXC1sOIb2
 3T8PWFyaqem2M1U+I+s1iQtv9JZ3FTFQuWLW7pNQi9HpVgYz+HVqVJcQejbMECs+Nd
 5pEx11UAlRvbbc6XUz3BQ6iR39hpvUs+H0Kfr7OfXCBMEw6Cyuox7sin4IJBOPGhTZ
 75Yx8vd3zJ8lQ==
Date: Mon, 3 Aug 2026 08:43:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yashas D <y-d@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, tomi.valkeinen@ideasonboard.com, 
 r-ravikumar@ti.com, sjakhade@cadence.com, yamonkar@cadence.com, u-kumar1@ti.com,
 devarsht@ti.com, s-jain1@ti.com, d-mittal@ti.com, b-padhi@ti.com
Subject: Re: [PATCH v6 1/2] dt-bindings: display: bridge: cdns,mhdp8546: Add
 no-hpd property to the cadence bridge
Message-ID: <20260803-obedient-truthful-centipede-4e5f1c@quoll>
References: <20260802153825.1570435-1-y-d@ti.com>
 <20260802153825.1570435-2-y-d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260802153825.1570435-2-y-d@ti.com>
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

On Sun, Aug 02, 2026 at 09:08:24PM +0530, Yashas D wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> The mhdp bridge can work without its HPD pin hooked up to the connector,
> but the current bridge driver throws an error when hpd line is not
> connected to the connector. For such cases, we need an indication for
> no-hpd, using which we can bypass the hpd detection and instead use the
> auxiliary channels connected to the DP connector to confirm the
> connection.
> So add no-hpd property to the bindings, to disable hpd when not
> connected or cannot be used for hotplug detection.
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Yashas D <y-d@ti.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

