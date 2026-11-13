Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063FD607233D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edsGFvGt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4511710E81F;
	Fri, 13 Nov 2026 16:06:26 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6389410E81F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:06:20 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-376a4059061so126248eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794585979; x=1795190779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wUwtsQ3N40287aIsw4DkULjhgKBahJqAdXPD93dhPZQ=;
 b=edsGFvGtqtwAqIsoDnFliLYMzwQWu36NX09rTmtlv1n9YAodJd1tU1rPLvc+GkuxqP
 bkimF0ktWSzQZbc55wXHWZ4iMlAGPKYGRqcN8CwwTPgv6dPkWa5PNVMxYvnN6PmscvUB
 1hJwQqrKErMs+POvZWE2o2p1bb4C89kniGzt5NYGiMvAvJc3uWqbOYwnLwTovmhZxUhF
 S+jh9u9tkZHsXhWNf5Rd4hdse6+I2fr17ri2acI48uMhM2fzN6KDZHdNsSk3Sm8o9spN
 MFF1pcv57kIOngd1F4RolFqyyjRzlmOq3yVLfIuGInxNV6ogFyT8Ta2WMA0ornM8Qcmi
 0nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794585979; x=1795190779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wUwtsQ3N40287aIsw4DkULjhgKBahJqAdXPD93dhPZQ=;
 b=jRwbHwi4R5JLS16grDZMGfMzHDhPmlSQnYLcqfYJUDpaxeZonGGQsGFxI2EPFUgt+i
 WT+vmQLnzeQWfQvrlM0BZCiJLtBRQIjzeUSki3XOonOGhNKb5rGnhDl8PZd3UBoL/Mwz
 rjHNSi/LVwIRnb+noeJcZs5WKmU2DdaUgC6AHlolprW6BIcqZbLK9IAURG1wXqKoT5f1
 3lwKSwEeMoTzOaiO4Z3MJYhWRo2ycG+kYLa6qOg8iMFC5+O0gyOWZHPz3sTKlTkyANEn
 JdtWd9lJsbfdJHlFdwJRGcWuFS6YRQIi9mHe27ldyX6jsrE1zBuStLz+Sgpl/YOr+i7m
 7Owg==
X-Gm-Message-State: APuU4Z/YwkvomkLJ8fmSxR+sGPR5nCoNEbpTbANAUERDZes826efZPHm
 ky7oMZSE1nsBw/9NiT3mAEQ+fHVhfbUAwPJr6iSFQzphaeB0pM2W++7Lg6Bo74IGjk8=
X-Gm-Gg: AYBFou14NNV1tXe+xHiIX6sgW+adw9cwEbCLV1vDcPJmI3EoqbahwN8ddkPTOyXuRxo
 ePey44/mzBBtJomk8b0Vi9Ab7O2gZCsn4DWIz1qaqzzSJLjc9yXJ36VgZWT++ASQrE99KXgIadp
 OjSnHB6JzEcrzrQC22ni93tAyhnv46xTmU6dxBxBcOBUNHszULWONqzdgg70u6jzgPeicA12p8G
 34cxSBc/ZMiv/dO3C6+zu4NuGYSYg4EwXl/pQ8eINAafn+Hv06IQSTGcWr5GoGjLPI7u9ElzFim
 RxsanAJUpYvBMRKOBeYIkPh5aof0kfYJdITtSxoXEv4/KARsLWMmLYeBex6LG/YQvFyH2GbKov5
 wpDs1kDJCHGnO0rnG6Hgc93HDLKzRXfZs9iC59UZEVp0rovq20kjfHGsBcyNJ57L+8RpzQgH4AN
 OBX+gQxvXAICkv8wXDHy/jPt+job6P+fVjBqTV5hQ/hnyO7z7HyyxoK6hejc2BJoFOz55zwzvAv
 RN0B89AbOmX32Ov1JLQ+rsML8t9zndHhGClF1L4nA1GsMFTZQcVVJtygR0+9WX+UbjBxpZXB1zz
 oeF3HJQyCN/7ZKFLmpjCsc/0hVzE3MsYTHJQ6E6a4RNfFE2YJDzuTKDa03ZA36I=
X-Received: by 2002:a05:693c:8204:b0:372:c0ee:875b with SMTP id
 5a478bee46e88-3796057b529mr3832724eec.0.1794585979141; 
 Fri, 13 Nov 2026 08:06:19 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d3e37sm9078296eec.24.2026.11.13.08.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:06:18 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v3] drm/gem-atomic-helper: fix fence leak on
 dma_fence_chain_alloc() failure
Date: Sat, 14 Nov 2026 00:04:58 +0800
Message-Id: <20261113160458.179741-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In drm_gem_plane_helper_prepare_fb(), when both "new" (the plane's GEM
singleton fence) and "fence" (explicit or previous plane's) exist, they
are wrapped in a freshly allocated chain.  If dma_fence_chain_alloc()
fails, the error path runs before dma_fence_chain_init() adopts "new",
and error: only puts "fence" - leaking one fence reference per failure.

Put "new" in the allocation-failure branch.

Found by static analysis.

Fixes: 1ea28bc5542d ("drm: handle kernel fences in drm_gem_plane_helper_prepare_fb v2")
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v3: regenerate with git format-patch so the hunk header carries the
function context.  No code change.

v2: add the Fixes trailer for 1ea28bc5542d
https://lore.kernel.org/dri-devel/20261112161725.41955-1-lui2012qwq@gmail.com/

v1: https://lore.kernel.org/dri-devel/20261107165303.13508-1-lui2012qwq@gmail.com/

Build-tested on x86_64: drm_gem_atomic_helper.o compiles clean.  Fix
written with AI assistance.

 drivers/gpu/drm/drm_gem_atomic_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index dd9efa7e3216..5d5bc0d1495c 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -154,6 +154,7 @@ int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane,
 			struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
 			if (!chain) {
+				dma_fence_put(new);
 				ret = -ENOMEM;
 				goto error;
 			}
-- 
2.25.1

