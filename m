Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5946010F930F
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C431E10EAA8;
	Wed,  1 Apr 2026 00:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jt10dAED";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667EA10EAA8
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:33:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 28D89600C4;
 Wed,  1 Apr 2026 00:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4404DC2BCB0;
 Wed,  1 Apr 2026 00:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1775003594;
 bh=AMNHzr+Jyby6lTUGZfzcMMmbkmLsEe2WHEinPPa1UKc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jt10dAED0bQQ5EIamY+UEw6FzXCGWjvBO9umoXF9o2B+7CWycKJMuxpXug83U91od
 cGyNZsirNhCQs0zDqIoVxR+hxvlxykmKQ8BpN5oL2iRXYHzpH4GpVqmT57nCP50519
 t0TErZ4h9KlJfy4AQNtaeGYMTmbON46735xI6UdE=
Date: Tue, 31 Mar 2026 17:33:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, zenghui.yu@linux.dev, Liam.Howlett@oracle.com,
 david@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 dri-devel@lists.freedesktop.org, balbirs@nvidia.com
Subject: Re: [PATCH 0/3] Minor hmm_test fixes and cleanups
Message-Id: <20260331173313.a471934b6d6b76e64ab9fa2f@linux-foundation.org>
In-Reply-To: <20260331063445.3551404-1-apopple@nvidia.com>
References: <20260331063445.3551404-1-apopple@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 31 Mar 2026 17:34:42 +1100 Alistair Popple <apopple@nvidia.com> wrote:

> Just a couple of minor fixups and cleanups for the HMM kernel selftests. These
> were mostly reported by Zenghui Yu with special thanks to Lorenzo for analysing
> and pointing out the problems.

Geeze, if a kernel oops and a ugly WARN are "minor" then I'd hate to
see your "major".

I strengthened the [0/N] cover to read "Two bugfixes a cleanup for the
HMM kernel selftests....".

I also slapped cc:stable on [1/3] and [3/3] and queued everything for
the upcoming merge window, OK?

Here I assume that some users of earlier kernels will use that kernel's
in-kernel selftests.  I don't know how accurate that is, but if they are not
using them, they don't care!

[3/3] lacks a Fixes:, but I'm sure the -stable team will figure it out.

Thanks ;)
