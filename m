Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511C606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SlY8qnq/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BED10EBA1;
	Mon,  2 Nov 2026 08:03:47 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CF910EBA1
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:03:40 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e9e53d011eso21427445ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793606620; x=1794211420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=thtxyrefz+ZDuy3D7yqgHBR2WhnB+jFTqsrrR4OaS5k=;
 b=SlY8qnq/2xu754f5m4xCWgoH6xvW5zxORh+oto3vitjWsi19ZXuXbUNSUHRpLBm89Y
 blox2wypvfUBvEUzmSJsRZ+DhUzIlgibWpHH/P5TStC//myRAwauCnP5NoNGLRGrHr2x
 F742vRbgkHfibFgPrK5xjNN8qT6hUiBeoMSrlY5etmAJ9e8kkt4KixYZdQpiRF56OISM
 n5TXNJjMTMI3Hsyha46VbPQ7EyOpyCkCTPQ9bXU/ET6tWdC2C8mm0iKPGWJVuoLeNF00
 NEdgAtzTNp+7K4WO4K5Tn64SGwjlGFf+IVWE2c4Fst/GRQ8fFreZnXmoa7FJyngYKVUP
 apag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793606620; x=1794211420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=thtxyrefz+ZDuy3D7yqgHBR2WhnB+jFTqsrrR4OaS5k=;
 b=PFN6ivrJ1jRCrnqKUHRSiLgagZcN0XR7zg9RKzsTkP5V5wt8MIWLRVCTEjvgBeOQCs
 GaT2CJ/gwdowHIT+OI+MGGCM22xhEEm5rE8SDceKPPn5euT2W1TgkvCxogGn01ALBPG8
 Fn3qyCEg1mSTQ5Y2kr4AAA2p4mVp8mnDu32PhLXzoX1b2vscxZOLpsU3C/ABrwpStkIs
 FeLgDNu+jomHFnREqvg3Es73wN3sUNPlrpU+jKIFbd7SmP33BK17pwOxy4LYMWM2KTco
 X2lCgNNcMMtyAi+sOTYTJUDbch/zz9tVILjIO+zRCGVQvdA3MjbiorLtiDU3LObQMx/t
 Ge/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrvBC0ByJxDbRxYO7y5HN+ffobMyz0v8dKUMg+KboQXyOD4x02gW60JTdZMqg86WlT9c/RYUXuklk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90JB5q3g+66f0lB+oV+ePU5rion7zk44EM8mHZv3oXqTysdZlA
 nYGA9eH7bnwf3/HL79dbCXduMi8yIIh/FfIiwqEQTif7eu4878Liu6lV
X-Gm-Gg: AYBFou1U86tTx9+SuhDOwmAihQtT+CNRe8py7DoPuf+6+hG+uGy5upr/Kxkja5bEz/z
 XPBaswbVFsmO5oaNlYZpvhzWruBewuQbOztEv0vgQu6uvFSzYl4WzS3Ib66pHGFbbTmyA7ilEWP
 lP8jhPuY8g3YsVxSgij4LxqXeibonDYPTChJp2iJfGSeSrRg5FDUoS7wWq9/wmdsPdHXYNhGCWL
 f+zOlumCsPSn/5HelXwvlcjspnM5blDW4rlt9YZs6HcaEx5jh7XMwHT9Cj34NfNVnBVXY+HAn5w
 wPPfa7pOOkN/2MTn4HwPOzfBpk/sPEY+Wk4wygEx7VQrZkiRmJiJHSfm0EfMn3G7DD0mo01PG6E
 J0aPY3daq0Y19deCcS8SE8N3essyD/UoLBbj8Nee/JcT8kH7Fc9V2K0P325i62KljLUpMAxJ9eg
 WxAWZ7IXkLsDe69A1qTHaT7mOg6c/ZmAjMyipt7pgEqhjfGNcYE02EWU+9GeF4PIDEolCn6Wxek
 Z5F9d9NtJbi/pmKn/x6Y5QWAfBx8+WWANgkUfENDKyLIcj/0B7RBjnZD+bpPK/9O4P0bETVXrW9
 YLnCBlsbftfmAAUvalAyQCymb2MlZMbFNohaYoEajLrjK7MRKvgXqJd50zBouuSTRnlMzT/i2u9
 WrvY2VQSBHSSb4/IJKf5w2RnP3kfNjzMiSpzXa+wXoBwAg2sFEVZ8z5uZMQAxSAQdlU7JkbRXSZ
 czq6iTcL3n8LOE9XSnv09HTvWd6PRF+oTrbx0=
