Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7E4C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308E110E064;
	Thu, 13 Aug 2026 15:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="H1X5J3ew";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id C930010F398
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:11:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D6E51596
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:11:42 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 03B4B3F632
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786633906; bh=Gf3v4QVvqhyfUNN4zkCnWh9pAVv2yh+/YpnQue6QahM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H1X5J3ewl5QoYt/j8pW13C6jMlaTSlrJMiArLP0Mha/ODMNJXnkZDudB+uCDnu8hG
 wiRapqF6zYtxxNEEqwJ+Vy51bZ4tTXgVOkIYQ1Aqdxa6iftuAQhPSicwaMiu44vA+9
 +nJFSmKsdnuXanNu00W9iE3HFkkser6gl/LXV3EM=
Date: Thu, 13 Aug 2026 16:11:37 +0100
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
Message-ID: <an3eqSUT_FRkye-1@e142607>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813132320.1682f9bd@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813132320.1682f9bd@fedora-21.home>
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

On Thu, Aug 13, 2026 at 01:23:20PM +0200, Boris Brezillon wrote:
> +Danilo, since you worked on the 'bound lifetime stuff in rust, and I
> feel this is related to the problem I'm trying to fix here.
> 
> On Thu, 13 Aug 2026 12:56:58 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > The current unplug logic is broken in multiple ways. This is an attempt
> > at addressing the various problems found along the way (some were
> > reported by Sashiko, others have been found while trying to address
> > Sashiko's concerns).
> > 
> > Sending a new version even though v2 didn't receive any human review
> > just to try and address the new stuff pointed out by Sashiko.

Sorry, I was on holiday at the beginning of the week, back today.

> 
> Just a note I forgot to add to my cover letter. I've already spent way
> more time than I wanted on this, not just because Sashiko keeps finding
> new issues at each of my attempt, but also because the whole idea of
> pretending a device on a platform bus is unplugged and can't harm us is
> doomed. This is not an hot-pluggable bus, and the device is still there,
> so, unless we can be absolutely sure it's inactive (which a RESET can
> provide, but RESETs are fallible) we just have two options:
> 
> 1. prevent the device from going away until we managed to properly
>    shutdown the GPU

That's going to be event harder with the upcoming HW where the GPU
slice can be made inaccessible by an arbiter.

> 
> 2. make sure all resources the HW might have its hands on at the time
>    the failure of RESET in the unplug path happened are leaked

There is another option which is to make sure that the HW can only
access the dummy pages. We're still in control of the MMU and the page
tables, once we update those and flush them we should be safe in the
knowledge that the HW cannot access live resources.


> 
> Option 1 is no longer possible since platform_driver::remove() can't
> return an error. That leaves options 2, which is basically what this
> patchset is doing, but the whole idea of leaking resources when the
> final RESET in the unplug path fails has various nasty implications,
> like the fact we end up with dangling drm_device (drm_gpuvm retains a
> ref, and each GPU mapping we kept alive in the gpuvm is what keeps the
> gpuvm and the BOs alive). In practice, there should be no one
> triggering operations on this drm_device, because all the user-facing
> interfaces have been shutdown by drm_dev_unregister() (which is called
> by drm_dev_unplug()), but as things stand now, this drm_device still
> has access to module-specific vtables, and there's nothing retaining
> the module either.
> 
> TLDR; this is all super fragile stuff, on the other hand the current
> situation is probably even worse. so if anyone has any idea how to
> handle this properly (or at least a bit better than we do), please let
> me know. I know a lot of this stuff is currently being considered as
> part of the drm-rust abstractions, so hopefully we have a long-term
> solution for rust drivers, but I'd really like a short-term solution
> for panthor that doesn't involve nasty tricks or overly complex
> refactoring.

I think some of the pain we're suffering comes from the overlap (that
you've tried to address in this series) between the resources that
are visible to the HW and the ones that are visible to user space. The
split of AS and VM is the right thing to do.

