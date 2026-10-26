Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D007606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FyS4VJeO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A028310F325;
	Tue, 27 Oct 2026 09:32:00 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7569910E039
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:49:01 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36661f953e4so5924994eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793029741; x=1793634541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HsJcoE+tcg++lXHusmJ7l3VcG6mAANy+njpMsw2MDrY=;
 b=FyS4VJeOT3J4s92xQXpJa2Du2GYAzi/E7cItBy77DpbtHQ9cKR3Im7LvJp+RtwqDqz
 4UiCLRph+eIj174YsboarV+bM/1MDTi2g3ybbXLDKfxbwyHkaGP1Yyu9ca7Ff8OuAKch
 aoMInglpIHYvff2/UtwP08ifk1ZIqsJk19dAgFj4oQyL8/T3/oQ9ue3ealpkOxiI6F8F
 YrqyOsklKhQlf4UQvdXG9Uu83llMly0Dt9G8XlK6kisYeem8EY8uapgO/5DfUXuJldiW
 hbZVnUoZ+K92RPB5u10H9ITwB5/ylERJymuLq1sxJyoMvos98k3otY5g1d+EcvO5uqI6
 PpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793029741; x=1793634541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HsJcoE+tcg++lXHusmJ7l3VcG6mAANy+njpMsw2MDrY=;
 b=q8LCKtmdSmKU9zDxfwA7Z7X5t/aDkBsPTqSj173WxPYkL8kUixj61/qCd2kUf7A9N4
 /mfBzFidgCQiRQZMto2bmcS7fope2sNjLWm2lIGDiS4y0QAQe0A7JA5UUrBy987nm+KY
 KY5lerDePKY0pthyHaul8IjO1u1d4Nqa5prXuW55HrkKYtkhx1FeVhuNopjfTtBj/Yra
 x8gXhcVboMm41YEjno6kmfcuUWlx4tOP09i+o8NqTJ7IFIB7XFYsrM3wPTsZIaiDaBso
 dSL33NEDF8+sn/mHZIpbN8HVl2IizhGroAsoVvTJfOxKwr4R09AWBVSFnN3bztK5nvZI
 kEjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVQ52uM64nI5rwN1epS23wAJHWdXKQR3PbMHXuRL+lr8NKPWXcW9VBtf5EWOGbOeE7XwdWfZBkXhc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLkHIvuzJQ/BqhzVzFurDaIvm3i64uDnMuhwxKhFr9tWG4RyVUC
 To+ZMhUISm+VtgWg79lWnEfFweeHGSqipXFCYZB2BJhsNRLqwsOyMS9CCCoHMcC9fKtouQ==
X-Gm-Gg: AYBFou23Wxk6lNWg+JquB6zENxU+SXjXyanTTwUOfOC99KpPw5KruxVqe9HMfEujc30
 ymr7bP0RhaVmCsC26r+eJGQhBCnXhkXBuIPSusS+NTZIf7t207hLkjdrltBV9JQbpTG52sHVQoq
 JqfkGPgG2XBITusLh1PcHQpCVxIutLgdk6BdTktGgwQq2hjpCrUkr52cfoxwBkDJfhVg1N2y5Hq
 sWVugQx3QKA82vfw/SmVhRnR8dl2LDXVCpaG13eUZIrv1bW7FsTzaTaCVo4GPzdH5dvCWY196Df
 TiseSI7oZMXJEtdwpJmprc9q+yVdauxlg4+e3+mP09AY0xiw7c0dCgqrVX4n/fsIzf76rDxdgmg
 1uY8+FTFQ7ud3SL9R1A0dWAWKT74YkR6HByxE0xCOyKk3M8vHyM+UEbOtveRA55+/69SAJIldTA
 jDCpsWkidepzsh/aNLKhqBsFldekS1iZTSpgHwDel/L+DbVwl/8fBhG2c9qHt1Z6fw71snuslgK
 FrfIu9+hSC7U1vv5YfZdxB2eCBoEvI25ZLASGaMdzJV01rtfujH/KTeFzgjTYlKkfXbdFRGZSHK
 brpNmulTlztZ3VF2ed2uzkO7tNgA
X-Received: by 2002:a05:7301:514a:b0:359:3460:bc1c with SMTP id
 5a478bee46e88-369e8492c25mr10432744eec.12.1793029740452; 
 Mon, 26 Oct 2026 08:49:00 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369f44bd644sm18151012eec.15.2026.10.26.08.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:48:59 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, Weiming Shi <bestswngs@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Mon, 26 Oct 2026 08:46:05 -0700
Message-ID: <20261026154604.579823-2-bestswngs@gmail.com>
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
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FBIOPUT_VSCREENINFO can supply a virtual width large enough to
overflow get_line_length()'s int multiplication and bypass the
video-memory limit, allowing fbcon to write past the framebuffer. The
offset additions can also wrap, while an excessive videomemorysize
module parameter can be truncated when PAGE_ALIGN() is assigned to
unsigned int.

Limit virtual geometry and offsets to 8192 x 8192 and cap video
memory at 512 MiB, keeping the stride, framebuffer-size, and generic
fbdev drawing calculations within their destination types.

KASAN reports:

  BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
    drivers/video/fbdev/core/sysfillrect.c:24
  Write of size 8 at addr ffa0000001671000 by task poc/198
  sys_fillrect
    drivers/video/fbdev/core/sysfillrect.c:24
  bit_clear_margins
    drivers/video/fbdev/core/bitblit.c:247
  fbcon_clear_margins.constprop.0
    drivers/video/fbdev/core/fbcon.c:1410
  fbcon_switch
    drivers/video/fbdev/core/fbcon.c:2261
  redraw_screen
    drivers/tty/vt/vt.c:994
  fbcon_modechanged
    drivers/video/fbdev/core/fbcon.c:2693
  fbcon_update_vcs
    drivers/video/fbdev/core/fbcon.c:2732

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: <co+b0df61d49532b2ee@bugs.sh>
Suggested-by: Helge Deller <deller@gmx.de>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mode
  support while bounding all generic fbdev drawing calculations.
- Cap videomemorysize at 512 MiB.
- Keep the existing arithmetic types now that all inputs are bounded.

 drivers/video/fbdev/vfb.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bd..de40ba8c3 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -31,6 +31,9 @@
      */
 
 #define VIDEOMEMSIZE	(1*1024*1024)	/* 1 MB */
+#define MAX_VIDEOMEMSIZE	(512 * 1024 * 1024)
+#define MAX_XRES		8192
+#define MAX_YRES		8192
 
 static void *videomemory;
 static u_long videomemorysize = VIDEOMEMSIZE;
@@ -159,6 +162,14 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
+	if (var->xres_virtual > MAX_XRES ||
+	    var->yres_virtual > MAX_YRES)
+		return -EINVAL;
+
+	if (var->xoffset > MAX_XRES - var->xres ||
+	    var->yoffset > MAX_YRES - var->yres)
+		return -EINVAL;
+
 	if (var->xres_virtual < var->xoffset + var->xres)
 		var->xres_virtual = var->xoffset + var->xres;
 	if (var->yres_virtual < var->yoffset + var->yres)
@@ -434,9 +445,13 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	if (videomemorysize > MAX_VIDEOMEMSIZE)
+		return -EINVAL;
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0
