Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D5AFB3D00
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87F610E5E0;
	Mon, 30 Mar 2026 10:28:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E7010E5E0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:28:26 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mfe@pengutronix.de>)
 id 1w79qj-0000CQ-RV; Mon, 30 Mar 2026 12:28:01 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <mfe@pengutronix.de>) id 1w79qi-002rMd-1h;
 Mon, 30 Mar 2026 12:28:00 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
 (envelope-from <mfe@pengutronix.de>) id 1w79qi-0000000EQ4g-1fiC;
 Mon, 30 Mar 2026 12:28:00 +0200
Date: Mon, 30 Mar 2026 12:28:00 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
Message-ID: <oyietcoxdawgjmpdc3kkmru2azuuqrkmn3onm37wpu6f3t2pqg@g7aswu7zsfrq>
References: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
 <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
 <aabe88e5-70f9-4ea1-b750-e425970a2761@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabe88e5-70f9-4ea1-b750-e425970a2761@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

On 26-03-30, Liu Ying wrote:
> On Sun, Mar 29, 2026 at 07:42:23PM +0200, Marco Felsch wrote:
> > Hi Liu,
> 
> Hi Marco,
> 
> > 
> > sorry for not writting back earlier, the last weeks were quite busy.
> > 
> > On 26-03-29, Liu Ying wrote:
> >> LDB's parent device could be a syscon which doesn't allow a reg property
> >> to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
> >> has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
> >> without a reg property(LDB is also a child device of the Media blk-ctrl).
> >> To make the LDB schema be able to describe LDBs without the reg property
> >> like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
> > 
> > NACK, we want to describe the HW and from HW PoV the LDB is and was
> > always part of a syscon. This is the case for all SoCs i.MX6SX/8MP/93.
> 
> The reality is that i.MX6SX and i.MX8MP LDB DT nodes are already in-tree.

What do you mean by 'already in-tee'?

> People may take them as ABI(not only for Linux, but also for other
> potential projects which use the LDB schema and/or the DT nodes).

Not sure about this. The DT sould be backward compatible, meaning an old
DT shouldn't break new users e.g. old DT with 'reg' property present
shouldn't break new u-boot/barebox/linux/... drivers. But a new DT could
fix/change the behavior for new u-boot/barebox/linux/... drivers.

So no, I don't see a problem here.

> >> Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
> > 
> > Therefore I would just revert this patch completely.
> 
> IMHO, it doesn't make too much difference between my patch and reverting
> this offending patch, because of the ABI, i.e., the reg properties in
> i.MX6SX and i.MX8MP LDB DT nodes are supposed to be stable.

Please see above. If that would be the case, your DT must be rock-solid
bug-free from day one, which is highly unlikely.

> I feel that what you are asking for is even more than simply reverting
> this offending patch, that is to say, completely disallowing the reg and
> reg-names properties for LDBs across all SoCs.  But again, that would
> break the ABI.

Please see above. IMHO it's more confusing if the same "IP" requires the
'reg' for i.MX6SX/8MP but doesn't require it for the i.MX93. Therefore I
would like to keep it consistent.

Regards,
  Marco

> 
> > 
> > Regards,
> >   Marco
> > 
> >> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >> ---
> >>  .../bindings/display/bridge/fsl,ldb.yaml           | 23 ++++++++++++++++------
> >>  1 file changed, 17 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> >> index 7f380879fffd..5f6dc2b11d7b 100644
> >> --- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> >> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> >> @@ -28,6 +28,7 @@ properties:
> >>      const: ldb
> >>  
> >>    reg:
> >> +    minItems: 1
> >>      maxItems: 2
> >>  
> >>    reg-names:
> >> @@ -68,7 +69,6 @@ required:
> >>    - compatible
> >>    - clocks
> >>    - ports
> >> -  - reg
> >>  
> >>  allOf:
> >>    - if:
> >> @@ -83,12 +83,23 @@ allOf:
> >>          ports:
> >>            properties:
> >>              port@2: false
> >> +
> >>    - if:
> >> -      not:
> >> -        properties:
> >> -          compatible:
> >> -            contains:
> >> -              const: fsl,imx6sx-ldb
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - fsl,imx6sx-ldb
> >> +              - fsl,imx8mp-ldb
> >> +    then:
> >> +      required:
> >> +        - reg
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: fsl,imx8mp-ldb
> >>      then:
> >>        required:
> >>          - reg-names
> >>
> >> ---
> >> base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
> >> change-id: 20260329-fsl_ldb_schema_fix-4fe01c42bff3
> >>
> >> Best regards,
> >> -- 
> >> Liu Ying <victor.liu@nxp.com>
> >>
> >>
> > 
> 
> -- 
> Regards,
> Liu Ying
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
