Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66446CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1D510E0B9;
	Mon, 18 May 2026 16:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gChJsCzR";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7537B10E0B9
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:08:18 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso27713155e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779120497; x=1779725297;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=klhCbReF4bvwraqj5tgeEa8fE21QJBvT1nSsOgsaMQ0=;
 b=gChJsCzRXMaTU1MyQ8yHb6yCSKbWWd7Jir+voDn6YNOEfK/Tka66XU8csG0Be3qQDc
 qc140cBgACbVpMNNmpQ4NXYmM92FHGvdVXnoTHwZRVoCZIZQ8EZn+OniEcW9vJR84Cah
 ChkdsA0C1HNAYnCc6jWtGqt1dlRJNPMUEi7Or+Ax1OzRpVMM2BnCTaJq5apxh/n4Kuzk
 4zuQ+s9hyNvH+wK8Oc3ZuITnFjKb3crGcYZnzCWyDp4VBv0f5RtMJcHBfAlOsNAD0ylL
 rjxm91xI03M74+Qot6vo2ApuFq3cKFRvYfRCUnbprUz3jA+eOeLb9yF7TTxrOa04SQ+r
 BcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120497; x=1779725297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klhCbReF4bvwraqj5tgeEa8fE21QJBvT1nSsOgsaMQ0=;
 b=Tdkm9oVx74vClzmujjqwPtDJ5gDMuZP7leY2tQ0NsURhFGYTywFtS3E3Dw89gs4C98
 gPavQw4xEHUGyxbsF8mHG4Vm0r5xm5mbwaUBDQHk9FKthe/3e7uZSj/9F7XpekRsri5J
 KS7DUV1p1+bGCDSl33fHe3TinhzwicZNnzviKX8tiFBLTtHTIm/oWHiiqXcRW7JylNX4
 cRqhGT3fuV6GJqqOEhveiMlMQQ4+1h1hZcSI14c7LYCNgoUHEnB6k24EwNwzFVkvOhD1
 ++DMVfBxuDx+Urf/9FPMyFdp3QrpT1/bFAPrYIT8aL68qf4HRz74ntePy4pYGWPRcqlT
 EOoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Tk9zd19LamLMwcAZ8An1oFXflrwQV4KkPoAOyJXYHTELRj7g7Wpax/jAUu3FqZMYWB1yhTgBZLwk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEOjyBhrG2YLeSPgUuaR8YirdpOMl//v7jKcSHDnWLv5Wza3dv
 2Xejx0aMXIADXJdXCwf6EfYJDTb76gUg+RJu8x6WBQgCFTd7ilOmlFHn6Q0Ef8xYzjk=
X-Gm-Gg: Acq92OHnHnko/zlXojVu1P+kTA3DYVRij8G38kTWAr9pgVTTvlBFGMM6ulTbTwIvA34
 S3f1Ux7zZkYlgidiP+/21X0XPRjKuwqSR8FBWfmqvmK3PE4WneYeAmArr89kePwA555XG8RmRm2
 voaF8P3+Z2J7xcoi4Ey+JYRpiexrjARn40i6Paozv83tScJA+v79QhlfCrnIdx0KQBbZXa9bE9K
 t6o7LF9pKV9TnUdPGCPr0iTN0y61kJSReOA/EVa1Ak1loeMaGMZiBhLCowydX0+zE2k5ykY6cQv
 vLVUvSuab2ovRWKli1cf2lHGVCXaUFDKqzF4i21mARCwnvjVcWCcoQvefJPsyL6KrbQhMj4aMCL
 UHwN6ZTq+KOz8h37ZpiQDb0ZwIXu30NxI7cy/zO6Z1vMipbaUkOMTR+GFER9yMR+K86jJnjVobG
 CwdNGY0WB8t78/JJW5Omp3USFkaDsiBx5wWa0RGEWPITmETXRCJqb0ElC/9wpwOAY7f+tc0q359
 +nbu6pEVyxp3g==
X-Received: by 2002:a05:600c:5010:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-48fe5388407mr229341615e9.12.1779120496908; 
 Mon, 18 May 2026 09:08:16 -0700 (PDT)
Received: from localhost
 (p200300f65f47db041bee4d0e08e9609b.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:1bee:4d0e:8e9:609b])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48fe4c8344asm451511985e9.1.2026.05.18.09.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:08:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Kees Cook <kees@kernel.org>, Abdun Nihaal <nihaal@cse.iitm.ac.in>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1] fbdev: Use named initializers for struct i2c_device_id
Date: Mon, 18 May 2026 18:08:08 +0200
Message-ID: <20260518160808.802423-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=OGkgFGp6LugTlj9h3s9yMhDwtp+l0mAgRR7UVtWHGOk=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqCzloUdKnlf1Nt0f9T2X5K0WZQuKiEsuchNCdO
 p0WhYruJqqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCags5aAAKCRCPgPtYfRL+
 ToDpCAChu7Mt0FJO95cXoBAYIIM3KUwcbBPBDeu8Kca9LfxWt9XVv2BUjY5QtNspxJu6Ez2N2TP
 Z2cURRnOBwE8O3KjdbwNJjr+lVk8AH38Y3mCbdWfWkEcTCJj5cODfIkEqc8A2QGpQFkdP08iTyT
 BUNRyt/cYfrrdb9ec9MAvxZLNKlsOgAAsOct7FQJ6nG0z5x16P6LHSviAmX/UPEWI2T1a+tlsxh
 fAbHKNLPAChBddKlLJSwj/vOL+NlI0MiJMMxz8o7wpQosPDwHqE66VWm1xc+iGYN/K1FBqKuqX+
 ag/qOmumGPWQovBtXg6ImIw+bF/pAqpZrUzGm3DQ84SwdX+0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

While touching all these arrays, unify usage of whitespace in the list
terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as no driver makes use of
.driver_data, so apart from the better readability this is only about
consistency with other subsystems.

Best regards
Uwe

 drivers/video/fbdev/matrox/matroxfb_maven.c | 2 +-
 drivers/video/fbdev/ssd1307fb.c             | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_maven.c b/drivers/video/fbdev/matrox/matroxfb_maven.c
index 2ea65da6075c..fe057a0b57ec 100644
--- a/drivers/video/fbdev/matrox/matroxfb_maven.c
+++ b/drivers/video/fbdev/matrox/matroxfb_maven.c
@@ -1282,7 +1282,7 @@ static void maven_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id maven_id[] = {
-	{ "maven" },
+	{ .name = "maven" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, maven_id);
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 83dd31fa1fab..644b8d97b381 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -784,10 +784,10 @@ static void ssd1307fb_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ssd1307fb_i2c_id[] = {
-	{ "ssd1305fb" },
-	{ "ssd1306fb" },
-	{ "ssd1307fb" },
-	{ "ssd1309fb" },
+	{ .name = "ssd1305fb" },
+	{ .name = "ssd1306fb" },
+	{ .name = "ssd1307fb" },
+	{ .name = "ssd1309fb" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

