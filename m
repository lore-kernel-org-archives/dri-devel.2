Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8432D10ED651
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E278710E2A4;
	Fri, 27 Mar 2026 10:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZWdCyNGf";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D996D10E2A4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:24 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 68DDC1E31;
 Fri, 27 Mar 2026 11:21:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606864;
 bh=rFlR/KJjk8JvLcGeo7Hup6fk2H2/TOVCbprtayPMB5U=;
 h=From:Subject:Date:To:Cc:From;
 b=ZWdCyNGfVWZXl96lO73QEIsmvVYQdrEhmwm5JSCPqRkN+yCS0p++rIIJVPPJMffRk
 gaq01f4MOqv/557+szEr7NmGG7dkro718R6lPVEYKqqsAh62zkluDHlAMCzbN11QgV
 4jf2YR8nNnnLS7xg9iDU1y/eEoSQ28Nm7v5cl99M=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 00/12] drm/bridge: tc358762: Various small fixes
Date: Fri, 27 Mar 2026 12:21:48 +0200
Message-Id: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1axmkC/3WMQQ7CIBBFr9LMWgydymBdeQ/TBcJgZ2Ex0DSap
 ncXu3f5/s97KxTOwgUuzQqZFymSpgp4aMCPbnqwklAZUCPpDknNvjNnS6iivLkoikRktA6uZ6j
 SK/N+VOc2VB6lzCl/9v7S/ta/qaVVWpGJJ9sjWhfNVQK7kqZ7cjkcfXrCsG3bFyOx1KizAAAA
X-Change-ID: 20260326-tc358762-fixes-6f666500da9e
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=rFlR/KJjk8JvLcGeo7Hup6fk2H2/TOVCbprtayPMB5U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpV3siXQMDOHBpticUpM6imH6SjD7JqHXtT8
 UwwqIK4rXaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaVQAKCRD6PaqMvJYe
 9V5aEACXLKHcPJ/G/2Fr1kMnVI/+MKtHizTB8cLEDOFRn4SeS0O/qVg5NlXsyxmH1OLp6x4WD0n
 5QlqIv4jpSpYSdgoMk/kH438Q6ofzs8jiIbdV2wJ2aqhGLcAM35aMg36GyiHHbzrcSCM4bfL+H+
 h9HYRgd+XO4e4VprPSJ702DJZGx/jxvmcJ5WJpmEM8xfESooLmnsiBENOTMItHBuVWlQ14YP0an
 NmPE8VmpZKWM4Rhx9/ro+nEX5lYDh3VrbVRQqpPKUneeFLxYhVNkvvyl4EQz5CqnWx9jWHT/j7I
 WX8ETImBrNiwiVQqO/5ino0xHtrL5hGj70Vx57J1hqgkZ5spX5DVZ3OfpWokWUXcRJ1KDZxZtw2
 USBOWq98VlQTF3oghNQD6/H6YxTYxKLbNzfmXANNZwFFDMARUwn5VccQejujIn7K9Q9BM4QLVGY
 oc337aBreiH1seMC70Y7aLIzcVPDsJN3FIJldOUXxKxbcJxXswXX486EQnVOxJVd6mgRfrSg0dW
 1qIdeBIjZWFzfJt74ghkj0AFs8vmex3vlHznUGgIWErolvou0mO2xqzYDwe7gAsxCsN17J0iCmO
 j70zLWHQAvrYm/0dW42iw/HHrugEPNy168IBzsC04puH24xpqGaeLa/0KQmYChKhnF6UOKiW/k3
 WG6A9bNzjT5EX5Q==
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

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- Always enable VTG. There should be no downside, and it fixes unstable
  hsync
- Add four new patches at the end
- Extend the patch desc in "Drop SPICMR write" a bit
- Link to v1: https://lore.kernel.org/r/20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com

---
Tomi Valkeinen (12):
      drm/bridge: tc358762: Clean up register defines
      drm/bridge: tc358762: Improce SYSCTRL register defines
      drm/bridge: tc358762: Improve LCDCTRL defines
      drm/bridge: tc358762: Configure SYSCTRL first
      drm/bridge: tc358762: Drop SPICMR write
      drm/bridge: tc358762: Improve DPI enable handling
      drm/bridge: tc358762: Update comment about the number of lanes
      drm/bridge: tc358762: Support VTG
      drm/bridge: tc358762: Fix sync polarities
      drm/bridge: tc358762: Move tc358762_init() into tc358762_enable()
      drm/bridge: tc358762: Drop drm_bridge_funcs.mode_set
      drm/bridge: tc358762: Set DE_POL and DCLK_POL properly

 drivers/gpu/drm/bridge/tc358762.c | 202 +++++++++++++++++++++++++-------------
 1 file changed, 136 insertions(+), 66 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260326-tc358762-fixes-6f666500da9e

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

