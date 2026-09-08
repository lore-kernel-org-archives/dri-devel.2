Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5041C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DE910EDDC;
	Tue,  8 Sep 2026 22:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VXpkgp9N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE65D10EDDC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:51:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7307F415AA;
 Tue,  8 Sep 2026 22:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C79E1F00A3A;
 Tue,  8 Sep 2026 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788907884;
 bh=HXNzkQIzS9z/LWitnfZ8U4rrIa8CiwOIVwRXMp23imI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=VXpkgp9NcAxT6XELD8jLF89obbFAMDdNCz/nCVPrJg2APlNnkTEyeuZSgK1UIF+Cb
 tKLXvNU5GdZlD3HMQ+aSAsFhn7hg/9Jzl2Pwzh3/pCyImkax65sO6YaNSpuk+e1oS8
 nF+/s9Utar/YWUE1vlOzA12VP4nIWN7stdIOQ3Yr0iiGyn6LJ39ZrFLFCpaN1fciQN
 +QeRyn6Uh8/wt+mbma+5ji94q51ZNeMwRdcaSm0/zsPBivrzz0hizj4IOVSgs2wcBf
 nsTsfz0oa604NsagSIhsfQ0pZ0gKXdjMnIanzFcBKUgdFyyjZZny1dTCNC80HczOl2
 O6jgXv367z+1g==
Date: Tue, 08 Sep 2026 12:51:23 -1000
Message-ID: <a7ac8aee6a315d4d6465b728d1d28226@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [RFC v4 1/2] workqueue: Add support for real-time workers
In-Reply-To: <8b0ea995-8299-4f68-9c06-2350a1d8fa2e@igalia.com>
References: <20260804101925.55414-1-tvrtko.ursulin@igalia.com>
 <20260804101925.55414-2-tvrtko.ursulin@igalia.com>
 <aoILFR3SNYBbMOOz@slm.duckdns.org>
 <8b0ea995-8299-4f68-9c06-2350a1d8fa2e@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

On Mon, Sep 07, 2026 at 04:00:47PM +0100, Tvrtko Ursulin wrote:
> I thought it was more elegant to split the policy from the priority
> within a policy for call sites which only look up the policy.

I'd prefer a single priority value. NORMAL and HIGH use the same policy, and
nice already determines their priority. With both fields in the pool
attributes, otherwise identical unbound queues with the same nice level
cannot share a pool if one is NORMAL and the other HIGH. rt_prio() can keep
the RT checks simple.

> I did not quite manage to follow you here. Was this not the per cpu
> part, with unbound and ordered down lower?

Yes, I was confused. Please disregard that comment.

> I suppose this landed by now? I can see some changes so once we clarify
> the above opens I will rebase and adjust.

The shared allocation path is in wq/for-7.4 now. Please rebase on that.
Per-cpu pools are still separate, but RT can remain unbound-only without
waiting for the rest of the unification. Converting the shared priority
field still needs the corresponding updates to per-cpu/BH initialization and
priority checks.

Thanks.

-- 
tejun
