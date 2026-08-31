Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6B5C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DE510EBB5;
	Tue,  1 Sep 2026 07:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PlAy1Dui";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B423B10E305
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:37:55 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-43bf9548df4so3538913fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788194275; x=1788799075; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q9afrDjj3OiNFQNFlcWPaAJKUnSQO06bnnIAXSq7zMg=;
 b=PlAy1Dui+KQEPCXFVVYsqFiiJMr01Ejywmfju0m2OF3Lipe8pjINgtJQj4L08fjcZu
 P/ZoivTyVYg3tQcScqY3DBZdZO361QPYNV5Ep7Ho0gWHBe/ifgFntNDNNV+RQxwNcxF2
 TiwNKTlKqQmcHHzHbpqSf0UFDQU5Un87xD2i/lh5Lhxo5suwIWupbCuj5MtQ6Pe3K3my
 cf5bPl0zkijjPc/aF90q5LNDt8mLJ67l5ZoNtzWU60Ge5aIZ2/0sY5Mk8GP7jHSTPX6n
 R542HOmGlzpVyzz3YeCuAsHVAXgCDAlTJhvbwZgcQpVzUuFeH/SI1slf1ouS/al+XMZM
 hdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194275; x=1788799075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q9afrDjj3OiNFQNFlcWPaAJKUnSQO06bnnIAXSq7zMg=;
 b=cIWFmSJw1mgcxfl4rFWVBn1dxV5/xqp1Ta83+e8nk7GhSF5JTr6er/sy1H1fQTW4Jf
 SuNTICxMZfcsrZzHqyplk4jkY/ce/Hsw2b+Df9eRPnKjpFMwHZ6QHyIweaW74WD8R/Yb
 93xAeiiVKpXOhHQBtNK7J5ib1H/2ttMXf5MDwSy6zI+iEG3z5VsY2GbVzdUnU9PIKgM8
 GgfZPo7ayQq3H1ZMY7ka5BEWT/OHPt4pkaCmbqm1rz3J1mO4aPz+YO0b29V4lxRIry9N
 U6qytbwLrMp74SYL8mfmT1PrJfYR2fLQsQ3VVq3MOYFFxLHox5BEvi9IytdG/2qLMQAm
 mwpg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPAy3WmruroQ84iymZeCJb7MgjHMu2qYVnzxVYB20iTc7UL4gkBiWbuGRdkQiBdQojwqqSmNrffiE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mJYWa5iOZb3ToTKy3rkdbiW0XDP5DmVx5fpsMH4VlrVNuGFhJu
 y09pr/rOd623K9NJ/jRFGaDGoIBfNOD8Jx/3kP7C6aG8SqtT6u7mkzNu
X-Gm-Gg: AR+sD13jP6vkW2K8DX2WccSBq8agZjq0pKnzS+I2R5e6YpirMzBY/Qpmu8kgM5FwkrL
 hxzSknwzJFk4P7N0jVFVSkJVU8RESSgOsFbX//1Roo2ohsqGKY+JVwIg3o02bZD7xDhop0RmI84
 L006mCPIfB1s4ZenwuhJkCAv5qHiokntxiGk9cfaw/YtSodQ3YPqvTRPe/RmZ1HVlpHZqTsNs3W
 9qJbBBzd2XCCRkN0SgH6covj6dSk9zaNiKZ12VvcTTL+xupmd27X0Bk/QQdcl9ft0sllz0qqZjb
 ok3Qec6t9xP8yj/hsG+yrnRvpEPnI1V9lOFyW4WLmQVRaXaOeytDfSW7oc+zVYuvGbanOIuQaNk
 VhaT10k3Zz1i56xHJsNUVDg0T/6Vg/qJZliLo+rGkf6LEk+F0KcT05XmLztnhITbRnywtEl+QIa
 su4JoTkbXXwxmoGIjXMVlXG6VRYJbwHNGt69M16cr5uBUC10/aDiwfWqS8StUPybzQnF8/T2y+q
 tnCBJl77LxzS2Jgag==
X-Received: by 2002:a05:6808:1921:b0:4b1:b83a:5878 with SMTP id
 5614622812f47-4b5b81e2f8emr2412176b6e.14.1788194274813; 
 Mon, 31 Aug 2026 09:37:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995f2fsm8537880b6e.11.2026.08.31.09.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:37:54 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org
Cc: roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, dev@lankhorst.se, mripard@kernel.org,
 nat@pixelcluster.dev, tj@kernel.org, mkoutny@suse.com, osalvador@suse.de,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-team@meta.com
Subject: [PATCH v5 1/7] mm/memcontrol: flatten try_charge_memcg control flow
Date: Mon, 31 Aug 2026 09:37:45 -0700
Message-ID: <20260831163752.2193337-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

Refactor try_charge_memcg by flattening the nested memsw/memory
page_counter operations to separate the logic between the two.

When page_counter_try_charge is made stock-aware, this flattening makes
the control flow easier to follow since each page counter now has its
own success/failure paths.

No functional changes intended.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bf829638524b5..93c2fa04da4fd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2679,18 +2679,21 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		batch = nr_pages;
 
 	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
-	if (!do_memsw_account() ||
-	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
-		if (page_counter_try_charge(&memcg->memory, batch, &counter))
-			goto done_restock;
-		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, batch);
-		mem_over_limit = mem_cgroup_from_counter(counter, memory);
-	} else {
+	if (do_memsw_account() &&
+	    !page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
 		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
+		goto reclaim;
 	}
 
+	if (page_counter_try_charge(&memcg->memory, batch, &counter))
+		goto done_restock;
+
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, batch);
+	mem_over_limit = mem_cgroup_from_counter(counter, memory);
+
+reclaim:
 	if (batch > nr_pages) {
 		batch = nr_pages;
 		goto retry;
-- 
2.53.0-Meta

