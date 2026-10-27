Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E5606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Aviyc7H2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7935810F309;
	Tue, 27 Oct 2026 09:32:08 +0000 (UTC)
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com
 [74.125.82.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4290710E212
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 05:02:30 +0000 (UTC)
Received: by mail-dy1-f194.google.com with SMTP id
 5a478bee46e88-35829219da8so784839eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793077349; x=1793682149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yzZEC/TrZrxGucG9Xp1MOjisRqHlcLyLSCjwMz8NQVc=;
 b=Aviyc7H2mlpAahtp40JN9IlLpYjCq4wb/m+hhdBcWoF6n6CtM5qxeSheob6mUz6QSa
 5ltUAMLI2/0u/uBrIr8Xz5AiibyAmvsHZqR/EP6hn4NOc+l74fFEDiXu1VWsVUimJatW
 TiTTYebAsPwBcZH9CKQkkBg6tOVhlC5mAyh5mftJabQeFbSKeqGYOMmAbvYfa27rtzJx
 WCHv4TpPNSfOc/C3eEyh+CKEcwsARTSIQ7bo3Naylf4O2aWX2WlPH+ujr6ecX3on0Kly
 2C+ltUWC+O/KLbG57dtOpPDpRuyVJTlg8H9/J/21ztKoG4hwTTT/ocJo033L1NirwKNv
 QVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793077349; x=1793682149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yzZEC/TrZrxGucG9Xp1MOjisRqHlcLyLSCjwMz8NQVc=;
 b=c1ard3f0n/WhaZsaCPf+vq3btxMOAjD0GkjnnTsDudG6LflK7e7kEB4/mWF6vSUvha
 sUJYVxs/ajugmq/8dEEmYBmp6ooBIAyfJw8axcIEo1D0IdYbgINFWiHDanwwdu/Ux+fm
 FL5RTBPi0D9Ldto6NIu3oJDloLAFyfQSqVINSh9B7K6yDizDOxa9vT6bI2Te3ZxVDcF/
 Zj9chbKiGf0vPj4FPW2jRuxYnyG3UYBBcatX2kIMAKAWKb2E4lrtk4I6hY0zvpOnXpFj
 MbVCr5bF329nDyEBXdqz0gOV8W3wbgoLVB13Wj3M8E0egkuvwPLErSu1PrB3GdOg4xrg
 exFQ==
X-Gm-Message-State: AFq9FYLewqEA6KifzQ1IIr9Q0wdE7uMYUBzj7NDS6fnpHVoiJdFYpwHG
 UgHQYGTJuLniLgupdAn2WN0uZe3pmBLwVpPYJIntth2rDX9KVEACZcfk
X-Gm-Gg: AYBFou2MkZggNskRw8nQExUdkOg74WeNt8EWtEpxZuq90kOd3K2CBXVxyK+kAGRjJcr
 kYdQGX3aIGx7qFwWePsqZfCjnfzURbdzs64xzG5ahP2ZN0MsKRXmkDR93h0XacEzN8nAfbhmVjc
 PjxhGw8ALxqycjvhR6NlS5SL3B/fmjsdcfjPfr5KetLUxi2Fop8Es6Bm61Nfj+dlIjpJWUpdI8O
 iGc5x4X0mKzu7OLKzy+Eo95vbrZ+9lj/EQQe4DIGTzr3ZXwbc92RmMD14s+1Hyw4EMyWwH+6g9r
 AG4fXH5XgOp3Rmup0FwFr7b1iea4d6C4GuJpdl1P2o9eCG6Az6p22k6FX91hEDKElCFMnSboSif
 n0wrfueDTsKFfySX7SlOszlvLbiCnXy2/xIe5nqPTtiWcRvWe64n04KtugVRXxY1lguzR1gok4T
 DxUMO9myM9mfy4vOpBCBR5kukP/nz3LYVN3VX54gNSbdfLfGZURvHf1yJuwYBv9E5KC1UjveFPU
 M7z28tcjIVkKHS2sZrzyXE0J/fwCYUQNKlxTPNZuast6FXZh9ltOHqAoSNlZX0EWwrQquUvoGpY
 VlfTzQe+X6l2B7MQ
X-Received: by 2002:a05:701b:4505:10b0:15b:1959:15e0 with SMTP id
 a92af1059eb24-1a3c76669abmr2075046c88.4.1793077348863; 
 Mon, 26 Oct 2026 22:02:28 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm35374587c88.6.2026.10.26.22.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 22:02:28 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
Subject: [PATCH v3] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 27 Oct 2026 13:02:15 +0800
Message-ID: <20261027050215.612762-1-yyaqia@gmail.com>
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

cancel_delayed_work() does not wait for a callback that is already
running. Since fb_flashcursor() re-arms itself, a callback that has
already been dequeued by process_one_work() can queue the work again
after fbcon_del_cursor_work() returns. Add a cursor_blink_on flag to
struct fbcon_par: fbcon_add_cursor_work() sets it, fbcon_del_cursor_work()
clears it, and fb_flashcursor() checks it after taking console_lock and
returns without drawing or re-arming once blinking has been stopped.
Keep the requeue inside the console_lock section so that the flag check
and the requeue are not split by a concurrent stop.

Fixes: 3b0fb6ab25dd ("fbcon: Use delayed work for cursor")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4.1-flash
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---

Changes in v3:
- Add cursor_blink_on to struct fbcon_par so a callback that has already
  been dequeued by process_one_work() cannot re-arm the work after
  fbcon_del_cursor_work() has stopped blinking.
- Keep the requeue inside console_lock so the flag check and the requeue
  are atomic with the stop.

Changes in v2:
- Reworked per review (sashiko-AI): do not guess the context with
  in_interrupt()/irqs_disabled().  fbcon_del_cursor_work() is now
  non-synchronizing by default and therefore safe from any context;
  fbcon_del_cursor_work_sync() is added for fbcon_release(), the only
  path that frees @par and needs to drain the work.
- Move the requeue in fb_flashcursor() under console_lock so a running
  callback cannot re-arm the work after the non-synchronizing cancel.

 drivers/video/fbdev/core/fbcon.c | 41 +++++++++++++++++++++++++++-----
 drivers/video/fbdev/core/fbcon.h |  1 +
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 94abbb5ac766..0847dcf18416 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -410,7 +410,8 @@ static void fb_flashcursor(struct work_struct *work)
 	if (par->currcon != -1)
 		vc = vc_cons[par->currcon].d;
 
-	if (!vc || !con_is_visible(vc) ||
+	if (!par->cursor_blink_on ||
+	    !vc || !con_is_visible(vc) ||
 	    fbcon_info_from_console(vc->vc_num) != info ||
 	    vc->vc_deccm != 1) {
 		console_unlock();
@@ -422,25 +423,53 @@ static void fb_flashcursor(struct work_struct *work)
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
 {
 	struct fbcon_par *par = info->fbcon_par;
 
-	if (fbcon_cursor_blink)
-		queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
-				   par->cur_blink_jiffies);
+	if (!fbcon_cursor_blink)
+		return;
+
+	par->cursor_blink_on = true;
+	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
+			   par->cur_blink_jiffies);
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
 
+	par->cursor_blink_on = false;
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
 
@@ -765,7 +794,7 @@ static void fbcon_release(struct fb_info *info)
 	if (info->fbcon_par) {
 		struct fbcon_par *par = info->fbcon_par;
 
-		fbcon_del_cursor_work(info);
+		fbcon_del_cursor_work_sync(info);
 		kfree(par->cursor_state.mask);
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index d93a89877d04..6a2f7f6e5a8c 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -97,6 +97,7 @@ struct fbcon_par {
 	int    blank_state;
 	int    graphics;
 	bool   initialized;
+	bool   cursor_blink_on;
 	int    rotate;
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-- 
2.56.0

