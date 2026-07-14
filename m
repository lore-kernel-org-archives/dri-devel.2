Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522D2C4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479AF10E0D6;
	Tue, 14 Jul 2026 19:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="KLkmofSR";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C9110E0D6
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:36:35 +0000 (UTC)
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id D7B871F8C1;
 Tue, 14 Jul 2026 21:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784057792;
 bh=ouG4gU2sMxcP7NnkE/ZCp7siG/EcEqz4Sk7+xu/lKZg=; h=From:To:Subject;
 b=KLkmofSRNvGp46eG5l7vx8V8L3VWhoxxkU0Qzios6IVZWT3JpLVXNXwOivqOqVmPd
 sKtwfZ5GN719FY3GWAyiu7jqsgou3YE6aQYbNGOifKGrtsbBN3aXT4aq+XC/EPSmiX
 cDUQTAuRXJJSjuOz6wiqeNQlRcbNzl4dWC68kqDFfJDPZGOIrR+2hnGuLWYv8JDp4S
 rPiH7+i3nNht+tpnPz5rNIAUofST5jjdtDCwWaoBcj6JEzzNvp/w/FMMnBqLKeRFIi
 KKT7/5yyufWUTZiT/+binA7KtPbKrRxfeKw5RqnO8tx9eJYfYmqQlvIzT05Sv+GpOL
 bVakEGMeY31zw==
Date: Tue, 14 Jul 2026 21:36:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de,
 vkoul@kernel.org, kishon@kernel.org, Frank.Li@nxp.com,
 lumag@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
 u.kleine-koenig@baylibre.com, francesco@dolcini.it,
 dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v9 00/19] Add Freescale i.MX8qxp Display Controller support
Message-ID: <20260714193627.GA9616@francesco-nb>
References: <20250414035028.1561475-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414035028.1561475-1-victor.liu@nxp.com>
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

Hello Liu,

On Mon, Apr 14, 2025 at 11:50:09AM +0800, Liu Ying wrote:
> Hi,
> 
> This patch series aims to add Freescale i.MX8qxp Display Controller support.
> 
> The controller is comprised of three main components that include a blit
> engine for 2D graphics accelerations, display controller for display output
> processing, as well as a command sequencer.

...

> 
> To follow up i.MX8qxp TRM, I changed the controller name to "Display Controller"
> instead of the previous "DPU".  "DPU" is only mentioned in the SoC block
> diagram and represents the whole display subsystem which includes the display
> controller and prefech engines, etc.
> 
> With an additional patch[1] for simple-pm-bus.c, this series facilitates
> testing a LVDS panel on i.MX8qxp MEK.
> 
> Please do NOT merge patch 14-19.  They are only used to facilitate testing
> the LVDS panel.

What's the plan to conclude this work? What's the latest status?
I am looking forward to have a way to use the i.MX8QXP display with
mainline, but to my understanding some required changes on the SOC dtsi
are not merged.

Can you help?

Thanks,
Francesco

