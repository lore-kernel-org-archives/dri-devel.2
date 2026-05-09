Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F66CD37AC
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 02:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD66D10F64F;
	Sat,  9 May 2026 02:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="t7OBeIUy";
	dkim-atps=neutral
X-Greylist: delayed 534 seconds by postgrey-1.36 at gabe;
 Sat, 09 May 2026 02:40:46 UTC
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A189B10E12F
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 02:40:46 +0000 (UTC)
Message-ID: <ede39af0-e5c1-4cb7-8382-400e1961d9d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778293900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isoMVqmiA39mM7GIpQVXu+Zu5R5lf1TBBevgqgkjmOE=;
 b=t7OBeIUyKK8fXSiN+xna9GkR7p4NwqefMbij1e8D74GOypyjdZDkhoArPhuZVaLhL59w/0
 JQgmkV8WJTeALVBdGfHmqe+M6Yg/X5UDJ3GmG14SQvxKPFrA68miMpu1o1BtToCsSNDYK5
 9+Dlr2RHsXkZlRF1zG1jBTqfzlJSJW0=
Date: Sat, 9 May 2026 10:31:15 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/5] mm, drm/ttm, drm/xe: Avoid reclaim/eviction loops
 under fragmentation
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Brost <matthew.brost@intel.com>, Dave Chinner <david@fromorbit.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260506033300.3534883-1-matthew.brost@intel.com>
 <20260508170355.c937b91cdd63a11e56d2225d@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260508170355.c937b91cdd63a11e56d2225d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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



On 5/9/26 8:03 AM, Andrew Morton wrote:
> On Tue,  5 May 2026 20:32:55 -0700 Matthew Brost <matthew.brost@intel.com> wrote:
> 
>> TTM allocations at higher orders can drive Xe into a pathological
>> reclaim loop when memory is fragmented:
>>
>> ...
>>
>> This series addresses the issue in three layers:
> 
> Thanks.  AI review asked a few things, nothing looked very serious to
> my eye:
> 
> 	https://sashiko.dev/#/patchset/20260506033300.3534883-1-matthew.brost@intel.com

I recall Dave having concerns about the design itself in v4 [1], but
since he wasn't CC'ed on the whole patchset, there seems to be no
further conclusion. Maybe it's best to wait for his further feedback. ;)

[1]. https://lore.kernel.org/all/afQE-2JOzfOm8enM@dread/
