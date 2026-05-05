Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCE0FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E083D10EB6A;
	Tue,  5 May 2026 16:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="U8Jng4gb";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1727210EB6A
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 16:12:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B8016F8
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:12:33 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 955B33F763
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777997558; bh=R1p7WWSkYbHrTBSZBaGz56YYLGocTFCxI8H7XbW3PBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U8Jng4gbzaiwe1PZfug8gqk27cOkVbEDGljpBzl2vWNCuT7P7BZSaouEVLQhRwOLJ
 gUvApcQvFGL5yKTmVw1XWDqXbNRfUe13We9/nmsJ+L20tnVpDE43RMG2z9Di8/SXfa
 V7G5Gbq9pvLgRZGRzuUkzqk0ln77p5r0JGITMelA=
Date: Tue, 5 May 2026 17:12:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] drm/panthor: Reduce dma_fence signalling latency
Message-ID: <afoW7X2xsjq_R6AZ@e142607>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429123607.7a8c7051@fedora> <20260505105453.23144e92@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505105453.23144e92@fedora>
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

On Tue, May 05, 2026 at 10:54:53AM +0200, Boris Brezillon wrote:
> On Wed, 29 Apr 2026 12:36:07 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > On Wed, 29 Apr 2026 11:38:27 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > 
> > > Right now, panthor is one of the rare drivers to signal fences
> > > from work items (not even from the threaded IRQ handler). We
> > > could move that to the threaded handler, but that would still
> > > leave the latency caused by the scheduling of the IRQ thread.
> > > 
> > > Instead, this patchset moves all the job IRQ processing to
> > > the raw IRQ handler, which is fine because what the current
> > > code does is demux the interrupts and deferring actual handling
> > > to sub work items. The only bits we keep in the IRQ path is
> > > the dma_fence signalling, which should be acceptable, in term
> > > of CPU cycles spent in the IRQ context.
> > > 
> > > Pretty much all the patches except the last two are just
> > > preparing the ground to get there. The second to last one
> > > does the thread -> IRQ transition, and the last one is some
> > > experimental interrupt coalescing support that I've added
> > > because I noticed moving job IRQ handling to the raw handler
> > > generates quite a lot of interrupts in some case, and having
> > > the system constantly interrupted like that can be
> > > detrimental.
> > >   
> > 
> > Forgot to post some preliminary numbers I collected during my,
> > admittedly, very basic testing :-). What this shows is that IRQ
> > coalescing provides small but noticeable improvements only in some
> > of the glmark scenes (terrain, refract),
> 
> I think I found the problem on the "refract" regression. Turns out if I
> set cpufreq governor to performance instead of schedutil, I get those
> ~20% back, which is not surprising given schedutil uses scheduling stats
> to decide to bump/lower the frequency, and the extra IRQ_WAKE_THREAD
> indirection does add regular thread activity.

Nice find! I've completely ignore that the choice of scheduler could play a
part in the latency of handling raw IRQs if it ends up lowering the CPU freq.

> 
> So, this basically leaves terrain where interrupt coalescing helps a
> bit, but it's not clear that the improvement justifies the added
> complexity or the extra CPU load incurred by the polling done in the
> threaded handler.
> 
> If everyone is fine with that, I'd be tempted to drop patch 10 for now,
> and revisit it if/when we have an actual use case where it's deemed
> essential to limit IRQs coming from the GPU.

Yes, I agree with the idea of dropping the coalescing patch for now. Doing
more in the raw handler and deferring only slow work to the threaded handler
makes sense, so we should keep that.

Best regards,
Liviu

