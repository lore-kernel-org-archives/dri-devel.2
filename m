Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3B606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HM4HKwBw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E069811239E;
	Thu, 12 Nov 2026 22:09:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35E7112396;
 Thu, 12 Nov 2026 22:09:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 751506248D;
 Thu, 12 Nov 2026 22:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555C61F000D4;
 Thu, 12 Nov 2026 22:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794521374;
 bh=Viwqy3ITQgBszpOy2nxIavh5Mt0ao4kMQc4DSQeToGo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HM4HKwBwenX5LPu3liCUHEMsEalytKn7ys2DDGNSBAMroq/1dFf/rVUIYBjFEHEpI
 hE/fY4rJBXGrrTOlj+FZDCzgZ/BtsewXoNR8UtSzaKL3UkvJ1GnU2uIWtxs8CtmBBW
 0qUUCKuerr+2hwfE4QZ3r9yCnSLDgkteS96rugzAyzmanEYhnXcnUEsXjy0yK3Id9c
 1d7fVZqky1H5uWLL9Z3pHvNpyENJfo+QwEDcpD3mU4gm8mDkSdZS36INIPyHwx5f4d
 gwGCNlnn5K6jpoD06i27gE2QSn1Iab7gBi1sgmvAemRpMKmkZuQiuX4NtlNV7WUC/I
 p0yh9C0dDrLeg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:08:59 +0100
Subject: [PATCH 3/5] drm/i915/selftests: request read access for mmap
 access tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-access_shite-v1-3-988a5c470db2@kernel.org>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
In-Reply-To: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Willy Tarreau <w@1wt.eu>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=david@kernel.org;
 h=from:subject:message-id; bh=UNHRKTPPJVrGYq3JL2OOfSiN8BE6XDeP4WdpR0zw48w=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+WfzXfSMdyle0+taS0KYbrY+ZzNvWegtJcp07d9F1o
 8y9imPFHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkkzEjw1dWKyPrzb+96jf5
 r53V6B4zxaXk36Gv5ozRBdwzOZ5LsDMyfDYz6l6worxt7dyFeduun10lZLpV2HND/cMu4aMaMY/
 7uAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__igt_mmap_access() reads the buffer with access_process_vm() without
FOLL_FORCE, but creates the mapping with only PROT_WRITE. Request
PROT_READ as well so the test remains valid when we fix the ->access
fallback to properly check VMA access permissions.

Fixes: 9f909e215fea ("drm/i915: Implement vm_ops->access for gdb access into mmaps")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 303be698891fd..d9c828032a1aa 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1460,7 +1460,8 @@ static int __igt_mmap_access(struct drm_i915_private *i915,
 	if (err)
 		return err;
 
-	addr = igt_mmap_offset(i915, offset, obj->base.size, PROT_WRITE, MAP_SHARED);
+	addr = igt_mmap_offset(i915, offset, obj->base.size,
+			       PROT_READ | PROT_WRITE, MAP_SHARED);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 	ptr = (unsigned long __user *)addr;

-- 
2.43.0

