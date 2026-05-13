Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E5CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12BD10EE82;
	Wed, 13 May 2026 13:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z5GVtc6s";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7785A10EE7B
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:18:11 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B81E2F8A;
 Wed, 13 May 2026 15:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778678282;
 bh=wJIwGQWQVF7nXvYZIy7GC96ascev6Pjy2rroRfLoy3Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Z5GVtc6sPp4nMSPPOceSEn1fHcYG0tUlRDZUOPYrPhs+sO9IGoxtrCuhr2zFxAcva
 V1ATauJlJ4WOGUbT2vw1ZayUQOIwsmmpnAFmJh59aIwYiZ3bi96NDyW0lguysRb+Pt
 eDbzaEt8Qbdq+y3a52bfDyuUELX62qch42DjR7pg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:17:35 +0300
Subject: [PATCH v2 13/16] drm/tidss: Add support for AM62P display
 subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-beagley-ai-display-v2-13-9e9bcefde6bc@ideasonboard.com>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
In-Reply-To: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=/85nzazta3ZSz2DegZrNcXTx/gK83bzKu5NpUXGKZHo=;
 b=kA0DAAgB+j2qjLyWHvUByyZiAGoEegDI1iz7h/jLtCo1kpGKDATo8OONswRA7dotGmDoL4LJy
 4kCMwQAAQgAHRYhBMQ4DD6WXv2BB5/zp/o9qoy8lh71BQJqBHoAAAoJEPo9qoy8lh71HGAP/jAX
 ACMP1m5RFBSzxnk9ZpgOoTGUyyNKTfPp1XSTBcqyIiu6hBh5jbDQuqqa2YfNUkBJIJxQMeuUMo/
 XBnlcUDY431qrEIorbOwizNQ4oatFBmQCQI6XjlmtpIg7VccLNg7QbuWUakoTse7qfNUgp9vp/i
 B8bj54PAx7o4qYzdb4xI6bOyVVQfucJbNGnQ5kd1rg8La2ndgjCtx4k6K7xel3TYJ5SfvT9amTM
 iwLQLZHLh2D55mlrTLzIytynrm9Q8SMsAyhuijcLl7PDvMrpAg0hSztVy+l85AVAGHT2HMF90rG
 H1Kj+84rOvVtIw9DpIYaAx8eDFjxXkDnctlwDLJSqC2zZJH3EEQEXQvb/VCnYQi9FEOIpoqvPUu
 twUl8yoHLpo2l+U6IltX0jOe+W/JgsANRzh+HsLLX3/Jo5Aklgj+I4QHm7MMrm0dVEiFQBYu+Cb
 0YJRvcpHIrgztJMmvjqm8cxR2vgH+IHd27oKaOIJGk+ZSjKV56tLIh5sYBoB+6wxSMsgfn3WgbA
 GDWMG9lcjOE1Zkr4GTuyYdS7mFZDerbyJKY+0OJQfhXsOGPvcBovRWNgMbAf8lY+WRA7JEPTT3v
 0AR0IJr7tVGWMqEevXMz2wJHQNPwG1L9NTpbHDDa9f9Gtk/0m199N4LQvSn6a8jUIyhOlbF8q+k
 6c6hq
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

From: Swamil Jain <s-jain1@ti.com>

The DSS controller on TI's AM62P SoC features two instances of the TI
DSS. Each DSS instance supports two video ports, similar to the DSS
controller found on the TI AM62X SoC. This allows three independent
video streams to be supported: OLDI, DPI, and DSI.

Since the DSS instances on AM62P are architecturally similar to those
on the AM62X DSS controller, the existing dispc_am625_feats
configuration can be reused for the AM62P DSS support.

This commit adds the necessary device tree compatibility entry for
"ti,am62p-dss" in the tidss driver, pointing to dispc_am625_feats,
thereby enabling DSS support on AM62P devices.

Signed-off-by: Swamil Jain <s-jain1@ti.com>
Tested-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index aef945101be4..2d056dc1c5ff 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -246,6 +246,7 @@ static const struct of_device_id tidss_of_table[] = {
 	{ .compatible = "ti,am625-dss", .data = &dispc_am625_feats, },
 	{ .compatible = "ti,am62a7-dss", .data = &dispc_am62a7_feats, },
 	{ .compatible = "ti,am62l-dss", .data = &dispc_am62l_feats, },
+	{ .compatible = "ti,am62p-dss", .data = &dispc_am625_feats, },
 	{ .compatible = "ti,am65x-dss", .data = &dispc_am65x_feats, },
 	{ .compatible = "ti,j721e-dss", .data = &dispc_j721e_feats, },
 	{ }

-- 
2.43.0

