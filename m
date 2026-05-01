Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D7CCD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EC610E969;
	Tue,  5 May 2026 07:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=panix.com header.i=@panix.com header.b="EwqJlXIY";
	dkim-atps=neutral
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D503110F5BF;
 Fri,  1 May 2026 20:06:00 +0000 (UTC)
Received: from [10.50.4.26] (45-31-46-51.lightspeed.sndgca.sbcglobal.net
 [45.31.46.51])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4g6hqp6ldbz44h5;
 Fri,  1 May 2026 16:05:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1777665960; bh=cONm87vO6U8KoFRSYCxJ8KYqOQ0G13S1o+mPo2nLIvE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EwqJlXIYdY4I1dS0lhxbfOj47Kt+Yj7YfgEwsGpNoNaJcRtXApRuMJuARolCq0MAm
 VWpEKWIhLMocrLBh3MQnn6CnrtDMKQ+9JPuLriJSUm4E6j8ABb1QK90bYbIP1Meq8Y
 8nPhy8FGQQAwgpjF3QZ84CGXq4SMvIqMQoKjEAPg=
Message-ID: <1bc0b1a7-a01f-4dc2-ad7a-3a05f975331e@panix.com>
Date: Fri, 1 May 2026 13:05:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH v4 0/6] mm, drm/ttm, drm/xe: Avoid reclaim/eviction loops
 under fragmentation
To: Matthew Brost <matthew.brost@intel.com>, airlied@gmail.com
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260430191809.2142544-1-matthew.brost@intel.com>
 <20260430191809.2142544-3-matthew.brost@intel.com>
 <f25f27a1-bf09-44bd-9b37-49f159d82d6a@panix.com>
 <afUGSmS+jNPP8O5v@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <afUGSmS+jNPP8O5v@gsse-cloud1.jf.intel.com>
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


On 5/1/26 13:00, Matthew Brost wrote:

> So is this 7.1-rc1? It looks like new feature to 7.1 added by Dave [1] and
> something look off here. Thanks for pointing this out.

Yeah. I grab his master branch daily (as of 6fe0be6dc7fa RN).

Is this a "shoot the messenger" thing? IOW, is the reporting off, or is 
the memory usage really that high?

(BTW, those are in 30-second intervals)

>> ----
>> SwapTotal:      33554428 kB
>> MemTotal:       32345672 kB
>> GPUActive:        652640 kB
>> GPUReclaim:       403988 kB
>>
>> SwapTotal:      33554428 kB
>> MemTotal:       32345672 kB
>> GPUActive:        651180 kB
>> GPUReclaim:       406812 kB
>>
>> SwapTotal:      33554428 kB
>> MemTotal:       32345672 kB
>> GPUActive:        659004 kB
>> GPUReclaim:       399396 kB
>>
>> SwapTotal:      33554428 kB
>> MemTotal:       32345672 kB
>> GPUActive:        666996 kB
>> GPUReclaim:       392764 kB
>>
>> <some hours later>
>> GPUActive:      91832468 kB
>> SwapTotal:      33554428 kB
>> MemTotal:       32345672 kB
>> GPUReclaim:       488000 kB
>>
>> GPUActive:      91832332 kB
>> SwapTotal:      33554428 kB
>> MemTotal:       32345672 kB
>> GPUReclaim:       487988 kB
>>
>> GPUActive:      91869376 kB
>> SwapTotal:      33554428 kB
>> MemTotal:       32345672 kB
>> GPUReclaim:       486504 kB
>> ----

-K

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

