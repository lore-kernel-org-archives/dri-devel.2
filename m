Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8A0FF8870
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB15010EACE;
	Tue, 28 Apr 2026 09:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WxTSaql7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0547510EACB;
 Tue, 28 Apr 2026 09:51:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2871560142;
 Tue, 28 Apr 2026 09:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4615BC2BCAF;
 Tue, 28 Apr 2026 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777369898;
 bh=Qtgzl9uQeZRdCw0Q5qVLT5RiRrK4qvEsHQ3PXE3CYOM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WxTSaql7s5o2xq8bLFvL8+8zawGPs9gT0E2KRQkyWx19f907nl6uczr6BRySYHlC4
 LD8vwCChAxOavFoUEClVXC5Y8Fu2ZQq1tcJJtkFaP82QRvncGA+BOJuuWrjzsJJPEl
 XS2uy7hwFFNOV+QziuppXmErCmssY064EObfxEpR6tC2/7eI1IrvlVdCExaIyEJPnI
 xTgBOymGHVZGYKMRlZU1Y7nczVKOQTfzsVJneVbjI2aVekEOc5KMeQqJ9qysE+yLaD
 1023mUcvfm/cIOwJWutGhvtXrWcG+0YDdgdHr8HjetD+cbU6wqWQc68H8no/sKe0IC
 /ucV8opqnE12Q==
Date: Tue, 28 Apr 2026 11:51:34 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Message-ID: <afCCCuLglfi70Tgq@zenone.zhora.eu>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423055656.1696379-2-matthew.brost@intel.com>
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

Hi Matt,

On Wed, Apr 22, 2026 at 10:56:52PM -0700, Matthew Brost wrote:
> Introduce zone_appears_fragmented() as a lightweight helper to allow
> subsystems to make coarse decisions about reclaim behavior in the
> presence of likely fragmentation.
> 
> The helper implements a simple heuristic: if the number of free pages
> in a zone exceeds twice the high watermark, the zone is considered to
> have ample free memory and allocation failures are more likely due to
> fragmentation than overall memory pressure.
> 
> This is intentionally imprecise and is not meant to replace the core
> MM compaction or fragmentation accounting logic. Instead, it provides
> a cheap signal for callers (e.g., shrinkers) that wish to avoid
> overly aggressive reclaim when sufficient free memory exists but
> high-order allocations may still fail.
> 
> No functional changes; this is a preparatory helper for future users.
> 
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  include/linux/vmstat.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 3c9c266cf782..568d9f4f1a1f 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -483,6 +483,19 @@ static inline const char *zone_stat_name(enum zone_stat_item item)
>  	return vmstat_text[item];
>  }
>  
> +static inline bool zone_appears_fragmented(struct zone *zone)

this is a bit of a strong statement and the function name might
be misleading. You received some suggestions from David and I
would rename this function to something like
"zone_maybe_fragmented()".

> +{
> +	/*
> +	 * Simple heuristic: if the number of free pages is more than twice the
> +	 * high watermark, this strongly suggests that the zone is heavily
> +	 * fragmented when called from a shrinker.
> +	 */

The commit log explains it a bit better. The heuristic statement
here is too strong and it still sounds stronger than it should.

Andi

> +	if (zone_page_state(zone, NR_FREE_PAGES) > high_wmark_pages(zone) * 2)
> +		return true;
> +
> +	return false;
> +}
> +
>  #ifdef CONFIG_NUMA
>  static inline const char *numa_stat_name(enum numa_stat_item item)
>  {
> -- 
> 2.34.1
> 
