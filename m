Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9246C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E39710E247;
	Tue, 15 Sep 2026 06:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Se+dNEfw";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D912710E257
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 06:29:31 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cebcb8d7so615028a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789453771; x=1790058571; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jliu2qQ+Am9D5/J1PCi8w8fiwrrDcbTYHcV6N7E5S9c=;
 b=Se+dNEfwzZSB74zLBYqJaiI/+pVmYI5jiO6DOydOGMG1cWOV941sywuQhC4JbyDMED
 0FnfTdh6AKRpjBRL4CEcsc9sfMJBjS/UAagV6ymnRkHe/rPoVIMQQPuqIOsQfQQ866PW
 fErs6Hj+88tj1Mgv1KVF0J9TB0zcsBB4VcRRWNeQRi+HluRnSixSW8/6kc8s1y07gH6w
 3mbdjb+tP4EOIUhrbVrr4Fix6EQgGhgSM+8egI1GVlsEsaQWx5z3/Ie27s/a01GYVjcw
 g0FHimY2WsIe+r+oqwjEtRUEo4tyYoQ67qahoUepIl8G/o3a83ywXLbNg9rzWI9UWKl/
 HS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789453771; x=1790058571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jliu2qQ+Am9D5/J1PCi8w8fiwrrDcbTYHcV6N7E5S9c=;
 b=Y13LBxzVGku1ZxguiJPZ8jxv2joGTxl07gQ35nF2A7QjA/HrVaNp6izay7ELm8EOCE
 V3j4AxPNmleIDD2/UO6g/5qWSMgASoeHcLkAYZA1Iqo5lIsikzjMUFbFGQ6LHdCL9os6
 eX3Qy9WI862MV06ESyQzpQTpF+CfXEqiNQ09ICdleQE6AH9UWhBD4sLjGRpgAiAtWefx
 lafvfTqDiYDyWcXsGwz0ug9s+w/dyiRBr6R1ME2QOf02+PZdufQTIH7UESvnZRH7RqP2
 SHDcgvSxgW9fbY3NXq8ml8VC5ySlC+XI30ZXujxuwiKuG4q6dh+zQQCfuauMVbIfQ0Ru
 5vHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhUbatwmSNGKZJuUuy0TKuobaXDoNLyk3r1hqw1M5mNRZupIun7WWw9h6niwJWQo6ghUEhLhC8jo8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k9JqG2Qy8JI2d2J31GUtnXYwSdTC/fupAS9u1xmjLqHqVeSbwS
 y0CjYBZMHMZM+jYa45Ikj5HKiE9K3q/cLZaE8GUjqHVD+upSL7b2MjKb
X-Gm-Gg: AYBFou2m3gMbn1RHwDtsdRY8B5J7W95IvzWIMk/5QI4OEn2yqISiCyCdYWF6hHagHXY
 QZE0fEE5bhQGLSE8lPAx2tih74ocF1TrGAVrn6ipiMlwhH5Ij55ADuiKjDDrG88Dex3QHsz9z/8
 veV/vV2xVTd0FI9gGVrst4PxMC+Xg15tBnypJtxBGRgzARS+aziNsuiRN0ccB04AjLbccMPvhU5
 f143tBisV8dFyTmCo8N4jaAHJ5IIgSRq7v/6006a2u3qVrkV5WnWPH9kD/88SDHdHXmK1s4B8MX
 3HNYEnYKEBIEZ/iQPsvBMtadR0C1g82T5EKUeduQPwQqm8c2VPua53K8Oms8+SU40Gsss2wAPKg
 LPppmTDeXmQAhuDGA5+m2AQ075L10BjJiPxVVCuYvWeqy0VO5M44BRUZWjlmJp8iCMhhRrhP/G0
 UUJ9LlWUk7FiaRtdTkLSlzPqqkqr87a/RxJ1X/MXIhUu1AEYv//jLCCAI72lVhJhJv29KXzOiR7
 xkc8xACFbQdLGe4torTOu+L1KopFpk1+ibp3TNhQNgl1LWjNBa1m83En7la500JIQ+FvP7bpQSd
 IE2sWzfTRFCEza+MBcXGDT8yQXPxXbs2+RFTxgq6+NtUPs2oInD6ggrIoZf94lyV
X-Received: by 2002:a05:6a21:3382:b0:39c:4e62:b843 with SMTP id
 adf61e73a8af0-3db5005bb45mr4318757637.10.1789453771209; 
 Mon, 14 Sep 2026 23:29:31 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c6549d95sm6031973a12.12.2026.09.14.23.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 23:29:30 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Brauner <brauner@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/i915: size shmem writeback budget to the object
Date: Tue, 15 Sep 2026 14:29:24 +0800
Message-ID: <20260915062924.2410550-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Before the writeback_iter() conversion, __shmem_writeback() walked the
object's page indices using its size argument. The conversion retained
nr_to_write = SWAP_CLUSTER_MAX, which the old loop did not enforce.

writeback_iter() consumes that budget for each folio and stops when it
is exhausted in WB_SYNC_NONE mode. Explicit writeback of larger objects
can therefore stop after only 32 base pages, leaving later dirty folios
unvisited. Mapped folios also consume the budget despite being skipped.

Use the supplied object size to set the page budget, restoring the
object-sized writeback attempt. Writeback remains best-effort; this does
not guarantee that every page is written or freed.

Fixes: 776a853a43c9 ("i915: Use writeback_iter()")
Link: https://lore.kernel.org/all/20260914111511.648711F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Thanks to Sashiko for pointing out the writeback-budget issue.

This is a separate follow-up to the folio-unlock fix and applies
independently. Compile-tested on x86-64 with CONFIG_DRM_I915=m.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index e7b18f7f9644..5751bd25c2b2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -308,7 +308,7 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 {
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
-		.nr_to_write = SWAP_CLUSTER_MAX,
+		.nr_to_write = size >> PAGE_SHIFT,
 		.range_start = 0,
 		.range_end = LLONG_MAX,
 	};
-- 
2.55.0

