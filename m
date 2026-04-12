Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2C4EBFD0F
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACC810E355;
	Mon, 13 Apr 2026 08:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FR3KkcPT";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D8E10E0D9
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:22:03 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so25346795e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776014522; x=1776619322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7F4lbNQWtZXtoROCb8OY9JzSy1iP1R3hy25K3QPEtAo=;
 b=FR3KkcPTffoBztS6Uhb8ovSjNtpN7csjWnZzh5pyABLZP6kqd6FNgDxidHGZttTmgu
 hONEzxv962IBPuRbqQHbQEJknTLxbP7/FhDyIN2bPD7cnAY9OLjdMFZrGRNIG4q3b2cY
 xH78wSUaHa3jxP9o0fenGeA2eE1OlOuQVjAcGZCwcnaEDKiL0tDPevDKcCF5OlhWJeqZ
 CR3PZHaUi72wfpo2YTDFOlqCxwGBx/8oUrfB91yJR2kQ3mEz1LF+SsGABuQ8sbhMfF2q
 +zomISncTo38hwweX4yvt6xJOqOnL8U7qosvlEk1hR/jm+ymW/aCAM9WmoEEwz4B1F1N
 4OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776014522; x=1776619322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7F4lbNQWtZXtoROCb8OY9JzSy1iP1R3hy25K3QPEtAo=;
 b=FSq1tSZNsWLssFOEYSPpq1s3JGmimO1pEUanIAjAOZeEMWuMFsw/vl4X3QIxqT5s6j
 YZvwjIPjFSW1buhGMOJ1eP23NKNWdWj5HjnpvuzHHbk/slfG1fdjkcTKLoHmfxuflXk6
 p90HIO7B7sG69MNefGm0W3HPnwwFRj9EetROILTjRPdRDG2j/dNSiACec/6eOhATcOvv
 Cwp5a1XNiwJ8I/tFUWBN9s18AZY+TtA/rD3o8g+PkOLuSHRD3JJ/AMWm8gusfz2QCswZ
 kgriQwu+gd3JkHBhaOOoAzSO7qsIEKoJbdso2j/agZ/tUJvTK4hrIrHsRV9jiBsHytIs
 bP2A==
X-Gm-Message-State: AOJu0Yw4vfx9Y24o5QvszGgRunUgNv6drdV+58ma8d5uPuMDw9hGMLT+
 eRGPp0NizGpmyDrPOPlIzZVM8nmlH857vAmT6xhoKNdzEv5sCMsISAwz
X-Gm-Gg: AeBDievcOzgjFxWOel0V0O5OZ7IDDzNn/i1hY0TJvSmENYCuKtv+hDkUxLVGePEIsZ2
 Ygk63c6sRhaKPAneedhnjVxu0Ay6RGhKYnc0plvjc8NDgk5CIpuqyrWCFMui9iDsUrH8KINiMBY
 R7cVcWrF6XPGJ8U8gMd/+aEprHv/f3lQg2H1BHyDUtvVlcrOBg1SgSxoxa8Dk53d1bPxRCyB0Ec
 bWBUpUaFfwglBmtaH8GnvBGmCI/Mbpvb7ovBPPrAx0qsm7Sibs2RxSXB7ZOG2U1y4SbMJ2TQ0lC
 ZI19rJSzyKMesrokFyYB4w28Mjdm9ku8uHfuOI4N7RMBOkSX7w6KbxqN8GkRaFpRkhqNKuzbX91
 aXT5xXr40wA0DGzH+I70w2yMDg9JC0m464nd3BcKopjCBvv2a7UYrl4eTXco4y03pcecxqXJsPH
 6s8UPtzNCRV7jrj1BtV5Uoj1sDBTjbLiM=
X-Received: by 2002:a05:600c:a109:b0:488:af7f:7751 with SMTP id
 5b1f17b1804b1-488d6836508mr100895415e9.15.1776014521398; 
 Sun, 12 Apr 2026 10:22:01 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:58be:2682::3d6:8f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5380feesm287047045e9.9.2026.04.12.10.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 10:22:01 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Baker <mzndmzn@gmail.com>
Subject: [PATCH] staging: fbtft: replace empty macro args with identity
 converter
Date: Sun, 12 Apr 2026 12:21:47 -0500
Message-ID: <20260412172147.2817-2-mzndmzn@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412172147.2817-1-mzndmzn@gmail.com>
References: <20260412172147.2817-1-mzndmzn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:01:34 +0000
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

The define_fbtft_write_reg macro calls 'modifier' as a function.
Passing an empty token as modifier is undefined behavior in C for
fixed-arity macros. Introduce fbtft_no_conv() as an identity
function to replace the empty args in the no-conversion cases.

Signed-off-by: Baker <mzndmzn@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..8ce263f68ed2 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,6 +11,8 @@
  *
  *****************************************************************************/
 
+#define fbtft_no_conv(x) (x)
+
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
@@ -62,9 +64,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.47.3

