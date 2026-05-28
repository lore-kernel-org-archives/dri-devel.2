Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F88CD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2479310ED37;
	Thu, 28 May 2026 07:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IqZlZ0jZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D5310ED38
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:37:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CCB83605D5;
 Thu, 28 May 2026 07:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720781F000E9;
 Thu, 28 May 2026 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779953837;
 bh=sjMCyOJicGcnsOK1p3JsmbDECVIS3LwVFxzgQoZgP/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IqZlZ0jZUWdyRo9TVikWIWSsxSzUCcde9CJs9ADiitZiyWPh+Myh3azKEFD7esWp3
 ZKOsVF6bKCuoUZSY+u+1/Bj4Lm9AG1WA5aRFhk4z3SKMTg/xjUB9lXC8pOQ7EOmSiS
 EYEszxyhtL0wcO/FOt1OTPDHdCwoPw0URBbak0gAsbFN3YqcOT/xLTx12Ch+kSAXLm
 G1k8Am2o9o/oqwVB61n00/NeSAiCN04vPqnZAO8S26D1MAjX37DQAb5ADQ7ogvEWvP
 h8IY3x4Ku1K5h4epJh5621y6jwHs+0GXRoLASvWi8VMek6/APjGK9gn9JcMY1htqai
 2Hs+lm+otW/jw==
Date: Thu, 28 May 2026 09:37:14 +0200
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
Message-ID: <20260528-watchful-nippy-toucanet-8ecf39@quoll>
References: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
 <20260519-dcss-hdmi-upstreaming-v23-5-5615524a9c63@oss.nxp.com>
 <20260526-golden-bobcat-of-aurora-fd1fef@quoll>
 <2301c829-5203-47ea-bc26-09f9e3b459a4@kernel.org>
 <6oub7yyy22dtrevw7oayaqkcncz6tmmddy6fb75gsn3z6yfe3r@zr5lehbaohof>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6oub7yyy22dtrevw7oayaqkcncz6tmmddy6fb75gsn3z6yfe3r@zr5lehbaohof>
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

On Tue, May 26, 2026 at 09:44:53AM +0300, Laurentiu Palcu wrote:
> Hi Krzysztof,
> 
> On Tue, May 26, 2026 at 08:10:43AM +0200, Krzysztof Kozlowski wrote:
> > On 26/05/2026 08:08, Krzysztof Kozlowski wrote:
> > > On Tue, May 19, 2026 at 02:42:28PM +0000, Laurentiu Palcu wrote:
> > >> From: Sandor Yu <Sandor.yu@nxp.com>
> > >>
> > >> Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> > >>
> > >> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > >> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > >> ---
> > >>  .../bindings/display/bridge/cdns,mhdp8501.yaml     | 136 +++++++++++++++++++++
> > >>  1 file changed, 136 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> > >> new file mode 100644
> > >> index 0000000000000..57e7e95199777
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> > 
> > Filename must match compatible.
> > 
> > >> @@ -0,0 +1,136 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Cadence MHDP8501 DP/HDMI bridge
> > >> +
> > >> +maintainers:
> > >> +  - Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > >> +
> > >> +description:
> > >> +  Cadence MHDP8501 DisplayPort/HDMI interface.
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    enum:
> > >> +      - fsl,imx8mq-mhdp8501-hdmi
> > >> +      - fsl,imx8mq-mhdp8501-dp
> > > 
> > > We are at v23 and you will be getting the same questions till you
> > > finally fix that commit msg.
> > > 
> > > Why bus/connector is part of the compatible? Device is exactly the same.
> > > Please read writing bindings - it covers exactly this case.
> 
> The device is the same but, based on the FW, it can act as DP or HDMI
> controller. For 8MQ, the FW is loaded by the ROM. I did look at the writing
> bindings doc and I assume you're referring to this exact paragraph:
> 
>    - DON'T use bus suffixes to encode the type of interface device is using.
>      The parent bus node already implies that interface.  DON'T add the type of
>      device, if the device cannot be anything else.
> 
> I don't see how is this applicable in this particular case. The parent bus node
> does not imply the interface and, as I explained previously, the device can be
> either DP or HDMI.

True, not parent bus node, but in your case still other nodes could define
that this is HDMI via graph.

The problem is that device is the same thus you cannot have different
copmatible. If you look at your driver (although that's not ultimate
argument, just a hint), it clearly needs compatible only to tell if
connection is HDMI or DP. So again: device is the same with the same
programming interface.

Therefore same compatible.

> 
> > 
> > And this was BTW completely different in previous version.
> 
> It was indeed. However, the problem is that there's no way to detect
> from the controller's registers if we're in DP mode or HDMI. In v22 I
> added a DT traversal function to detect the connector type from the last
> node but it was suggested to me that having 2 compatibles would be a
> much cleaner solution and I agree.

Well, you cannot have two compatibles.

Discover the end connector. Optionally phy argument can tell, although
usually not that direction (the phy argument would tell the phy provider
how to configure it, not phy consumer).

Best regards,
Krzysztof