> 
> Regards,
> 
> Boris
> 
> > the rest of the variations
> > stay in the noise of what we see between regular glmark runs. BTW,
> > those relatively small improvements (~5%) aren't even reflected in the
> > final score, because many tests have high FPS scores, and any variation
> > on those might actually have more impact on the final score (which is
> > just a average FPS IIUC) than any improvement on the lower-FPS scenes.
> > 
> > It's also worth noting that the refract scenes seems to suffer from
> > this threaded -> raw-IRQ transition, and that coalescing gets us back
> > to where we were.
> > 
> > TLDR; As always, there's no simple answer to this 'latency vs throughput'
> > issue, and it's not surprising one approach helps some cases and
> > regresses others.
> > 
> > ---------- Before this series ---------------
> > 
> > =======================================================
> >     glmark2 2023.01
> > =======================================================
> >     OpenGL Information
> >     GL_VENDOR:      Mesa
> >     GL_RENDERER:    Mali-G610 MC4 (Panfrost)
> >     GL_VERSION:     OpenGL ES 3.1 Mesa 26.2.0-devel (git-c71664cfbc)
> >     Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
> >     Surface Size:   800x600 windowed
> > =======================================================
> > [build] use-vbo=false: FPS: 2708 FrameTime: 0.369 ms
> > [build] use-vbo=true: FPS: 4209 FrameTime: 0.238 ms
> > [texture] texture-filter=nearest: FPS: 5211 FrameTime: 0.192 ms
> > [texture] texture-filter=linear: FPS: 5224 FrameTime: 0.191 ms
> > [texture] texture-filter=mipmap: FPS: 5255 FrameTime: 0.190 ms
> > [shading] shading=gouraud: FPS: 3395 FrameTime: 0.295 ms
> > [shading] shading=blinn-phong-inf: FPS: 3329 FrameTime: 0.300 ms
> > [shading] shading=phong: FPS: 2990 FrameTime: 0.335 ms
> > [shading] shading=cel: FPS: 2916 FrameTime: 0.343 ms
> > [bump] bump-render=high-poly: FPS: 1879 FrameTime: 0.532 ms
> > [bump] bump-render=normals: FPS: 5242 FrameTime: 0.191 ms
> > [bump] bump-render=height: FPS: 4997 FrameTime: 0.200 ms
> > [effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 3725 FrameTime: 0.268 ms
> > [effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 1906 FrameTime: 0.525 ms
> > [pulsar] light=false:quads=5:texture=false: FPS: 4863 FrameTime: 0.206 ms
> > [desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 706 FrameTime: 1.417 ms
> > [desktop] effect=shadow:windows=4: FPS: 2621 FrameTime: 0.382 ms
> > [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 411 FrameTime: 2.435 ms
> > [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 402 FrameTime: 2.489 ms
> > [buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 490 FrameTime: 2.043 ms
> > [ideas] speed=duration: FPS: 1008 FrameTime: 0.992 ms
> > [jellyfish] <default>: FPS: 2722 FrameTime: 0.367 ms
> > [terrain] <default>: FPS: 120 FrameTime: 8.339 ms
> > [shadow] <default>: FPS: 2086 FrameTime: 0.479 ms
> > [refract] <default>: FPS: 312 FrameTime: 3.209 ms
> > [conditionals] fragment-steps=0:vertex-steps=0: FPS: 4877 FrameTime: 0.205 ms
> > [conditionals] fragment-steps=5:vertex-steps=0: FPS: 4118 FrameTime: 0.243 ms
> > [conditionals] fragment-steps=0:vertex-steps=5: FPS: 4845 FrameTime: 0.206 ms
> > [function] fragment-complexity=low:fragment-steps=5: FPS: 4444 FrameTime: 0.225 ms
> > [function] fragment-complexity=medium:fragment-steps=5: FPS: 3722 FrameTime: 0.269 ms
> > [loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 4468 FrameTime: 0.224 ms
> > [loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 4442 FrameTime: 0.225 ms
> > [loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 3847 FrameTime: 0.260 ms
> > =======================================================
> >                                   glmark2 Score: 3135 
> > =======================================================
> > 
> > ---------- After transitioning to job event processing in the IRQ context ------------
> > 
> > =======================================================
> >     glmark2 2023.01
> > =======================================================
> >     OpenGL Information
> >     GL_VENDOR:      Mesa
> >     GL_RENDERER:    Mali-G610 MC4 (Panfrost)
> >     GL_VERSION:     OpenGL ES 3.1 Mesa 26.2.0-devel (git-c71664cfbc)
> >     Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
> >     Surface Size:   800x600 windowed
> > =======================================================
> > [build] use-vbo=false: FPS: 2703 FrameTime: 0.370 ms
> > [build] use-vbo=true: FPS: 4630 FrameTime: 0.216 ms
> > [texture] texture-filter=nearest: FPS: 5406 FrameTime: 0.185 ms
> > [texture] texture-filter=linear: FPS: 5429 FrameTime: 0.184 ms
> > [texture] texture-filter=mipmap: FPS: 5408 FrameTime: 0.185 ms
> > [shading] shading=gouraud: FPS: 3678 FrameTime: 0.272 ms
> > [shading] shading=blinn-phong-inf: FPS: 3587 FrameTime: 0.279 ms
> > [shading] shading=phong: FPS: 3221 FrameTime: 0.311 ms
> > [shading] shading=cel: FPS: 3119 FrameTime: 0.321 ms
> > [bump] bump-render=high-poly: FPS: 1977 FrameTime: 0.506 ms
> > [bump] bump-render=normals: FPS: 5488 FrameTime: 0.182 ms
> > [bump] bump-render=height: FPS: 5323 FrameTime: 0.188 ms
> > [effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 4003 FrameTime: 0.250 ms
> > [effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 2008 FrameTime: 0.498 ms
> > [pulsar] light=false:quads=5:texture=false: FPS: 4961 FrameTime: 0.202 ms
> > [desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 852 FrameTime: 1.174 ms
> > [desktop] effect=shadow:windows=4: FPS: 2649 FrameTime: 0.378 ms
> > [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 412 FrameTime: 2.429 ms
> > [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 392 FrameTime: 2.554 ms
> > [buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 482 FrameTime: 2.075 ms
> > [ideas] speed=duration: FPS: 1021 FrameTime: 0.980 ms
> > [jellyfish] <default>: FPS: 2939 FrameTime: 0.340 ms
> > [terrain] <default>: FPS: 126 FrameTime: 7.979 ms
> > [shadow] <default>: FPS: 2273 FrameTime: 0.440 ms
> > [refract] <default>: FPS: 251 FrameTime: 3.999 ms
> > [conditionals] fragment-steps=0:vertex-steps=0: FPS: 5148 FrameTime: 0.194 ms
> > [conditionals] fragment-steps=5:vertex-steps=0: FPS: 4555 FrameTime: 0.220 ms
> > [conditionals] fragment-steps=0:vertex-steps=5: FPS: 5245 FrameTime: 0.191 ms
> > [function] fragment-complexity=low:fragment-steps=5: FPS: 4880 FrameTime: 0.205 ms
> > [function] fragment-complexity=medium:fragment-steps=5: FPS: 4042 FrameTime: 0.247 ms
> > [loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 4846 FrameTime: 0.206 ms
> > [loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 4854 FrameTime: 0.206 ms
> > [loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 4207 FrameTime: 0.238 ms
> > =======================================================
> >                                   glmark2 Score: 3335 
> > =======================================================
> > 
> > ---- With IRQ coalescing enabled (max_us=100 poll_period_us=5 inbounds_cnt_threshold=5) ---
> > 
> > =======================================================
> >     glmark2 2023.01
> > =======================================================
> >     OpenGL Information
> >     GL_VENDOR:      Mesa
> >     GL_RENDERER:    Mali-G610 MC4 (Panfrost)
> >     GL_VERSION:     OpenGL ES 3.1 Mesa 26.2.0-devel (git-c71664cfbc)
> >     Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
> >     Surface Size:   800x600 windowed
> > =======================================================
> > [build] use-vbo=false: FPS: 2663 FrameTime: 0.376 ms
> > [build] use-vbo=true: FPS: 4640 FrameTime: 0.216 ms
> > [texture] texture-filter=nearest: FPS: 5335 FrameTime: 0.187 ms
> > [texture] texture-filter=linear: FPS: 5442 FrameTime: 0.184 ms
> > [texture] texture-filter=mipmap: FPS: 5434 FrameTime: 0.184 ms
> > [shading] shading=gouraud: FPS: 3683 FrameTime: 0.272 ms
> > [shading] shading=blinn-phong-inf: FPS: 3580 FrameTime: 0.279 ms
> > [shading] shading=phong: FPS: 3211 FrameTime: 0.312 ms
> > [shading] shading=cel: FPS: 3093 FrameTime: 0.323 ms
> > [bump] bump-render=high-poly: FPS: 1969 FrameTime: 0.508 ms
> > [bump] bump-render=normals: FPS: 5368 FrameTime: 0.186 ms
> > [bump] bump-render=height: FPS: 5273 FrameTime: 0.190 ms
> > [effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 4038 FrameTime: 0.248 ms
> > [effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 2001 FrameTime: 0.500 ms
> > [pulsar] light=false:quads=5:texture=false: FPS: 4961 FrameTime: 0.202 ms
> > [desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 842 FrameTime: 1.188 ms
> > [desktop] effect=shadow:windows=4: FPS: 2681 FrameTime: 0.373 ms
> > [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 412 FrameTime: 2.430 ms
> > [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 408 FrameTime: 2.452 ms
> > [buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 483 FrameTime: 2.072 ms
> > [ideas] speed=duration: FPS: 1005 FrameTime: 0.995 ms
> > [jellyfish] <default>: FPS: 2945 FrameTime: 0.340 ms
> > [terrain] <default>: FPS: 131 FrameTime: 7.663 ms
> > [shadow] <default>: FPS: 2276 FrameTime: 0.440 ms
> > [refract] <default>: FPS: 328 FrameTime: 3.050 ms
> > [conditionals] fragment-steps=0:vertex-steps=0: FPS: 5099 FrameTime: 0.196 ms
> > [conditionals] fragment-steps=5:vertex-steps=0: FPS: 4538 FrameTime: 0.220 ms
> > [conditionals] fragment-steps=0:vertex-steps=5: FPS: 5152 FrameTime: 0.194 ms
> > [function] fragment-complexity=low:fragment-steps=5: FPS: 4818 FrameTime: 0.208 ms
> > [function] fragment-complexity=medium:fragment-steps=5: FPS: 4035 FrameTime: 0.248 ms
> > [loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 4855 FrameTime: 0.206 ms
> > [loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 4812 FrameTime: 0.208 ms
> > [loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 4150 FrameTime: 0.241 ms
> > =======================================================
> >                                   glmark2 Score: 3322 
> > =======================================================
> > 
> > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > > Boris Brezillon (10):
> > >       drm/panthor: Make panthor_irq::state a non-atomic field
> > >       drm/panthor: Move the register accessors before the IRQ helpers
> > >       drm/panthor: Replace the panthor_irq macro machinery by inline helpers
> > >       drm/panthor: Extend the IRQ logic to allow fast/raw IRQ handlers
> > >       drm/panthor: Make panthor_fw_{update,toggle}_reqs() callable from IRQ context
> > >       drm/panthor: Prepare the scheduler logic for FW events in IRQ context
> > >       drm/panthor: Automate CSG IRQ processing at group unbind time
> > >       drm/panthor: Automatically enable interrupts in panthor_fw_wait_acks()
> > >       drm/panthor: Process FW events in IRQ context
> > >       drm/panthor: Introduce interrupt coalescing support for job IRQs
> > > 
> > >  drivers/gpu/drm/panthor/panthor_device.h | 358 ++++++++++++++---------
> > >  drivers/gpu/drm/panthor/panthor_drv.c    |   1 +
> > >  drivers/gpu/drm/panthor/panthor_fw.c     | 226 +++++++++++++--
> > >  drivers/gpu/drm/panthor/panthor_fw.h     |  11 +-
> > >  drivers/gpu/drm/panthor/panthor_gpu.c    |  27 +-
> > >  drivers/gpu/drm/panthor/panthor_mmu.c    |  38 +--
> > >  drivers/gpu/drm/panthor/panthor_pwr.c    |  21 +-
> > >  drivers/gpu/drm/panthor/panthor_sched.c  | 475 ++++++++++++++-----------------
> > >  8 files changed, 698 insertions(+), 459 deletions(-)
> > > ---
> > > base-commit: 7455a0583a906533041a80e48c6a2e3230cce96e
> > > change-id: 20260429-panthor-signal-from-irq-d33684f4d292
> > > prerequisite-message-id: <20260427155934.416502-1-karunika.choo@arm.com>
> > > prerequisite-patch-id: 70905a2eb09ab2b31d242a5ed5af3b42fb6a464c
> > > prerequisite-patch-id: aa4c22669f80328039762f25c0b3942bbadbdc89
> > > prerequisite-patch-id: 7f61bcee3c4bb5703900b18d5b6e0f52e622f29d
> > > prerequisite-patch-id: 3402f4d60aa526d40113fc3d9b3e599f8f89e705
> > > prerequisite-patch-id: 00ddbd3d455891f6950609614c1acd2baa78b0db
> > > prerequisite-patch-id: 6a9928f609e3757cadebb2df6795d0da55745f4e
> > > prerequisite-patch-id: fd91f68f25d4bc93eec405f0131f5ae4284bfaf2
> > > prerequisite-patch-id: 553958a10a0ca2f20f7883ad4c752cfc7485c5a8
> > > 
> > > Best regards,  
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
