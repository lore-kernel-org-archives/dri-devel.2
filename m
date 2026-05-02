Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0256ECD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA5B10E983;
	Tue,  5 May 2026 07:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=panix.com header.i=@panix.com header.b="ovusLGWM";
	dkim-atps=neutral
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E9810E276;
 Sat,  2 May 2026 08:14:40 +0000 (UTC)
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net
 [72.219.82.239])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4g710b2LQsz4n9b;
 Sat,  2 May 2026 04:14:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1777709680; bh=bxqm0lW2PmvQTaH5Q++wyZMQfBtk2aVXIpYkVvoKLc4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ovusLGWMO6yJx6JdnTzukjg74nhX4iiCZ2Z46DaNl6rZBv+/qR/Dz7zWEjaguVWaH
 2qPmTCXIyroszvUBXGb31acfbMuz57NEpTt6FTDZ+gNoaqcKPu1XwVVEuYmr/RKw7E
 +m7CsAdVGItg4c4GBgDs6q42nq/rN7bnB8kC7vBw=
Message-ID: <7f927ef8-2d3d-4609-926d-b18535794f72@panix.com>
Date: Sat, 2 May 2026 01:14:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Fix GPU MM stats during pool shrinking
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 David Airlie <airlied@gmail.com>
References: <20260502065338.2720646-1-matthew.brost@intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20260502065338.2720646-1-matthew.brost@intel.com>
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



On 5/1/26 23:53, Matthew Brost wrote:
> TTM pool shrinking frees pages by calling __free_pages() directly,
> which bypasses updates to NR_GPU_ACTIVE and leaves GPU MM accounting
> out of sync.
> 
> Introduce a helper, __free_pages_gpu_account(), and use it for all page
> frees in ttm_pool.c so GPU MM statistics are updated consistently.
> 
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Fixes: ae80122f3896 ("drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)")
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> ---
> 
> v2:

Tested-By: Kenneth R. Crudup <kenny@panix.com>

I think this one got it right ... this is after two bonnie++ runs:

----
SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        676092 kB
GPUReclaim:       584272 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        750396 kB
GPUReclaim:       516348 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        801996 kB
GPUReclaim:       478756 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        794224 kB
GPUReclaim:       481624 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        351336 kB
GPUReclaim:          400 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:       1015624 kB
GPUReclaim:           72 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        583176 kB
GPUReclaim:           48 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        737852 kB
GPUReclaim:         2524 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:       1041056 kB
GPUReclaim:          308 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:       1356568 kB
GPUReclaim:       109992 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:       1181732 kB
GPUReclaim:        39000 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        989900 kB
GPUReclaim:           68 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        486720 kB
GPUReclaim:          544 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        687628 kB
GPUReclaim:         2280 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:        634060 kB
GPUReclaim:         1000 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:       1030168 kB
GPUReclaim:         1696 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:       1323464 kB
GPUReclaim:         1392 kB

SwapFree:       33554428 kB
MemTotal:       32345768 kB
GPUActive:       1452340 kB
GPUReclaim:        20024 kB
----



-Kenny "yeah, I don't sleep much either" Crudup

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

