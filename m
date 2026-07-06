Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B611C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3579710E7AC;
	Mon,  6 Jul 2026 07:13:30 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9420D10E758
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 06:19:49 +0000 (UTC)
X-AuditID: a67dfc5b-c2dff70000001609-e7-6a4b48fe92a2
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: max.byungchul.park@gmail.com, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
 linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
 joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
 duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
 willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
 gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
 hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
 jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, boqun.feng@gmail.com,
 longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
 yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com,
 her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com,
 andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
 samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org,
 urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, kees@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, mark.rutland@arm.com,
 ada.coupriediaz@arm.com, kristina.martsenko@arm.com,
 wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com,
 dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
 yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
 joel.granados@kernel.org, richard.weiyang@gmail.com,
 geert+renesas@glider.be, tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 2407018371@qq.com, dakr@kernel.org, miguel.ojeda.sandonis@gmail.com,
 neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
 dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: [PATCH v19 14/40] dept: apply sdt_might_sleep_{start,
 end}() to dma fence
Date: Mon,  6 Jul 2026 15:19:02 +0900
Message-Id: <20260706061928.66713-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxjFee99771tQ81NZ+KdLtHVOZ2Jui6OPVuMIzHbXj9iNPMvNc47
 uZFiQVIUZR9JnTDxA2xYCo4Klk0rokDXRlfAmopzaNVGqYMCdnyIXRps2aAFSwsOMP73e87J
 Oc8/R0arnjDzZdqcA5I+R9SpWQVWhFNrVqSs35j1flf7xxCLFmPojRUjGE+YaShqeolhsuxP
 DqLxHg5GbVMsmPoHWagIHcFQGTRzELr9BYR7WxjoHHuOwDo4RcGg+xiCyfJ9UGF6iKCmP0DD
 SKgPwTPjVRp8g3PgcWyYhfCjsxREbCxYfnAx8Oj+EIJgt4uCpr5mDswVRykw1bdQELfWTZ8P
 fAwM1FZykOzXQOC0CcPvhj4O7F23EdifdjBw3XUXg6/5LAsG8zgDjf/4Kejv8zPgNz5DUB/5
 hYWhMSsN1tgwB+1uCwWXXA9YsBVOd/44OsVAW4mbggvRCA2Pu1oQNAZv0TARcDLQUXaOBc+E
 h4KB0jAHpmQxCyeLyjEcGe1FUBXVQMQYZdLTyXhRKSZ1jmsUKWqfZMmV6iuIJCbKECl0HCKu
 MQsm549PUKSpMsARi/0gKfwjzBBH7XLy6/UQRex1x1kS8Xo5cudMAm95Z7tiTYak0+ZL+lVr
 dysy7/zm4XJPKg97jZsN6LniBJLLBH61kDS3UK95IOBFM8zySwW/P07P8Fx+keAoCTInkEJG
 876FwilrCZ4x3uC3Cq5YzSxjfolQ7zw6G1DyaYLnrwvMq9KFwmWbe1aXT+sNyarZZyr+Q6Fn
 uA3PlAq8WS50TD3FrwJvCjdr/diIlBaUUodU2pz8bFGrW70ysyBHe3jlnv3ZdjS9Oev3yR1O
 NPLwy1bEy5A6VQnpG7JUjJifV5DdigQZrZ6rfHfZxiyVMkMs+EbS7/9Kf1An5bWiBTKsnqf8
 YOxQhorfKx6Q9klSrqR/7VIy+XwD2vrTxbfVT9Le27TXsLkx4TWuTesc+rn02+4NWLvlfE1P
 4ZqqTy5eI7mf0l+Xt/EZV2nNNuq/7wynO1+Y0nYEOyTw+Hbdu4T/rWcWH2sIOV6kNnTrdKcW
 BG6J1LrE5xXNmt3xj+7+Xd19Y2SnM+Ut90u+OZ6bcASdlfLPtqeuElfY1DgvU9Qsp/V54v91
 A44/bwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+793V4vXJfhSdGFQRqBdyDhhRH2I3i5aQdDlQznyrc07m5l2
 Id0amVpsi01qmtNyhC6vlVmOzEpt3VxmrotZsVbiysjN8DJtGn05/M7znOdwPhwGlzSScxlF
 aoagTJUlSykRIYqL0URO8NsSV3heLYE87Wn40Ocm4U1uCwF+Xx4BxTU2CgLmRhry6i+R0NGj
 JqCzugpBnz8PwZ8xMw7apkkCAoY2Gnwj72kw5iKYtLchMDkNOLg67+Ngu5mLwVDtBAUDD38j
 MH52U1DUn0vAoLUQwWWPmYb+x5vhR989EiZ7v2HQM+xFYHVPYOBuOYsgYEqC0vKGYNz0i4Kx
 5y9xKDJ2Iij73IvD7/5PCG62fURgv66m4KvuFg5d7tnw2j9IwRNjAQU/nMUY/KylwKK2k+B8
 NoCgxGxA4Hlnx0BztYYCU0k9AU2f7tLgHBjH4IPJgEFVfSz0WT0EPNWVY8Fzg1N14WAu0mDB
 8h0D4417GIxYK+kNFYj/o71A8JUNtzFe+ypA8bYrNsSPjRoQ76vQ4LxWF2wfegdx/kzDMb7i
 qZfiR/3dFG8fthC8o5zjr50bxXj980i+6XIvvXPjftG6BCFZkSkol6+PF8k76hx0eoE464Uu
 Lgd5RfkohOHY1dyX3hdoiik2gnO5RvApDmMXcQ3nPWQ+EjE427WQK7SeJ6aMOewuzu4vm2aC
 XczduKOZDojZNZyju4L8t3QhV1XbMq2HBPXq8RJsiiVsNPd+sJ3QIZEFzahEYYrUzBSZIjk6
 SpUkz05VZEUdSkupR8F3sp4a199Bvq7NrYhlkHSWGDZsTZSQskxVdkor4hhcGiZesnRbokSc
 IMs+LijTDiqPJguqVjSPIaTh4q17hHgJe0SWISQJQrqg/O9iTMjcHITtK744XFgQQVj8Fv05
 R+xQR/nsSqc5K59e2zgzRXJAGrUjdmgTPi/9UORiY0yNS4i+4Lqiljd/iehOaHpweDKincxR
 75aX6p22NaoE+UBB8/zQR6Gr3p40rEjTNZ+gAj79272jj3QutzdmdSnz4En3lu2O+GvLhfAF
 lva6uBlSQiWXrVyGK1Wyv//RwaZKAwAA
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:13:14 +0000
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

Make dept able to track dependencies by dma fence waits and signals.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 35afcfcac591..f7498c770035 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -16,6 +16,7 @@
 #include <linux/dma-fence.h>
 #include <linux/sched/signal.h>
 #include <linux/seq_file.h>
+#include <linux/dept_sdt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dma_fence.h>
@@ -822,6 +823,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
+	sdt_might_sleep_start(NULL);
 	while (!dma_fence_test_signaled_flag(fence) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -835,6 +837,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	if (!list_empty(&cb.base.node))
 		list_del(&cb.base.node);
@@ -924,6 +927,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
+	sdt_might_sleep_start(NULL);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -938,6 +942,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1

