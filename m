Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A4606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e1OW00Kr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A40C10F2FC;
	Tue, 20 Oct 2026 07:36:33 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E1210E04F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 17:55:00 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35ef6b49813so4541927eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792432500; x=1793037300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=74uvMze8U6BbGPbd8gwymf11h9qlFwlZm+CW2Kl7KEg=;
 b=e1OW00KrCskAZmyB0PItFG2Pbv7bJiHp5sgfk+nbtJ9YyHaJ3f9xOybG4HHCuy6QhG
 +/i453abDW5Lz2Kyg5lx6hnY31/aD+xti0zp91Oniqpnp3csy6X/IKXrPznkiUetC8Cw
 rglSlh1Ux8kgOem0yRKS/a0rQyCkKMC5TIZap+cBk9DWItLx3ku3LIhFQoBJ0Mo5AdSX
 LhuaSnbvphyazf/Iqo3F0EyxwvTB6VK9yLbbk/aeYSDpBRKJcYsDuskd4mw59vQdndAa
 ZrLs8w6Wfij3T0qPW6/rxzvyqWapwiZqB8lG4qvGqaeeZ0XRM9QH1xuTVgyU8Q63waYm
 2iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792432500; x=1793037300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=74uvMze8U6BbGPbd8gwymf11h9qlFwlZm+CW2Kl7KEg=;
 b=oC2Tcp73i6OF53jCiNnvfCm2JEwagVfnhnPGJtBi3/96Z9BH/VSlA8RgfErsmviKqk
 /CMQ9l/J8ZB/eCEWXD6bPvl49VThw3pdXcwUsF0mpIMXZAV6nETxp56s33kI2nwy3eHC
 CiLHd2OtAGP9dxqe5LmrdhFiy8W2Cl+tok5j2qK6SRWi2aqBjs4z5eLXajepqkoEIrFt
 Noxp2D/NalCe2YZulhEp6JpoULaPBltr/2eE9O9Rgr4fwoHr4u5s5Nu+KMQggj2kcS3O
 uv1GMUZ3AucSIbbm3psegF57+96/dHPO5J9Ao/TL3FUJB5Sn8MTxvNQ56yAqCD/9uvUh
 WeQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1c7QAuhZfQfOYKStxMbntKlmCeeabO8eGdTwITHGtrSxxJ47XprxfcMna6V2/Jf+HwrPit3cP2uw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJMWnmnf7gw0uZFDJCasVFcckJORcXcbwwqyN1KKDzyz8rZ6CuM
 DPRdYQR510sQ/cMRrX0YQFj6KMtbZlJfpxOeVf7EqJukrNBtRbMJYSQj
X-Gm-Gg: AYBFou1n+DIfJymhBycT7ZfSA2LIDJUsaLmuwGPkya/6CQD9yLU0NOHUwBFeqLyW0Qk
 7QTR+CXZ9lwQyVGe5wx1heV66KS4Mo+9tUXslM+SugqfaO+7Pzv2xJVbPwLIjwaVz9zOCRN3h63
 2k6B67IuStlfnp4U6AMPb/p8y+Nyn6GOn/b6WJQ1L0Z6aBbtKfJklqMkoTp2Ouz/2a0zOcsQoi9
 IDADqohwoFmOOa0f6IKGUGy21tugKFlcg0zxf8je8xIhlc/P1K5Q1dxPMcQ9cM8NF/gYlqlgczw
 7RHBn51tsMM/aeVe/0QdcQT5/6GZcOJFrYjRz9x0mu0O2wYkhJwdBtF7Z9Y5xUbcRAjrzgzQMIC
 zmy+tVs/X5qqlg1i20w+pm3oxQUWxWz4ZNemhf2v6R/27EE8VGWalv0hFYFtfPE/yjLrAoumlxn
 dopynyKlHZL/O/hv20PkW+aDDsNOEg9yApXHr4bWePI6FE4UOH0Lof+XLJ1pQPAEXRyLWuVjESj
 MbHKBPLKkpdVSCUShLzu5/3Aa5r3ssmpvKylL4=
X-Received: by 2002:a05:701b:4587:b0:143:26cf:8615 with SMTP id
 a92af1059eb24-18512b42d8emr13262304c88.25.1792432499621; 
 Mon, 19 Oct 2026 10:54:59 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c5cb39esm31837697c88.22.2026.10.19.10.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:54:58 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: henryzhang62@gmail.com, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/vc4: dsi: Serialize host transfers
Date: Mon, 19 Oct 2026 10:49:30 -0700
Message-ID: <20261019174930.7237-4-henryzhang62@gmail.com>
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

vc4_dsi_host_transfer() fills the command FIFOs and the TXPKT registers
and waits on a single completion without any locking. Two callers
sending at the same time, for example a panel driver and a backlight
update, can overwrite each other's packets, and the timeout recovery
added in the previous patch could reset the block under a transfer
that is still in flight.

Hold a mutex for the whole host transfer, including the recovery.

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---

Notes:
    New in v2 (Sashiko review).

 drivers/gpu/drm/vc4/vc4_dsi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 2d985bc..627adf0 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -595,6 +596,8 @@ struct vc4_dsi {
 	 */
 	struct clk *pixel_clock;
 
+	/* Serializes host transfers, including the recovery after a timeout. */
+	struct mutex transfer_lock;
 	struct completion xfer_completion;
 	int xfer_result;
 	int irq;
@@ -1434,6 +1437,8 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
 	u32 disp0_ctrl;
 	ssize_t ret;
 
+	guard(mutex)(&dsi->transfer_lock);
+
 	ret = vc4_dsi_transfer(dsi, msg);
 	if (ret != -ETIMEDOUT)
 		return ret;
@@ -1911,6 +1916,7 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct vc4_dsi *dsi;
+	int ret;
 
 	dsi = devm_drm_bridge_alloc(&pdev->dev, struct vc4_dsi, bridge, &vc4_dsi_bridge_funcs);
 	if (IS_ERR(dsi))
@@ -1918,6 +1924,9 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, dsi);
 
 	dsi->pdev = pdev;
+	ret = devm_mutex_init(dev, &dsi->transfer_lock);
+	if (ret)
+		return ret;
 #ifdef CONFIG_OF
 	dsi->bridge.of_node = dev->of_node;
 #endif
-- 
2.47.3

