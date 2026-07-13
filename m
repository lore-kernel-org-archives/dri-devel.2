Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430EBC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2EF510E95D;
	Mon, 13 Jul 2026 12:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LtuU1onj";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4313210E958
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:10:40 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so3205866a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944640; x=1784549440; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6GCAuneNa/1gKb9DW8CBD7WKj6dTVzcbk/e+PXY8YBw=;
 b=LtuU1onjwiScCNIj95I8KSWgy03xuvGRcdC+2emJ3oYw7O7+98j+vsiqg6Bo6DddPY
 O9sC9XEiH5T2bKfpsZ+y5pyr8y1TPByoCyTK8szWlNmAT0oJiCpzjrOOHT1JX3l9HP6q
 7NSkLzjS8xMB1CapXZZVGDeyk+Y7Ri8Vi8o6KripA/nz5UZgY1diM9jJILHrTJTG+SzU
 BUP8nQ7p4byl3f5IkySvlNwNhXBul0dXcaoptFs810LVAV4KeUC3cUti2jGKgW7VMFiK
 wOa6EKTMjWu9h0LUNTUeB4CwvFavVZUEvAd8GDzDcmskyZi0SeoxXqWpkyKmnFRZuXT3
 B9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944640; x=1784549440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6GCAuneNa/1gKb9DW8CBD7WKj6dTVzcbk/e+PXY8YBw=;
 b=r3iQVU/q2UCPhJkfoWcVOYGwBstlhobHX2gmIbXQxIm5pVPyOaTGv2PwiNJ2gc0TcW
 pWGw8Zu7iiNWBANgLC06Uh32n5XWboDk6seNbyJ4+JBGXWKMnNg8JTyrBt2L6TtgS7ZH
 mpvEBmtYshaQzK6gQ4AcoFAD35B3CEWl7YQd88eao/mEciKEUKPupVuM9vvxMVPSxTIP
 phXbXgfSh6qndWDjbiWykWB3a30ThzDfkaYyUymb7rNjJBrztnhZsItYJ8wBcgboV2ip
 S7i9mQBBi/yblgBSCDM59Hxfi0X5K/xElnD6mXpNSR3fVViYZtBfOo2QtPkDpInpSJtg
 Pf3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkL1/5Sr6JNUVQW08VRndQHyBxvvzIsdGDi1MvZFnSljyl2S9iwAICPQqJWq/HsXPFQDcq4PKGyjc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6TxlY9aQ66L2SqhxK+0XDV3wL0Qczrwhkv+38OeKMbKbCOOAr
 0UUZ1CmCN++dT0jtMRUpgqSllp8jLRouAOAi5mVPnx955dN1TNv5E3Tp
X-Gm-Gg: AfdE7cm5Chs+Q/u/CPau49bXISNITFOaWi16bgBa8jqOEBNuCUQY4p3OZ6O4xxnEZf+
 d5TayQSnOFEiJ77ExmupcRVz75XgpcijwlalLJHsbwi9lTfxL0Lc7YThKrMv9bA9v39pGjRLLD+
 Gj8PE9YjKEe9Q3omobJW6dPXhX41sM56bsUUKbZ2rK5qM3xgZFpUIj4RRT1CfiwQ6ux3iIvZLQE
 kABvti3b5MzgzAi+CM+7kUdX68apc37o+O3odxWYzzsDEm/Xu+JPu977fF9TVZKy1RGLR48+epn
 yzitZxafYwa4ue9F6m8OjU1W74qyJIGzLZ2kXtp/06Nze6AWQV2jZiQT5QcX2c29uh8qgHAs0Fq
 dKsezY3SGUHaXc+X5R8RYMUVvPD9qy9NJ36nJImkhlqLuSRvojwr33vqBv5F1uSbVtLa+DEuyg9
 nJW3+ZN8KG8g==
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id
 98e67ed59e1d1-38dc77c61d6mr7650924a91.39.1783944639617; 
 Mon, 13 Jul 2026 05:10:39 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:10:38 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: [PATCH v7 10/19] media: meson: vdec: Fix race conditions and leaks in
 esparser pipeline
