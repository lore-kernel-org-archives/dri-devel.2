Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11D0CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2A410E1DB;
	Thu, 25 Jun 2026 11:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ww2d4Wy6";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4080D10E1DB
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:42:33 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-13986d61b4fso3158046c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782387752; x=1782992552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B73dDp79EG28EytJ5lKOIpIzktknebQaTwhx7eBVLTQ=;
 b=Ww2d4Wy6am5Nntaem3daEwqtWiAXzTndxPt/Ga3g7QBuvPfkesiMBqcrCeXEq3bXsv
 bQEswGUNiukLRAoG2xKOpl1qPvPAozygjM+lkYjp1KC2uLCQcKBCZruYAZa5aJGMKn9C
 w0ZTCD76eU7om25h/jd1bSUVbrC3kPTgfVAAJjRgSv4qOX3SOxdaP+fAf/eaOGZnkdhc
 ZLuAQTUSKPR3Rk1aZ6OzXVWVxzdOhXGjEz0wSVx/sws6Im3f2dQbqqYenV1Wt0zIAHZW
 z5oc0vCHcc7IR/P8rZem6PIbvpBWaFbucAHAHUiLxtMJIvUTw7bHwXdwHkFX2sDmSp7j
 recA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782387752; x=1782992552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B73dDp79EG28EytJ5lKOIpIzktknebQaTwhx7eBVLTQ=;
 b=C1oy8eKpAnOQat9HkFAF+Rgt5bej960mkW+1WdAczknMfS4bwvHBHJ5+8Dq16VnzZX
 VEPZCbyt3T7QjBkH5+J+iDymi88QuedECfm+qQhPO+Oedod40xFSp7S7OXDXmyRgyo+5
 YQ6tcW6h7N06g/pwTW7VB9nqqOSpBdZBSv861+GlmFlO417QDaoYH96zhWXw8NlP4oFu
 pgr5o3km89dg05S2kgWZwp0XC6oP72TFKi00Cp4GjHfJBFziOhN0uQiLGsnEYKUyoQ1Q
 XIdsamFSCNrulyjscq2s8XBhsBC1yX5dpuctSTnoVQcvDcJ+Mj+YI4Afyp7dSWfAcdMK
 KJ8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uIdpOGk6T6Gl4g6n1AZAkflPneUAj+RMNNJ0dMkB8gLsIfKJTtFWGO2OJ45xqeYnaOnDEUKreCok=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLy4bK+J5IaQhe2CORaJRu74aSX1SOc8ZsGFNgBWwxt8rvZewz
 T4MxFW45KzCEOzCJENqfcp+JtrOGCNlmWp4nBpu8DcMcPFw4yR8uho1P
X-Gm-Gg: AfdE7cmw3fuzo0IFAdk38DnDRZzmRnMbNYEb9pHiCyBIlf3Km1PsQ185jMWx1DidD7m
 sRHNdwmneHfoUKyXiO4JORDmC0GNk7fCWYnC2TYhtGR07A35Its8zynacEUjb/ny+VWNpysAjmk
 mxYcDqbRct7ikLsHJLMOFtCWsjm3bBdIoWQ58oopW5haCZn7Mb1Bx+w8WMFQxPnNoEP+f9O0zxQ
 jDqCFG/gfX5o/uJA9YsMqOhMmMSKg0WU87z2sDCL9dMbAZmAocp7IBFQDNb5zv4C97RLdR5Kem5
 wR64ECNc7sFxu67scTG0KMXpLjbObmOAW5yJzgse+aClVkmIsZnl81k/GhTsuRZfoWnEMiYTrzd
 S98DByzQBkkh7Ykn5pUp6ii4dB2pEV/JPRPa311wD9HCZGgdMbcqNHs+g+O4iEj3gX5mTT/CUyw
 sNRwCywgilKfpLjt5YBISnM7zKsbN/3FDr3w==
X-Received: by 2002:a05:7022:504:b0:139:dab5:e2bb with SMTP id
 a92af1059eb24-139dba4ac87mr2092744c88.15.1782387751916; 
 Thu, 25 Jun 2026 04:42:31 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d912197bsm12312296c88.15.2026.06.25.04.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 04:42:31 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: fbtft: fix unaligned access and txbuf safety issues
Date: Thu, 25 Jun 2026 19:42:15 +0800
Message-ID: <20260625114215.325973-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625111602.438761F000E9@smtp.kernel.org>
References: <20260625111602.438761F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch addresses several pre-existing issues in the fbtft driver:

