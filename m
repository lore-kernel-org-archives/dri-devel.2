Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F52C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 23:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B09F310E13A;
	Mon,  7 Sep 2026 23:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="QRMHfJnI";
	dkim-atps=neutral
X-Greylist: delayed 3588 seconds by postgrey-1.36 at gabe;
 Mon, 07 Sep 2026 23:25:35 UTC
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526E610E13A
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 23:25:35 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=PtebkO6fHQqVEN+q6vEw0kJNHvFekDfGiYSLlcOjT4k=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788823533; v=1; x=1789428333;
 b=QRMHfJnIOX0wn1+t3ROZQa/neKVPuqoeelwU6jZWwq8bkye/pufy39LaUF03aq9suHIFE+l0
 1Sj2BJ+QrCEM/tqpyVhxe0CYztCpiRTppqjbAMa808+ws7CmvGkcZOKk5vkwmut8iOgfvKRphfw
 SWfeemSixCUKHRdyEi/5BpFI=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 096a1c17d24f69cc;
 Mon, 07 Sep 2026 23:25:33 +0000
X-Mizu-Trace-ID: 096a1c17d24f69cc
X-Migadu-Flow: FLOW_OUT
Date: Mon, 7 Sep 2026 16:25:31 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
 muchun.song@linux.dev, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 dev@lankhorst.se, mripard@kernel.org, nat@pixelcluster.dev, tj@kernel.org, 
 mkoutny@suse.com, osalvador@suse.de, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-team@meta.com
Subject: Re: [PATCH v5 5/7] mm/page_counter: introduce an asynchronous drainer
Message-ID: <ap9HiQv7_9cyIe2e@linux.dev>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
 <20260831163752.2193337-6-joshua.hahnjy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831163752.2193337-6-joshua.hahnjy@gmail.com>
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

On Mon, Aug 31, 2026 at 09:37:49AM -0700, Joshua Hahn wrote:
> The existing percpu memcg stock drainer schedules a stock drain worker
> per-cpu, one for every CPU containing the target memcg's stock.

But you are introducing remote draining. Why do you need async drainer at all?
Just always drain synchronously.

