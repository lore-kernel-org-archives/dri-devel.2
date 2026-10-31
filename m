Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9A606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHWtuxcu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EA810E9DF;
	Sun,  1 Nov 2026 11:58:12 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8451610E02A
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 06:47:27 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c411e139259so121296366b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793429246; x=1794034046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9U3dWfP9wuIKNIASQMC6j7LlTeXrOraHdMR5EURM28M=;
 b=JHWtuxcuy1lnWQI7MkmYs0st1voIjA58oriSV4/iVxkOOHNOYdjDNxUDbsaekH0zYd
 udOqkARhK59JCNeX7+LGZCzyQtWOH8ak/fPgytKcz6lE9EcWrO2O+h1P3u0TWRbAm7L5
 j79mEg10vPJ3ipmHpzssT20n0Sum7r/yrS1VZ6MCPibynWBaMMiPPhkjOn8HRMTXcvGb
 RSM8oYCsVor6nG1e260XhnKgGTAsoMooiSirmiUD9gpflr/uRiNROj2XRSMSAxzxcmg+
 6jm6nIzCGdrFR4CbWNC/p3Jdn5Kavph/uaU+kE6jHVrVoHA6iizfX1g5rS1XzJMllXnx
 JRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793429246; x=1794034046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9U3dWfP9wuIKNIASQMC6j7LlTeXrOraHdMR5EURM28M=;
 b=B+h807ZwR5UFP2HpKihABltNXMfqLCZUd9yQw6MatR5vRW38Kc2KAYVEIRHAJPjD4T
 6btEYOcDZztWyKjvctLXvU24MM0vRFoEVLk6xtbe34RBgOKlmcE9T58TaN4KbqsDxhxc
 OqUVOEYtLWhEwc0wL5+jxJU0squSnnYaBzk7XbQfzIotX4VqZwcjox+6puTc1cpzlDSm
 lH6ggPNt1ijLN9Y3r2QWVgeXJPGvWdWsV/sMTZ0Vhs8b/OkypuR7lu9ieegbybcX4waB
 ZSHmw8EEad2pthTYH9++pYAm6AoHT0a+rhKf7scyEu8l6nDGDKsKFEq69r5NKZk/SAKF
 +Tyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzG6SQITjv0kCrf6hOvm48wxBCKGhNSwxUXWg/U8VzqxMGJ3LsODcHkgIe+3oK03fTq2C0DSuT/dyc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIWMW4JuZnmx8B0oOVHj//bQYo8rHZKSuv+5kcMVL89n1t8Zus0
 0VbeUwvTXEzinBwAplcIudMXA7YJcly5cgh7ZRo1KOeWwJ7BfimpOGB0
X-Gm-Gg: AYBFou35/IyeEMHvViv2u4F/ivnKVBOo/jOUMKv2V7S8aP+1/cqJ4BzBlu6mKOmiEh0
 5EfguHQi0wAQb3lLGXodnMVv6KaDV9nnpO0e2t70bZBp55VHIlnZEcmQqGzRKPWL7xjXBdfFBM/
 M35Z3mycdKi4M7+JhhSltfQxQNyj2c6FbN87PFb4LQN0yVqxDkYOpbwq8CSOP34zwHwuxnWTmYJ
 WRa8s6v9ohDvvazQzHIIqlXwg8x8P5vFZOx/ns4zvor+PH6Nynw+HM68dekEfBS2z+ZTTGFrfro
 DQUsDK9p3rNQmIuMuzj3t78rNfbixbS8qdgUGqWZCtjO8Wr3LoUEpaKIX+jGkPxaFVN3o5RFJ6b
 4UXsUwv34GubWgflVl0HKPFoB6o7zBvthXg1uzV/Rpc891xkGJ+VrfE+GtSL0opvZ5T5cQ9Zsrq
 9Vz+dQ6FOwLu1CsQ1Yt/84NeTXpuCc4SysUVtlxh6VlWMR8myZJS13Nn1WkGgLWAUHsZ7YzeGhM
 wpOFVcVyoLJazwURVNQ+uHgQ7ODGQb29bvtXnFNNP5X1gZOLsG9MBWo8laCLJo+atb2EsghNuGt
 pmN49EWOjOrIid8kJw7xW84OE6E13oQHZPkDebApbibRuOq5tl4YlIbUNtuBsdX7cMjf0116IE1
 AZ0nL3VPgM3ucfoftitOEZu4D6SS47sFwnBwWeri9frRZ+vnvGxOgJp9oGoKBWl5gOao=
X-Received: by 2002:a17:907:9346:b0:c49:b9b6:4b5e with SMTP id
 a640c23a62f3a-c4ca7b1f727mr373328966b.20.1793429245709; 
 Fri, 30 Oct 2026 23:47:25 -0700 (PDT)
Received: from maria-VMware-Virtual-Platform ([182.186.37.126])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabf43b19sm145030266b.87.2026.10.30.23.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 23:47:24 -0700 (PDT)
From: Maria Sheikh <mariasheikh812@gmail.com>
To: outreachy@lists.linux.dev, andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Maria Sheikh <mariasheikh812@gmail.com>
Subject: [PATCH] staging: fbtft: fb_tinylcd: align argument with open
 parenthesis
Date: Sat, 31 Oct 2026 11:46:59 +0500
Message-ID: <20261031064705.9513-1-mariasheikh812@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Align the continuation line of the write_reg() call with the open
parenthesis to fix the checkpatch.pl check "Alignment should match open
parenthesis".

Signed-off-by: Maria Sheikh <mariasheikh812@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c740c5..d58b1247262b 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);
-- 
2.53.0

