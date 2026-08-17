Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27372C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E2B10E8AC;
	Mon, 17 Aug 2026 17:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vgm6nGYx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6059810E780
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:22:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DCC044015;
 Mon, 17 Aug 2026 17:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AE43C2BCF6;
 Mon, 17 Aug 2026 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786987351;
 bh=RVVE5r0NGUE4k5ybuOlp+7aHs2IlhNHimZ4YfYSSYDE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Vgm6nGYxPCpnhsPyBgdcgF8JbuxFF/gy/YpTLAh4AKZLyV0AmkmhdqB4ijiDN8khe
 d340Rr/KNdjeRaI8m59OUPzO92PqxbPW8i3f3zry1G9MtF/bAX8+tbShkp742iWpyO
 WfY44+cLHZhbzyyWPz6Txlra1l3JKspyLvgK3BBASHhU+Z2E2AFGwEvsJ7yhzVerx1
 5v5mnOrdoDy/qA8hk+7aDRJ6j9GQ2IwAj2VkSCRpYdCvRZcljSxlE7ex2jcvYIfaQ6
 d5uQdEcENIC0s+Px4jfZxngrNy+jKzR6HQvWyTgsY4H/zIr9QwVXyJZkBEMtkk1avG
 4kb03jlxCo8oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 56928C5B572;
 Mon, 17 Aug 2026 17:22:31 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 17 Aug 2026 11:22:20 -0600
Subject: [PATCH 6/9] locking/lockdep: Fallback to folio_pool in
 alloc_list_entry when static pool is full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-folio-pool-v1-v1-6-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
In-Reply-To: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boqun Feng <boqun@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: netfilter-devel@vger.kernel.org, bpf@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, coreteam@netfilter.org, netdev@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786987349; l=4052;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Hw9H0XS3lRz/8Cusmj0TdRoN7GOnkgdGE/QpF+OTKZE=;
 b=7ApQuwEsLmNusDVgP3wGCUer5jWN1Mvb2G7RmfE1VdvcfA0Sc3zPBxPrhepGf2Qoooi58cGiI
 /JMtsQaQwZxAKM58qj6awvp+EWf0JxWRjrcSmYqhuYL91ZsT2xJmsy6
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
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
Reply-To: jim.cromie@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jim Cromie <jim.cromie@gmail.com>

Use struct folio_pool to dynamically expand lock dependency storage when
the static list_entries pool is exhausted, avoiding premature lockdep
disabling.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/locking/lockdep.c           | 35 ++++++++++++++++++++++++++++++++++-
 kernel/locking/lockdep_internals.h |  2 ++
 kernel/locking/lockdep_proc.c      | 16 ++++++++++++++--
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2d4c5bab5af8..f0f58db090ff 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -58,12 +58,37 @@
 #include <linux/context_tracking.h>
 #include <linux/console.h>
 #include <linux/kasan.h>
+#include <linux/folio_pool.h>
+
+DEFINE_STATIC_KEY_TRUE(lockdep_pool_key);
+static struct folio_pool lockdep_pool =
+	FOLIO_POOL_INIT_KEY(lockdep_pool, sizeof(struct lock_list),
+			    FOLIO_POOL_64K_ORDER, &lockdep_pool_key);
+
+static int __init setup_lockdep_folio_pool(char *str)
+{
+	bool enable;
+
+	if (!kstrtobool(str, &enable)) {
+		if (enable)
+			static_branch_enable(&lockdep_pool_key);
+		else
+			static_branch_disable(&lockdep_pool_key);
+	}
+	return 1;
+}
+__setup("lockdep.folio_pool=", setup_lockdep_folio_pool);
 
 #include <asm/sections.h>
 
 #include "lockdep_internals.h"
 #include "lock_events.h"
 
+void lockdep_pool_stats(unsigned int *nr_chunks, size_t *chunk_size, size_t *tail_used)
+{
+	folio_pool_stats(&lockdep_pool, nr_chunks, chunk_size, tail_used);
+}
+
 #include <trace/events/lock.h>
 
 #ifdef CONFIG_PROVE_LOCKING
@@ -1404,11 +1429,19 @@ static struct lock_list *alloc_list_entry(void)
 				      ARRAY_SIZE(list_entries));
 
 	if (idx >= ARRAY_SIZE(list_entries)) {
+		struct lock_list *p;
+
+		p = folio_pool_alloc_type(&lockdep_pool, struct lock_list,
+					  GFP_ATOMIC);
+		if (p) {
+			nr_list_entries++;
+			return p;
+		}
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
 		nbcon_cpu_emergency_enter();
-		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
+		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low and folio_pool exhausted!");
 		dump_stack();
 		nbcon_cpu_emergency_exit();
 		return NULL;
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 0e5e6ffe91a3..f802160c0dd5 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -159,6 +159,8 @@ extern unsigned long max_lock_class_idx;
 extern struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 extern unsigned long lock_classes_in_use[];
 
+void lockdep_pool_stats(unsigned int *nr_chunks, size_t *chunk_size, size_t *tail_used);
+
 #ifdef CONFIG_PROVE_LOCKING
 extern unsigned long lockdep_count_forward_deps(struct lock_class *);
 extern unsigned long lockdep_count_backward_deps(struct lock_class *);
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 1916db9aa46b..3e6f24ae9b34 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -288,8 +288,20 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 			nr_lock_classes, MAX_LOCKDEP_KEYS);
 	seq_printf(m, " dynamic-keys:                  %11lu\n",
 			nr_dynamic_keys);
-	seq_printf(m, " direct dependencies:           %11lu [max: %lu]\n",
-			nr_list_entries, MAX_LOCKDEP_ENTRIES);
+	{
+		unsigned int fp_chunks = 0;
+		size_t fp_chunk_sz = 0, fp_tail_used = 0;
+
+		lockdep_pool_stats(&fp_chunks, &fp_chunk_sz, &fp_tail_used);
+		if (fp_chunks) {
+			seq_printf(m, " direct dependencies:           %11lu [dynamic: %u x %zu kB, tail: %zu kB/%zu kB]\n",
+				   nr_list_entries, fp_chunks, fp_chunk_sz / 1024,
+				   fp_tail_used / 1024, fp_chunk_sz / 1024);
+		} else {
+			seq_printf(m, " direct dependencies:           %11lu [max: %lu]\n",
+				   nr_list_entries, MAX_LOCKDEP_ENTRIES);
+		}
+	}
 	seq_printf(m, " indirect dependencies:         %11lu\n",
 			sum_forward_deps);
 

-- 
2.55.0


