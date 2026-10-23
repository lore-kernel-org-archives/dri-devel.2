Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F9606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SvN84fEp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADA8112CCE;
	Fri, 23 Oct 2026 18:17:30 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D6710E0DF
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:51:51 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-35c76e9614aso1797617eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792777910; x=1793382710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7wwANjuDtZeTrIYJO8YoDGwetOTDKqWw0CaiXm+A6RE=;
 b=SvN84fEpCFLzk45l8XXmS5SgQ8ZRQB1JdwJ4fSQykEhYgZ/50QebjIKVS3GG7tIp13
 2rIGlEa0tjBo/3WQoprR3sCSXwqTNQyx6uw+Xg43vf8Q/K3CbgvvZeynFK4bYeuHIIia
 nXdXcckhgdB6Ieqrz5pjSXFSjMQjaI+xFdh6IgpyN7dbkI9L8qU84eQmK0UWn6q9Xgvz
 ol7AyGSGsnIwA59qslbqpu3azqnR4ICE6O1IU8o8d/m2Uhadebynu2S60yEm3kYkqm0D
 wb3V1YauYyOGa11D/DN+YTrJGggWusix28FaFP3AD0Wt4GhFrjFjAt3xl+6L7zPp3iyZ
 q95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777910; x=1793382710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7wwANjuDtZeTrIYJO8YoDGwetOTDKqWw0CaiXm+A6RE=;
 b=P2G7FXC+GHScQnmwBHWCnDu2GTFSKHSzXBnPu7TV15cnay9NirT00ZY7HVJWrkWuF9
 YYJJEeO7J8SurWzi0PDhQw4FZ2e2l92wfLgzSDR/VXpgXFlblX0dUNiO+wQu9Gy1H2MQ
 aWNzJXcDKJr58aovYEJq3KoIFAtedaxx0vyY1eVKwLaLLJcEBJWuvAz6dL1G4RCOynlB
 HGVb5C5LkMowI19eZBttyaXXtip1wEz/QJ0978nzupDhiRC3e182tBxxq90FjZ9xrUrJ
 Se2CWclwtunEHL9PGbvg3pLt/+coOlgiew/ILnxaaJ5LVB64sjFqwUv+HCzOl2FhGPC6
 bbbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWI72rpSLlhIiptGbn0Wj2niJuIXMxMJSJIpZPyQzelI8CwXOAGf4dASDXRfyr6Yr6sn+8+SwU5h0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJE25BjMWPSo050hdLwNuKhEecfF9nrOOgG34sSSoj83ftDxKH
 UWYCcCui8eTtDmM5CtT/0tJittymW0OKn2lvZucF4be5gF00FOmc5cPL
X-Gm-Gg: AYBFou1v/tqpHAIBYNK+1NoZAxHMYaADUb6r+/riK7+0NLdijvx9l8p67O8w0T1upop
 Vozs7E7oZdMCFsRgl//kNOr7I3XzipQuHFqGhIaAgyOhidUq7jewynxPqHQ6jGKgcpejjhnQ0XD
 CM4eENuewUsPzj/9uuK5u6G2tTN5qgDF+eBU8YeSNwFkft17Tr599gnJpq3f+gX5zMmFdyX01Hk
 ilMeGWOuaTH+/uYzVkLTYAxu6+y0a/50dvhvYRgFcGvmgFDpLBsnFCAyOv60yr5zmJtbjem4aw+
 Myer+cqSmOtfBYwlGrElMf3EjMlVNNto9CA44VWBwKszEiN7X4x0YzBEf9FqtaExYc6dDsRgmra
 +vthAzmn4kUrVnoewJNdrgr4S7pmt2p35M/JN/KLJPEeUWH8/jbkHcS7t9qZRgs/tOb6N0KjQLx
 wWAg+uEQEJak3ycxxYTYb+JHqoMvm7dsA0VKZa8ruNp9KMZXKPWHqBPnt0JZIQG8nMZDyAh5wzd
 7l5xIudf2egMCtx+EEZ4+TB6OG5OslUm9NV3DCnDVXQPBDraW1paYT9asdvG8PzKyPYipxqcfDF
 8MgCkWCq++HkU9PkC1Ui7mNmJGsr
