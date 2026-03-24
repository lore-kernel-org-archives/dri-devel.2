Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1D0E9A75A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1333310E145;
	Tue, 24 Mar 2026 10:42:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3E66210E145
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:42:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAA401476
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:42:02 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 7A6BC3FDF5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:42:08 -0700 (PDT)
Date: Tue, 24 Mar 2026 10:41:56 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH v3] drm/panthor: extend timestamp query with flags
Message-ID: <acJqdFEo4l4oi--V@e142607>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260319110053.909152-1-marcin.slusarz@arm.com>
 <abvhcedS46eLEYVB@e142607> <abvujKZxtg0zvFaz@e129842.arm.com>
 <abwTkBi5WvItsEX-@e142607> <abwXXFgPheyA03P8@e129842.arm.com>
 <acE9LkMYQvrGKb8b@e142607> <acFmUc-qx0eO8A1F@e129842.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acFmUc-qx0eO8A1F@e129842.arm.com>
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

On Mon, Mar 23, 2026 at 05:12:01PM +0100, Marcin Ślusarz wrote:
> On Mon, Mar 23, 2026 at 01:16:30PM +0000, Liviu Dudau wrote:
> > On Thu, Mar 19, 2026 at 04:33:48PM +0100, Marcin Ślusarz wrote:
> > > On Thu, Mar 19, 2026 at 03:17:36PM +0000, Liviu Dudau wrote:
> > > > On Thu, Mar 19, 2026 at 01:39:40PM +0100, Marcin Ślusarz wrote:
> > > > > On Thu, Mar 19, 2026 at 11:43:45AM +0000, Liviu Dudau wrote:
> > > > > > Hi Marcin,
> > > > > > 
> > > > > > On Thu, Mar 19, 2026 at 12:00:53PM +0100, Marcin Slusarz wrote:
> > > > > > > ...
> > > > > > > +#define VALID_TIMESTAMP_QUERY_FLAGS \
> > > > > > > +		(DRM_PANTHOR_TIMESTAMP_GPU | \
> > > > > > > +		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
> > > > > > > +		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
> > > > > > > +		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
> > > > > > > +		 DRM_PANTHOR_TIMESTAMP_FREQ | \
> > > > > > > +		 DRM_PANTHOR_TIMESTAMP_DURATION)
> > > > > > > +
> > > > > > >  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> > > > > > >  					struct drm_panthor_timestamp_info *arg)
> > > > > > >  {
> > > > > > >  	int ret;
> > > > > > > +	u32 flags;
> > > > > > > +	unsigned long irq_flags;
> > > > > > > +	struct timespec64 cpu_ts;
> > > > > > > +	u64 query_start_time;
> > > > > > > +	bool minimize_interruption;
> > > > > > > +	u32 timestamp_types = 0;
> > > > > > > +
> > > > > > > +	if (arg->flags != 0) {
> > > > > > > +		flags = arg->flags;
> > > > > > > +	} else {
> > > > > > > +		/*
> > > > > > > +		 * If flags are 0, then ask for the same things that we asked
> > > > > > > +		 * for before flags were added.
> > > > > > > +		 */
> > > > > > > +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> > > > > > > +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > > > > > > +			DRM_PANTHOR_TIMESTAMP_FREQ;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > > > > > > +	case 0:
> > > > > 
> > > > > Umm, this should be DRM_PANTHOR_TIMESTAMP_CPU_NONE.
> > 
> > OK, are you going to re-spin?
> 
> Yes, as soon as we get to some conclusion.
> 
> > > > > 
> > > > > > > +		break;
> > > > > > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > > > > > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > > > > > > +		timestamp_types++;
> > > > > > > +		break;
> > > > > > > +	default:
> > > > > > > +		return -EINVAL;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
> > > > > > > +		return -EINVAL;
> > > > > > 
> > > > > > Can we move this check before the switch and simplify the switch itself to only do the timestamp_types increment?
> > > > > 
> > > > > DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is bit field that holds individual
> > > > > clock type values, so we still need to validate the bit field.
> > > > 
> > > > The if () test eliminates the default case, and if you change the switch to:
> > > > 
> > > > 	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_NONE) {
> > > > 	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > > > 	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > > > 		timestamp_types++;
> > > > 		break;
> > > > 	}
> > > > 
> > > > then it should be equivalent, right?
> > > 
> > > We need the default case to detect garbage values in the part of flags
> > > that ands with DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK.
> > > 
> > > DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is 7 << 1,
> > 
> > I understand that you want to make sure that user space doesn't insert values into the
> > flags and then pretends that because we didn't return an error that's now part of the
> > ABI. But then maybe you should not reserve the extra bit now if you don't know how
> > it's going to be used (in other words, why not make TIMESTAMP_CPU_TYPE_MASK  3 << 1?).
> 
> I think it makes sense to reserve this bit now to make it easier to
> extend the interface if we ever will need to. Changing uapi definition
> is painful enough, so reserving this will rule out misuses of the current
> value. Another point is that we would have to validate that the bit is 0
> anyway, so I don't see why we can't include that bit in the field that
> is supposed to go with.

You do validate the bits in the if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS) test if the
QUERY_FLAGS bitfield is updated.

