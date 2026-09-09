Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CBFC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCE710F089;
	Wed,  9 Sep 2026 10:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="jSC3TOzJ";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A80010F089
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 10:21:26 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so79517125e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1788949285; x=1789554085; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QW7FwcI5CLpgkHE+mMHfthdjtYGSrqpt8xAnoW9r4Hs=;
 b=jSC3TOzJQuN54w8c2WUEq1s4Vo1J35q168f0eEL6WaVxCDyQxKxyO5w549mbBDZftM
 GGNDQyXlRjMD4pfFCa1XDoz6m47joOE9vk+wQ9Eujd9C7ZEdp/O0m1ZO8P72cbLgBFcY
 B2XFB6PxzwOSswL3GJzYKrtGp+VL0ZIZV/IOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788949285; x=1789554085;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QW7FwcI5CLpgkHE+mMHfthdjtYGSrqpt8xAnoW9r4Hs=;
 b=b1DmHdb54EcZpHvtQkIVyHw3w9FRwqYRmgmMZsPRkopkiCQvJsoNW8iapLoA8XUlNT
 8TxfuZivxMQMFdUmsJl/yqfKVCCyYKbYfaBONRSj2Fn/RMqhsOFNbjGyDI8Or66T5q9w
 GLE6kJ1Yowvxa27xiNq0FKaPW9LmpwsHMwPc25XgkfBy1ToBA+A3xydjZHb8jYszTdVq
 xLT02RTC6jrm6jhpzx6xQ9Zb59de9hjNBrpntqDrf3/Lr3qmgMHA1UAPorltuIwTohM9
 Ghvrn2VRuiN15ahOPO/iRuGNPCHG/p9dmLgDN0V6JvXFNotZszQ5+tRBPrngi3ZT7HPg
 HIYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5FNRsqcJgm5XdcDu2Ho4GbNlLKd654+QZBPXZKTf9OjYyLczlnSUmK1JHvxMyu7K3rNFh1hWMwIA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nM220XIC8A2JglpHgZG6Vaz7NAulhLAYn/+QR3s9HBcaBpU8n4
 4hZf7ptDhjqaFsPX5ktoNZrhich/uKWU3+oGk684pP37HX3/wVMJgQeInkoyOQFP/8A=
X-Gm-Gg: AYBFou3LM47YhItljMbmByLBLTv5hWmt9Nrj9MYP1yVSjV0TAQzLjVxGeSxYPYMH3lt
 yD6oPBetPTuM49zb7sl1x2qDMv64QPAp3q+rt0lhvapBJgxrz/A9n7jWQxGUM4UfBd0JQr3WcGx
 PilMy/XOI+9tNj1g0TTvQ6PKyd627lvVDsgVG0QwBUQJGcvI4ZTALah17uZrPOFIKJMywCd36dS
 tgMizbAWAwmJu5L/YuY8aCWE/Ftp5cFrSnrnjdSHNelc3NWcsGpcSwf1YSReiNpM42ZbqnL1LwA
 Sr8Cg6QCApuU0qF2q+YynU/3+m73svY3dA6sWjk4RoXDQXAx9VhUHVMUOUHO/fDpWH5vc0dGuAP
 8VKWgW/FDrCPd/7QNE/5W7eWN6SawcRVRp/vHDAOztCx/JoT/EWmoiTIRdzTbm9SFOUsjNbeww/
 qpJj6Lkg+83mbc7nMHuNkPvm/Vc9V9qaRoqrFdLChokXBIokzL9SgRGsm7mARLCWYeBcDqABG7g
 JqbO9jRZtY=
X-Received: by 2002:a05:600c:3e06:b0:49d:99:1d98 with SMTP id
 5b1f17b1804b1-49d00991db1mr277639155e9.9.1788949280007; 
 Wed, 09 Sep 2026 03:21:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7740d44sm1008046105e9.15.2026.09.09.03.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 03:21:19 -0700 (PDT)
Date: Wed, 9 Sep 2026 12:21:17 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>,
 Joanne Koong <joannelkoong@gmail.com>,
 Amir Goldstein <amir73il@gmail.com>, intel-xe@lists.freedesktop.org,
 fuse-devel@lists.linux.dev, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: Re: FUSE deadlocks vs. copy_from_user() and locks (Was: Re: [PATCH
 v10 04/27] drm/xe/eudebug: Introduce discovery for resources)
Message-ID: <aqEzHQMrI8p9XVcu@phenom.ffwll.local>
References: <20260903145952.848051-1-mika.kuoppala@linux.intel.com>
 <20260903145952.848051-5-mika.kuoppala@linux.intel.com>
 <20260903152224.AD48C1F00A3F@smtp.kernel.org>
 <178878748003.179185.16833574173741290547@jlahtine-mobl>
 <178894801687.37859.4186888279082797860@jlahtine-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178894801687.37859.4186888279082797860@jlahtine-mobl>
X-Operating-System: Linux phenom 7.1.3+deb14-amd64 
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