X-Received: by 2002:a05:7022:3b85:b0:187:efba:9ba2 with SMTP id
 a92af1059eb24-195c6f00fa6mr4412390c88.44.1792777910049; 
 Fri, 23 Oct 2026 10:51:50 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1989ff2ea25sm132988c88.5.2026.10.23.10.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:51:48 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, Weiming Shi <bestswngs@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Fri, 23 Oct 2026 10:51:29 -0700
Message-ID: <20261023175128.4127122-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 18:17:02 +0000
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

get_line_length() multiplies two int operands before assigning the
result to u_long. Setting xres_virtual to 0x8000000 at 32 bpp therefore
wraps the product to zero and bypasses vfb_check_var()'s video-memory
limit. fbcon can then clear margins with a zero line stride and write
past the vmalloc'ed framebuffer.

The xoffset + xres and yoffset + yres calculations can likewise wrap,
leaving an invalid offset in info->var after fb_pan_display() rejects
it. Subsequent fbcon drawing can then access far beyond the framebuffer.

Finally, PAGE_ALIGN(videomemorysize) was narrowed from unsigned long to
unsigned int. Values near or above 4 GiB could therefore allocate a much
smaller buffer than the size used for mode validation.

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

Reject video-memory sizes whose aligned value is not representable by
the fbdev metadata. Check the offset additions for overflow. Compute the
line length and framebuffer size in u64, reject unrepresentable line
lengths, and check the total-size multiplication before comparing it
with the allocated video-memory size.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: <co+b0df61d49532b2ee@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/video/fbdev/vfb.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bd..84b0a937c 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -101,11 +101,11 @@ static const struct fb_ops vfb_ops = {
      *  Internal routines
      */
 
-static u_long get_line_length(int xres_virtual, int bpp)
+static u64 get_line_length(u32 xres_virtual, u32 bpp)
 {
-	u_long length;
+	u64 length;
 
-	length = xres_virtual * bpp;
+	length = (u64)xres_virtual * bpp;
 	length = (length + 31) & ~31;
 	length >>= 3;
 	return (length);
@@ -122,7 +122,8 @@ static u_long get_line_length(int xres_virtual, int bpp)
 static int vfb_check_var(struct fb_var_screeninfo *var,
 			 struct fb_info *info)
 {
-	u_long line_length;
+	u64 line_length, size;
+	u32 xres, yres;
 
 	/*
 	 *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
@@ -159,17 +160,23 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
-	if (var->xres_virtual < var->xoffset + var->xres)
-		var->xres_virtual = var->xoffset + var->xres;
-	if (var->yres_virtual < var->yoffset + var->yres)
-		var->yres_virtual = var->yoffset + var->yres;
+	if (check_add_overflow(var->xoffset, var->xres, &xres) ||
+	    check_add_overflow(var->yoffset, var->yres, &yres))
+		return -EINVAL;
+
+	if (var->xres_virtual < xres)
+		var->xres_virtual = xres;
+	if (var->yres_virtual < yres)
+		var->yres_virtual = yres;
 
 	/*
 	 *  Memory limit
 	 */
 	line_length =
 	    get_line_length(var->xres_virtual, var->bits_per_pixel);
-	if (line_length * var->yres_virtual > videomemorysize)
+	if (line_length > U32_MAX ||
+	    check_mul_overflow(line_length, (u64)var->yres_virtual, &size) ||
+	    size > videomemorysize)
 		return -ENOMEM;
 
 	/*
@@ -434,9 +441,13 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	if (videomemorysize > U32_MAX - (PAGE_SIZE - 1))
+		return -EINVAL;
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0

