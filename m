Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DF9CC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE9E10F57F;
	Tue, 13 Oct 2026 07:53:05 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0FD10E5B8
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 19:03:30 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-35b647aac23so663303eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791831810; x=1792436610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gg30uP+2zT7F4nzhITDGMjokMeqKShVAiesVP2byYZ8=;
 b=Pehe1BtM6Rm4SfX+16vYd7Pr7kdgp5MCdwOPojlBo8G2C19KbZMfJ9ONtWNnoPxWDx
 nVe2dnpGfVVjgXsF766WjszBylWjRQCgeb3OMqVJFrlIwIbw2QF2AzjWCcsrMEMpKQPo
 X8DFs3joYYCt5M1AgoZi6EMbsRhDC47yCc1NnO3GWifCFcwbB05fwttSHG4dyIW4D49O
 P2HQUaYVeh2MHrmnhLYkLmP2pYG+ZiGvfokrr6cA8IY7/FGbIEWYj61CTQU0U5N6tVy2
 dnUxeK83jMaCmp0ZURolH221x0Kjn5HJLScVsJYhkW0eITAHcf0MSTEo1Yeru1SkJijL
 xJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791831810; x=1792436610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gg30uP+2zT7F4nzhITDGMjokMeqKShVAiesVP2byYZ8=;
 b=GyxqxyjvjX44OxiMyfCRLoqtr6SDrLnacuI7RSbbd1nhi0yiziRVQ5J7Oh+LKcKMrY
 eqhMJ5J9vEQsfHD7PQ+//5aLf7zSh+6GP2juAp4joRs/VnZUR3FH6tOFIxJ4Ez9QYycn
 pusZQhyKbRdoaDmg3zfmwTdxO+AkA+kSR8wzGBr+FLot+WW5gUjwCkzE/HO3qbTvkguT
 X3lHq5QRzdRu6rimZHjAlfAqa4D/Iu5TT55/fUh2d4RIQT/odc+ZiU5UsikKikoDKowO
 VnQuN4HSPDJjPyQhBDoYjwNBtsookA39o5HhNAVPxUjd188SfzQGD8sbNb8UtjK+NaZv
 7icg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydWDK60eg1hTakpIkizQ4eo5s1wI8YutL4FlQ08R5tqQ0BbbUvoiAlVPfYw7Vtx2izABRBWbvzGK0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJKk6zZCqqCEVhqI3QKNAM+uKrjC7HsGhbQStOIhBbqN0kele1S
 vZAAbkn+R75LXJW7A4/LdziRXLCk5tjEvzFazplFrasPVEgoCs41RO3N
X-Gm-Gg: AYBFou28qLh2+xJsu2O5q/edVfXTVtU0sGcjb15g4ClbOoMIoHr+PwuWbJIiJjyDLDg
 MpbMovlfJxzxi9BubiIBePtvkfR0zo+G3chG2BD2+Y7X2GrD6s2bttDDL/XPci9ZPUsm4by5jqZ
 JXE1w40iCrJ1KPbkpi2g6zab7NQWQogSU0R/zhJRGztGcf2A2itIV+5otREJ+ujyoef8Z+IBMte
 +GEcDZJ7dE+lXMH240ZfhVKriWqoKzol4Np5T1fHogJBRbYmANnQGlI5EiFP5XU84Ww2iP3d6R4
 L3ConmIsDbcMasH6dbqwMJdFTjrC3vlOVgU9WtaJBA7Kxml9xG49DxeMsHbZfkhBAYXxKtPJuGv
 82PH9f6mts0Uw5WAJ09fh39QmeTWMh3nIfupyW898Z+BiRucucLgHjX1M4WvBB7Y4+eMmVreV/s
 IGupKrPGEkmSfH6jzAn8yxINDqVRtygD81Sx9ENFJrBOgqIsc/g8HT6dDeiKzUl3r3Yx/Z2QyKb
 tJJEigoG7VpCQoo+rq96vtCxqT7+ysmLUQYLEs=
X-Received: by 2002:a05:7301:6794:b0:351:606f:2832 with SMTP id
 5a478bee46e88-3537df77e03mr19422574eec.3.1791831809517; 
 Mon, 12 Oct 2026 12:03:29 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a279sm35501602eec.30.2026.10.12.12.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:03:29 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Henry Zhang <henryzhang62@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/vc4: dsi: Don't return error reports as read data
Date: Mon, 12 Oct 2026 12:02:42 -0700
Message-ID: <20261012190249.3167-2-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012190249.3167-1-henryzhang62@gmail.com>
References: <20261012190249.3167-1-henryzhang62@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

When a DSI peripheral detects an error, for example contention during
the bus turnaround, it may answer a read request with an Acknowledge
and Error Report short packet instead of the read response.

vc4_dsi_host_transfer() does not check the type of the received packet
(there is a FINISHME for it). It copies the two bytes of the error
report into the caller's buffer and returns success, so the caller
gets the error bits as if they were register contents. Packets
received with a checksum error, an uncorrectable ECC error or
incomplete are passed on the same way.

Return -EIO in these cases so that callers can tell a failed read from
data, and retry if they want to.

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 0148f2b..c092a1a 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -40,6 +40,8 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
+#include <video/mipi_display.h>
+
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
@@ -1300,6 +1302,24 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
 		u32 rxpkt1h = DSI_PORT_READ(RXPKT1H);
 		u8 *msg_rx = msg->rx_buf;
 
+		/*
+		 * A peripheral that detected an error, e.g. contention during
+		 * the bus turnaround, may answer with an Acknowledge and Error
+		 * Report instead of the read response. Don't hand that, or a
+		 * packet received with errors, to the caller as read data.
+		 * Bits 7:6 of the Data ID are the virtual channel.
+		 */
+		if ((rxpkt1h & (DSI_RXPKT1H_CRC_ERR | DSI_RXPKT1H_DET_ERR |
+				DSI_RXPKT1H_INCOMP_PKT)) ||
+		    (!(rxpkt1h & DSI_RXPKT1H_PKT_TYPE_LONG) &&
+		     (VC4_GET_FIELD(rxpkt1h, DSI_RXPKT1H_DT_LP_CMD) & 0x3f) ==
+		     MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT)) {
+			drm_dbg_driver(drm, "DSI read rejected, RXPKT1H 0x%08x\n",
+				       rxpkt1h);
+			ret = -EIO;
+			goto reset_fifo_and_return;
+		}
+
 		if (rxpkt1h & DSI_RXPKT1H_PKT_TYPE_LONG) {
 			u32 rxlen = VC4_GET_FIELD(rxpkt1h,
 						  DSI_RXPKT1H_BC_PARAM);
@@ -1314,8 +1334,6 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
 			for (i = 0; i < msg->rx_len; i++)
 				msg_rx[i] = DSI_READ(DSI1_RXPKT_FIFO);
 		} else {
-			/* FINISHME: Handle AWER */
-
 			msg_rx[0] = VC4_GET_FIELD(rxpkt1h,
 						  DSI_RXPKT1H_SHORT_0);
 			if (msg->rx_len > 1) {
-- 
2.47.3

