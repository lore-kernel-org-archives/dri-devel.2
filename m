Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A6606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VGYAZH5L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A4510E0E6;
	Sat, 31 Oct 2026 03:33:00 +0000 (UTC)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43D110E0E6
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 03:32:53 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so2310425c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793417573; x=1794022373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yNBCcyYS48KOF7Z3SVlpQ1pq/HG3PypPDg7sc6kq5zE=;
 b=VGYAZH5L47g5U2SVbYiFrb3dI+ETxJxLnMC30dzZafiBgDzdj7eoeD+6ASx98p0AmP
 m+IChXyaxGkWzrviR2B8Z8qcEDAYWZ4Xob6k6SwQ+H1Tn9A2+Qk1h4GjnasxJr+GAHhr
 JdEFzdIHBVX1Sr3HBPs4M/hsmBa9WFoGOym1xLwYUxlXgvmDCfnAl7XQaxQQuLxuwZ3L
 J24g7qz27McdLZ4mntJ2XUVOsg8b+pSMQ3+3RiIiACVuhSAl76LXev2zauflv12uUDtU
 RZ10DNgFw/Ih/uAMQId/UZUCkXPgkBvpgbR6TVtSDKJmkVqMYhZqKqIv7mGfcOmJCcbu
 I9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793417573; x=1794022373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yNBCcyYS48KOF7Z3SVlpQ1pq/HG3PypPDg7sc6kq5zE=;
 b=jNxfHZfJKLeF00wpmFiPv0ONdhqog7Itj9xxDhnTGSimXUk6RZtMbsM5ZICn+H+Vbx
 41s23GioZWqJSO1qiQitLh7vSjVMIlStRWpfktN6eWeH4fiKuBKg/h1pRuyCR3lL0d2n
 aOS+UgMmkD0LsWmy5CO+P1FxZu9ctVMG0dxagrYEqYtgkQR9oIPNv2wCtXfrJcgd1asa
 f9GigYOwGGeC46KzHeKYqk7vHvKIxXTjOKodF62LwMy0kJ5SSH4cgIWUMv4XOXds2Kde
 AkAJwqoKgqQN5USSGfmh1fQkWVIfBaS7kyNvus/MyNefYd0jg0Jq5hF6Q3ctvRLEShsj
 xV2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1drxzU57pYhSRKn6O6maOhD4uM1dA07bSKPZ21XOFW6cq5T3TS6WGvTzWHe1f1edv3joHAKFzemA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKBAObTZzrpUsGko6U8Ry60tvRivAgJ3Fj82VP2uxTKYE/uabhJ
 Ui/Oq8rTQ0MXQgosWVbNWM+CPuvdRNdFW4lyj9YebmSKm1qRkNtFCtN9
X-Gm-Gg: AYBFou1t+9Ss8h767FFapSA0KsYxz13pP/o5dld1naWtUqPF7ZlkJapuxiTE7k7QNdZ
 1ZOWct3Yn8uruKI2kqfXoXHsIkGNgWkduXIMbQLGB1lVAPc5ZZ4N4e1N7IvhbSI2zwZXIWUgBUV
 p3fq4t6S9fY748hGui+Gp2WjbHZGSnWFPojgkPpK456XnMeQFTa455J0l0YGOBGlMBou9asRRNE
 2HOfwWAiw7x83rG8EbZLXhhjmuqj/lkB/8C7gReX2sxUmOAK6GadrjkqU8crem7REjHkdQVbKbO
 SJiKsPapaWxQOT9yts+D8PHf20TSvsmTuqvRVgA8J83dXHE2wdZqR0usSFhT4oXn2mSTPw0Gk4e
 P3SyyFgnhq3vSvbFSN74swCIIl7sIzsRQ3HzFj4Anq/VL6MbswztSGZi5P2LUvSdDbyKYNWte5T
 VOkl7ou15YZcpJSc43BLXml2sh2qOtSW4AtwPFZS0LtCANDxNH/FFZJ9TJ+h8uQ2J/Q1I9k/jqB
 0JCNrWLQTsOw/Cr+rMQoxK+oRzDpjc1p+b3HsE5Nh9yR2pTPqIdYHY62cYB+NYwDV5/5H2tK0k9
 t67rvmwX49YzdS+leZTetSVds1wkZfFDe7RAlGqIBfHvwQOmsnAozcm90q3rSgB/NMkAKRsBSDp
 uKVSH/0d72haGUkNtY0pKkX2MOIu2Vnw2bT9WjCfqv6qIsl2/3ITUy3/UffmmvT3xltAWr0fhWY
 Rh1N0Q6l1sVumKZeb2XyixMgVCdJHIlRjv8Ck=
X-Received: by 2002:a05:701b:42d4:10b0:143:2967:c0b1 with SMTP id
 a92af1059eb24-1ac5b7e1cdfmr5936493c88.25.1793417572110; 
 Fri, 30 Oct 2026 20:32:52 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm12841651c88.11.2026.10.30.20.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 20:32:51 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: pxafb: stop smart-panel thread and notifier
Date: Sat, 31 Oct 2026 11:32:48 +0800
Message-ID: <20261031033248.2491098-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Validate smart_update before creating the smart-panel thread, so the
thread cannot exit independently before kthread_stop().  Use the
freezer-safe stop API and stop the thread on removal and every probe
error path after it has been created.  Unregister the cpufreq notifier
during removal.

Found by Sashiko AI review.

Link: https://lore.kernel.org/dri-devel/20260722075803.570532-1-panchuang@vivo.com
---
 drivers/video/fbdev/pxafb.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 1912cfce28d6..1b2a16590999 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1248,20 +1248,10 @@ static int pxafb_smart_thread(void *arg)
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
-	while (!kthread_should_stop()) {
-
-		if (try_to_freeze())
-			continue;
-
+	while (!kthread_freezable_should_stop(NULL)) {
 		mutex_lock(&fbi->ctrlr_lock);
 
 		if (fbi->state == C_ENABLE) {
@@ -1290,6 +1280,9 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 	init_completion(&fbi->command_done);
 	init_completion(&fbi->refresh_done);
 
+	if (!fbi->inf->smart_update)
+		return -EINVAL;
+
 	fbi->smart_thread = kthread_run(pxafb_smart_thread, fbi,
 					"lcd_refresh");
 	if (IS_ERR(fbi->smart_thread)) {
@@ -1299,8 +1292,15 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 
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
@@ -2364,6 +2364,7 @@ static int pxafb_probe(struct platform_device *dev)
 	if (fbi->fb.cmap.len)
 		fb_dealloc_cmap(&fbi->fb.cmap);
 failed_free_mem:
+	pxafb_smart_exit(fbi);
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 failed_free_dma:
 	dma_free_coherent(&dev->dev, fbi->dma_buff_size,
@@ -2382,6 +2383,11 @@ static void pxafb_remove(struct platform_device *dev)
 
 	info = &fbi->fb;
 
+#ifdef CONFIG_CPU_FREQ
+	cpufreq_unregister_notifier(&fbi->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+	pxafb_smart_exit(fbi);
 	pxafb_overlay_exit(fbi);
 	cancel_work_sync(&fbi->task);
 	unregister_framebuffer(info);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
prerequisite-patch-id: 44b1c2680cb029871e123eb11eab7764a807ef24
prerequisite-patch-id: f4dfbbaaec2d208ac255451cf032c22f0e7fed2d
prerequisite-patch-id: ff6a574f35399a0059df3a759cbd2a558d24300c
prerequisite-patch-id: 784ec68755ba9ffc1d5693e1baff1f59d574c331
-- 
2.56.0

