Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67E606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LShBs4Um
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5860F10FB93;
	Wed,  4 Nov 2026 12:34:53 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAAFF10FB8D;
 Wed,  4 Nov 2026 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=/KrU18TxoMz8vUQyvvcbQgGQ57lrSkeZ5V2+nueE+zk=; t=1793795686; x=2109155686; 
 b=LShBs4UmsCbOFb7GPqJ+fUSyEMxw15nQmz02fcKqpknovioVCtfwi0S/BtPo9FalS1YZ3md5XP3
 UNdHAnF223CM2hfTCQFW+eq7FrC6zeGou/FB/prA8IPA9tfY86WczvzkYHD7phEhyDVMUbjThBnA0
 KTXL4yyo14odCkffyu+uXozW8ykbTK4YnGw9c0UCbLB/goCiXxp8M6ZtILEmDPm4lNZcNARNlVfr1
 ibcdL/wD41EaRQ16dXmP57pLzSxptrnhe679hjKXg/hWqkU7cycpfWNQeSKicl4LFMIp5dBDMgveE
 fns29xqZ6A88xlAfzFxmpfEircexDdV8h/hA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOaCS-002Fet-PS; Wed, 04 Nov 2026 13:34:44 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 3/3] drm/sched: Remove useless log message on memory exhaustion
Date: Wed,  4 Nov 2026 12:34:41 +0000
Message-ID: <20261104123441.34842-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104123441.34842-1-tvrtko.ursulin@igalia.com>
References: <20261104123441.34842-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If scheduler initialization has failed due failure to allocate a handful
of bytes for the run-queue backing data structure, there will be plenty of
loud messages in the kernel log. We can safely remove the one
drm_sched_init() logs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d86738611b1e..85a49e219837 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1164,7 +1164,6 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 Out_check_own:
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
-	dev_err(sched->dev, "%s: Failed to setup GPU scheduler--out of memory\n", __func__);
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(drm_sched_init);
-- 
2.56.0

