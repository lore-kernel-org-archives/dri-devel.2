Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B64606A333
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=CYUi+Zjx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FED510E856;
	Tue, 24 Nov 2026 10:08:42 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DE710E856
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:31 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11D64DDE;
 Tue, 24 Nov 2026 11:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514757;
 bh=A1AjQIfR+LVh5QY+tWaYnITJZOQod6xmvpTtTt76hb4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CYUi+Zjx6zj4PmjBv8Ge5i2HTAtcNJ+8xXCYw4qrEenyMXawP0FT4BjebQcxvzeN6
 PAKQ8FUu47lgSuvQU4EMg8aVGSd6pjEkpQyXtPZq/6SeePax6WUGulyKT4H9XSQK46
 Ka2eQ+Q4X2wV+L7xHUrdbOg6XNHMKA1PwXRSMNAE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 24 Nov 2026 12:07:53 +0200
Subject: [PATCH v6 02/13] drm/bridge: tc358762: Improve SYSCTRL register
 defines
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc358762-fixes-v6-2-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
In-Reply-To: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=A1AjQIfR+LVh5QY+tWaYnITJZOQod6xmvpTtTt76hb4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWIWyy1xI8TNvOPi+lJ8YztWDk1twL8rjcAFf
 Z0//EkA/e+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViFgAKCRD6PaqMvJYe
 9WzVD/9v08IViWYGQbafTWpCEUfIIHkDUj5fG8foHMIgG7+o7o0j/NVxpyyQ2v4pVt/dHf784f+
 KyysYuB6PtIUd40Pdn3fDwei4mEiN7EwbGAOZtBzGA1BPfvPdwIowpyt4PKlCyL/2MP+W3GIJoO
 vOeM2X25jXHGrK4U+yksILM2jXltNmW/YlIqKlgpVsVFqpoIRGu7caj5a0yWMUbxXz2RwZ1oVA0
 q882XZEpx45xqH9YbNL5qlZ39dFX0tEC829t9GPWCUtJAcn0IV6bIUwXx+u6xzrynWJsZv6Dqai
 Azxksg8+LQw1lMFWdboUpkTzf9wFNDD0jNXzhUi+5k7TsTdhyJrFXaHmD/uKHelHZrNswBLvxgj
 jum726Vpx7DZal2ipy+rb37e4kU/7wkLRLmn4GIetcVROOH6FwJ7on6ujkaHJat4xi26AdtDhMX
 Mi1eZtPzYuvk3rZz5PPYxd2UNXM227mUGpYZRp5xOB4AphmCGgriyU05iRBh/IWuPLa2tWEeJ7l
 WOZtEHt7Ny3gIpWfTrj4MIG/dfA+ZP6cRDxPvX/4JdyEXmLj54kgbj24KYehE3IxZyelJQqVvM5
 s6jJc+AytJ6Slfv7Jn9OKid/VczZHsqqcf52M1TFh80xzIfvG14rfhmhSN4owYZuPMaaLhvEDCg
 r3Y6e0wbWe7WsUA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Define SYSCTRL fields. No functional changes.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 097d2f331a16..59c68432f8e1 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -10,6 +10,7 @@
  *  Eric Anholt <eric@anholt.net>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -63,6 +64,19 @@
 
 /* System Controller Registers */
 #define SYSCTRL			0x0464
+#define SYSCTRL_DPIDATA_IO_MASK GENMASK_U32(1, 0)
+#define SYSCTRL_DPIDATA_IO_1MA	0
+#define SYSCTRL_DPIDATA_IO_2MA	1
+#define SYSCTRL_DPIDATA_IO_3MA	2
+#define SYSCTRL_DPIDATA_IO_4MA	3
+#define SYSCTRL_DPISTB_IO_MASK	GENMASK_U32(3, 2)
+#define SYSCTRL_DPISTB_IO_1MA	0
+#define SYSCTRL_DPISTB_IO_2MA	1
+#define SYSCTRL_DPISTB_IO_3MA	2
+#define SYSCTRL_DPISTB_IO_4MA	3
+#define SYSCTRL_PCLKDIV_MASK	GENMASK_U32(11, 8)
+#define SYSCTRL_PCLKDIV_DIV_2	2
+#define SYSCTRL_PCLKDIV_DIV_3	4
 
 #define LPX_PERIOD		3
 
@@ -136,7 +150,11 @@ static int tc358762_init(struct tc358762 *ctx)
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
 
-	tc358762_write(ctx, SYSCTRL, 0x040f);
+	tc358762_write(ctx, SYSCTRL,
+		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
+		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
+		       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
+
 	msleep(100);
 
 	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);

-- 
2.43.0

