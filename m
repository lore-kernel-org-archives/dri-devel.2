Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B5DFED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB00D10F66E;
	Fri, 24 Apr 2026 17:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WI58WkQH";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402C610ED80
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:29:58 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so37866315e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022997; x=1777627797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PRmQYDLWnbQPdXE28Inb8Q/Xi2npOv1Gc9ccDpPNZg0=;
 b=WI58WkQHJuC/eShwjxx/L4gMMNCVGg9U/DlsST6j2w+chg4OvLC87GAcylgO3gF43q
 YkUEr0pXPEZKJ+tR9R0VHMcusGgQm5PNCndkzoYFOvksll/m+nNGO2QkpT1AKJE3sahS
 imWZddIxC2AQlGIJBFj25MyQSnhwcuZW1btmslcRtDheMD4aL0k3BSlNR0CWC3frLj67
 6TtP5Fl2L2Bkk6cIO4ozsHySm3vkfqn7qiAf2BqfDSp4cnaL6nIfQaaQ9BcaVCwckt9i
 OR8tFiYAJRYECiqaWUEwqC48blvukEgadyT2g+Ki/Np8XbgKXba9MDDEzU8Oeu7uiqHJ
 UAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022997; x=1777627797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRmQYDLWnbQPdXE28Inb8Q/Xi2npOv1Gc9ccDpPNZg0=;
 b=PXuqBBDfO+0RMvhbDLQ+Ai6aLDHS2Kg790S02hH03G1xysr7jXPA57piN7+iIrRIm/
 ARRlc/2javFG6APTRFpcXCvWiwHpm7evrjOt0TxOM1yuf3d5Sd8zZYpyB41cBSGrs5+f
 dYZlEzzsdLjfLDqjJMZHkFg/8J7ZZyszYNXZUhJzgmgwcph0oR87wRML0gk3XV88SyEE
 o3EQok7EZlAaJWTCoZjU8puHHF91neiFEA97V1zzqV3pKKcfQl13Sk0mypCYgH9trRWJ
 Vo8hbjlJ1uUWx/3dD09NaIs4uejAnjNHebnLq3cyy7G0mDA1g5j76Keb7pxhbMiNUFbx
 ting==
X-Gm-Message-State: AOJu0YyNxbtM0Yvr4EoymzKDemIsI1ylpVy1q+rE4flYFcYPnOJt2yAm
 aIsy8BlOQ6eS+V0O3IFmisBNknqsCHmu+GdsOkDHxZiuDaJGhriofdIp
X-Gm-Gg: AeBDieufNEuIfRMcsfrECmyIP1iSGawkROZ2tHSILRZMz06paORA+RVCN7xmRlzrqKJ
 iOGTELLhXm4ohYPQRaPTx5DY+6BFSi2FJ6GyzPHN9uYeZZRB3Ax8oauRFxQ0H/aPwKIKqHV/BVa
 4Wh8ze/p7lqsKoVf6vyPj1J7OtsK7TC6HxguyEosj9BRlKP0a/dcnmkV5c36pgJurx8rhgVQFkK
 cpPgUxM8ciRyeMGzJmGiwUpn+gZcSFNCO/P38OnXCcyBRqppb5ftWQuFWisYuIVEvDZ+yvOBgSO
 OCp0kWegGMvuRLyJl153uFkt6DcyPjybS4i29YEm40Lo/JQAS43aIkTnfFwBU4+I9mKoJsNujZD
 GKzEZyWRrlL6WJpAZeqteUlYAPvGkH/yF2KsHYUxRttGEdsP+hEdnUV13xl31I9UXfVGsI575Zf
 HxMy5W0W1TDQIh3wsjMf6Fg5zBjrNaE55FT/vJ5BkSQcGPbjCU26UQ/SVRGrQFTC+m4q8hN9VpN
 V4Ymgcw8g2IPiW74lwijcBv6fVMI0PIE2kaGDx7+lIrKt3sT9yeNJpkqXRjqxM2L0br
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-4891d7a463emr288514125e9.3.1777022996567; 
 Fri, 24 Apr 2026 02:29:56 -0700 (PDT)
