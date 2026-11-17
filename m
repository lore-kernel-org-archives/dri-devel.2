Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvGtvT8B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A9E10F7EB;
	Tue, 17 Nov 2026 16:43:54 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D324010E405
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:54:14 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e987a2ba0cso29329005ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 06:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794927254; x=1795532054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nR9F0XM+B7rn1+ea8p9fct2rHHNP071jbR/ecoiRPcU=;
 b=YvGtvT8BhwQonfDWTv6lPSJz00sq4i6nHLDP/k45KYBPvtB+xHkX9MqTunjsn+ZDCU
 PUcJzRHIjIrVtfBTVPVnUm7tgWMiJxAL4B8lTclKg8JtyaJMsDdR4VSX6y0iovsqwMJ/
 WB9QGdKAUB2EJ/295nm2k2QBAQa9ruAXPLnVF7wbp28Fw4yChm1Al01R/zzt4DdSGWZG
 LI9I5dy5JdrAmsi4br/bD/XMWX8Pyw+liTa0RdfrZBGf6Fhn+6dQ1+yqesd+6YiJ4vXi
 OQn2VyWHxX+DdNM5dVcX4H/h4ttFIxkU93vApcGLBfM/g1X7X+8NhcbNZJcjgJRAoT0E
 HKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927254; x=1795532054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nR9F0XM+B7rn1+ea8p9fct2rHHNP071jbR/ecoiRPcU=;
 b=FFrrH7/vbRAXLvkmDMaweTB1IOkWxTxoCljQWulQ8TQr6aBHAU6YqThyCeJ4omN+Wb
 fT0FlmPxI9AI1+4bmGkx8QtUwpusOUIFX6ytu4lyiQU0iM+nYXhZdmTLQtShJ/GHuyAt
 e//rt6zmNBzV7KZnDTJF165JpZKziqqvN1XkMWMT99akhCHBEJSzdjaA5yHSRupBy1yE
 CG+P+C0EKd9Tzpws2O6QXPR+B3kJLvrwyj2NuR7FYMw+o9b3PCuzumA0OqLdb7jaaoxl
 XKYGPJKJUVJn09aFsyTykGIsyvirGARRkt+XKO0eN2gajjQwfvXzD+QrCfzOixT9I9nr
 r+CQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEs2sP/D6ck29jtAOMQl3wvjboQstJQY3VPVty5K+7elT6RRfcaOxrslT+G2VCKR9PbNLpyfn77JC8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9lOogZaYAkE00v5wmuhQRiXcbZ+5Jv+bHKVHhg5P5oW61obVmH
 VDsoZy/YPMihsBJguCrAOirmb9tJyuD8V8Nm5Y4HVAzECK/uBCiQRgGI
X-Gm-Gg: AZFdTZfMZrd+tMkvCjI2TION5D2KbXywDKzIZwyPxR6WyBVj/c8OOBaG14gmP+1Xp2O
 Xm6VHe4/gNK0mmrTpVwthV+4y1LtqYLjPqLQ5I9H8CDDHlk8aiKnrlw7JOCKc0h+X+IrM1QV/a7
 JU9hLWdTSTCX0g+alp5rG5ENCAgRCr6Lq67FcjybvfZSYV4EBjaexEpCxuYabTAExwIwqmpPxK8
 NRCuFDmGFM4YVqd7caeGY41S0EBDKE5WJ6y89ZzljOQuDz0joij0OgF7v6HZpCZHsh8Job4yEJp
 WtXdnJ2d6Mk76gr73nUNgPzCAB5es9uyzPhFeSiCd1dyzYAH6kxxmy8LffAtvuzBwNcLXonJseE
 CTq2GSwMzSJpwVFDfdhcmWbzwlKwyfjv3Xy/WBjGAMdsPgZWNNqspneGxgnpCnFcy72MtOk94ND
 OjrrEZLKXW2eiCUnXzhpl+29Qjz0kH7y9ywb1hokb85ifMB06QxlzLh16wWTtiXWUp8P61Y4Pzw
 h/ooDAlkrp8oFHURraYgyYqbkZGs7F0YX5qLWSWhEZBqFspD46TeZO+BS+UU8Ry/1TMjtqRvz+G
 OxZArTyziSpmS6X7+hGnNyv1Z2pI0q+g6Ks+lslc6o0+zfNM+a22JoOeNx9ZhEJ6zJ21EObNmS7
 gQtwJgo4HNSnj0K0DrVwfQOe0d+FBY35HP/TjyG0i
