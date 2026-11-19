Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840E60A261B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hq/Vi7SU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DC0112412;
	Thu, 19 Nov 2026 13:42:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7403A112410
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:42:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEF3763707;
 Thu, 19 Nov 2026 13:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8043E1F000C9;
 Thu, 19 Nov 2026 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795095770;
 bh=6ACBWYhco6iUyk86M6ZeVBft2fDb7VqeF5xQEolIGhw=;
 h=From:To:Cc:Subject:Date;
 b=Hq/Vi7SURRQ4G0CFNT6KNjDS4l9SdlvxkpT8g0q5tQKl7S0JSbJwXwm3qiNqj2pH1
 pr8RY47z4+iwOFncXy+4enYCcDES/++ypN+1SPfagDseZztJiiyq4UEw9PGZyOzXEC
 oIJeWwI0zhKmpd+5fKTwOMIG5co5LhUACmU4eJE5RZmd8ADu8aPsTyAwCLPsnovGpv
 /9r4WKGGlQf2bw1XIqDdP/ZXAH/9nVkMzPGkWFGpucFwsUWAi+Tpywksm2/Su6ZrmP
 FxrjO+DCxprHcytRiY2x3gR8X4P3w6OBcg4IUmMrnlgtM/WWnaVSkUh84xO0ipQdQ8
 Br8XCiUVKpjZA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfauth.ams.internal (Postfix) with ESMTP id 9F7AF198003A;
 Thu, 19 Nov 2026 08:42:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 08:42:48 -0500
X-ME-Sender: <xms:1vz-arAWbA3JNCA5qRsM1QaX5aSLpDW1bhNL-e5w0Yop4BI74SI4Yw>
 <xme:1vz-at2SKQvAQAcNroSohzSmIRgZSM8dwvqXOm7EuaHE49RCSwbFOFzZoqT4o9T8Q
 vLGFZzXrDAAs2XqVc9F6yY7HRaCYA5d1d8c_X-9pPxMdo63FN43NR-A>
X-ME-Received: <xmr:1vz-aoO4V94YCmqMyAziKoVD06qGXjCrnuMVgnisbRMNFa8yO9nbWSGkiVU>
X-ME-Proxy-Cause: dmFkZTE00JGDJwFuizNjyrkcP9E3XGTxdCScKzw0WQL1sclgiRqNMY2HriNnib5wcvvs22
 Rrwbz4qEEZ+3QOrWPBhBhkiA0pSYhuImPR+ZEfxUIsofjgQp2nAaPLgDDTLlSOEqBYYsJA
 QlC0VKBofHq11WhrU/5P8ZCgqaTV9Uj2UsJVuePZ86Q53AhiOcFYtEL42tSN+l/MAgMYUa
 gFRgiJbEMWKVciOs6z+FFSTI8EVWt5U88cq68qk0KksjbbSZqGaRHTOaast1of5wy4Yk9W
 gNEcgL51Z9xmnevSNhZCPjykNnfq9g5zBEfIzSNVPky8JfYH3TmkT2L+QSY6LoQe/WuxQk
 mvJFZpqgfCMtDVAw7H6mrjKYz6/YeRSrmY5DRLfUEeXmZ9SfcKLkOCWJGsoycmlRSGzddu
 +AkDV2HRe2mL8Mx/toLDoH2Bgpxs0j3W/sgQKfz7PbRdYqb8N0Erpzx36Zz3fHZE2XYpk0
 DlPbh2JlWc3pUEJPfaZaDfHjn3aMUuFO+1HwGTCj1E3gGGcOJIuIQYXDezGiQZ5zyYjFqH
 SihlIF5hY4H67V4SRUGqtdozY5Yp5QefAziPge9ODLU87eABw/FZOCu55V0QJragBgvSXY
 ku4Q0VQ4oeNfrpECsNH03dyCZPVbj5wpNjUUkmhdopjxIJDzIyqJFpv9P7Iw
X-ME-Proxy: <xmx:1vz-aq4AKHexI-K2Vhw2nq5VD7A344l0jed_dTBA2npOSMeTwdtq2A>
 <xmx:1vz-alY67vPB10Agk-LdVuEHe3DhxQ5OHhgHPCd4PmaTIqy3yfoZig>
 <xmx:1vz-anHzxWK_8KjZxZJ1Q60h7pGPvvw4_tuj49EWLIR_REf1XhFdQg>
 <xmx:1vz-aunf613BeKx1fSsraxwz3ds3ntkswBWT_g3B0H5TCtFiIaOKwQ>
 <xmx:1vz-aulHjv7xH2_MzrzR_X3w90D0VWjzOxSqQwCt-xB1qQdTLq_u4c0f>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 08:42:45 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] drm/i915/gem: Skip writeback of shmem folios with extra
 references
Date: Thu, 19 Nov 2026 13:42:41 +0000
Message-ID: <20261119134243.3745282-1-kas@kernel.org>
X-Mailer: git-send-email 2.56.0
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__shmem_writeback() writes out every dirty folio that is not mapped. A
folio stops being mapped when munmap() removes its rmap, but the TLB
flush comes later. Until then another thread can still store to it
through a stale TLB entry:

    CPU0 (munmap)            CPU1 (same mm)       CPU2 (i915 shrinker)
    zap_huge_pmd()
      folio_remove_rmap_pmd()
                                                  __shmem_writeback()
                                                    clear dirty
                                                    !folio_mapped()
                                                    shmem_write_folio()
                             store via stale TLB
    tlb_finish_mmu()

The store leaves the folio clean in the swap cache. Once reclaim frees
it, the object reads back from swap without that store.

The legacy mmap ioctl maps the shmem file directly, and i915 mounts it
with huge=within_size on some platforms, so the folio can be PMD-mapped.
The core mm keeps the rmap until after the flush for PTEs, but not for
shmem PMDs: shmem has no writeback, and pageout() refuses a folio with
an extra reference.

Do the same here. The unmapping side holds its reference until the TLB
is flushed, so a folio with references beyond the page cache and
writeback_iter() is left to reclaim, as a mapped one already is.

Fixes: 2d6692e642e7 ("drm/i915: Start writeback from the shrinker")
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
Found while reviewing David's fix for the same race on file PMDs, which
leaves shmem out because shmem has no writeback:
https://patch.msgid.link/20261116-dirty_file_pmd-v2-2-571883053174@kernel.org

Build-tested only.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index bf9e7480f0f5..748772c358ac 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -316,9 +316,15 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 	 * leaving only CPU mmapings around) and add those folios to the LRU
 	 * instead of invoking writeback so they are aged and paged out
 	 * as normal.
+	 *
+	 * The same goes for a folio with references beyond the page cache
+	 * and writeback_iter(). A folio that was just unmapped can still be
+	 * written through a stale TLB entry until the unmapping side flushes
+	 * the TLB and drops its reference. pageout() checks the same.
 	 */
 	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
-		if (folio_mapped(folio))
+		if (folio_mapped(folio) ||
+		    folio_ref_count(folio) != 1 + folio_nr_pages(folio))
 			folio_redirty_for_writepage(&wbc, folio);
 		else
 			error = shmem_write_folio(folio);

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.54.0

