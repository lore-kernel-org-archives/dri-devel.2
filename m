Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F0606A327
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lS0Rf170
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F2810E051;
	Wed, 21 Oct 2026 09:56:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF0710E051
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:56:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D03D601F1;
 Wed, 21 Oct 2026 09:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032901F000CA;
 Wed, 21 Oct 2026 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792576603;
 bh=EZCm0kE3titGYhKqRVn8yaTjCW0wvCcWPMDKwf1pgeE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lS0Rf170RqojOFfZUl03pobZ9QngXd5aL0EYku/6zFqBesXGJtuEKiEsgInSY4bKG
 T5rT6AIzTmZgbE9ZQaEx7VvWeIYCriUTbQV8tcGRWo0Pyv6DFlg4TsryjvrnrWgm+l
 aqq1uKQ5mB1BZ3tcjbnA2comYA57x+nkVzNSv+YmgXUW1NE9zLHS6dVW7t08ka6JNJ
 v65iQSUM49jDJYZvRApKFyxoUiU6CNZyRF10KhhGUQ8TvOzv0rUmG0dyGninbvpXAC
 rI/h0+wbwfTQEItJoM1QVG303LDx0htcwxYqogWH2p2GQo99yrK1whxwE0HvtFhvSD
 q7K3OnG9pI8Zg==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
Date: Wed, 21 Oct 2026 11:55:12 +0200
Message-ID: <20261021095512.1345191-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021095512.1345191-2-phasta@kernel.org>
References: <20261021095512.1345191-2-phasta@kernel.org>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel already has test_bit_acquire(). A set_bit_release(), however,
was missing so far. It can be expected to be useful for parties that
need release ordering, but not the stricter full ordering of the other
bit-setting functions.

Add set_bit_release().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/asm-generic/bitops/instrumented-atomic.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index c010d54275e4..fb2d1472fd4d 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -72,6 +72,20 @@ static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *ad
 	return arch_test_and_set_bit(nr, addr);
 }
 
+/**
+ * set_bit_release - Set a bit with release ordering
+ * @nr: Bit to set
+ * @addr: Address to start counting from
+ *
+ * This is an atomic ordered operation (implied write memory barrier).
+ */
+static __always_inline void set_bit_release(long nr, volatile unsigned long *addr)
+{
+	kcsan_wmb();
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	arch_set_bit(nr, addr);
+}
+
 /**
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
-- 
2.56.0

