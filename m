Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7F8FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 20:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BE910E87A;
	Mon,  4 May 2026 20:21:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E314010E86B
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 20:21:48 +0000 (UTC)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <m.felsch@pengutronix.de>)
 id 1wJznX-0007WV-3d; Mon, 04 May 2026 22:21:47 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 0/4] i.MX LDB DT cleanups
Date: Mon, 04 May 2026 22:21:40 +0200
Message-Id: <20260504-v7-1-topic-ldb-fixes-v1-0-0125d937ff7f@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANX/+GkC/x3LSwqAMAwA0atI1gbS+sWriAttowakSiMiiHe3u
 HwM84ByFFbosgciX6KyhwSTZ+DWMSyM4pPBkq2pohKvBg2e+yEONz/hLDcrtlNBpfWuIs+Q1iP
 yH9LZD+/7AZL914tmAAAA
X-Change-ID: 20260504-v7-1-topic-ldb-fixes-8b3042dc50de
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, laurentiu.palcu@oss.nxp.com, 
 victor.liu@nxp.com
Cc: kernel@pengutronix.de, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
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

Hi,

this cleanup prepares the LDB dt-bindings for the upcoming i.MX93 and
i.MX94 LDB support and is a different abborach than [1]. This approach
should be easier to maintain [2] and far more flexible for upcoming
BLK-CTRL or IOMUX_GPR syscon sub-devices.

Please be informed: I didn't do runtime tests but since the LDB driver
never used the reg (nor reg-names) property, it should be safe to remove
them.

Regards,
  Marco

[1] https://lore.kernel.org/all/20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com/
[2] https://lore.kernel.org/all/2mkih6id2cfqjfksfvvitzlcnyfz7r4rs4f7bhtvdhf7scwzue@bb4ucnfxa4l4/#t

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Marco Felsch (4):
      Revert "dt-bindings: display: bridge: ldb: Add check for reg and reg-names"
      Revert "dt-bindings: display: bridge: ldb: Fill in reg property"
      ARM: dts: imx6sx: remove LDB reg property
      arm64: dts: imx8mp: remove LDB reg and reg-names property

 .../bindings/display/bridge/fsl,ldb.yaml           | 25 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi              |  3 +--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  4 +---
 3 files changed, 3 insertions(+), 29 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260504-v7-1-topic-ldb-fixes-8b3042dc50de

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>

