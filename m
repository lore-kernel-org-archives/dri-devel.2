Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D47C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82D110E9D2;
	Tue, 18 Aug 2026 03:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="WlJhW4ID";
	dkim-atps=neutral
X-Greylist: delayed 2167 seconds by postgrey-1.36 at gabe;
 Tue, 18 Aug 2026 03:51:32 UTC
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C32C10E9D2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:51:32 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=QPjkqeMQzOAZpb/zyY52x+vxw+KmNvb6bRJRhWPK3mw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787025090; v=1; x=1787629890;
 b=WlJhW4ID+yh1ysREDhUC5UY1/mZXIYmqe+85ovjWdOYR4DnQ0mTw6dg+KzfBRdbq2f1fIz5P
 cuYNtjQRKDi/5G7e+a1yPAvghmHeUyi8+ob+/cWiORIL2bjaCOYQZGYdXOKFIo3933+XLeFXjlM
 UhEjlVMaDUwbsLdbSu/Z1XMM=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from fedora (117.129.78.49)
 by smtp.migadu.com with ESMTPS id 68147398b43ced4c;
 Tue, 18 Aug 2026 03:15:22 +0000
X-Migadu-Flow: FLOW_OUT
Date: Tue, 18 Aug 2026 11:15:12 +0800
From: Hao Li <hao.li@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, 
 kasan-dev@googlegroups.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 1/5] mm/slab: cleanup deferred free handling
Message-ID: <aoPN2evd_u09IxfR@fedora>
References: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
 <20260807-kfree_nolock_kmalloc-v1-1-ba993cbf7a60@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-kfree_nolock_kmalloc-v1-1-ba993cbf7a60@kernel.org>
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

On Fri, Aug 07, 2026 at 03:50:27PM +0200, Vlastimil Babka (SUSE) wrote:
> In deferred_percpu_work_fn() we have a bunch of single-use local
> variables for the various llists. Remove them and access the lists
> directly.
> 
> In defer_free() make it more obvious and documented what we are doing.
> Also restrict guard(preempt) to only the necessary part.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slub.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)

Looks much cleaner now.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