On Wed, Sep 09, 2026 at 01:00:16PM +0300, Joonas Lahtinen wrote:
> (Adding bunch of FUSE folks and DRM folks in the hopes of coming to a
> resolution here.)
> 
> Quoting Joonas Lahtinen (2026-09-07 16:24:40)
> > Quoting sashiko-bot@kernel.org (2026-09-03 18:22:23)
> > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > - [High] Global ordered workqueue stall via copy_from_user block while holding ioctl_lock.
> > > - [Medium] Event sequence numbers (seqno) can be queued out-of-order in the event stream due to a race between seqno generation and event queuing.
> > > --
> > > 
> > > commit e2061e72d8e954a17bde35e9c970ee41bc2db0ad
> > > Author: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> > > 
> > >     drm/xe/eudebug: Introduce discovery for resources
> > > 
> > > This commit introduces a resource discovery mechanism for debugger connections.
> > > When a debugger connects, all existing resources for the target client are
> > > relayed as events via an ordered workqueue, and DRM ioctls are blocked using
> > > an rw_semaphore until discovery is complete.
> > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> > > > index 032a7ec5fbc8d..f10959b898297 100644
> > > > --- a/drivers/gpu/drm/xe/xe_device.c
> > > > +++ b/drivers/gpu/drm/xe/xe_device.c
> > > [ ... ]
> > > > @@ -238,8 +239,12 @@ static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > >  
> > > >       ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
> > > >       ret = ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
> > > > -     if (ret >= 0)
> > > > +     if (ret >= 0) {
> > > > +             bool lock = xe_eudebug_discovery_lock(file, cmd);
> > > >               ret = drm_ioctl(file, cmd, arg);
> > > 
> > > [Severity: High]
> > > Does holding the discovery lock across drm_ioctl() create a vector for a
> > > workqueue stall? 
> > > 
> > > If an unprivileged user maps the ioctl argument pointer to a blocking FUSE
> > > or userfaultfd region, drm_ioctl() can be stalled indefinitely during
> > > copy_from_user() while holding xef->eudebug.ioctl_lock for read.
> > 
> > Don't think this is a very realistic vector to address, as it would
> > also extend to every other copy_from_user() and also to userptr across
> > all drivers.
> > 
> > Having a malfunctioning FUSE driver and getting a malfunctioning system
> > as a result is probably somewhat expected.
> 
> Based on further chatting on this with Sima, I was volunteered to pull
> together the discussion here.
> 
> We seem to have Sashiko picking up on patterns about accessing userspace
> memory with locks held and potential for copy_from_user() (or userptr) to
> then take indefinitely long to resolve. And that spreads to deadlocks
> everywhere situation very fast.
> 
> Based on reading of [1] and [2], it seems pretty much expected FUSE
> drivers can trivially deadlock and ultimately in worst case the situation
> can only be solved by manually aborting those connections by sysadmin.
> 
> It also seems (from the Sashiko comments) that by design, there's no
> upper bound for how long an operation can take, so a bad FUSE driver
> may stall for however long it sees fit to serve page-fault or in the
> case of [3] it may decide to not actually populate the PTEs (or maybe
> invalidate them immediately).
> 
> Should we really be refactoring the whole kernel for the sake of
> knowingly allowing potentially malicious userspace driver to idefinitely
> stall or incorrectly resolve page faults? That'll be quite a lot of
> complexity added to all the other drivers.
> 
> Or should there be more protections on FUSE / uffd to ensure such
> idefinitive stall can't happen? Or maybe this is just an academic
> problem and we amend review-prompts not to bring it up?
> 
> Or maybe I missed some part of the FUSE docs and this isn't a real
> problem?

Thanks for typing this up, matches what I think is going on here.

> Regards, Joonas
> 
> PS. There is a related patch in [3] which tries to address the problem,
> but we'll quickly run into live-locks and other issues even if we
> refactored things into: pre-fault, take locks, do _nofault() access, and
> retry if that fails.

Yeah just quickly wanting to add here that in my opinion, trying to sort
this out in all the various subsystem is not how we should even start to
think about this issue. This would be a fundamental change in how
subsystems are allowed to nest locking with stuff that can trigger
userspace faults.

I did ponder a bit how this could be solved on the fuse side of things,
maybe with some seccomp style filters. Like maybe lockdep could be
enlisted to help catch deadlocks, with a special "this is a fuse process,
it all defacto runs in fault handler context. But that only catches bugs
in normal use, not malicious exploits. And given that userspace can choose
the timing and unblock at will (I think so at least), this is pretty
powerful tool for being nasty to the kernel.

But mostly I want to really, really stand back in awe about this issue and
not think too hard about it.

Cheers, Sima

> [1] https://www.kernel.org/doc/html/next/filesystems/fuse.html#kernel-userspace-interface
> [2] https://www.kernel.org/doc/html/next/filesystems/fuse.html#aborting-a-filesystem-connection
> [3] https://sashiko.dev/#/patchset/20260827062142.4038272-1-srinivasan.shanmugam%40amd.com

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