Received: from ahossu.localdomain ([5.14.129.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52d232afsm97787865e9.31.2026.04.24.02.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:29:55 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH] staging: fbtft: fbtft-bus: replace function-defining macro
 with concrete functions
Date: Fri, 24 Apr 2026 11:28:18 +0200
Message-ID: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

The define_fbtft_write_reg macro defines full function bodies including
a goto statement and a trailing semicolon on EXPORT_SYMBOL(), which
violates kernel coding style (checkpatch reports 2 ERRORs, 2 WARNINGs,
and 5 CHECKs).

Replace it with three concrete C functions that are semantically
identical to the macro expansions:
  - fbtft_write_reg8_bus8   (u8 buffer, u8 data)
  - fbtft_write_reg16_bus8  (__be16 buffer, u16 data, cpu_to_be16)
  - fbtft_write_reg16_bus16 (u16 buffer, u16 data)

The function declarations in fbtft.h are already present and unchanged.

Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 191 +++++++++++++++++++++---------
 1 file changed, 137 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..acd035203 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,60 +11,143 @@
  *
  *****************************************************************************/
 
-#define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
-void func(struct fbtft_par *par, int len, ...)                                \
-{                                                                             \
-	va_list args;                                                         \
-	int i, ret;                                                           \
-	int offset = 0;                                                       \
-	buffer_type *buf = (buffer_type *)par->buf;                           \
-									      \
-	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {                    \
-		va_start(args, len);                                          \
-		for (i = 0; i < len; i++) {                                   \
-			buf[i] = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
-		}                                                             \
-		va_end(args);                                                 \
-		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,                  \
-				  par->info->device, buffer_type, buf, len,   \
-				  "%s: ", __func__);                          \
-	}                                                                     \
-									      \
-	va_start(args, len);                                                  \
-									      \
-	if (par->startbyte) {                                                 \
-		*(u8 *)par->buf = par->startbyte;                             \
-		buf = (buffer_type *)(par->buf + 1);                          \
-		offset = 1;                                                   \
-	}                                                                     \
-									      \
-	*buf = modifier((data_type)va_arg(args, unsigned int));               \
-	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
-				 0);                                          \
-	if (ret < 0)							      \
-		goto out;						      \
-	len--;                                                                \
-									      \
-	if (par->startbyte)                                                   \
-		*(u8 *)par->buf = par->startbyte | 0x2;                       \
-									      \
-	if (len) {                                                            \
-		i = len;                                                      \
-		while (i--)						      \
-			*buf++ = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
-		fbtft_write_buf_dc(par, par->buf,			      \
-				   len * (sizeof(data_type) + offset), 1);    \
-	}                                                                     \
-out:									      \
-	va_end(args);                                                         \
-}                                                                             \
-EXPORT_SYMBOL(func);
-
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
-define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+void fbtft_write_reg8_bus8(struct fbtft_par *par, int len, ...)
+{
+	va_list args;
+	int i, ret;
+	int offset = 0;
+	u8 *buf = (u8 *)par->buf;
+
+	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {
+		va_start(args, len);
+		for (i = 0; i < len; i++)
+			buf[i] = (u8)va_arg(args, unsigned int);
+		va_end(args);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
+				  par->info->device, u8, buf, len,
+				  "%s: ", __func__);
+	}
+
+	va_start(args, len);
+
+	if (par->startbyte) {
+		*(u8 *)par->buf = par->startbyte;
+		buf = (u8 *)(par->buf + 1);
+		offset = 1;
+	}
+
+	*buf = (u8)va_arg(args, unsigned int);
+	ret = fbtft_write_buf_dc(par, par->buf, sizeof(u8) + offset, 0);
+	if (ret < 0)
+		goto out;
+	len--;
+
+	if (par->startbyte)
+		*(u8 *)par->buf = par->startbyte | 0x2;
+
+	if (len) {
+		i = len;
+		while (i--)
+			*buf++ = (u8)va_arg(args, unsigned int);
+		fbtft_write_buf_dc(par, par->buf,
+				   len * (sizeof(u8) + offset), 1);
+	}
+out:
+	va_end(args);
+}
+EXPORT_SYMBOL(fbtft_write_reg8_bus8);
+
+void fbtft_write_reg16_bus8(struct fbtft_par *par, int len, ...)
+{
+	va_list args;
+	int i, ret;
+	int offset = 0;
+	__be16 *buf = (__be16 *)par->buf;
+
+	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {
+		va_start(args, len);
+		for (i = 0; i < len; i++)
+			buf[i] = cpu_to_be16((u16)va_arg(args, unsigned int));
+		va_end(args);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
+				  par->info->device, __be16, buf, len,
+				  "%s: ", __func__);
+	}
+
+	va_start(args, len);
+
+	if (par->startbyte) {
+		*(u8 *)par->buf = par->startbyte;
+		buf = (__be16 *)(par->buf + 1);
+		offset = 1;
+	}
+
+	*buf = cpu_to_be16((u16)va_arg(args, unsigned int));
+	ret = fbtft_write_buf_dc(par, par->buf, sizeof(u16) + offset, 0);
+	if (ret < 0)
+		goto out;
+	len--;
+
+	if (par->startbyte)
+		*(u8 *)par->buf = par->startbyte | 0x2;
+
+	if (len) {
+		i = len;
+		while (i--)
+			*buf++ = cpu_to_be16((u16)va_arg(args, unsigned int));
+		fbtft_write_buf_dc(par, par->buf,
+				   len * (sizeof(u16) + offset), 1);
+	}
+out:
+	va_end(args);
+}
+EXPORT_SYMBOL(fbtft_write_reg16_bus8);
+
+void fbtft_write_reg16_bus16(struct fbtft_par *par, int len, ...)
+{
+	va_list args;
+	int i, ret;
+	int offset = 0;
+	u16 *buf = (u16 *)par->buf;
+
+	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {
+		va_start(args, len);
+		for (i = 0; i < len; i++)
+			buf[i] = (u16)va_arg(args, unsigned int);
+		va_end(args);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
+				  par->info->device, u16, buf, len,
+				  "%s: ", __func__);
+	}
+
+	va_start(args, len);
+
+	if (par->startbyte) {
+		*(u8 *)par->buf = par->startbyte;
+		buf = (u16 *)(par->buf + 1);
+		offset = 1;
+	}
+
+	*buf = (u16)va_arg(args, unsigned int);
+	ret = fbtft_write_buf_dc(par, par->buf, sizeof(u16) + offset, 0);
+	if (ret < 0)
+		goto out;
+	len--;
+
+	if (par->startbyte)
+		*(u8 *)par->buf = par->startbyte | 0x2;
+
+	if (len) {
+		i = len;
+		while (i--)
+			*buf++ = (u16)va_arg(args, unsigned int);
+		fbtft_write_buf_dc(par, par->buf,
+				   len * (sizeof(u16) + offset), 1);
+	}
+out:
+	va_end(args);
+}
+EXPORT_SYMBOL(fbtft_write_reg16_bus16);
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.53.0

