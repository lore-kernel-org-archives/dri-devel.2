Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C6606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OdpBGqqT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070D510F32B;
	Tue, 27 Oct 2026 09:32:25 +0000 (UTC)
Received: from mail-dl2-f11.google.com (mail-dl2-f11.google.com
 [74.125.229.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D97110E07D
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 03:34:35 +0000 (UTC)
Received: by mail-dl2-f11.google.com with SMTP id
 a92af1059eb24-149f2b3f25dso1068362c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793072074; x=1793676874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=waUlW0e7gDgmzI+AA1aqVFppIW+pExWUzgSe1N9AwE0=;
 b=OdpBGqqTowfPbi/w+BzTa52w3cbzgoy8RmHZBzGXd08+5u1ng5l9vKK2ltmcJSQEqo
 Mk/QzBS04r/2Ys+Tzinu28xmz1yW+IRM5HMrhBMV+pvgHyyrQLynRpN8hPi1qm/oRmez
 MnmdkSCSLJJh8gak6O7qi42/NhCSgoH7UXliDaZfgEjd/8YzCmj4igOqIpjKPgRhgqW9
 JvI0nLiaXZykUYuxXYUXA556BhKwuN1H4jHv3qwKoH4E97XHIhgx5TZQSWKHDnbasfYI
 KeyWrTmMF6WqAagXD1vWY7LoM1O3vwt8pFQdUhkfIbdPU/B0wgaS4T2a1TcZu5CKFimg
 vsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793072074; x=1793676874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=waUlW0e7gDgmzI+AA1aqVFppIW+pExWUzgSe1N9AwE0=;
 b=wRr8el1NqtxFwyR1MvJVBeN8FSRKp2vrnS1+pU4AIHTKO8h0m3kONdJKZFsyD6VE60
 FAv4avdat17K5fmEcXw6IMxtnvSoeuCCftLCg1o+AgDZZ32uGBGg1FbWDlpiaCBgkiLg
 Lk6jKPejinMcO8nyvY7u06/tFUhiZEx95xucEszcH3BT1nLV01yop8fxNsKLDcp+6xER
 vqMmCOGKfpKyzhQSm/xeQNzFlIJgZW6/HjDICSgD1ufAgvYuuInQaumBRyMRirNp137h
 +IcaoxROBPOPDLzj+DSzVWgPWSt14VS0+mF9HtmvaXY3T+wBCVFswLez2pbO4U2NdMF9
 hEKQ==
X-Gm-Message-State: AFq9FYK75guhwxigxF9y1dUgaHNqi+aCTSw38GYXXTzvwQ7Gni/uvcbX
 bujDDm+QixSHmszSPhdfloFfJ9Xa6lDDRH8zs5w2k9dy6XgIeTKkrpyM
X-Gm-Gg: AYBFou3v/4Kc0bN8ec6QqANZP0b5Ki6gPC0dyWiD77BjFMtVe0mknQiTM671iAnCL/1
 59ahAUBH0TGFGpgQrZnI/T30dS8T6Ru6vg9MJGS8GkiTdd+hy6LgNS8EqjLnRQB4ukX6a41nsOv
 zYPDLcZX2CxkEBmw4T5fthtW6W2l7IQgGCZkCtIEYFrCxI0+w9t5OwTSCGReouIhLUo5xcxRwk9
 gT9R7jyjKo1WhTdw94Xq6elKRt3I7PH8Uah3MVxOep4q1Po/R9DxLzZzOz4F903b9FRO5WH0B3A
 gDup4qZKy0pnx5EDnw8maF61J2bOMmoppMLJhedj7WTpGcePaBvKq9uMy+Fm9c0kz1xEuzB7ZBL
 PDfPNXwE5CuPvgds8vVhg41k1lQvfX1Cg9+81dEqAf3yy+Ges6ttAFqDiDb3KPCFn3ChMXGw0gD
 Ahyhov9XRvzQszu1ZpaiXavsL3HF+gvM7Z081y2C1k6JASQw37HLusiLUNAOnxs/vx2L9SJWUUw
 X8ZN5P3u1RXn/QcbPrATMtJtb5jVkgi1d0m5EGebQAfFXkD5x0BcadiqxyHkgZjyIBGPLNE/uRk
 vBY6cIt43lJPoZSN6fMLWKxO6Zf/uJtqH5sFOw==
X-Received: by 2002:a05:701b:428a:20b0:192:fd91:c567 with SMTP id
 a92af1059eb24-19935906f80mr13498312c88.11.1793072073779; 
 Mon, 26 Oct 2026 20:34:33 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec50bcsm54876624eec.23.2026.10.26.20.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:34:33 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
Subject: [PATCH v2] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Tue, 27 Oct 2026 11:34:22 +0800
Message-ID: <20261027033422.585328-1-yyaqia@gmail.com>
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

