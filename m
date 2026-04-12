Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9097EBFD10
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C2110E359;
	Mon, 13 Apr 2026 08:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PC9WMFW+";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B2B10E2D0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:33:30 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so2409398f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776015209; x=1776620009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SbvXgjGPphhAE2I9ElLsnXiA+UjDwBVBpN1/DptNsY=;
 b=PC9WMFW+haNXCW+RO5Z6KG4w9V5/zLeqtbtoxobZR/47eFFKZYEIHNw6gFu1lnewjP
 WJQdUCzDxbWb42El1Ip0MTPeCNidH5+qTVjixgw1ihv+LOowR3TH4lsv0cave+zW4fJZ
 cgHJaFCpieZxeK/RqvAHs6EX0PNKPofCU/ELAxrm5IpdlNxLJqHEWhyD0JstWr/GePw/
 y0PMqzrh0apGZnBe6dXrww2lzio/lAOW1Nn0SJOGGbfJiuXodL2BDoztDmDBUIVw/kX/
 rloPKqs0ZTQHPrRoy5py24K/3wjqSgXidIvy1trLGFq0z/nPi2gfOXuLlq+bIE7ZbkpT
 GLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776015209; x=1776620009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9SbvXgjGPphhAE2I9ElLsnXiA+UjDwBVBpN1/DptNsY=;
 b=mGk2PEhXR5Hq7qMuwa2vYKvV0YawBmZSzO97/XkRhEc/uk2dF+JgMzRPtJxT8GTizf
 2t52uyGLAfuaFZeyUEHo9dIfCUQsmnPTT9z/RSbuQ7YTTVMbEzh6FXKNx+ApOXLXS0Ex
 ACsDQ2ihjsDlKJ6XiXOz6nM6yxXfM+J2/n+9RYHIyjbbi9CznG9nDZNbb+VmuIvjD3Wq
 qFyak1njEbdRlM9U6/byJiMly2c8ILeQs1VuhmyyALm3thnsHOK7Jrbs1Kb4TeiQHMUY
 nan2Jv2Snw+ETS7Rik9lHaz5TI1Xtk9dIf6AL258AK4iiSEvgRjtYdbWBXQiyMrj7Lzo
 K/+g==
X-Gm-Message-State: AOJu0YyqxgMOqLL+k0TbzjN5JOgTv+j4EbEdeN9z5VYW3h1A3P16R4pA
 4hnHYJf7icX8PPzsOTAWYLCho7pkEUKeoViOB1lRqFD0fz/s8h33EIpt
X-Gm-Gg: AeBDiet4cEvFnEOYycd6A8pb5lR4G7Cibg2JAMayN9lmXeKSAy9FUy3RxFOi2igTb2c
 hyu7oWsx1+2/Cs4/Kdfg9lwURCNSMvg6chE4qxb7JVvoOsKV9rusoUzGuNJZgl0pqp6hLXUcJIO
 w7hhsESSFSpcZOBl/TMT50xaCKZC99LcB+DDRBe+4yPy4boOia1kF3l8p8SjoTyK1jKzh7jpwzu
 DZFNL/zaPKLAX5qRq/2o53QiFQdy8/SY6w1Up4t60mi0IJ6Lj1a95AnXIMD0gYIKvPLCWmLgX+M
 SQqSmpbGtl9xO5TC4AzLaPV//ZBRGknGfz0WGAeKVCFKkgz21YuWdtDuwa+gc/VRZZfmfoFgswy
 5mH8mtTnAtmPr9JRv4Nz5NlbCc7W291ClA2dLbJaKRJLLqO9DDGE0g1FqCaRpTe++ZIAiz3wiMD
 rkZWncl0Fz2uQMxdoJnL3O1uhmS+5LEyg=
X-Received: by 2002:a05:6000:25c4:b0:43d:4a74:8ec7 with SMTP id
 ffacd0b85a97d-43d64286af4mr15611203f8f.20.1776015209362; 
 Sun, 12 Apr 2026 10:33:29 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6c0:2682::3d6:8f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d76eeb2d1sm5499983f8f.22.2026.04.12.10.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 10:33:29 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Baker <mzndmzn@gmail.com>
Subject: [PATCH v3] staging: fbtft: replace empty macro args with identity
 converter
Date: Sun, 12 Apr 2026 12:33:17 -0500
Message-ID: <20260412173317.3329-2-mzndmzn@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412173317.3329-1-mzndmzn@gmail.com>
References: <20260412173317.3329-1-mzndmzn@gmail.com>
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
index 30e436ff19e4..7f3fd30576ab 100644
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
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_no_conv)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_no_conv)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.47.3

