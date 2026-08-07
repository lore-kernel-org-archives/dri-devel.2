Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCFDC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53FF10F4E9;
	Fri,  7 Aug 2026 13:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cp0jaKCR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204A510F4E8
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:50:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE66143A4B;
 Fri,  7 Aug 2026 13:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132021F00A3A;
 Fri,  7 Aug 2026 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786110636;
 bh=4DjfwV4ACAZUpRZw8MHQBqFBcbFpqFXHuRpYH05Uydg=;
 h=From:Subject:Date:To:Cc;
 b=Cp0jaKCRDnHCNEKuRgGcimB5c/OcwG/zvo7mP0N4Fa133BwLaa7BHfpAZRKIILPo6
 7CjfGJ4tXc5ZG3JmqiAtktsJw0/1fbPBsODeqyAtXiuJqDiwy+0eT5ODBTu8Tvto1J
 Sbly6dpwQQkkx2IjEzzozvYHi9u+WDb/DN37BauhuqKeEnFPO9QYrWPkzwsUw2xf6b
 HmBujHQs0QlKI+EBXVHKerqIcDOGLAQ2/zICGf6VSpGoMMBboxC1LXehxtM6c/thcr
 OHFX3+PojipRuK5JkNDRNuB7hsPb7TdGzpFKFcjYwMIAEj34A+3zHg8LCJ+q7tdjLg
 HT0JC6CyGz4uw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH RFC 0/5] allow kfree_nolock() handle kmalloc() objects
Date: Fri, 07 Aug 2026 15:50:26 +0200
Message-Id: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLidWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2MD3ey0otTU+Lz8nPzk7Pjs3MQcIEPXzMDM3NDcIC3FNDFFCai1oCg
 1LbMCbGy0UpCbs1IsRLC4NCkrNbkEZKBSbS0APFcePH0AAAA=
X-Change-ID: 20260730-kfree_nolock_kmalloc-6067170fd5ad
To: Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, bpf@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Dmitry Vyukov <dvyukov@google.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kasan-dev@googlegroups.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
 Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-rt-devel@lists.linux.dev, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2
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

This is an initial RFC for something that could target 7.4 and
definitely not earlier merge window. Based on
slab/for-7.3/kfree_rcu_nolock

Currently kfree_nolock() can only handle objects from kmalloc_nolock().
Removing this restriction means an easier to use API and might be useful
in some situations. It means dealing properly with kfence, kmemleak and
large kmalloc allocations. Some of the cases may end up being deferred
to the irq_wor() but that's not a big issue.

As a example of usefullness, convert a kfree_rcu() to kfree_nolock() in
the scheduler code, where kfree_rcu() has been used as a workaround for
kfree() being unsafe to call under pi_lock.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
Vlastimil Babka (SUSE) (5):
      mm/slab: cleanup deferred free handling
      mm/slab, kfence: support kfence objects in kfree_nolock()
      mm/slab, kmemleak: handle kmemleak freeing in kfree_nolock()
      mm/slab: handle large_kmalloc objects in kfree_nolock()
      sched: use kfree_nolock() instead of kfree_rcu()

 include/linux/kfence.h   |   5 ++
 include/linux/kmemleak.h |  17 +++++
 kernel/sched/core.c      |   9 +--
 kernel/sched/sched.h     |   7 +--
 mm/kfence/core.c         |  14 +++++
 mm/kfence/kfence.h       |   5 +-
 mm/kmemleak.c            |  42 +++++++++++++
 mm/slub.c                | 157 +++++++++++++++++++++++++++++++++++++++--------
 8 files changed, 215 insertions(+), 41 deletions(-)
---
base-commit: 648294a02bfcd0eddae51877e3b30f8bbb2d4bb6
change-id: 20260730-kfree_nolock_kmalloc-6067170fd5ad

