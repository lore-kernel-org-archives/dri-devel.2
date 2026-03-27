Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931E510ED656
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4F610ED91;
	Fri, 27 Mar 2026 10:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="F9kA0zTh";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8563F10ED90
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:52:00 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 485AA7CA;
 Fri, 27 Mar 2026 11:50:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774608640;
 bh=zh1Sw23HpwSomtH0uJ0uw6RIlmm200Zz2iUyV3Z8fUQ=;
 h=From:Subject:Date:To:Cc:From;
 b=F9kA0zThlHiBRjPTax+/vJm73emWUDZvocC3bj+vUB5Y15M1kmB7ipcV5SeHTpF92
 axXOML3lIcnQYQeJ2n73Jvf7GYIjdvd5EhKju+ZiHnC9HWnq3BCtodv9AU0TRLyH5h
 fqVUYxODF0u43fGxFBsmd3M6rfOByfvzTr1esh/k=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/3] drm/bridge: cdns-dsi: A few fixes
Date: Fri, 27 Mar 2026 12:51:38 +0200
Message-Id: <20260327-cdns-dsi-fixes-v1-0-088edd40e97f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADphxmkC/x3LQQqAIBBA0avIrBtQU4OuEi1Kp5qNhQMRhHdPW
 j4+/wWhwiQwqhcK3Sx85gbTKYjHkndCTs1gtQ26twPGlAWTMG78kKAjs3odyBmfoE1XoT+0Z5p
 r/QBPecCzYAAAAA==
X-Change-ID: 20260327-cdns-dsi-fixes-4e1b506e415d
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=631;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=zh1Sw23HpwSomtH0uJ0uw6RIlmm200Zz2iUyV3Z8fUQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxmFJ8+LDjDi1D7VAh9ScHEye9bpryc2nDKbUp
 Q5N5rA4yemJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZhSQAKCRD6PaqMvJYe
 9bDVEACECtaUHMqdscy1abqaKSfkX4kaQlBrgQelx2hcBGm+UDfH0ozi3zmNfxqID4UOKWzdstz
 OgBpXVVN6R4aQeqxCCqXOmSgWzbllw1pPIOLFIP1jFHVEivp66MOI2JoZcczgi3RgvrIfIPcoZb
 BYiOgc2g+gPWhXd8t4U7BB0f1PnIvhVewjXNtyy7MiXrFSNKguf4//p8R/C4nZ5wtx0jMgYQo/E
 aSXmrbs6Gtx8dqh4dtHoV32mLCmQYuWDT98VEWDBvKclCcG7psCo2jjvVSIgMdvRF9w9XpOEwYi
 CcjTW46yoOf0Djh7BGUfb7PADbcTizr/hW23rXBKbPO+2F6DghGhrtxxdgiBzQhoLbmaza2gpwk
 zx8UCz70c5cburideqtvpwV9Zs/OYMZjwQdlaEQRNHIOJODsmirL9CP98HLW9KhghXnjcwyQl9p
 FgHIcKkGyS7VbrIGR/we5JY6gS4go5ErilO+kj2R8sCkfmoDFHK0oiOcmv/RmyiTUItYXWjJuMn
 0XyfLufNQ4KoofhLEBT3DpSJ9i/ePROWZ+ji4uuhimlUo9BLzoJbSbNABsUvVOYvnu/6P+nUbrM
 JgEBlAlOM4h0sp7lkMmF2XjDbG0jyIrBS1d2y6uagad/FX/bqMhJcUuLDJkLbReTpR8bkC3coP6
 BuJssxImN4hLGfg==
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

Cadence DSI bridge fixes for missing stop-state and bus flags.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (3):
      drm/bridge: cdns-dsi: Add clk debug print
      drm/bridge: cdns-dsi: Fix stop-state at enable time
      drm/bridge: cdns-dsi: Fix mode and bus flags

 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260327-cdns-dsi-fixes-4e1b506e415d

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