> 
> > > DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC is 1 << 1,
> > > DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW is 2 << 1,
> > > so 3 << 1, 4 << 1, 5 << 1, 6 << 1, 7 << 1 are all invalid values that need
> > > to be rejected.
> > 
> > I am confused about why TIMESTAMP_CPU is a continous range [0-7] while the rest of the
> > flags are bits in a bitmask. A note should be added to the panthor_drm.h file to
> > explain this.
> 
> Well, just look at the definition of struct drm_panthor_timestamp_info -
> there's one to one relation between field and a DRM_PANTHOR_TIMESTAMP_* flag,
> with an exception that CPU timestamp types have only one field (well,
> a pair of "seconds" and "nanoseconds", but from logical perspective it's
> only one value). There's no known reason why anyone would want to query
> multiple CPU timestamps together with various GPU counters from _GPU_ query.

OK, so what I'm hearing is: we're reserving space for up to 6 CPU clock sources (zero is
no CPU clock) but you can have only one active at any time (because we can't think of any
reason why you would want more at the same time) and we currently only define two sources
because that's what user space cares about.

If you agree with this then this will be recorded in the thread and we can go back in the
future and reference it.

> 
> > 
> > > 
> > > And since DRM_PANTHOR_TIMESTAMP_CPU_NONE is 0 << 1, we need it too in
> > > the switch to not be caught by the default case.
> > 
> > It only makes sense if you explain that TIMESTAMP_CPU values are in a range. I kept reading
> > the different versions of the patch thinking that they are bits in a bitmask, with
> > TIMESTAMP_CPU_NONE being the logical state of not selecting any of the sources.
> 
> That should be resolved with the documentation update below, right?

The documentation doesn't say anything about the intent for future values for CPU sources, but
if you don't want to add more in the documentation at least we have this thread as reference.

I don't want to turn this into a bikeshedding thread, so please do a v4 with the switch case updated
and the documentation addition and I will ACK that.

Best regards,
Liviu

> 
> > 
> > Best regards,
> > Liviu
> > 
> > 
> > > 
> > > > > 
> > > > > > > +
> > > > > > > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> > > > > > > +		timestamp_types++;
> > > > > > > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> > > > > > > +		timestamp_types++;
> > > > > > > +
> > > > > > > +	/* If user asked to obtain timestamps from more than one source,
> > > > > > > +	 * then it very likely means they want them to be as close as possible.
> > > > > > > +	 * If they asked for duration, then that likely means that they
> > > > > > > +	 * want to know how long obtaining timestamp takes, without random
> > > > > > > +	 * events, like process scheduling or interrupts.
> > > > > > > +	 */
> > > > > > 
> > > > > > This comment makes me think that user can ask for both CPU_MONOTONIC and
> > > > > > CPU_MONOTONIC_RAW timestamps, but the code is built to make them exclusive.
> > > > > > Can we document better what sources can be requested simultaneously?
> > > > > 
> > > > > Somethine like this?
> > > > > 
> > > > > diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> > > > > index 8a46ef040c3d..0e455d91e77d 100644
> > > > > --- a/include/uapi/drm/panthor_drm.h
> > > > > +++ b/include/uapi/drm/panthor_drm.h
> > > > > @@ -466,6 +466,11 @@ struct drm_panthor_timestamp_info {
> > > > >          *  DRM_PANTHOR_TIMESTAMP_GPU |
> > > > >          *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > > > >          *  DRM_PANTHOR_TIMESTAMP_FREQ
> > > > > +        *
> > > > > +        * Note: these flags are exclusive to each other (only one can be used):
> > > > > +        * - DRM_PANTHOR_TIMESTAMP_CPU_NONE
> > > > > +        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC
> > > > > +        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW
> > > > 
> > > > Yes, looks good to me.
> > > > 
> > > > Best regards,
> > > > Liviu
> > > > 
> > > > >          */
> > > > >         __u32 flags;
> > > > >  

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
