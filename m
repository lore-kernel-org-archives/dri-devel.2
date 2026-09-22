Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2C4C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C144C10E70B;
	Tue, 22 Sep 2026 13:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="XEd5ezKq";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BFC10E70B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790084418; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QIkrARGJmxfhdMefGZsdjXrGO/URbswRmscA6iq0Yl1/WQ5OCJEWMLNIHzpLdNQal7YgCOk9kmQfvb2ChAqDg8YEk5vJvmQzxkMTDht77cOwvfBl4PZWYb8nUm9CBAL1gu195eIdgWL37HFemEvwp0rRlfnBI2UPgfW2Agxoigw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790084418;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=elHEN+T4qLUN/ZJgFC2dcWpkOLWVH6EAQ0hRhXlVtlA=; 
 b=LZ0uOMzz6vQw7CBsxqIBJbbiwphETdk+V5PQje3NljYpU/9y7wXNkRcJ3q5IimWGaBqJDoleZ5/ORcabvsMQFP6T4nsbnK2Ys3jGW2jdhcRqRSasJovllTCOhNkGOW31yV6GUgGreMvpk5SXG8q277D+aV+GoOPTBBDWHD5ktWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790084418; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=elHEN+T4qLUN/ZJgFC2dcWpkOLWVH6EAQ0hRhXlVtlA=;
 b=XEd5ezKq9bV9CG5cMnyj7i+Fh1UsxBVhgbU8PUaIP+EDU/zJpJuY0Nchdiijn4Gn
 CZrD094W8oeJ4r9t3z/2/z0N1wApiW2GSilDbiHao5vPkriL2eliEg4j08XY5HZWR20
 /kCXbSmfCyuwXgKYRm8AKgLW6mBeYG+z5iTr1EvQ=
Received: by smtp.zohomail.com with SMTPS id 1790084418184517.6641931371963;
 Tue, 22 Sep 2026 06:40:18 -0700 (PDT)
Message-ID: <e60fdbae-293c-484a-bf3f-2d8b2d136b7e@collabora.com>
Date: Tue, 22 Sep 2026 15:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Xaver Hugl <xaver.hugl@kde.org>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-3-vivek.kasireddy@intel.com>
 <77b5fa08-6c95-4f9d-a12e-5ddca3c1c1e0@amd.com>
 <IA0PR11MB718502111B354D893D71FA0CF8832@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a6e77fdd-52b9-4701-a677-c984ce534c42@amd.com>
Content-Language: en-US, de-DE, en-GB
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <a6e77fdd-52b9-4701-a677-c984ce534c42@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

On 22.09.26 09:33, Christian König wrote:
> On 9/22/26 07:19, Kasireddy, Vivek wrote:
>> Hi Christian,
>>
>>> Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for
>>> udmabuf pages/folios
>>>
>>> On 8/31/26 08:00, Vivek Kasireddy wrote:
>>>> Since udmabuf allows users to pin pages in memory, which is a vital
>>>> resource, we need to ensure that unprivileged users cannot abuse
>>>> this feature to exhaust system memory. To address this, introduce
>>>> mlock accounting for udmabuf pages/folios. This change ensures that
>>>> the number of pages/folios pinned by udmabuf is tracked and limited
>>>> based on the user's mlock limits.
>>>>
>>>> If an unprivileged user/process exceeds their mlock limit, no pages
>>>> are pinned and EPERM is returned to the user. Note that, privileged
>>>> users/processes (CAP_IPC_LOCK capable) are exempt from this limit,
>>>> allowing them to pin pages without any restriction.
>>>>
>>>> Earlier, there was a 64 MB default limit on the size of udmabuf
>>>> allocations, but it was removed in commit 44e9eb5a7621
>>>> ("dma-buf/udmabuf: Disable the size limit by default") which left
>>>> open the possibility that unpriviledged users could pin unbounded
>>>> amount of memory. This change makes the limit dynamic, by invoking
>>>> user_shm_lock() to check the mlock limit for unprivileged users.
>>> That makes no sense at all and would create a massive problems.
>>>
>>> The mlock limit is per process, but udmabuf is represented by a file
>>> descriptor which can move between processes.
>>>
>>> So this here can be trivially abused to account the allocation to one
>>> process while accounting the free to another process and overflowing
>>> the mlock housekeeping.
>> The goal is to have the mlock accounting be tied to the exporters since they
>> are the ones that pin the pages/folios. As Sashiko identified, this patch doesn't
>> quite do that but once fixed, both alloc and free accounting would be attributed
>> to the exporter. Would this idea not work?
> Most likely not, no.
>
> First of all this is trivially circumvent-able, you just need to create a child process which allocates and exports the memory and then gives the fd back to the parent and dies.
>
> The result would be that you have accounted to the mlock limit of the child process (which is now dead) and then a dangling reference to the cred structure of a dead process. Both are most likely no-gos for this.
>
> Then the second problem is that you often have processes which allocates the memory on behalves of another process (display servers for example do that).
>
> The fundamental issue is that Linux doesn't have a way to track file descriptors as they move from process to process and so if your file descriptor represents more than just a standard file on a file system you run into tons of trouble with resource management.
>
> Regards,
> Christian.

