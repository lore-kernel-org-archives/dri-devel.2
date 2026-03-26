Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B3710AB804
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095A910EBBB;
	Thu, 26 Mar 2026 18:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YjJVDNpF";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2439410EBB9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:13 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d4be94eeacso1183553a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551312; x=1775156112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COes0JAbo1d/mRlXxq1tSmCpD+ZApr8iQ8/8rv37VLw=;
 b=YjJVDNpFxC65rE4MOW8HuXzzV0RSZPKn+UF8SGHOPgX2JUbPFg6vOOy6LVv1L2RaCW
 fEefvUaVT6yuZPOrEL159P5m5NC3v358tZxKLNKJ0umporzwxWeTE8o49u4pR4iqFIcb
 D/MC+lhnnTCZal1Kk8a1AYkik3LzjACA3zwA4FGE8N2A2KCFhE3V2QF6wck9Zw/kUU7i
 1AhFxj51sd1NORbLiCw0DDNTmeDGY/liygdU6M8VLqmipIgOV055du/72VXWN7U19qkX
 w93fz6XVVQU6/PF3Tv+ZVd8Cf0FeImlbnAliKRbSJj63TuORbUTf2eqdLBLkUyAGcrK4
 0vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551312; x=1775156112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=COes0JAbo1d/mRlXxq1tSmCpD+ZApr8iQ8/8rv37VLw=;
 b=WdEQTv8U4b4CMmVz0fSXmDQIynXZminW+gj6JeP8Wo68Vwo692OkWm7bulIFLged0x
 vemFp9fw/XNy8bO15G2q65dcHO7Wkp9cMmY359ioABkVpUbVd1xEPaNyLF4atsfi1611
 A/GFd4fpmD/Or4M5ZHsIc5ShY55BwLxYQxyzQDY+04EWWEhFiG2kESfAC1MLTmDdZWtO
 y2idYUm4O1Dak5aMy9kbM5D+s6pe/PE8+So8AuL5yOUSwIw7oiNk7z9xmtkl0kEcOouW
 pqz7ONkHDUS55538UL1lSD6Qb3iMUQ68KpgGbrrm2t/OWfFtt0yWKY5dmhSebKEFfEL+
 abcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0KO6bxmVBZUXr11Obi3DCneUI9X0zVTOILXVdtkDO+IVuKwIy+yTzBmTK4ntxHSbT0I++nMGyADE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyYNeuGoulmSltTSWMcn0wvOKUk0uMIlHzekLUj7Pc1woMeKmb
 +Bl/2xkf5Ym1IvtNVTB2kjapuxHUinOKuO/EsQnWblgR9V93zLwgLRp/
X-Gm-Gg: ATEYQzyK1kxU3VXNyTyFin3WC5kGR05eGRQ6EM8cml/IvD7mrrO32kA8J3I4l/A+RZ+
 2jb7Xlqt9DbjKrFl9mwU5tldwgiLTPHjoRo5CuZY9JddVmWNAAuN4xf1hbRtc3LOi00sCSc4etS
 zXWkcDO3IsfaW6C+koAsXdda14R06UgdXCiZ8iMftqWS9UwICGr0GrrMULDaliqLSDJnCipmLqf
 ifN1zHrM8499jBAdUyv+/Gyrn6qEvlWZ8LDaSXDsE51Vbt7T1If/FxD1qqaBZO4LUlnQey0hdbF
 I/fdj7xCLgPKk6Sbii8lu879WgwJCB5elWvaQYc0E+zp3FXwbZkrs6bIDdYd/yEs5CixJIjLP03
 HZMIEonot4cEv72WH08zhxz0rp6tmQgQp6YD9Uv2wIlzbirq3OnfEsUY0VYQESqDkCt88xN2dKl
 egFh2HhCtTToBGy13/cplbuNhPtSGsDRDgosPPPDuXzvLmxAcB
X-Received: by 2002:a05:6830:4392:b0:7d7:e792:b98e with SMTP id
 46e09a7af769-7d9d6617e9bmr4694632a34.8.1774551312358; 
 Thu, 26 Mar 2026 11:55:12 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:12 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 28/69] dyndbg-test: change do_prints testpoint to accept a
 loopct
Date: Thu, 26 Mar 2026 12:53:32 -0600
Message-ID: <20260326185413.1205870-29-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

echo 1000 > /sys/module/test_dynamic_debug/parameters/do_prints

This allows its use as a scriptable load generator, to generate
dynamic-prefix-emits for flag combinations vs undecorated messages.
This will make it easy to assess the cost of the prefixing.

Reading the ./do_prints node also prints messages (once).

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 5036fd58d7c6..756bbb7506ea 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -29,18 +29,25 @@
 
 #include <linux/module.h>
 
-/* re-gen output by reading or writing sysfs node: do_prints */
-
-static void do_prints(void); /* device under test */
+/* re-trigger debug output by reading or writing sysfs node: do_prints */
+static void do_prints(unsigned int); /* device under test */
 static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
 {
-	do_prints();
+	int rc;
+	unsigned int ct;
+
+	rc = kstrtouint(instr, 0, &ct);
+	if (rc) {
+		pr_err("expecting numeric input, using 1 instead\n");
+		ct = 1;
+	}
+	do_prints(ct);
 	return 0;
 }
 static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
 {
-	do_prints();
-	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+	do_prints(1);
+	return scnprintf(buffer, PAGE_SIZE, "did 1 do_prints\n");
 }
 static const struct kernel_param_ops param_ops_do_prints = {
 	.set = param_set_do_prints,
@@ -194,17 +201,20 @@ static void do_levels(void)
 	prdbg(V7);
 }
 
-static void do_prints(void)
+static void do_prints(unsigned int ct)
 {
-	pr_debug("do_prints:\n");
-	do_cats();
-	do_levels();
+	/* maybe clamp this */
+	pr_debug("do-prints %d times:\n", ct);
+	for (; ct; ct--) {
+		do_cats();
+		do_levels();
+	}
 }
 
 static int __init test_dynamic_debug_init(void)
 {
 	pr_debug("init start\n");
-	do_prints();
+	do_prints(1);
 	pr_debug("init done\n");
 	return 0;
 }
-- 
2.53.0

