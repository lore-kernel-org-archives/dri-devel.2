Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA37C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1358310E392;
	Wed, 29 Jul 2026 10:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="QBiaDcmD";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB5510E392
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=r/qeObb1PMyAWCGmcaMAqm2/lsqLPrpGwnxOpx5sgwI=; b=QBiaDcmDh8IP8bv7Lk0dMFtTHG
 Js8ebvb4Zh1qFFVK3M+KK26EazFoVyrwA516D7L8ZpjjPPMrMWDfycy0v31pzfpQEJf1fp5KytdV3
 ru1HELt8abKK0uYDsARPrVMkhYzyN3oFPJJP8EA/TFG5RaNpw2QVdT8E94Dy+2RyNsdAG4ccuXfwj
 Qczg0rNCVUbxjOlgwE7Adkmq61d63BQpbsPsEgjg0DFjmJkAQGcVJiMKn/iH+Wi2KfY4tNk9stv72
 mCeukMKekVkjsDo/KDN8xpk2Do1vCupEciXlZeIv6w6e3z3vtLTEP5Zf16TaAJOK0YfovmduexW7T
 iOa9zdIQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wp1Eu-00000000SUZ-3Orq; Wed, 29 Jul 2026 10:10:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id E2EC5300208; Wed, 29 Jul 2026 12:10:15 +0200 (CEST)
Date: Wed, 29 Jul 2026 12:10:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH 1/3] wait: Introduce non-irq variants of
 wait_event_lock_timeout
Message-ID: <20260729101015.GK49951@noisy.programming.kicks-ass.net>
References: <20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com>
 <20260729-panthor-cache-flush-fix-v1-1-205921ed3c81@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-panthor-cache-flush-fix-v1-1-205921ed3c81@collabora.com>
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

On Wed, Jul 29, 2026 at 08:19:49AM +0200, Nicolas Frattaroli wrote:
> For locks that are never acquired in an interrupt context, the non-irq
> variants for spin_lock()/spin_unlock() are more efficient. However, so
> far, wait.h only provided wait_event_lock_irq_timeout and
> wait_event_interruptible_lock_irq_timeout, both of which use
> spin_lock_irq()/spin_unlock_irq().
> 
> Rectify this by adding new non-irq variants of these two macros.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
