Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAFEC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC1D10E7B3;
	Mon, 29 Jun 2026 15:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="EvE1v1f3";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4473510E7B3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=8sQUhO0gEm6SixPxSIu1WpqPG3obYPtKTd58dLgHyVU=; t=1782748331; x=1783957931; 
 b=EvE1v1f3sq3hSHv218sFMljqwBUceJ3JkreSlrh7Im5OzwIO2qZLFZUyKhoa2+6co8CUJlkMk5F
 IdkKQjCMp9z2bI/Z9cWrk9t8AMDaf74Z5OLLgdk0U6BiBzojK2e1YqLlJ4E56BN3v7n+afFM4H13Y
 bi7vtgok7HBfOl87+2JVUJXtkVhotTd05wRR/DukikoO3yJf/8ZdBGFIWrqbU5dWuVMjNU6n5vwnV
 fYL/5/nkeWVVvrgo7TXEnrLm+YtofeQp2INqG+R9dEHh8AZ37YjTDvmrF3HygGqMmtlSN33ggMbOn
 vvXG5eIKYwx3Qi0w2OW7Ol4rEsCm22+k1g9Q==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Mon, 29 Jun 2026 17:50:59 +0200
Subject: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time in
 writes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAGKUQmoC/23NTQ6DIBRG0a0YxsUIKEhH3UfjwJ+HklYwYEkb4
 96LTmrTDr8XzmVBHpwGj87JghwE7bU1ceSnBLVDbXrAuosb0YzyrKAlDiN+TH52uC1BcJZDowq
 O4vPJgdLPPXWt4h60n6177eVAtuufSCCYYNVIBqpsG8jF5QbOwD21rkdbJdCjlAdJo6R5yzIui
 CBS/Uj2kfzrTxalBFl3nWRMlE2Uo6k7SLVRFlXrur4BFMj1XxcBAAA=
X-Change-ID: 20260528-vm-upstr-c8e7634ebf56
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, 
 "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5715; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=f6k7CqaDDr7N8lJ9oJAbbzBJB23kzlUVgp3lEF+ne9Y=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFlOU7KmbTq80LN30VOTd9Gmf+7sn73CpPl04tt1B/783
 nDVOfzY1I5SFgYxLgZZMUWWX9YKbp9UnuUGT42wh5nDygQyhIGLUwAm8vU7wz/9ltOSbJ93Siz+
 MEG96ezUr0XWq3VsRC91CHau4jT0XnuHkeF1i2cIa8z1qllhb/gnbFf7NbFRSHdxcx+HuNhZXq6
 9K3kA
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
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

In Command-Mode update, there was a nop sent, apparently the most
relevant part was the bta sync to actually force low power mode.

Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.

Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v4:
- wait on completition on all packets (was limited to long packets only,
  because I had the wrong impression that there is no confirmation on
  these)
- Link to v3: https://patch.msgid.link/20260628-vm-upstr-v3-1-9e9add93378b@kemnade.info

Changes in v3:

- Link to v2: https://patch.msgid.link/20260529-vm-upstr-v2-1-24c30671719f@kernel.org
- fix things mentioned by claude here:
  https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch1-20260529-vm-upstr-v2-1-24c30671719f@kernel.org/
  - fix typos
  - register ISR before sending packet
  - check for RX_FIFO_NOT_EMPTY also in for short packets

Changes in v2:
- fix commandmode update, need bta sync there
- do not wait on short packets
- Link to v1: https://patch.msgid.link/20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org

To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 53 ++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 27fe7bca9e2c..3f22929c36e2 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2194,28 +2194,38 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
 static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
 			       const struct mipi_dsi_msg *msg)
 {
+	DECLARE_COMPLETION_ONSTACK(completion);
 	struct dsi_data *dsi = to_dsi_data(dssdev);
 	int r;
 
+	/* wait for IRQ for packet transmission confirmation */
+	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
+				&completion, DSI_VC_IRQ_PACKET_SENT);
+	if (r)
+		return r;
+
 	if (mipi_dsi_packet_format_is_short(msg->type))
 		r = dsi_vc_send_short(dsi, vc, msg);
 	else
 		r = dsi_vc_send_long(dsi, vc, msg);
 
-	if (r < 0)
+	if ((!r) && wait_for_completion_timeout(&completion,
+				msecs_to_jiffies(500)) == 0)
+		r = -EIO;
+
+	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
+			      &completion, DSI_VC_IRQ_PACKET_SENT);
+	if (r)
 		return r;
 
-	/*
-	 * TODO: we do not always have to do the BTA sync, for example
-	 * we can improve performance by setting the update window
-	 * information without sending BTA sync between the commands.
-	 * In that case we can return early.
-	 */
+	/* TODO: find out if more needs to be done for MIPI_DSI_MSG_REQ_ACK */
 
-	r = dsi_vc_send_bta_sync(dssdev, vc);
-	if (r) {
-		DSSERR("bta sync failed\n");
-		return r;
+	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
+		r = dsi_vc_send_bta_sync(dssdev, vc);
+		if (r) {
+			DSSERR("bta sync failed\n");
+			return r;
+		}
 	}
 
 	/* RX_FIFO_NOT_EMPTY */
@@ -3233,21 +3243,6 @@ static int _dsi_update(struct dsi_data *dsi)
 	return 0;
 }
 
-static int _dsi_send_nop(struct dsi_data *dsi, int vc, int channel)
-{
-	const u8 payload[] = { MIPI_DCS_NOP };
-	const struct mipi_dsi_msg msg = {
-		.channel = channel,
-		.type = MIPI_DSI_DCS_SHORT_WRITE,
-		.tx_len = 1,
-		.tx_buf = payload,
-	};
-
-	WARN_ON(!dsi_bus_is_locked(dsi));
-
-	return _omap_dsi_host_transfer(dsi, vc, &msg);
-}
-
 static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 {
 	struct dsi_data *dsi = to_dsi_data(dssdev);
@@ -3268,13 +3263,13 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 	DSSDBG("dsi_update_channel: %d", vc);
 
 	/*
-	 * Send NOP between the frames. If we don't send something here, the
+	 * Transition to LP here. If we don't send something here, the
 	 * updates stop working. This is probably related to DSI spec stating
 	 * that the DSI host should transition to LP at least once per frame.
 	 */
-	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
+	r = dsi_vc_send_bta_sync(dssdev, vc);
 	if (r < 0) {
-		DSSWARN("failed to send nop between frames: %d\n", r);
+		DSSWARN("failed to send bta sync between frames: %d\n", r);
 		goto err;
 	}
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260528-vm-upstr-c8e7634ebf56

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

