Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2503EC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4134510EE41;
	Mon, 14 Sep 2026 13:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJM+t/54";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC0110ED4B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:56:12 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8692be1cda4so2496016b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789383372; x=1789988172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gj8h2lt98zX4NzJl96Knw548gSSkkGwsjExtVdozT0A=;
 b=ZJM+t/54UkS88PI+ugp+p4grc1x/wunR07RivP38z03zBSEmSug3m4qR0NJWknLB5b
 3O3lc1BIgn5TD3OZwwgjQxS/7+4SEw34LMfF6nFrwxfynbYD2nwYEYUZ3bR7Zvnugddp
 lg7HZfxjqpPOpvw03CjtotuUfcfSDJhel6jUVV8zSUOihSg8OVe1xelGBRyGT/+SM9tx
 1JJ992VX+Ul9fnsGwItivDlvopyaJtBEe0LpxdRt3bncH561IEkwCjRf8KXEmJ3sH5id
 BOD8ACBlulxqsZ7QBiWlg+/RPJogIRyNCbuXZpMBiqgkZUzoZKL7xTUX5lA0OSh2gz4P
 pikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789383372; x=1789988172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gj8h2lt98zX4NzJl96Knw548gSSkkGwsjExtVdozT0A=;
 b=MLNAzIjXuLz0RK0KF3F04LITrHOQXlyTIpvMErO5MtqMLC104H06g6ltcj1qtg5G6U
 jsLNtaxxvHSaj1kTccMQhzC7LobJcDosd4LktmcfcKvz37idgcOzTPSVWVoyLxdc5p/a
 4pqYy2pqBuERocrGuN03DuFmiVqJ9VI7ljVqUa3sdu3pmdJRHNu0sSid27IBKi39JnYV
 vf3yRr7iKEXTzDnlTtAPibtYmFFSDxC3wqqaAMp3NQNuyFzLnwUDJc+6O5YZLJl3OJtR
 ujtvhmq5FvRWHAw1j3zljq/ozgpCR3ft8eWIBSS+sATlrpFR+koZCDX9QERvnqiOhxKM
 Zbzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOuMZOZZV2MsM3AkndEgpX5Vi8VTT2FMYOeIfqO2N55OaUdcqoto/CxHkNrTOM/g2nCQfuvocjsW0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nqjDxhwoBOdX2Pt8bUtoQEkhdsXPYa70DibHPezrvM2eZW9Elw
 K4nZkigxs3m1sV1ZQwLrGd5g6TzDMNhkwU2/EyMiEXBPznLOZ7Ku73pJ
X-Gm-Gg: AYBFou2/+puwfVu9R06JyqUYno8dgqyyICFnOGQFoyMpTy6d6nlFXrE/QhVSFPGNZ4e
 c4N1Ocf0TigqR36eur3+v5QczW9TvjtV6qzm2NVnDG1ajxLf/ABtV91t4+cYTiJreSyxCgInbqM
 WfDmw2s8PF55AEAbgnZON0zU5Ojec42eQRIyTYExlYMhucA4Z98RPjB4SIX9kDt6fdCJ4lIImmg
 C80p4MtvzINBPLdy1TBU7ZeuiCZVbgJHOME97eIJ+FtByMC6eH61fIkOTX4WkfCVriEsonii53Q
 ZPT2GMoGkvPZev38+bW6LCv11tQQacyiVdvRtY16HGOkIH3gpvw15b5Ge+QDjX4/H8cJHJzhpPM
 lRF+zOkRzvkw76lm0UcKiWkIOEj7wGqPjLRyt4bnpQE/KI7bym5FBpZVXMP1/qeuon0ktx4w1mw
 0uXrNYWv3iIZav6D9VGwuOqW8iTd9hb4BdwOp3EAmVDB4V8AeN+uQH0wHcAYNt1k/VrTDvDySR6
 7BZuzzzEgtzEW6c3r00lZYA9xnBu/uZejKjlfblDr4EDOF14SRl6k9jwefBUp00tx6mF47r9jI6
 kcZZ1aKJN8SSWUgD4oqsxIk0ZPMJMIOlqa47AlzXX58aT1/DhtNbDL76kPjgU0c=
X-Received: by 2002:a05:6a00:438d:b0:86a:9be:6bf9 with SMTP id
 d2e1a72fcca58-86f85108442mr4695374b3a.12.1789383371846; 
 Mon, 14 Sep 2026 03:56:11 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b287c481asm4589354b3a.11.2026.09.14.03.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 03:56:11 -0700 (PDT)
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
Subject: [PATCH] drm/i915: unlock shmem folios after skipped writeback
Date: Mon, 14 Sep 2026 18:56:06 +0800
Message-ID: <20260914105606.3997649-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:10:56 +0000
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

writeback_iter() returns a locked folio.  The mapped-folio path redirties
the folio without unlocking it, so shrinking can leave the folio locked
indefinitely.

shmem_write_folio() can also return AOP_WRITEPAGE_ACTIVATE with the folio
locked.  Passing that positive control value back to writeback_iter()
triggers its warning, stops asynchronous writeback, and leaves the folio
locked.  This can occur when zswap rejects a folio while memcg zswap
writeback is disabled.

Unlock folios on both paths and consume AOP_WRITEPAGE_ACTIVATE so the
best-effort writeback scan can continue.

Fixes: 776a853a43c9 ("i915: Use writeback_iter()")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index ef9440166295..e7b18f7f9644 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -322,10 +322,16 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 	 * as normal.
 	 */
 	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
-		if (folio_mapped(folio))
+		if (folio_mapped(folio)) {
 			folio_redirty_for_writepage(&wbc, folio);
-		else
+			folio_unlock(folio);
+		} else {
 			error = shmem_write_folio(folio);
+			if (error == AOP_WRITEPAGE_ACTIVATE) {
+				folio_unlock(folio);
+				error = 0;
+			}
+		}
 	}
 }
 

base-commit: cbd3dafc2003db679ccd2f6c6a2551db79657049
-- 
2.55.0

