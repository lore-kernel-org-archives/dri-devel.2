Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA5606A331
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lJxfz6F4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E47F10E4E2;
	Sat,  7 Nov 2026 13:57:42 +0000 (UTC)
Received: from mta1.migadu.com (out-144.mta1.migadu.com [95.215.58.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32EA710E4E2
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 13:57:35 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=a4WQjTS9cLmNAnAJkm3u/yMKK8cVrEp4RpmNfDVq90s=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794059853; v=1; x=1794664653;
 b=lJxfz6F4qBNSR5tFla7gLu8C60Ut8j6sNhgl36PjYrBesekcQ460PWTFUBZKJBTXlOb167Cz
 EYAxD+DU/YXTiDp0v0C46KCq/hhwcfZgC5Q+E2SOBt3QwWyB+hXy5CTC+iuQKMFnn9NMW+C4It5
 ILQjSrkCXaBdr5OGpjI70qJg=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta12.migadu.com with ESMTPS id bb1f088a7420c55f;
 Sat, 07 Nov 2026 13:57:32 +0000
X-Mizu-Trace-ID: bb1f088a7420c55f
X-Migadu-Flow: FLOW_OUT
Message-ID: <fd7ed305-6192-46e8-a5bb-cc1ed8f12f74@linux.dev>
Date: Sat, 7 Nov 2026 21:57:02 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/list_lru: Account node removals in isolation helpers
To: Johannes Weiner <hannes@cmpxchg.org>, Dave Chinner <dgc@kernel.org>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 brauner@kernel.org, cmllamas@google.com, aliceryhl@google.com,
 nat@pixelcluster.dev, arunpravin.paneerselvam@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk,
 agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, cel@kernel.org,
 jlayton@kernel.org, cem@kernel.org, akpm@linux-foundation.org,
 david@fromorbit.com, david@kernel.org, hughd@google.com, yosry@kernel.org,
 nphamcs@gmail.com, matthew.auld@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, jack@suse.cz, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, qi.zheng@linux.dev,
 roman.gushchin@linux.dev, muchun.song@linux.dev, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org,
 mhocko@kernel.org, shakeel.butt@linux.dev, ljs@kernel.org,
 kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, baoquan.he@linux.dev, chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20261103045053.59548-1-kaitao.cheng@linux.dev>
 <aupITfr9pBKPrU20@dread> <au3eyCrHiuhbJx3u@cmpxchg.org>
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <au3eyCrHiuhbJx3u@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

在 2026/11/6 22:06, Johannes Weiner 写道:
> On Wed, Nov 04, 2026 at 07:47:09AM +1100, Dave Chinner wrote:
>> On Tue, Nov 03, 2026 at 12:50:53PM +0800, Kaitao Cheng wrote:
>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>
>>> Successful writeback calls zswap_entry_free(), which removes the entry
>>> from the LRU and decrements both the sublist and node item counts.
>>> shrink_memcg_cb() then returns LRU_REMOVED_RETRY, causing the LRU walker
>>> to decrement the node count again.
>>>
>>> The affected call path before this change is:
>>>
>>>   __list_lru_walk_one()
>>>     shrink_memcg_cb()
>>>       zswap_writeback_entry()
>>>         zswap_entry_free()
>>>           zswap_lru_del()
>>>             list_lru_del()
>>>               __list_lru_del()
>>>                 atomic_long_dec()  /* first node count decrement */
>>>       return LRU_REMOVED_RETRY
>>>     atomic_long_dec()              /* second node count decrement */
>>
>> That's a bug in the zswap code. You shouldn't be calling
>> list_lru_del() from __list_lru_walk_one() context.
> 
> Grr, Kaitao you dropped the wrong thing that I thought had merit in my
> proposal...
> 
> Dave, would you mind taking a look at my patch at
> https://lore.kernel.org/all/auJkvb-Lq0M5Enkz@cmpxchg.org/?
> 
> Ignore zswap for a second. I know it has problems. Most of it stems
> from the fact that we rely on the swap locking and do none of our own
> locking/lifetime on the zswap entry. As a result we work around it in
> odd ways. Sorry, you didn't ask :-) That's worth revisiting, although
> it's likely more invasive work.
> 
> The observation that led to the patch above was a much simpler one:
> since we now have the caller-locked __list_lru_del() anyway, the only
> difference between that and the list_lru_isolate* is the
> accounting. The patch is about one thing: removing the isolate helpers
> entirely. There is then simply one tool for caller-locked list
> unlinking, __list_lru_del(). It removes an avoidable distinction,
> shrinks the API surface, makes it harder to screw up.

I don't think replacing EXPORT_SYMBOL_GPL(list_lru_isolate) with
EXPORT_SYMBOL_GPL(__list_lru_del) makes much difference by itself.
The only reason I kept list_lru_isolate() in the current version
is to avoid passing an additional parameter (nid) to the isolate
callbacks.

I don't have a strong preference for the current approach. If we
can reach a consensus, I'd be happy to send v3 with the proposed
changes.

> The zswap weirdness made me look at list_lru. Consider it a stress
> test from idiotic code :-) But I would propose the list_lru
> simplification for its own sake, regardless of what we do with zswap.

-- 
Thanks
Kaitao Cheng

