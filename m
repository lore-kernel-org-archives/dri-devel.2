Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770F606A6F1
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eH5Db7yS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A23810E1AC;
	Fri, 20 Nov 2026 19:21:55 +0000 (UTC)
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EFD10E252
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:21:47 +0000 (UTC)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so1568071eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795202507; x=1795807307;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DNVNmDF5dVzvlnQ4zjX9N+gfP3FXX+TLZ7yfkqU1zlQ=;
 b=eH5Db7yS/3V5aJekncnImhJmdbICY4YFBtlFD86/3tGv9a9bb3whtikqxksbHPG9o+
 xzWWCeRau2Sz5x2cNXA+ELMebMLuQOOMsb22X+0DeTWYzEhyalSpZGnTeNo4MIkLO61i
 oKFx2cb8xFSuioi61ydhGVf7ghluL89Wz3D9HqrahNRaknQUyGzcHUzd45HzGSr8PRVS
 3e4i/RwiAasa2vwf65ySoSyktmOWByyXdVrqURmUkxa29jbK/sspjLMEfUlmiuxgSpFa
 nLANRxtfaopmZHM5Pws/ixzZvrPTZGbjcvCaW2mB+tWsf9ekdk1ABM8ocrKs357dhL2h
 LcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202507; x=1795807307;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DNVNmDF5dVzvlnQ4zjX9N+gfP3FXX+TLZ7yfkqU1zlQ=;
 b=XN9DtrQPGv4Xfl8Xa1cEy+WyAY06GUMo4d9Jf1I3Tj1ilxU0seyv/xQUEqM+3SpsHz
 DAij7HXJVGXMcjVHxfCZfeTIlOb15gCD5Y3SOWNba8gfHapIY5sA7sPuzKhbPgS8YPId
 CzoGZkdiQfGKDLHpZcmKH/HDLuGDVy2ONl59URbugyvY2s9oZHlyFwbLWKERVzzeq3Uq
 kpqyT+U6zPoBCH4h+E2BPb+BzZWZNLITyz9w6L6J5bgJt/jgSEW515xBzoKuPRiXsvM+
 qozsoUjkUXTSN7IBOkCz3t5cOEWdRuzdcep4q7s5X0aOQn8Y5ySJWi2Vn55/YUviLyZK
 NffA==
X-Forwarded-Encrypted: i=1;
 AL+hErEb3JFO++TPf63qNDOo0sCtE6U4Qui8tZacDz1d0hgy9DZ+WSzGxOjaFbvoDp3irHqj2wteIavH7Ws=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9/TH96+TQ71svGUaiRiTYkMDOYIigf/v7KuOH+jqzwSIuu+l6x
 j9oPv3pKvfC6WCZSLMTjYAJkWKEAT3EwiOHzcQNf7NB2+h2WQRfGkR7NMYHBC0XhSiqUdy6CWZN
 LYg==
X-Received: from dycqw15-n1.prod.google.com
 ([2002:a05:7300:c00f:10b0:36f:5688:8a11])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:ff48:b0:385:3595:5e87
 with SMTP id 5a478bee46e88-3856fd5b5damr3386093eec.16.1795202506690; Fri, 20
 Nov 2026 11:21:46 -0800 (PST)
Date: Fri, 20 Nov 2026 19:20:50 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120192050.2868566-1-elkin@google.com>
Subject: [PATCH] drm/xe: clear backup ERR_PTR before retrying in
 xe_bo_evict_pinned()
From: Elkin Cruz <elkin@google.com>
To: Matthew Brost <matthew.brost@intel.com>, 
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
 Elkin Cruz <elkin@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In xe_bo_evict_pinned(), backup is initialized to bo->backup_obj (NULL)
outside xe_validation_guard(). When xe_bo_init_locked() returns an
ERR_PTR on lock contention (-EDEADLK) or OOM (-ENOMEM),
drm_exec_retry_on_contention(&exec) or
xe_validation_retry_on_oom(&ctx, &ret) restarts the loop while backup
still holds the ERR_PTR. On the retried iteration, "if (!backup)" is
false, passing the ERR_PTR directly to xe_bo_evict_pinned_copy().

Extract ret = PTR_ERR(backup) and reset backup to NULL before
retrying.

Fixes: 844150c255c9 ("drm/xe: Convert pinned suspend eviction for exhaustive eviction")
Signed-off-by: Elkin Cruz <elkin@google.com>
---
I am trying out a new Clang static analysis linter for ERR_PTR/NULL
handling, and it flagged this code as possibly buggy. The findings were triaged
and fixed with an AI coding assistant, then checked against linux-next (not
runtime-tested on hardware).

Thanks,
Elkin

 drivers/gpu/drm/xe/xe_bo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 353ac1e9a9d6..ae6fd20304ce 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1680,8 +1680,9 @@ int xe_bo_evict_pinned(struct xe_bo *bo)
 						   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS |
 						   XE_BO_FLAG_PINNED, NULL, &exec);
 			if (IS_ERR(backup)) {
-				drm_exec_retry_on_contention(&exec);
 				ret = PTR_ERR(backup);
+				backup = NULL;
+				drm_exec_retry_on_contention(&exec);
 				xe_validation_retry_on_oom(&ctx, &ret);
 				break;
 			}
-- 
2.56.1.750.gf70dc682cf-goog

