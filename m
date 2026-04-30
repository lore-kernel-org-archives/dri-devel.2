Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71F8FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21EB410F26F;
	Thu, 30 Apr 2026 07:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AYsaJNX/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C7E10E0EF
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 07:56:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 059D743BB3;
 Thu, 30 Apr 2026 07:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB91C2BCB4;
 Thu, 30 Apr 2026 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777535794;
 bh=izexGcIwdtyGTJHND8E/q0tfWCcSCGUGo5HOHm0zPtM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AYsaJNX/CQOjYCeNvICWroD8akoGwIQ0LoaykxGr7zvn7J4IxIr1BkgyeKU4iVQHY
 NhsBJBadIh1ACEsyTqGpta4tqEoZhSnFbUI0yrLE9PbYcpHyPqB8JX4cW8F/nWonh6
 9xklaskRHq/BL/MYOSBqYwKSXLtK4ZtIlZURMU7pkxiNgLyJ4fDVERusTpNIY0Q/Zu
 U/9w2kWPPLhnaDcVPwqcA6qD0dCNj5qx89YTzstIrB7HZ48snF49+0mSRdNlElJjdz
 TAANz3dOsVqx/fUmqNLIajoVxKpfWyBkVRax6niQuZM+0OJaR90tdD+36HYhecNmyO
 R9x5PrUeQAFVQ==
Date: Thu, 30 Apr 2026 09:56:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v3 1/2] dt-bindings:bridge: Add Lontiun LT7911EXC eDP to
 MIPI DSI bridge
Message-ID: <20260430-gainful-hopping-quokka-da7e7b@quoll>
References: <20260429040541.3404116-1-syyang@lontium.com>
 <20260429040541.3404116-2-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429040541.3404116-2-syyang@lontium.com>
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

On Wed, Apr 29, 2026 at 12:05:40PM +0800, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> and output signal/dual port mipi.
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>

Missing space after ':' in subject.

...

> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video port for MIPI DSI output.

Wrong description, first is input. Look at your DTS.

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video port for eDP input.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vdd-supply
> +  - vcc-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mipi-bridge@41 {
> +            compatible = "lontium,lt7911exc";
> +            reg = <0x41>;
> +            reset-gpios = <&gpy8 8 GPIO_ACTIVE_LOW>;
> +            vdd-supply = <&lt7911exc_1v2>;
> +            vcc-supply = <&lt7911exc_3v3>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    bridge_in: endpoint {
> +                        remote-endpoint = <&edp_out>;
> +                    };
> +                };

Best regards,
Krzysztof

