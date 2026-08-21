Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4E9C5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8512110E499;
	Sun, 23 Aug 2026 09:27:24 +0000 (UTC)
X-Greylist: delayed 579 seconds by postgrey-1.36 at gabe;
 Fri, 21 Aug 2026 09:29:14 UTC
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D69810F281
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:29:14 +0000 (UTC)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id F36051EAA53; Fri, 21 Aug 2026 17:19:31 +0800 (AWST)
Received: from shelley.lan (unknown [IPv6:2001:8003:8802:7000::41b])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 689E11EAA47;
 Fri, 21 Aug 2026 17:19:29 +0800 (AWST)
From: David Gow <david@ingeniumdigital.com>
To: Jim Cromie <jim.cromie@gmail.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: David Gow <david@davidgow.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] linux/log2.h: Add round{up,down}_pow_of_two64()
Date: Fri, 21 Aug 2026 17:19:14 +0800
Message-ID: <20260821091918.1902032-1-david@ingeniumdigital.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

From: David Gow <david@davidgow.net>

The existing roundup_pow_of_two() and rounddown_pow_of_two() functions work
on values of type unsigned long, which is 32-bit on 32-bit systems. There
are cases (most notably in the GPU buddy allocator) which always operate on
64-bit values (as a 32-bit host can still use a GPU which internally has
64-bit addresses).

Add a version of these which always operate on a 64-bit value. These have
the (unimaginative) names roundup_pow_of_two64() and
rounddown_pow_of_two64(), and otherwise work identically to their unsigned
long counterparts. They are a bit ugly, but better than everyone hardcoding
calls to ilog2() -- which does handle 64-bit values -- directly.

Signed-off-by: David Gow <david@davidgow.net>
---

Hi all,

This series is basically a reworked and rebased version of
https://lore.kernel.org/all/20260326185413.1205870-40-jim.cromie@gmail.com/

Most importantly, the drm_test_buddy_alloc_exceeds_max_order KUnit test
was failing in linux-next on 32-bit systems, which this series fixes.

In rebasing it, I decided to add these helper functions, rather than
having an open-coded round{up,down} implementation in the buddy allocator,
but if no-one thinks it's worth having these for (at the moment) just one
user, I'm not too worried either way.

Cheers,
-- David

---
 include/linux/log2.h | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index e17ceb32e0c9..67446d5ce9a3 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -195,6 +195,63 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 	__rounddown_pow_of_two(n)		\
  )
 
+/**
+ * __rounddown_pow_of_two64() - round a 64-bit value down to nearest power of two
+ * @n: value to round up
+ */
+static inline __attribute_const__
+u64 __rounddown_pow_of_two64(u64 n)
+{
+	return 1ULL << ilog2(n);
+}
+
+/**
+ * rounddown_pow_of_two64 - round a 64-bit value down to nearest power of two
+ * @n: parameter
+ *
+ * round the given value down to the nearest power of two
+ * - this always operates on 64-bit values, even on 32-bit systems
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define rounddown_pow_of_two64(n)		\
+(						\
+	__builtin_constant_p(n) ? (		\
+		((n) == 1) ? 1ULL :		\
+		(1ULL << ilog2((n)))		\
+				   ) :		\
+	__rounddown_pow_of_two64(n)		\
+)
+
+
+/**
+ * __roundup_pow_of_two64() - round a 64-bit value up to nearest power of two
+ * @n: value to round up
+ */
+static inline __attribute_const__
+u64 __roundup_pow_of_two64(u64 n)
+{
+	return 1ULL << (ilog2(n - 1) + 1);
+}
+
+/**
+ * roundup_pow_of_two64 - round a 64-bit value up to nearest power of two
+ * @n: parameter
+ *
+ * round the given value up to the nearest power of two
+ * - this always operates on 64-bit values, even on 32-bit systems
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two64(n)			\
+(						\
+	__builtin_constant_p(n) ? (		\
+		((n) == 1) ? 1ULL :		\
+		(1ULL << (ilog2((n) - 1) + 1))	\
+				   ) :		\
+	__roundup_pow_of_two64(n)		\
+)
+
 static inline __attribute_const__
 int __order_base_2(unsigned long n)
 {
-- 
2.55.0

