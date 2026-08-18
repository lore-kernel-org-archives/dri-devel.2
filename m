Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729F8C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22EA10EA36;
	Tue, 18 Aug 2026 08:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I4JtYMkd";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9576910EA36
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:06:52 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so2571828f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787040411; x=1787645211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LmOA0dUy4iPUy3GXyYFTKqQUYL4L03dnOD0Ttu1y9OE=;
 b=I4JtYMkd3MYvEkvgD2EwrKfIy4PIFMC2+wQ+kqx5JHm80jy4Q8CJgY3+lFhqvrY5wU
 l7GHIz9mK5dGJjBlL/QXLgSN2CppzPDS9B4L6WWIdb4Uaiz9rZ4qaFLjxYaDUtoUl2g3
 2ujmQoAe+T7m0DKeM9MCEnDH38PYUe7kAuX/xA8j0+CXnha4u3exfVI6SSxT6HlgPJVu
 OEVUY6EOPyGuTCbagBwp5FaXg+CRaxaD65EcQEXKnQcV9eNL3of5wwGIklvkqJSiES5L
 WnMAReB+KBcTAoiEYwq1iuwhi4QZd0E6lXgvW4jeeil7Hwv5h7kthKtOdeWTAwmt4exm
 4u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040411; x=1787645211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LmOA0dUy4iPUy3GXyYFTKqQUYL4L03dnOD0Ttu1y9OE=;
 b=FiEDr1HpwaAe89/0t+gqfW68tU0+DQdGtatXJbGTXao93NIZomfS9x7blfBvRIRdpD
 eneonmn4Ycx+72lhLHWNt+a0/qQihiWk/vQkso2I0jNZUlY6g4hOvUMJvKzbfdRM3OLA
 wlspIrnfUzmsXyYFbLu4iK4L52HJr18CEyIdMuwOA5qgUMyL6oWtbdZqLrAoODPxB0dR
 1uyT/0ivc0FDl2o/hysBXtYi9H0Kj2Pa9j5HVHZyKZSQCI2r2wuMR/6Hca8s9rZk8bsQ
 aoWWclZ5tm2zwRO791E+pqk9ZDbqP7QhQa71JJGtu0LoXSt4lY16LOfYIAgdpZQ3LyP6
 Dplg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7ZWMQTRQVfhQTa6+A5DYi5gbXrX2ohMvkzpe2HIFwLDZCOeWerSUSkffNzAhMEeK/5JkpD2qNTxc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDct9lqGsGMzpuahp/sjgF9f7km9/trLxjyIRDwHyTfxxMztgS
 xBwARcUBO6USHnsKN076HxKLX3UbMEaG4AQBOi8FMDwlBS5yemXYUMV/
X-Gm-Gg: AR+sD134CRohlVy6Y+Qh/tOSznIEvS7AxXU1ItzDFUh4apT1J0H2WZr/frFtECGLA//
 Phf34sGSMw3n7EC0yXW0bBaFjRPyOzWDZsImzdLaG+UhwX0BXsL+9O7jAkkqrijztmZOTEb9MVM
 /bJNy8UpNDtNsocUrRcfcz0vg0I0vXX0lVmYwzeC9hnD16HrdZ0u5NnhNDnA6kb7ADCIj3zKaLv
 UHP7jNZOl+lKONkV7DF0hr6uQVr9MrBxejOJBeXMCNmvBy5BmNvwwhojxl1rjNdn7mLilP9m0a6
 mGcCg7L2KqFTI0N6AUUSj1AO7/A9HYl7F7uLLrOFXycNw8k4J10E/nqLpnLHujWs0zIvaGhmTkU
 fLF1eKv3eD/evX17PgQ1MV1xgFW3fCBIkswakZv/P0F0/Em24I5hlOWwUt5zHHLgcN9xq8o77ss
 tpIiZ6JZjJuOP2hloketu++Dn05X+k8fFrUezRV9gEdeuaTDP2xGIGiybP9nWM
