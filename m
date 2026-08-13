Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F30C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D24B10E02C;
	Thu, 13 Aug 2026 08:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="xSZV/gXq";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C670010E02C
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:34:10 +0000 (UTC)
Received: from francesco-nb (2-224-16-253.ip168.fastwebnet.it [2.224.16.253])
 by mail11.truemail.it (Postfix) with ESMTPA id 9B75A1FBAF;
 Thu, 13 Aug 2026 10:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1786610048;
 bh=7xjwtghHlk2Hu/nCWdg14GhhhCsWUBT8CAjn3KZOlQw=; h=From:To:Subject;
 b=xSZV/gXq/gh8q2vWa5+5RNpYaKm3SwFJk4OPD+WwW369+8GoL/OPto8pRtiw4b2Of
 1Zr24iWHmsCq5Rpat/hVjDBxXNuBhVSG6E7/MvpthNTYzA8cPOXGpdd34EilgikuDE
 qLdnwGvy96m/EU2gXKX5rLjkm1cCglHczpO4oITcL/+g5EPpkTV9ZOcEr3CX53Q3mA
 sp5RmTD5Q5X+HTt7g+XT4sPbRYfxUkU87Q8IqluXor+lSZmPAPJ1XuByRX4EglUgin
 kgRb5SHcLfBGp5z57/mwd5zIuYIHW7LzOg5v23/B1VnmuE4FfizlwL8MuTaiVSc6H4
 oDsPeIf8SL8/Q==
Date: Thu, 13 Aug 2026 10:34:02 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: lcdif: Add endpoint bus-width property
Message-ID: <20260813083402.GA19687@francesco-nb>
References: <20260812132954.148571-1-francesco@dolcini.it>
 <20260812132954.148571-2-francesco@dolcini.it>
 <20260813-classy-boa-of-apotheosis-57207e@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-classy-boa-of-apotheosis-57207e@quoll>
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

On Thu, Aug 13, 2026 at 10:10:43AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 12, 2026 at 03:29:49PM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > The DPI output of the LCD interface can be configured with a bus width
> > of 16, 18, or 24 bits. Introduce a bus-width property to the output
> > endpoint, specifying the number of parallel RGB bits connected.
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > v3: use video-interfaces.yaml
> > v2: use the common bus-width property instead of the legacy interface-pix-fmt
> > ---
> >  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > index 2dd0411ec651..1f3daf002707 100644
> > --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > @@ -71,6 +71,15 @@ properties:
> >      $ref: /schemas/graph.yaml#/properties/port
> >      description: The LCDIF output port
> >  
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml
> 
> This won't work, you need to test your DTS. The port schema does not
> allow video-interfaces properties. You need port-base, like in every
> other case.

Thanks for the review Krzysztof

Given my testing was not ok, and I am not sure what I did wrong exactly
on my tests, is this the change I should do?

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 1f3daf002707..89cea0c14cf1 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -68,7 +68,8 @@ properties:
     maxItems: 1
 
   port:
-    $ref: /schemas/graph.yaml#/properties/port
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
     description: The LCDIF output port

