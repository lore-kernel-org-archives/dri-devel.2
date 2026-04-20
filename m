Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F4CF588C2
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13AF10E581;
	Mon, 20 Apr 2026 12:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="byVdaHN0";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FB010E581
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776688154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsLazpgDoZcx+ASK1eTTBe2uAy362phg74sYeHXc9dM=;
 b=byVdaHN0H59z51HfN9Den4sAjkLBJ/nejQHU9lr1ChTQFSGej5T4HWJTnGuVQw9yYQrBAl
 uAIi9TxwyXAGmI4WEEZWkMBnTMcXxCm75UZxsVvGvsIigK46V2kHfiw9lJYzfJAmvKxT6g
 wLFSIl1Ka1sEmI/NxQXeh0bM+rs4lR4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-uOLzcwM6PmSvNgLFUozmdw-1; Mon,
 20 Apr 2026 08:29:10 -0400
X-MC-Unique: uOLzcwM6PmSvNgLFUozmdw-1
X-Mimecast-MFC-AGG-ID: uOLzcwM6PmSvNgLFUozmdw_1776688147
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FFB61955DDB; Mon, 20 Apr 2026 12:29:06 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5F5A1956095; Mon, 20 Apr 2026 12:29:00 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 20 Apr 2026 14:28:05 +0200
Subject: [PATCH v7 3/5] kunit: Add backtrace suppression self-tests
MIME-Version: 1.0
Message-Id: <20260420-kunit_add_support-v7-3-e8bc6e0f70de@redhat.com>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
In-Reply-To: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, peterz@infradead.org, 
 Guenter Roeck <linux@roeck-us.net>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Kees Cook <kees@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776688120; l=4375;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=vuDHildPEPNlCHogR5KyfnFhxEoODOxMc2R3mM4Q7g4=;
 b=ELW2SvmwsG5uXtj+qpzqCxqtNwG1LIsm1McB6sCN5QK+FOTG5/pEpAapAxC1WOUnBhwSOfayA
 78HEDz1TIaDBD8o0X3gylq2LDZbflDbkE2QUYCuGRtZtRisEva92Z/E
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: rjXJpym7p0GxiGpKlCrplVHeaOd6njSLWwytE0rwqOk_1776688147
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

From: Guenter Roeck <linux@roeck-us.net>

Add unit tests to verify that warning backtrace suppression works,
covering WARN() and WARN_ON() with direct calls, indirect calls
through helper functions, and multiple warnings in a single window.

If backtrace suppression does _not_ work, the unit tests will likely
trigger unsuppressed backtraces, which should actually help to get
the affected architectures / platforms fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 lib/kunit/Makefile                     |  3 ++
 lib/kunit/backtrace-suppression-test.c | 90 ++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index fe177ff3ebdef..b2f2b8ada7b71 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -23,6 +23,9 @@ obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o \
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
+ifeq ($(CONFIG_KUNIT_SUPPRESS_BACKTRACE),y)
+obj-$(CONFIG_KUNIT_TEST) +=		backtrace-suppression-test.o
+endif
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
new file mode 100644
index 0000000000000..2ba5dcb5fef35
--- /dev/null
+++ b/lib/kunit/backtrace-suppression-test.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for suppressing warning tracebacks.
+ *
+ * Copyright (C) 2024, Guenter Roeck
+ * Author: Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/test.h>
+#include <linux/bug.h>
+
+static void backtrace_suppression_test_warn_direct(struct kunit *test)
+{
+	KUNIT_START_SUPPRESSED_WARNING(test);
+	WARN(1, "This backtrace should be suppressed");
+	KUNIT_END_SUPPRESSED_WARNING(test);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
+}
+
+static void trigger_backtrace_warn(void)
+{
+	WARN(1, "This backtrace should be suppressed");
+}
+
+static void backtrace_suppression_test_warn_indirect(struct kunit *test)
+{
+	KUNIT_START_SUPPRESSED_WARNING(test);
+	trigger_backtrace_warn();
+	KUNIT_END_SUPPRESSED_WARNING(test);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
+}
+
+static void backtrace_suppression_test_warn_multi(struct kunit *test)
+{
+	KUNIT_START_SUPPRESSED_WARNING(test);
+	WARN(1, "This backtrace should be suppressed");
+	trigger_backtrace_warn();
+	KUNIT_END_SUPPRESSED_WARNING(test);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 2);
+}
+
+static void backtrace_suppression_test_warn_on_direct(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KALLSYMS))
+		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CONFIG_KALLSYMS");
+
+	KUNIT_START_SUPPRESSED_WARNING(test);
+	WARN_ON(1);
+	KUNIT_END_SUPPRESSED_WARNING(test);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
+}
+
+static void trigger_backtrace_warn_on(void)
+{
+	WARN_ON(1);
+}
+
+static void backtrace_suppression_test_warn_on_indirect(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
+		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
+
+	KUNIT_START_SUPPRESSED_WARNING(test);
+	trigger_backtrace_warn_on();
+	KUNIT_END_SUPPRESSED_WARNING(test);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
+}
+
+static struct kunit_case backtrace_suppression_test_cases[] = {
+	KUNIT_CASE(backtrace_suppression_test_warn_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_indirect),
+	KUNIT_CASE(backtrace_suppression_test_warn_multi),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
+	{}
+};
+
+static struct kunit_suite backtrace_suppression_test_suite = {
+	.name = "backtrace-suppression-test",
+	.test_cases = backtrace_suppression_test_cases,
+};
+kunit_test_suites(&backtrace_suppression_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression");

-- 
2.52.0