X-Received: by 2002:a17:902:ea02:b0:2dd:7646:35cd with SMTP id
 d9443c01a7336-2eb3633227dmr87841375ad.0.1793606620285; 
 Mon, 02 Nov 2026 00:03:40 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb392afa5asm23573655ad.72.2026.11.02.00.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:03:39 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] fbdev: pxafb: stop the smart-panel thread
Date: Mon,  2 Nov 2026 16:03:31 +0800
Message-ID: <20261102080332.1466689-3-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102080332.1466689-1-matthias.goergens@gmail.com>
References: <20261102080332.1466689-1-matthias.goergens@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

pxafb_smart_init() starts the smart-panel refresh thread, but nothing
ever stops it: neither pxafb_remove() nor the probe error paths that
run after it.  The thread then keeps running on the devm-allocated
struct pxafb_info after it has been freed.

Stop the thread on removal, after pxafb_disable_controller(), which
waits for a refresh that only the thread signals, and on those probe
error paths.

A thread that has already exited must not be passed to kthread_stop()
unless the caller holds a reference to its task_struct (see the comment
above kthread_stop()).  This thread returns at once when the board
provides no smart_update callback, so check for the callback in
pxafb_smart_init() before starting the thread.  Probe now fails with
-EINVAL in that case, instead of succeeding with a smart panel that is
never refreshed.

This needs CONFIG_FB_PXA_SMARTPANEL and a board with a smart panel; I
found no in-tree board that provides smart_update.  Sashiko, the AI
review bot, pointed this out while reviewing a pxafb cleanup.  I have
no PXA hardware; this is build-tested only.

Link: https://lore.kernel.org/all/20260722081427.413EF1F000E9@smtp.kernel.org/
Fixes: 3c42a449107b ("pxafb: preliminary smart panel interface support")
Fixes: 9f17f2874834 ("[ARM] 5118/1: pxafb: add exit and remove handlers")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 drivers/video/fbdev/pxafb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 4f5c408eae56..b889a17e7304 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1248,12 +1248,6 @@ static int pxafb_smart_thread(void *arg)
 	struct pxafb_info *fbi = arg;
 	struct pxafb_mach_info *inf = fbi->inf;
 
-	if (!inf->smart_update) {
-		pr_err("%s: not properly initialized, thread terminated\n",
-				__func__);
-		return -EINVAL;
-	}
-
 	pr_debug("%s(): task starting\n", __func__);
 
 	set_freezable();
@@ -1290,6 +1284,9 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 	init_completion(&fbi->command_done);
 	init_completion(&fbi->refresh_done);
 
+	if (!fbi->inf->smart_update)
+		return -EINVAL;
+
 	fbi->smart_thread = kthread_run(pxafb_smart_thread, fbi,
 					"lcd_refresh");
 	if (IS_ERR(fbi->smart_thread)) {
@@ -1299,8 +1296,15 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 
 	return 0;
 }
+
+static void pxafb_smart_exit(struct pxafb_info *fbi)
+{
+	if (!IS_ERR_OR_NULL(fbi->smart_thread))
+		kthread_stop(fbi->smart_thread);
+}
 #else
 static inline int pxafb_smart_init(struct pxafb_info *fbi) { return 0; }
+static inline void pxafb_smart_exit(struct pxafb_info *fbi) { }
 #endif /* CONFIG_FB_PXA_SMARTPANEL */
 
 static void setup_parallel_timing(struct pxafb_info *fbi,
@@ -2366,6 +2370,7 @@ static int pxafb_probe(struct platform_device *dev)
 	if (fbi->fb.cmap.len)
 		fb_dealloc_cmap(&fbi->fb.cmap);
 failed_free_mem:
+	pxafb_smart_exit(fbi);
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 failed_free_dma:
 	dma_free_coherent(&dev->dev, fbi->dma_buff_size,
@@ -2393,6 +2398,7 @@ static void pxafb_remove(struct platform_device *dev)
 	unregister_framebuffer(info);
 
 	pxafb_disable_controller(fbi);
+	pxafb_smart_exit(fbi);
 
 	if (fbi->fb.cmap.len)
 		fb_dealloc_cmap(&fbi->fb.cmap);
-- 
2.56.0

