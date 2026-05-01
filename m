Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F410BFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E8A10E975;
	Tue,  5 May 2026 07:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=panix.com header.i=@panix.com header.b="uLrtLc67";
	dkim-atps=neutral
X-Greylist: delayed 1095 seconds by postgrey-1.36 at gabe;
 Fri, 01 May 2026 19:27:07 UTC
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BCA10E25E;
 Fri,  1 May 2026 19:27:07 +0000 (UTC)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
 (No client certificate requested)
 by l2mail1.panix.com (Postfix) with ESMTPS id 4g6gYw0xRKzDSj;
 Fri,  1 May 2026 15:08:52 -0400 (EDT)
Received: from [10.50.4.26] (45-31-46-51.lightspeed.sndgca.sbcglobal.net
 [45.31.46.51])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4g6gYs5wssz40Dc;
 Fri,  1 May 2026 15:08:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1777662531; bh=l6JbYucB+9yD0k96T5o6k3yiniTY2VGeKOqZ7PJWN2I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=uLrtLc67iWq4GSqPGwTJ4rzevu63TXdyY+tNy3yIoVxzTdPx+0fPodKpQqxhC4lNc
 QCHPB1S0lTSGcF0UU4nPVLMx1ZldiL+6j23fwwJohT2SBeEYi26JMpRWvIueKLSTyb
 EzfKFKOXzZUJmOYybDBlTJSczHHL4DxaWkFQioyw=
Message-ID: <f25f27a1-bf09-44bd-9b37-49f159d82d6a@panix.com>
Date: Fri, 1 May 2026 12:08:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH v4 0/6] mm, drm/ttm, drm/xe: Avoid reclaim/eviction loops
 under fragmentation
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Kenneth C <kenny@panix.com>
References: <20260430191809.2142544-1-matthew.brost@intel.com>
 <20260430191809.2142544-3-matthew.brost@intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20260430191809.2142544-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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


On 4/30/26 12:18, Matthew Brost wrote:

> Introduce zone_maybe_fragmented_in_shrinker() as a lightweight helper to
> allow subsystems to make coarse decisions about reclaim behavior in the
> presence of likely fragmentation

I'm running Linus' master on my LunarLake (258v) laptop, and sometimes 
after compiling a kernel (of all things) I'd see kswapd0 thrash despite 
having quite a bit of free memory.

I finally traced it to the xe driver after seeing the "GPUActive" field 
in /proc/meminfo suddenly start rising, eventually growing larger than 
real memory by several times (see below).

This patchset fixes the issue, and I'm sure there'll be a fix going into 
Linus' master soon, but what I'M wondering is how could building a 
kernel (which is just in a KDE Konsole running on Wayland) make the 
GPActive grow from ~1.6G to > 30G (and continue to rise, RN I'm seeing 
91839848 kBs and still growing).

-Kenny

----
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:        652640 kB
GPUReclaim:       403988 kB

SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:        651180 kB
GPUReclaim:       406812 kB

SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:        659004 kB
GPUReclaim:       399396 kB

SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:        666996 kB
GPUReclaim:       392764 kB

<some hours later>
GPUActive:      91832468 kB
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUReclaim:       488000 kB

GPUActive:      91832332 kB
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUReclaim:       487988 kB

GPUActive:      91869376 kB
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUReclaim:       486504 kB
----

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

