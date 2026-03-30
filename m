Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FDF1061B24
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 22:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE5210E05A;
	Mon, 30 Mar 2026 22:47:01 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD0610E05A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 22:46:59 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 98CB01F8004A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 22:46:57 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 1AA88B2EBC6; Mon, 30 Mar 2026 22:46:57 +0000 (UTC)
Received: from shepard (unknown [192.168.1.65])
 by laika.paulk.fr (Postfix) with ESMTP id F354FB2EBBF;
 Mon, 30 Mar 2026 22:46:29 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
 Marco Felsch <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>,
 Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH 0/3] drm: lcdif: FIFO underrun/solid color bug fix
Date: Tue, 31 Mar 2026 00:46:16 +0200
Message-ID: <20260330224619.2620782-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series brings a fix for the FIFO underrun/solid color bug (in the
last commit) and two other changes that may help with reliability.

Paul Kocialkowski (3):
  drm: lcdif: Set undocumented bit to clear FIFO at vsync
  drm: lcdif: Use dedicated set/clr registers for polarity/edge
  drm: lcdif: Wait for vblank before disabling DMA

 drivers/gpu/drm/mxsfb/lcdif_kms.c  | 42 ++++++++++++++++++++++++------
 drivers/gpu/drm/mxsfb/lcdif_regs.h |  1 +
 2 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.53.0

