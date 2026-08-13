Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E065C5DF67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649C910E4DB;
	Thu, 13 Aug 2026 17:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="aB/ZsfPD";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7A5A810E4DB
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:06:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADDB1576
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:06:17 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 AB3823F632
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786640781; bh=GVYycV9xCyF19fTPesqjidnOQ1Ci/sfR8rc0+aTyDk8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aB/ZsfPDc/9++qKCPq2m4ED22wGJF5lSBb5TzmGzLMwslfiYdIKnuuoJFIihk4mJx
 6o8QzadInfTnOjBmJ+tON+Cg5gCDwWSQGN+s0L8BjsP6QXjdJQjo1V+oBCTSdfKTos
 tHbpfniWu0z99hwsnCx1I8a4G0eknypWPN9rvves=
Date: Thu, 13 Aug 2026 18:06:13 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH v3 00/17] drm/panthor: Fix the unplug logic
Message-ID: <an35hWg7K3pzIpm6@e142607>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813132320.1682f9bd@fedora-21.home> <an3eqSUT_FRkye-1@e142607>
 <20260813175522.0ae2f42d@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813175522.0ae2f42d@fedora-21.home>
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

On Thu, Aug 13, 2026 at 05:55:22PM +0200, Boris Brezillon wrote:
> On Thu, 13 Aug 2026 16:11:37 +0100
> Liviu Dudau <liviu.dudau@arm.com> wrote:
> 
> > On Thu, Aug 13, 2026 at 01:23:20PM +0200, Boris Brezillon wrote:
> > > +Danilo, since you worked on the 'bound lifetime stuff in rust, and I
> > > feel this is related to the problem I'm trying to fix here.
> > > 
> > > On Thu, 13 Aug 2026 12:56:58 +0200
> > > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > >   
> > > > The current unplug logic is broken in multiple ways. This is an attempt
> > > > at addressing the various problems found along the way (some were
> > > > reported by Sashiko, others have been found while trying to address
> > > > Sashiko's concerns).
> > > > 
> > > > Sending a new version even though v2 didn't receive any human review
> > > > just to try and address the new stuff pointed out by Sashiko.  
> > 
> > Sorry, I was on holiday at the beginning of the week, back today.
> > 
> > > 
> > > Just a note I forgot to add to my cover letter. I've already spent way
> > > more time than I wanted on this, not just because Sashiko keeps finding
> > > new issues at each of my attempt, but also because the whole idea of
> > > pretending a device on a platform bus is unplugged and can't harm us is
> > > doomed. This is not an hot-pluggable bus, and the device is still there,
> > > so, unless we can be absolutely sure it's inactive (which a RESET can
> > > provide, but RESETs are fallible) we just have two options:
> > > 
> > > 1. prevent the device from going away until we managed to properly
> > >    shutdown the GPU  
> > 
> > That's going to be event harder with the upcoming HW where the GPU
> > slice can be made inaccessible by an arbiter.
> > 
> > > 
> > > 2. make sure all resources the HW might have its hands on at the time
> > >    the failure of RESET in the unplug path happened are leaked  
> > 
> > There is another option which is to make sure that the HW can only
> > access the dummy pages. We're still in control of the MMU and the page
> > tables, once we update those and flush them we should be safe in the
> > knowledge that the HW cannot access live resources.
> 
> That's more for an "active device" situation though. Active as in,
> device is probed and ready to accept user requests, even if it might be
> temporarily inaccessible because of RESETs (or access-window loss
> on new gens).
> 
> The thing I'm trying to fix here is the unplug logic: device is going
> away, we just need to make sure it's either
> 
> - off
> 
> or
> 
> - the resources it had access to are leaked
> 
> or
> 
> - we prevent the removal until we're sure it's off (retry the SOFT_RESET
>   indefinitely?)
> 
> > 
> > 
> > > 
> > > Option 1 is no longer possible since platform_driver::remove() can't
> > > return an error. That leaves options 2, which is basically what this
> > > patchset is doing, but the whole idea of leaking resources when the
> > > final RESET in the unplug path fails has various nasty implications,
> > > like the fact we end up with dangling drm_device (drm_gpuvm retains a
> > > ref, and each GPU mapping we kept alive in the gpuvm is what keeps the
> > > gpuvm and the BOs alive). In practice, there should be no one
> > > triggering operations on this drm_device, because all the user-facing
> > > interfaces have been shutdown by drm_dev_unregister() (which is called
> > > by drm_dev_unplug()), but as things stand now, this drm_device still
> > > has access to module-specific vtables, and there's nothing retaining
> > > the module either.
> > > 
> > > TLDR; this is all super fragile stuff, on the other hand the current
> > > situation is probably even worse. so if anyone has any idea how to
> > > handle this properly (or at least a bit better than we do), please let
> > > me know. I know a lot of this stuff is currently being considered as
> > > part of the drm-rust abstractions, so hopefully we have a long-term
> > > solution for rust drivers, but I'd really like a short-term solution
> > > for panthor that doesn't involve nasty tricks or overly complex
> > > refactoring.  
> > 
> > I think some of the pain we're suffering comes from the overlap (that
> > you've tried to address in this series) between the resources that
> > are visible to the HW and the ones that are visible to user space. The
> > split of AS and VM is the right thing to do.
> 
> Yeah, that definitely makes things harder to disconnect when the device
> goes away. But even with this split, there's still the problem that the
> "unplug" we have is not HW based (unlike a PCI bus), so the HW still has
> access to the memory we shared with it (for its MMU page table, and the
> pages those point to).

There is no copy of the MMU page tables that the FW or the hardware own.
Panthor is in charge of the page tables and it can force change them if it
wants to be sure that HW doesn't access memory we don't want to. If it
does, HW will get a bus access violation and halt.

> 
> > 
> > My proposal for handling the unplugging would be to have race as quick
> > as possible to the MMU unplug and then free up all BOs and VMs that
> > were allocated at the request of user space, then go back and free
> > the kernel BOs. Then hopefully we should be in a position where there
> > are no GPU mappings and we can unplug the drm_gpuvm.
> 
> I mean, that's basically what this patchset is doing. To be accurate,
> what the unplug logic does at the end of this patchset is:
> 
> 1. RESET the GPU, so the HW is inactive => basically faking a real
>    unplug on an hot-pluggable bus
> 2. unplug each component, and make sure the unplug logic doesn't
>    interact with the HW. It just acts as a janitor releasing all the
>    objects that were left behind at the moment the unplug happens. The
>    only thing left are the user-facing objects (panthor_file) so that
>    DRM FDs can be closed after the unplug, but all other operations
>    IOCTLs fail with ENODEV. panthor_device also stays around a bit
>    longer, but it's mostly here to keep the drm_device around until the
>    last ref is dropped
> 3. if and only if the RESET failed in step 1, the MMU unplug logic leaks
>    the GPU mappings of the resident AS instead of releasing them. This
>    leak retains the gpuvm which retains the drm_device/panthor_device
> 
> Step 3 is only here to cover for failures in step 1 (in a normal
> situation, there's no leak and everything is released as expected),
> and that's the problematic part. I don't mind refactor the code to
> isolate objects containing HW resource from the user-facing objects,
> but that won't solve the fact that, on a RESET failure, we either leak
> memory, or we expose ourselves to HW UAFs. If you tell me HARD_RESET is
> not fallible and is safe, I can go for that. But last I looked, I've
> read that it could leave the memory bus in a bad state, with the risk of
> impacting the rest of the system.

My suggestion would be to do step 1, 3 and then 2. But on step 3 I would
not leak the GPU mappings, but replace them with the dummy pages and release
the resident AS.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