1. define_fbtft_write_reg(): when par->startbyte is set, buf is
   advanced by one byte creating a misaligned pointer for 16-bit types.
   Use put_unaligned() for register writes and fix the SPI transfer
   size from len * (sizeof(data_type) + offset) to
   len * sizeof(data_type) + offset.

2. fbtft_write_vmem16_bus8() and fb_ra8875 write_vmem16_bus8(): same
   unaligned 16-bit stores when txbuf is byte-offset for a start
   prefix. Use put_unaligned() for pixel data copies.

3. tx_array_size underflow: both vmem helpers subtract 2 from
   tx_array_size when a startbyte prefix is used. A small txbuflen
   device property causes unsigned underflow and out-of-bounds heap
   writes. Fall back to the non-buffered write path when the buffer
   is too small.

4. fb_ra8875 write_vmem16_bus8(): missing NULL check for
   par->txbuf.buf, which remains NULL on big-endian when txbuflen is
   0 because the PAGE_SIZE fallback is little-endian only. Fall back
   to direct write when the buffer is missing.

Also replace empty modifier arguments in define_fbtft_write_reg() with
a no-op macro to fix checkpatch warnings.

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 10 +++++++++-
 drivers/staging/fbtft/fbtft-bus.c | 25 +++++++++++++++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de664..06f650aac 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 
 #include <linux/gpio/consumer.h>
+#include <linux/unaligned.h>
 #include "fbtft.h"
 
 #define DRVNAME "fb_ra8875"
@@ -250,7 +251,14 @@ static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
+
+	if (!par->txbuf.buf)
+		return par->fbtftops.write(par, vmem16, len);
+
 	tx_array_size = par->txbuf.len / 2;
+	if (tx_array_size <= 2)
+		return par->fbtftops.write(par, vmem16, len);
+
 	txbuf16 = par->txbuf.buf + 1;
 	tx_array_size -= 2;
 	*(u8 *)(par->txbuf.buf) = 0x00;
@@ -262,7 +270,7 @@ static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 			to_copy, remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i] = cpu_to_be16(vmem16[i]);
+			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
 
 		vmem16 = vmem16 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf,
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..52a0c5c0c 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -4,6 +4,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
+#include <linux/unaligned.h>
 
 /*****************************************************************************
  *
@@ -11,6 +12,7 @@
  *
  *****************************************************************************/
 
+#define fbtft_write_reg_no_modifier(x) (x)
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
@@ -39,7 +41,7 @@ void func(struct fbtft_par *par, int len, ...)                                \
 		offset = 1;                                                   \
 	}                                                                     \
 									      \
-	*buf = modifier((data_type)va_arg(args, unsigned int));               \
+	put_unaligned(modifier((data_type)va_arg(args, unsigned int)), buf);  \
 	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
 				 0);                                          \
 	if (ret < 0)							      \
@@ -51,20 +53,22 @@ void func(struct fbtft_par *par, int len, ...)                                \
 									      \
 	if (len) {                                                            \
 		i = len;                                                      \
-		while (i--)						      \
-			*buf++ = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
+		while (i--) {                                                 \
+			put_unaligned(modifier((data_type)va_arg(args,        \
+					       unsigned int)), buf);          \
+			buf++;                                                \
+		}                                                             \
 		fbtft_write_buf_dc(par, par->buf,			      \
-				   len * (sizeof(data_type) + offset), 1);    \
+				   len * sizeof(data_type) + offset, 1);      \
 	}                                                                     \
 out:									      \
 	va_end(args);                                                         \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_write_reg_no_modifier)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_write_reg_no_modifier)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
@@ -142,19 +146,24 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	tx_array_size = par->txbuf.len / 2;
 
 	if (par->startbyte) {
+		if (tx_array_size <= 2)
+			return par->fbtftops.write(par, vmem16, len);
 		txbuf16 = par->txbuf.buf + 1;
 		tx_array_size -= 2;
 		*(u8 *)(par->txbuf.buf) = par->startbyte | 0x2;
 		startbyte_size = 1;
 	}
 
+	if (!tx_array_size)
+		return par->fbtftops.write(par, vmem16, len);
+
 	while (remain) {
 		to_copy = min(tx_array_size, remain);
 		dev_dbg(par->info->device, "to_copy=%zu, remain=%zu\n",
 			to_copy, remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i] = cpu_to_be16(vmem16[i]);
+			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
 
 		vmem16 = vmem16 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf,
-- 
2.47.3

