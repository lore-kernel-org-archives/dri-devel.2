Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBF606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cokjIgVH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA48B10F327;
	Tue, 27 Oct 2026 09:32:00 +0000 (UTC)
Received: from mail-dl2-f4.google.com (mail-dl2-f4.google.com [74.125.229.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925C410EF63
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 14:59:45 +0000 (UTC)
Received: by mail-dl2-f4.google.com with SMTP id
 a92af1059eb24-1922a6f0d23so1190562c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793026785; x=1793631585; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0hZu4fC9M40eXtw7zx0zkLs5DS7aBYk38bRzFK4atkQ=;
 b=cokjIgVH85QXYxphb741bleT6JrdXtXsZN71nepQ9ERBKqJKA/tAaDxAEw32kPUZIL
 owJlF/GBt1N+/7M0YzOFcJ1E8uJSYc8wkydZNzOB6yKP8Ui+yG8UdmGsAJm3g3dyE5Au
 ThsIQ6dJ+c8T2tsTIbgof5QIzjsXppfpg8onCCm9KoYbF9EOTYczKylZD3C9IEjQXQxI
 Up/U6OHk6qD1Ztr1U5wRPjVWWI63LmR21UT/t4W3ani9LT2Xl/EN5BcWO9mtI7mvZd8A
 7wh390uXaKkR95TTv77WeabLJ0ldPB4imaYneERlpDriAajrI5VEA0L+4v1/KsXrG3i5
 zyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793026785; x=1793631585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0hZu4fC9M40eXtw7zx0zkLs5DS7aBYk38bRzFK4atkQ=;
 b=0cG3Y5M7QzJW9K2k4MUD1rlm07srMTzU5LwAf1WrLcbE6594FIZIKYirqL8LYBoyXV
 KSu6O31ypp2Cv6ReJrus54paMxH8SOTboZ6Zf2UDMnaiD1xyTpqm+Je8jNzKFJta1v6Z
 smNetqFyJpfJKUgVYh4k8+fHRQheGBKuQSv21X/paCSZS6QCURq+UnbCiY0GghOiK0qK
 GF51fXYHxGGwTdjq3ga2Iv0PGFfbv9OOUuM0eZQbtsvgtHSSIHyrrEdsIXrsnd7+FzRt
 j8eQ6QCf6Q8Xpci4KmJ9yDc7Gyndt2hv/ogEOsuoOk4M3s8pGy1GC8WPHIL6jvkNci2N
 g1Dw==
X-Gm-Message-State: AFq9FYKEkROrZ8dr3Uo9lefDu3J5HMPbcOGiq5ONUbs0r1gAwEhGnqsz
 QcFg1mNeN0c25Ln22Xd0Y7v2C05tho+EDBNpG6Gteb5DV2RbM9pePCND
X-Gm-Gg: AYBFou33M0Hc1lp8sQLqR+Dfeo8QtCYhe39EWXlTfNOpfFSZJCBUTJmgWIMwUg/jhzt
 TKCLtGZZJAIiGYWzGj8PLKApyH2iQgyXLzZpUcIJbwfI6vy9ttwHppgV2PeCasXrGfNXCk+Ynra
 DftXHcCUIGvB3FqhZ6U7gE1uea8JxubETfTdNPTOXUB0453wQTWhrToZo9PaEFhHBbefmc/rLXV
 Wa0pK2UMLbdeaXTcuFJMv4q3kvju8EqX2neBIRhmnTJNA0XetpVDDQSjXIQRUaSi8++2+1N7bf+
 Mwvfx1N0pfRxoCfOSrROUpNRLyUOIMlewTQMxDP+5n2PaO4x+om40n5zkKbsEhegNOiAQ5wGH5X
 QqID4o4IM7mpa+z2aJ2aC9VYCF9GGezBu2MKlWVcoiuP4bErezobwJQYgJkoAuvU77thAZ8fFtn
 BhS2GMkW2xlF8POo8dibguA8mLWlGbWxLuIO3mDqLqF4C7XHBB3jdvI0tkPkWWKBvA8IrRjm6GK
 PeXyZcevOxIl40KDgkQXYW8aFxzddZHKRJLdpJnyoTIKR2t2o8UxIS2fnE/LIZbHd1Uf6F9K2hA
 LWPC+ZwZDipTRTk2GA==
X-Received: by 2002:a05:7022:b04f:b0:181:8948:f01f with SMTP id
 a92af1059eb24-19937309c99mr9745342c88.36.1793026784563; 
 Mon, 26 Oct 2026 07:59:44 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a277b26csm28619817c88.18.2026.10.26.07.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:59:43 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com
Subject: [PATCH] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Mon, 26 Oct 2026 22:59:16 +0800
Message-ID: <20261026145916.414396-1-yyaqia@gmail.com>
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

fbcon_cursor() can be reached from the console printing path with
interrupts disabled, but it might sleep in two paths:

  console_unlock()                  <- IRQ disabled here
    vt_console_print()
      hide_cursor()
        con_cursor()
          fbcon_cursor()
            fbcon_del_cursor_work() <- this call may sleep

  console_unlock()                    <- IRQ disabled here
    vt_console_print()
      lf()
        con_scroll()
          fbcon_scroll()
            fbcon_cursor()
              fbcon_del_cursor_work() <- this call may sleep

When the VT software cursor is enabled (vc_cursor_type & CUR_SW),
fbcon_cursor() calls fbcon_del_cursor_work(), which uses
cancel_delayed_work_sync() and therefore may sleep.

With CONFIG_DEBUG_ATOMIC_SLEEP enabled, there are reports like this:

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

Use the non-synchronizing cancel when called with interrupts disabled or
from an interrupt context. We still keep the synchronizing cancel in
sleepable contexts, where it is needed to drain the work before
teardown.

Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 94abbb5ac766..f1dbf973e44b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -56,6 +56,9 @@
  *  more details.
  */
 
+#include "linux/irqflags.h"
+#include "linux/preempt.h"
+#include "linux/workqueue.h"
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -441,7 +444,14 @@ static void fbcon_del_cursor_work(struct fb_info *info)
 {
 	struct fbcon_par *par = info->fbcon_par;
 
-	cancel_delayed_work_sync(&par->cursor_work);
+	/*
+	 * fbcon_cursor() can be reached from the console printing path with 
+	 * interrupts disabled. Only synchronize when sleeping is allowed.
+	 */
+	if (in_interrupt() || irqs_disabled())
+		cancel_delayed_work(&par->cursor_work);
+	else
+		cancel_delayed_work_sync(&par->cursor_work);
 }
 
 unsigned char *fbcon_cursor_glyph(const struct vc_font *font, unsigned int cursor_type)
-- 
2.56.0

