Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B7E1090240
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29AE510E8CA;
	Thu, 19 Mar 2026 15:17:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6C6B210E8CA
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 15:17:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEEEB1BD0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:17:33 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9554A3F778
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:17:39 -0700 (PDT)
Date: Thu, 19 Mar 2026 15:17:36 +0000
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
Message-ID: <abwTkBi5WvItsEX-@e142607>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260319110053.909152-1-marcin.slusarz@arm.com>
 <abvhcedS46eLEYVB@e142607> <abvujKZxtg0zvFaz@e129842.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abvujKZxtg0zvFaz@e129842.arm.com>
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

On Thu, Mar 19, 2026 at 01:39:40PM +0100, Marcin Ślusarz wrote:
> On Thu, Mar 19, 2026 at 11:43:45AM +0000, Liviu Dudau wrote:
> > Hi Marcin,
> > 
> > On Thu, Mar 19, 2026 at 12:00:53PM +0100, Marcin Slusarz wrote:
> > > ...
> > > +#define VALID_TIMESTAMP_QUERY_FLAGS \
> > > +		(DRM_PANTHOR_TIMESTAMP_GPU | \
> > > +		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
> > > +		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
> > > +		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
> > > +		 DRM_PANTHOR_TIMESTAMP_FREQ | \
> > > +		 DRM_PANTHOR_TIMESTAMP_DURATION)
> > > +
> > >  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> > >  					struct drm_panthor_timestamp_info *arg)
> > >  {
> > >  	int ret;
> > > +	u32 flags;
> > > +	unsigned long irq_flags;
> > > +	struct timespec64 cpu_ts;
> > > +	u64 query_start_time;
> > > +	bool minimize_interruption;
> > > +	u32 timestamp_types = 0;
> > > +
> > > +	if (arg->flags != 0) {
> > > +		flags = arg->flags;
> > > +	} else {
> > > +		/*
> > > +		 * If flags are 0, then ask for the same things that we asked
> > > +		 * for before flags were added.
> > > +		 */
> > > +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> > > +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > > +			DRM_PANTHOR_TIMESTAMP_FREQ;
> > > +	}
> > > +
> > > +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > > +	case 0:
> 
> Umm, this should be DRM_PANTHOR_TIMESTAMP_CPU_NONE.
> 
> > > +		break;
> > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > > +		timestamp_types++;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
> > > +		return -EINVAL;
> > 
> > Can we move this check before the switch and simplify the switch itself to only do the timestamp_types increment?
> 
> DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is bit field that holds individual
> clock type values, so we still need to validate the bit field.

The if () test eliminates the default case, and if you change the switch to:

	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_NONE) {
	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
		timestamp_types++;
		break;
	}

then it should be equivalent, right?

> 
> > > +
> > > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> > > +		timestamp_types++;
> > > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> > > +		timestamp_types++;
> > > +
> > > +	/* If user asked to obtain timestamps from more than one source,
> > > +	 * then it very likely means they want them to be as close as possible.
> > > +	 * If they asked for duration, then that likely means that they
> > > +	 * want to know how long obtaining timestamp takes, without random
> > > +	 * events, like process scheduling or interrupts.
> > > +	 */
> > 
> > This comment makes me think that user can ask for both CPU_MONOTONIC and
> > CPU_MONOTONIC_RAW timestamps, but the code is built to make them exclusive.
> > Can we document better what sources can be requested simultaneously?
> 
> Somethine like this?
> 
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 8a46ef040c3d..0e455d91e77d 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -466,6 +466,11 @@ struct drm_panthor_timestamp_info {
>          *  DRM_PANTHOR_TIMESTAMP_GPU |
>          *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
>          *  DRM_PANTHOR_TIMESTAMP_FREQ
> +        *
> +        * Note: these flags are exclusive to each other (only one can be used):
> +        * - DRM_PANTHOR_TIMESTAMP_CPU_NONE
> +        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC
> +        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW

Yes, looks good to me.

Best regards,
Liviu

>          */
>         __u32 flags;
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
