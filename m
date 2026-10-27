Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B987606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLIi192z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39DB611203A;
	Thu, 29 Oct 2026 07:58:58 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6374210F6D1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:09:51 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-353804b591eso71873eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793117390; x=1793722190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zXxn2I5xRz6x8frUdiRRQE7jhrWj+wttl0bEoQMCRfs=;
 b=YLIi192zzcmCYr223qMnJejxqVHkgtNPtR4xvXgH2tx7ts3IavdtIxNd3E+LntdpkD
 QW01b/4DSLnA6d65QZ9zrm78wuWGTbvOssX1ACEOwCFY4vSaUSkHoRm/PhY3fG/tlADf
 1z9+Jmu28XnaHj3jXq8kdL+r2j/aBYyfEKPf0V4LBH3O1dSdI2J1AKLQJdWEzPHjM5Ut
 +Rvxyt0CFRBoRx1av8rjDcIOv7aashitAV/RO8etnr0o8Lkm771Xc0Y/aSMk/Y7ocs5P
 fqsNSooadv804PlCOoPVtQ9p76rxWH8G5KxTJq+Zx2fO4wTLxUgF4EFWMm1WU8xxBqt6
 HBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793117390; x=1793722190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXxn2I5xRz6x8frUdiRRQE7jhrWj+wttl0bEoQMCRfs=;
 b=gror2nA8KXNbNmA8JlFWBuCjdbaHs0mwZLlKZJMmAkldOcPCpJv5e77gHeAyj9kJya
 VxCryydpFX5bdHqkrIgwToP70MumlY4InJ0UhTdzfZQPUC6R0ilTPv5dNEsPzV3C86Ux
 kDo/jbjUJuInfBDQoWNrrFHHQUIcfvfA3Bhe8/rXWbJwzJDc3FK2FgePPdlnJ8NCv0NU
 x0skDzu/KB/kRH4f1hGr9tRx6MmBkZLhHQrLxVqwJWTZ5UTJMf9rrxGVpgNwoMIRVvHV
 ffIcYlATrWlR8aYDfzHyJWI/4DZgUxMLvfOZ+2SH8qfp4ebRuDE2qazWH/IpyKWPTr51
 QT7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnmsUGXaFwWR6Ad9VL/i6356jsCj3wUSCInb+Q6Ajn/LcMOLsikPIhaGAhEkNJ/mxA+IwcJSNCpDg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJqfqvAaOz7kBQfpOyCyxQOOXTPVEgMuWL778xV3t2zvs5gb+nj
 XVo9XgZaABlU9UQgumH/T7rEQQXB5yKTX6xXEc4Pm3+xpvnw7jjnqVNv
X-Gm-Gg: AYBFou2JP9oHSRCQXxLIVb1+Yji1Cxku+zDib+cU7icTsTOuTnUvUBJDNftjf176Oqj
 Eanx+3lDZKYdv4701lO4Mp+v7QCMtuZY+zxcbHQtd0UggRg2tXLmWIeKy4sZth/RgDtkWK6ZFKu
 Ptw+lJTx4Jrtx8M0mpVJSCST/4PsVlVtFDhSp3kg7rnUEtZoGZdMA14JyJU+L1kVcvvfuxBxKAP
 zAOjYJvBed01b2J3ncJSqUfNynirz7Xz4g8bf14Ee8Gz1rXq+BqYiD3Pv3U7EEk7vDsaQqSslgy
 BEc2NgvrQAP3mdxEIIr6rdd4yu7OqJ57QZAr/WszdgS5xTrhEF848mQTuESWkqZfOX5/TIumep3
 plLrlZHTiV+uMRF//+pupw/nYX2neEAhvm/NFzjMAaT50ruiYZPmTsYHONsy1s4OvJdWcG7MUEA
 6tKTRrgR6W3C8DaCupTDXL2vlG+3Nye1qn+bEIiRv0lLL/4037mLoQ9eG+X4T8wRgJlDNT55s3b
 jP4ljhNN2+aRO2KmjCcEM7v0kxnHJ/mHV7rfNioVUf2r7m/7c3Lm4Iue6Kdu0+9gYK/FOlGoKYJ
 mGw7fE1qnLEURHZvqprfk6YwOusWUAPH2jB5d9YKTx09+qcf+HG2zjQcrdOKQAMUtgMEkly4IGo
 N8g==
X-Received: by 2002:a05:7301:d192:b0:353:7e33:664c with SMTP id
 5a478bee46e88-369e8610eedmr14636189eec.37.1793117390413; 
 Tue, 27 Oct 2026 09:09:50 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8daa3a8sm43061239eec.16.2026.10.27.09.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:09:49 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, Weiming Shi <bestswngs@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Tue, 27 Oct 2026 09:09:14 -0700
Message-ID: <20261027160914.3787276-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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

Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
keeping the stride, framebuffer-size, and generic fbdev drawing
calculations within their destination types.

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
Changes in v3:
- Clamp visible and virtual resolutions and offsets instead of rejecting
  oversized requests.
- Clamp videomemorysize before PAGE_ALIGN() instead of rejecting it.
- Add unsigned suffixes to the limit constants.

Changes in v2:
- Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mode
  support while bounding all generic fbdev drawing calculations.
- Cap videomemorysize at 512 MiB.
- Keep the existing arithmetic types now that all inputs are bounded.

 drivers/video/fbdev/vfb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bdaed..deaa3e9c758d 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -31,6 +31,9 @@
      */
 
 #define VIDEOMEMSIZE	(1*1024*1024)	/* 1 MB */
+#define MAX_VIDEOMEMSIZE	(512UL * 1024 * 1024)
+#define MAX_XRES		8192U
+#define MAX_YRES		8192U
 
 static void *videomemory;
 static u_long videomemorysize = VIDEOMEMSIZE;
@@ -142,6 +145,10 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 		var->xres = 1;
 	if (!var->yres)
 		var->yres = 1;
+	var->xres = min(var->xres, MAX_XRES);
+	var->yres = min(var->yres, MAX_YRES);
+	var->xres_virtual = min(var->xres_virtual, MAX_XRES);
+	var->yres_virtual = min(var->yres_virtual, MAX_YRES);
 	if (var->xres > var->xres_virtual)
 		var->xres_virtual = var->xres;
 	if (var->yres > var->yres_virtual)
@@ -159,6 +166,9 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
+	var->xoffset = min(var->xoffset, MAX_XRES - var->xres);
+	var->yoffset = min(var->yoffset, MAX_YRES - var->yres);
+
 	if (var->xres_virtual < var->xoffset + var->xres)
 		var->xres_virtual = var->xoffset + var->xres;
 	if (var->yres_virtual < var->yoffset + var->yres)
@@ -434,9 +444,12 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	videomemorysize = min(videomemorysize, MAX_VIDEOMEMSIZE);
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0

