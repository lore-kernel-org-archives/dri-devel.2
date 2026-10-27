Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308E606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PTvtmCnP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E88A10F347;
	Tue, 27 Oct 2026 09:32:31 +0000 (UTC)
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E340D10E28F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 03:47:28 +0000 (UTC)
Received: by mail-dy2-f7.google.com with SMTP id
 5a478bee46e88-369f126a526so705130eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 20:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793072848; x=1793677648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d5xPE7zkAisWNP1/3IMkS+loLJJfjfdBEUGlcoiM7g0=;
 b=PTvtmCnP4GaMU1ZCI3pSvgBPCpgNH4phx97s70WwKL/oDfw6ym8T+1vu/8hQTllzL5
 EV7DhWT/pwg3c+ODBifiOAdOqvLK7XbsujDTcxDLPvGx4wQxI4AydVND/34hwZGeignp
 5EdBSXRfxMXkZwchxGVWvXyzcIaZ8wpdr8Auxn3c7EDj4zLsE1bWY1rOo6JhDpwTXTYy
 vsheH/euUMQ4Of9N9YdNttj0t5h5vTF3r6zIF8/pw0oFnbEr1n04QqZIR8aLAOIlScPc
 yIgf87jN0hBIsbcjC8/1KRVkzEoTVdTDhbV5OHPMBKVkvDdgpdLoZOw6do+e5Wpxxe/A
 qOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793072848; x=1793677648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d5xPE7zkAisWNP1/3IMkS+loLJJfjfdBEUGlcoiM7g0=;
 b=a2IMbt+jQH4LT1upJAWaGh7jwK0mw5J/CGxfSN3rxfxwWNS3c5DrNF8SZ8qExp2wL9
 jyjuIb8WTEBEQE+IgFfvY7idIhilNeCHjA0tlV3pXYeqwp4psbm6hMaHLC6l9XGStbI5
 zQPNtcxgyVYz/zk7sMjR4rKPoAy3UgMf9t0OsnrHQKX1BpAfPDuNSgK+fDjSAh55c0k4
 Bv2fy3cTGop8R6Qn6fP6kH3c+ZPj8sMDHomNqXpoktffqByvSp/VYtjhKA47kIXnmAGO
 UQ5rYTxbN7cgTTIxXeybs2lbwpIzxxsVOIxNUffLp7fgmY9KXf+83OThMLfdr+DKMOTp
 Apsg==
X-Gm-Message-State: AFq9FYLYd1XRjPieoArJBdqP29f2NsPg1ycFTn5u6SvOoB8DtFX9EZL6
 NUKkuhKPgjbhXtppoqUue+fPs+SFEnUNfYNblTd0SWRnxzY9Q3JkndrFJjdobHMhySC5gA==
X-Gm-Gg: AYBFou0ZujkGB0RUzihKGvlyUhtZy4WQVRWF6pf6pDLnmqHjZLsBir7f52Xy7C2wcFd
 ofOLRovCjuKl5nrwO2gmr8lwHULPBkW7R5+AVECIzLNdiG44fcGhUzBXfhlpUlmXwfOYPK5TllD
 hdkRDFSIaNLMqL6wbbN6P3T2RRotSnCpSJOeSwdPI4VOyj+ftqfkiWwcN3dvaJL/qUVP3981rOd
 s6ngxYca2dZcaklKioBvuOrEh3m7FtgJ5zBiJkvAOEZhFWrAAd0p93zlpYzo7iR7LnMOmMqMcyJ
 dOHgO8/XwJqdZQWVlhMwbe/a0BsqG3NS5dr9O98t1cT/3f/CxFAo8BEVVtfyqv36ajaKq8jgi1+
 YwTcYgd5DgHYvpdU+53FkW9Azis8M5yKpEfzotGHpUFTYBkPHypZp8QD5LAfIWj/5WtrxKqYx/w
 fgOcL0mk6X7oZdYfkBt2kx0PMO+Bq8kkZhkcOWQtxbU1FYW5BsIJFZah4b3UHXbHPALifNEkeSs
 sVIsw/sa3pZ1DmbhqH4cf+d5TS7zYJ8BqdWfMd9C26ik8BuMnjlWUlyVEgcmeAjO29ZtJos3DDJ
 hrjOYd8zEzIN+COh
