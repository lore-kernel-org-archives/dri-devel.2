Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01146606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rz1eRpvl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D337410F335;
	Tue, 27 Oct 2026 09:32:05 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C9610E37C
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:16:58 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso5507606eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793042218; x=1793647018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V7os7q6ROONwI3bHWhMjwfZ8GV54GUpgZwrMIsvJS9k=;
 b=Rz1eRpvlWcAGQqMhi13FC5LCV1HkDYwvf0fbTB0HdRXUb03EmrIzOQPfS24o+v+V80
 ViJehRglurID3jVO35pL1Vl74RfVypwrsa7zVK5uN6fWl+MyjIVFuUy4eI1f27KWBQ5l
 xNOHitaycyrtV6z+Avwi/axjM1DJlVMufXT8djdG8dXKcEeUYRtdvQ0ZI1ZPnv1+HLDF
 PXvdssQ/WdgN4SCcmNz2AiBoAXM5JI+kDK260Un9XeYXVha91NT3yOeo7i4YY2PErCUO
 O4EkdnXxkxmGcyv66lVm0GfRA90tK6qTQ51S8SIZoF9toch9EerWeFZloGY+Xd79ibsB
 nOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793042218; x=1793647018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V7os7q6ROONwI3bHWhMjwfZ8GV54GUpgZwrMIsvJS9k=;
 b=Cy4MfxXmaRBSRGFGmLuSfGKRGx58MPWZP4ImntgASZ/gX5kK9T016cD8NRfyvgGrnM
 430KlxXwP24p43kK4BTHMn5LhM3o7ysZuubw+d5Mtd+FbXubMvQkmNQ1X4GWuldIemJu
 eEz6jWGT4rofLTKK+7a4sQzKR1ov+FA461qfQByATm+e6u+qmi3hjwcTXp7mvg43D3pF
 BBUwg2pKBPz0iJaLhgBQV0kR6bVl2gIXGeegdmXYXwSWAqgO3c4/S0jub8XUfdW6xtUF
 dzHqlF1GO2KwgutzJmm4RTNHbIpaHyzC4rpskiGR6/ci/BhhpNN2/zFuMa12Ylyas6Zf
 ZYSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxic9/1ppb0HItgPSKtY7INoW/H8D8ri7blSDDGeOAsfWYGO42nQJGyw9jqeTBDREmowjxZPbHP09E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLex3KFRQ3KtAFH4kifI9CcIc0kiDC4xUPfRqWrImt3p4qRdD1M
 Ydb9L6wCurXdX92v0Z7RmYXITEydGDHz0sfnau1+TcIEv41+QKpw82q4
X-Gm-Gg: AYBFou1KmMERY9O8o5ZxPjvmThUzCkdNovDXruE+qB/1XcLJP2Kig8NcL3JOnE83qzH
 B2DwuKPxyJ6IDRD1BpBfaeCZ9rGKvh42zjq9UyuRFeZRnP8XpsBLzivIDJjJmmL4wuMAbVvYPqv
 7akU8InO0yL3CcsszG69pE8xG20bYgbrUo3TfRoEPIN7OpEiimBMePqF9ybvMtIsyMtqY/Xsh9J
 EAuJuo3E0K8IIGgaIgua+dL4UN87+QQI3ThWQrOXWomsxhYNHCRIySpLUP6kncYl77yIBImnjtP
 +bFN4eSJFsn4gLAncRYHE8BzK2ID6da6MEY49tPrjqtj9zuPaFJS/nvH3m2b9nm2Uwft/dlTvuI
 Y0pyF0mra/5SrcyREuRjrXEboRHQBhcJmxx4lrasKUuxd6DfxDPlPG8pjH8OvlG4BF++sOS3FWc
 kLz2qEayGuLNNH23f34KP/nI1TRf3TZS8KC2SW32GqXVS1ZGDVNp52ajnmP5O7Bq4OEeLYhEjDi
 l0HBdJ3lqfiT6xefLT19OZFF4HLG2YAGpj0GkdJM2AuRe/OSeps0fzS8M937EyKR8KApdUzpmRO
 iZi7nGJiHVK8i4uP3onM
X-Received: by 2002:a05:693c:4015:b0:369:d992:e3 with SMTP id
 5a478bee46e88-369e8660a6bmr10838577eec.32.1793042217669; 
 Mon, 26 Oct 2026 12:16:57 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a01fa4c58sm25348449eec.21.2026.10.26.12.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:16:57 -0700 (PDT)
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
Subject: [PATCH v3 1/4] drm/vc4: dsi: Don't return error reports as read data
Date: Mon, 26 Oct 2026 12:14:55 -0700
Message-ID: <20261026191618.9430-2-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026191618.9430-1-henryzhang62@gmail.com>
References: <20261026191618.9430-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 5ed3c35ee..5452b727a 100644
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

