Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04235C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6951910E64E;
	Mon,  3 Aug 2026 13:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="A30PE+Vf";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE0310E653
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785763223; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EvVRl/yXstn8NkEx27l4Z5npudKXR2KuJnjosYfUq+5qbLqHCgP5dvaXbHXd636UqUV4LnXx8XyULv1ZPkeRJea0OOqoV3vIykSzZB2ZHbm8ukCnTJJmcc7N2YaPnk1iBAkShZ/lqmaco6/t/A8GTQbHy2PvdgbzpIfqL52DwbE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785763223;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3XDs2AL6dDQ4H+CdWU65MVevEoVYOrc0yGy3mX2p2jE=; 
 b=CNrEOnakREEaj1lXADE8lJD5R0McKwFAf+fX7lCbj/vigvMKNNrIgT+ADDVM7Hwg4cUJobTmF2qJzqjc442TMurLFhO95dmS1LdgLauzK35YvIomR9ocAAdlijtX7FHGMgVijii0Onx3pPG5ZUhR7gi2d3a4CaLuqb7FOCz2Ous=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785763223; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=3XDs2AL6dDQ4H+CdWU65MVevEoVYOrc0yGy3mX2p2jE=;
 b=A30PE+VfdbTWRMbr585ir6P6g2kEFP6YXQt2tbkYWoggOXt1JSt5BFXQJTziwoXr
 v7RBojQnjt2Oe9iBXlo6yl5s56gO2l8uiprhS89qOdc+oLABFbT2mx5pprcvJFi15jW
 lt8naiysz7DOzGZzf6WMZXOiY701X9Z8GowP7OsI=
Received: by mx.zohomail.com with SMTPS id 1785763222071159.7552701038611;
 Mon, 3 Aug 2026 06:20:22 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
Date: Mon, 03 Aug 2026 15:20:14 +0200
Message-ID: <d8RYWTYuQ0anmClym0IahA@collabora.com>
In-Reply-To: <fiUy-cD0Q9OOQiaEoz9UeA@collabora.com>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260803105324.478ed594@fedora1.home> <fiUy-cD0Q9OOQiaEoz9UeA@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Monday, 3 August 2026 15:13:25 Central European Summer Time Nicolas Frattaroli wrote:
> On Monday, 3 August 2026 10:53:24 Central European Summer Time Boris Brezillon wrote:
> > Hello Nicolas,
> > 
> > On Thu, 30 Jul 2026 13:45:15 +0200
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> > 
> > > panthor_gpu_flush_caches() and panthor_gpu_soft_reset() would read (and
> > > even reset) the contents of the pending_reqs register outside of holding
> > > the reqs_lock.
> > 
> > Can you elaborate a bit on the race being fixed here? If pending_reqs bits
> > are truly cleared before the wake_up_all() call (which would require a
> > WRITE_ONCE() to be enforced, admittedly), there's no risk for the
> > wait_event() call to do a test before the bits have been updated,
> > and this holds even if the test is done without the lock held.
> > 
> > The other race I could think of is two threads calling
> > panthor_gpu_flush_caches() concurrently, and the second one stealing
> > the FLUSH_COMPLETED event the first thread waits on and re-issuing a
> > second flush on top, thus delaying the completion for the first thread.
> > But that should be covered by the cache_flush_lock.
> 
> panthor_gpu_flush_caches() is not the only thing that sets/gets
> pending_reqs. Notably, the threaded interrupt handler does, as
> well as any other functionality using the same member for reqs
> tracking (e.g. the soft reset).
> 
> Consider the following serialisation of events:
> 1. T1 asks to flush caches by writing GPU_CMD and setting pending_reqs
> 2. T1 drops reqs_lock.
> 3. T2 enters IRQ handler for flush complete, spins lock waiting for
>    reqs_lock

Minor correction: Imagine 2 and 3 reversed here in a non-IRQ-disabling,
variant, otherwise "spins lock" does not make sense. With an IRQ-disabling
variant, ignore the "spins lock waiting for reqs_lock" part. 

> 4. T1 sleeps at wait_event_timeout
> 5. T2 updates pending_reqs and wakes up the waiter in any order, since
>    the effects of those two can't consistently be observed as sequential
>    logic without the outer reqs_lock being held by the observer
> 6. T1 wakes up, checks pending_reqs, but since pending_reqs is checked
>    without holding any lock, so we implictly depend on the synchronisation
>    point that is the waitqueue's lock rather than the reqs_lock spinlock,
>    which says nothing about whether the pending_reqs change materialised
>    on T1's side yet as far as I can tell?
> 7. T1 sees that pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED is still != 0,
>    so goes back to sleep for some future wake-up of reqs_acked or a timeout.
> 




