Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B4C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CCB10E3EA;
	Sun, 23 Aug 2026 11:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B6hTl3G1";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA52F10E4F3
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:20:44 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c15b1da6b82so264779666b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787484043; x=1788088843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SZlvya7+gytEhYd4eQsQn/QeDP25uctPqe5cmCgXCPc=;
 b=B6hTl3G1p5VeCW1mqef1gfdeUzAEgykm/9CxtRgZYAyiir3qf1zOe9DcAikrr3YkBt
 pOG/KM5UVr3tAOYba47UvQHd7bMi5z7oF2IKB1COzoyiZhk0fk4o4ZUNgTaurpqg+VGE
 Nlt9K9p3Sg6sVvQM4l/PGL5ftsC1klJxr+n8UI21l3r0MlsM8OG4DdnZDHViGxd14ZpC
 4WNxaoA2Lq8ZCjYs/JpTwpm8SH5FzYG0rF7cSN5yczaWWN4tuiIXpgmd/md/8xjcaX3j
 INcQeSUFVPYvH8jX6EQfN8GdEOaA76scrRsRQdtigMlhb/Y5FL+wX3pGgAm1+pZy/XeD
 KCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787484043; x=1788088843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SZlvya7+gytEhYd4eQsQn/QeDP25uctPqe5cmCgXCPc=;
 b=Uzp8otJ+M8NIoBoi0YCANVOzTMIRMxpm1JivGPAzuFbnl2+bL6Tx3v2oUK2LYLHOjn
 J3dvKz4JmPk0xqR0n2hsKfPm8q10RDyKJ/bigDEMOeXJ80prUQYoLz09MmsVnIig9m/f
 R/uYglWgSAIz0H7sJoGI2RVyf84OptDvUk1T2HF1x73s6S6zQudwzjPx1cqvH0UxrcsT
 dhgQKHO1KE5/LGVKytC1D7yqu3BCQR9d6ZYS+JzhCfN9d0rbZ6+G0RmjMDSMPXajdt60
 +44kmGpbxCfB5Ul5Fls28Q00F45Ndj8MV+3fuY2LFTcFPPZ44AzDyKS1KOLRQxBheWQX
 IuYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXeJGbEkFtUTQ4bnZdg9AWUW0RLSMDTTXTBlOW2c8mDHKkQ+BedEUN6Jzcg+MIJta4BXg2ZyUaZLA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nDzoGATdnPL5J3yRKjDBQ0vvTZ91twFW/K5iU7jxJRcY+3Xfcl
 oG/B0LZp0H7onOGWsnoG6pMETlckSLSHtOQ8QMpA6zH3+HltUhsZIOG0
X-Gm-Gg: AR+sD108JN2S8uGry8vatSxCc+xsvm+3oRnOIZJlfhlHfNqMVXaf8vOGvi8cdcOr1q7
 zq2NHuyRE2K6OmUGRnlW59zEq5CBPYzChutzTfRh7x9828svmDrVHD1rPmfo6s6IO92uX9lAR2u
 0K9naWU0hWpMM+EP6Ak7WLl+9hjDRzYKj+0V5+STZufLeEf1JhKHT7sHyf9NdzJOSUcfAPQwEJk
 lLIbfuE25LuDY3N95CdJ27snWTjp2VSIj3lIurqIqKrVAZ9ZXIf/uDZxBj65z8pD4FhjAeOIKqo
 CruszKML/k6zBdgNsQaY6CKfRZTacO+EKJbTaWWg0h23fLBKghiPuDtDUWW4DI73S8+QYUedbiG
 nJP1YYRqIZi4360/YIJgLsuj6Xp3y17lg2I5HGe1sVrpiRprC3Xhxe760AL2pvok+YcYKFFsrHh
 BH7kifH9KAezHE5DrSbwDfcytHXkMJ9O0EHpsByivgmcW4F9oG4ZDDhkM6IUZ9YudFOg==
X-Received: by 2002:a17:907:72c1:b0:c24:bf0b:6b62 with SMTP id
 a640c23a62f3a-c24bf0b6d6fmr40013866b.4.1787484042903; 
 Sun, 23 Aug 2026 04:20:42 -0700 (PDT)
Received: from thinker ([2a13:54c2:f000:e268:6d0c:d746:2b12:231f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm707233866b.38.2026.08.23.04.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 04:20:42 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v5 5/6] drm/ssd130x: Implement ssd130x_write_cmd() on top of
 ssd130x_write_cmds()
Date: Sun, 23 Aug 2026 14:19:58 +0300
Message-ID: <20260823111959.17029-6-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823111959.17029-1-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
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
index 73e7f2a8b730..cdef0c09b050 100644
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
+	if (drm_WARN_ON(&ssd130x->drm, count > sizeof(buf)))
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

