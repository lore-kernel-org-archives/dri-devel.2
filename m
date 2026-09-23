Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6272C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135B610F063;
	Wed, 23 Sep 2026 13:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LH+Hketp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8865610F059;
 Wed, 23 Sep 2026 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=RX0nC5/G1nHYgo/O/I+UWwIt/9sGvg7gtikYgWUDZew=; b=LH+HketpB88l1j4WjP5BQJeI+y
 YW9BdZMYbkD2kxdiOmMM11FGOobgu+H22MK8Q3GKzdxmjdje1yNOrdv3i61dE/bHXn1GjsePbd8mS
 NoiYK5tftL9bpvcjbM1sZtJCFtHP9nuFEHxhxbs0CtSnfL7Mku6n1XfoeR92ebrv6mv5vK1u5e5Vf
 6erCBySYxcbrsKeS6RgbkheZSj1HjVOUOy2H8X1nbWEfe7RzM1o7QwmY9N8FMaeGXdTyLDros8/cc
 Gb57/MTZBw32OzUZxJtJZPb6SXhAqI62o68Hjp+3AFOPVetYipqPAdK8ctVTr84rXGZiDPx2kARsH
 4dmwQOHw==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9NSg-006AXI-0h; Wed, 23 Sep 2026 15:56:38 +0200
Date: Wed, 23 Sep 2026 10:56:32 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Natalie Vock <nat@pixelcluster.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: Re: [PATCH 3/4] drm/amdgpu: don't free mapping when
 amdgpu_vm_update_range fails
Message-ID: <arPakAXXW1TdfF0Z@quatroqueijos.cascardo.eti.br>
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
 <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
 <9c507259-f65c-4f18-8fc7-8e03de0c4f87@amd.com>
 <acc1e3eb-264c-4591-9f66-5fe93b96f97f@pixelcluster.dev>
 <aqkf0LE51mObdEJc@quatroqueijos.cascardo.eti.br>
 <fb733813-9e4d-494a-ba60-469261340e74@amd.com>
 <aqktL4Ui1MaIvs_j@quatroqueijos.cascardo.eti.br>
 <a59d3421-a241-4497-9890-0b94329b94da@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a59d3421-a241-4497-9890-0b94329b94da@amd.com>
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

