Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E978CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B358C10F954;
	Wed,  3 Jun 2026 07:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o1dKl8mN";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274B510F957
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 07:34:26 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-bec4639953dso614525566b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780472065; x=1781076865; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tPiXO1dCCP98YnBjWC02+T/M/Rv7LEFPOyMbOWtK8IE=;
 b=o1dKl8mNeb47uvXRm6aMC9GJXwLo8FeSDv2ns9mm7eI1FGzUoYtbxH7gMo+sB1J08T
 c9rI5NcFz7EuMESCK+DGRB5XM8ZPIyaDaPiQRSbaThh5i0ohgF72gokNIfGFxFYFq3Hf
 qt/Mr1TVidQ1vw//okGHffbJBSyo+hhMSbUPYrsSxhYvzw0JKk2qwvnKu8SmdGqGTfOd
 QLafeo8k2iGgPB4Q0RrSLNY9/Cb2vX0FHmo1Z/KZIYK0kb8uPoftVPt+R2FAbo0IoMTo
 Y3WQeKeKqCt2vl2olH7gMR15FxDaoYaVbtXplbh9x5zPm7/0sU6T+DBi7e4lvpaX6NhM
 /VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780472065; x=1781076865;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tPiXO1dCCP98YnBjWC02+T/M/Rv7LEFPOyMbOWtK8IE=;
 b=QvUYpCWAF0UOmEOxEuvb98yAWkJOtnKAyko6e4b9yVl2I8qzHQkU8btjRaait3W7/I
 lqyel7fEqSEbh4WNsb2d6Eu8V1k1FjwqHmTgsJSr5920GaagMLoI1Ig0QSlxoyfK4JBR
 NnCTrOqxt4raZYlmAg+CEhz+1ehlAhhX7DjGXhJCevvkKRqROgmn4L/LQywNSOfT9BN9
 igHIEI8+OyF+LocCLfc+90+UygvFuXz+rOsZpIxIouHTasEPWZWL0cBM+4dw9XOxIC3k
 UllAnDbwax7DsPwIFLNZZ4T9dlJXYTyYM6lpl7yIVjRIl3cNNNeNWvJzVl0rubwXBbqL
 6oiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JjRFEgrkE9/qd2XoFvsURjfXMxpWXqliteX7JxMDBlt9h2rNlpF0T3nUR085JCn+rvCglbsmcKFE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWIS3sX5seUcFp6AZFR1bMyo/Tj/v4qpNTkn26fwesk5ERYu/o
 EglfPOPRxZzpsc0rpslWnpyYBTRzJD0bQCznRlgzAsLLWIaw5kRfgGC2
X-Gm-Gg: Acq92OHXcGDmcisqbqGajQt7EMaQwQLdjMvsoJxMo/zPpm+E33hUqt9F8zxAXpgcyl9
 t6Ujr00U4xCpcJ5Edwp2MGX5Ha+F/6CcZJo4Kx/svLX0ttobLXVC3GPk4giJ0wrYWjmYmbnq7uW
 SxQ1wgzOpV3xer2xUS9PrE4qtNqE6P4Inj6yq3w6BigPCM9KI9AB+I5nKoNasPfKzko3bMe8iaC
 DP2AfPHaoEdtPx6t/dq9Q+b6VFqCXr8DcchW+ImvFhP+DmQgtNY1z5oPMkSE9AdfElV/IjN2tEP
 Y80hXyNxe9gMFhqnVV3tB/schFgIGWzaa/Ido8aTAdc1oN5Pb5Q/P0Y3jFgPVPD8+Y9euQM5pHi
 1/u8voR9u1PdY/P0yz2BKis0H9R7LupKBbBNo9gCAea0+Yc6iJe5WZao8HJcIttJgLSciRj0B4r
 xs9IzVO8dbkEgFimq7v6QQFigVjO/QVw==
X-Received: by 2002:a17:906:f58d:b0:bec:64d4:3869 with SMTP id
 a640c23a62f3a-bf0b0fdda85mr96495066b.4.1780472064614; 
 Wed, 03 Jun 2026 00:34:24 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517721e5sm102019166b.9.2026.06.03.00.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 00:34:24 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:34:21 +0300
From: Dan Carpenter <error27@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Chintan Patel <chintanlike@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: fbtft: Use sysfs_emit_at() to print to sysfs file
Message-ID: <ah_Y_Y2RtqeGxchF@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

This scnprintf() uses the wrong limit.  It should be "PAGE_SIZE - len"
instead of just PAGE_SIZE.  We're not going to hit the limit in real
life since we are printing at most FBTFT_GAMMA_MAX_VALUES_TOTAL (128)
u32 values, however, it's still worth fixing.

Use sysfs_emit_at() to fix this since this is a sysfs file.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/staging/fbtft/fbtft-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index d05599d80011..343545e83a37 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -98,7 +98,7 @@ sprintf_gamma(struct fbtft_par *par, u32 *curves, char *buf)
 	mutex_lock(&par->gamma.lock);
 	for (i = 0; i < par->gamma.num_curves; i++) {
 		for (j = 0; j < par->gamma.num_values; j++)
-			len += scnprintf(&buf[len], PAGE_SIZE,
+			len += sysfs_emit_at(buf, len,
 			     "%04x ", curves[i * par->gamma.num_values + j]);
 		buf[len - 1] = '\n';
 	}
-- 
2.53.0

