Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C389606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nb2Gsn9O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA2E112C21;
	Fri,  6 Nov 2026 09:18:42 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0088C11248A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:01:19 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b309147589so20188097b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793887279; x=1794492079; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m3SlBj9C3fFyi2mB1vPCHBkBvVGhRO2V4RCAtxMQktY=;
 b=Nb2Gsn9ORh4LxGxkRW+e4Pi31fGMyE1DWmFQBQOKW4/dLLLuLCPC7B5MkCf9IFr54I
 3sGyHZCMBzYb2PpWPitzorNwp7C+7BdssFkXGC0Mdu1uN2Vfr8IYHogasvc7UQZHlnmM
 g8iYQe/pmjJz2wnB4K12OedjL+oKkNjxl4v0PGmQIU3d3lmSrExDL5ni/FJkvoSpHRW/
 71cQMYUrlyNAcfTlsWkoaSTeRevQstjaSGYH1x/ThBxPgn9KhoirZpJqEa7/04MS65Eq
 5byvxWZKHDIvXp4sSK+Koz8V/GCwRgnU0KroKayRclALdBDzf/OMYn+4+Et7/R1kAJgJ
 rXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887279; x=1794492079;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m3SlBj9C3fFyi2mB1vPCHBkBvVGhRO2V4RCAtxMQktY=;
 b=RHlKlfXZ0tDzkq7O0yN8UgKnRYb0dY25CchKOAocJJpAdJ+m+IdUNPzfyqIh0vI22d
 cR0444WIr47pFB8ZfZ9Vo9q95QwX9A2kNr3ZPdzfyMzqf6mHYzQLXxSFFQ2IrT3FWxmW
 KxjS2r80FKqYlZOPeDncjWhVal3Ck6wmLEn+YigbAZNZdrKVXyUNqEWJRH7C2IBZn7Mo
 VOzUheglSaxlQO0sKIf/5EMr03upUsUXOiNTCUgrbuwgj7ojwob0jLp25PoCwOjuFl3l
 B3ca9jhfy/JLYm5//F4q891e506EeosWmDBO8PTvNathg2UKgiSpdHer6lek01mxsw2F
 vruw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWxS29BP8Q5oFXrpBvUwSiBQd1fpbGVdpKgmekIw4hhjMuY3O0bMb0ElkKEtkh8M8mBvQHZWuUK0I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9e9FGJZaViHRdcusL98N9pF3OJqkHRcfPFqaBpXNUkt2CqE3vv
 YI2q9dGV1j2ig0sE0cbdAUsSVbvADFfC9A3RgrbL5qg8s8t/aIitaCsb
X-Gm-Gg: AYBFou3YRrfLOV6Og1N2kNk4aR4o/JBdbg7axY9KXYA6I2f4g6ycBHzTtXb5Xduiww9
 xiXBChkA+OcYeILMB51MqckVPJJ84KRItDIjuxuqZxbk+zv14+Fun7UsIM3coroN/gs2qUP3sB3
 Xagw9JtHCUb0m4R0opCcLD2a7HZzQCRvfkaTsjWOrxnrigbXNMc8fzx2vAwy/X+2U71TwKFAJZ0
 CRoo8XcJTYrm4ZrGqBY9/XBrw4nWRErhOLFoeJT/rvrzVkNeBlDTbVeNPFuJhylLcELnu2ssf4o
 UIYP2J3sGgfnCIbLQQNVjKSVab5T+wRE0ei2FB6P9l/C8QeobPzNaLR44RIWYT169mTn1KfVwE7
 8gmusYlWIraz3vy+WV2eNL1NffFv9kDS3d3le1OWuIn33IsgYd+E29KF0PJ7HM/zVrgD2i2QyU0
 DnGm36sDahQfOiri+S4mGkiLQfpy8KyR3n5YSs7VZ4Tmi7DA5+pLUbElNGtTabOrsnwdXMV+e3I
 cVy6C9sI0ROX6uosemmcnl4gHJzHHdw95opzGfEYJdZo8m4vvFeV9q0j+WtLiojybiXCkzCA/dp
 OMaVWBP2igCWnw3ykntBvPjhYkySsrLB65MbwX6eB4nQdxga0cifzOh7y+2U6wBfMhD9UgpUNRY
 z/knO+GGJYhN+8I/hnYi6tse8h/FDbtloz3VIyJ0qNTvA+suj97TaT6dnIwJsiJrzYm4qFIfaMN
 kXag4Ld7o=
