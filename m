Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF64606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNHzdq59
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E71112047;
	Thu, 29 Oct 2026 07:59:09 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100E410E6CC
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:46:17 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso66676eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205976; x=1793810776; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nVp2xwOFbAzbZYwoIV/veWLs6VENy+j34lM3/5MySVY=;
 b=oNHzdq59RreD7PzG9FuxMjZiuMPUCKO+yB5WJ4zOJzocCjk66oJFVD61rcnmTkoq6b
 SC7kQvCPUUZT/6yFg7sbDJnqm5QilZhu0YWqMzlGWtzppVfevAflwrc2+SFX19juaZvs
 pLR/zrER90oyiimPL5l365tqfhYkBKkiDgM4kp33wG18uMJbLZ+lMYHgsH+G8o1nvMRu
 x4HoSZhZTp10Z5LyC6IGCpz5jsxK+FFxrjth4oP40YlM7uJ+YoS8+1UzO+br4ShXl2j8
 Noxl2MAG01Kg1fcNWKfrIM8RNGBJ+8w0d62tlN5b7DdB8e/TtE9Itnr009DpJAb8iZpu
 myHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205976; x=1793810776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nVp2xwOFbAzbZYwoIV/veWLs6VENy+j34lM3/5MySVY=;
 b=vuzN9pKbULP2/e+LUwA/CrhEYcWEczFuwTDTf6raqYbzEpkbIJBj05BTkWHdZoi3Zb
 uLCOAQ6sWplfpku8oLvaAf2D+ffnOEo0mEAH9jG2ZDnyQz6PTu4bVUb2FAT77mxOGxoO
 foFk4/CNPIe2cM2GiyK4dnAhsA0s0wCwTeaJZx3GXuXwdMwpF1TRbjXJv+wBIPDQaj7p
 S43g7P3BSP7qVwde1guONOnrtOxr5UNbf5nz0p6iAongS1UrrebVUdnBP1AScLOBjLnq
 td7n6ZvGaiD+LIr87eCEwT3vkvnrhzywdif0Myh9K+SDCV82RavlMusliwNMToC2KwWh
 cbaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBybQIDHVNSbV1Sxx6x8T/KBqzNU9q1rEC1VxHeb+crgqbcd9PKFJ7KKJlgb5L50xM890EBa50KxTh4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJhZDfaRl9egKI24jzMjFx07Xr5OatQJRxOSF5zntljo1wrWnX9
 Y6NVkr9/2lqUA7mIoP8qAEqb79H2GV/Toql/J9okOSlFRRidR7SzLNhv
X-Gm-Gg: AYBFou1e/hDmd7LOpBe/40J+31+rYQ0bIj4XnG5MCp9YEITyun+mjwHrIg2IYPr3Fvo
 RbiekmdwtjpKiVV7DyxO8/5Tatsb66USNODnTewzdhwZnMwi/auectjeR7eUiPi4uaz8H+2uosq
 F93nZHAk+UOOJ/8ssKBGJc9PkvJ8ZklsI1izBEFpGZG7ucII+qJo+BRGjtNCT5uPf5cyZWOtMIg
 PKHNLuyc2Jap0z0B/1+Gz4YteibZdblYLRGWWiXwD+SiKajyqVulwaC7TjkQs46CEGbjRbGVVTc
 SKpS0nak6y/c9dKk2YeTH0xHfASPQxHphyluM3qIQjErArzshNzm0o2gGk/wPJpBEtq4DcDuX5P
 CzIGu2i1J7wyA88MJFizKthsrMYa+WhpZG8HnbsZiV8JmEfZTRzC+PpUMn86yXSyH176ANM+HNH
 FRZNFfG2r+tVmcuclBLxMYngy9acKTdqABWEzr71NCmh3ME6gGY95iJojRuwGwm2+CiO3KSgPMA
 hqV7Jqvv8Y+VMmZ2tmLCQKl0DfzHafo/Bi2dYnrndMOiouo0aP8L2Iq7pjdb1S5FC7S6ywMZirV
 PUj0eaZOxJ+lsWHkJiHUNYV+BQbnAfYdJjPzMOutT9qzOieUBoWC3MuMlx6bwXMd2ZQLoYI=
X-Received: by 2002:a05:693c:60c6:b0:369:fd32:79fe with SMTP id
 5a478bee46e88-36a203cd26cmr4554102eec.17.1793205976186; 
 Wed, 28 Oct 2026 09:46:16 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23908449sm7821964eec.11.2026.10.28.09.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:46:15 -0700 (PDT)
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
Subject: [PATCH v4 2/5] drm/vc4: dsi: Don't return error reports as read data
Date: Wed, 28 Oct 2026 09:45:27 -0700
Message-ID: <20261028164539.3471833-3-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028164539.3471833-1-henryzhang62@gmail.com>
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index aa2b46fb0..1eea60aec 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -39,6 +39,8 @@
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
+#include <video/mipi_display.h>
+
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
@@ -1299,6 +1301,24 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
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
@@ -1313,8 +1333,6 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
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