I'd like to quickly chime in on what we IMHO would optimally want (from 
a userspace perspective). Some context:

1. Unprivileged users by default don't have access to /dev/udmabuf

2. Since https://github.com/systemd/systemd/pull/33738 systemd grants 
uaccess to graphical users - i.e. if I'm not mistaken only the users 
currently owning drm master should be able to use udmabuf (or something 
similar)

3. When owning drm master one can probably already DDoS the system in 
various ways - so probably not really worth to try to hard to defend 
against.

4. An exception here would be sandboxed apps - e.g. flatpaks. Such apps 
get udabuf access if they also have dri device access 
(https://github.com/flatpak/flatpak/pull/6158). Preventing these apps 
from pinning unlimited amounts of memory would be great - however I 
guess this would require mlock accounting on the level of cgroups. Is 
that realistic to have by any means?

Best regards,

Robert

>> Thanks,
>> Vivek
>>
>>> What could potentially work is to grab a reference to the cred structure
>>> of the allocating task, but that is also not the nicest thing to do.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>> Cc: "Christian König" <christian.koenig@amd.com>
>>>> Cc: Robert Mader <robert.mader@collabora.com>
>>>> Cc: Xaver Hugl <xaver.hugl@kde.org>
>>>> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
>>> default")
>>>> ---
>>>>   drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
>>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>>>> index 7c4339130eff..e78947f01656 100644
>>>> --- a/drivers/dma-buf/udmabuf.c
>>>> +++ b/drivers/dma-buf/udmabuf.c
>>>> @@ -203,9 +203,10 @@ static __always_inline int
>>> init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
>>>>   	return 0;
>>>>   }
>>>>
>>>> -static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
>>>> +static __always_inline void deinit_udmabuf(struct udmabuf *ubuf,
>>> pgoff_t pgcnt)
>>>>   {
>>>>   	unpin_all_folios(ubuf);
>>>> +	user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());
>>>>   	kvfree(ubuf->pages);
>>>>   }
>>>>
>>>> @@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf
>>> *buf)
>>>>   	if (ubuf->sg)
>>>>   		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
>>>>
>>>> -	deinit_udmabuf(ubuf);
>>>> +	deinit_udmabuf(ubuf, ubuf->pagecount);
>>>>   	kfree(ubuf);
>>>>   }
>>>>
>>>> @@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice
>>> *device,
>>>>   	if (!pgcnt)
>>>>   		goto err_noinit;
>>>>
>>>> +	if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {
>>>> +		pr_warn_once("%s: User not permitted to pin more than
>>> %lu KB "
>>>> +			     "of memory, either increase ulimits -l, or "
>>>> +			     "obtain CAP_IPC_LOCK capability\n", current-
>>>> comm,
>>>> +			     rlimit(RLIMIT_MEMLOCK) >> 10);
>>>> +		ret = -EPERM;
>>>> +		goto err_noinit;
>>>> +	}
>>>> +
>>>>   	ret = init_udmabuf(ubuf, pgcnt);
>>>>   	if (ret)
>>>>   		goto err;
>>>> @@ -441,7 +451,7 @@ static long udmabuf_create(struct miscdevice
>>> *device,
>>>>   	return ret;
>>>>
>>>>   err:
>>>> -	deinit_udmabuf(ubuf);
>>>> +	deinit_udmabuf(ubuf, pgcnt);
>>>>   err_noinit:
>>>>   	kfree(ubuf);
>>>>   	kvfree(folios);
