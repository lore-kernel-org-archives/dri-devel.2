Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C64FC55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A6C10EE95;
	Thu, 30 Jul 2026 11:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="hBbJyl6X";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4BE10EE95
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785411943; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WZJnWZVw2P8EZVw0NiWCAdqAmmrJUwyTjIU2dJ4N5zi3vmRvhXGf8OShBeBlmiAQfqPNc9UbwWi2cu3+BZi10kavfEMGOzKWjtbui2FVc383+qPAjCJozghPu1nAghWXnR+dOO3K7B5RVup7kEdikEObN///kdsMq3ERfIuyNgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785411943;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=A/S77ywcJNEWNYibuHZlunu83Y1+7/T5c7HCPO1HImM=; 
 b=Ow32821VLGpSHLE9w8mu4w0JAigIbpgax63Uup8tdH8SmFcihlS4W0VJ4Udc5jrdmf668hZvlDPZxcIoKPn6Nwg8/6z4a1Fe/RBPcyRUwLzGG1tiBIoUrAvvHac+Eg5XeOjYTPOtOkGAAu8RhtFLqNCzpx/JtQeiujba42cdk4g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785411943; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=A/S77ywcJNEWNYibuHZlunu83Y1+7/T5c7HCPO1HImM=;
 b=hBbJyl6XqfmES6HcabfPPgtRnsdbW/KZAOyGizjuvzSm91pomztQU8diG1VA91W/
 J+4IXyZ9QUGb49Sf//u294oGXlF27Si0ASeh/FzbrRShy2Eyk/ApprwcvUFJnoCW5EE
 xXwOcTBtsAHnh14PWyjUy8GsmBN30fLzN3fBMN/I=
Received: by mx.zohomail.com with SMTPS id 1785411942090200.7625346804483;
 Thu, 30 Jul 2026 04:45:42 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 30 Jul 2026 13:45:14 +0200
Subject: [PATCH v2 1/3] wait: Introduce non-irq variants of
 wait_event_lock_timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-panthor-cache-flush-fix-v2-1-28790478bfff@collabora.com>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

For locks that are never acquired in an interrupt context, the non-irq
variants for spin_lock()/spin_unlock() are more efficient. However, so
far, wait.h only provided wait_event_lock_irq_timeout and
wait_event_interruptible_lock_irq_timeout, both of which use
spin_lock_irq()/spin_unlock_irq().

Rectify this by adding new non-irq variants of these two macros.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/linux/wait.h | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index dce055e6add3..cd9b989c120e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1174,6 +1174,13 @@ do {										\
 		      __ret = schedule_timeout(__ret);				\
 		      spin_lock_irq(&lock));
 
+#define __wait_event_lock_timeout(wq_head, condition, lock, timeout, state)	\
+	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+		      state, 0, timeout,					\
+		      spin_unlock(&lock);					\
+		      __ret = schedule_timeout(__ret);				\
+		      spin_lock(&lock))
+
 /**
  * wait_event_interruptible_lock_irq_timeout - sleep until a condition gets
  *		true or a timeout elapses. The condition is checked under
@@ -1219,6 +1226,83 @@ do {										\
 	__ret;									\
 })
 
+/**
+ * wait_event_interruptible_lock_timeout - sleep until a condition gets
+ *		true or a timeout elapses. The condition is checked under
+ *		the lock with IRQs enabled. This is expected to be called
+ *		with the lock taken.
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @lock: a spinlock_t that has been locked with spin_lock(), which will be
+ *	  released before schedule() and reacquired afterwards.
+ * @timeout: timeout, in jiffies
+ *
+ * The process is put to sleep (TASK_INTERRUPTIBLE) until the
+ * @condition evaluates to true or signal is received. The @condition is
+ * checked each time the waitqueue @wq_head is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * This is supposed to be called while holding the lock. The lock is
+ * dropped before going to sleep using spin_unlock() and is reacquired
+ * using spin_lock() afterwards, but without globally disabling IRQs.
+ * This is in contrast to wait_event_interruptible_lock_irq_timeout(),
+ * which uses the spin_lock_irq() and spin_unlock_irq() functions instead.
+ *
+ * The function returns 0 if the @timeout elapsed, -ERESTARTSYS if it
+ * was interrupted by a signal, and the remaining jiffies otherwise
+ * if the condition evaluated to true before the timeout elapsed.
+ */
+#define wait_event_interruptible_lock_timeout(wq_head, condition, lock,		\
+					      timeout)				\
+({										\
+	long __ret = timeout;							\
+	if (!___wait_cond_timeout(condition))					\
+		__ret = __wait_event_lock_timeout(				\
+					wq_head, condition, lock, timeout,	\
+					TASK_INTERRUPTIBLE);			\
+	__ret;									\
+})
+
+/**
+ * wait_event_lock_timeout - sleep until a condition gets true or a timeout
+ *		elapses. The condition is checked under the lock with IRQs
+ *		enabled. This is expected to be called with the lock taken.
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @lock: a spinlock_t that has been locked with spin_lock(), which will be
+ *	  released before schedule() and reacquired afterwards.
+ * @timeout: timeout, in jiffies
+ *
+ * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
+ * @condition evaluates to true or signal is received. The @condition is
+ * checked each time the waitqueue @wq_head is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * This is supposed to be called while holding the lock. The lock is
+ * dropped before going to sleep using spin_unlock() and is reacquired
+ * using spin_lock() afterwards, but without globally disabling IRQs.
+ * This is in contrast to wait_event_lock_irq_timeout(), which uses the
+ * spin_lock_irq() and spin_unlock_irq() functions instead. Compared to
+ * wait_event_interruptible_lock_timeout(), it uses the %TASK_UNINTERRUPTIBLE
+ * instead of allowing the task to be interrupted.
+ *
+ * The function returns 0 if the @timeout elapsed, or the remaining jiffies
+ * otherwise if the condition evaluated to true before the timeout elapsed.
+ */
+#define wait_event_lock_timeout(wq_head, condition, lock, timeout)		\
+({										\
+	long __ret = timeout;							\
+	if (!___wait_cond_timeout(condition))					\
+		__ret = __wait_event_lock_timeout(				\
+					wq_head, condition, lock, timeout,	\
+					TASK_UNINTERRUPTIBLE);			\
+	__ret;									\
+})
+
 /*
  * Waitqueues which are removed from the waitqueue_head at wakeup time
  */

-- 
2.55.0

