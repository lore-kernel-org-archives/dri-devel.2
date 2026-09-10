Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B20AC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C46A10F52D;
	Fri, 11 Sep 2026 07:50:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995F910F19B;
 Thu, 10 Sep 2026 23:39:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0F66601F0;
 Thu, 10 Sep 2026 23:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F0C1F000FF;
 Thu, 10 Sep 2026 23:39:52 +0000 (UTC)
From: Andi Shyti <andi@zenone.zhora.eu>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Cc: linux-stable <stable@vger.kernel.org>,
 Chris Wilson <chris.p.wilson@linux.intel.com>,
 Dmitriy Okunev <dokunevdmitriy@gmail.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] drm: i915: fix sizeof argument in reset_csb_pointers
Date: Fri, 11 Sep 2026 01:37:10 +0200
Message-ID: <20260910233711.2528459-1-andi@zenone.zhora.eu>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

From: Dmitriy Okunev <dokunevdmitriy@gmail.com>

In reset_csb_pointers(), drm_clflush_virt_range() is called with a size
calculated using sizeof(execlists->csb_status), which returns the size
of the pointer rather than the size of the object it points to. This
could lead to incomplete cache flushing on 32-bit systems where pointer
size differs from u64.

Replace sizeof(execlists->csb_status) with
sizeof(*execlists->csb_status).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dc0406820ee7 ("drm/i915/gt: Drop invalidate_csb_entries")
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
Cc: <stable@vger.kernel.org> # v5.19+
---
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index e693b0c9d2a3..9ac67a0cbb1f 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -2833,7 +2833,7 @@ static void reset_csb_pointers(struct intel_engine_cs *engine)
 	memset(execlists->csb_status, -1, (reset_value + 1) * sizeof(u64));
 	drm_clflush_virt_range(execlists->csb_status,
 			       execlists->csb_size *
-			       sizeof(execlists->csb_status));
+			       sizeof(*execlists->csb_status));
 
 	/* Once more for luck and our trusty paranoia */
 	ENGINE_WRITE(engine, RING_CONTEXT_STATUS_PTR,
-- 
2.55.0

