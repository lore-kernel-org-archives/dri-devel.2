Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5ABCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFE110F35A;
	Thu, 14 May 2026 21:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=worksmobile.com header.i=@worksmobile.com header.b="n8kHmuWE";
	dkim=pass (1024-bit key; unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="Zc9nNL6n";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Thu, 14 May 2026 19:42:33 UTC
Received: from cvsmtppost106.wmail.worksmobile.com
 (cvsmtppost106.wmail.worksmobile.com [125.209.209.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6398110E3DC
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 19:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
 s=s20171120; t=1778787150;
 bh=1eHtKfnZZvV2FZWSbFdMFCZ/Jeqh4dQweFotTtU0Uak=;
 h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
 X-Works-Security;
 b=n8kHmuWElZGmiBaw0VKb3pQgBkPBbzRCcjMfvQiLc1uIJsH8+c7aG/tlQmgqwlgBl
 GqMHpIGk8xi1sUoaSIUU2rTfALamHYaUASDLa6vTkEcx8j6pMhZFc0L8bE8OUch8/y
 /ZNnpZaBAqZcv/OR53ocUwspk/z8hHZtnyHhJbk/HV4eLZwCW8PqZW5n5+sjBwy8ok
 So17h+JjaMJJXHPTRLBe6maPxx8+1cBGYf6wzq/vuJ2bYdSyGeTasLSyyqz0njUgJv
 f2KA1V/xpHwNvXLqQb/mWaFTrq75XtF2fE+uN3fkmtN8RVkRfaYJRI/X8TZD1SSI95
 pBabM9LX+o/pg==
X-Originating-IP: 163.152.163.130
Received: from cvsendbo001.wmail ([10.113.20.163])
 by cvsmtppost106.wmail.worksmobile.com with ESMTP id bIIte-1sQXG6ZmrqZKGE+A
 for <dri-devel@lists.freedesktop.org>;
 Thu, 14 May 2026 19:32:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
 s=naverworks; t=1778787150;
 bh=1eHtKfnZZvV2FZWSbFdMFCZ/Jeqh4dQweFotTtU0Uak=;
 h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
 X-Works-Security;
 b=Zc9nNL6nQmVpoqHx3BhhpSVgEdphZnO22JN7CihzTL/vanUJo7RFGjGO9fT9gOHRP
 hggV07eGEVMd7EaiU4HQhOXF24/hg6C5JGXUaJ7Go3SNeH+6UjbZkEhbyIcrIJXEUq
 GZ8Zr4BtdzWI/JevJzUZAl0umBZrKqvlgwGP0+Og=
X-Session-ID: DSRmjtN-SyWT0Zk01YbWfA
X-Originating-IP: 163.152.163.130
X-Works-Send-Opt: penljAIYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: A9K9Fq2XFqJZ+HmlFAbd+6E=
Received: from s2lab05.. ([163.152.163.130])
 by jvnsmtp403.gwmail.worksmobile.com with ESMTP id DSRmjtN-SyWT0Zk01YbWfA
 for <multiple recipients>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 14 May 2026 19:32:29 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Use IS_ERR() check for kernel_context() in
 selftests
Date: Fri, 15 May 2026 04:32:27 +0900
Message-Id: <20260514193227.2472962-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

kernel_context() returns an error pointer on failure, never NULL, so
the NULL checks on its return value are unreachable. On a real
allocation failure the subsequent dereference of the returned ERR_PTR
(e.g. ctx_hi->sched.priority = ...) would oops the test kernel.

Use IS_ERR() and propagate the actual error via PTR_ERR() in
live_preempt(), live_late_preempt(), live_preempt_timeout() and
preempt_client_init().

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 drivers/gpu/drm/i915/gt/selftest_execlists.c | 28 ++++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 21e5ed9f72a30..36f51805f74e3 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -1742,13 +1742,15 @@ static int live_preempt(void *arg)
 	int err = -ENOMEM;
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
-		return -ENOMEM;
+	if (IS_ERR(ctx_hi))
+		return PTR_ERR(ctx_hi);
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	if (igt_spinner_init(&spin_hi, gt))
@@ -1834,12 +1836,14 @@ static int live_late_preempt(void *arg)
 	int err = -ENOMEM;
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
-		return -ENOMEM;
+	if (IS_ERR(ctx_hi))
+		return PTR_ERR(ctx_hi);
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
 
 	if (igt_spinner_init(&spin_hi, gt))
 		goto err_ctx_lo;
@@ -1934,8 +1938,8 @@ struct preempt_client {
 static int preempt_client_init(struct intel_gt *gt, struct preempt_client *c)
 {
 	c->ctx = kernel_context(gt->i915, NULL);
-	if (!c->ctx)
-		return -ENOMEM;
+	if (IS_ERR(c->ctx))
+		return PTR_ERR(c->ctx);
 
 	if (igt_spinner_init(&c->spin, gt))
 		goto err_ctx;
@@ -3384,13 +3388,15 @@ static int live_preempt_timeout(void *arg)
 		return 0;
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
-		return -ENOMEM;
+	if (IS_ERR(ctx_hi))
+		return PTR_ERR(ctx_hi);
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	if (igt_spinner_init(&spin_lo, gt))
-- 
2.34.1

