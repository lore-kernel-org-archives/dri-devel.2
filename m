Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE192606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2D4+Q+I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8F310E42F;
	Wed, 25 Nov 2026 10:59:30 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B8710FAF3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:59:24 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-386c4d2e2ccso2734231eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604363; x=1796209163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j1FGvTIUIAFBOZYmL6OiO8sZFEbEFDfPmxmvVzyQ4O4=;
 b=j2D4+Q+IDY1Pfogzgx1+CcWYbQhYRfFRS0f4LiniHxdNHPoWaoBk93wvuGBiFCBNJ0
 i/NPJyO4w6pMZP8is6/MA0aAbf3Mo+LvSuUe/q6DY/JfRR/xWF4S4UhUMGdmQfsamoK4
 5vMA6UahyCN2Iqbd16cfCfDBH/mYwoHo9elrLTb1zBVVw4TXgc032I8HFdVIVym0xbKP
 aRBZjxUyEqM0VGEqw+dKoj4T8H1bQA8hjs/UbE7VgXNh9wZRnRF7+jH1mKfWdiiMVUAJ
 7pvgekkTtzAJUhkMSJw43w0Ezfu/2jUCosL94lVz7ZWXjaS5b7dM/njTd9Kb3wKmT61v
 MPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604363; x=1796209163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j1FGvTIUIAFBOZYmL6OiO8sZFEbEFDfPmxmvVzyQ4O4=;
 b=QlTDIXIt2oL9I4KYG7Qt1zwn++d6hhb0RF9XBM86Q0QG6h/lfi54JDvhVaiTcyiTca
 a0VjQT/lUd/lM+YdLrP57ke//r7fIMc0NupxetjMH1ZntcyhNL9zNN5yc9D0f6DrTbLI
 mniZVc74UXCqFuTsf1Pku5008FA0wz9kgCSSzKxEDIXA40GWXbbOX9UzX3mL1PKGw0zN
 T245FZJDid9yWaR8sp/93MfsYzQa47L5sXFPjx4RhHgZMgqZhy13tvn8zywADAq4TtHH
 /Qw4Mtzfxbt2JRw1lJz9EJNZxRfh7fwwsw3+9DjaiUepEehbct7lWR1JBJWNuluETOYx
 rkMw==
X-Forwarded-Encrypted: i=1;
 AL+hErG86MkSEA4OpdmQ/DXhBhkWMXy9Ff7KP6h0R58GErN4ztG9NNA2ChMWcCm2UsA0rMDpW8FJEAwYO9o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z94+7j8T+ueBWdwLTQdd+TVzShkbZc42IqrFgms6XdEYmfSQpg7
 79Uz3i1vQOZw/8AV0/N2+mTbztdt5Fqky5+qifZz4S9qwTAgFjLfa2oH
X-Gm-Gg: AZFdTZfnRRSM6TsluLUSThLcNIdTDJUYN0t1udfHbamUN2uknVQi4fJ/c4jLF4JTSOz
 i3vvdAZYin6GtkLW7qHKg93B45dJlz+zcLdD9v5ZU6VPKN5b85h57K52ZYDM31q2Ix4WROUTTEp
 2ZF3tg6ErCRHsg6Br2o0+N+ZkCHBQG+Ea9JBkv6zKXeoKiSpIF8iQ1vORlefICo82c63d3cqVQq
 CG11Bphj1WrMYmK+OnkhQXQ6sHybM2Fux7nivyPNtIkuqhq2epfoBQGsPbKEVV131tQuc6OsUTx
 V6/yxCYq6CFkfVudi9+HN1FSc43SbyRSb94Y7qsnMG4MEr2C/nhgayv5WmXKqwGNzsP/0/w1kJ7
 /9gFtM2J3y+hBqWte0rKhEvWmZGBYDTtU1vbhoRhxg9Ab2PRh6ydfilhjYTUTm7BMAuvW/pT3rl
 IJMjpIDb6+FD5lW01P5E6K1VPD369ZrvEg68iU3KkEVnae7TtovQ46OiTrahuU5HP8ABTkM54KE
 YiRI+Q9ioFehVGUxykg6oIiCl1tBFN24J0WWbaz4ZKDc3NOWy/yhUh7pPVyWfEPS0FlreEyoPOt
 Sdlhl0HQmJ82ym5BFo0z0/eWZcOyWTXGr9zGypFm9p9y6kPCXajwr7bdCrmzYQzFZiOy9wbSS2U
 Cywy800bE3oND+CCN4feP5T4GjB8=
X-Received: by 2002:a05:693c:39cc:b0:386:48c1:6c5e with SMTP id
 5a478bee46e88-38648c1719dmr15667422eec.37.1795604363311; 
 Wed, 25 Nov 2026 02:59:23 -0800 (PST)
Received: from localhost.localdomain ([2409:40f0:12f:243a:5b38:482:e2fe:5dab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385d2b93dd9sm60114815eec.24.2026.11.25.02.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:59:22 -0800 (PST)
From: Torra Sowmya <sowmyatorra@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe: Remove unused userptr rebind tracepoints
Date: Wed, 25 Nov 2026 16:28:54 +0530
Message-ID: <20261125105854.48591-1-sowmyatorra@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The xe_vma_userptr_rebind_worker and xe_vma_userptr_rebind_exec
events were introduced without callers. Their definitions were
later moved to xe_trace_bo.h, but remain unused.

Remove both definitions while retaining the shared xe_vma event
class and the other events that use it.

With the tested x86-64 configuration, size reports a reduction of
936 bytes in xe_trace_bo.o, from 24146 to 23210 bytes: 344 bytes
in text and 592 bytes in data.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Torra Sowmya <sowmyatorra@gmail.com>
---
 drivers/gpu/drm/xe/xe_trace_bo.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
index 36fc7eb65882..8be08d527ea5 100644
--- a/drivers/gpu/drm/xe/xe_trace_bo.h
+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
@@ -150,16 +150,6 @@ DEFINE_EVENT(xe_vma, xe_vma_unbind,
 	     TP_ARGS(vma)
 );
 
-DEFINE_EVENT(xe_vma, xe_vma_userptr_rebind_worker,
-	     TP_PROTO(struct xe_vma *vma),
-	     TP_ARGS(vma)
-);
-
-DEFINE_EVENT(xe_vma, xe_vma_userptr_rebind_exec,
-	     TP_PROTO(struct xe_vma *vma),
-	     TP_ARGS(vma)
-);
-
 DEFINE_EVENT(xe_vma, xe_vma_rebind_worker,
 	     TP_PROTO(struct xe_vma *vma),
 	     TP_ARGS(vma)
-- 
2.47.3