Date: Mon, 13 Jul 2026 17:37:05 +0530
Message-ID: <20260713120840.17427-11-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713120840.17427-1-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fix a circular locking dependency (lockdep warning) and a potential KASAN
wild-memory-access race condition within the asynchronous esparser queue
by restructuring register write and context evaluation blocks.

Previously, evaluating hardware ownership checks outside of core->lock
introduced a time-of-check to time-of-use vulnerability, risking register
corruption during parallel stream initialization cycles. Additionally,
abruptly exiting the payload queue loop without sanitizing timestamp
trackers left metadata dynamically stranded in memory, triggering regular
kmemleak warnings.

Fix these flaws by moving the hardware session ownership validation and
atomic stop signal checks directly inside the core->lock mutex region in
esparser_queue(). Ensure that presentation timestamp pointers are cleanly
removed via amvdec_remove_ts() on all early-exit routes. Finally, refine
the VP9 payload evaluation logic to correctly catch negative error passes
from vp9_update_header() and pass the session context explicitly to the
padding helper to secure memory operations.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/esparser.c | 29 ++++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index edbfc829e2da8..b9f36fef4be12 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -199,12 +199,16 @@ static int vp9_update_header(struct amvdec_core *core, struct vb2_buffer *buf)
  * the ESPARSER interrupt.
  */
 static u32 esparser_pad_start_code(struct amvdec_core *core,
+				   struct amvdec_session *sess,
 				   struct vb2_buffer *vb,
 				   u32 payload_size)
 {
 	u32 pad_size = 0;
 	u8 *vaddr = vb2_plane_vaddr(vb, 0);
 
+	if (!sess || READ_ONCE(sess->should_stop) || !sess->priv || !vaddr)
+		return 0;
+
 	if (payload_size < ESPARSER_MIN_PACKET_SIZE) {
 		pad_size = ESPARSER_MIN_PACKET_SIZE - payload_size;
 		memset(vaddr + payload_size, 0, pad_size);
@@ -313,6 +317,9 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 	u32 offset;
 	u32 pad_size;
 
+	if (READ_ONCE(sess->should_stop) || !sess->priv)
+		return -ESHUTDOWN;
+
 	/*
 	 * When max ref frame is held by VP9, this should be -= 3 to prevent a
 	 * shortage of CAPTURE buffers on the decoder side.
@@ -349,24 +356,38 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 	vbuf->sequence = sess->sequence_out++;
 
 	if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9) {
-		payload_size = vp9_update_header(core, vb);
+		int res = vp9_update_header(core, vb);
 
-		if (payload_size == 0) {
-			dev_err(core->dev, "esparser: VP9 header update failed\n");
+		if (res <= 0) {
+			dev_err(core->dev,
+				"esparser: VP9 header update failed (%d)\n",
+				res);
 			amvdec_remove_ts(sess, vb->timestamp);
 			return -EBADMSG;
 		}
+		payload_size = res;
+	}
+
+	pad_size = esparser_pad_start_code(core, sess, vb, payload_size);
+
+	/* Protect hardware register writes under core->lock */
+	mutex_lock(&core->lock);
+	if (core->cur_sess != sess || READ_ONCE(sess->should_stop)) {
+		mutex_unlock(&core->lock);
+		amvdec_remove_ts(sess, vb->timestamp);
+		return -ESHUTDOWN;
 	}
 
-	pad_size = esparser_pad_start_code(core, vb, payload_size);
 	ret = esparser_write_data(core, phy, payload_size + pad_size);
 
 	if (ret <= 0) {
 		dev_warn(core->dev, "esparser: input parsing error\n");
 		amvdec_remove_ts(sess, vb->timestamp);
 		amvdec_write_parser(core, PARSER_FETCH_CMD, 0);
+		mutex_unlock(&core->lock);
 		return -EIO;
 	}
+	mutex_unlock(&core->lock);
 
 	atomic_inc(&sess->esparser_queued_bufs);
 
-- 
2.50.1

