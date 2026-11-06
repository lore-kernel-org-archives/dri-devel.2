Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009D606A332
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIJ9MBZz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D704112E08;
	Fri,  6 Nov 2026 14:10:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B20112E08
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:10:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0971A43C64;
 Fri,  6 Nov 2026 14:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B29A1F008A6;
 Fri,  6 Nov 2026 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974209;
 bh=7qoeOCwcbAlvTBPcx9yQQNBwlzgqLb6BVjDnL4j1bZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FIJ9MBZz8tgAkGuuOjwDJzH8xt1FNx7U6yxuD14Az4zgMnWlMATxtWeAzKBbnxPry
 5/WKCqgzHzzj6tXdzujJa+gRuE/HehR5EPD7EQdkxH7nUCtGCaNfclJUX6bnfsG/Na
 uXo7vE7yd1pl8gCjlEnt0Ghe8mNVqwUd/tEruZ2G9e0YOVKtvk24xKQOx6pWQ4jtk2
 Hv527qXg3xPAQZEmHU0QHObEF+2/7VRmukLeBpZDocfUw21A4jSjWUlvIgwrk7bsI2
 xrE/Rs9NTVU7VQ3egxi4c+8lfBx/VQYyOFjLnpxNgm/WDKewFEumlKdizEg2Fpas4L
 oDKmQxqUG89mA==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Matthew Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 8/8] MAINTAINERS: Add drm::JobQueue to drm_sched's entry
Date: Fri,  6 Nov 2026 15:07:53 +0100
Message-ID: <20261106140752.520386-10-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106140752.520386-2-phasta@kernel.org>
References: <20261106140752.520386-2-phasta@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DRM subsystem now provides drm::JobQueue, a Rust dependency manager
and load balancer for GPUs with firmware scheduling. Since it resides in
the same problem space as drm_sched, it is reasonable to maintain it
through a common entry.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 19818be10616..5cb896c4e0eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9267,6 +9267,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/scheduler/
 F:	include/drm/gpu_scheduler.h
 F:	include/drm/spsc_queue.h
+F:	rust/kernel/drm/job_queue.rs
 
 DRM GPUVM
 M:	Danilo Krummrich <dakr@kernel.org>
-- 
2.56.0

