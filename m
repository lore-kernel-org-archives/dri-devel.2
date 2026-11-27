Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E011606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImKm0uk4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60C31129CF;
	Fri, 27 Nov 2026 10:20:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC821129D4;
 Fri, 27 Nov 2026 10:20:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 327FC417A8;
 Fri, 27 Nov 2026 10:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA78A1F00925;
 Fri, 27 Nov 2026 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774845;
 bh=eKMhP9nUIJHIhP+6Zbg0A5RYBnJOUES6EU29xJ7w5Nk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ImKm0uk4YNABStVNvlUYviuSYraNdLsFtMoD9VAXloG8OBlqzDMZ1kkMBxs/lClju
 BFaMguKuuVoken+4HZoI0hGF1AdGkdo0dePWwrXd+MhRUY5jGeH990o47EnkMh38Xw
 WKq8pv4NBinlexpquQPtvZA2KbaZDEynHM+ncwRqIGHe2ePnoMYODOoGsD1WiB52Ij
 28UHFnoVuOeP4Nie7ZTEUmYJt67INmG4g0yG7Y7h2JSitBd9yBY99CXqRDyJGqbJaa
 Q9BgX6NfPS5PZrbHhCDa3z31ZDODRiZcXltD7F54iuJg3CyWMJO+vDm9er8AAgoVNT
 Sf8LxTaGwWrag==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ruslan Vagner <rusya92266@gmail.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [RFC PATCH 7/8] drm/i915: Remove TIMESTAMP bit
Date: Fri, 27 Nov 2026 11:18:12 +0100
Message-ID: <20261127101812.2706432-9-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127101812.2706432-2-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
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

i915 seems to have built its own half-copy of parts of the dma_buf
subsystem. This includes interferences with dma_fences' timestamp bit,
which does not provide memory ordering and which does not seem to serve
a clear purpose in i915.

Remove the set_bit().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index c10ac0ab3bfa..a43d774ba779 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -138,7 +138,6 @@ static void
 __dma_fence_signal__timestamp(struct dma_fence *fence, ktime_t timestamp)
 {
 	fence->timestamp = timestamp;
-	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
 	trace_dma_fence_signaled(fence);
 }
 
-- 
2.56.0

