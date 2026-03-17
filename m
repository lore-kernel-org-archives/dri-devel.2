Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBFBFCD0DB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933D510E753;
	Wed, 18 Mar 2026 08:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B1pGTCDK";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E6510E045
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:00:28 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c7412b07f22so89668a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773774028; x=1774378828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2RhT/UW1C987y6pJfFZ8RN5SYowSBt72Kbbj9XR2UU=;
 b=B1pGTCDKomwHTuyf3+Wg7w3iKPNLvGrLGgPp4cp8nhZgHkD4ekYXmy0VRCcncA2hof
 gLaBKm8Tzz2u7X7NRwCbIDfJv1I76wVGgdXA5JrU8CvG4d1/863xRGoWS0CeNV/KCzm/
 k+RJYQLis+EOdH5QAZrew6k2nBK792+zYRBpSzOcI77WcjFebr1bLmxG26XqUsZZHUX2
 C4ZglIvBrNIi3E500JSHZmq3ewhy/PK8DmNrXm5pRar8Y8ikazG7i+MhCA43KJYYU92/
 tSlJqBaHJLkEnplKTtmI3stbxMndxftOjspN1oniyYl3bEfABjqzgtuwtpYoCX3GMFtr
 98Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774028; x=1774378828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2RhT/UW1C987y6pJfFZ8RN5SYowSBt72Kbbj9XR2UU=;
 b=E0bNOry/TDrg6TLWdudUKdkPIwgb/5J1JOzf2YzJiL9sbi3RrPhWVFOorLX7IDcRIh
 MMe3qP4IvuwPhSRZ3uUv+UjYvHFcWkLKt0LlfJzpChKZNR7+LTe4S6RqZGFStLDAv8tO
 Mbk13w8RL1gdvfiMeoOz2VKaHhrmsJakan/1fTAqvy6GyMC9dsQcIP1NnyBb8jukMsJT
 16KN91m8nWLZBCvRDvgP+Qipjfw1jLuGMijednS7wqjxAwL9Ff6OflN+Q53mXG7s7p9O
 Yc3Yb9/BRr/gOFNQIYXgTjMvDLSCiPmjJIyRXkGLve/3rl0nSW8UWJhOR4oU/oliMUvm
 RaFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2iYjHnScRBaCHXLHfUXSSL+TIIfpr8pOf/aWmj6za5L8tTahAXumgNITAyAF+v66HnFymWH/m3SE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMW+CL6RL88fnwe9lGQTdfBuoqmVsBYgJUZOfZ0r0WBhsCexje
 uZZoXnhBAKsDlpNVDktgJk5dq2tdf+8XTtjXb5xneOjmCmR8MCKAyDDs
X-Gm-Gg: ATEYQzw1COjAGjeIvW2bECJrnxzdOv2+YryTb1uAJq+nop0zgISGyyEQ4be9M5CZ4fc
 7JFJcaegAwdsuV9QbqKLBeqe2QK7wXMWHrYMcPHPBCU5ZzOCEOB2OHxD7/ojkOCAVksZOEEkdR1
 +yffg06dk28dsLAJgXLypXc7+5p8KGI08oogzoMY9WK0Kd+LqQDzhLUx2a7L2ziDHLUG/nh6kV7
 yfngMtvAU4/i2gjbVtJC7+4CVmEOg3qxZfzTcdL+P0mYqfkfrqOGhnQhl5Z5YxJzkJBnwkR4IMQ
 ieU5x8QXno39GKopt/mDAxL7ufj9XsdLnkwRZkUwY1wou+Nz5djFPHekI6voY8PCBavx41XLtF4
 XR3Z2sibBweQNV1R59h0+ZlRzWaAuyea050geVg6l7vtHs0S2EIkH5zG5Ufn+Tb0Is53yWpzTp/
 PLuJTQfnpjy0MH3FC12lAhz5m1U1oGHB0kVVWtmFXkhibVKEPqiW11s5wxATZjBA6mQfnpYuf52
 KpvGSf+j7aPwYEAj6zmsGxioLg7BPRnZFpCCKPyvcMHz0cj/IHFQsJSnakE7pDs5lXFhw==
X-Received: by 2002:a17:90b:35cb:b0:35b:92ba:66e4 with SMTP id
 98e67ed59e1d1-35bb99b2ce2mr555490a91.7.1773774027874; 
 Tue, 17 Mar 2026 12:00:27 -0700 (PDT)
Received: from 2045D.localdomain (76.sub-72-110-123.myvzw.com. [72.110.123.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5a2c60sm196240a91.9.2026.03.17.12.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:00:27 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: gregkh@linuxfoundation.org,
	dakr@kernel.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 akaieurus@gmail.com, me@ziyao.cc, Gui-Dong Han <hanguidong02@gmail.com>,
 yangshiguang <yangshiguang@xiaomi.com>
Subject: [PATCH 1/4] debugfs: check for NULL pointer in debugfs_create_str()
Date: Wed, 18 Mar 2026 02:59:10 +0800
Message-ID: <20260317185920.43387-2-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317185920.43387-1-hanguidong02@gmail.com>
References: <20260317185920.43387-1-hanguidong02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

Passing a NULL pointer to debugfs_create_str() leads to a NULL pointer
dereference when the debugfs file is read. Following upstream
discussions, forbid the creation of debugfs string files with NULL
pointers. Add a WARN_ON() to expose offending callers and return early.

Fixes: 9af0440ec86e ("debugfs: Implement debugfs_create_str()")
Reported-by: yangshiguang <yangshiguang@xiaomi.com>
Closes: https://lore.kernel.org/lkml/2025122221-gag-malt-75ba@gregkh/
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 fs/debugfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 3376ab6a519d..a941d73251b0 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1127,7 +1127,7 @@ static const struct file_operations fops_str_wo = {
  *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
- *         from.
+ *         from. This pointer and the string it points to must not be %NULL.
  *
  * This function creates a file in debugfs with the given name that
  * contains the value of the variable @value.  If the @mode variable is so
@@ -1136,6 +1136,9 @@ static const struct file_operations fops_str_wo = {
 void debugfs_create_str(const char *name, umode_t mode,
 			struct dentry *parent, char **value)
 {
+	if (WARN_ON(!value || !*value))
+		return;
+
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
 				   &fops_str_ro, &fops_str_wo);
 }
-- 
2.43.0

