Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C72CD6E45
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF0610ED3A;
	Thu, 28 May 2026 07:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SVp+0DpW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B6710ED3A
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:39:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE02844438;
 Thu, 28 May 2026 07:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3711F000E9;
 Thu, 28 May 2026 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779953963;
 bh=DSIjaXcduwNYBJCQrGtQKLo8lAav4xOuWF8oe+nqQKU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SVp+0DpWalSi7cdfdBP7UfszYqPQZkiQ6CgIvR+C5PufGehp6wsNS7S0VM2rKBmmi
 UWPJQ3vKqm4RBEeXpGml01oRpLdtxBrfoZE4yUPu42w4GaJ55oYmHGmjzNFf3PGRCA
 sOW11CJnfQjqtcUV77j8BsSdZ/gqZBY8L9IAILV5OW0GRpy0hOWKZA309StDLK/L4h
 NUg72vfoIBA6+gHaG31hdWQwRHkL/TT2QMtgb45jKE8hkvIfSc1oHiH8ZKnTOt+WZU
 PT1RzASgc0m3MkFpvyB4E8THmx3kdhkOLj3wDel4jEsQSSH6UUNCzlfXlf3no34duc
 tpNlVtxau+9RA==
Date: Thu, 28 May 2026 09:39:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
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
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Ying Liu <victor.liu@nxp.com>
Subject: Re: [PATCH v23 5/8] dt-bindings: display: bridge: Add Cadence MHDP8501
Message-ID: <20260528-nice-bronze-cat-19be71@quoll>
References: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
 <20260519-dcss-hdmi-upstreaming-v23-5-5615524a9c63@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519-dcss-hdmi-upstreaming-v23-5-5615524a9c63@oss.nxp.com>
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

On Tue, May 19, 2026 at 02:42:28PM +0000, Laurentiu Palcu wrote:
> +    required:
> +      - port@0
> +      - port@1
> +
> +  phy:
> +    description:
> +      Child node describing the Cadence HDP-TX DP/HDMI PHY, which shares
> +      the same MMIO region as the bridge.
> +    $ref: /schemas/phy/fsl,imx8mq-hdptx-phy.yaml#

Another new thing... at v23 you should not have major changes to the
binding.

You do not get separate node, just to instantiate the driver and sharing
the MMIO suggests that this is the same device. Phy reference from your
bridge into the child confirms that this is the same device, so one
device node.

Best regards,
Krzysztof