X-Received: by 2002:adf:e18b:0:b0:481:568e:11b5 with SMTP id
 ffacd0b85a97d-4816070fc33mr53173391f8f.5.1787040410813; 
 Tue, 18 Aug 2026 01:06:50 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm10367223f8f.9.2026.08.18.01.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:06:50 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v4 5/6] drm/ssd130x: Implement ssd130x_write_cmd() on top of
 ssd130x_write_cmds()
Date: Tue, 18 Aug 2026 11:06:25 +0300
Message-ID: <20260818080626.30430-6-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818080626.30430-1-amit.barzilai22@gmail.com>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
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

ssd130x_write_cmd() and ssd130x_write_cmds() each carried their own
regmap_write() loop over SSD13XX_COMMAND, differing only in how the caller
supplies the bytes.

Turn ssd130x_write_cmd() into a thin variadic wrapper that collects its
arguments into a small stack buffer and defers to ssd130x_write_cmds(), and
move the protocol comment onto the latter, which is where the loop now
lives.

No functional change: the bytes sent and the bus transactions used to send
them are identical for every chip on both the I2C and SPI transports.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 65 +++++++++++++++----------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index a229d7a87da0..61187a630a0d 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -258,41 +258,12 @@ static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values,
 }
 
 /*
- * Helper to write command (SSD13XX_COMMAND). The fist variadic argument
- * is the command to write and the following are the command options.
+ * Helper to write a command (SSD13XX_COMMAND) from a buffer. The first byte
+ * is the command opcode and the following ones are its parameters.
  *
- * Note that the ssd13xx protocol requires each command and option to be
- * written as a SSD13XX_COMMAND device register value. That is why a call
- * to regmap_write(..., SSD13XX_COMMAND, ...) is done for each argument.
- */
-static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
-			     /* u8 cmd, u8 option, ... */...)
-{
-	va_list ap;
-	u8 value;
-	int ret;
-
-	va_start(ap, count);
-
-	do {
-		value = va_arg(ap, int);
-		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, value);
-		if (ret)
-			goto out_end;
-	} while (--count);
-
-out_end:
-	va_end(ap);
-
-	return ret;
-}
-
-/*
- * Write a command byte sequence from a buffer.
- *
- * Like ssd130x_write_cmd() but takes a pre-built byte array instead of
- * variadic arguments, handy when the command is already in an array or
- * when the caller wants to use sizeof() for the length.
+ * Note that the ssd13xx protocol requires the opcode and each parameter to
+ * be written as a SSD13XX_COMMAND device register value. That is why a call
+ * to regmap_write(..., SSD13XX_COMMAND, ...) is done for each byte.
  */
 static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
 			      size_t len)
@@ -309,6 +280,32 @@ static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
 	return 0;
 }
 
+/*
+ * Variadic wrapper around ssd130x_write_cmds(). The first variadic argument
+ * is the command opcode and the following are its parameters.
+ *
+ * The arguments are gathered into a fixed size buffer, so at most 8 bytes
+ * can be sent per call, i.e. an opcode and seven parameters. That covers
+ * every command this driver sends through it. Commands taking more parameters,
+ * such as the grey scale tables, must use ssd130x_write_cmds() instead.
+ */
+static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
+			     /* u8 cmd, u8 param, ... */...)
+{
+	u8 buf[8];
+	va_list ap;
+
+	if (drm_WARN_ON(&ssd130x->drm, count > ARRAY_SIZE(buf)))
+		return -EINVAL;
+
+	va_start(ap, count);
+	for (int i = 0; i < count; i++)
+		buf[i] = va_arg(ap, int);
+	va_end(ap);
+
+	return ssd130x_write_cmds(ssd130x, buf, count);
+}
+
 /*
  * Run a packed command sequence.  The format is a flat byte array where each
  * entry starts with a length byte followed by that many command bytes.  A
-- 
2.55.0