X-Received: by 2002:a05:7301:7d01:b0:366:c497:610c with SMTP id
 5a478bee46e88-369e8610133mr11168504eec.33.1793072847986; 
 Mon, 26 Oct 2026 20:47:27 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a026e04a0sm11349777eec.1.2026.10.26.20.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:47:27 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
Subject: [PATCH v2] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 27 Oct 2026 11:47:16 +0800
Message-ID: <20261027034716.588174-1-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_cursor() can be reached from the console printing path, which runs
in atomic context. When the VT software cursor is enabled
(vc_cursor_type & CUR_SW), it calls fbcon_del_cursor_work(), which uses
cancel_delayed_work_sync() and therefore may sleep.

With CONFIG_DEBUG_ATOMIC_SLEEP enabled, the following is reported:

  BUG: sleeping function called from invalid context at kernel/workqueue.c:4722
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0
  ...
  __cancel_work_sync
  fbcon_del_cursor_work
  fbcon_cursor
  hide_cursor
  vt_console_print
  console_unlock
  ...

Make the default helper safe: fbcon_del_cursor_work() only stops
blinking, using cancel_delayed_work(), which is allowed in any context.
Every "stop blinking" call site keeps using it, including fbcon_cursor().
Only fbcon_release(), which is about to free @par and must ensure that no
callback is still using it, calls the separate
fbcon_del_cursor_work_sync(). New call sites therefore get the safe
variant by default.

cancel_delayed_work() does not wait for a running callback, and
fb_flashcursor() re-arms itself, so also move the requeue into the
console_lock section. fbcon_del_cursor_work() callers hold
console_lock, which serializes them with the requeue and keeps the
non-synchronizing cancel effective.

Fixes: 3b0fb6ab25dd ("fbcon: Use delayed work for cursor")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4.1-flash
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Sorry for the last email, I forgot to write changelog. This email has no
code modification, it just adds the changelog.

Changes in v2:
- Reworked per review (sashiko-AI): do not guess the context with
  in_interrupt()/irqs_disabled().  fbcon_del_cursor_work() is now
  non-synchronizing by default and therefore safe from any context;
  fbcon_del_cursor_work_sync() is added for fbcon_release(), the only
  path that frees @par and needs to drain the work.
- Move the requeue in fb_flashcursor() under console_lock so a running
  callback cannot re-arm the work after the non-synchronizing cancel.

 drivers/video/fbdev/core/fbcon.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 94abbb5ac766..917ce9d641a1 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -422,10 +422,14 @@ static void fb_flashcursor(struct work_struct *work)
 	par->bitops->cursor(vc, info, enable,
 			    get_fg_color(vc, info, c),
 			    get_bg_color(vc, info, c));
-	console_unlock();
 
+	/*
+	 * Re-arm under console_lock so that a concurrent
+	 * fbcon_del_cursor_work() cannot race with this requeue.
+	 */
 	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
 			   par->cur_blink_jiffies);
+	console_unlock();
 }
 
 static void fbcon_add_cursor_work(struct fb_info *info)
@@ -437,10 +441,30 @@ static void fbcon_add_cursor_work(struct fb_info *info)
 				   par->cur_blink_jiffies);
 }
 
+/*
+ * Stop the cursor blink.
+ *
+ * Does not wait for a callback that is already running, so it is safe to
+ * call from any context.
+ *
+ * console_lock serializes this with the requeue in fb_flashcursor();
+ * otherwise a running callback could re-arm the work.
+ */
 static void fbcon_del_cursor_work(struct fb_info *info)
 {
 	struct fbcon_par *par = info->fbcon_par;
 
+	cancel_delayed_work(&par->cursor_work);
+}
+
+/*
+ * Stop the cursor blink and wait for a running callback to finish before
+ * @par is freed.  May sleep, only for teardown paths.
+ */
+static void fbcon_del_cursor_work_sync(struct fb_info *info)
+{
+	struct fbcon_par *par = info->fbcon_par;
+
 	cancel_delayed_work_sync(&par->cursor_work);
 }
 
@@ -765,7 +789,7 @@ static void fbcon_release(struct fb_info *info)
 	if (info->fbcon_par) {
 		struct fbcon_par *par = info->fbcon_par;
 
-		fbcon_del_cursor_work(info);
+		fbcon_del_cursor_work_sync(info);
 		kfree(par->cursor_state.mask);
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
-- 
2.56.0

