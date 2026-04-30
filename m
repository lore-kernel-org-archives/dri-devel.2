Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C933DCD13DE
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 23:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255E310E4A9;
	Thu, 30 Apr 2026 23:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GeiddE3O";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC8B10E4A9;
 Thu, 30 Apr 2026 23:01:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CBC060142;
 Thu, 30 Apr 2026 23:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04EEC2BCB3;
 Thu, 30 Apr 2026 23:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1777590067;
 bh=PTULIpfRpRHkz0qopelU8YTdmvf6BncDc8+Oy6+/FfU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GeiddE3O5PYXm17s8GY+whOzMH+r8aSqPUcTTBGpfl5yEsELOtc1RBsuQmCU4XAAv
 G2xQ2oifD6lJM0tEBXagW1Yy5u8RbsAOaeRTgyhKNydcQaSZIu8uBQJ2fbrPzhoFlz
 u4ekfPkgl811pE2YyrckBnbbyWZMzpKVOwggUM/A=
Date: Thu, 30 Apr 2026 16:01:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Dave
 Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Roman
 Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] mm, drm/ttm, drm/xe: Avoid reclaim/eviction
 loops under fragmentation
Message-Id: <20260430160105.a3b74ec3bb316bbfbf8f9808@linux-foundation.org>
In-Reply-To: <20260430191809.2142544-1-matthew.brost@intel.com>
References: <20260430191809.2142544-1-matthew.brost@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Thu, 30 Apr 2026 12:18:03 -0700 Matthew Brost <matthew.brost@intel.com> wrote:

> TTM allocations at higher orders can drive Xe into a pathological
> reclaim loop when memory is fragmented:
> 
> kswapd → shrinker → eviction → rebind (exec ioctl) → repeat
> 
> In this state, reclaim is triggered despite substantial free memory,
> but fails to produce contiguous higher-order pages. The Xe shrinker then
> evicts active buffer objects, increasing faulting and rebind activity
> and further feeding the loop. The result is high CPU overhead and poor
> GPU forward progress.
> 
> ...
>
> This series addresses the issue in two ways:
> 
> TTM: Restrict direct reclaim to beneficial_order. Larger allocations
> use __GFP_NORETRY to fail quickly rather than triggering reclaim.
> 
> Xe: Introduce a heuristic in the shrinker to avoid eviction when
> running under kswapd and the system appears memory-rich but
> fragmented.

Please cc everyone on all the patches?  It's kind of annoying to have
to hunt around to find out how these proposed changes will be used. 
Personal preference, anyway.

AI review flagged a few possible issues:
	https://sashiko.dev/#/patchset/20260430191809.2142544-1-matthew.brost@intel.com