X-Received: by 2002:a05:690c:a013:b0:8b0:ce77:8dcd with SMTP id
 00721157ae682-8b2b67a446fmr105553857b3.62.1793887278349; 
 Thu, 05 Nov 2026 06:01:18 -0800 (PST)
Received: from lab01.myowncloud.network
 ([2601:cb:4000:1c5:5396:7ba1:d08a:ebca])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b309959603sm41104577b3.24.2026.11.05.06.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:01:14 -0800 (PST)
From: Amit Patole <amit.patole@gmail.com>
Date: Thu, 05 Nov 2026 09:01:01 -0500
Subject: [PATCH] gpu: host1x: document the remaining host1x_bo_ops
 callbacks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-kdoc-host1x-bo-ops-v1-1-cc171c9e36a0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAByM7GoC/yXMQQqDQAxA0atI1gaMOhV6leJiZow1LRiZ2CKId
 3dql2/x/w7GSdjgXuyQ+CsmOmdQWUCc/PxklCEb6qq+EVUO34NGnNRW2jAo6mLYee5841w7BoI
 cLolH2a7po//bPuHFcf2d4DhOU1EOy3YAAAA=
X-Change-ID: 20261105-kdoc-host1x-bo-ops-7ae7a3554fb1
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Amit Patole <amit.patole@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

Commit 3cbf5e3c46e6 ("gpu: host1x: Allow entries in BO caches to be
freed") added a kernel-doc comment for struct host1x_bo_ops that only
describes the .pin and .unpin callbacks. Since include/linux/host1x.h
is pulled into Documentation/gpu/tegra.rst, this produces four
kernel-doc warnings during the htmldocs build:

  include/linux/host1x.h:159 struct member 'get' not described in 'host1x_bo_ops'
  include/linux/host1x.h:159 struct member 'put' not described in 'host1x_bo_ops'
  include/linux/host1x.h:159 struct member 'mmap' not described in 'host1x_bo_ops'
  include/linux/host1x.h:159 struct member 'munmap' not described in 'host1x_bo_ops'

Describe .get, .put, .mmap and .munmap, based on how they are used by
host1x_bo_get(), host1x_bo_put(), host1x_bo_mmap() and
host1x_bo_munmap(), and on the Tegra DRM implementations in
drivers/gpu/drm/tegra/gem.c.

The warnings were found by running scripts/kernel-doc over the headers
pulled into the htmldocs build. An AI coding assistant (Claude Opus
5.5) was used to locate the warnings and draft this change; it was
verified with scripts/kernel-doc (no warnings left) and checkpatch.

Fixes: 3cbf5e3c46e6 ("gpu: host1x: Allow entries in BO caches to be freed")
Signed-off-by: Amit Patole <amit.patole@gmail.com>
---
Comment-only change. Built with W=1 on x86_64 (drivers/gpu/host1x/,
COMPILE_TEST) with no new warnings.
---
 include/linux/host1x.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index e7ba601b2afb..7027adb9bff5 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -146,8 +146,12 @@ static inline struct host1x_bo_mapping *to_host1x_bo_mapping(struct kref *ref)
 /**
  * struct host1x_bo_ops - operations implemented by a host1x_bo provider
  *
+ * @get: take a reference to the bo and return it.
+ * @put: drop a reference to the bo.
  * @pin: create a DMA mapping. Implementation must not touch the bo's refcount.
  * @unpin: destroy a DMA mapping. Implementation must not touch the bo's refcount.
+ * @mmap: map the bo into the kernel's address space and return the address.
+ * @munmap: unmap a kernel mapping previously returned by @mmap.
  */
 struct host1x_bo_ops {
 	struct host1x_bo *(*get)(struct host1x_bo *bo);

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261105-kdoc-host1x-bo-ops-7ae7a3554fb1

Best regards,
--  
Amit Patole <amit.patole@gmail.com>

