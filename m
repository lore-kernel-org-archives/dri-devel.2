Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14184606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6K+wAf7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DAB10E1A2;
	Thu, 29 Oct 2026 18:30:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E379910E6CD
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:30:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87BFF60267;
 Thu, 29 Oct 2026 18:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35111F01816;
 Thu, 29 Oct 2026 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793298644;
 bh=T1jQPPOnIUPn54gOQVLPacFnP84O2C/bl7ta1IvDEVw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=j6K+wAf7ZjRh9Ao4TJpsqRQcwVrqwhHiapAH8DC7rep5dgOpHzoaqe9/tUVvPObO+
 KB8hjr2tiqbKGwQp6c39C1X5ojGJSsqyC+nPzE9J3w2ZdzBxhUN2ya3PJBXbJ/scJy
 HBSFMGLcximqJcBzunCT/gKnuCVBC6p3eA0/nNbtleub1Guk1EYVHf2MXNcknjoRTo
 4etDeDvNDKHKZTscTGw0obKhKEZtewUh9TskRl2yHfh4uCt/ZMh+RYV/OgSR1QtUJ9
 igrnsMD4lUq25iyxd8eLP5xJMuEgKKYVhcJxicByYCySguIPHj51kHLmJaTFZNYVFn
 Gq+InIT0Tq13Q==
Date: Thu, 29 Oct 2026 13:30:41 -0500
From: Rob Herring <robh@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-rockchip@lists.infradead.org, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 William Qiu <william.qiu@starfivetech.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 devicetree@vger.kernel.org, Andy Yan <andyshrk@163.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Dominique Belhachemi <db@domibel.de>,
 Maud Spierings <maud_spierings@murena.io>,
 Joshua Peisach <jpeisach@ubuntu.com>, David Airlie <airlied@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robert Foss <rfoss@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Paul Walmsley <pjw@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Yakir Yang <kuankuan.y@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Hal Feng <hal.feng@starfivetech.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, dri-devel@lists.freedesktop.org,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Jonas Karlman <jonas@kwiboo.se>,
 Graham Markall <hello@big-grey.co.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, linux-riscv@lists.infradead.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v6 04/18] dt-bindings: soc: starfive: Add
 starfive,jh7110-hdmi-subsystem
Message-ID: <20261029183041.GA4029917-robh@kernel.org>
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075358eucas1p111293c602fc3aac9c6a044fc41488919@eucas1p1.samsung.com>
 <20261029-jh7110-clean-send-v6-4-759594e43acf@samsung.com>
 <179329528881.3539981.14637229355908751610.robh@kernel.org>
 <777c7a8c-de7c-4f0c-9c9c-d5b78a5595d8@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777c7a8c-de7c-4f0c-9c9c-d5b78a5595d8@samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 06:53:25PM +0100, Michal Wilczynski wrote:
> 
> 
> On 10/29/26 18:38, Rob Herring (Arm) wrote:
> > 
> > On Thu, 29 Oct 2026 08:53:38 +0100, Michal Wilczynski wrote:
> >> Add the dt-binding for the StarFive JH7110 HDMI subsystem.
> >>
> >> The JH7110 HDMI IP is a monolithic block containing both the digital
> >> controller and analog PHY in a single register space. This binding
> >> defines the parent device, which holds the shared register map, and its
> >> two children: the PHY and the controller.
> >>
> >> The two have separate resources. The PHY takes the 24 MHz reference
> >> clock and provides both the pixel clock, which the VOUT clock generator
> >> routes on to the display controller, and the phy the controller uses.
> >> The controller takes its clocks from the VOUT clock generator. What
> >> they share is the register space, which the parent maps.
> >>
> >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >> ---
> >>  .../starfive/starfive,jh7110-hdmi-subsystem.yaml   | 95 ++++++++++++++++++++++
> >>  1 file changed, 95 insertions(+)
> >>
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml: Unresolvable reference: /schemas/phy/starfive,jh7110-inno-hdmi-phy.yaml#
> > Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.example.dtb: hdmi@29590000 (starfive,jh7110-hdmi-subsystem): phy: False schema does not allow {'compatible': ['starfive,jh7110-inno-hdmi-phy'], '#clock-cells': 0, 'clocks': [[4294967295]], '#phy-cells': 0, 'phandle': 2}
> > 	from schema $id: https://protect2.fireeye.com/v1/url?k=e93a78e1-88b16dd1-e93bf3ae-000babffaa23-e7f80dd3ed8ff65f&q=1&e=27d4095f-5012-49f1-94e3-a63fd9693348&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fsoc%2Fstarfive%2Fstarfive%2Cjh7110-hdmi-subsystem.yaml
> > Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.example.dtb: /example-0/soc/hdmi@29590000/phy: failed to match any schema with compatible: ['starfive,jh7110-inno-hdmi-phy']
> > 
> 
> This patch depends on the JH7110 HDMI PHY series which adds
> starfive,jh7110-inno-hdmi-phy.yaml [1].

I'm aware. I just want whomever applies this to know they need to wait 
for that series.

> With that series applied dt_binding_check is clean.

Humm, this is applied with b4 and you added the dependencies for 
it (thanks!), so it should have run with that series applied too. I'll 
have to investigate.

Rob