My proposal for handling the unplugging would be to have race as quick
as possible to the MMU unplug and then free up all BOs and VMs that
were allocated at the request of user space, then go back and free
the kernel BOs. Then hopefully we should be in a position where there
are no GPU mappings and we can unplug the drm_gpuvm.

Best regards,
Liviu

> 
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> > Changes in v3:
> > - Fix a race in the reset reschedule logic we added to
> >   panthor_device_resume() (missing smp_mb__after_atomic())
> > - Fix a VM leak when reset and suspend are racing with each other
> > - Add missing drm_dev_enter/exit() sections
> > - Insert the groups in the user_owned list even if the group creation
> >   happens during a reset
> > - Try to document why some of the issues pointed out by Sashiko are
> >   either not real issues, or are expected (either fixed in a later
> >   commits, or just expected behavior)
> > - Fix a race between panthor_device_unplug() and vm_prep_for_cleanup()
> >   (introduced in v2)
> > - Link to v2: https://patch.msgid.link/20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com
> > 
> > Changes in v2:
> > - Fix UAFs caused by deferred cleanup works
> > - Fix UAFs caused by open FDs closed after unplug
> > - Fix deadlock when device_unplug() is called from the reset work
> > - Make sure reset requests are not lost in the resume and post_reset
> >   paths
> > - Fix a deadlock in the suspend path
> > - Fix a clk prepare_enable leak in the unplug path
> > - Don't use a drmm_action to flush the cleanup queue (this could cause
> >   UAFs)
> > - Drop the now unused panthor_vm::unusable field
> > - Keep track of user owned resources to prevent leaks and/or UAFs
> > - Link to v1: https://patch.msgid.link/20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com
> > 
> > ---
> > Boris Brezillon (17):
> >       drm/panthor: Disable reset work before unplug
> >       drm/panthor: Further delay reset work enablement
> >       drm/panthor: Make sure reset requests in the resume path are not lost
> >       drm/panthor: Make sure reset requests in the post reset path are not lost
> >       drm/panthor: Flush the cleanup_wq in the unplug path
> >       drm/panthor: Drop unused vm argument passed to panthor_vm_prepare_sync_only_op_ctx()
> >       drm/panthor: Move the debugfs initialization to panthor_device.c
> >       drm/panthor: Split panthor_vm
> >       drm/panthor: Add fine-grained restrictions on VMs
> >       drm/panthor: Check AS state before disabling
> >       drm/panthor: Don't pre-allocate VMAs or page tables when preparing a full VM unmap
> >       drm/panthor: Make the VM cleanup path more robust against UAF
> >       drm/panthor: Track user owned VMs
> >       drm/panthor: Track user owned groups
> >       drm/panthor: Fix the unplug logic
> >       drm/panthor: Add a debugfs knob to simulate unplug failures
> >       drm/panthor: Add a debugfs knobs to simulate reset failures
> > 
> >  drivers/gpu/drm/panthor/panthor_device.c |  189 +++-
> >  drivers/gpu/drm/panthor/panthor_device.h |   38 +
> >  drivers/gpu/drm/panthor/panthor_drv.c    |  132 ++-
> >  drivers/gpu/drm/panthor/panthor_fw.c     |    9 +-
> >  drivers/gpu/drm/panthor/panthor_mmu.c    | 1493 ++++++++++++++++++------------
> >  drivers/gpu/drm/panthor/panthor_mmu.h    |    4 +-
> >  drivers/gpu/drm/panthor/panthor_sched.c  |  132 ++-
> >  7 files changed, 1344 insertions(+), 653 deletions(-)
> > ---
> > base-commit: 44e9eb5a762142a4aa46c0b5da7c39bfeb78910e
> > change-id: 20260804-panthor-unplug-fixes-7927b3ddc2f9
> > 
> > Best regards,
> > --  
> > Boris Brezillon <boris.brezillon@collabora.com>
> > 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
