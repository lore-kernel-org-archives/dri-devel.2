Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125DFF588C1
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D7210E583;
	Mon, 20 Apr 2026 12:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="atBuAchv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E87610E583
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776688149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BinESyPjYkBGzkTzM8DQoId3ZnfKuLEeV1CNBHsJlrs=;
 b=atBuAchvscpWrdXw/o25Qm7C2pdmbOAzRR2EiTKvPMiba5EqFhLQJKPPV6ffe0Ds//Ymq1
 /EgLl1r9fQ4MomtZ5LU6sbfPDNfZU/M2orDWutUilEHyqFlNKdcJqGwrAaK7XaDC/lO3QT
 n4YU54c3m9VwQla8teO7cuhJCygw9/Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-7gbebslHPzGit0lhHsqkPQ-1; Mon,
 20 Apr 2026 08:29:03 -0400
X-MC-Unique: 7gbebslHPzGit0lhHsqkPQ-1
X-Mimecast-MFC-AGG-ID: 7gbebslHPzGit0lhHsqkPQ_1776688141
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 711551800623; Mon, 20 Apr 2026 12:29:00 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49B12195608E; Mon, 20 Apr 2026 12:28:55 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 20 Apr 2026 14:28:04 +0200
Subject: [PATCH v7 2/5] bug/kunit: Reduce runtime impact of warning
 backtrace suppression
MIME-Version: 1.0
Message-Id: <20260420-kunit_add_support-v7-2-e8bc6e0f70de@redhat.com>
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
 Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776688120; l=2136;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=EvDxlJcVBpYxTjqabx/j+30VM9jjHc+hJIPtgz057gc=;
 b=j+JeD/zKKszRnXGwfEbR0r9dcHQNp/MyXjhdoyfX1FAy3fqvwC0OcnCv/UUdTcvBOsLKUBi2S
 dA2fZh+1VNoBwfgjSnMDrCw3A+9/UMFlFJCiT51jDA2HMIoSJPJRp4Q
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: r4jQwho1xBWv53jYSJX3Vk1OQNMhOp2cIlEnwonLBa0_1776688141
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

From: Alessandro Carminati <acarmina@redhat.com>

KUnit support is not consistently present across distributions, some
include it in their stock kernels, while others do not.
While both KUNIT and KUNIT_SUPPRESS_BACKTRACE can be considered debug
features, the fact that some distros ship with KUnit enabled means it's
important to minimize the runtime impact of this patch.

To that end, this patch adds an atomic counter that tracks the number
of active suppressions. __kunit_is_suppressed_warning() checks this
counter first and returns immediately when no suppressions are active,
avoiding RCU-protected list traversal in the common case.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 lib/kunit/bug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
index 356c8a5928828..a7a88f0670d44 100644
--- a/lib/kunit/bug.c
+++ b/lib/kunit/bug.c
@@ -8,6 +8,7 @@
 
 #include <kunit/bug.h>
 #include <kunit/resource.h>
+#include <linux/atomic.h>
 #include <linux/export.h>
 #include <linux/rculist.h>
 #include <linux/sched.h>
@@ -15,11 +16,13 @@
 #ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
 
 static LIST_HEAD(suppressed_warnings);
+static atomic_t suppressed_warnings_cnt = ATOMIC_INIT(0);
 
 static void __kunit_suppress_warning_remove(struct __suppressed_warning *warning)
 {
 	list_del_rcu(&warning->node);
 	synchronize_rcu(); /* Wait for readers to finish */
+	atomic_dec(&suppressed_warnings_cnt);
 }
 
 KUNIT_DEFINE_ACTION_WRAPPER(__kunit_suppress_warning_cleanup,
@@ -37,6 +40,7 @@ __kunit_start_suppress_warning(struct kunit *test)
 		return NULL;
 
 	warning->task = current;
+	atomic_inc(&suppressed_warnings_cnt);
 	list_add_rcu(&warning->node, &suppressed_warnings);
 
 	ret = kunit_add_action_or_reset(test,
@@ -68,6 +72,9 @@ bool __kunit_is_suppressed_warning(void)
 {
 	struct __suppressed_warning *warning;
 
+	if (!atomic_read(&suppressed_warnings_cnt))
+		return false;
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
 		if (warning->task == current) {

-- 
2.52.0

