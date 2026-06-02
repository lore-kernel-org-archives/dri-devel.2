Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D88CD6E64
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C9810ECBB;
	Tue,  2 Jun 2026 07:24:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13A210ECB7
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:24:19 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <mfe@pengutronix.de>)
 id 1wUJTe-0001hd-Bf; Tue, 02 Jun 2026 09:23:54 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <mfe@pengutronix.de>) id 1wUJTc-000i8j-2h;
 Tue, 02 Jun 2026 09:23:52 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
 (envelope-from <mfe@pengutronix.de>) id 1wUJTc-0000000Futw-2umF;
 Tue, 02 Jun 2026 09:23:52 +0200
Date: Tue, 2 Jun 2026 09:23:52 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marek Vasut <marex@denx.de>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, laurentiu.palcu@oss.nxp.com, 
 victor.liu@nxp.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] Revert "dt-bindings: display: bridge: ldb: Fill in
 reg property"
Message-ID: <n6akxiayi3g6gxcqhreb4iaohmeokoalnqup6h5r2fwdt4zijt@u2wyps55ayqm>
References: <20260504-v7-1-topic-ldb-fixes-v1-0-0125d937ff7f@pengutronix.de>
 <20260504-v7-1-topic-ldb-fixes-v1-2-0125d937ff7f@pengutronix.de>
 <20260505141538.GA2547282-robh@kernel.org>
 <2bl2mwpk57xgkuye2gydliymjkzikiovnb7ovnb73olwtfkjwn@byn3732grvnh>
 <CAL_JsqLYS1sgU680KNR60+OvtNwEVKWovht7K2APO3sqeJe6Nw@mail.gmail.com>
 <zbbez4lpme7szgnsd7fqufbuhmvcftw4sqrmwwwzyxu64i2ppb@fh2fgdkc6tat>
 <CAL_JsqJWyRPh_hmJW8p7+VvtcqpS0a_azjMO-PyQgkqQUfLAGA@mail.gmail.com>
 <uyh5s6g7bvuufnhfjrmungp5dbyllxfrgfzaxno22knpxxojmj@qqvh75ezblpp>
 <20260601222941.GA101404-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601222941.GA101404-robh@kernel.org>
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

On 26-06-01, Rob Herring wrote:
> On Wed, May 13, 2026 at 12:26:40PM +0200, Marco Felsch wrote:

...

> > Please see the below full example, is this allowed?
> > 
> > system-controller@4ac10000 {
> > 	compatible = "fsl,imx93-media-blk-ctrl", "syscon";
> > 	reg = <0x4ac10000 0x10000>;
> > 	#address-cells = <1>;
> > 	#size-cells = <1>;
> > 
> > 	...
> > 
> > 	bridge@5c {
> > 		compatible = "fsl,imx8mp-ldb";
> > 		reg = <0x5c 0x4>, <0x128 0x4>;
> > 		reg-names = "ldb", "lvds";
> > 		clocks = <&clk IMX8MP_CLK_MEDIA_LDB_ROOT>;
> > 		clock-names = "ldb";
> > 		assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>;
> > 		assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
> > 		status = "disabled";
> > 
> > 		ports {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 
> > 			port@0 {
> > 				reg = <0>;
> > 
> > 				ldb_from_lcdif2: endpoint {
> > 					remote-endpoint = <&lcdif2_to_ldb>;
> > 				};
> > 			};
> > 
> > 			port@1 {
> > 				reg = <1>;
> > 
> > 				ldb_lvds_ch0: endpoint {
> > 				};
> > 			};
> > 
> > 			port@2 {
> > 				reg = <2>;
> > 
> > 				ldb_lvds_ch1: endpoint {
> > 				};
> > 			};
> > 		};
> > 	};
> > 
> > 	dpi-bridge {
> > 		compatible = "nxp,imx93-pdfc";
> > 		status = "disabled";
> > 
> > 		ports {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 
> > 			port@0 {
> > 				reg = <0>;
> > 
> > 				dpi_from_lcdif: endpoint {
> > 					remote-endpoint = <&lcdif_to_dpi>;
> > 				};
> > 			};
> > 
> > 			port@1 {
> > 				reg = <1>;
> > 
> > 				dpi_to_panel: endpoint {
> > 				};
> > 			};
> > 		};
> > 	};
> > };
> 
> Yes, this seems fine.

Thanks for the clarification!

Regards,
  Marco

> 
> Rob
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
