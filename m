Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79421C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A572310F395;
	Tue, 15 Sep 2026 10:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="m7HB4ItW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB6110F395;
 Tue, 15 Sep 2026 10:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=pUaNdE/ksclSo83DfteFLMPN1opeeAZY4wWnZgrFVTY=; b=m7HB4ItWLBzRfKQN//n5ufcrsY
 4+h8RdKbOqH7GB6vAtbk+yUHIAMOXgw/KbDyVCSlc/9pzfsP0mBajUw/V4lQVwY61Iye4IgdB/z9B
 TvcHQJtAdWWnTz/QPhQSJQLVKrCIHp/1T6Xt1Ksv3ywCDPUc6/+Xb9e8kID5mb0CDPr29RKAy986e
 ZYyQZdiD1BQbiqCKCYA7mT7iwYsHtD6sw1aM4k5FtL/kH910C6hQaM7MLYDJ513HgYs8AOE3oy3hr
 JjeWVtSE8/l8GoYV2fTUmu99WHdIJpCGTyt9W6hI31aq/JmTOctSS+dU4vCtwwzIIC0/4Nhg4JBII
 2ZQR4F7g==;
Received: from 179-125-70-185-dinamico.pombonet.net.br ([179.125.70.185]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6QXH-002NlV-GJ; Tue, 15 Sep 2026 12:37:11 +0200
Date: Tue, 15 Sep 2026 07:37:04 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Natalie Vock <nat@pixelcluster.dev>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: Re: [PATCH 3/4] drm/amdgpu: don't free mapping when
 amdgpu_vm_update_range fails
Message-ID: <aqkf0LE51mObdEJc@quatroqueijos.cascardo.eti.br>
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
 <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
 <9c507259-f65c-4f18-8fc7-8e03de0c4f87@amd.com>
 <acc1e3eb-264c-4591-9f66-5fe93b96f97f@pixelcluster.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acc1e3eb-264c-4591-9f66-5fe93b96f97f@pixelcluster.dev>
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

On Tue, Sep 15, 2026 at 10:53:43AM +0200, Natalie Vock wrote:
> On 9/15/26 10:33, Christian König wrote:
> > On 9/14/26 22:25, Thadeu Lima de Souza Cascardo wrote:
> > > If amdgpu_vm_update_range fails when called by amdgpu_vm_clear_freed,
> > > the clearing of that mapping will not be attempted again. Later on, when
> > > an IB tries to read that mapping, the read succeeds, leading to a
> > > potential info leak, or even data corruption, if it attempts to write to
> > > it.
> > > 
> > > If the mapping is left in the freed list, then clearing will be
> > > attempted again during amdgpu_cs_ioctl, which will either fail and not
> > > submit the job or will succeed in clearing the mapping, preventing the
> > > invalid access.
> > 
> > Same as I replied to oushinnyo <oushinnyo@163.com>, absolutely clear NAK to that.
> > 
> > amdgpu_vm_update_range() can only fail when the device is hot removed and we don't care about clearing page tables in that case.
> 
> Actually, how so? The SDMA update path has lots of allocations that happen
> at random points throughout the update process (think the SDMA IB being
> exhausted, then vm_funcs->update() will allocate a new one and can fail on
> that, or various fence allocations. Some paths allocate from the delayed IB
> pool which is just regular GFP_KERNEL, why couldn't these allocations fail?
> 
> Aside from that, the more trivial failure path that I think Thadeu is also
> talking about here is that amdgpu_vm_ptes_update will call
> amdgpu_vm_pt_alloc (so that happens in the middle of VM updates) and these
> allocations can fail. I'm not even sure if drm_exec can save this one
> because we need to be ready to drop locks and retry.
> 
> I get that failing is unacceptable for the cases inside a pagefault handler
> (though I'm not sure if anything of what I mentioned applies here, pagefault
> VM updates are immediate so they get GFP_ATOMIC, but maybe the pagefault
> handler could still allocate PTs?) but for anything else, failure seems like
> a possibility and maybe we should think about handling it in some way.
> 
> I'm not sure I see a problem in keeping BOs invalidated and backing off
> later, since new submissions should be rejected unless the VM manages to
> complete all updates successfully.
> 
> Best,
> Natalie
> 

Thanks, Natalie, those are exactly the possible scenarios here:
amdgpu_job_alloc and amdgpu_vm_pt_alloc might fail.

Christian,

I have started this investigation once I observed the kmemleak that is
fixed by the other 3 patches. Natalie brings up the exact case where this
might happen: amdgpu_vm_pt_alloc fails as all other VRAM BOs are locked as
they are either ALWAYS_VALID BOs or PT BOs, thus sharing the same dma_resv.

Here is a log showing up that something failed during the update:
[ 3839.556311] [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-12)

The investigation then led to a reproducer, which is able to trigger the
list corruption that is mentioned in patch 4.

And given the kmemleak stack trace shows amdgpu_vm_clear_freed in the stack
trace, that should clearly be where the failure has happened. Looking at
the function, then I noticed it ignores the return code and still removes
the mappings from the list. I was able to write a second reproducer that
triggers the failure, then releases some memory and demonstrate that
amdgpu_cs_ioctl does not clear the freed page tables as the freed list is
empty.

Regards.
Cascardo.

> > 
> > Regards,
> > Christian.
> > 
> > > 
> > > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > index 09037df76400..5bde36754607 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> > >   	while (!list_empty(&vm->freed)) {
> > >   		mapping = list_first_entry(&vm->freed,
> > >   			struct amdgpu_bo_va_mapping, list);
> > > -		list_del(&mapping->list);
> > >   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
> > >   					   &sync, mapping->start, mapping->last,
> > >   					   0, 0, 0, NULL, NULL, &f);
> > > -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
> > >   		if (r) {
> > >   			dma_fence_put(f);
> > >   			goto error_free;
> > >   		}
> > > +		list_del(&mapping->list);
> > > +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
> > >   	}
> > >   	if (fence && f) {
> > > 
> > 
> 