On Tue, Sep 15, 2026 at 03:56:00PM +0200, Christian König wrote:
> On 9/15/26 13:34, Thadeu Lima de Souza Cascardo wrote:
> > On Tue, Sep 15, 2026 at 01:22:48PM +0200, Christian König wrote:
> >> On 9/15/26 12:37, Thadeu Lima de Souza Cascardo wrote:
> >>> On Tue, Sep 15, 2026 at 10:53:43AM +0200, Natalie Vock wrote:
> >>>> On 9/15/26 10:33, Christian König wrote:
> >>>>> On 9/14/26 22:25, Thadeu Lima de Souza Cascardo wrote:
> >>>>>> If amdgpu_vm_update_range fails when called by amdgpu_vm_clear_freed,
> >>>>>> the clearing of that mapping will not be attempted again. Later on, when
> >>>>>> an IB tries to read that mapping, the read succeeds, leading to a
> >>>>>> potential info leak, or even data corruption, if it attempts to write to
> >>>>>> it.
> >>>>>>
> >>>>>> If the mapping is left in the freed list, then clearing will be
> >>>>>> attempted again during amdgpu_cs_ioctl, which will either fail and not
> >>>>>> submit the job or will succeed in clearing the mapping, preventing the
> >>>>>> invalid access.
> >>>>>
> >>>>> Same as I replied to oushinnyo <oushinnyo@163.com>, absolutely clear NAK to that.
> >>>>>
> >>>>> amdgpu_vm_update_range() can only fail when the device is hot removed and we don't care about clearing page tables in that case.
> >>>>
> >>>> Actually, how so? The SDMA update path has lots of allocations that happen
> >>>> at random points throughout the update process (think the SDMA IB being
> >>>> exhausted, then vm_funcs->update() will allocate a new one and can fail on
> >>>> that, or various fence allocations. Some paths allocate from the delayed IB
> >>>> pool which is just regular GFP_KERNEL, why couldn't these allocations fail?
> >>>>
> >>>> Aside from that, the more trivial failure path that I think Thadeu is also
> >>>> talking about here is that amdgpu_vm_ptes_update will call
> >>>> amdgpu_vm_pt_alloc (so that happens in the middle of VM updates) and these
> >>>> allocations can fail. I'm not even sure if drm_exec can save this one
> >>>> because we need to be ready to drop locks and retry.
> >>>>
> >>>> I get that failing is unacceptable for the cases inside a pagefault handler
> >>>> (though I'm not sure if anything of what I mentioned applies here, pagefault
> >>>> VM updates are immediate so they get GFP_ATOMIC, but maybe the pagefault
> >>>> handler could still allocate PTs?) but for anything else, failure seems like
> >>>> a possibility and maybe we should think about handling it in some way.
> >>>>
> >>>> I'm not sure I see a problem in keeping BOs invalidated and backing off
> >>>> later, since new submissions should be rejected unless the VM manages to
> >>>> complete all updates successfully.
> >>>>
> >>>> Best,
> >>>> Natalie
> >>>>
> >>>
> >>> Thanks, Natalie, those are exactly the possible scenarios here:
> >>> amdgpu_job_alloc and amdgpu_vm_pt_alloc might fail.
> >>>
> >>> Christian,
> >>>
> >>> I have started this investigation once I observed the kmemleak that is
> >>> fixed by the other 3 patches. Natalie brings up the exact case where this
> >>> might happen: amdgpu_vm_pt_alloc fails as all other VRAM BOs are locked as
> >>> they are either ALWAYS_VALID BOs or PT BOs, thus sharing the same dma_resv.
> >>
> >> Yeah and on a clear there is never a single page table allocated. What could be is that temporary memory allocations fail, but we need to make sure that never happens by using the emergency reserves and/or pools.
> >>> Here is a log showing up that something failed during the update:
> >>> [ 3839.556311] [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-12)
> >>
> >> That is failed memory allocation while trying to map something which we also ignore and delegate to the next CS.
> >>
> > 
> > Yep, that is a possibility as well and amdgpu_vm_bo_update is not ignoring
> > the failure here and leaves the mappings in the invalids list, which the
> > next CS will try to map.
> > 
> >>>
> >>> The investigation then led to a reproducer, which is able to trigger the
> >>> list corruption that is mentioned in patch 4.
> >>>
> >>> And given the kmemleak stack trace shows amdgpu_vm_clear_freed in the stack
> >>> trace, that should clearly be where the failure has happened. Looking at
> >>> the function, then I noticed it ignores the return code and still removes
> >>> the mappings from the list. I was able to write a second reproducer that
> >>> triggers the failure, then releases some memory and demonstrate that
> >>> amdgpu_cs_ioctl does not clear the freed page tables as the freed list is
> >>> empty.
> >>
> >> Unmap/clear operations are also used in MMU notifiers who can't give an error back to higher levels but rather need to unmap the area no matter what.
> >>
> >> So basically that is an operation which can never fail in the first place (except for device is completely gone and then we don't care any more).
> >>
> >> I'm about to split the map/unmap into separate functions to make it clear that unmap operations can't fail.
> >>
> >> When you have a reproducer and can pinpoint where exactly the memory allocation fails that would be rather helpful here.
> >>
> > 
> > What I understand that happens in the case of clear_freed is that we are
> > breaking a PDB/hugepage and descending, as the clear happened in the middle
> > of the hugepage. With the specific reproducer I had to go through lengths
> > of making sure that the original mapping landed on a hugepage-aligned
> > address, then used CLEAR/amdgpu_vm_clear_mappings to unmap a single page in
> > the middle of it.
> 
> Yeah that is exactly the broken case I'm already working on.
> 
> In that case the clear should just unmap the whole hugepage and not allocate new PDs.
> 

Agreed that we should also do this. Because my patchset does not prevent
the issue and if there is no relief on memory pressure, the failure will
end up in amdgpu_cs_ioctl, resulting in a submission failure.

In any case, given that other causes could still result in the similar
symptoms (memory leak, list corruption), would you consider applying this
patchset?

> Re-mapping the two fragments before and after the unmapped area is supposed to allocate the new PDs.
> 
> Without that we run into tons of problems with userptrs and MMU notifiers.
> 
> I will CC you on the patches I have so far.
> 

Please, do. I will be happy to test it and review it.

Thanks.
Cascardo.

> Regards,
> Christian.
> 
> > 
> > The other reproducer that I have required that I used REPLACE instead of
> > MAP in order to trigger the tlb_flush_waitlist issue. REPLACE does call
> > amdgpu_vm_clear_mappings too. Notice that RADV Mesa driver uses REPLACE,
> > instead of MAP, so that explains that we can see this in production.
> > 
> > Regards.
> > Cascardo.
> > 
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Regards.
> >>> Cascardo.
> >>>
> >>>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>>>>
> >>>>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> >>>>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> >>>>>> ---
> >>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
> >>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>>>> index 09037df76400..5bde36754607 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>>>> @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> >>>>>>   	while (!list_empty(&vm->freed)) {
> >>>>>>   		mapping = list_first_entry(&vm->freed,
> >>>>>>   			struct amdgpu_bo_va_mapping, list);
> >>>>>> -		list_del(&mapping->list);
> >>>>>>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
> >>>>>>   					   &sync, mapping->start, mapping->last,
> >>>>>>   					   0, 0, 0, NULL, NULL, &f);
> >>>>>> -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
> >>>>>>   		if (r) {
> >>>>>>   			dma_fence_put(f);
> >>>>>>   			goto error_free;
> >>>>>>   		}
> >>>>>> +		list_del(&mapping->list);
> >>>>>> +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
> >>>>>>   	}
> >>>>>>   	if (fence && f) {
> >>>>>>
> >>>>>
> >>>>
> >>
> 
