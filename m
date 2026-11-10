Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C2606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Euv8htjp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DBB10F935;
	Wed, 11 Nov 2026 08:22:53 +0000 (UTC)
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7911D10E03E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:00:52 +0000 (UTC)
Received: by mail-dl2-f5.google.com with SMTP id
 a92af1059eb24-1ac216daf7dso1164039c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 06:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794319252; x=1794924052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+T9D/kB7BW8AzSh/iiHsnXz7kQX8FAMQaVA4PKYbVfM=;
 b=Euv8htjpziUAN1DMa9hu9KOU0Ho1kw/0675aGcKrVDmjwUPghRE1c8jWDpBQ+O4KoY
 DDjbJq7pRh6n8oROWZ8956HTDV6MsSGu9g1XT/s5DXy9+lzlkU3AMIPJ6rVnCx83dwNx
 Hs33yY8zATThvpsXsRfnfVny7+lUq+Ci62ClHoevUkp3xmmX7nV+OUe76zgrgoo5aOUN
 RyOTzDC1vAjfpt0oaim4J5YnUIHIYZOsGKeaD9RxOJhkuVGseUJkeKxIAjZm2g/kwhrF
 A/cMEh8KUiJAUiXbyppPzBbHDhdPEFA1ohl73XZSSPw6pUI2j6bdtNFL9t0Nq3U0WA4O
 m5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794319252; x=1794924052;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+T9D/kB7BW8AzSh/iiHsnXz7kQX8FAMQaVA4PKYbVfM=;
 b=FNxQyJWiSixs2qBy1aeQPDRI3q9955qVA4/ETLDP4B6QlI66T0VoqL/Yg7a0WJXoHu
 ab60wFHe7xW0BrLEvqjrukjLVGyp92DL8iMtliDO3hyiKzwSvpZP7xjzoLKGKPyuTjik
 tPypt1dekT9LmxLi2RQ/6wjbgW+p4DqU3YLjlVlla/quF6N1fY0P4NY4UZnD5g0oe37k
 4SKerP/bjnKNeowOJNunRwUnS6bReVsE6jt/E4qaR2AELHsS5fFjtGLUhHkqli0IBZHD
 W32ZeDliOI7+MySGT1w1/4aHoF8onvqeN8U4CmcmA7sTQMbmpCuqXTLswwjy/1cvo5Ye
 JC+A==
X-Forwarded-Encrypted: i=1;
 AL+hErHPdaPv3yRZ4dTcTFJD46z8pMI8s9sFoTQcU+JGD41m6Eqn5WWSBmWj/W0OHbWwrWC6moI4JXl7oM0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Mf+7F5je5Gp+2qWdGThD5qH55SQqzABBhKzlx0bTg1hVfNH/b
 w2fN3hWyeUclM51H1hQO5XlkDTTCQsSTDxX+lDEFQ70F/YdxIsggiqx/
X-Gm-Gg: AYBFou3Dv+du0Qeh+DdCj8hJoEa6sLnK7moJVJSNPWF7xEalmo2I0ckh1ZkK/m7sxST
 j2Hq2P+XTgiHQw8iUvPZyfvjDnXKblYJgkEkMdGGCDWhR0Z+S1rBXs1VAzOg4ozxzQyy6VzAOE9
 +u+3YSU+RjOmfMCYgJmDHEaoEbQn9ZumcB8OUrhilX5Wtic6reG1yIcBCAPfV+svBFdba13ibJu
 NHzn4pcPY74hi6tVovfXm0T93Kjy5bQkIrRjtEM+FMCcgGPCBq93/DWh7ShHuYNVvkKzzuMHvPc
 xgpmIHzvygU0tNtHD6KA6sRx0NPQDg/cHTljABFJOgOqc7v54Bb8e5EOs3oaoh2ziXWxZdVBYvn
 jpTQSAycB5IFUsEeAVsG7d7YSkKMaqK/1D6N/qvaDhCKf01RfSoYUn7p/s8CJhW0QGWaZf28nI3
 ATKrosgO0JhPONpN4P9b7uAy4TZK789O/Ed0SHvkoHn0kvdNEuCd9y+2MiO3yxFSNXAsxk+Cx2g
 PUGpXhYXxQwYqwn8GWSVLS5uofuf7DS36PuUzcbS4RzWahjUf/QFp//yu0mLTW5bl7lvQMn96zL
 QIGferAaQG2/g6qetVosbLsHW/Z5FTaXrAa6wBInIw==
X-Received: by 2002:a05:701b:455a:10b0:1a3:dfb6:e593 with SMTP id
 a92af1059eb24-1b3b6185203mr3440708c88.27.1794319251406; 
 Tue, 10 Nov 2026 06:00:51 -0800 (PST)
Received: from blue (104.194.64.109.16clouds.com. [104.194.64.109])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b85d22sm7594328c88.19.2026.11.10.06.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:00:51 -0800 (PST)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yao Yiqi <yaoyiqi3@huawei.com>, stable@vger.kernel.org
Subject: [PATCH V3 RESEND] fbcon: Avoid cancel_delayed_work_sync() in atomic
 context
Date: Tue, 10 Nov 2026 21:59:59 +0800
Message-ID: <20261110135959.232798-1-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