X-Received: by 2002:a17:902:d4d2:b0:2e9:2a1a:8b69 with SMTP id
 d9443c01a7336-2ee0dcc33ebmr121427145ad.55.1794927254093; 
 Tue, 17 Nov 2026 06:54:14 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:f6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2efd7a7ff9asm16767345ad.54.2026.11.17.06.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:54:13 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, oded.gabbay@gmail.com,
 kent.russell@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/amdkfd: unlink destroyed event waiters from the wait queue
Date: Tue, 17 Nov 2026 22:54:06 +0800
Message-Id: <20261117145406.1092636-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:43:43 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

destroy_event() clears waiter->event and calls wake_up_all() before the
event is removed from the IDR.  The waiters use init_wait(), so a
successful wake-up already unlinks the wait_queue_entry through
autoremove_wake_function().  A waiter that is already runnable, though,
is not woken again and stays linked to ev->wq after destroy_event()
returns.

free_waiters() only calls remove_wait_queue() while waiter->event is
still set.  destroy_event() has already cleared that field, so a waiter
that is still linked there is freed without being unlinked.

ev itself is released with kfree_rcu(), so a reader that reaches it
through RCU -- kfd_set_event() or the GPU signal interrupt path -- can
take ev->lock afterwards and walk ev->wq in set_event(), writing
waiter->activated into memory that has already been kfreed.  The
waitqueue_active() test at the top of set_event() reads the same list.

destroy_event() used to unlink the waiters here.  That unlink was lost
when the code was converted to wait_queue_entry_t by 74e4071665da,
which moved the removal into free_waiters() and left the destroyed
path without one.

Unlink whatever is left on the wait queue after wake_up_all(), while
still holding ev->lock, so the wake-up is delivered first and the
remainder can no longer outlive its storage.

Fixes: 74e4071665da ("drm/amdkfd: Use wait_queue_t to implement event waiting")
Cc: stable@vger.kernel.org
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Prepared against v7.4-rc1-1969-g666539eecdf4.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.

History: fe528c13acc7 unlinked the waiters here.  That unlink was lost
when the code moved to wait_queue_entry_t (74e4071665da).

Testing: compile tested only (x86_64, gcc 11.4).  No AMD GPU was
available, so the race was not run.
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 6e32a892d56f..adc27f25af4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -219,13 +219,25 @@ int kfd_event_init_process(struct kfd_process *p)
 
 static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
 {
-	struct kfd_event_waiter *waiter;
+	struct kfd_event_waiter *waiter, *tmp;
 
 	/* Wake up pending waiters. They will return failure */
 	spin_lock(&ev->lock);
 	list_for_each_entry(waiter, &ev->wq.head, wait.entry)
 		WRITE_ONCE(waiter->event, NULL);
 	wake_up_all(&ev->wq);
+
+	/*
+	 * A wake-up that actually wakes a task detaches its entry through
+	 * autoremove_wake_function(), but a waiter that was already runnable
+	 * stays on the list.  free_waiters() only unlinks a waiter while
+	 * waiter->event is still set, so once that field has been cleared
+	 * above nothing else will detach the remainder.  Leaving them linked
+	 * would let a concurrent set_event(), which reaches ev through RCU,
+	 * walk a list pointing at already freed waiters.
+	 */
+	list_for_each_entry_safe(waiter, tmp, &ev->wq.head, wait.entry)
+		remove_wait_queue(&ev->wq, &waiter->wait);
 	spin_unlock(&ev->lock);
 
 	if (ev->type == KFD_EVENT_TYPE_SIGNAL ||
-- 
2.34.1

