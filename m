Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB90105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED45F10EC0A;
	Fri, 13 Mar 2026 13:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A8yP/26X";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA09510EC07
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:51 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-464ba2bb3aeso1296784b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408231; x=1774013031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HuyybZs7Z0tHabOQHGkaDjwue2hifxy3VAIL8mPUeE=;
 b=A8yP/26XKFGvYc0WwI+3mpJkAjP6dlqjSPiRV6oESiRwnFCVTyWnl5fPdWKg2sER+v
 /D647+lHEaLAaq9kVfSxfgB1nRGsKlSeRNPAI4KKIBlrWh39MeaaA6kFvKNwpqCOtfxM
 ZK8JlS4JnSvGD+iO4KUVp4JqESy8NfJJC1V6hhq0WmScLrergo6Vv5o/9BeSg80EaJz6
 gJUZHbgNqzVw5j1dGYa47kasPFDLyQS7r1Ebqm+FJFxFXu8HB8SloGV/H7zBqdnWlKYJ
 dVYovk56EAEAfdnIT5fBm2U+BmEDLc+Qc1xExJncBidqgfntSL/Me/WaT5IGUFKzd8z6
 GDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408231; x=1774013031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HuyybZs7Z0tHabOQHGkaDjwue2hifxy3VAIL8mPUeE=;
 b=SJ/FLfOldF65Wy2Bs53ErSJ1EzJ4heQRfR/c4GZX0fQrK0/NSdGg0/upMJbkoznsov
 HFImuiiV/CAlpOqXs7V2m77A8J/UYn9uh6a15T8QnXOHXhiGCaKVk5Yy0+rAUm8I1mm8
 oTZnUW5NhKzYVfkbTUc7Lxq8i/AbYIWkURisi/OwUFqSclgiBbCd1DJ/oaiRGWr4lcUt
 hhrbJf7uKXGDmpQdHrVZD5Yxgj47cNATJx36GlC2zzLGl3lc9j848gRwgSjBi+bbhey3
 aFaHYW9AotWw8OZ5t+Kubr7wGdG4PlZGXW4EY4zW7NQkHQtasgq63W5Ti2hOkUQ6vZjH
 luCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+6Bifb6bSuEXcD3B7DRxl2kWmaZ8+p1Nfti45lvBoebPy6a3N/i/G+ruPyYKph8acBBSw+wYuq6E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4vngdQhawzcBdDdWDi+Tnprt0kyVN7AFfhuI+TKn+VFl5UfEf
 bG1/ofoUqHQoKheCrgxn+o/AVqWSbv8666JYSUIdH+7Vrlx5vk4F2eZ2
X-Gm-Gg: ATEYQzyMUK39ZiKe80qLHxAj2Qj7Qm7pn/ZFMajWmEIR2tMaeKkt7jSQlzvW/KmMwwm
 CTbDXNthtV03CXPJpnOBjoMG6KR1wmJmiMB+qvLJwhWayYiFvI5wibGhkMujL5qHBxmNiEL5zVM
 st0oxBNNuxiUutRjCS+eO1NnjmnAqw8TjBn/pAWKsQ3vMnt7hCXGHBTYd7UUWWrQt76kdD2SmPT
 YcMr9ulRdeUYsk9a1YOTPSVauNnZ3K45eud7HzfvB/GfSsPmgPepH29IMVjWj980bjr+ymmXa7S
 StujwbCH0GOH/55r1GYvwyx0NtPYQSpW3ws47uugv56yCzpHF9o2UQRAtUIZSTA9EPpLlIpfjVG
 Fp97mi0uatG5eHxeUEEi1yLL3oIgZUNHGtAvMaUzXgQMPPTGntgup0AzYrQnCI66C+9sQPPJlun
 6MGqdsDA60gBanFv3lE4/uHJ3GporpPyae2GvdKgv9ATOHTpIe
X-Received: by 2002:a05:6808:17a8:b0:466:f6ee:5bc6 with SMTP id
 5614622812f47-467557ec7d9mr1854894b6e.27.1773408230845; 
 Fri, 13 Mar 2026 06:23:50 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 25/65] dyndbg-test: change do_prints testpoint to accept a
 loopct
Date: Fri, 13 Mar 2026 07:19:50 -0600
Message-ID: <20260313132103.2529746-26-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

Reading the ./do_prints node also prints messages (once) to the-log.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index b2bdfdfb6ba1..fa81177e8089 100644
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
@@ -191,17 +198,20 @@ static void do_levels(void)
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

