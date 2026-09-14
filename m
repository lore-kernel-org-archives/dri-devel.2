Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB0BC88E6A
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26ED410EC26;
	Mon, 14 Sep 2026 09:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Obzgy3sg";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4397310EC26
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:29 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so859737f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789376428; x=1789981228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zaMjbnfDAPZVK+O4yC2H4PKXkZqx8bBFkgVpIjfU32g=;
 b=Obzgy3sgP2AJxQgKhi87Nz5CPcPPG3oWaMpXAVnfb58BmDITrGepRmQYk8VfAJzZPt
 zpefV51T86jKO3O0C2VKwfMLtZDzN1DVZurXHl2sXl35BoUkdn6VhhSzsx2IwO6Zn0Q2
 rhxEroi1x03NAsu6S919q2G4fGvr4mkqgwjXaDzJ/Zj1maWWrhUuteq3iC+QKgujTQXa
 4zVmYHHZYw8Tf6PJ7/8xFmsR1E7leVT3Le0aqbl57/sG/aGWQ3lcmysUdJleqsOm3ue9
 keRZ2oxLtfcDEnMYtdASgb3xPUgn6kf5Zo3if7jDmqLwjkSTXulpNYZOa7T1MaHfXpRh
 7uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376428; x=1789981228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zaMjbnfDAPZVK+O4yC2H4PKXkZqx8bBFkgVpIjfU32g=;
 b=HZlDRohB7sTu34ritnyW1EZ31paaM4AW415FDTywHLCHiWj+7Z+CUAxZSnk0yziiqi
 KSh23n8E2kX4hFedv3J9paSNDukLlPJsbxeFrfHHGP6eC7E9VHiksk5ZNzL2Uf3VovJw
 mF/Lv/gbjD4Uf8rTv+I/50WlVcmzlLvo9imr7p9F2nTfrxDkqLIxQbOGZSJ2ceHJ3GkT
 3j5K8/cCUzNlYzO+tpWaGhnfmZkLrRUMptBKsWTlBojcX7UKEjqXgUkVLOooQPJ6TsnI
 T4GYAwwwu6fH8VmWK5/pzsjtQ+tRH9lKnrTkAwpOFQ6UyQcXOKLrGKmrCPUeybZGVwGD
 A+HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWL7BL6Ij5jXgHDL9DgNplzvV6gv1ZdUg/wdBCGhu0oZ2+rGBIggOIGAnU6ou50v1jHKPENwpWz+g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++loqEozqvclsYW9rKaEF9LztcxeGmaENtmSvjAagUFuXF02RMPf
 T1K8kYSlwLDQLwVgyXCEJYKpq/lP2zFi9F48Yj9JQX9BF26P7NCqXOX/
X-Gm-Gg: AYBFou2ga7QJ1lfH6tMXPSYGz+z3d7GXTo05GaywLRpciy+1+KYfomVhZTnNPhlQLID
 v7WlQ3W4vPlfxNP84Rz5+PZwlB/d/RtJCPbLPs4zpQekU23xyjPrn0qU+HCcG/5/kAWqrNsROc8
 pcSlkbmjZXjns21wB+VSko0HereI77MCI0K6J5CsPWFGMh7pH8aUKPQa9a3VkmxBtuNSAFr+6fw
 2mvztKtOMyzDUcOkcsbAiVxKof6KE3FlNL+ZU88M2nNyFyMMh433o1pJARIS+iHwWna+72T7eHx
 ybZlsV2lNLnri2nqkLrySxKcC5Zh1xSG78TBIcb+cxUI3odJXjlYYwtRyuewaMrArNnV+6xbPsB
 X012A9UHBr+pVt2jLmpj3lFJhfVZp4woX+cltXGxxeGNZcGadkd+ZzZ3hIk4vR7fJan8dkh28qe
 SLB2XdLRNuRcnMIFBmoi3xnYvGZu+3dj1+4FeMf8iZPWaFy7CH25H3a9P/cu3uYkeuv5HGgkedi
 W/XKoB5NrCJ
X-Received: by 2002:adf:e18d:0:b0:486:f955:895e with SMTP id
 ffacd0b85a97d-48702a9a5b5mr1446542f8f.7.1789376425972; 
 Mon, 14 Sep 2026 02:00:25 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm25245851f8f.9.2026.09.14.02.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:00:25 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amit.barzilai22@gmail.com
Subject: [PATCH v6 5/6] drm/ssd130x: Implement ssd130x_write_cmd() on top of
 ssd130x_write_cmds()
Date: Mon, 14 Sep 2026 11:59:30 +0300
Message-ID: <20260914085931.66857-6-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914085931.66857-1-amit.barzilai22@gmail.com>
References: <20260914085931.66857-1-amit.barzilai22@gmail.com>
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

Assisted-by: LLM
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 65 +++++++++++++++----------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 1d834be6243b..fd13250ef56a 100644
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

