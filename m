Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCEBCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE5110EF90;
	Thu, 28 May 2026 10:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UOk6PiTe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4475C10EF92
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:16:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F8BE4052D;
 Thu, 28 May 2026 10:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C81F000E9;
 Thu, 28 May 2026 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779963388;
 bh=qywb0J3OhPTJfqBTYcBrYs/kwFeeV45HmCUVbG/2IE0=;
 h=From:Date:Subject:To:Cc;
 b=UOk6PiTegeq3YwBoX41Vib0qOhNIKaY1769snO/z2mnyct9pPz/NtNTNi782H1e+v
 93nVXegQK181dA17OfYt7f6e/br6fiywWD3xInHnYrJ9ksEpeWZ6o1syJWE7Qtc8C2
 mBGS4RS58JKoQ94vZkgEPzvclFpUF9jVG6cIwLgPuz81PpdNdNUxiIPSvgBkgKLX5I
 y9n6zS9jewD8tUUZeGE038Jg9QhlDKhSc7ufkzOmvrFGfOfbhEZprGkmsCRNTMnC2f
 xw31IqkTkBEVG9ZoMod1uGMEurG1UcCVHghzbngpXNwJU4BFtXhMF9CIUtEvzkyLdQ
 VlLH3HsM+kmcQ==
From: akemnade@kernel.org
Date: Thu, 28 May 2026 12:16:13 +0200
Subject: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in writes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOwVGGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyML3bJc3dKC4pIi3WSLVHMzY5PUpDRTMyWg8oKi1LTMCrBR0bG1tQD
 kL7RWWgAAAA==
X-Change-ID: 20260528-vm-upstr-c8e7634ebf56
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, 
 "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3048; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=RPsny3VvNUoNL92N34U61K6kebn7Y12ikjdxLESjBXM=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFkSoj+1HzC/Kj7I/uLR+cUL/1/eFRDHt3+u0TnTUlnWr
 f928iundpSyMIhxMciKKbL8slZw+6TyLDd4aoQ9zBxWJpAhDFycAjAR2yKG/xFzI72VpPjOnloR
 kFnS47z7c/XRtBtWNwsrxQo1bxrXMjEybNY70JtVKcJzViS4UV/Xg+dnJYMFNyPb71W6Ke43dqs
 yAAA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

From: Andreas Kemnade <andreas@kemnade.info>

Some chips need configuration commands to be sent first, before they can
send data. TC358762 for example needs PPI_LPTXTIMECNT configured
and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
configure such chips, do not send bta sync during writes if no acks are
requested. Instead just wait for the packet to be sent to avoid FIFO
overflows. There might be more to do about acks, but there seem to be
virtually no users of that flag.

This came to light when fiddling with the Epson Moverio BT-200 display
which consists of 2 TC358762 bridges with SPI funneled through
to the unknown display chip. With that patch the bridge can be accessed,
Reading back registers works, when the above-mentioned registers are set.

Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.

Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
This was not tested on any command mode display, which IMHO should be
done.  So droid4 folks: please give it a try
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 27fe7bca9e2cf..98362b0157023 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2194,6 +2194,7 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
 static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
 			       const struct mipi_dsi_msg *msg)
 {
+	DECLARE_COMPLETION_ONSTACK(completion);
 	struct dsi_data *dsi = to_dsi_data(dssdev);
 	int r;
 
@@ -2205,17 +2206,30 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
 	if (r < 0)
 		return r;
 
-	/*
-	 * TODO: we do not always have to do the BTA sync, for example
-	 * we can improve performance by setting the update window
-	 * information without sending BTA sync between the commands.
-	 * In that case we can return early.
-	 */
+	/* wait for IRQ for long packet transmission confirmation */
+	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
+			&completion, DSI_VC_IRQ_PACKET_SENT);
+	if (r)
+		return r;
 
-	r = dsi_vc_send_bta_sync(dssdev, vc);
-	if (r) {
-		DSSERR("bta sync failed\n");
+	if (wait_for_completion_timeout(&completion,
+			msecs_to_jiffies(500)) == 0)
+		r = -EIO;
+
+	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
+			      &completion, DSI_VC_IRQ_PACKET_SENT);
+
+	if (r)
 		return r;
+
+	/* TODO: find out if more needs to be done for MIPI_DIS_MSG_REQ_ACK */
+
+	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
+		r = dsi_vc_send_bta_sync(dssdev, vc);
+		if (r) {
+			DSSERR("bta sync failed\n");
+			return r;
+		}
 	}
 
 	/* RX_FIFO_NOT_EMPTY */

---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260528-vm-upstr-c8e7634ebf56

Best regards,
--  
Andreas Kemnade <akemnade@kernel.org>

