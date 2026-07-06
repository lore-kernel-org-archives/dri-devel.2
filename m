Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA68C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7BF10E3EF;
	Mon,  6 Jul 2026 19:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kkycI5Eo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC5510E3EF
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 19:37:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F5FE42DB5;
 Mon,  6 Jul 2026 19:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED49A1F00A3A;
 Mon,  6 Jul 2026 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783366620;
 bh=5wVXaZyBswMFYBHHYDn7xtnHs1hnMKtVBMS98qXTlXI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kkycI5EoqpJy8CEtW+M7I48QxuaeJI4NttgsIc2MLAMY8uidqbf5S8/SKl7OawTYK
 9WOJaAJyinQZuLv1sCSWAjWjJvvEsnwZB3SsMgf0MWHNFPbHfq9g/Rs2NJ8oCCuRK1
 Y1GE7n3zNkrZT6lTF7ief5KZeyjUe43idRo1jGUDT9c1PBO6waJtgE9ugMVVtf7SOh
 SssxAI5Xtrvxr/H+7/1EaDNbgQ1EZFvW49X4u64a8kC3Vn/L0kDIp7xPLNaXdM3iUE
 yF2tu1wRSC56jpzpF5r/Amh/iy1Dv0BtUtQnQ6YvT8+dJKCcfHHSzl5jQn6qtHS5C5
 Z8SarwKREvXmQ==
Date: Mon, 6 Jul 2026 09:36:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: phasta@kernel.org, dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, kernel-dev@igalia.com
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <akwD28ihbzn1FB-P@slm.duckdns.org>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <4eb23476ff56bee108578adfe131be38e8fc1476.camel@mailbox.org>
 <b76ea01c-ead3-4eaf-86a7-5bf91bfdb9cb@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76ea01c-ead3-4eaf-86a7-5bf91bfdb9cb@igalia.com>
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

Hello,

On Mon, Jul 06, 2026 at 01:20:49PM +0100, Tvrtko Ursulin wrote:
...
> > So the first question I would like to see considered is whether
> > workqueue could be improved in any way to address said latency issues.
> > 
> > Have you already considered that, Tvrtko?
> 
> Yes, priority inheritance was justifiably rejected for generic workqueues.
> There is WQ_HIGHPRI, but the idea here is to go one step further and allow
> tracking realtime scheduling policies.

If deciding at work item boundaries is granular enough, it's not
unconscionable to support RT worker pools. The main reason for resisting
that is because it can be too easy to abuse. A couple RT threads may solve
immediate problems but with a bunch of them you just don't have a working
scheduler in the system. In general, it's pretty suspicious if there's
intersection of "I need a bunch of worker threads in a flexible way" and "I
want RT".

How big a hit is WQ_HIGHPRI vs. RT?

Thanks.

-- 
tejun
