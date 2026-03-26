Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD23C10A62CB
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFFD10E213;
	Thu, 26 Mar 2026 13:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CyKPZiuZ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B702D10E1DE
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:36 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7744D666;
 Thu, 26 Mar 2026 14:11:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774530675;
 bh=/VdVfQ5DcjjGPdGLGIAdXKpQQegOwIrcYz0ZDfZq5Dc=;
 h=From:Subject:Date:To:Cc:From;
 b=CyKPZiuZTX/aJBjsuv+Im72JhqBXlXkM7ych951TwtRpN4PWervZvLyvRyZjX14W4
 Wh4WhintUTKs1dZ7VkA0tk6D9x12m5LMhzTmkca1ZwY9F/91lx6j1jx1dNqKwDxjRd
 WRTaHjr0aPVu2YwrY5irIQOPjShMxH0L5qObgaws=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/8] drm/bridge: tc358762: Various small fixes
Date: Thu, 26 Mar 2026 15:12:10 +0200
Message-Id: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKswxWkC/x3LTQqAIBBA4avIrBNMcfq5SrQQHWs2FhoRhHdPW
 n483guFMlOBWbyQ6ebCR2roOwF+d2kjyaEZtNKojEZ5eWPHAbWM/FCRGBHRKhXcRNCmM9Mf2rO
 stX6dHuaTYAAAAA==
X-Change-ID: 20260326-tc358762-fixes-6f666500da9e
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=/VdVfQ5DcjjGPdGLGIAdXKpQQegOwIrcYz0ZDfZq5Dc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxTC65z2jsIMej99vuFYbhz+gZlO68ejkae4gE
 ZNs1WDPJEKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacUwugAKCRD6PaqMvJYe
 9Zw/EACrBc1U8Zii7WHBxopOuC2kgAfhlOhA9MJVqddt0o8HMkRRSYSNrOqyxsfWZc4u18ZnkBI
 0SxWDcFEUa8tvObQxjyetUAZKdJ/9/N2bW63Bs9Qo/yuZQec1q9DvQ2VklvZMmTyNiyZKktcZJr
 Mm2zv49j2eqC6qjzoly7zaudTcVzV5Q3hfckDHWt2OttUutA2B92+BI0nglH3ouyzceNuUHyEwO
 mXkvpfGRczjwhN+V5W5WhZfn494zyhRBjKIRzAdH69dPLNyfyrN3AjIVzdQlTXuZICQCmt4Q0tq
 6LB9XxYyS+2DWGXkyswOznWvCHV1GI2Dslh0dIhNuF69FP3P0BKzdJ+CIwIlGhMtWH8lmlYPqc/
 LF6cCPozZgXKmyTNWYbwAJwexq/yMpw2ihuQJMisO2H5P3OiuMw68KrVEi6nsRlig6ynzl43u83
 txs8/AKR14lGuIvjpTgObe2S98axnoHK1HSO9zp6v3T9CeIKl49o51ftYTotR7e9E+wZ8dqs40h
 DRaDScJGCNq+5RlU/GtfTOLLDhYplZ9q+x+QsRdjzfwYOlk0NgpD7Cqi4BNBJZMwNTyVluWnefd
 EaYJHrdAcyhmKPmHJsZx5u5GzIoEMS2JVVpFRMdKZbsVsvqsHA1m/ptTz7jBBOHFCXa0dZMUu8S
 y9lPd2zkpTAo6Fw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

While trying to get Raspberry Pi display v1.1 working on Beagleboard
platforms, I noticed various small issues with the tc358762 driver.
Unfortunately none of the fixes helped for my case, but neither did they
make the issues worse.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (8):
      drm/bridge: tc358762: Clean up register defines
      drm/bridge: tc358762: Improce SYSCTRL register defines
      drm/bridge: tc358762: Improve LCDCTRL defines
      drm/bridge: tc358762: Configure SYSCTRL first
      drm/bridge: tc358762: Drop SPICMR write
      drm/bridge: tc358762: Improve DPI enable handling
      drm/bridge: tc358762: Update comment about the number of lanes
      drm/bridge: tc358762: Support VTG (but don't enable it)

 drivers/gpu/drm/bridge/tc358762.c | 125 +++++++++++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 29 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260326-tc358762-fixes-6f666500da9e

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

