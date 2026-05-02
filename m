Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F92CD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF89C10E978;
	Tue,  5 May 2026 07:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=panix.com header.i=@panix.com header.b="NmnmgQLW";
	dkim-atps=neutral
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEDA10E231;
 Sat,  2 May 2026 00:05:16 +0000 (UTC)
Received: from [10.50.4.26] (45-31-46-51.lightspeed.sndgca.sbcglobal.net
 [45.31.46.51])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4g6p7v12zqz4Z6J;
 Fri,  1 May 2026 20:05:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1777680315; bh=yLOeTb77iO7D7G1rMqHM9UKvi2cmkepdCc7JELURt04=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NmnmgQLWf5M2n77Be2fq4Pe3S2BXcN9TyQltwq0kBbWP2fLErTjI6PrIAbIvIIWXO
 PYq26fwcy92CNBRZqo4B8WYjEdpLcuSJEi8DRJiu2EpwhF+mG271jbL6sPGW3FPWtL
 0cF7zi8Kxi5NncE/x2jMSPgqyjeiC9kTwE8+O0Iw=
Message-ID: <18c48e7f-a2bd-4e74-9262-266cd5c2fde8@panix.com>
Date: Fri, 1 May 2026 17:05:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix GPU MM stats during pool shrinking
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 David Airlie <airlied@gmail.com>
References: <20260501223003.2648450-1-matthew.brost@intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20260501223003.2648450-1-matthew.brost@intel.com>
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


On 5/1/26 15:30, Matthew Brost wrote:

> TTM pool shrinking frees pages by calling __free_pages() directly,
> which bypasses updates to NR_GPU_ACTIVE and leaves GPU MM accounting
> out of sync.
> 
> Introduce a helper, __free_pages_gpu_account(), and use it for all page
> frees in ttm_pool.c so GPU MM statistics are updated consistently.

OK, so why/how does "bonnie++" increase the GPU Memory size?

----
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUReclaim:       621568 kB
GPUActive:        453592 kB

SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:       5554976 kB
GPUReclaim:        12716 kB

SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:      18407272 kB
GPUReclaim:          884 kB

SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:      24022916 kB
GPUReclaim:          716 kB

SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:      25258248 kB
GPUReclaim:        16032 kB

SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUActive:      28207188 kB
GPUReclaim:         3684 kB
----

... and I'm now not so sure the patch is working ... this after a 2nd 
bonnie run:

----
GPUActive:      44357100 kB
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUReclaim:        94864 kB

GPUActive:      44373904 kB
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUReclaim:        94996 kB

GPUActive:      44354940 kB
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUReclaim:        98048 kB

GPUActive:      44769340 kB
SwapTotal:      33554428 kB
MemTotal:       32345672 kB
GPUReclaim:       122996 kB
----

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

