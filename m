Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A2606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hE2emNtp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C4210F323;
	Tue, 20 Oct 2026 07:37:02 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6076610E04F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 17:54:44 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1517bda04a0so1839235c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792432483; x=1793037283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C7azmWjrPYssETtnPifTR3vECEnxH6JPytoZCfuGPLk=;
 b=hE2emNtpwoCopduIFLyENC9VMkow22hvHAzcW1RjujBMFJweFghbutKsVHaygKXG8X
 1Ra77RWO0Gu3cefhd28cwFDnSSU5X5h5Tn8g0MJAu4W0YK4OlaBHeE1oUP9udO3o2pUS
 Sl5mcSAZSzo2E3JE7ci5Gx9W4SiM6S9bMjKQnNxPtpRTbDpYUDzBclkQH4GQKYww7efH
 8gKTRKzQ+sXqUHS2KdYRdDEE/Y0wSGht8G+/DmBMwM/FjIa98YneTjMei8EuZAheUANG
 Dqw3pjypvrPYSw/3ib3I6JnBVZYOuChWMBpLr3cdFFmfHdYmZoIJbqG+pek1tY+eIkq/
 6FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792432483; x=1793037283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C7azmWjrPYssETtnPifTR3vECEnxH6JPytoZCfuGPLk=;
 b=vPhjS6rGoy79k7vc0n9zCqllbB5iKhXBU9FDtuqigabU76g4Wf2/jM6ArzZDkr2AQu
 lh/yx+KdaZq4GF4vPqPH0sIvUS+r94nqfxqY+3m5vQ+pwMVYxOCzumef7v7vEC2zzMkO
 dIj/kJkIYxCizVd9j6renr1r2CWv/+q+jOslzBox0lrZG0mn68EH/SQmLnU0MU5FRv3x
 Oinr45d1YEbyKj2Ov/HC4557jmNB5zFOWTPQu4byLviX32da9a+Xc7dcrDJuFPExqJq7
 RublGHv2FQGLRUUknRVqVb1RdsFSB1svTdd3+S+SXJmpnZQc8apLXRoA+N26cQI0dmZf
 zixA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqIO4S2orSnwyvCUFwy32gxZwfYAk4LP2Z3boyzjX/m+pwfMMTRzGc1tjivYh39v/1pGaiHo7hNlA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLW+EO7Qmi6dmero1gPAQHYmyGc/fmPy3x8EmisAwJ7IvmA2ReL
 /lPl7dCAfHmvkj9rakADZr3JTtuBmw97fOLUPeB9sDyml7hUh95KEpCMy7kWpqjY
X-Gm-Gg: AYBFou1u4ybkeC1W3ERXHZf4R1DpwRe4lZR2W8M1CldZ/BUawWsEl4Mt79podb2WZ7u
 +XJpTVMynpY5KbglyqyAIJ27pmFEenpAI9ypCwtWHbQY7/MoB44zNYtOOIu37WLB9voYkM7xKeL
 obsJRovT3lcYwR5G6TrJ6meU836oFuR58/zhBF+KjF3+scVrxoLypU/1Gi27RWs8KXm5PznzpWO
 uDbRTLjrbJRVJTO5vDP2DviGB0m7qhNKx/40ASMHjsqeBmn/ibNhZH1hoo6hUflat4XaKv+hxm0
 VTZnnSRKFM40SZ56GZKa0PZSShTJJKQL8MpwsQ5niJXn4NnlrbHz+6BuiPePm2xi+qOp/MzMfPJ
 2TGS4v5qbKp7wiTszfNRTKMCa3ucFu5xo+K2WWpkznmoYWtihnpgsfv0kopRPm+I048pMu/CSb9
 9Yn+Jj1YBpTRZS7r0HjbkFfasJfQm4pHoa/fdWTHL0huXLNAbCTB/ieaYxrm0DB4NGqMf8cpzmC
 aTHYC+y5Il9nGiBgEr7pklljrW+UGtR6z0tLuw=
X-Received: by 2002:a05:701b:2092:20b0:168:3243:c907 with SMTP id
 a92af1059eb24-1851238b3cbmr13066525c88.24.1792432483063; 
 Mon, 19 Oct 2026 10:54:43 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c5cb39esm31837697c88.22.2026.10.19.10.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:54:42 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: henryzhang62@gmail.com, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/vc4: dsi: Don't return error reports as read data
Date: Mon, 19 Oct 2026 10:49:28 -0700
Message-ID: <20261019174930.7237-2-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019174930.7237-1-henryzhang62@gmail.com>
References: <20261019174930.7237-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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

Notes:
    v2: no changes.

 drivers/gpu/drm/vc4/vc4_dsi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 5ed3c35..5452b72 100644
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

