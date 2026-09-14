Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DA8C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0904910EE2E;
	Mon, 14 Sep 2026 12:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OsrBnctL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D3710E558;
 Mon, 14 Sep 2026 12:50:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0DC0601F9;
 Mon, 14 Sep 2026 12:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855C61F00902;
 Mon, 14 Sep 2026 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789390225;
 bh=nAHs0FwO5HirqBTAsL4xPSPoEzHJVgBNldVSVJGuM6w=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OsrBnctLlVJgJWgc+plCxEab0DY8146Qc1y8Ip+Tu/Ll3daLLQsZaHPldecXLyIdC
 NBuC3ALG7uHJs19Qw3qJdlrLV9Ay7UVdlo7Bh8RRQ1RWDqKWUnsfOIRfQmgNVqrY8n
 wp5SesIHJyRyNLXyA+WfzoHIpICyGsVKuLUtDzW2qWN7k7FZ7WqfxCWV5etlbIM54b
 gVP5twM7yfOTh/ZQRqmwiVOXlFYvVhHItFHWHfKQToTY+135Kiu2uJkEBXt3uqd8VB
 xaTqe/pxjFr4Z0TSy6ARyNJKJNSPNL/xELAfpyHHOgSHUa5LmN0goMPEqN7VffUzm7
 9BAQr8UcOfqFw==
Subject: Re: [PATCH net-next] dt-bindings: net: Use consistent indentation in
 the example
From: netdev-bot+sashiko@kernel.org
To: krzysztof.kozlowski@oss.qualcomm.com
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, justin.chen@broadcom.com, florian.fainelli@broadcom.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ulli.kroll@googlemail.com,
 linusw@kernel.org, clement.leger@bootlin.com, olteanv@gmail.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, hayashi.kunihiko@socionext.com,
 mhiramat@kernel.org, nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
 shayne.chen@mediatek.com, sean.wang@mediatek.com, johannes@sipsolutions.net,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jjohnson@kernel.org, richardcochran@gmail.com, geert+renesas@glider.be,
 magnus.damm@gmail.com, yongxing.mou@oss.qualcomm.com, rfoss@kernel.org,
 abelvesa@kernel.org, vineetha.g.jaya.kumaran@intel.com,
 claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com, elder@kernel.org,
 s-vadapalli@ti.com, rogerq@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 ath10k@lists.infradead.org
Date: Mon, 14 Sep 2026 12:50:22 +0000
Message-ID: <178939022208.22033.14553895731937911806@kernel.org>
In-Reply-To: <20260913122910.99457-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260913122910.99457-3-krzysztof.kozlowski@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] In Documentation/devicetree/bindings/net/cortina,gemini-
  ethernet.yaml the patch does more than re-indent: it deletes the whole…

--

dt-bindings: net: Use consistent indentation in the example

This reindents the DT binding examples under Documentation/devicetree/
bindings/net/ to consistent 2- or 4-space indentation so that
dt-check-style stops reporting "indent mismatch" warnings.  Twelve
binding files are touched.

> diff --git a/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml b/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
> index f0b5bea2458d5..da9bc170cd543 100644
> --- a/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
> +++ b/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
> @@ -87,18 +87,6 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/clock/cortina,gemini-clock.h>
>      #include <dt-bindings/reset/cortina,gemini-reset.h>
> -    mdio0: mdio {
> -      #address-cells = <1>;
> -      #size-cells = <0>;
> -      phy0: ethernet-phy@1 {
> -        reg = <1>;
> -        device_type = "ethernet-phy";
> -      };
> -      phy1: ethernet-phy@3 {
> -        reg = <3>;
> -        device_type = "ethernet-phy";
> -      };
> -    };

[Severity: Medium]
Is this deletion intended?  The commit message says only:

    Correct indentation in the examples to consistent 2- or 4-spaces
    indentation to fix dt-check-style warnings

Every other hunk in the series is a pure whitespace shift with the brace
nesting preserved, but here the whole mdio0 node with phy0 and phy1 is
removed and nothing is added back.

Wouldn't re-indenting the mdio0 node to 4 spaces achieve the stated goal
without dropping the example content?

> 
>      ethernet@60000000 {
>          compatible = "cortina,gemini-ethernet";
> @@ -110,28 +98,28 @@ examples:
>          ranges;
>  
>          gmac0: ethernet-port@0 {
[ ... ]
> +            phy-mode = "rgmii";
> +            phy-handle = <&phy0>;
>          };

[Severity: Medium]
Do the surviving phy-handle properties in gmac0 and gmac1 now reference
labels that no longer exist in the file?  After this patch the file
contains:

    gmac0: ethernet-port@0 {
        ...
        phy-handle = <&phy0>;
    };

    gmac1: ethernet-port@1 {
        ...
        phy-handle = <&phy1>;
    };

but there is no longer any definition of phy0 or phy1 anywhere in
cortina,gemini-ethernet.yaml, and the example no longer shows the MDIO bus
and PHY topology it used to illustrate.

If the mdio0 removal is deliberate, could it go into a separate patch that
also updates the phy-handle references?

>  
>          gmac1: ethernet-port@1 {
[ ... ]
> +            phy-mode = "rgmii";
> +            phy-handle = <&phy1>;
>          };
>      };

[ ... remaining files snipped, no comments ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913122910.99457-3-krzysztof.kozlowski%40oss.qualcomm.com
