Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F0CD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807EA10EB9E;
	Sun,  7 Jun 2026 21:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="aaqtDv2Z";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E1010EB9E
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780866124; x=1781470924; i=deller@gmx.de;
 bh=p2xWpZVBhxwbeMjpSopR2RGaZvmMmu2NdGj2i5TYV6k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aaqtDv2ZDhUchb73gvJ9E2UIilD1l8/2OURY7SfeTqQTXYOZmo4Oib6Wf/qUnOrB
 IIQXQlWIxUvx/7GximnVRV2ngU+Q2vWPG1NoitFHgRU54Zy/vO8u7aWFWnuZHxxRF
 13+zJLFT0D8oNUzSBHbJolgdOrlD655aLCjhXKqKaKK0pSYQlLVScKVS26R0HwTEP
 f2/eXdgg/x2pgP59FJgNblufRbGomx2n4yw4L8PbQGrFZkVw5kl61USpjJb+KLQmw
 opMsVNy9GEf8h3C4jRj++q8B26gX4tuYSqQCCcAVeAiE0rIq8dNfOku7snbiJE7+n
 414+ufIc0S4oC4L7Zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1wMSk416bU-00Fxiw; Sun, 07
 Jun 2026 23:02:04 +0200
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
Date: Sun,  7 Jun 2026 23:02:03 +0200
Message-ID: <20260607210203.229613-1-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WOvRLrJZH2fMsLz0p1TR50u4KJMnjSVZyAge0lxD1vOf9uHZLIE
 pr0h1v0mlsEqKhkasB1OPK9nV/+keAJB4/+b/FT4BxN3ezE6jmbbEs9pjsXsOB1mzjUBHgm
 LDW6cyLd7RlXvP33EzuDXDdBCQJk8ADMRU0MtY3fUHz5YLEpUglTyUjZskiIw0VrSA+U1VT
 gKvA/FctfsKAVbwKX8yqg==
UI-OutboundReport: notjunk:1;M01:P0:Xb6DGd7uGTQ=;ANp5u/YJxeDUNL7RG5vqoUycBCu
 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
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The text display code used in the Risc PC kernel image decompression
code uses arch/arm/boot/compressed/font.c, which includes
lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.

Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
glyph pitch and size") <linux/font.h> contains inline functions that
require __do_div64, which is not linked into the ARM kernel
decompressor. This makes Risc PC zImages fail to build.

There is no need to use 64-bit division code here, so resolve this issue
by using plain standard addition and shift maths.

Fixes: 97df8960240a ("lib/fonts: Provide helpers for calculating glyph pit=
ch and size")
Reported-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 include/linux/font.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/font.h b/include/linux/font.h
index 6845f02d739a..67d32268989d 100644
=2D-- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -11,7 +11,6 @@
 #ifndef _VIDEO_FONT_H
 #define _VIDEO_FONT_H
=20
-#include <linux/math.h>
 #include <linux/types.h>
=20
 struct console_font;
@@ -35,7 +34,7 @@ struct console_font;
  */
 static inline unsigned int font_glyph_pitch(unsigned int width)
 {
-	return DIV_ROUND_UP(width, 8);
+	return (width + 7) >> 3;
 }
=20
 /**
=2D-=20
2.54.0

