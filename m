Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A607C1093188
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 08:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF4A10E544;
	Fri, 20 Mar 2026 08:23:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF91010E544
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 08:23:55 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mfe@pengutronix.de>)
 id 1w3V8i-0001kv-JS; Fri, 20 Mar 2026 09:23:28 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <mfe@pengutronix.de>) id 1w3V8h-001DAd-0B;
 Fri, 20 Mar 2026 09:23:27 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
 (envelope-from <mfe@pengutronix.de>) id 1w3V8g-0000000Cpkf-3s5d;
 Fri, 20 Mar 2026 09:23:26 +0100
Date: Fri, 20 Mar 2026 09:23:26 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Marek Vasut <marex@nabladev.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, imx@lists.linux.dev,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, 
 Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
Message-ID: <xqy67fmh42k26iagl7wqrh2dbsn7c5fytwbkcksfzagefp327j@s5hg4lpuvy3q>
References: <20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com>
 <20260304-dcif-upstreaming-v8-1-bec5c047edd4@oss.nxp.com>
 <b7968f1a-c4bc-4bad-bcf8-407ff2d8db27@nxp.com>
 <dmqbmmpyi3ssvq67iqwbt6ww7tsaik7ifi5dnupmuhep7u5saz@ads5g7ette3y>
 <mx6b5svmvlonil4efuiaxcmtygn7lld3nj7gcxnnauaryt2yed@gohjshakc2g6>
 <40b3d1c8-0cf2-470d-8223-751240061735@nabladev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b3d1c8-0cf2-470d-8223-751240061735@nabladev.com>
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

Hi Marek,

On 26-03-19, Marek Vasut wrote:
> On 3/19/26 9:57 AM, Laurentiu Palcu wrote:
> > On Fri, Mar 06, 2026 at 09:46:57AM +0100, Marco Felsch wrote:
> > > On 26-03-06, Liu Ying wrote:
> > > > On Wed, Mar 04, 2026 at 11:34:10AM +0000, Laurentiu Palcu wrote:
> > > > > i.MX94 has a single LVDS port and share similar LDB and LVDS control
> > > > > registers as i.MX8MP and i.MX93.
> > > > > 
> > > > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > ---
> > > > >   Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml | 2 ++
> > > > >   1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> > > > > index 7f380879fffdf..fb70409161fc0 100644
> > > > > --- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> > > > > +++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> > > > > @@ -20,6 +20,7 @@ properties:
> > > > >         - fsl,imx6sx-ldb
> > > > >         - fsl,imx8mp-ldb
> > > > >         - fsl,imx93-ldb
> > > > > +      - fsl,imx94-ldb
> > > > 
> > > > Cc'ing Marco.
> > > > 
> > > > Recently, Marco said that LDB node should not have a reg property...
> > > > 
> > > > https://lore.kernel.org/all/4sofljffovrorpxe2os3jl745qfjoglvl54oqf3v7r5bk5f6aq@6y3jwn4abiqy/
> > > 
> > > Yes, this has to be dropped. All variants of this specific "IP" use the
> > > same approach. This "IP" is part of a general purpose register layout
> > > with very loose reg-field definitions: e.g. resets and clk-gatting share
> > > the same register. Or a mux reg-field shares the same register as a
> > > MIPI-{C,D}SI configuration reg-field. Therefore this "IP" is part of a
> > > syscon and should be abstracted as such within the DT.
> > 
> > Even though I understand the logic behind why 'reg' should be dropped,
> > I'm not exactly sure how to proceed with this. It appears Marek made the
> > 'reg' required in this commit (merely 2 months ago):
> > 
> > 8aa2f0ac08d3b - dt-bindings: display: bridge: ldb: Add check for reg and reg-names
> > 
> > Should the above patch simply be reverted and have 'reg' as optional again?
> > Or should the 'reg' and 'reg-names' be removed completely from the
> > binding.
> > 
> > @Marek, any comments?
> The LDB driver was always written with parsing 'reg' out of the DT, so

Not sure what you mean by always. I re-checked the imx6qdl.dtsi which
uses the ipuv3/imx-ldb.c driver. These platforms don't use the 'reg'
property either.

> encoding the register offsets into the driver was a mistake. The LDB
> controls two registers, which can be comfortably described in DT.

Sorry but I have to disagree on this. It's no about if it's possible,
it's about if the abstraction is correct and IMHO the LDB is just one
subdevice of the syscon. For i.MX6SX the syscon is the iomuxc-gpr for
the i.MX8M and i.MX9 this is now a blkctrl.

So IMHO the dt-bindings patch should be reverted and the DTs need to be
adapted.

Regards,
  Marco

> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
