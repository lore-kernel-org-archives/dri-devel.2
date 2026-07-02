Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24282C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7831010F436;
	Thu,  2 Jul 2026 15:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Dkh9RWL9";
	dkim-atps=neutral
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com
 [95.215.58.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B903810F43E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:09:14 +0000 (UTC)
Message-ID: <cf5a92d3-2c7e-41e6-afed-f2a4c9d1a774@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783004941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GVgi/IDW6MB0ICHH5yTujujreeH5t5fHN661xjkq/74=;
 b=Dkh9RWL9rMIQE6Ur1L+lFP9fWBIPUF1EBlETBXiV1FwoU/+0F4n7u3+DtwQotZKTkFazHu
 oHVZr/Vs+FAfYKVbUxY57cWOfPctKhbPm5r74IEfkBs57Xoqgu/OIspBSvCnXq9uEYouaN
 h+ygMrTbcJpYGV90L9aTDp+5SWenOgM=
Date: Thu, 2 Jul 2026 23:08:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 02/13] mm/vma: update do_mmap() to use vma_flags_t
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, tsbogend@alpha.franken.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 l.stach@pengutronix.de, inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, krzk@kernel.org, peter.griffin@linaro.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, lyude@redhat.com, dakr@kernel.org,
 tomi.valkeinen@ideasonboard.com, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com, thierry.reding@kernel.org, mperttunen@nvidia.com,
 jonathanh@nvidia.com, kraxel@redhat.com, dmitry.osipenko@collabora.com,
 zack.rusin@broadcom.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, oleksandr_andrushchenko@epam.com,
 deller@gmx.de, bcrl@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 muchun.song@linux.dev, osalvador@suse.de, david@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, liam@infradead.org, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, hughd@google.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 jannh@google.com, pfalcato@suse.de, kees@kernel.org, perex@perex.cz,
 tiwai@suse.com, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org,
 linux-fbdev@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-sound@vger.kernel.org
References: <e0ac58ad2b88ff7e2f0024e3286b2e786f79ca32.1782760670.git.ljs@kernel.org>
 <20260702111531.64883-1-lance.yang@linux.dev> <akZwsS-_cywsXSjL@lucifer>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <akZwsS-_cywsXSjL@lucifer>
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



On 2026/7/2 22:16, Lorenzo Stoakes wrote:
> On Thu, Jul 02, 2026 at 07:15:31PM +0800, Lance Yang wrote:
[...]
>>
>> [...]
>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>> index 46174e706bbe..547352183214 100644
>>> --- a/mm/mmap.c
>>> +++ b/mm/mmap.c
>> [...]
>>> @@ -488,23 +496,27 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>>> 		 * Check to see if we are violating any seals and update VMA
>>> 		 * flags if necessary to avoid future seal violations.
>>> 		 */
>>> -		err = memfd_check_seals_mmap(file, &vm_flags);
>>> +		err = memfd_check_seals_mmap(file, &vma_flags);
>>> 		if (err)
>>> 			return (unsigned long)err;
>>> 	} else {
>>> 		switch (flags & MAP_TYPE) {
>>> 		case MAP_SHARED:
>>> -			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
>>> +			if (vma_flags_can_grow(&vma_flags))
>>> 				return -EINVAL;
>>> 			/*
>>> 			 * Ignore pgoff.
>>> 			 */
>>> 			pgoff = 0;
>>> -			vm_flags |= VM_SHARED | VM_MAYSHARE;
>>> +			vma_flags_set(&vma_flags, VMA_SHARED_BIT, VMA_MAYSHARE_BIT);
>>> 			break;
>>> -		case MAP_DROPPABLE:
>>> -			if (VM_DROPPABLE == VM_NONE)
>>> +		case MAP_DROPPABLE: {
>>> +			vma_flags_t droppable = VMA_DROPPABLE;
>>> +
>>> +			if (vma_flags_empty(&droppable))
>>> 				return -EOPNOTSUPP;
>>> +			vma_flags_set_mask(&vma_flags, droppable);
>>> +
>>> 			/*
>>> 			 * A locked or stack area makes no sense to be droppable.
>>> 			 *
>>> @@ -515,23 +527,24 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>>> 			 */
>>> 			if (flags & (MAP_LOCKED | MAP_HUGETLB))
>>> 			        return -EINVAL;
>>> -			if (vm_flags & (VM_GROWSDOWN | VM_GROWSUP))
>>> +			if (vma_flags_can_grow(&vma_flags))
>>> 			        return -EINVAL;
>>>
>>> -			vm_flags |= VM_DROPPABLE;
>>
>> Old code checked VM_GROWSDOWN|VM_GROWSUP before seting VM_DROPPABLE. New
>> code flips that around. Hmm, shouldn't master, just made me look twice ;)
>>
>> Maybe keep old order?
> 
> I guess I feared that defining droppable above then referencing it below would
> be less clear?
> 
> Can move if you feel strongly about it, and sorry for making the move at the
> same time as the general vm_flags_t -> vma_flags_t refactor as it does make that
> less clear...

No need to churn just for me. Thanks :)
